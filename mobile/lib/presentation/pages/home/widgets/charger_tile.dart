import 'package:flutter/material.dart';

class ChargerTile extends StatelessWidget {
  final String name;
  final String address;
  final double rating;
  final double wattage;

  const ChargerTile({
    super.key,
    this.name = "Charger Name",
    this.address = "Address",
    this.rating = 4.5,
    this.wattage = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Start image
              Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.ev_station,
                    size: 50,
                    color: Colors.green,
                  )),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 15,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        address,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.bolt,
                        size: 15,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "${wattage.toStringAsFixed(0)}W",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
