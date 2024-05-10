import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grid_item_animation/item.dart';

class ExpandableGrid extends StatefulWidget {
  const ExpandableGrid({super.key});

  @override
  State<ExpandableGrid> createState() => _ExpandableGridState();
}

class _ExpandableGridState extends State<ExpandableGrid> {
  int? bigItemIndex;
  bool showAllItems = true;
  bool isBigCardToggled = false;
  final animationDuration = const Duration(milliseconds: 500);
  final animationCurve = Curves.ease;

  void onItemTap(int index) {
    setState(() {
      if (bigItemIndex == null) {
        bigItemIndex = index;
        showAllItems = false;
        isBigCardToggled = true;
      } else {
        isBigCardToggled = false;
        Timer(
          animationDuration,
          () => setState(() {
            showAllItems = true;
            bigItemIndex = null;
          }),
        );
      }
    });
  }

  List<ItemModel> get models => [
        ItemModel(
          icon: Icons.bar_chart_rounded,
          value: '10%',
          description: 'Bazin',
          fullDescription: loremIpsum,
          uiPosition: (top: 0, left: 0, right: null, bottom: null),
        ),
        ItemModel(
          icon: Icons.bar_chart_rounded,
          value: '22%',
          description: 'Graham',
          fullDescription: loremIpsum,
          uiPosition: (top: 0, left: null, right: 0, bottom: null),
        ),
        ItemModel(
          icon: Icons.bar_chart_rounded,
          value: '11%',
          description: 'Gordon',
          fullDescription: loremIpsum,
          uiPosition: (top: null, left: 0, right: null, bottom: 0),
        ),
        ItemModel(
          icon: Icons.bar_chart_rounded,
          value: '0,55',
          description: 'Índice PEG',
          fullDescription: loremIpsum,
          uiPosition: (top: null, left: null, right: 0, bottom: 0),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 200,
          child: Stack(
            children: models.map(
              (e) {
                final index = models.indexWhere((element) => element == e);
                final isCurrentItemBig = bigItemIndex == index;
                final isAnimatingOtherCard = !showAllItems && !isCurrentItemBig;
                final hideCurrentCard =
                    isAnimatingOtherCard && isBigCardToggled;

                return AnimatedPositioned(
                  top: e.uiPosition.top,
                  left: e.uiPosition.left,
                  right: e.uiPosition.right,
                  bottom: e.uiPosition.bottom,
                  duration: animationDuration,
                  curve: animationCurve,
                  child: AnimatedOpacity(
                    opacity: isAnimatingOtherCard ? 0 : 1,
                    duration: animationDuration,
                    curve: animationCurve,
                    child: hideCurrentCard
                        ? const SizedBox.shrink()
                        : Item(
                            e,
                            animationCurve: animationCurve,
                            onItemTap: () => onItemTap(index),
                            showBigItem: isCurrentItemBig && isBigCardToggled,
                            animationDuration: animationDuration,
                          ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}

const loremIpsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec rhoncus nec lacus id ullamcorper. Integer pharetra ipsum ullamcorper, pulvinar risus nec, mattis lacus. Integer tempus tellus non vehicula ultricies. Pellentesque aliquam dui non molestie pretium.';
