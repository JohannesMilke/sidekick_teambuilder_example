import 'package:flutter/material.dart';
import 'package:flutter_sidekick/flutter_sidekick.dart';
import 'package:sidekick_teambuilder_example/data/users.dart';
import 'package:sidekick_teambuilder_example/main.dart';
import 'package:sidekick_teambuilder_example/model/user.dart';
import 'package:sidekick_teambuilder_example/widget/favourites_row_widget.dart';
import 'package:sidekick_teambuilder_example/widget/user_grid_widget.dart';

class HomePage extends StatelessWidget {
  final controller = ScrollController();
  final gridController = ScrollController();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          title: Text(MyApp.title),
        ),
        body: SidekickTeamBuilder<User>(
          animationDuration: Duration(seconds: 1),
          initialSourceList: allUsers,
          builder: (context, sourceDelegates, delegates) => Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  child: UserGridWidget(
                    delegates: sourceDelegates,
                    controller: gridController,
                    rowController: controller,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  height: 80,
                  child: Column(
                    children: [
                      Text(
                        'Favourites',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      FavouritesRowWidget(
                        delegates: delegates,
                        controller: controller,
                        gridController: gridController,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
