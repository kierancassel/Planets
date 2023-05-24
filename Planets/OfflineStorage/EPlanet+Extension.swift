//
//  EPlanet+Extension.swift
//  Planets
//
//  Created by Kieran Cassel on 15/05/2023.
//

import Foundation
import CoreData

extension EPlanet {
    static func create(result: Planet, context: NSManagedObjectContext) -> EPlanet {
        let ePlanet = EPlanet(context: context)
        ePlanet.name = result.name
        return ePlanet
    }

    func entityMapper() -> Planet {
        return Planet(name: name ?? "", rotationPeriod: nil, orbitalPeriod: nil, diameter: nil, climate: nil, gravity: nil, terrain: nil, surfaceWater: nil, population: nil, residents: nil, films: nil, created: nil, edited: nil, url: nil)
    }
}


