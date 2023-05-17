import 'package:charge_station_finder/presentation/pages/home/widgets/plugTypeModal.dart';
import 'package:flutter/material.dart';

// search field with filter icon button at the end


class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: TextField(

          decoration: InputDecoration(
        hintText: 'Search',
        suffixIcon: IconButton(
          onPressed: () {
            // show filter dialog box
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  
                  return PlugTypeModal();
                  
                });
            
          },
          icon: const Icon(Icons.filter_list),
        ),
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      )),
    );
  }
}
