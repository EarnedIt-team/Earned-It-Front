/// Exception 클래스에 대한 확장 메서드
extension ExceptionExtension on Object {
  /// Exception.toString() 결과에서 "Exception: " 접두사를 제거합니다.
  String toDisplayString() {
    final String fullMessage = toString();
    if (fullMessage.startsWith('Exception: ')) {
      return fullMessage.substring('Exception: '.length);
    }
    return fullMessage;
  }
}
