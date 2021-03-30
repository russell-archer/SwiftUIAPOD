//
//  ImageCountSliderView.swift
//  SwiftUIAPOD
//
//  Created by Russell Archer on 30/03/2021.
//

import SwiftUI

struct ImageCountSliderView: View {
    @Binding var nImages: Double
    @Binding var allowDateEdits: Bool
    
    var body: some View {
        
        let postfixText = nImages > 1.0 ? "images" : "image"
        Text("Will request \(String(Int(nImages))) \(postfixText)")
            .font(.subheadline)
        
        Slider(
            value: $nImages,
            in: 1...10,
            onEditingChanged: { editing in
                if editing { allowDateEdits = false }
                else { allowDateEdits = nImages > 1.0 ? false : true }
            },
            minimumValueLabel: Text("1"),
            maximumValueLabel: Text("10")
        ) {}
        .padding()
    }
}

