//
//  EndpointList.swift
//  Dot_Health_1
//
//  Created by Animesh Mohanty on 02/06/20.
//  Copyright © 2020 Animesh Mohanty. All rights reserved.
//

import Foundation

enum API: String {
     case api1 = "http://104.215.179.29/v1/"
     case api2 = "http://104.215.179.29/v1/sessions"
    
    // To get the API endpoint with request setup
   func getPostAPIEndpoint(urlString:String ,queryItems: [URLQueryItem] = [], headers: HTTPHeaders = [ : ], body: Data = Data()) -> Endpoint {
            return Endpoint(path: urlString, httpMethod: .post, headers: headers, body: body, queryItems: nil)
    }
    func getPostAPIEndpointForStates(urlString:String ,queryItems: [URLQueryItem] = [], headers: HTTPHeaders = [ : ], body: Data? = Data()) -> Endpoint {
            return Endpoint(path: urlString, httpMethod: .get, headers: nil, body: nil, queryItems: nil)
    }
}
