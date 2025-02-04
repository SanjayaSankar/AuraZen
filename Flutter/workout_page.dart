import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/components/exercise_tile.dart';
import 'package:tracker/data/workout_data.dart';

class WorkoutPage extends StatefulWidget{
  final String workoutName;
  const WorkoutPage({super.key, required this.workoutName});
  
  @override
  State<WorkoutPage> createState() => _WorkoutPageState(); 

}

class _WorkoutPageState extends State<WorkoutPage>
{
  @override
  Widget build(BuildContext context) {

    return Consumer<WorkoutData>
    (builder:((context, value, child) => Scaffold(
      appBar: AppBar(title: Text(widget.workoutName)),
      body: ListView.builder(
        itemCount: value.numberExercise(widget.workoutName),
        itemBuilder: ((context, index) => Exercisetile(
          exerciseName: value.getRelevantWorkout(widget.workoutName).exercises[index].name,
          weights: value.getRelevantWorkout(widget.workoutName).exercises[index].weight,
          reps: value.getRelevantWorkout(widget.workoutName).exercises[index].reps,
          sets: value.getRelevantWorkout(widget.workoutName).exercises[index].sets,
          isCompleted: value.getRelevantWorkout(widget.workoutName).exercises[index].isCompleted,
        )

        )))
    ));

  }

}