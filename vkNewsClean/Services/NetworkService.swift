//
//  NetworkService.swift
//  vkNewsClean
//
//  Created by Никита Ломовцев on 19.09.2021.
//

import Foundation

final class NetworkService{
    
    func getFeed(){
        
        //https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.131
        
        var components = URLComponents()
        let params = ["filters": "post,photo"]
        let allParams = params
        allParams["access_token"]
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsfeed
        components.queryItems
        
        components.url
    }
}
