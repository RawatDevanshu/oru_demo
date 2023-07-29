import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oru/misc/constants.dart';
import 'package:oru/models/filterchip_model.dart';
import 'package:oru/widgets/filtercatagory_widget.dart';

class CustomModalBottomSheet extends StatefulWidget {
  const CustomModalBottomSheet({super.key, required this.filters});
  final Future<dynamic> filters;

  @override
  State<CustomModalBottomSheet> createState() => _CustomModalBottomSheetState();
}

class _CustomModalBottomSheetState extends State<CustomModalBottomSheet> {
  double start = 0;
  double end = 400000;
  late TextEditingController? _minController;
  late TextEditingController? _maxController;

  @override
  void initState() {
    super.initState();
    _minController = TextEditingController();
    _maxController = TextEditingController();
  }

  @override
  void dispose() {
    _minController!.dispose();
    _maxController!.dispose();
    _minController = null;
    _maxController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.81,
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Filters"),
                TextButton(
                    style: const ButtonStyle(
                        foregroundColor: MaterialStatePropertyAll(Colors.red)),
                    onPressed: () {},
                    child: const Text(
                      "Clear Filter",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.dashed,
                          decorationThickness: 1.5),
                    ))
              ],
            ),
          ),
        ),
        FutureBuilder(
            future: widget.filters,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<List<ItemModel>> data = snapshot.data.filters!;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: FilterCatagory(
                                    title: data[index][0].label,
                                    typeList: data[index].sublist(1)),
                              );
                            }),
                      ),
                      const Text(
                        "Price",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text("Min"),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextField(
                                  controller: _minController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                    constraints: BoxConstraints(
                                        maxWidth: 100, maxHeight: 30),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Max"),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: _maxController,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                    constraints: BoxConstraints(
                                        maxWidth: 100, maxHeight: 30),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      RangeSlider(
                        values: RangeValues(start, end),
                        activeColor: GlobalColor.primarycolor,
                        inactiveColor: Colors.grey,
                        onChanged: (value) {
                          setState(() {
                            start = value.start;
                            end = value.end;
                            _minController!.text = start.toStringAsFixed(0);
                            _maxController!.text = end.toStringAsFixed(0);
                          });
                        },
                        max: 400000,
                        min: 0,
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  color: GlobalColor.primarycolor,
                ));
              }
            }),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                height: 50,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 44, 46, 67),
                    )),
                    onPressed: () {},
                    child: const Text(
                      "APPLY",
                      style: TextStyle(fontSize: 20),
                    )),
              )),
        ),
      ]),
    );
  }
}
