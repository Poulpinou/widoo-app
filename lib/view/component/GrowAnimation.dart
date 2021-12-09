import 'package:flutter/material.dart';

class GrowAnimation extends StatefulWidget {
  final Widget child;

  const GrowAnimation({Key? key, required this.child}) : super(key: key);

  @override
  _GrowAnimationState createState() => _GrowAnimationState();
}

class _GrowAnimationState extends State<GrowAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.3, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: _animation.value,
        child: ClipRect(
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
