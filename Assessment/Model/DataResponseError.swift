

import Foundation

enum DataResponseError: Error {
  case network
  case decoding
  case endofData
  var reason: String {
    switch self {
    case .network:
      return "An error occurred while fetching data ".localizedString
    case .decoding:
      return "An error occurred while decoding data".localizedString
      case .endofData:
        return "end of Array Data".localizedString
    }
  }
}
