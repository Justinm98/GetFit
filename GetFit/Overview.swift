//
//  Overview.swift
//  GetFit
//
//  Created by CS3714 on 11/22/20.
//

import SwiftUI
import PDFKit
import Foundation

struct Overview: View {
    
    @FetchRequest(fetchRequest: Workout.allWorkoutsFetchRequest()) var allWorkouts: FetchedResults<Workout>
    
    @FetchRequest(fetchRequest: Meal.allMealsFetchRequest()) var allMeals: FetchedResults<Meal>
    
    @FetchRequest(fetchRequest: Progress.allProgressFetchRequest()) var allProgress: FetchedResults<Progress>
    
    @State private var categories = ["Abs":0, "Arms":0, "Back":0, "Calves":0, "Chest":0, "Legs":0, "Shoulders":0]
    
    var body: some View {
        ZStack {
            activityViewController
        NavigationView {
        Form {
            Section(header: Text("Average Calories Burnt Per Workout")) {
                let formatAveCalories = String(format: "%.1f", averageCaloriesBurnt())
                if totalWorkouts() != 0 {
                    Text("\(formatAveCalories) cal with \(totalWorkouts()) workouts")
                } else {
                    Text("No workout completed yet")
                }
            }
            Section(header: Text("Total Calories Burnt")) {
                Text("\(totalCaloriesBurnt()) cal")
            }
            Section(header: Text("Average Minutes Exercised Per Workout")) {
                let formatAveMinutes = String(format: "%.1f", averageExerciseMinutes())
                if totalWorkouts() != 0 {
                    Text("\(formatAveMinutes) min with \(totalWorkouts()) workouts")
                } else {
                    Text("No workout completed yet")
                }
            }
            Section(header: Text("Total Minutes Excercised")) {
                Text("\(totalExerciseMinutes()) min")
            }
            Section(header: Text("Number of Workouts per each muscle category")) {
                let categoryCount = updateWorkoutCategoryArray()
                VStack(alignment: .leading) {
                    Text("Abs: \(categoryCount[0])")
                    Text("Arms: \(categoryCount[1])")
                    Text("Back: \(categoryCount[2])")
                    Text("Calves: \(categoryCount[3])")
                    Text("Chest: \(categoryCount[4])")
                    Text("Legs: \(categoryCount[5])")
                    Text("Shoulders: \(categoryCount[6])")
                }
            }
            Section(header: Text("Total weight loss/gain")) {
                if (totalWeightLoss() < 0) {
                    let weightGained = -1*totalWeightLoss()
                    let formatWeightGained = String(format: "%.1f", weightGained)
                    Text("\(formatWeightGained) lbs gained")
                }
                else {
                    let weightLost = totalWeightLoss()
                    let formatWeightLost = String(format: "%.2f", weightLost)
                    Text("\(formatWeightLost) lbs lost")
                }
            }
            Section(header: Text("Average Calories Consumed Per Meal")) {
                let caloriesConsumed = averageCaloriesConsumed()
                let formatCaloriesConsumed = String(format: "%.1f", caloriesConsumed)
                Text("\(formatCaloriesConsumed) cal with \(allMeals.count) meals")
            }
        } // end of Form
        .font(.system(size: 14))
        .navigationBarTitle(Text("Overview"))
        .navigationBarItems(trailing:
            Button(action: {
                // Display the Share interface to Share uiImageOfQRBarcode
                activityViewController.sharePDF(pdfData: generatePDF())
            }) {
                Image(systemName:"square.and.arrow.up")
                    .imageScale(.medium)
                    .font(Font.title.weight(.regular))
                    .foregroundColor(.blue)
            })
        }
        }
    } // end of body
    
    func totalWorkouts() -> Int {
        var total = 0;
        for workout in allWorkouts {
            total = total + Int(truncating: workout.timesDone ?? 0)
        }
        return total
    }
    /*
     MARK: - get total number of calories burnt
     */
    func totalCaloriesBurnt() -> Int {
        var total = 0
        for workout in allWorkouts {
            total = total + (Int(truncating: workout.calories ?? 0) * Int(truncating: workout.timesDone ?? 0))
        }
        return total
    }
    
    /*
     MARK: - get average number of calores burnt
     */
    func averageCaloriesBurnt() -> Double {
        let total = totalCaloriesBurnt()
        let average = Double(total)/Double(totalWorkouts())
        
        return average
    }
    
    /*
     MARK: - get total number of exercise minutes
     */
    func totalExerciseMinutes() -> Int {
        var total = 0
        for workout in allWorkouts {
            total = total + (Int(truncating: workout.duration ?? 0) * Int(truncating: workout.timesDone ?? 0))
        }
        return total
    }
    
    /*
     MARK: - get average number of exercise minutes
     */
    func averageExerciseMinutes() -> Double {
        let total = totalExerciseMinutes()
        let average = Double(total)/Double(totalWorkouts())
        return average
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
        return average
    }
    
    /*
     MARK: - get number of occurances of each workout category
     */
    func updateWorkoutCategoryArray() -> [Int] {
        var categoryCount = [0, 0, 0, 0, 0, 0, 0]
        for workout in allWorkouts {
            
            if workout.category == "Abs" {
                categoryCount[0] += Int(truncating: workout.timesDone ?? 0)
            }
            if workout.category == "Arms" {
                categoryCount[1] += Int(truncating: workout.timesDone ?? 0)
            }
            if workout.category == "Back" {
                categoryCount[2] += Int(truncating: workout.timesDone ?? 0)
            }
            if workout.category == "Calves" {
                categoryCount[3] += Int(truncating: workout.timesDone ?? 0)
            }
            if workout.category == "Chest" {
                categoryCount[4] += Int(truncating: workout.timesDone ?? 0)
            }
            if workout.category == "Legs" {
                categoryCount[5] += Int(truncating: workout.timesDone ?? 0)
            }
            if workout.category == "Shoulders" {
                categoryCount[6] += Int(truncating: workout.timesDone ?? 0)
            }
        }
        return categoryCount
    }

    /*
     MARK: - get total weight lost/gained
     */
    func totalWeightLoss() -> Double {
        let startWeight = allProgress[0].weight ?? 0
        let endWeight = allProgress[allProgress.count-1].weight ?? 0
        let weightLost = Double(truncating: startWeight) - Double(truncating: endWeight)
        return weightLost
    }
    
    func generatePDF() -> Data {
        //create metadata and initialize format
        let format = UIGraphicsPDFRendererFormat()
        let metaData = [
            kCGPDFContextTitle: "Fitness Summary",
            kCGPDFContextAuthor: "CS3714 Team 1"
          ]
        format.documentInfo = metaData as [String: Any]
        
        //create dimensions (standard letter: 8.5in x 11in, dpi: 72)
        let pageWidth = Int(8.5 * 72)
        let pageHeight = 11 * 72
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        //create our renderer
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        let data = renderer.pdfData { (context) in
            context.beginPage()
            let attributes = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
              ]
            var text = "Average Calories Burned per Workout: \(totalWorkouts() != 0 ? "\(averageCaloriesBurnt()) cal" : "No workout completed")"
            var textRect = CGRect(x: 100, // left margin
                                    y: 100, // top margin
                                width: pageWidth,
                               height: 20)
            text.draw(in: textRect, withAttributes: attributes)
            text = "Total Calories Burnt: \(totalCaloriesBurnt()) cal"
            textRect = CGRect(x: 100, y: 120, width: pageWidth, height: 20);
            text.draw(in: textRect, withAttributes: attributes)
            text = "Average Minutes Exercised per Workout: \(totalWorkouts() != 0 ?  "\(averageExerciseMinutes())" : "No Workout Completed")"
            textRect = CGRect(x: 100, y: 140, width: pageWidth, height: 20);
            text.draw(in: textRect, withAttributes: attributes)
            text = "Total Minutes Exercised: \(totalExerciseMinutes()) min"
            textRect = CGRect(x: 100, y: 160, width: pageWidth, height: 20);
            text.draw(in: textRect, withAttributes: attributes)
            text = "Number of Workouts per each Muscle Category\n\tAbs: \(categories["Abs"] ?? 0)\n\tArms: \(categories["Arms"] ?? 0)\n\tBack: \(categories["Back"] ?? 0)\n\tCalves: \(categories["Calves"] ?? 0)\n\tChest: \(categories["Chest"] ?? 0)\n\tLegs: \(categories["Legs"] ?? 0)\n\tShoulders: \(categories["Shoulders"] ?? 0)"
            textRect = CGRect(x: 100, y: 180, width: pageWidth, height: 160);
            text.draw(in: textRect, withAttributes: attributes)
            let weightChange = totalWeightLoss()
            var descrWeightChange = ""
            if weightChange < 0 {
                descrWeightChange = "lost"
            }
            else if weightChange > 0 {
                descrWeightChange = "gained"
            }
            text = "Total Weight Loss/Gain: \(weightChange) lbs \(descrWeightChange)"
            textRect = CGRect(x: 100, y: 340, width: pageWidth, height: 20);
            text.draw(in: textRect, withAttributes: attributes)
            text = "Average Calories Consumed per Meal: \(averageCaloriesConsumed()) with \(allMeals.count)"
            textRect = CGRect(x: 100, y: 360, width: pageWidth, height: 20);
            text.draw(in: textRect, withAttributes: attributes)
            
            let temp = ProgressTab()
            let chartURL = URL(string: "https://image-charts.com/chart?chtt=Weight+Loss+Progress&cht=lc&chg=20,50,1,1,333333&chd=a:\(temp.getProgressDataString())&chm=o,ff0000,0,-1,8.0&chs=350x150&chxt=y&chma=0,5,0,0")
            let chartData = try! Data(contentsOf: chartURL!)
            var image = UIImage(data: chartData)!
            var nextTop = addImage(pageRect: pageRect, imageTop: 400, image: image)
            
            text = "Progress Photo Overview on Next Page"
            textRect = CGRect(x: 100, y: Int(nextTop), width: pageWidth, height: 20);
            text.draw(in: textRect, withAttributes: attributes)
            
            context.beginPage()
            if (allProgress.count > 0) {
                if allProgress[0].hasPhotoUrl == 1 {
                    image = UIImage(named: allProgress[0].photoUrl ?? "ImageUnavailable")!
                }
                else {
                    image = UIImage(data: allProgress[0].photo!)!
                }
                nextTop = addImage(pageRect: pageRect, imageTop: 0, image: image)
                if (allProgress.count > 1) {
                    let last = allProgress.count - 1
                    if allProgress[last].hasPhotoUrl == 1 {
                        image = UIImage(named: allProgress[last].photoUrl ?? "ImageUnavailable")!
                    }
                    else {
                        image = UIImage(data: allProgress[last].photo!)!
                    }
                    _ = addImage(pageRect: pageRect, imageTop: nextTop, image: image)
                }
            }
        }
        return data
    }
    
    func addImage(pageRect: CGRect, imageTop: CGFloat, image: UIImage) -> CGFloat {
        
      // 1
      let maxHeight = pageRect.height * 0.4
      let maxWidth = pageRect.width * 0.8
      // 2
      let aspectWidth = maxWidth / image.size.width
      let aspectHeight = maxHeight / image.size.height
      let aspectRatio = min(aspectWidth, aspectHeight)
      // 3
      let scaledWidth = image.size.width * aspectRatio
      let scaledHeight = image.size.height * aspectRatio
      // 4
      let imageX = (pageRect.width - scaledWidth) / 2.0
      let imageRect = CGRect(x: imageX, y: imageTop,
                             width: scaledWidth, height: scaledHeight)
      // 5
      image.draw(in: imageRect)
      return imageRect.origin.y + imageRect.size.height
    }

}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview()
    }
}
