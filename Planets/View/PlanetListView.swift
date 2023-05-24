//
//  PlanetListView.swift
//  Planets
//
//  Created by Kieran Cassel on 13/05/2023.
//

import SwiftUI
import CoreData

struct PlanetListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @StateObject var viewModel: PlanetListViewModel

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.planetResults) { result in
                    Text(result.name)
                }
            }
        }
        .task {
            await viewModel.getPlanets()
        }
    }

    struct PlanetListView_Previews: PreviewProvider {
        static var previews: some View {
            PlanetListView(viewModel: PlanetListViewModel(planetRepo: PlanetRepository(networkManager: NetworkManager())))
        }
    }
}
