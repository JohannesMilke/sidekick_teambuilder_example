import 'package:flutter/material.dart';
import 'package:flutter_sidekick/flutter_sidekick.dart';
import 'package:sidekick_teambuilder_example/model/user.dart';

class UserGridWidget extends StatelessWidget {
  final List<SidekickBuilderDelegate<User>> delegates;
  final ScrollController controller;
  final ScrollController rowController;

  const UserGridWidget({
    @required this.delegates,
    @required this.controller,
    @required this.rowController,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GridView.builder(
        controller: controller,
        itemCount: delegates.length + 1,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index == delegates.length) {
            return Container();
          } else {
            final delegate = delegates[index];
            final user = delegate.message;

            return delegate.build(
              context,
              GestureDetector(
                onTap: () async {
                  await SidekickTeamBuilder.of<User>(context).move(user);

                  final value = rowController.position.maxScrollExtent;
                  rowController.jumpTo(value);
                },
                child: buildUser(user),
              ),
              animationBuilder: (animation) => CurvedAnimation(
                parent: animation,
                curve: Curves.easeIn,
              ),
            );
          }
        },
      );

  Widget buildUser(User user) => Card(
        child: FittedBox(
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(user.imageUrl),
                radius: 50,
              ),
              SizedBox(height: 16),
              Text(
                user.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
      );
}
