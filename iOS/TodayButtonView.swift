//
//  TodayButtonView.swift
//  SwiftUIAPOD (iOS)
//
//  Created by Russell Archer on 30/03/2021.
//

import SwiftUI

struct TodayButtonView: View {
    
    @Binding var allowDateEdits: Bool
    @Binding var nImages: Double
    @Binding var requestDate: Date
    
    var body: some View {
        
        Button("Today") {
            allowDateEdits = true
            nImages = 1.0
            requestDate = Date()
        }
        .padding(.top, 20)
    }
}
