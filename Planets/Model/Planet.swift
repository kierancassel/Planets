//
//  Result.swift
//  Planets
//
//  Created by Kieran Cassel on 23/05/2023.
//

import Foundation

struct Planet: Decodable, Equatable {
    let name: String
    let rotationPeriod, orbitalPeriod, diameter: String?
    let climate, gravity, terrain, surfaceWater: String?
    let population: String?
    let residents, films: [String]?
    let created, edited: String?
    let url: String?
}

extension Planet: Identifiable {
    var id: UUID {
        return UUID()
    }
}
