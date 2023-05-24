import 'package:flutter/material.dart';

// search field with filter icon button at the end

class SearchField extends StatefulWidget {
  final Function onSearchSubmit;
  final Function onShowFilterDialog;

  const SearchField(
      {Key? key,
      required this.onSearchSubmit,
      required this.onShowFilterDialog})
      : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: TextField(
        controller: _searchController,
        onSubmitted: (value) {
          widget.onSearchSubmit(value);
        },
        decoration: InputDecoration(
          hintText: 'Search',
          suffixIcon: IconButton(
            onPressed: () {
              widget.onShowFilterDialog();
            },
            icon: const Icon(Icons.filter_list),
          ),
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
