
import Foundation

protocol ComicListViewModel {
    var isOffline:Dynamic<Bool> { get }
    var noOfComics:Dynamic<Int> { get }
    var comicListApiTotal:Dynamic<Int> { get }
    var isComicDataLoading:Dynamic<Bool> { get }
    var error:Dynamic<String> { get }
    var coreDataStack : DBHandler? {set get}

    
  func getSelectedComicViewModel(atIndex indexpath:IndexPath) -> ComicsDBModel

    func fetchComicList(charID : Int)
    func fetchMoreComics()
    func refreshComicList()
    func preLoadComicList()

}


