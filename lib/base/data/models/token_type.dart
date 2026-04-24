/// Enum representing the type of token.
library;
// ignore_for_file: constant_identifier_names

enum TokenType {
  /// A bearer token.
  JWT,

  /// No token.
  None;

  const TokenType();

  /// Returns a map of extra data for the [TokenType].
  Map<String, dynamic> get asExtra {
    switch (this) {
      case TokenType.JWT:
        return <String, dynamic>{
          'secure': <Map<String, String>>[
            {'type': 'http', 'scheme': 'JWT', 'name': 'JWT'},
          ],
        };

      case TokenType.None:
        return {};
    }
  }

  /// Returns a [TokenType] from the given extra data.
  static TokenType fromExtra(Map<String, dynamic> extra) {
    final secure = extra['secure'];

    if (secure != null && secure[0]['type'] == 'http' && secure[0]['scheme'] == 'JWT') {
      return TokenType.JWT;
    }

    return TokenType.None;
  }
}
