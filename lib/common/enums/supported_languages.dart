enum SupportedLanguage {
  english(shortCode: "en"),
  slovak(shortCode: "sk"),
  czech(shortCode: "cz");

  final String shortCode;

  const SupportedLanguage({required this.shortCode});
}
