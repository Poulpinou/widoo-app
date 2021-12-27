import 'package:flutter/material.dart';

class RulesCard extends StatelessWidget {
  static const String RULES_TEXT =
      "Afin d'être valides, les activités doivent répondre à un certain nombre "
      "de contraintes décrites ci dessous:"
      "\n\n  - Réalistes: acheter un château et le transformer en piscine n'est par exemple pas valide"
      "\n\n  - Réalisables: d'une seule traite ou en plusieurs itérations, rendre l'action répétable le "
      "cas échéant et cliquer sur l'option \"répéter\" à chaque fin d'itération. Idéalement, décrire "
      "précisément le contenu de chaque itération dans la description."
      "\n\n  - Acceptables: okay, l'autre a la surprise du contenu des activité, mais "
      "il a quand même le droit de refuser si cela ne lui convient vraiment pas"
      "\n\n  - Concrètes: Une action doit avoir un résultat concret. Il faut donc veiller "
      "à bien tourner la description afin d'avoir une tâche réalisable rapidement. "
      "Il est possible de prévoir des actions réalisables dans le future, mais il "
      "est nécessaire de créer une action réalisable dans le présent (ex réserver "
      "l'activité en question) afin de ne pas bloquer les autres actions."
      "\n\nToute action ne rentrant pas dans ce cadre pourra être refusée et annulée "
      "par n'importe quel participant.";

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(child: const Text(RULES_TEXT)),
      ),
      color: Theme.of(context).colorScheme.background,
    );
  }
}
