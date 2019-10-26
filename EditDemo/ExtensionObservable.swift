//
//  ExtensionObservable.swift
//  EditDemo
//
//  Created by Lazy on 2019/10/26.
//  Copyright © 2019 Lazy. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import ObjectMapper

extension Observable {

    public func mapObject<T:Mappable>(type: T.Type) -> Observable<T> {

        return self.map { response in

            guard let dict = response as? [String: Any] else {

                throw RxSwiftMoyaError.ParseJSONError
            }
            if let error = self.parseError(response: dict) {
                throw error
            }
            print("response=\(dict)")
            return Mapper<T>().map(JSON: dict)!
        }
    }
    public func mapArray<T:Mappable>(type: T.Type) -> Observable<[T]> {

        return self.map { response in

            guard let array = response as? [[String: Any]] else {

                throw RxSwiftMoyaError.ParseJSONError
            }

            for dict: [String: Any] in array {

                if let error = self.parseError(response: dict) {

                    throw error
                }
            }
            return Mapper<T>().mapArray(JSONArray: array)
        }
    }

    final fileprivate func parseError(response: [String: Any]?) -> NSError? {

        var error: NSError?

        if let value = response {
            var code: Int?
            var msg: String?

            if let errorDic = value["error"] as? [String: Any] {

                code = errorDic["code"] as? Int
                msg = errorDic["msg"] as? String
                error = NSError(domain: "Network", code: code!, userInfo: [NSLocalizedDescriptionKey: msg ?? ""])
            }
        }
        return error
    }

    final fileprivate func parseServerError() -> Observable {

        return self.map { (response) in

            let name = type(of: response)
            print(name)

            guard let dict = response as? [String: Any] else {

                throw RxSwiftMoyaError.ParseJSONError
            }
            if let error = self.parseError(response: dict) {
                throw error
            }
            return self as! Element
        }
    }
}


enum RxSwiftMoyaError: String {

    case ParseJSONError
    case OtherError
}
extension RxSwiftMoyaError: Swift.Error { }


extension ObservableType {

    func withErrorMessage() -> Observable<E> {
        return self.catchError({ error in
            NSLog(error.localizedDescription)
            return Observable.error(error)
        })
    }
}
