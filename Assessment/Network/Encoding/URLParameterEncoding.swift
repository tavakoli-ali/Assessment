

import Foundation

struct URLParameterEncoding:ParameterEncoder{
    
    func encode(urlRequest: inout URLRequest, parameters: ParametersData) throws {
        guard let url = urlRequest.url else{
           throw(NetworkErrors.missingURL)
        }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty{
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in parameters{
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
    }
}
