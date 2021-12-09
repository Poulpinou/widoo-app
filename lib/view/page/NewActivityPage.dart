import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widoo_app/bloc/ActivityBloc.dart';
import 'package:widoo_app/model/dto/request/CreateActivityRequest.dart';
import 'package:widoo_app/view/component/form/ActivityForm.dart';

class NewActivityPage extends StatefulWidget {
  @override
  _NewActivityPageState createState() => _NewActivityPageState();
}

class _NewActivityPageState extends State<NewActivityPage> {
  bool _formSubmitted = false;

  @override
  Widget build(BuildContext context) {
    if (_formSubmitted) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "L'activité à été créée",
              style: Theme.of(context).textTheme.headline6,
            ),
            Container(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _formSubmitted = false;
                });
              },
              child: const Text("Créer une autre activité"),
            )
          ],
        ),
      );
    } else {
      return BlocBuilder<ActivityBloc, ActivityState>(
          buildWhen: (previous, current) =>
              previous.isLoading != current.isLoading,
          builder: (context, state) {
            if (state.isLoading) {
              return LinearProgressIndicator();
            }

            if (state.isErrored) {
              return Center(
                child: Text(
                  "Une erreur s'est produite, veuillez réessayer ultérieurement",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Theme.of(context).errorColor),
                ),
              );
            }

            return ActivityForm(
              onSubmit: (data) {
                final CreateActivityRequest request = CreateActivityRequest(
                  name: data.name,
                  description: data.description,
                  repeatable: data.repeatable,
                );

                context.read<ActivityBloc>().add(ActivityEvents.create(
                      request,
                      onSuccess: () {
                        setState(() {
                          _formSubmitted = true;
                        });
                      },
                    ));
              },
            );
          });
    }
  }
}
