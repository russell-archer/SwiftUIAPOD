//
//  ApodDetailView.swift
//  SwiftUIAPOD (iOS)
//
//  Created by Russell Archer on 28/03/2021.
//

import SwiftUI

struct ApodDetailView: View {
    
    var apodData: ApodModel
    
    var body: some View {
        
        VStack {
            Text(apodData.date)
                .font(.title2)
                .padding()
            
            Text(apodData.title)
                .font(.title2)
                .padding()
            
            if URL(string: apodData.hdurl) != nil {
                Link(destination: URL(string: apodData.hdurl)!) {
                    Image(uiImage: self.downloadImage(url: apodData.url))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .overlay(Rectangle()
                                    .stroke(Color.white, lineWidth: 4)
                                    .shadow(radius: 7)
                                    .padding())
                }
            } else {
                
                Text("Unable to load image")
                    .font(.title3)
                    .foregroundColor(.red)
                    .padding()
                
                Image("OwlSmall")
            }
            
            Text(apodData.explanation)
                .padding()
                .minimumScaleFactor(0.3)
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

struct ApodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        ApodDetailView(apodData: ApodModel(date: "2021-03-24",
                                           explanation: "Why does so much of Jupiter's lightning occur near its poles? Similar to Earth, Jupiter experiences both aurorae and lightning.",
                                           hdurl: "https://apod.nasa.gov/apod/image/2103/AuroraLightningJupiter_Juno_1629.jpg",
                                           mediaType: "image",
                                           serviceVersion: "v1",
                                           title: "Aurorae and Lightning on Jupiter",
                                           url: "https://apod.nasa.gov/apod/image/2103/AuroraLightningJupiter_Juno_1080.jpg"))
            .preferredColorScheme(.light)
    }
}
