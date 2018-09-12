//
//  HomeService.swift
//  MetaBrowser
//
//  Created by Николай Садчиков on 10.09.2018.
//  Copyright © 2018 mad. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class HomeService {
    var homeItems: [HomeItem]?
    
    func load(complition: @escaping () -> ()) {
        let request = GetDataRequest()
        request.parameters = ["id": 1, "version": "1.0.0", "method": "getPopular", "params": [:]]
        
        Alamofire.request(request.path(), method: request.method(), parameters: request.parameters, encoding: JSONEncoding.default).validate().responseJSON { (response) in
            guard response.error == nil else {
                print(response.error?.localizedDescription ?? "Error nil")
                complition()
                return
            }
            guard let result = response.result.value as? [String : Any] else {
                complition()
                return
            }
            
            guard let items = result["data"] as? [[String : String]] else {
                complition()
                return
            }
            
            self.homeItems = Mapper<HomeItem>().mapArray(JSONArray: items)
            complition()
        }
    }
    
    func filteredItems(with: String) -> [HomeItem]? {
        guard let items = homeItems else {
            return nil
        }
        let filteredItems = items.filter { (item) -> Bool in
            return ((item.name?.range(of: with, options: .caseInsensitive)) != nil) || ((item.company?.range(of: with, options: .caseInsensitive)) != nil)
        }
        
        return filteredItems
    }
}
