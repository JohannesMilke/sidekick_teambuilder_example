import 'package:flutter/material.dart';
import 'package:flutter_sidekick/flutter_sidekick.dart';
import 'package:sidekick_teambuilder_example/model/user.dart';

class FavouritesRowWidget extends StatelessWidget {
  final ScrollController controller;
  final ScrollController gridController;
  final List<SidekickBuilderDelegate<User>> delegates;

  const FavouritesRowWidget({
    @required this.controller,
    @required this.gridController,
    @required this.delegates,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: delegates.isEmpty
              ? [Text('Add someone as favourite')]
              : delegates.map((delegate) {
                  final user = delegate.message;

                  return delegate.build(
                    context,
                    buildUser(context, user),
                    animationBuilder: (animation) => CurvedAnimation(
                      parent: animation,
                      curve: FlippedCurve(Curves.ease),
                    ),
                  );
                }).toList(),
        ),
      );

  Widget buildUser(BuildContext context, User user) => GestureDetector(
        onTap: () async {
          final value = gridController.position.maxScrollExtent;
          await gridController.animateTo(
            value,
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 100),
          );

          SidekickTeamBuilder.of<User>(context).move(user);
        },
        child: Card(
          elevation: 4,
          child: FittedBox(
            child: Container(
              padding: EdgeInsets.all(4),
              child: CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(user.imageUrl),
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ),
      );
}
