

import Foundation
import CoreData

class CharachterDBModel: NSManagedObject {
    enum CodingKeys: String, CodingKey {
        case imageUrl
        case name
        case id
    }

    // MARK: - Core Data Managed Object
    @NSManaged var imageUrl: URL?
    @NSManaged var name: String?
    @NSManaged var id: Int
//    @NSManaged public var of_comic: NSSet?


    // MARK: - Decodable
  required convenience init?(imageUrl : URL ,name : String,id : Int,insertIntoManagedObjectContext context: NSManagedObjectContext){
      
    _ = CodingUserInfoKey.managedObjectContext
    guard let entity = NSEntityDescription.entity(forEntityName: "CharachterDBModel", in: context) else{return nil}
      

    self.init(entity: entity, insertInto: context)
   // self.init()
    self.imageUrl = imageUrl
    self.name = name
    self.id = id
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(imageUrl?.path, forKey: .imageUrl)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
    }
}
extension CharachterDBModel {

   @nonobjc public class func fetchRequest() -> NSFetchRequest<CharachterDBModel> {
      return NSFetchRequest<CharachterDBModel>(entityName: "CharachterDBModel")
    }

}
