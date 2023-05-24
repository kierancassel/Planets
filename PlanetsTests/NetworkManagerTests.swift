//
//  NetworkManagerTests.swift
//  PlanetsTests
//
//  Created by Kieran Cassel on 23/05/2023.
//

import XCTest
@testable import Planets

class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!

    override func setUp()  {
        super.setUp()
        networkManager = NetworkManager()
    }

    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }

    func testRequest_ValidURL_ReturnsData() async throws {
        let url = URL(string: "https://swapi.dev/api/planets")!
        let data = try await networkManager.request(url: url)
        XCTAssertNotNil(data, "Data returned is not nil")
    }

    func testRequest_InvalidURL_ThrowsError() async {
        let url = URL(string: "https://swapi.dev/404")!
        do {
            _ = try await networkManager.request(url: url)
            XCTFail("Expected error to be thrown, but no error was thrown")
        } catch {
            XCTAssertTrue(error is NetworkManagerError, "Error thrown is of type NetworkManagerError")
            if let networkError = error as? NetworkManagerError {
                XCTAssertEqual(networkError, NetworkManagerError.invalidServerResponse(404))
            }
        }
    }
}
