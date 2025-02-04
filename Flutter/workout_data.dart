import 'package:flutter/cupertino.dart';
import 'package:tracker/data/hive_database.dart';
import 'package:tracker/models/exercise.dart';
import 'package:tracker/models/workout.dart';

class WorkoutData extends ChangeNotifier
{
  final db = HiveDatabase();

  List<Workout> workoutList = [
    Workout(
      name: "Upper body",
      exercises: [
        Exercise(
          name: "Bicep Curl", 
          weight:"10", 
          reps: "10", 
          sets: "3"),
      ],
    ),

    Workout(
      name: "Lower Body body",
      exercises: [
        Exercise(
          name: "Bicep Curl", 
          weight:"10", 
          reps: "10", 
          sets: "3"),
      ],
    ),
  ];

  void initialiseWorkout()
  {
    if(db.previousDataExists())
    {
      workoutList = db.readFromDatabase();
    }
    else
    {
      db.savetoDatabase(workoutList);
    }
  }

  List<Workout>getWorkoutList()
  {
    return workoutList;
  }

  int numberExercise(String workoutName)
  {
    Workout relevantWorkout  = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  void addWorkout(String name)
  {
    workoutList.add(Workout(name:name,exercises: []));
    notifyListeners();
  }
    
  void addExercise(String workoutName, String exerciseName, String weight, String reps, String sets)
  {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    relevantWorkout.exercises.add(
      Exercise(
        name: exerciseName,
        weight: weight,
        reps: reps,
        sets: sets,
      ),
    );  

    notifyListeners();
  }

  void checkExercise(String workoutName, String exerciseName)
  {
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);
    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();
  }

  Workout getRelevantWorkout(String workoutName)
  {
    Workout relevantWorkout = 
      workoutList.firstWhere((workout) => workout.name == workoutName);
  
    return relevantWorkout;
  }

    Exercise getRelevantExercise(String workoutName, String exerciseName)
  {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    Exercise relevantExercise = relevantWorkout.exercises.firstWhere((exercise) => exercise.name == exerciseName);

    return relevantExercise;
  }
  
}