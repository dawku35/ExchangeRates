import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, ConvertError> {
  let decoder = JSONDecoder()

  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
      .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}
