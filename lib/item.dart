// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grid_item_animation/icons.dart';

class ItemModel {
  ItemModel({
    required this.icon,
    required this.value,
    required this.description,
    required this.fullDescription,
    required this.uiPosition,
  });
  final IconData icon;
  final String value;
  final String description;
  final String fullDescription;
  final ({double? top, double? left, double? bottom, double? right}) uiPosition;

  @override
  bool operator ==(covariant ItemModel other) {
    if (identical(this, other)) return true;

    return other.icon == icon &&
        other.value == value &&
        other.description == description &&
        other.fullDescription == fullDescription;
  }

  @override
  int get hashCode {
    return icon.hashCode ^
        value.hashCode ^
        description.hashCode ^
        fullDescription.hashCode;
  }
}

class Item extends StatefulWidget {
  const Item(
    this.model, {
    super.key,
    required this.showBigItem,
    required this.onItemTap,
    required this.animationDuration,
    required this.animationCurve,
  });
  final ItemModel model;
  final bool showBigItem;
  final VoidCallback onItemTap;
  final Duration animationDuration;
  final Curve animationCurve;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  Color get textColor =>
      widget.showBigItem ? Colors.white : Colors.black.withOpacity(0.6);

  late bool showBigItem = widget.showBigItem;
  late bool showFullDescription = false;

  @override
  void didUpdateWidget(covariant Item oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.showBigItem != widget.showBigItem) {
      if (widget.showBigItem) {
        Timer(
          widget.animationDuration,
          () => setState(() => showFullDescription = true),
        );
      } else {
        setState(() => showFullDescription = false);
      }
      setState(() => showBigItem = widget.showBigItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.animationDuration,
      padding: const EdgeInsets.all(10),
      height: showBigItem ? 200 : 100,
      curve: widget.animationCurve,
      width: showBigItem
          ? MediaQuery.of(context).size.width - 15
          : (MediaQuery.of(context).size.width - 15) / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:
              showBigItem ? const Color(0xFF4B778D) : const Color(0xFFF3EFED),
          border: Border.all(color: Colors.white, width: 4)),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              CustomIcon(icon: widget.model.icon),
              const SizedBox(height: 10),
              Text(
                widget.model.value,
                style: TextStyle(fontSize: 10, color: textColor),
              ),
              const SizedBox(height: 7),
              Text(
                widget.model.description,
                style: TextStyle(fontSize: 8, color: textColor),
              ),
              AnimatedCrossFade(
                firstChild: Container(),
                secondChild: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      widget.model.fullDescription,
                      overflow: TextOverflow.fade,
                      style: TextStyle(color: textColor, fontSize: 12),
                    )
                  ],
                ),
                crossFadeState: showFullDescription
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
                firstCurve: widget.animationCurve,
                secondCurve: widget.animationCurve,
                sizeCurve: widget.animationCurve,
              )
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: widget.onItemTap,
              child: showBigItem ? const CloseIcon() : const InfoIcon(),
            ),
          ),
        ],
      ),
    );
  }
}
