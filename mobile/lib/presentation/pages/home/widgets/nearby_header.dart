import 'package:flutter/cupertino.dart';

class NearbyHeader extends StatelessWidget {
  const NearbyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text(
                'Nearby Stations',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
  }
}