import 'package:widoo_app/config/WidooClientConfig.dart';

import 'ApiClient.dart';

class WidooApiClient extends ApiClient {
  final String? basePath;

  WidooApiClient({this.basePath})
      : super(
          baseUrl: WidooClientConfig.instance.host +
              ":" +
              WidooClientConfig.instance.port.toString(),
          logRequests: WidooClientConfig.instance.logRequests,
          useHttps: WidooClientConfig.instance.useHttps,
        );

  @override
  Uri buildUri(String? path) => super.buildUri(
      WidooClientConfig.instance.routePrefix + "${basePath ?? ""}$path");

  @override
  Future<Map<String, String>> buildHeaders() async {
    final Map<String, String> finalHeaders =
        Map.from(await super.buildHeaders());

    finalHeaders["application-key"] = WidooClientConfig.instance.applicationKey;

    return finalHeaders;
  }
}
