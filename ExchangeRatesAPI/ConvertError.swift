import Foundation

enum ConvertError: Error {
  case parsing(description: String)
  case network(description: String)
}
