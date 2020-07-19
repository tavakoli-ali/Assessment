
import UIKit

class CollViewCell: UITableViewCell {

    @IBOutlet  weak var collectionView: UICollectionView!
   @IBOutlet  weak var container: UIView!
  static let identifier = "CollViewCell"

}

extension CollViewCell {
  
    func reloaddata(){
    collectionView.reloadData()
    }

    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDataSourcePrefetching>(_ dataSourceDelegate: D, forRow row: Int) {
//        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.prefetchDataSource = dataSourceDelegate
        collectionView.tag = row
        //Stops collection view if it was scrolling.
        collectionView.setContentOffset(collectionView.contentOffset, animated:false)
    }
  

    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
  
}
