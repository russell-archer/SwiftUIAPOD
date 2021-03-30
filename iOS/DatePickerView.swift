//
//  DatePickerView.swift
//  SwiftUIAPOD
//
//  Created by Russell Archer on 28/03/2021.
//

import SwiftUI

struct DatePickerView: View {
    
    @Binding var requestDate: Date
    @Binding var allowDateEdits: Bool
    
    var body: some View {
        
            DatePicker("", selection: $requestDate, in: ...Date(), displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .disabled(!allowDateEdits)
                .font(.title3)
                .padding()
    }
}

