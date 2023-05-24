//
//  Planets.swift
//  Planets
//
//  Created by Kieran Cassel on 14/05/2023.
//

import Foundation

struct Planets: Decodable, Equatable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Planet]?
}
