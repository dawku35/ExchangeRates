//
//  ConvertComponents.swift
//  ExchangeRates
//
//  Created by Dawid Kunz on 09/09/2022.
//

import Foundation

class ConvertComponents {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
      self.session = session
    }
    
  struct OpenConvertAPI {
    static let scheme = "https"
    static let host = "api.apilayer.com"
    static let path = "/exchangerates_data"
    static let key = "2jiqgWRpA7vCaXRWn2kLN86HLiIHwUCo"
  }
    
    enum ConvertError: Error {
      case failed
      case failedToDecode
      case invalidStatusCode
    }
    
  func makeConvertComponents(
    withTo to: String
  ) -> URLComponents {
    var components = URLComponents()
    components.scheme = OpenConvertAPI.scheme
    components.host = OpenConvertAPI.host
    components.path = OpenConvertAPI.path + "/convert"
    
    components.queryItems = [
      URLQueryItem(name: "to", value: to),
      URLQueryItem(name: "from", value: "EUR"),
      URLQueryItem(name: "amount", value: "1"),
      URLQueryItem(name: "apikey", value: OpenConvertAPI.key)
    ]
    return components
  }
  
    func fetchConvert(to: String) async throws -> ConvertResponse {
        
        let url = makeConvertComponents(withTo: to).url
        let configuration = URLSessionConfiguration.ephemeral
        
        let (data, response) = try await URLSession(configuration: configuration).data(from: url!)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode <= 299 else {
            throw ConvertError.invalidStatusCode
        }
        
        let decodedData = try JSONDecoder().decode(ConvertResponse.self, from: data)
        return decodedData
    }
    
    
}
