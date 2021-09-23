//
//  API.swift
//  vkNewsClean
//
//  Created by Никита Ломовцев on 19.09.2021.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = "5.131"
    
    static let newsfeed = "/method/newsfeed.get"
    static let user = "/method/users.get"
}
