//
//  PersonModel.swift
//  EditDemo
//
//  Created by Lazy on 2019/10/21.
//  Copyright © 2019 Lazy. All rights reserved.
//

import ObjectMapper

struct TempModel {
    var pass: String = UUID().uuidString
    var views: Int = 1
    var days: Int = 2
    var isDelete: Bool = false
}

class SecretMessageObject: Mappable {

    var created: String = ""
    var deleted: Bool = false
    var expireDays: Int = 0
    var expireViews: Int = 0
    var expired: Bool = false
    var id: Int = 0
    var payload: String = ""
    var updatedAt: String = ""
    var urlToken: String = ""

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        created <- map["created_at"]
        deleted <- map["deletable_by_viewer"]
        expireDays <- map["expire_after_days"]
        expireViews <- map["expire_after_views"]
        expired <- map["expired"]
        id <- map["id"]
        payload <- map["payload"]
        updatedAt <- map["updated_at"]
        urlToken <- map["url_token"]
    }
}
