

import Foundation
import CoreData


class DBManager :NSObject, DBHandler {
  
  var coreDataStack : CoreDataStack?
  
  
  
  func saveToDBCharachterList(_ data : [ResultCharachter],completionHandler: @escaping ( Bool?) -> Void) {
    guard   let managedObjectContext = coreDataStack?.mainContext else { return}
    managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    managedObjectContext.perform {
      for item in data {
        guard  let url = URL(string:item.thumbnail.path + "." + item.thumbnail.thumbnailExtension)else {return}
        _ = CharachterDBModel(imageUrl: URL.emptyIfNil(url), name: item.name, id: item.id, insertIntoManagedObjectContext: managedObjectContext)
      }
      do {
        try managedObjectContext.save()
        print("Success")
      } catch {
        print("Error saving: \(error)")
      }
      self.coreDataStack?.saveContext()
      completionHandler(true)
    }
  }
  func fetchFromStorageCharachterList(completionHandler: @escaping ( Bool?, [CharachterDBModel]?) -> Void){
    let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    childContext.parent = coreDataStack?.mainContext
    guard  let managedObjectContext =  coreDataStack?.mainContext else { return }
    var data : [CharachterDBModel]?
    let fetchRequest = NSFetchRequest<CharachterDBModel>(entityName: "CharachterDBModel")
    managedObjectContext.perform {
      do {
        let users = try managedObjectContext.fetch(fetchRequest)
        data = users
      } catch let error {
        print(error)
        data = nil
      }
      completionHandler (true,data)
    }
    
  }
  func saveToDBComicList(_ data : [ResultComic], charachterId: Int,completionHandler: @escaping ( Bool?) -> Void) {
    guard   let managedObjectContext = coreDataStack?.mainContext else { return}
    managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    managedObjectContext.perform {
      for item in data {
        guard let path = item.thumbnail?.path,
          let exten = item.thumbnail?.thumbnailExtension  else {return}
        _ = ComicsDBModel(imageUrl: path + "." + exten, title: item.title, id: item.id, desc: String.sampleIfNil(item.resultDescription), date: item.dates?[0].date, charachterId: charachterId, insertIntoManagedObjectContext: managedObjectContext)
      }
      do {
        try managedObjectContext.save()
        print("Success")
      } catch {
        print("Error saving: \(error)")
      }
      self.coreDataStack?.saveContext()
      completionHandler(true)
    }
  }
  
  
  func fetchFromStorageComicList(charachterId: Int,completionHandler: @escaping ( Bool?, [ComicsDBModel]? ) -> Void){
    var data : [ComicsDBModel]?
    guard   let managedObjectContext = coreDataStack?.mainContext else { return }
    let fetchRequest = NSFetchRequest<ComicsDBModel>(entityName: "ComicsDBModel")
    fetchRequest.predicate = NSPredicate(format: "charachterId == \(charachterId)")
    managedObjectContext.perform {
      do {
        let users = try managedObjectContext.fetch(fetchRequest)
        data = users
      } catch let error {
        print(error)
        data = nil
      }
      completionHandler(true,data)
    }
    
  }
}
