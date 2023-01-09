import 'package:flutter/material.dart';
import 'package:system_delivery/application/use_case/widgets/main_admin/meal.dart';

class MainStaggeredDualView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Meals',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: StaggeredDualView(
              aspecRatio: 0.65,
              spacing: 30,
              itemBuilder: (context, index) {
                return MealItem(
                  meal: meals[index],
                );
              },
              itemCount: meals.length),
        ),
      ),
    );
  }
}

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal});
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: ClipOval(
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  meal.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  meal.name,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  meal.name,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 11,
                      color: Colors.grey),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < 4 ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StaggeredDualView extends StatelessWidget {
  const StaggeredDualView({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.spacing = 0.0,
    this.aspecRatio = 0.5,
    this.offsetPercent = 0.5,
  }) : super(key: key);

  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double spacing;
  final double aspecRatio;
  final double offsetPercent;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final itemHeight = (width * 0.5) / aspecRatio;
      final height = constraints.maxHeight + itemHeight;
      return ClipRect(
        child: OverflowBox(
          maxWidth: width,
          minWidth: width,
          minHeight: height,
          maxHeight: height,
          child: GridView.builder(
            padding: EdgeInsets.only(top: itemHeight / 2, bottom: itemHeight),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: aspecRatio,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return Transform.translate(
                offset:
                    Offset(0.0, index.isOdd ? itemHeight * offsetPercent : 0.0),
                child: itemBuilder(context, index),
              );
            },
          ),
        ),
      );
    });
  }
}
