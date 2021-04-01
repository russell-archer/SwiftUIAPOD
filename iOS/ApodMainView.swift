//
//  ApodMainView.swift
//  SwiftUIAPOD (iOS)
//
//  Created by Russell Archer on 27/03/2021.
//

import SwiftUI

struct ApodMainView: View {
    
    @State private var allowDateEdits = true  // If nImages > 1 the API won't allow you to specify date(s)
    @State private var requestDate = Date()
    @State private var nImages = 1.0
    @State private var triggerNavigation = false
    @State private var showAlert = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                TodayButtonView(allowDateEdits: $allowDateEdits, nImages: $nImages, requestDate: $requestDate)
                DatePickerView(requestDate: $requestDate, allowDateEdits: $allowDateEdits)
                ImageCountSliderView(nImages: $nImages, allowDateEdits: $allowDateEdits)
                
                Spacer()
                
                // Request the APOD data. When it arrives trigger programmatic navigation to the list view
                DataButtonView(requestDate: $requestDate, nImages: $nImages, triggerNavigation: $triggerNavigation, showAlert: $showAlert)
                
                NavigationLink(destination: ApodListView(), isActive: $triggerNavigation) {}
                .navigationBarTitle("NASA APOD")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Unable to get data for the selected date."), dismissButton: .default(Text("OK")))
        }
    }
}

struct ApodMainView_Previews: PreviewProvider {
    static var previews: some View {
        ApodMainView()
    }
}

