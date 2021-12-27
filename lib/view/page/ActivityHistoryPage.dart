import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:widoo_app/bloc/ActivityBloc.dart';
import 'package:widoo_app/model/Activity.dart';
import 'package:widoo_app/model/dto/response/ActivityCountResponse.dart';
import 'package:widoo_app/repository/ActivityRepository.dart';
import 'package:widoo_app/view/component/ActivityCard.dart';
import 'package:widoo_app/view/component/GrowAnimation.dart';

class ActivityHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<ActivityBloc>().add(ActivityEvents.fetchHistory());

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Theme.of(context).colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<ActivityCountResponse>(
              future: context.read<ActivityRepository>().getActivityCount(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    "Une erreur s'est produite",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Theme.of(context).errorColor),
                  );
                }

                final ActivityCountResponse? activityCount = snapshot.data;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Total: ${activityCount?.total ?? "?"}"),
                    Text("Terminées: ${activityCount?.done ?? "?"}"),
                    Text("À faire: ${activityCount?.active ?? "?"}"),
                  ],
                );
              },
            ),
          ),
        ),
        BlocBuilder<ActivityBloc, ActivityState>(
          buildWhen: (previous, current) =>
              previous.isLoading != current.isLoading,
          builder: (context, state) {
            if (state.isLoading) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LinearProgressIndicator(),
                ],
              );
            }

            if (state.isErrored) {
              return Center(
                child: Text(
                  state.error!.message,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Theme.of(context).errorColor),
                ),
              );
            }

            final List<Activity> history = state.history;
            if (history.isEmpty) {
              return Expanded(
                child: Center(
                  child: const Text("Pas encore d'activité terminée"),
                ),
              );
            } else {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      final Activity activity = history[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        child: GestureDetector(
                          onTap: () => showDialog(
                              context: context,
                              builder: (context) {
                                return GrowAnimation(
                                  child: ActivityCard(
                                    activity,
                                    onClose: () => Navigator.of(context).pop(),
                                  ),
                                );
                              }),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        activity.repeatable
                                            ? Icons.replay_outlined
                                            : Icons.check,
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                          child: Text(
                                            activity.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        DateFormat("dd/MM/yyyy")
                                            .format(activity.endDate!),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ],
                                  ),
                                  Container(height: 5),
                                  Text(
                                    activity.description,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
