import 'package:flutter/material.dart';
import 'package:oru/models/filterchip_model.dart';

class FilterCatagory extends StatefulWidget {
  const FilterCatagory({super.key, required this.title, required this.typeList});
  final String title;
  final List<ItemModel> typeList;

  @override
  State<FilterCatagory> createState() => _FilterCatagoryState();
}

class _FilterCatagoryState extends State<FilterCatagory> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(color: Colors.grey, fontSize: 15),
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .91,
              height: MediaQuery.of(context).size.height * .06,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.typeList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: FilterChip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        side: BorderSide(color: Colors.grey.shade400),
                        backgroundColor: Colors.white,
                        selectedColor: Colors.blueGrey.shade200,
                        showCheckmark: false,
                        label: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(widget.typeList[index].label),
                        ),
                        onSelected: (value) {
                          setState(() {
                            widget.typeList[index].isSelected =
                                !widget.typeList[index].isSelected;
                          });
                        },
                        selected: widget.typeList[index].isSelected,
                      ),
                    );
                  }),
            )
          ],
        )
      ],
    );
  }
}
