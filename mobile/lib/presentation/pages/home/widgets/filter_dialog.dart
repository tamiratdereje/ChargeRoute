import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  final Function onFilterSubmit;

  const FilterDialog({Key? key, required this.onFilterSubmit})
      : super(key: key);

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  var minWattage = 0.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Filters', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            // Min value slider for wattage
            const Text('Min Wattage'),
            Slider(
              value: minWattage,
              max: 10000,
              divisions: 100,
              label: "${minWattage.round().toString()}W",
              onChanged: (double value) {
                setState(() {
                  minWattage = value;
                });
              },
            ),
            // Submit button
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  onPressed: () {
                    widget.onFilterSubmit(minWattage);
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 30),
          ],
        ),
      ),
    );
  }
}
