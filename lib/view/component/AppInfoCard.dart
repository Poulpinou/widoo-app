import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AppInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      "Nom: ",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(snapshot.data?.appName ?? "?"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Version: ",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(snapshot.data?.version ?? "?"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Numéro de build: ",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(snapshot.data?.buildNumber ?? "?"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Package: ",
                      style: Theme.of(context).textTheme.subtitle2,
                      maxLines: 3,
                    ),
                    Text(snapshot.data?.packageName ?? "?"),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      color: Theme.of(context).colorScheme.background,
    );
  }
}
