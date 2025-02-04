import 'package:flutter/material.dart';

class Exercisetile extends StatelessWidget{
  final String exerciseName;
  final String weights;
  final String reps;
  final String sets;
  final bool isCompleted;

  const Exercisetile({super.key, 
  required this.exerciseName,
  required this.weights,
  required this.reps,
  required this.sets,
  required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.purple ,
          child: ListTile(
          title: Text(exerciseName),
          subtitle: Row(
            children: [
              Chip(
                label: Text (
                  "${weights}kg"),       
              ),

              Chip(
                label: Text (
                  "$reps reps",)
              ),

              Chip(
                label: Text (
                  "$sets sets",)
              )
            ],
          ),
      ),
    );
  }
}