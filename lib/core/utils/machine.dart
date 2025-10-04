import 'package:equatable/equatable.dart';

class Machine extends Equatable {
  final String name;
  final String imagePath;
  final String description;

  const Machine({
    required this.name,
    required this.imagePath,
    required this.description,
  });

  @override
  List<Object> get props => [name, imagePath, description];
}