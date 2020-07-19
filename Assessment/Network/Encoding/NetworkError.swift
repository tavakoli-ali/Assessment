
import Foundation

//
// MARK: - Network Error
//
enum NetworkError: Error {
  //
  // MARK: - Cases
  //
  case dateParseError
  case invalidPath
  case parseError
  case requestError
}
