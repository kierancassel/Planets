//
//  PlanetRepositoryTests.swift
//  PlanetsTests
//
//  Created by Kieran Cassel on 23/05/2023.
//

import XCTest
@testable import Planets

class PlanetRepositoryTests: XCTestCase {
    var planetRepository: PlanetRepository!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        planetRepository = PlanetRepository(networkManager: mockNetworkManager)
    }

    override func tearDown() {
        planetRepository = nil
        mockNetworkManager = nil
        super.tearDown()
    }

    func testGet() {
        let planets = planetRepository.get()
        XCTAssertNotNil(planets, "Failed to get planets")
    }

    func testFetch() async {
        mockNetworkManager.result = .success(Data("{\"count\": 1, \"next\": null, \"previous\": null, \"results\": [{\"name\": \"Tatooine\"}]}".utf8))
        await planetRepository.fetch()
        XCTAssertNotNil(planetRepository.get(), "Failed to fetch planets")
    }

    func testStore() async {
        mockNetworkManager.result = .success(Data("{\"count\": 1, \"next\": null, \"previous\": null, \"results\": [{\"name\": \"Tatooine\"}]}".utf8))
        await planetRepository.fetch()
        await planetRepository.store()
        let storedPlanets = planetRepository.get()
        XCTAssertNotNil(storedPlanets, "Failed to store planets")
    }
}
