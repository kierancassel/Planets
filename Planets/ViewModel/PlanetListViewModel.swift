//
//  PlanetListViewModel.swift
//  Planets
//
//  Created by Kieran Cassel on 14/05/2023.
//

import Foundation
import Combine

final class PlanetListViewModel: ObservableObject {
    private let planetRepo : Repository
    @Published var planetResults: [Planet] = []

    init(planetRepo: Repository) {
        self.planetRepo = planetRepo
    }

    func getPlanets() async {
        if let results = planetRepo.get()?.results {
            DispatchQueue.main.async {
                self.planetResults = results
            }
        } else {
            await planetRepo.fetch()
            DispatchQueue.main.async {
                self.planetResults = self.planetRepo.get()?.results ?? []
            }
            await planetRepo.store()
        }
    }
}
