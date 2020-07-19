
import UIKit

//
// MARK: - CharachterCell
//
class CharachterCell: UICollectionViewCell {
  let appDelegate = UIApplication.shared.delegate as! AppDelegate

  //
  // MARK: - Class Constants
  //
  static let identifier = "CharachterCell"
  
  //
  // MARK: - Outlets
  //
 
 @IBOutlet weak var imageCard: CustomUIImageView!


  //
  // MARK: - Table View Cell
  //
  override func prepareForReuse() {
    super.prepareForReuse()
    imageCard.image = nil
    imageCard.canceltask()

 // imageCard?.downloadedFrom(url: nil, path: nil)
  }
  
  override func layoutSubviews() {
         super.layoutSubviews()
    imageCard.contentMode = .scaleAspectFill


  }
  func  selected(){
     imageCard.layer.borderWidth=2.0
    imageCard.layer.borderColor = UIColor.blue.cgColor
  }
    public func configureWith(_ cell: CharachterDBModel) {
     
      imageCard.layer.masksToBounds = false
      imageCard.layer.cornerRadius = 40
      imageCard.clipsToBounds = true
      imageCard.layer.borderWidth=1.0
      imageCard.layer.borderColor = UIColor.white.cgColor
      
      imageCard.downloadedFrom(url: cell.imageUrl,path: "photo/temp/Charachters/")

          
    

    }

  
}

