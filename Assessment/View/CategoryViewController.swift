
import UIKit
import CoreData


//
// MARK: - FeedViewController View Controller
//
class CategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITableViewDataSourcePrefetching,AlertDisplayer {
  
  var viewModelCharachter1:CharachterListViewModel?
  var viewModelComic1:ComicListViewModel?
  
  
  let indicatorView: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect (x: 50 ,y: 50,width: 50,height: 50))
  let tableView:UITableView = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.plain)
  
  
  
  
  var comics: [ResultComic]?
  var charachters: [ResultCharachter]?
  var tableViewCell : CollViewCellCode?
  var charachterSelected : Int?
  var charachterName : String = ""
  var charachterImageUrl : URL?
  var storedOffsets = [Int: CGFloat]()
  lazy var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "CashData")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    setupTableView()
    indicatorView.isHidden = false
    indicatorView.startAnimating()
    setupViewModel()
    self.navigationController?.isNavigationBarHidden = false
    tableView.isHidden = true
    tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0);
    tableView.prefetchDataSource = self
    
    
    
  }
  
  func setupViewModel(){
    viewModelComic1?.noOfComics.bind{[unowned self] _ in
      DispatchQueue.main.async {
        self.tableView.isHidden = false
        self.tableView.reloadData()
        self.indicatorView.stopAnimating()
        
      }
    }
    viewModelComic1?.isComicDataLoading.bind{[unowned self] show in
      if show{
        self.indicatorView.startAnimating()
        
      }else{
        DispatchQueue.main.async {
          self.tableView.reloadData()
          self.indicatorView.stopAnimating()
          
        }
      }
    }
    viewModelComic1?.error.bind{[unowned self] errorMessage in
      DispatchQueue.main.async {
        print(errorMessage + "comic" )
        self.tableView.reloadData()
        let title = "Warning".localizedString
        let action = UIAlertAction(title: "OK".localizedString, style: .default)
        self.displayAlert(with: title , message: errorMessage, actions: [action])
        
      }
      
    }
    
    viewModelCharachter1?.noOfCharachters.bind{[unowned self] _ in
      DispatchQueue.main.async {
        let indexPath = IndexPath(item: 0, section: 0)
        if  self.charachterSelected==nil {
          guard let char = self.viewModelCharachter1?.getSelectedCharachterViewModel(atIndex: indexPath) else{return}
          self.charachterImageUrl = char.imageUrl
          self.charachterSelected = char.id
          guard let temp = self.charachterSelected else {return}
          self.viewModelComic1?.fetchComicList(charID: temp)
        }
        if(self.viewModelCharachter1?.noOfCharachters.value ?? 0 > 0)
        {self.tableView.reloadRows(at: [indexPath], with: .none)}
      }
    }
    viewModelCharachter1?.isCharachterDataLoading.bind{ show in
      if show{
        
      }else{
        DispatchQueue.main.async {            }
      }
    }
    viewModelCharachter1?.errorCharachter.bind{errorMessage in
      debugPrint(errorMessage)
    }
    indicatorView.startAnimating()
    viewModelCharachter1?.fetchCharachterList()
  }
  
  func setupTableView(){
    
    tableView.register(CollViewCellCode.self, forCellReuseIdentifier: "CollViewCellCode")
    tableView.register(ComicCellCode.self, forCellReuseIdentifier: "ComicCellCode")
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    indicatorView.translatesAutoresizingMaskIntoConstraints = false
    
    
    
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.estimatedRowHeight = 5000
    tableView.rowHeight = UITableView.automaticDimension
    tableView.backgroundColor = UIColor.white
    tableView.separatorStyle = .none
    
    if #available(iOS 13.0, *) {
      indicatorView.style = .medium
    } else {
      // Fallback on earlier versions
    }
    
    self.view.addSubview(tableView)
    self.view.addSubview(indicatorView)
    
    tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive=true
    tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive=true
    tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive=true
    tableView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor).isActive=true
    
    indicatorView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    indicatorView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    
    
    
    
    
  }
  
  // tableview for comics
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  //  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  //    if indexPath.row == 0{
  //      return 100
  //    }
  //    return 700
  //  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //first cell is collectionview
    if indexPath.row == 0   {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: CollViewCellCode.identifier, for: indexPath) as! CollViewCellCode
      return cell
    }
    else{
      
      let comicCell = tableView.dequeueReusableCell(withIdentifier: ComicCellCode.identifier, for: indexPath) as! ComicCellCode
      let session = viewModelComic1?.getSelectedComicViewModel(atIndex: indexPath)
      try?  comicCell.configureWith(session, charachterUrl : charachterImageUrl!, charachterId: charachterSelected!)
      return comicCell
    }
  }
  
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    for index in indexPaths{
      if (index.row+1 <  viewModelComic1?.comicListApiTotal.value ?? 0
        && index.row+1 >  viewModelComic1?.noOfComics.value ?? 0)
      { viewModelComic1?.fetchMoreComics()}
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print( "table view records :\((viewModelComic1?.noOfComics.value ?? 0)+1) " )
    return (viewModelComic1?.noOfComics.value ?? 0) + 1
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == 0
    {
      tableViewCell = cell as? CollViewCellCode
      self.tableViewCell!.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
      self.tableViewCell!.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    else {
      // viewModelComic.fetchMoreDeliveries()
    }
  }
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == 0
    {
      guard let tableViewCell = cell as? CollViewCellCode else { return }
      storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
  }
  
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDataSourcePrefetching {
  
  func collectionView(_ collectionView: UICollectionView,
                      didEndDisplaying cell: UICollectionViewCell,
                      forItemAt indexPath: IndexPath)
  {
    storedOffsets[0] = collectionView.contentOffset.x
  }
  
  //MARK: ScrollView Delegates
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if scrollView.tag == 0 {
      if (scrollView.contentOffset.x + scrollView.frame.size.width) > scrollView.contentSize.width{
        //                 viewModel.fetchMoreDeliveries()
        
      }
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    if (collectionView.contentOffset.x + collectionView.frame.size.width) > collectionView.contentSize.width{
      viewModelCharachter1?.fetchMoreCharachters()
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  
  //  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  //
  //    return CGSize(width: 100, height: 100)
  //  }
  
  //  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
  //    if isLoadingCell(for: indexPath) {
  //      fetchCharachters = true
  //      viewModelCharachters.fetchCharachters()
  //    }
  //  }
  //
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return  viewModelCharachter1?.noOfCharachters.value ?? 0
  }
  //  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
  //       return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
  //   }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharachterCellCode.identifier, for: indexPath) as! CharachterCellCode
    cell.tag = indexPath.row
    guard let temp = viewModelCharachter1?.getSelectedCharachterViewModel(atIndex: indexPath) else{return cell}
    //  cell.imageCard.downloadedFrom(url: temp.imageUrl,path: "photo/temp/Charachters/", tag: indexPath.row)
    cell.configureWith(temp)
    let charId = temp.id
    if charachterSelected == charId{
      cell.selected()
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let tempModel = viewModelCharachter1 else{return}
    let char = tempModel.getSelectedCharachterViewModel(atIndex: indexPath)
    self.charachterImageUrl = char.imageUrl
    self.charachterSelected = char.id
    tableView.isHidden = true
    indicatorView.isHidden = false
    indicatorView.startAnimating()
    viewModelComic1?.preLoadComicList()
    guard let temp = self.charachterSelected else {return}
    if charachterSelected == temp
    {collectionView.reloadData()}
    viewModelComic1?.fetchComicList(charID: temp)
  }
  
}
