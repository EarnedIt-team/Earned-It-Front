import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

// 로딩 상태 Provider
final profileImageLoadingProvider = StateProvider<bool>((ref) => false);

// 로직 Provider
final profileImageViewModelProvider = Provider.autoDispose((ref) {
  return ProfileImageViewModel(ref);
});

class ProfileImageViewModel {
  final Ref _ref;
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();

  ProfileImageViewModel(this._ref);

  /// 1. 갤러리에서 이미지 선택 -> 2. 이미지 자르기 -> 3. 서버에 업로드
  Future<void> pickAndEditImage(BuildContext context) async {
    // 👇 1. (핵심 수정) 함수 시작 시 BottomSheet를 닫는 코드를 제거합니다.
    // if (context.mounted) Navigator.of(context).pop(); // 이 줄 제거!

    try {
      // 갤러리에서 이미지 선택
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
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
            title: '프로필 이미지 변경',
            aspectRatioLockEnabled: true,
            doneButtonTitle: '완료',
            cancelButtonTitle: '취소',
          ),
        ],
      );

      if (croppedFile == null || !context.mounted) return;

      // 잘린 이미지를 바이트로 변환하여 업로드
      final imageBytes = await croppedFile.readAsBytes();

      const maxSizeInBytes = 5 * 1024 * 1024;
      if (imageBytes.lengthInBytes > maxSizeInBytes) {
        toastification.show(
          context: context,
          type: ToastificationType.error,
          title: const Text('이미지 크기는 5MB를 초과할 수 없습니다.'),
        );
        return;
      }

      await _uploadEditedImage(context, imageBytes);
    } catch (e) {
      debugPrint('Image processing error: $e');
      if (context.mounted) {
        toastification.show(
          context: context,
          type: ToastificationType.error,
          title: const Text('이미지 처리 중 오류가 발생했습니다.'),
        );
      }
    }
  }

  /// 편집된 이미지를 서버에 업로드합니다.
  Future<void> _uploadEditedImage(
    BuildContext context,
    Uint8List imageBytes,
  ) async {
    _ref.read(profileImageLoadingProvider.notifier).state = true;
    try {
      // TODO: 여기에 실제 서버로 이미지를 업로드하는 API 호출 로직을 구현합니다.
      print('✅ ${imageBytes.lengthInBytes} 바이트 크기의 이미지를 서버로 전송합니다.');
      await Future.delayed(const Duration(seconds: 2));

      // await _ref.read(userProvider.notifier).loadUser();

      if (context.mounted) {
        toastification.show(
          context: context,
          type: ToastificationType.success,
          title: const Text('프로필 이미지가 변경되었습니다.'),
        );
        // 👇 2. 모든 작업이 성공적으로 끝난 후 BottomSheet를 닫습니다.
        Navigator.of(context).pop();
      }
    } on DioException catch (e) {
      // TODO: API 에러 처리
    } catch (e) {
      // TODO: 일반 에러 처리
    } finally {
      if (_ref.exists(profileImageLoadingProvider)) {
        _ref.read(profileImageLoadingProvider.notifier).state = false;
      }
    }
  }
}
