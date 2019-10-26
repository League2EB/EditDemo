//
//  Service.swift
//  EditDemo
//
//  Created by Lazy on 2019/10/26.
//  Copyright © 2019 Lazy. All rights reserved.
//

import Moya

enum Service {
    case featch(model: TempModel)
}

extension Service: TargetType {

    var baseURL: URL {
        return URL(string: "htps://pwpush.com")!
    }

    var path: String {
        return "/p.json"
    }

    var method: Moya.Method {
        return .post
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .featch(let model):
            var pars = [String: Any]()
            pars["payload"] = model.pass
            pars["expire_after_views"] = model.views
            pars["expire_after_days"] = model.days
            pars["deletable_by_viewer"] = model.isDelete
            return .requestParameters(parameters: pars, encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        return [:]
    }
}
