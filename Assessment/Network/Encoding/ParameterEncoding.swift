

import Foundation

public typealias ParametersData = [String:Any]

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, parameters:ParametersData) throws
}


public enum ParameterEncoding{
    case none
    case body(parameter : ParametersData?)
    case url(parameter : ParametersData?)
    
    func encode(urlReqeuest: inout URLRequest) throws {
        do{
            switch self {
            case .none:
                return
            case .url(let parameter):
                guard let parameter = parameter else{ return}
                try URLParameterEncoding().encode(urlRequest: &urlReqeuest, parameters: parameter)
            case .body(_):
                return
            }
        }catch{
            throw error
        }
    }
}

public enum NetworkErrors: String, Error{
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Parameter Encoding Failed"
    case missingURL = "URL is nil"
}
