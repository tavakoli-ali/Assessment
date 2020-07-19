
import Foundation

public typealias APIServiceCompletion = (_ data:Data?, _ reponse:URLResponse?, _ error:Error?) -> ()

protocol APIService{
    func dispatch(apiRequest:RequestEndPoint, completion: @escaping APIServiceCompletion)
}

