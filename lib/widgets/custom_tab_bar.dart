import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  final List<String> tabTitles;
  final int selectedIndex;
  final Function(int) onTabTapped;

  const CustomTabBar({
    Key? key,
    required this.tabTitles,
    required this.selectedIndex,
    required this.onTabTapped,
  }) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Row(
        children: widget.tabTitles.asMap().entries.map((entry) {
          final index = entry.key;
          final title = entry.value;
          return Expanded(
            child: GestureDetector(
              onTap: () => widget.onTabTapped(index),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: index == widget.selectedIndex
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: index == widget.selectedIndex
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                    fontWeight: index == widget.selectedIndex
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}