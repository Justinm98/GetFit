//
//  ParkDetails.swift
//  NationalParks
//
//  Created by Osman Balci on 10/24/20.
//  Copyright © 2020 Osman Balci. All rights reserved.
//

import SwiftUI
import MapKit
import AVFoundation

struct MealDetails: View {
    
    // ❎ Input parameter: CoreData ParkVisit Entity instance reference
    let meal: Meal
    
    // ❎ CoreData FetchRequest returning all ParkVisit entities in the database
    @FetchRequest(fetchRequest: Meal.allMealsFetchRequest()) var allMeals: FetchedResults<Meal>
    
    // ❎ Refresh this view upon notification that the managedObjectContext completed a save.
    // Upon refresh, @FetchRequest is re-executed fetching all ParkVisit entities with all the changes.
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        Form {
            /*
             ?? is called nil coalescing operator.
             IF visit.fullName is not nil THEN
             unwrap it and return its value
             ELSE return ""
             */
            Section(header: Text("Category")) {
                Text(meal.category ?? "")
            }
            Section(header: Text("Meal Photo")) {
                if(meal.hasPhotoUrl == 0) {
                photoImageFromBinaryData(binaryData: meal.photo!, defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
                }
                else {
                    getImageFromUrl(url: meal.photoUrl!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 300, maxWidth: 500, alignment: .center)
                }
            }
            Section(header: Text("Meal Contents")) {
                Text(meal.mealContents ?? "")
                    // Allow lines to wrap around
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
            }
            Section(header: Text("Calories")) {
                Text("\(meal.calories!) Cal")
            }
            Section(header: Text("Protein")) {
                Text("\(meal.nutrients!.protein!) grams" )
            }
            Section(header: Text("Fat")) {
                Text("\(meal.nutrients!.carbs!) grams" )
            }
            Section(header: Text("Carbs")) {
                Text("\(meal.nutrients!.fats!) grams" )
            }
        }   // End of Form
        .navigationBarTitle(Text("Meal Details"), displayMode: .inline)
        // Set font and size for the whole VStack content
        .font(.system(size: 14))
    }   // End of body
}
