//
//  Overview.swift
//  GetFit
//
//  Created by CS3714 on 11/22/20.
//

import SwiftUI


struct Overview: View {
    
    @FetchRequest(fetchRequest: Workout.allWorkoutsFetchRequest()) var allWorkouts: FetchedResults<Workout>
    
    @FetchRequest(fetchRequest: Meal.allMealsFetchRequest()) var allMeals: FetchedResults<Meal>
    
    @FetchRequest(fetchRequest: Progress.allProgressFetchRequest()) var allProgress: FetchedResults<Progress>
    
    var body: some View {
        Text("Hello, World!")
    }
    
    /*
     MARK: - get total number of calories burnt
     */
    func totalCaloriesBurnt() -> Int {
        var total = 0
        for workout in allWorkouts {
            total = total + Int(truncating: workout.calories ?? 0)
        }
        return total
    }
    
    /*
     MARK: - get average number of calores burnt
     */
    func averageCaloriesBurnt() -> Double {
        let total = totalCaloriesBurnt()
        let average = Double(total)/Double(allWorkouts.count)
        let roundedAverage = Double(round(average*100)/100)
        return roundedAverage
    }
    
    /*
     MARK: - get total number of exercise minutes
     */
    func totalExerciseMinutes() -> Int {
        var total = 0
        for workout in allWorkouts {
            total = total + Int(truncating: workout.duration ?? 0)
        }
        return total
    }
    
    /*
     MARK: - get average number of exercise minutes
     */
    func averageExerciseMinutes() -> Double {
        let total = totalCaloriesBurnt()
        let average = Double(total)/Double(allWorkouts.count)
        let roundedAverage = Double(round(average*100)/100)
        return roundedAverage
    }
    
    /*
     MARK: - get average number of calories consumed
     */
    func averageCaloriesConsumed() -> Double {
        var total = 0
        for meal in allMeals {
            total = total + Int(truncating: meal.calories ?? 0)
        }
        let average = Double(total)/Double(allMeals.count)
        let roundedAverage = Double(round(average*100)/100)
        return roundedAverage
    }
    
    /*
     MARK: - get most worked muscle category
     */
    func mostWorkedCategory() -> String {
        return ""
    }
    
    /*
     MARK: - get least worked muscle category
     */
    func leastWorkedCategory() -> String {
        return ""
    }

    /*
     MARK: - get total weight lost/gained
     */
    func totalWeightLoss() -> Double {
        let startWeight = allProgress[0].weight ?? 0
        let endWeight = allProgress[allProgress.count-1].weight ?? 0
        let weightLost = Double(truncating: endWeight) - Double(truncating: startWeight)
        let roundedWeightLost = Double(round(weightLost*100)/100)
        return roundedWeightLost
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview()
    }
}
