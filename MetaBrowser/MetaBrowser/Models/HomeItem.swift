//
//  HomeItem.swift
//  MetaBrowser
//
//  Created by Николай Садчиков on 10.09.2018.
//  Copyright © 2018 mad. All rights reserved.
//

import ObjectMapper

class HomeItem: Mappable {
    var name: String?
    var company: String?
    var description: String?
    var iconUrl: String?
    var url: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        company <- map["company"]
        description <- map["description"]
        iconUrl <- map["icon"]
        url <- map["url"]
    }
}
