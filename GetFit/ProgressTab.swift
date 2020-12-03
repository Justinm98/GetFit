//
//  Countries.swift
//  TravelGuide
//
//  Created by Osman Balci on 7/4/20.
//  Copyright © 2020 Osman Balci. All rights reserved.
//

import SwiftUI
import WebKit

struct ProgressTab : View {
    
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // ❎ CoreData FetchRequest returning all ParkVisit entities in the database
    @FetchRequest(fetchRequest: Progress.allProgressFetchRequest()) var allProgress: FetchedResults<Progress>
    
    // Fit as many photos per row as possible with minimum image width of 100 points each.
    // spacing defines spacing between columns
    let columns = [ GridItem(.adaptive(minimum: 100), spacing: 5) ]
    
    @State private var showProgressInfoAlert = false
    @State private var selectedPhoto = Progress()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Color the background to light gray
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                VStack {
                    getImageFromUrl(url: "https://image-charts.com/chart?chtt=Weight+Loss+Progress&cht=lc&chg=20,50,1,1,333333&chd=a:\(getProgressDataString())&chm=o,ff0000,0,-1,8.0&chs=350x150&chxt=y&chma=0,5,0,0")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Divider()
                    ScrollView {
                        // spacing defines spacing between rows
                        LazyVGrid(columns: columns, spacing: 3) {
                            // 🔴 Specifying id: \.self is critically important to prevent photos being listed as out of order
                            ForEach(allProgress) { progress in
                                // Public function getImageFromUrl is given in UtilityFunctions.swift
                                if(progress.hasPhotoUrl == 0) {
                                    photoImageFromBinaryData(binaryData: progress.photo!, defaultFilename: "ImageUnavailable")
                                        .resizable()
                                        .scaledToFit()
                                        .onTapGesture {
                                            selectedPhoto = progress
                                            self.showProgressInfoAlert = true
                                        }
                                }
                                else {
                                    getImageFromUrl(url: progress.photoUrl!)
                                        .resizable()
                                        .scaledToFit()
                                        .onTapGesture {
                                            selectedPhoto = progress
                                            self.showProgressInfoAlert = true
                                        }
                                }
                            }
                        }   // End of LazyVGrid
                        .padding()
                        
                    }   // End of ScrollView
                    .alert(isPresented: $showProgressInfoAlert, content: { self.progressInfoAlert })
                }   // End of VStack
            }   // End of ZStack
            .navigationBarTitle(Text("Progress"), displayMode: .inline)
            // Place the Edit button on left and Add (+) button on right of the navigation bar
            .navigationBarItems(trailing:
                                    NavigationLink(destination: AddProgress()) {
                                        Image(systemName: "plus")
                                    })
            
        }
        .customNavigationViewStyle()
        
        
    }
    
    var progressInfoAlert: Alert {
        Alert(title: Text(selectedPhoto.date!),
                  message: Text("Weight: \(selectedPhoto.weight!)"),
                  dismissButton: .default(Text("OK")) )
        }
    
    func getProgressDataString() -> String {
        
        var dataStringArray = [Double]()
        
        for aProgress in allProgress {
            dataStringArray.append(Double(truncating: aProgress.weight!))
        }
        
        var dataParam = ""
        
        if(dataStringArray.count == 0){
            return dataParam
        }
        if(dataStringArray.count <= 30){
            var count = 0
            for _ in dataStringArray {
                
                if(count < dataStringArray.count - 1){
                    dataParam = dataParam + "\(dataStringArray[count]),"
                }
                else {
                    dataParam = dataParam + "\(dataStringArray[count])"
                    break
                }
                count += 1
            }
        }
        else {
            var count = dataStringArray.count - 30
            for _ in dataStringArray {
                
                if(count < dataStringArray.count - 1){
                    dataParam = dataParam + "\(dataStringArray[count]),"
                }
                else {
                    dataParam = dataParam + "\(dataStringArray[count])"
                    break
                }
                count += 1
            }
        }
        
        print(dataParam)
        return dataParam
    }
    
    
}

struct ProgressTab_Previews: PreviewProvider {
    static var previews: some View {
        ProgressTab()
    }
}

