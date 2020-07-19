
import UIKit

//
// MARK: - Session Cell
//
class ComicCellCode: UITableViewCell {
  //
  // MARK: - Class Constants
  //
  let container: UIView = UIView()
  static let identifier = "ComicCellCode"
  
  //
  // MARK: - Outlets
  //
  let descLabel: UILabel = UILabel()
  let dateLabel: UILabel = UILabel()
  let titleLabel: UILabel = UILabel()
  let imageCard: CustomUIImageView = CustomUIImageView()
  let imageCharachter: CustomUIImageView = CustomUIImageView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
     setShape()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
   imageCard.contentMode = .scaleToFill
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
//      DispatchQueue.main.async {
//        self.descLabel.addTrailing(with: "... ", moreText: "Readmore", moreTextFont: readmoreFont, moreTextColor: readmoreFontColor)
//      }
    }
    else{
    }
  }
  
  func setupView(){
    container.frame = .zero
    container.translatesAutoresizingMaskIntoConstraints = false
    imageCharachter.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    imageCard.translatesAutoresizingMaskIntoConstraints = false
    descLabel.translatesAutoresizingMaskIntoConstraints = false
    
     imageCharachter.layer.borderWidth=1.0
     imageCharachter.layer.masksToBounds = false
     imageCharachter.layer.borderColor = UIColor.white.cgColor
     imageCharachter.layer.cornerRadius = 25
    imageCard.contentMode = .scaleAspectFit
    
    titleLabel.clipsToBounds = true
    dateLabel.clipsToBounds = true
    imageCharachter.clipsToBounds = true
    imageCard.clipsToBounds = true
    descLabel.clipsToBounds = true
//git

    container.clipsToBounds = true
    contentView.clipsToBounds = true

    container.addSubview(titleLabel)
    container.addSubview(dateLabel)
    container.addSubview(descLabel)
    container.addSubview(imageCharachter)
    container.addSubview(imageCard)
    self.contentView.addSubview(container)

  }
  
  func setShape() {
    self.container.backgroundColor = UIColor.white
    
//    self.contentView.translatesAutoresizingMaskIntoConstraints = false
//    self.contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
//    self.contentView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
//    self.contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//    self.contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    
    self.container.widthAnchor.constraint(equalTo:contentView.widthAnchor ).isActive = true
    self.container.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
    self.container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    self.container.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16).isActive = true

//
    self.imageCharachter.widthAnchor.constraint(equalToConstant: 50).isActive = true
    self.imageCharachter.heightAnchor.constraint(equalToConstant: 50).isActive = true
    self.imageCharachter.leadingAnchor.constraint(equalTo: container.leadingAnchor,constant: 16).isActive = true
    self.imageCharachter.topAnchor.constraint(equalTo: container.topAnchor,constant: 0).isActive = true
//    self.imageCharachter.bottomAnchor.constraint(equalTo: container.bottomAnchor,constant: -16).isActive = true

    
    self.titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor ,constant: -16).isActive = true
       self.titleLabel.leadingAnchor.constraint(equalTo: imageCharachter.trailingAnchor,constant: 8).isActive = true
       self.titleLabel.topAnchor.constraint(equalTo: imageCharachter.topAnchor,constant: 8).isActive = true


    self.dateLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor ,constant: -16).isActive = true
       self.dateLabel.leadingAnchor.constraint(equalTo: imageCharachter.trailingAnchor,constant: 8).isActive = true
       self.dateLabel.bottomAnchor.constraint(equalTo: imageCharachter.bottomAnchor,constant: 0).isActive = true

    
//    self.imageCard.widthAnchor.constraint(equalToConstant: 400).isActive = true
//    self.imageCard.heightAnchor.constraint(equalToConstant: 400).isActive = true

           self.imageCard.topAnchor.constraint(equalTo: dateLabel.bottomAnchor , constant: 20).isActive = true
           self.imageCard.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
           self.imageCard.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
//          self.imageCard.bottomAnchor.constraint(equalTo: container.bottomAnchor , constant: -20).isActive = true
//
//
      self.descLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor ,constant: -16).isActive = true
         self.descLabel.topAnchor.constraint(equalTo: imageCard.bottomAnchor ,constant: 16).isActive = true
         self.descLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor,constant: 16).isActive = true
         self.descLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor,constant: -20).isActive = true

    
 
       
    
    

    
    
  }
}



