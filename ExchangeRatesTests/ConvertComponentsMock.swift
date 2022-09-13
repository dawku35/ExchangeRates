//
//  ConvertComponentsMock.swift
//  ExchangeRatesTests
//
//  Created by Dawid Kunz on 13/09/2022.
//

import Foundation
@testable import ExchangeRates

class ConvertComponentsMock: ConvertComponents {
    var shouldFail: Bool
    
    init(shouldFail: Bool){
        self.shouldFail = shouldFail
    }
    enum ConvertError: Error {
      case failed
      case failedToDecode
      case invalidStatusCode
    }
    
    func fetchConvert(to: String) async throws -> ConvertResponse {
        guard let url = Bundle.main.url(forResource: "ConvertSuccessResponse", withExtension: "json") else {
            fatalError("Could not find file json")
        }
        let configuration = URLSessionConfiguration.ephemeral
        
        let (data, response) = try await URLSession(configuration: configuration).data(from: url)
        
        guard let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode <= 299 else {
            throw ConvertError.invalidStatusCode
        }
        
        guard let decodedData = try? JSONDecoder().decode(ConvertResponse.self, from: data) else {
            shouldFail = true
            throw ConvertError.failedToDecode
        }
        return decodedData
    }
}
