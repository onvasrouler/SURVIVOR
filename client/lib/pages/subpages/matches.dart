import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soul_connection/pages/constants/constants.dart';
import 'package:soul_connection/pages/models/user.module.dart';
import 'package:soul_connection/pages/subpages/interface/mouse_pointer.dart';
import 'package:soul_connection/pages/subpages/widget/appbar.dart';
import 'package:soul_connection/pages/subpages/widget/progress_circle.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key, required this.user});
  final UserModel user;

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage>
    with HoverMixin<MatchesPage> {
  Widget profilePic(int index) {
    return MouseRegion(
      onEnter: (event) => onHoverGraph(event, index, context),
      onHover: (event) => onHoverGraph(event, index, context),
      onExit: onExit,
      child: Transform(
        transform: hoveredIndex == index
            ? (Matrix4.identity()
              ..setEntry(2, 2, 0.001)
              ..rotateX(rotationX)
              ..rotateY(rotationY))
            : Matrix4.identity(),
        alignment: FractionalOffset.center,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: (((dw(context) / 10) > 140 ? 140 : (dw(context) / 10)) +
              (hoveredIndex != index ? 0 : 40)),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 3),
            borderRadius: BorderRadius.circular(100),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.memory(
              widget.user.profilePic!,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dh(context),
      width: dw(context),
      child: Column(
        children: [
          appBar(context, 'Matches'),
          SizedBox(
            height: dh(context) - 300,
            width: dw(context),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                sw(20),
                profilePic(0),
                MouseRegion(
                  onEnter: (event) => onHoverGraph(event, 2, context),
                  onHover: (event) => onHoverGraph(event, 2, context),
                  onExit: onExit,
                  child: CircleProgressIndicator(
                    hoveredIndex: hoveredIndex,
                  ),
                ),
                profilePic(1),
                sw(20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
