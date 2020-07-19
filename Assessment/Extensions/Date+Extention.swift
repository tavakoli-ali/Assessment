import Foundation

extension Date{
  func toString() -> String {
 let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd"
    let now = df.string(from: self)
    return now
  }
}

extension String{
  func toDate() -> Date? {
    if self == ""
    { return Date()}
    let dateFormatter = DateFormatter()
         dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    // set locale to reliable US_POSIX
         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
         let date = dateFormatter.date(from:self)
    
    return date
  }
}
