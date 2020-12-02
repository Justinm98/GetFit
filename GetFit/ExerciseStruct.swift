//
//  ExerciseStruct.swift
//  DomsGitFit
//
//  Created by Dominic Gennello on 11/28/20.
//

import Foundation
 
struct ExerciseStruct: Hashable, Codable, Identifiable {
   
    var id: UUID
    var name: String
    var category: String
    var muscles: String
    var equipment: String
    var description: String
}

/*
 {
     change this
 }
 */
