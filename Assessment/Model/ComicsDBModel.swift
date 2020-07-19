

import Foundation
import CoreData

class ComicsDBModel: NSManagedObject {
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl
        case title
        case desc
        case date
        case charachterId
    }
    // MARK: - Core Data Managed Object
    @NSManaged var id: Int
    @NSManaged var imageUrl: URL?
    @NSManaged var title: String?
    @NSManaged var desc: String?
    @NSManaged var date: String?
    @NSManaged var charachterId: Int
    @NSManaged public var of_char: NSSet?

    // MARK: - Decodable
    required convenience init(imageUrl : String? ,title : String?,id : Int,desc : String?,date : String? ,charachterId : Int, insertIntoManagedObjectContext context: NSManagedObjectContext!){
        _ = CodingUserInfoKey.managedObjectContext
    //            let managedObjectContext = NSManagedObjectContext()
      guard  let entity = NSEntityDescription.entity(forEntityName: "ComicsDBModel", in: context) else { self.init()
        return}
          

        self.init(entity: entity, insertInto: context)
        self.imageUrl = URL(string: String.emptyIfNil(imageUrl))
      self.title = title!.replacingOccurrences(of: "#", with: " ")
      self.desc = desc
      self.date = date
      self.charachterId = charachterId
        self.id = id
        }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(title, forKey: .title)
      try container.encode(date, forKey: .date)
         try container.encode(id, forKey: .id)
        try container.encode(charachterId, forKey: .charachterId)
    }
}

extension ComicsDBModel{
  
  @nonobjc public class func fetchRequest(charachterId: Int) -> NSFetchRequest<ComicsDBModel> {
    let fetchRequest = NSFetchRequest<ComicsDBModel>(entityName: "ComicsDBModel")
     fetchRequest.predicate = NSPredicate(format: "charachterId == \(charachterId)")
   return fetchRequest
}
}
