import UIKit
import Foundation
import Alamofire
import ObjectMapper


public enum WombatHttpRouter: URLRequestConvertible {
    
    case postInfo(name: String)
   
    var method: Alamofire.HTTPMethod {
        switch self {
        case .postInfo:
            return.post
        }
    }
    
    var path: String {
        switch self {
        case.postInfo:
            return "get_account"
       }
    }
    
    var isAuthorization: Bool {
        switch self {
        case .postInfo:
            return false
        default:
            return true
        }
    }
    
    var authorization: String? {
        switch self {
        default:
            return nil
        }
    }
    
    var useBaseUrl: Bool? {
        switch self {
        default:
            return true
        }
    }
    
    var jsonParameters: [String: Any]? {
        switch self {
            
        case.postInfo(let name):
            return ["account_name" :name]
       
        }
    }
    
    var urlParameters: [String: Any]? {
        switch self {
            
        default:
            return nil
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = NSURL(string: Configuration.baseURL() + self.path)!
        var urlRequest = URLRequest(url: url as URL)
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        if self.isAuthorization {
           
        }
        
        switch self {
      
        case .postInfo:
            return try JSONEncoding.default.encode(urlRequest, with: self.jsonParameters)
            
        }
    }
}


