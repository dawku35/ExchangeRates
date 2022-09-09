
import Foundation
import Combine

protocol ConvertFetchable {
  func ConvertFromEurTo(
    forTo to: String
  ) -> AnyPublisher<ConvertResponse, ConvertError>
}

class ConvertFetcher {
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
}

// MARK: - WeatherFetchable
extension ConvertFetcher: ConvertFetchable {
  func ConvertFromEurTo(
    forTo to: String
  ) -> AnyPublisher<ConvertResponse, ConvertError> {
    return Convert(with: makeConvertComponents(withTo: to))
  }

  private func Convert<T>(
    with components: URLComponents
  ) -> AnyPublisher<T, ConvertError> where T: Decodable {
    guard let url = components.url else {
      let error = ConvertError.network(description: "Couldn't create URL")
      return Fail(error: error).eraseToAnyPublisher()
    }
    return session.dataTaskPublisher(for: URLRequest(url: url))
      .mapError { error in
        .network(description: error.localizedDescription)
      }
      .flatMap() { pair in
        decode(pair.data)
      }
      .eraseToAnyPublisher()
  }
}

// MARK: - OpenWeatherMap API
private extension ConvertFetcher {
  struct OpenConvertAPI {
    static let scheme = "https"
    static let host = "api.apilayer.com"
    static let path = "/exchangerates_data"
    static let key = "2jiqgWRpA7vCaXRWn2kLN86HLiIHwUCo"
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
}
