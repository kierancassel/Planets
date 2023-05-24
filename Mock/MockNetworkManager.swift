//
//  MockNetworkManager.swift
//  PlanetsTests
//
//  Created by Kieran Cassel on 23/05/2023.
//

import Foundation
@testable import Planets

class MockNetworkManager: Networkable {
    var result: Result<Data, Error>?

    func request(url: URL) async throws -> Data {
        if case let .success(data) = result {
            return data
        } else if case let .failure(error) = result {
            throw error
        }
        throw NSError(domain: "", code: -1, userInfo: nil)
    }
}
