
import Foundation
import CoreData


protocol DBHandler {
  
  
  var coreDataStack : CoreDataStack? {set get}
  
  func saveToDBCharachterList(_ data: [ResultCharachter],completionHandler: @escaping ( Bool?) -> Void)
  func fetchFromStorageCharachterList(completionHandler: @escaping ( Bool?, [CharachterDBModel]?)-> Void )
  
  func saveToDBComicList(_ data : [ResultComic], charachterId: Int,completionHandler: @escaping ( Bool?) -> Void)
  func fetchFromStorageComicList(charachterId: Int,completionHandler: @escaping ( Bool?, [ComicsDBModel]? )-> Void )
  
  
}
