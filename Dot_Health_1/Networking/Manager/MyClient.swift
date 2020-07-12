//
//  MyClient.swift
//  Dot_Health_1
//
//  Created by Animesh Mohanty on 02/06/20.
//  Copyright © 2020 Animesh Mohanty. All rights reserved.
//

import Foundation

class MyClient: APIClient {
    
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
}

// MARK: - API Request calls

extension MyClient {
    //In the signature of the function we define the Class type that is the generic one in the API
    func getSomething(from endpoint: Endpoint, completion: @escaping (Result<Model2?, APIError>) -> Void) {
        
        let request = endpoint.request
        
        callAPI(with: request, decode: { json -> Model2? in
            guard let model2 = json as? Model2 else { return  nil }
            return model2
        }, completion: completion)
    }
}

