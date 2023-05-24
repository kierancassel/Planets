//
//  EPlanets+Extension.swift
//  Planets
//
//  Created by Kieran Cassel on 15/05/2023.
//

import Foundation
import CoreData

extension EPlanets {
    static func create(planets: Planets, context: NSManagedObjectContext) -> EPlanets {
        let ePlanets = EPlanets(context: context)
        if let count = planets.count { ePlanets.count = Int16(count) }
        ePlanets.next = planets.next
        ePlanets.previous = planets.previous
        planets.results?.forEach {
            let ePlanet = EPlanet.create(result: $0, context: context)
            ePlanets.addToEPlanet(ePlanet)
        }
        return ePlanets
    }

    static func read(context: NSManagedObjectContext) -> [EPlanets] {
        let request = EPlanets.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }

    func entityMapper() -> Planets {
        var results: [Planet] = []
        ePlanet?.forEach { result in
            if let result = result as? EPlanet {
                results.append(result.entityMapper())
            }
        }
        return Planets(count: Int(count), next: next, previous: previous, results: results)
//        return Planets(count: Int(count), next: next, previous: "", results: results)
    }
}
