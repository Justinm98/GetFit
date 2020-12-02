//
//  EnterFoodBarcodeUPC.swift
//  BarcodeScanner
//
//  Created by Osman Balci on 5/26/20.
//  Copyright © 2020 Osman Balci. All rights reserved.
//
 
import SwiftUI
 
struct EnterFoodBarcodeUPC: View {
       
    @State private var upcTextFieldValue = ""
    @State private var upcEntered = ""
   
    var body: some View {
        VStack {
            HStack {
                Text("UPC: ")
               
                TextField("Enter Food UPC", text: $upcTextFieldValue,
                    onCommit: {
                        self.upcEntered = self.upcTextFieldValue
                    })
                    .font(.subheadline)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.default)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
               
                // Button to clear the text field
                Button(action: {
                    self.upcTextFieldValue = ""
                    self.upcEntered = ""
                }) {
                    Image(systemName: "clear")
                        .imageScale(.medium)
                        .font(Font.title.weight(.regular))
                }
            }   // End of HStack
            .padding(.horizontal)
            .frame(minWidth: 300, maxWidth: 500, alignment: .center)
 
            if !upcEntered.isEmpty {
                NavigationLink(destination: foodItemNutritionDetails) {
                    HStack {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.blue)
                            .imageScale(.large)
                            .font(Font.title.weight(.regular))
                        Text("Show Nutrition Details")
                            .font(.system(size: 16))
                    }
                }
                .padding()
            }
        }   // End of VStack
        .navigationBarTitle(Text("UPC Lookup"), displayMode: .inline)
    }
   
    var foodItemNutritionDetails: some View {
       
        // Public function getNutritionDataFromApi is given in NutritionixApiData.swift
        getNutritionDataFromApi(upc: self.upcEntered)
       
        if foodItem.foodName.isEmpty {
            return AnyView(NoNutritionData(upc: self.upcEntered))
        }
 
        return AnyView(
            FoodNutritionDetails(barcode: self.$upcEntered)
                .onDisappear() {
                    self.upcTextFieldValue = ""
            }
        )
    }
   
}
 
struct EnterFoodBarcodeUPC_Previews: PreviewProvider {
    static var previews: some View {
        EnterFoodBarcodeUPC()
    }
}
 
