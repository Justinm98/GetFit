//
//  WorkoutDetails.swift
//  DomsGitFit
//
//  Created by Dominic Gennello on 11/23/20.
//

import SwiftUI

struct WorkoutDetails: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var userData: UserData
    
    let workout: Workout
    var body: some View {
        Form {
            Section(header: Text("Workout Name")) {
                Text(workout.name ?? "Unavailable")
            }
            Section(header: Text("Category")) {
                Text(workout.category ?? "Unavailable")
            }
            Section(header: Text("Exercises")) {
                List {
                    ForEach(workout.exercises!.allObjects as! [Exercise], id: \.self) { anExercise in
                        NavigationLink(destination: ExerciseDetails(exercise: anExercise)) {
                            Text(anExercise.name ?? "")
                        }
                    }
                }
            }
            Section(header: Text("Duration")) {
                Text("\(workout.duration as! Int) mins")
            }
            Section(header: Text("Calories")) {
                Text("\(workout.calories as! Int)")
            }
            Section(header: Text("Notes")) {
                Text(workout.notes ?? "Unavailable")
            }
            Section(header: Text("Edit Workout")) {
                NavigationLink(destination: ChangeWorkout(workout: workout)) {
                    HStack {
                        Image(systemName: "pencil.circle")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                            .foregroundColor(.blue)
                        Text("Edit Workout")
                    }
                }
            }
        }
            .font(.system(size: 16))
    }
}

