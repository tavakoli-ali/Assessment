

import UIKit
import CoreData
import Swinject
//import FLEX


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
    // MARK: - Core Data stack
  lazy var coreDataStack = CoreDataStack(modelName: "CashData")
  let container: Container = {
      let container = Container()
      container.register(ComicListViewModel.self) { _ in ComicListViewModelViewDetails() }
      container.register(CharachterListViewModel.self) { _ in CharachterListViewModelDetails() }
      container.register(DBHandler.self) { _ in DBManager() }
    .inObjectScope(.container)
      return container
  }()

  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    
//     FLEXManager.shared.showExplorer()

    if
      let tabBarController = window?.rootViewController as? UITabBarController,
      let navigationControllers = tabBarController.viewControllers as? [UINavigationController],
      let feedViewC = navigationControllers[0].viewControllers.first as? FeedViewController,
      let CatViewC = navigationControllers[3].viewControllers.first as? CategoryViewController
    {
         _ = coreDataStack.mainContext
      feedViewC.viewModelComic1 = container.resolve(ComicListViewModel.self)
      feedViewC.viewModelCharachter1 = container.resolve(CharachterListViewModel.self)
      var db = container.resolve(DBHandler.self)
      db?.coreDataStack = coreDataStack
      feedViewC.viewModelCharachter1?.coreDataStack = db
      feedViewC.viewModelComic1?.coreDataStack = db
      
      CatViewC.viewModelComic1 = container.resolve(ComicListViewModel.self)
      CatViewC.viewModelCharachter1 = container.resolve(CharachterListViewModel.self)
      CatViewC.viewModelCharachter1?.coreDataStack = db
      CatViewC.viewModelComic1?.coreDataStack = db


    }
    return true
  }
  func applicationWillTerminate(_ application: UIApplication) {
   coreDataStack.saveContext()
    }
}
