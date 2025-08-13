import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/config/toastMessage.dart';
import 'package:earned_it/services/auth/login_service.dart';
import 'package:earned_it/services/setting_service.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// 로딩 상태 Provider
final profileImageLoadingProvider = StateProvider<bool>((ref) => false);

// 로직 Provider
final profileImageViewModelProvider = Provider.autoDispose((ref) {
  return ProfileImageViewModel(ref);
});

class ProfileImageViewModel {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final Ref _ref;
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();

  ProfileImageViewModel(this._ref);

  Future<void> pickAndEditImage(BuildContext context) async {
    try {
      // 갤러리에서 이미지 선택
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 1080,
        maxHeight: 1920,
      );

      if (pickedFile == null || !context.mounted) return;

      // 이미지 자르기 UI 실행
      final croppedFile = await _cropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 4),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: '이미지 편집',
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: '이미지 편집',
            aspectRatioLockEnabled: true,
            doneButtonTitle: '완료',
            cancelButtonTitle: '취소',
          ),
        ],
      );

      if (croppedFile == null || !context.mounted) return;

      const maxSizeInBytes = 5 * 1024 * 1024;
      final imageFile = File(croppedFile.path);
      final imageSize = await imageFile.length();

      if (imageSize > maxSizeInBytes) {
        toastMessage(
          context,
          '이미지는 최대 5MB 이하로 가능합니다.',
          type: ToastmessageType.errorType,
        );
        return;
      }

      await _uploadEditedImage(context, croppedFile);
    } catch (e) {
      debugPrint('Image processing error: $e');
      if (context.mounted) {
        toastMessage(
          context,
          '이미지 처리 중 오류가 발생했습니다.',
          type: ToastmessageType.errorType,
        );
      }
    }
  }

  /// 편집된 이미지를 서버에 업로드합니다.
  Future<void> _uploadEditedImage(
    BuildContext context,
    CroppedFile croppedImage,
  ) async {
    _ref.read(profileImageLoadingProvider.notifier).state = true;
    try {
      // 1. AccessToken 가져오기
      final accessToken = await _storage.read(key: 'accessToken');
      if (accessToken == null) {
        throw Exception("로그인이 필요합니다.");
      }

      final imageFile = File(croppedImage.path);

      // 2. SettingService를 통해 API 호출
      final response = await _ref
          .read(settingServiceProvider)
          .setProfileImage(accessToken: accessToken, imageFile: imageFile);

      await _ref.read(userProvider.notifier).loadProfile();

      if (context.mounted) {
        toastMessage(context, '프로필 이미지가 변경되었습니다.');
        context.pop();
      }
    } on DioException catch (e) {
      _ref.read(profileImageLoadingProvider.notifier).state = false;

      if (e.response?.data['code'] == "AUTH_REQUIRED") {
        print("토큰이 만료되어 재발급합니다.");
        final String? refreshToken = await _storage.read(key: 'refreshToken');
        try {
          await _ref.read(loginServiceProvider).checkToken(refreshToken!);
          toastMessage(
            context,
            '잠시 후, 다시 시도해주세요.',
            type: ToastmessageType.errorType,
          );
        } catch (e) {
          context.go('/login');
          toastMessage(
            context,
            '다시 로그인해주세요.',
            type: ToastmessageType.errorType,
          );
        }
      }
    } catch (e) {
      print('프로필 이미지 설정 중 에러 발생: $e');
      _ref.read(profileImageLoadingProvider.notifier).state = false;
      toastMessage(
        context,
        e.toDisplayString(),
        type: ToastmessageType.errorType,
      );
    } finally {
      if (_ref.exists(profileImageLoadingProvider)) {
        _ref.read(profileImageLoadingProvider.notifier).state = false;
      }
    }
  }

  /// 편집된 이미지를 서버에 업로드합니다.
  Future<void> deleteProfileImage(BuildContext context) async {
    _ref.read(profileImageLoadingProvider.notifier).state = true;
    try {
      // 1. AccessToken 가져오기
      final accessToken = await _storage.read(key: 'accessToken');
      if (accessToken == null) {
        throw Exception("로그인이 필요합니다.");
      }

      await _ref.read(settingServiceProvider).deleteProfileImage(accessToken);

      _ref.read(userProvider.notifier).updateUserProfileImage(null);

      if (context.mounted) {
        toastMessage(context, '프로필 이미지가 삭제되었습니다.');
        context.pop();
      }
    } on DioException catch (e) {
      _ref.read(profileImageLoadingProvider.notifier).state = false;

      if (e.response?.data['code'] == "AUTH_REQUIRED") {
        print("토큰이 만료되어 재발급합니다.");
        final String? refreshToken = await _storage.read(key: 'refreshToken');
        try {
          await _ref.read(loginServiceProvider).checkToken(refreshToken!);
          toastMessage(
            context,
            '잠시 후, 다시 시도해주세요.',
            type: ToastmessageType.errorType,
          );
        } catch (e) {
          context.go('/login');
          toastMessage(
            context,
            '다시 로그인해주세요.',
            type: ToastmessageType.errorType,
          );
        }
      }
    } catch (e) {
      print('프로필 이미지 삭제 중 에러 발생: $e');
      _ref.read(profileImageLoadingProvider.notifier).state = false;
      toastMessage(
        context,
        e.toDisplayString(),
        type: ToastmessageType.errorType,
      );
    } finally {
      if (_ref.exists(profileImageLoadingProvider)) {
        _ref.read(profileImageLoadingProvider.notifier).state = false;
      }
    }
  }
}
