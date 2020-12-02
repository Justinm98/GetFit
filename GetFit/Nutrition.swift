//
//  SearchCocktail.swift
//  Cocktails
//
//  Created by Justin Maloney on 10/04/20.
//  Copyright © 2020 Justin Maloney. All rights reserved.
//

import SwiftUI

struct Nutrition: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Image("SearchCocktails")
                            .frame(alignment: .center)
                            .padding()
                        
                        // Show REST Countries API provider's website in default web browser
                        
                        NavigationLink(destination: MealTracker()) {
                            HStack {
                                Image(systemName: "list.bullet")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                                    .foregroundColor(.blue)
                                    .frame(width: 60)
                                Text("Meal Tracker")
                                    .font(.headline)
                            }
                            .frame(minWidth: 300, maxWidth: 500, alignment: .leading)
                        }
                        .padding()
                        NavigationLink(destination: ScanFoodBarcode()) {
                            HStack {
                                Image(systemName: "barcode.viewfinder")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                                    .foregroundColor(.blue)
                                    .frame(width: 60)
                                Text("Find Food via Barcode")
                                    .font(.headline)
                            }
                            .frame(minWidth: 300, maxWidth: 500,  alignment: .leading)
                        }
                        .padding()
                        
                        NavigationLink(destination: EnterFoodBarcodeUPC()) {
                            HStack {
                                Image(systemName: "pencil.and.ellipsis.rectangle")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                                    .foregroundColor(.blue)
                                    .frame(width: 60)
                                Text("Find Food by entering barcode")
                                    .font(.headline)
                            }
                            .frame(minWidth: 300, maxWidth: 500,  alignment: .leading)
                        }
                        .padding()
                        
                        Text("Powered By")
                            .font(.headline)
                            .padding(.top, 30)
                            .padding(.horizontal, 30)
                        
                        // Show Nutritionix API provider's website in default web browser
                        Link(destination: URL(string: "https://www.nutritionix.com/business/api")!) {
                            Image("Nutritionix")
                                .renderingMode(.original)   // Keep the logo in its original form
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 37)
                                .padding(.horizontal, 30)
                        }
                    }   // End of VStack
                    .navigationBarTitle(Text("Nutrition"), displayMode: .inline)
                    .padding(50)
                }   // End of ScrollView
            }   // End of ZStack
        }   // End of NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct Nutrition_Previews: PreviewProvider {
    static var previews: some View {
        Nutrition()
    }
}


