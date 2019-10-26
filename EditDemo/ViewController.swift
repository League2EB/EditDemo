//
//  ViewController.swift
//  AlamoFireDemo
//
//  Created by Frank.Chen on 2017/3/11.
//  Copyright © 2017年 Frank.Chen. All rights reserved.
//
import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!

    let viewModel = ViewModel()
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.requestData().subscribe(onNext: { (result) in
            print(result)
        }, onError: { (error) in
            print(error)
        }).disposed(by: self.bag)

        self.viewModel.dataSource.bind(to: self.titleLabel.rx.text).disposed(by: self.bag)
    }
}

