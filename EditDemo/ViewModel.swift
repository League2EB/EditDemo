//
//  ViewModel.swift
//  EditDemo
//
//  Created by Lazy on 2019/10/26.
//  Copyright © 2019 Lazy. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {

    /*
     需要給初始Value的Subject
     寫法上面最精簡，只要accept就可以對既有的Value修改
    */
    var dataSource = BehaviorRelay<String>(value: "😂")

    let api = APi()
    let bag = DisposeBag()

    func requestData() -> Observable<Bool> {
        return self.api.fetcthData(model: TempModel()).flatMap { [weak self] (item) -> Observable<Bool> in
            guard let `self` = self else { return Observable.just(false) }
            self.dataSource.accept("https://pwpush.com/p/\(item.urlToken)")
            return Observable.just(true)
        }
    }
}
