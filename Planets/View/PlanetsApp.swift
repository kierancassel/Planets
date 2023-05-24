//
//  PlanetsApp.swift
//  Planets
//
//  Created by Kieran Cassel on 13/05/2023.
//

import SwiftUI

@main
struct PlanetsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PlanetListView(viewModel: PlanetListViewModel(planetRepo: PlanetRepository(networkManager: NetworkManager())))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
