// 플랫폼 계정
enum PlatformAuth { kakao, apple }

// 리턴받는 플랫폼 이름
extension PlatformAuthExtension on PlatformAuth {
  String get platformName {
    switch (this) {
      case PlatformAuth.kakao:
        return 'kakao';
      case PlatformAuth.apple:
        return 'apple';
    }
  }
}

// 추후, 구글 / 네이버 적용 예정
