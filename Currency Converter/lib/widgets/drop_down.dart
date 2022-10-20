import 'package:flutter/material.dart';

Widget dropDown(List<String> items, String value, void onChange(val)) {
  return Container(
    padding: EdgeInsets.symmetric(
      vertical: 4.0,
      horizontal: 16.0,
    ),
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 182, 224, 227),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: DropdownButton<String>(
      value: value,
      onChanged: (String val) {
        onChange(val);
      },
      items: items?.map((String val) {
            return DropdownMenuItem(child: Text(val), value: val);
          })?.toList() ??
          [],
    ),
  );
}
