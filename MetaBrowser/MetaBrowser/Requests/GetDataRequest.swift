//
//  GetDataRequest.swift
//  MetaBrowser
//
//  Created by Николай Садчиков on 10.09.2018.
//  Copyright © 2018 mad. All rights reserved.
//

import Alamofire

class GetDataRequest: Request {
    var parameters: Parameters?
    var headers: HTTPHeaders?
    
    func path() -> String {
        return baseURL()
    }
    
    func method() -> HTTPMethod {
        return .post
    }
}
