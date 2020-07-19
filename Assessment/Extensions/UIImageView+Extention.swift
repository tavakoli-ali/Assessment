import UIKit



class CustomUIImageView : UIImageView {
 private var uiImage : UIImageView?
  private var task : URLSessionTask?
 private var ind = UIActivityIndicatorView()

  override func layoutSubviews() {
    super.layoutSubviews()
    ind.isHidden = false
    ind.hidesWhenStopped = true
    ind.color = UIColor.black
    ind.translatesAutoresizingMaskIntoConstraints = false
//    self.translatesAutoresizingMaskIntoConstraints = false
//
//    self.centerXAnchor.constraint(equalTo: superview!.centerXAnchor).isActive=true
//    self.centerYAnchor.constraint(equalTo: superview!.centerYAnchor).isActive=true
    
    self.ind.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    self.ind.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

  }
  func downloadedFrom(url: URL?,path: String?, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
    self.contentMode = mode
    let urlSession = URLSession.shared
    guard  let url = url else {return}
    guard  var path = path else {return}
    self.image = nil
    let patharr = url.path.components(separatedBy: "/")
    guard let name = patharr.last else {return}
    path = path + name
    let tempDirectoryUrl = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(path)
     let fileManager = FileManager.default
    ind.startAnimating()
    self.addSubview(ind)
    if fileManager.fileExists(atPath: tempDirectoryUrl.path) 
    {
      self.image = UIImage(fileURLWithPath: tempDirectoryUrl)
      ind.stopAnimating()
    }
    else {
//      task.request(url).responseImage { response in
//
//          if case .success(let image) = response.result {
//            self.image = image
//              guard let _ = image.save(at: tempDirectoryUrl) else {return }
//              self.ind.stopAnimating()
//        }
    
     task = urlSession.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {return }
            DispatchQueue.main.async() { () -> Void in
              guard let _ = image.save(at: tempDirectoryUrl) else {
                return  self.ind.stopAnimating()}
                self.image = image
              self.ind.stopAnimating()
            }
        }
      task?.resume()
    }
}
  func canceltask()
  {
    ind.stopAnimating()
    task?.cancel()
  }
}
