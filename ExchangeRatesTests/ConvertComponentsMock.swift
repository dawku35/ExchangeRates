//
//  ConvertComponentsMock.swift
//  ExchangeRatesTests
//
//  Created by Dawid Kunz on 13/09/2022.
//

import Foundation
@testable import ExchangeRates

class ConvertComponentsMock: ConvertComponents {
    var shouldFail: Bool?
    
    init(shouldFail: Bool){
        self.shouldFail = shouldFail
    }
    enum ConvertError: Error {
      case failed
      case failedToDecode
      case invalidStatusCode
    }
    
    func fetchConvert(to: String) async throws -> ConvertResponse {
        if(shouldFail==true){
            throw ConvertError.failed
        }
        guard let url = Bundle.main.url(forResource: "ConvertSuccessResponse", withExtension: "json") else {
            shouldFail = true
            throw ConvertError.failed
        }
        
        let data = try Data(contentsOf: url)
        
        guard let decodedData = try? JSONDecoder().decode(ConvertResponse.self, from: data) else {
            shouldFail = true
            throw ConvertError.failedToDecode
        }
        return decodedData
    }
}
