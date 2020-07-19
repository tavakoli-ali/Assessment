

import Foundation
import Reachability
import CoreData

class ComicListViewModelViewDetails: NSObject, ComicListViewModel {
  let appDelegate = UIApplication.shared.delegate as! AppDelegate

    private var apiService = URLSessionAPIService()
    private var ComicList:[ResultComic] = []
    private var comicListDataSource:[ComicsDBModel] = []
    private var comicListApiOffset = 0
    private var comicListApiLimit = 50
    private var charachterId = 20
    var coreDataStack : DBHandler?

    var isOffline: Dynamic<Bool>
    var noOfComics:Dynamic<Int>
    var comicListApiTotal:Dynamic<Int>
    var isComicDataLoading:Dynamic<Bool>
    var error: Dynamic<String>
    
    override init() {
        isOffline = Dynamic(false)
        isComicDataLoading = Dynamic(false)
        noOfComics = Dynamic(0)
        comicListApiTotal = Dynamic(0)
        error = Dynamic("")
        super.init()
    }
    
    func getSelectedComicViewModel(atIndex indexpath:IndexPath) -> ComicsDBModel{
        return comicListDataSource[indexpath.row-1]
      }
    func fetchMoreComics(){
        if !isComicDataLoading.value {
          //  self.comicListApiOffset += 20
            self.comicListApiLimit += 20
          fetchComicList(charID: charachterId)
        }
    }
    
    func refreshComicList(){
        self.comicListApiOffset = 0
        self.noOfComics.value = 0
        self.comicListApiLimit = 50
        self.ComicList = []
        self.comicListDataSource = []
        self.comicListDataSource = []
//      fetchComicList(charID: charachterId)
    }
    
  func preLoadComicList(){
      self.comicListApiOffset = 0
      self.noOfComics.value = 0
      self.comicListApiLimit = 50
      self.ComicList = []
      self.comicListDataSource = []
  }
  func fetchComicList(charID : Int) {
    charachterId = charID
      let reachability = try! Reachability()
      if ((reachability.connection) == .unavailable && ComicList.count == 0) {
     coreDataStack?.fetchFromStorageComicList(charachterId:charachterId) { (success , comicFromDB) in
       self.comicListDataSource = comicFromDB!
                      self.comicListApiOffset = self.comicListDataSource.count
                      self.noOfComics.value = self.comicListDataSource.count
              self.comicListApiTotal.value = self.comicListDataSource.count
            return
        }
    }
        self.isComicDataLoading.value = true
      apiService.dispatch(apiRequest: MarvelRequestsEndPoint.comicList(offset: comicListApiOffset, limit: comicListApiLimit, charachterId: charachterId)) { (data, response, error) in
            if let data = data {
                do {
                    let comicList = try JSONDecoder().decode(ResponseJson<ResultComic>.self, from: data)
                    self.comicListApiTotal.value = comicList.data.total
                  self.processFetchedComicDetail(comicList: comicList){ success in
                    self.isComicDataLoading.value = false
                       if let response = response {
                           debugPrint(response)
                       }
                  }
                } catch {
                    print(error)
                    self.error.value = error.localizedDescription
                }
            }
   
            if let error = error {
                print(error)
                self.error.value = error.localizedDescription
            }
        }
    }
    
  private func processFetchedComicDetail(comicList:ResponseJson<ResultComic>, needCache:Bool = true,completionHandler: @escaping ( Bool?) -> Void){
    if comicList.data.results.count == 0 {
            self.error.value = ResponsListConstant.ErrorMessages.NoDataToShow

            return
        }
    coreDataStack?.saveToDBComicList(comicList.data.results,charachterId : charachterId){ successsaved in
      self.coreDataStack?.fetchFromStorageComicList(charachterId:self.charachterId) { (success , comicFromDB) in
      self.comicListDataSource = comicFromDB!
                self.comicListApiOffset = self.comicListDataSource.count
                self.noOfComics.value = self.comicListDataSource.count

      }
    }
    }
    
 
}
