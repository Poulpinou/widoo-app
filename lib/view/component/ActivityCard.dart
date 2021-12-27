import 'package:flutter/material.dart';
import 'package:widoo_app/model/Activity.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final Function()? onClose;
  final Function(Activity activity)? onDone;
  final Function(Activity activity)? onRepeat;

  ActivityCard(
    this.activity, {
    this.onClose,
    this.onDone,
    this.onRepeat,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColoredBox(
            color: Theme.of(context).colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/idea_box.png',
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                  Expanded(
                    child: Text(
                      activity.name,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  onClose != null
                      ? IconButton(
                          icon: Icon(Icons.close),
                          onPressed: onClose,
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Text(activity.description),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              onDone != null
                  ? ElevatedButton(
                      child: Text("Terminer"),
                      onPressed: () => onDone!(activity),
                    )
                  : Container(),
              onRepeat != null
                  ? ElevatedButton(
                      child: Text("Répéter"),
                      onPressed: activity.repeatable
                          ? () => onRepeat!(activity)
                          : null,
                    )
                  : Container(),
            ],
          )
        ],
      ),
      color: Theme.of(context).colorScheme.background,
    );
  }
}
