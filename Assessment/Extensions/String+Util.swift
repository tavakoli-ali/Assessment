
import Foundation

extension String {
    static func emptyIfNil(_ optionalString: String?) -> String {
        let text: String
        if let unwrapped = optionalString {
            text = unwrapped
        } else {
            text = ""
        }
        return text
    }
  static func sampleIfNil(_ optionalString: String?) -> String {
      let text: String
      if let unwrapped = optionalString {
          text = unwrapped
      } else {
          text = "description description description description description"
      }
      return text
  }
}
extension URL {
    static func emptyIfNil(_ optionalString: URL?) -> URL {
      let text: URL
        if let unwrapped = optionalString {
            text = unwrapped
             return text
        } else {
          guard  let text = URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg") else{
            fatalError("Base Url could not be configured")}
            return text
        }
    }
}
extension Int {
    static func emptyIfNil(_ optionalString: Int?) -> Int {
        let text: Int
        if let unwrapped = optionalString {
            text = unwrapped
        } else {
          text = 0
        }
        return text
    }
}
