//
//  DataButtonView.swift
//  SwiftUIAPOD
//
//  Created by Russell Archer on 30/03/2021.
//

import SwiftUI

struct DataButtonView: View {
    @Binding var showProgress: Bool
    @Binding var requestDate: Date
    @Binding var nImages: Double
    @Binding var apodModel: [ApodModel]
    @Binding var triggerNavigation: Bool
    
    var body: some View {
        Button(action: {
            showProgress = true
            
            let requestDateFormatter = DateFormatter()
            requestDateFormatter.dateFormat = "yyyy-MM-dd"
            let date = requestDateFormatter.string(from: requestDate as Date)
            
            NetworkHelper.requestApodData(date: date, count: Int(nImages)) { result in
                
                showProgress = false
                
                switch result {
                    case .failure(let error):
                        print("**** Error: \(error)")
                        
                    case .success(let data):
                        apodModel = data!
                        triggerNavigation = true
                }
            }
            
        }, label: {
            
            VStack {
                if showProgress {
                    ProgressView().padding()
                }
                
                Text("Get APOD Data")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(30)
                    .frame(width: 250, height: 100, alignment: .center)
                    .background(Color(.blue))
                    .cornerRadius(10)
            }
        })
    }
}

