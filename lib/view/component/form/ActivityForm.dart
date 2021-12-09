import 'package:flutter/material.dart';
import 'package:widoo_app/model/formData/ActivityFormData.dart';

class ActivityForm extends StatefulWidget {
  final Function(ActivityFormData data) onSubmit;

  const ActivityForm({required this.onSubmit, Key? key}) : super(key: key);

  @override
  ActivityFormState createState() => ActivityFormState();
}

class ActivityFormState extends State<ActivityForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _repeatableValue = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                maxLines: 1,
                maxLength: 64,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nom de l'activité",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ce champs ne peut pas être vide";
                  }
                  return null;
                },
              ),
              Container(height: 10),
              TextFormField(
                controller: _descriptionController,
                minLines: 5,
                maxLines: 10,
                maxLength: 2048,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Description de l'activité",
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ce champs ne peut pas être vide";
                  }
                  return null;
                },
              ),
              Container(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                      value: _repeatableValue,
                      onChanged: (value) {
                        setState(() {
                          _repeatableValue = value ?? false;
                        });
                      }),
                  const Text("Répétable?"),
                ],
              ),
              Container(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final ActivityFormData data = ActivityFormData(
                      _nameController.value.text,
                      _descriptionController.value.text,
                      _repeatableValue,
                    );

                    widget.onSubmit(data);
                  }
                },
                child: const Text("Créer l'activité"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
