

import Foundation

public enum MarvelRequestsEndPoint:RequestEndPoint{
    
    case  charachterList(offset:Int, limit:Int)
  case  comicList(offset:Int, limit:Int,charachterId:Int )
  
    
    var baseUrl: URL{
        switch self {
        case .charachterList(_,_):
            guard let url = URL(string: "https://gateway.marvel.com:443/v1/public/")else{
                fatalError("Base Url could not be configured")
            }
            return url
        
      case .comicList(_,_,_):
             guard let url = URL(string: "https://gateway.marvel.com:443/v1/public/")else{
                 fatalError("Base Url could not be configured")
             }
             return url
         }
  }
    
  
    var path: String{
        switch self {
        case .charachterList(_,_):
            return("characters")
      case .comicList(_,_, let charachterId):
                 return("characters/\(charachterId)/comics")
             }
    }
    
    var httpMethod: HTTPMethod{
        switch self {
        case .charachterList(_, _):
            return HTTPMethod.get
          case .comicList(_, _,_):
                    return HTTPMethod.get
        }
    }
    
    var httpHeaders: HTTPHeaders{
        switch self {
        case .charachterList(_,_):
            return ["Content-Type":"application/json"]
          case .comicList(_,_,_):
                    return ["Content-Type":"application/json"]
        }
    }
    
    var parameters: ParameterEncoding{
        switch self {
        case .charachterList(let offset, let limit):
            return ParameterEncoding.url(parameter: ["offset":offset, "limit":limit ,"ts": "1", "apikey": "8157ad875ed81104cd0e0ff54b2f44a3", "hash": "b66668787b7f4645f596a8fdc2266d2f"])
        case .comicList(let offset, let limit,_):
          return ParameterEncoding.url(parameter: ["offset":offset, "limit":limit ,"ts": "1", "apikey": "8157ad875ed81104cd0e0ff54b2f44a3", "hash": "b66668787b7f4645f596a8fdc2266d2f"])
        }
    }
}
