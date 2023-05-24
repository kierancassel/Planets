//
//  NetworkManager.swift
//  Planets
//
//  Created by Kieran Cassel on 14/05/2023.
//

import Foundation

protocol Networkable {
    func request(url: URL) async throws -> Data
}

class NetworkManager: Networkable {
    func request(url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300) ~= httpResponse.statusCode else {
            throw NetworkManagerError.invalidServerResponse((response as? HTTPURLResponse)?.statusCode ?? 0)
        }
        return data
    }
}

enum NetworkManagerError: LocalizedError, Equatable {
    case invalidServerResponse(Int)

    var errorDescription: String {
        switch self {
        case .invalidServerResponse(let responseCode):
            return "Invalid response code: \(responseCode)"
        }
    }
}

