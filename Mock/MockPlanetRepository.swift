//
//  MockPlanetRepository.swift
//  PlanetsTests
//
//  Created by Kieran Cassel on 23/05/2023.
//

import Foundation
@testable import Planets

class MockPlanetRepository: Repository {
    var shouldFetch: Bool
    let dummyResults: [Planet]

    init(shouldFetch: Bool) {
        self.shouldFetch = shouldFetch
        self.dummyResults = [
            Planet(name: "Earth", rotationPeriod: nil, orbitalPeriod: nil, diameter: nil, climate: nil, gravity: nil, terrain: nil, surfaceWater: nil, population: nil, residents: nil, films: nil, created: nil, edited: nil, url: nil),
            Planet(name: "Mars", rotationPeriod: nil, orbitalPeriod: nil, diameter: nil, climate: nil, gravity: nil, terrain: nil, surfaceWater: nil, population: nil, residents: nil, films: nil, created: nil, edited: nil, url: nil)
        ]
    }

    func get() -> Planets? {
        return shouldFetch ? nil : Planets(count: nil, next: nil, previous: nil, results: dummyResults)
    }

    func fetch() async {
        self.shouldFetch = !shouldFetch
    }

    func store() async {

    }
}
