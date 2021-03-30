//
//  ApodListView.swift
//  SwiftUIAPOD (iOS)
//
//  Created by Russell Archer on 28/03/2021.
//

import SwiftUI

struct ApodListView: View {
    
    @State var apodModel: [ApodModel] = []
    
    var body: some View {
        
        VStack {
            
            List(apodModel) { apodItem in
                
                // Because we aren't embedding this NavigationLink in a NavigationView
                // we use our parent's (ApodMainView) NavigationView. This avoids the
                // issue of multiple navigation stacks
                NavigationLink(destination: ApodDetailView(apodData: apodItem)) {
                    Text(apodItem.date)
                        .font(.subheadline)
                        .padding()
                    
                    Text(apodItem.title)
                        .minimumScaleFactor(0.2)
                        .padding()
                    
                    Image(uiImage: self.downloadImage(url: apodItem.url))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(7)
                        .padding()
                }
            }
            .navigationTitle("APOD Search Results")
        }
    }
    
    /// Helper function that returns a UIImage from a URL. If the URL is invalid a default image is returned.
    /// - Parameter url: URL of an image
    fileprivate func downloadImage(url: String) -> UIImage {
        if let imageUrl = URL(string: url), let imageData = try? Data(contentsOf: imageUrl) {
            return UIImage(data: imageData)!
        }
        
        return UIImage(named: "OwlSmall")!  // Return a default image
    }
}

struct ApodListView_Previews: PreviewProvider {
    static var previews: some View {
        ApodListView(apodModel: [ApodModel(date: "2021-03-24",
                                           explanation: "Why does so much of Jupiter's lightning occur near its poles? Similar to Earth, Jupiter experiences both aurorae and lightning.",
                                           hdurl: "https://apod.nasa.gov/apod/image/2103/AuroraLightningJupiter_Juno_1629.jpg",
                                           mediaType: "image",
                                           serviceVersion: "v1",
                                           title: "Aurorae and Lightning on Jupiter",
                                           url: "https://apod.nasa.gov/apod/image/2103/AuroraLightningJupiter_Juno_1080.jpg")])
    }
}
