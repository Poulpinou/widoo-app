import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widoo_app/bloc/ActivityBloc.dart';
import 'package:widoo_app/model/dto/response/ActivityCountResponse.dart';
import 'package:widoo_app/repository/ActivityRepository.dart';
import 'package:widoo_app/view/component/ActivityCard.dart';
import 'package:widoo_app/view/component/GrowAnimation.dart';

class CurrentActivityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<ActivityBloc>().add(ActivityEvents.fetchCurrent());

    return BlocBuilder<ActivityBloc, ActivityState>(
      buildWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.currentActivity != current.currentActivity,
      builder: (context, state) {
        if (state.isLoading) {
          return Column(
            children: [
              LinearProgressIndicator(),
              Image.asset('assets/images/idea_box.png'),
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

        if (state.currentActivity != null) {
          return GrowAnimation(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ActivityCard(
                state.currentActivity!,
                onRepeat: (activity) => context
                    .read<ActivityBloc>()
                    .add(ActivityEvents.repeatCurrent()),
                onDone: (activity) => context
                    .read<ActivityBloc>()
                    .add(ActivityEvents.endCurrent()),
              ),
            ),
          );
        } else {
          return Container(
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/images/idea_box.png'),
                  FutureBuilder<ActivityCountResponse>(
                    future:
                        context.read<ActivityRepository>().getActivityCount(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Une erreur s'est produite, veuillez réessayer ultérieurement",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Theme.of(context).errorColor),
                          ),
                        );
                      }

                      final ActivityCountResponse? activityCount =
                          snapshot.data;

                      return Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text((activityCount?.active.toString() ?? "?") +
                                " activités dans la boîte"),
                            Container(height: 10),
                            activityCount != null
                                ? activityCount.active > 0
                                    ? ElevatedButton(
                                        child: Text("Prendre une activité"),
                                        onPressed: () => context
                                            .read<ActivityBloc>()
                                            .add(ActivityEvents.getRandom()),
                                      )
                                    : Text(
                                        activityCount.total > 0
                                            ? "Toutes les activités sont terminées, veuillez en créer de nouvelles"
                                            : "Pas encore d'activité dans la boîte, veuillez en créer une",
                                        textAlign: TextAlign.center,
                                      )
                                : Container(),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
