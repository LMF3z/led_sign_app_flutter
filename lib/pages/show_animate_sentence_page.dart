import 'package:flutter/material.dart';

class ShowAnimateSentencePage extends StatefulWidget {
  final String textToShow;

  const ShowAnimateSentencePage({
    super.key,
    required this.textToShow,
  });

  @override
  State<ShowAnimateSentencePage> createState() =>
      _ShowAnimateSentencePageState();
}

class _ShowAnimateSentencePageState extends State<ShowAnimateSentencePage>
    with TickerProviderStateMixin {
  late AnimationController _animation_controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animation_controller.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _animation_controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: (widget.textToShow.length / 1.5).round(),
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animation_controller.repeat();
        }
      });

    final sWidth = MediaQuery.of(context).size.width;

    _offsetAnimation = Tween<Offset>(
      begin: Offset(
        (widget.textToShow.length + sWidth).roundToDouble(),
        0,
      ),
      end: Offset(
        -(widget.textToShow.split(" ").length * sWidth),
        0,
      ),
    ).animate(_animation_controller);

    _animation_controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // return MediaQuery(
    //     data: MediaQueryData.fromView().copyWith(),
    //     child: Builder(builder: (ctx) {
    //       return Scaffold();
    //     }));

    // ? --------------------------------------------------

    return Scaffold(
      backgroundColor: Colors.black45,
      body: OrientationBuilder(
        builder: (BuildContext ctx, or) {
          return Center(
            child: AnimatedBuilder(
              animation: _animation_controller,
              builder: (ctx, child) {
                return Transform(
                  transform: Matrix4.translationValues(
                      _offsetAnimation.value.dx, 0, 0),
                  child: FittedBox(
                    fit: BoxFit.none,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.textToShow,
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 100, // Dynamic sizing
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );

    // ? --------------------------------------------------

    // return Scaffold(
    //   body: Center(
    //     child: Transform.rotate(
    //       angle: 1.6,
    //       child: Text(
    //         widget.textToShow,
    //         style: const TextStyle(
    //           fontSize: 150,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
