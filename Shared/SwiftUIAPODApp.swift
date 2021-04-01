//
//  SwiftUIAPODApp.swift
//  Shared
//
//  Created by Russell Archer on 24/03/2021.
//

import SwiftUI

@main
struct SwiftUIAPODApp: App {
    @StateObject var repo = DataRepository()
    
    var body: some Scene {
        WindowGroup {
            ApodMainView()
                .environmentObject(repo)  // Make our APOD data repository available to the entire app
        }
    }
}
