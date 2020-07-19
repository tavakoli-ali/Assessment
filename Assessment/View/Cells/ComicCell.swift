
import UIKit

//
// MARK: - Session Cell
//
class ComicCell: UITableViewCell {
  //
  // MARK: - Class Constants
  //
  @IBOutlet weak var container: UIView!
  static let identifier = "ComicCell"
  
  //
  // MARK: - Outlets
  //
  @IBOutlet weak var descLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
 @IBOutlet weak var imageCard: CustomUIImageView!
  @IBOutlet weak var imageCharachter: CustomUIImageView!
  
  override func layoutSubviews() {
         super.layoutSubviews()
     imageCharachter.layer.borderWidth=1.0
     imageCharachter.layer.masksToBounds = false
     imageCharachter.layer.borderColor = UIColor.white.cgColor
     imageCharachter.layer.cornerRadius = 25
     imageCharachter.clipsToBounds = true
      imageCard.contentMode = .scaleAspectFit
    imageCharachter.contentMode = .scaleAspectFill

  }
  
  //
  // MARK: - Table View Cell
  //
  override func prepareForReuse() {
    super.prepareForReuse()
 //   configureWith( .none)
    descLabel.text = nil
        dateLabel.text = nil
        titleLabel.text = nil
    imageCard.image = nil
    imageCharachter.image = nil
    imageCard.canceltask()
    imageCharachter.canceltask()
  }

  public func configureWith(_ cell: ComicsDBModel? , charachterUrl : URL, charachterId : Int ) throws {
       if let cell = cell {
        imageCard.downloadedFrom(url: cell.imageUrl, path: "photo/temp/Comics/\(charachterId)/")
        imageCharachter.downloadedFrom(url: charachterUrl, path: "photo/temp/Charachters/")
        
      titleLabel.text = cell.title
        let isoDate = cell.date?.toDate()
        guard  let text = isoDate?.toString() else {return}
        dateLabel.text = text
        descLabel.text = cell.desc
        guard let readmoreFont = UIFont(name: "Helvetica-Oblique", size: 14.0)  else {return}
        guard let readmoreFontColor = UIColor(named: "rw-highlight") else {return}
        DispatchQueue.main.async {
          self.descLabel.addTrailing(with: "... ", moreText: "Readmore", moreTextFont: readmoreFont, moreTextColor: readmoreFontColor)
        }
      }
       else{
      }
  }
}



