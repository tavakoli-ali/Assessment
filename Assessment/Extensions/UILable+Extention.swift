
import UIKit

extension UILabel {
  var textdata : String {
    if let text = self.text
    {
      return text
    }
    else {
      let text = " "
      return String.emptyIfNil(text)
    }
  }
    func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
        let readMoreText: String = trailingText + moreText
        let lengthForVisibleString: Int = self.vissibleTextLength
//      guard let textdata = self.text? else {return}
         let mutableString: String = textdata
        let trimmedString: String = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: ((textdata.count) - lengthForVisibleString)), with: "")
        let readMoreLength: Int = (readMoreText.count)
      let trimmedForReadMore: String = (trimmedString as NSString).replacingCharacters(in: NSRange(location: ((trimmedString.count ) - readMoreLength), length: readMoreLength), with: "") + trailingText
        let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedString.Key.font: self.font])
        let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
        answerAttributed.append(readMoreAttributed)
        self.attributedText = answerAttributed
    }

    var vissibleTextLength: Int {
        let font: UIFont = self.font
        let mode: NSLineBreakMode = self.lineBreakMode
        let labelWidth: CGFloat = self.frame.size.width
        let labelHeight: CGFloat = self.frame.size.height
        let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)

        let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: font]
        let attributedText = NSAttributedString(string: textdata, attributes: attributes as? [NSAttributedString.Key : Any])
        let boundingRect: CGRect = attributedText.boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, context: nil)

        if boundingRect.size.height > labelHeight {
            var index: Int = 0
            var prev: Int = 0
            let characterSet = CharacterSet.whitespacesAndNewlines
            repeat {
                prev = index
                if mode == NSLineBreakMode.byCharWrapping {
                    index += 1
                } else {
                    index = (textdata as NSString).rangeOfCharacter(from: characterSet, options: [], range: NSRange(location: index + 1, length: textdata.count - index - 1)).location
                }
            } while index != NSNotFound && index < textdata.count && (textdata as NSString).substring(to: index).boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, attributes: attributes as? [NSAttributedString.Key : Any], context: nil).size.height <= labelHeight
            return prev
        }
        return textdata.count
    }
}
