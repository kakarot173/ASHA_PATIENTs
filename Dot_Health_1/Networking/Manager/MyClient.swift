//
//  MyClient.swift
//  Dot_Health_1
//
//  Created by Animesh Mohanty on 02/06/20.
//  Copyright © 2020 Animesh Mohanty. All rights reserved.
//

import Foundation

class DotConnectionClient: APIClient {
    
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
}

// MARK: - API Request calls

extension DotConnectionClient {
    //In the signature of the function we define the Class type that is the generic one in the API
    func userLogin(from endpoint: Endpoint, completion: @escaping (Result<AnyObject?, APIError>) -> Void){
        let request = endpoint.request
        callAPI(with: request, modelParser: String.self, completion: completion)
    }
    func getCountryList(from endpoint: Endpoint, completion: @escaping (Result<AnyObject?, APIError>) -> Void){
           let request = endpoint.request
                  callAPI(with: request, modelParser: String.self, completion: completion)
       }
    func registerUser(from endpoint: Endpoint, completion: @escaping (Result<AnyObject?, APIError>) -> Void) {
        
        let request = endpoint.request
        callAPI(with: request, modelParser: String.self, completion: completion)
//        callAPI(with: request, decode: { json -> String? in
//
//            guard let model2 = json as? String else { return  nil }
//            return model2
//        }, completion: completion)
    }
}

