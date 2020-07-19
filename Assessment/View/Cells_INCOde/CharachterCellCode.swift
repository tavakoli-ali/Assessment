
import UIKit

//
// MARK: - CharachterCell
//
class CharachterCellCode: UICollectionViewCell {
  
  //
  // MARK: - Class Constants
  //
  static let identifier = "CharachterCellCode"
  
  //
  // MARK: - Outlets
  //
  let container: UIView = UIView()
  let  imageCard: CustomUIImageView = CustomUIImageView()
  
  override init(frame: CGRect) {
      super.init(frame: frame)
    setupView()
     setShape()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
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
  func configureWith(_ cell: CharachterDBModel) {
    setupView()
    imageCard.downloadedFrom(url: cell.imageUrl,path: "photo/temp/Charachters/")
    
  }
  
  func setupView(){
    imageCard.layer.masksToBounds = false
    imageCard.layer.cornerRadius = 40
    imageCard.layer.borderWidth=1.0
    imageCard.clipsToBounds = true
    imageCard.layer.borderColor = UIColor.white.cgColor
    
    container.translatesAutoresizingMaskIntoConstraints = false
    imageCard.translatesAutoresizingMaskIntoConstraints = false
    contentView.clipsToBounds = true
    container.clipsToBounds = true
    container.addSubview(imageCard)
    self.contentView.addSubview(container)
  }
  
  func setShape() {
    

    
    self.container.backgroundColor = UIColor.white
    self.container.widthAnchor.constraint(equalTo:contentView.widthAnchor ).isActive = true
    self.container.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
    self.container.topAnchor.constraint(equalTo: contentView.topAnchor ,constant: 0).isActive = true
    self.container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 0).isActive = true
    
    self.imageCard.widthAnchor.constraint(equalToConstant: 80).isActive = true
    self.imageCard.heightAnchor.constraint(equalToConstant: 80).isActive = true
    self.imageCard.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
    self.imageCard.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
    
    
    

    
  }
}

