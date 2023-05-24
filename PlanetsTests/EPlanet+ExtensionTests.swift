//
//  EPlanet+ExtensionTests.swift
//  PlanetsTests
//
//  Created by Kieran Cassel on 23/05/2023.
//

import XCTest
import CoreData
@testable import Planets

class EPlanetExtensionTests: XCTestCase {
    private var mockContainer: NSPersistentContainer!
    private var testContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockContainer = NSPersistentContainer(name: "Planets")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        mockContainer.persistentStoreDescriptions = [description]
        mockContainer.loadPersistentStores { description, error in
            XCTAssertNil(error)
        }
        testContext = mockContainer.viewContext
    }

    override func tearDownWithError() throws {
        testContext = nil
        mockContainer = nil
        try super.tearDownWithError()
    }

    func testCreate() throws {
        let planet = Planet(name: "TestPlanet", rotationPeriod: nil, orbitalPeriod: nil, diameter: nil, climate: nil, gravity: nil, terrain: nil, surfaceWater: nil, population: nil, residents: nil, films: nil, created: nil, edited: nil, url: nil)
        let ePlanet = EPlanet.create(result: planet, context: testContext)
        XCTAssertEqual(ePlanet.name, "TestPlanet")
    }

    func testEntityMapper() throws {
        let ePlanet = EPlanet(context: testContext)
        ePlanet.name = "TestPlanet"
        let planet = ePlanet.entityMapper()
        XCTAssertEqual(planet.name, "TestPlanet")
    }
}
