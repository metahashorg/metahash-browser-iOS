//
//  RequestProtocol.swift
//  MetaBrowser
//
//  Created by Николай Садчиков on 10.09.2018.
//  Copyright © 2018 mad. All rights reserved.
//

import Alamofire

let baseURLString = "http://app.metahash.io/api/browser/"

protocol Request {
    func baseURL () -> String
    func path () -> String
    func method () -> HTTPMethod
    var parameters: Parameters? { get set }
    var headers: HTTPHeaders? { get set }
}

extension Request {
    func baseURL () -> String {
        return baseURLString
    }
}
