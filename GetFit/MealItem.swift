//
//  ParkItem.swift
//  NationalParks
//
//  Created by Osman Balci on 5/5/20.
//  Copyright © 2020 Osman Balci. All rights reserved.
//
 
import SwiftUI
 
struct MealItem: View {
   
    // ❎ Input parameter: CoreData ParkVisit Entity instance reference
    let meal: Meal
   
    // ❎ CoreData FetchRequest returning all ParkVisit entities in the database
    @FetchRequest(fetchRequest: Meal.allMealsFetchRequest()) var allMeals: FetchedResults<Meal>
   
    // ❎ Refresh this view upon notification that the managedObjectContext completed a save.
    // Upon refresh, @FetchRequest is re-executed fetching all ParkVisit entities with all the changes.
    @EnvironmentObject var userData: UserData
   
    var body: some View {
        HStack {
            // This function is given in PhotoImageFromBinaryData.swift
            if(meal.hasPhotoUrl == 0) {
                photoImageFromBinaryData(binaryData: meal.photo!, defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 100, maxWidth: 100, alignment: .center)
            }
            else {
                getImageFromUrl(url: meal.photoUrl!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 100, maxWidth: 100, alignment: .center)
            }
           
            VStack(alignment: .leading) {
                /*
                 ?? is called nil coalescing operator.
                 IF visit.fullName is not nil THEN
                 unwrap it and return its value
                 ELSE return ""
                 */
                Text(meal.category ?? "")
                MealTime(stringDate: meal.timeOfMeal ?? "")
                Text("\(meal.calories!) calories")
            }
                // Set font and size for the whole VStack content
                .font(.system(size: 14))
        }
    }
}
 
 
