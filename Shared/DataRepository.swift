//
//  DataRepository.swift
//  SwiftUIAPOD
//
//  Created by Russell Archer on 01/04/2021.
//

import Foundation

class DataRepository: ObservableObject {
    
    @Published var data: [ApodModel] = []
}
