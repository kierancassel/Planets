//
//  PlanetRepository.swift
//  Planets
//
//  Created by Kieran Cassel on 14/05/2023.
//

import Foundation
import Combine
import CoreData

protocol Repository {
    func get() -> Planets?
    func fetch() async
    func store() async
}

class PlanetRepository: Repository {
    private let networkManager: Networkable
    private var planets: Planets?
    private var context = PersistenceController.shared.container.viewContext

    init(networkManager: Networkable) {
        self.networkManager = networkManager
    }

    func get() -> Planets? {
        planets = planets ?? EPlanets.read(context: context).first?.entityMapper()
        return planets
    }

    func fetch() async {
        let url = URL(string: "https://swapi.dev/api/planets/?format=json")!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let data = try await networkManager.request(url: url)
            let response = try decoder.decode(Planets.self, from: data)
            self.planets = response
        } catch {
            print(error)
        }
    }

    func store() async {
        if let planets {
            await EPlanets.create(planets: planets, context: context)
        }
        PersistenceController.shared.save()
    }
}
