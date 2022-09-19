//
//  ConvertComponents.swift
//  ExchangeRates
//
//  Created by Dawid Kunz on 09/09/2022.
//

import Foundation

protocol ConvertComponents{
    func fetchLatest(base: String) async throws -> Latest
}

class ConvertComponentsImpl: ConvertComponents {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
      self.session = session
    }
    
    struct OpenConvertAPI {
        static let scheme = "https"
        static let host = "api.apilayer.com"
        static let path = "/exchangerates_data"
        static let key = "GbWUy6k8jdhOAszvPXCA4CsP1dKpdASN"
    }
    
    enum ConvertError: Error {
      case failed
      case failedToDecode
      case invalidStatusCode
    }
    
    func makeLatestComponents(withTo base: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenConvertAPI.scheme
        components.host = OpenConvertAPI.host
        components.path = OpenConvertAPI.path + "/latest"
        var symbols = ["PLN", "GBP", "EUR", "JPY", "USD"]
        
        if let index = symbols.firstIndex(of: base) {
            symbols.remove(at: index)
        }
        let symbolsString = symbols.joined(separator: ", ")
        
        components.queryItems = [
          URLQueryItem(name: "base", value: base),
          URLQueryItem(name: "symbols", value: symbolsString),
          URLQueryItem(name: "apikey", value: OpenConvertAPI.key)
        ]
        return components
      }
  
    func fetchLatest(base: String) async throws -> Latest {
        let url = makeLatestComponents(withTo: base).url
        let configuration = URLSessionConfiguration.ephemeral
        
        let (data, response) = try await URLSession(configuration: configuration).data(from: url!)
        
        guard let response = response as? HTTPURLResponse else {
            throw ConvertError.invalidStatusCode
        }
        print("HTTP status code \(response.statusCode)")
        guard response.statusCode >= 200 && response.statusCode <= 299 else {
            throw ConvertError.invalidStatusCode
        }
        
        let decodedData = try JSONDecoder().decode(Latest.self, from: data)
        return decodedData
    }
}
