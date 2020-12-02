//
//  FoodStruct.swift
//  BarcodeScanner
//
//  Created by Osman Balci on 5/26/20.
//  Copyright © 2020 Osman Balci. All rights reserved.
//
 
import Foundation
 
struct FoodStruct: Hashable {
   
    var brandName: String
    var foodName: String
    var imageUrl: String
    var ingredients: String
    var calories: String
    var dietaryFiber: String        // in grams
    var protein: String             // in grams
    var saturatedFat: String        // in grams
    var sodium: String              // in milligrams
    var sugars: String              // in grams
    var totalCarbohydrate: String   // in grams
    var totalFat: String            // in grams
    var servingQuantity: String
    var servingUnit: String
    var servingWeight: String       // in grams
   
}
 
