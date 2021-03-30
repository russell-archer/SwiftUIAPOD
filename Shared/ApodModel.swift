//
//  ApodModel.swift
//  SwiftUIAPOD
//
//  Created by Russell Archer on 24/03/2021.
//

import Foundation

struct ApodModel: Codable, Identifiable {
    let id = UUID()
    let date: String
    let explanation: String
    let hdurl: String
    let mediaType: String
    let serviceVersion: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case date
        case explanation
        case hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title
        case url
    }
}

