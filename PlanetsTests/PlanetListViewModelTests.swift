//
//  PlanetListViewModelTests.swift
//  PlanetsTests
//
//  Created by Kieran Cassel on 23/05/2023.
//

import XCTest
import Combine
@testable import Planets

class PlanetListViewModelTests: XCTestCase {
    private var cancellableSet: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellableSet = []
    }

    override func tearDown() {
        cancellableSet = nil
        super.tearDown()
    }

    func test_getPlanets_whenRepoIsEmpty() {
        let planetRepo = MockPlanetRepository(shouldFetch: true)
        let viewModel = PlanetListViewModel(planetRepo: planetRepo)
        let expectation = expectation(description: "Fetch planets")
        viewModel.$planetResults
            .dropFirst()
            .sink { results in
                XCTAssertEqual(results, planetRepo.dummyResults)
                expectation.fulfill()
            }
            .store(in: &cancellableSet)
        Task {
            await viewModel.getPlanets()
        }
        waitForExpectations(timeout: 1)
    }

    func test_getPlanets_whenRepoIsNotEmpty() {
        let planetRepo = MockPlanetRepository(shouldFetch: false)
        let viewModel = PlanetListViewModel(planetRepo: planetRepo)
        let expectation = expectation(description: "Load planets from repo")
        viewModel.$planetResults
            .dropFirst()
            .sink { results in
                XCTAssertEqual(results, planetRepo.dummyResults)
                expectation.fulfill()
            }
            .store(in: &cancellableSet)
        Task {
            await viewModel.getPlanets()
        }
        waitForExpectations(timeout: 1)
    }
}
