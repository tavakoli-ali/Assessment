

import Foundation


class URLSessionAPIService:APIService{
    private var task:URLSessionTask?
    
    func dispatch(apiRequest: RequestEndPoint, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let urlSession = URLSession.shared
        do{
            var urlRequest = try self.buildURLRequest(request: apiRequest)
            addHeaders(urlRequest: &urlRequest, httpHeaders: apiRequest.httpHeaders)
            task = urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
        }catch{
            completion(nil, nil, error)
        }
        task?.resume()
    }
    
    fileprivate func buildURLRequest(request: RequestEndPoint) throws -> URLRequest{
        var urlRequest = URLRequest(url: request.baseUrl.appendingPathComponent(request.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        urlRequest.httpMethod = request.httpMethod.rawValue
        try request.parameters.encode(urlReqeuest: &urlRequest)
        return urlRequest
    }
    
    fileprivate func addHeaders(urlRequest: inout URLRequest, httpHeaders:HTTPHeaders?){
        guard let headers = httpHeaders else{
            return
        }
        for (key, value) in headers{
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
    }
}
