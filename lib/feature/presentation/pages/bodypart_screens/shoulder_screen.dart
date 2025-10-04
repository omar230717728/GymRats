import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/shared/app_bar.dart';
import 'package:flutter_application_1/core/shared/machine_grid.dart';
import 'package:flutter_application_1/core/utils/machine.dart';

class ShoulderScreen extends StatelessWidget {
  final List<Machine> armMachines = [
    Machine(
      name: 'Bicep Curl Machine',
      imagePath: 'assets/bicep_curl.jpg',
      description: 'Targets bicep muscles...',
    ),
    Machine(
      name: 'Tricep Extension',
      imagePath: 'assets/tricep_extension.jpg',
      description: 'Focuses on tricep development...',
    ),
    Machine(
      name: 'Preacher Curl',
      imagePath: 'assets/preacher_curl.jpg',
      description: 'Isolates bicep muscles...',
    ),
    Machine(
      name: 'Preacher Curl',
      imagePath: 'assets/preacher_curl.jpg',
      description: 'Isolates bicep muscles...',
    ),
    Machine(
      name: 'Preacher Curl',
      imagePath: 'assets/preacher_curl.jpg',
      description: 'Isolates bicep muscles...',
    ),
    Machine(
      name: 'Preacher Curl',
      imagePath: 'assets/preacher_curl.jpg',
      description: 'Isolates bicep muscles...',
    ),
    Machine(
      name: 'Preacher Curl',
      imagePath: 'assets/preacher_curl.jpg',
      description: 'Isolates bicep muscles...',
    ),
    Machine(
      name: 'Preacher Curl',
      imagePath: 'assets/preacher_curl.jpg',
      description: 'Isolates bicep muscles...',
    ),
    Machine(
      name: 'Preacher Curl',
      imagePath: 'assets/preacher_curl.jpg',
      description: 'Isolates bicep muscles...',
    ),
    Machine(
      name: 'Preacher Curl',
      imagePath: 'assets/preacher_curl.jpg',
      description: 'Isolates bicep muscles...',
    ),
    Machine(
      name: 'Preacher Curl',
      imagePath: 'assets/preacher_curl.jpg',
      description: 'Isolates bicep muscles...',
    ),
    // Add more arm machines...
  ];

  @override
  Widget build(BuildContext context) {
    return buildMachinesGrid(context, armMachines);
  }
}
