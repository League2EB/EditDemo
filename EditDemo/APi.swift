//
//  APi.swift
//  EditDemo
//
//  Created by Lazy on 2019/10/26.
//  Copyright © 2019 Lazy. All rights reserved.
//

import Moya
import RxSwift
import ObjectMapper

class APi {

    let provider = MoyaProvider<Service>()
    let backgroundQueue = SerialDispatchQueueScheduler(internalSerialQueueName: "com.lazy.sample")

    func fetcthData(model: TempModel) -> Observable<SecretMessageObject> {
        return provider.rx
            .request(.featch(model: model))
            .mapJSON()
            .asObservable()
            .withErrorMessage()
            .mapObject(type: SecretMessageObject.self).subscribeOn(backgroundQueue)
            .observeOn(MainScheduler.instance)
    }
}

