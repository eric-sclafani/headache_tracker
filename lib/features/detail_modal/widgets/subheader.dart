import 'package:flutter/material.dart';
import 'package:headache_tracker/models/headache.dart';

class SubHeader extends StatelessWidget {
  final Headache inputHeadache;

  const SubHeader({super.key, required this.inputHeadache});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.black.withAlpha(50)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(3),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.electric_bolt,
                size: 20,
                color: Colors.yellow.shade800,
              ),
              const Text(
                'Intensity: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${inputHeadache.intensity}/5'),
            ],
          ),
          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.medication_outlined,
                        size: 20,
                        color: Colors.lightGreen.shade800,
                      ),
                      const Text(
                        'Advils: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(inputHeadache.totalAdvils.toString()),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.ac_unit,
                        size: 20,
                        color: Colors.lightBlue.shade800,
                      ),
                      const Text(
                        'Ice packs: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(inputHeadache.totalIcepacks.toString()),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
