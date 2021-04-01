//
//  DataButtonView.swift
//  SwiftUIAPOD
//
//  Created by Russell Archer on 30/03/2021.
//

import SwiftUI

struct DataButtonView: View {
    @State private var showProgress = false
    
    @Binding var requestDate: Date
    @Binding var nImages: Double
    @Binding var triggerNavigation: Bool
    @Binding var showAlert: Bool
    
    @EnvironmentObject var repo: DataRepository
    
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
                        print("Networkhelper error: \(error)")
                        showAlert = true
                        
                    case .success(let data):
                        repo.data = data!
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

