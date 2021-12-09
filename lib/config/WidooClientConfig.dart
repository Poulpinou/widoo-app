import 'AppConfig.dart';

class WidooClientConfig {
  final String host;
  final int port;
  final bool useHttps;
  final String routePrefix;
  final bool logRequests;
  final String applicationKey;

  const WidooClientConfig({
    this.host = "10.0.2.2",
    this.port = 8080,
    this.useHttps = false,
    this.routePrefix = "",
    this.logRequests = true,
    this.applicationKey = "mostSecretKeyEver",
  });

  static WidooClientConfig get instance => AppConfig.instance.clientConfig;
}
