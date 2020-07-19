
import UIKit

class CollViewCellCode: UITableViewCell {
  
  var collectionView: UICollectionView!
  var container : UIView = UIView()
  static let identifier = "CollViewCellCode"
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
    setShape()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  func setupView(){
    
    let layout = UICollectionViewFlowLayout()
    //    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    layout.itemSize = CGSize(width: 100, height: 100)
    layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    layout.scrollDirection = .horizontal
    collectionView = UICollectionView(frame: CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width,height: 100),collectionViewLayout: layout)
    collectionView.contentInsetAdjustmentBehavior = .never
    collectionView.register(CharachterCellCode.self, forCellWithReuseIdentifier: "CharachterCellCode")
    collectionView.collectionViewLayout = layout
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    container.translatesAutoresizingMaskIntoConstraints = false
    
    container.clipsToBounds = true
    contentView.clipsToBounds = true
    collectionView.clipsToBounds = true
    container.addSubview(collectionView)
    self.contentView.addSubview(container)
  }
  func setShape(){
    
    self.container.widthAnchor.constraint(equalTo:contentView.widthAnchor ).isActive = true
    self.container.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
    self.container.heightAnchor.constraint(equalToConstant: 100).isActive = true
    self.container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    self.container.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 0).isActive = true
    
    self.collectionView.widthAnchor.constraint(equalTo:self.container.widthAnchor).isActive = true
    self.collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    self.collectionView.leadingAnchor.constraint(equalTo: self.container.leadingAnchor).isActive = true
    self.collectionView.topAnchor.constraint(equalTo: self.container.topAnchor).isActive = true
  }
  
  
}
extension CollViewCellCode {
  
  func reloaddata(){
    collectionView.reloadData()
  }
  
  func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDataSourcePrefetching>(_ dataSourceDelegate: D, forRow row: Int) {
    
    collectionView.delegate = dataSourceDelegate
    collectionView.dataSource = dataSourceDelegate
    collectionView.prefetchDataSource = dataSourceDelegate
    collectionView.tag = row
    collectionView.backgroundColor = UIColor.white
    //Stops collection view if it was scrolling.
    collectionView.setContentOffset(collectionView.contentOffset, animated:false)
    //    collectionView.reloadData()
    
    
  }
  
  
  var collectionViewOffset: CGFloat {
    set { collectionView.contentOffset.x = newValue }
    get { return collectionView.contentOffset.x }
  }
  
}
