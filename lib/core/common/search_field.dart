import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final void Function(String)? onChanged;
  const SearchField({this.onChanged,super.key});

  @override
  Widget build(BuildContext context) {
    const customBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );
    return  TextField(
      onChanged: onChanged,
      decoration: const InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(CupertinoIcons.search),
        border: customBorder,
        enabledBorder: customBorder,
      ),
    );
  }
}
