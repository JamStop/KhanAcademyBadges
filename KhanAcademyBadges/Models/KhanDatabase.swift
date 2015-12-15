//
//  Database.swift
//  KhanAcademyBadges
//
//  Created by Jimmy Yue on 12/14/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//




// Didn't expect your server response haha, messed up :(

import Foundation
import JSONHelper
import RxSwift
import Alamofire

class KhanDatabase {
    
    typealias JSON = [String: AnyObject]
    typealias CompletionHandler = (response: JSON? , error: DatabaseError?) -> Void
    
    private let baseURL = "https://www.khanacademy.org/api/v1/"
    private let unexpectedResponse = "Unexpected response."
    
    enum DatabaseError: ErrorType {
        case NoResponse
        case ErrorParsingJSON
        case ResponseError(message: String?, error: String?)
        case UnexpectedResponseError(message: String?, statusCode: Int?)
        case UnexpectedError(message: String)
    }

    
    func rx_getBadgeCategories() -> Observable<JSON?> {

        return create { observer in
            
            self.get("badges/categories") {
                (resp, err) -> Void in
                
                if let error = err {
                    observer.onError(error)
                } else {
                    observer.onNext(resp)
                    observer.onCompleted()
                }
            }
            
            return NopDisposable.instance
        }
        
    }
    
    private func get(endPoint: String, handler: CompletionHandler?) {
        
        request(.GET, endpoint: endPoint, handler: handler)
        
    }
    
    private func post(endPoint: String, handler: CompletionHandler?) {
        
        request(.POST, endpoint: endPoint, handler: handler)
        
    }
    
    private func request(method: Alamofire.Method, endpoint: String, handler: CompletionHandler?) {
        
        let encoding: Alamofire.ParameterEncoding = method == Alamofire.Method.GET ? .URL : .JSON
        
        Alamofire.request(method, baseURL + endpoint, encoding: encoding, headers: nil)
            .responseJSON(options: .AllowFragments) { (Response) -> Void in
                
                guard let response = Response.response else {
                    handler?(response: nil, error: .NoResponse)
                    return
                }
                
                if (response.statusCode == 200) {
                    
                    print(response)
                    guard let responseJSON = Response.result.value as? JSON else {
                        handler?(response: nil, error: .ErrorParsingJSON)
                        return
                    }
                    
                    if let error = responseJSON["error"] {
                        // error fetching data
                        let message = responseJSON["message"] as? String
                        handler?(response: nil, error: .ResponseError(message: message, error: error as? String))
                    } else {
                        // no errors
                        handler?(response: responseJSON, error: nil)
                    }
                    
                } else {
                    
                    handler?(response: nil, error: .UnexpectedResponseError(message: "Unexpected error", statusCode: response.statusCode))
                    
                }
                
        }
        
    }

    
}