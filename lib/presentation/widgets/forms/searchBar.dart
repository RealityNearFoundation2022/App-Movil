import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class Searchbar extends StatefulWidget {
  final String placeholder;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const Searchbar({Key key, this.placeholder, this.controller, this.onChanged})
      : super(key: key);

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          hintText: widget.placeholder,
          hintStyle: GoogleFonts.sourceSansPro(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: widget.controller.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close),
                  onTap: () {
                    widget.controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
