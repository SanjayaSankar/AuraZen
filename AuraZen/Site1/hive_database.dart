import 'package:hive/hive.dart';
import 'package:tracker/datetime/date_time.dart';
import 'package:tracker/models/exercise.dart';

import '../models/exercise.dart';
import '../models/workout.dart';

class HiveDatabase
{
  final _myBox = Hive.box("workout_database1");
  bool previousDataExists()
  {
    if(_myBox.isEmpty)
    {
      print("previous data does not exist");
      _myBox.put("START DATE", todaysDateYYYYMMDD());
      return false;
    }
    else
    {
      print("previous data does exist");
      return true;
    }
  }

  String getStartDate()
  {
    return _myBox.get("START DATE");
  }

  void savetoDatabase(List<Workout>workouts)
  {
    final workoutList = convertObjectToWorkoutList(workouts);
    final exerciseList = convertObjectToExerciseList(workouts);

    if(exerciseCompleted(workouts))
    {
      _myBox.put("Completion Status_${todaysDateYYYYMMDD()}",1);
    }
    else
    {
      _myBox.put("Completion Status_${todaysDateYYYYMMDD()}",0);
    }

    _myBox.put("Workouts",workoutList);
    _myBox.put("Exercises",exerciseList);
  }

  List<Workout> readFromDatabase()
  {
    List<Workout> mySaverdWorkouts = [];
    List<String> workoutNames = _myBox.get("WORKOUTS");
    final exerciseDetails = _myBox.get("EXERCISES");

    for(int i=0; i<workoutNames.length;i++)
    {
      List<Exercise> exercisesInWorkout = [];
       for(int j=0; j<exerciseDetails[i].length;j++)
       {
        exercisesInWorkout.add(
          Exercise(
            name: exerciseDetails[i][j][0],
            weight: exerciseDetails[i][j][1],
            reps: exerciseDetails[i][j][2],
            sets: exerciseDetails[i][j][3],
            isCompleted: exerciseDetails[i][j][4]=="true"?true:false,
          ),
        );
       }

      Workout workout = 
        Workout(name: workoutNames[i], exercises: exercisesInWorkout);

      mySaverdWorkouts.add(workout);
    }
    return mySaverdWorkouts;
  }
  
  bool exerciseCompleted(List<Workout> workouts)
  {
    for(var workout in workouts)
    {
      for(var exercise in workout.exercises)
      {
        if(exercise.isCompleted)
        {
          return true;
        }
      }
    }
    return false;
  }

  int getCompletionStatus(String yyyymmdd)
  {
    int completionStatus = _myBox.get("Completion Status_"+yyyymmdd) ?? 0;
    return completionStatus;
  }
}

List<String> convertObjectToWorkoutList(List<Workout> workouts){
  List<String> workoutList = [];

  for(int i=0;i<workouts.length;i++)
  {
    workoutList.add(
      workouts[i].name,
    );
  }
  
  return workoutList;
}

List<List<List<String>>> convertObjectToExerciseList(List<Workout> workouts)
  {
    List<List<List<String>>> exerciseList = [];

    for(int i=0;i<workouts.length;i++)
    {
      List<Exercise> exercisesInWorkout = workouts[i].exercises;
      List<List<String>> individualWorkout = [

      ];

      for(int j=0; j<exercisesInWorkout.length;j++)
      {
        List<String> individualExercise = [

        ];
        individualExercise.addAll(
          [
            exercisesInWorkout[j].name,
            exercisesInWorkout[j].weight,
            exercisesInWorkout[j].reps,
            exercisesInWorkout[j].sets,
            exercisesInWorkout[j].isCompleted.toString(),
          ],
        );
        individualWorkout.add(individualExercise);
      }
      exerciseList.add(individualWorkout);
    }
    return exerciseList;
  }