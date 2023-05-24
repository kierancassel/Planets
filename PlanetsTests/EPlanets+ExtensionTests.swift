//
//  EPlanets+ExtensionTests.swift
//  PlanetsTests
//
//  Created by Kieran Cassel on 23/05/2023.
//

import XCTest
import CoreData
@testable import Planets

class EPlanetsExtensionTests: XCTestCase {
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
        let planets = Planets(count: nil, next: "test", previous: nil, results: nil)
        let ePlanets = EPlanets.create(planets: planets, context: testContext)
        XCTAssertEqual(ePlanets.next, "test")
    }

    func testEntityMapper() throws {
        let ePlanet = EPlanet(context: testContext)
        ePlanet.name = "TestPlanet"
        let planet = ePlanet.entityMapper()
        XCTAssertEqual(planet.name, "TestPlanet")
    }
}
