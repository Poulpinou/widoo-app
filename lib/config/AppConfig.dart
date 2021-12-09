import 'WidooClientConfig.dart';

class AppConfig {
  final String title;
  final WidooClientConfig clientConfig;

  const AppConfig({
    this.title = "Widoo",
    this.clientConfig = const WidooClientConfig(),
  });

  factory AppConfig.base() => AppConfig();

  static AppConfig _instance = AppConfig.base();

  static AppConfig get instance {
    return _instance;
  }

  factory AppConfig.create(AppConfig config) {
    _instance = config;

    return _instance;
  }
}
