//
//  NationalParkStruct.swift
//  NationalParks
//
//  Created by Osman Balci on 5/31/20.
//  Copyright © 2020 Osman Balci. All rights reserved.
//
 
import Foundation
 
// Used only for API search results
struct ProgressData: Codable {
 
    var date: String
    var weight: Double
    var photoFileName: String
    var photoUrl: String
    var hasPhotoUrl: Int
}
 
 
