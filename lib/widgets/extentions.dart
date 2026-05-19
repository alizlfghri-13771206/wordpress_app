
extension FarsiNumbers on String {
  String get farsiNumber {
    const english = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
    const farsi = ["۱", "۲", "۳", "۴", "۵", "۶", "۷", "۸", "۹", "۰"];
    String text = this;
    for (int i = 0; i < 10; i++) {
      text = text.replaceAll(english[i], farsi[i]);
    }
    return text;
  }
}
