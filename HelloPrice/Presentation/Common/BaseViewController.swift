//
//  BaseViewController.swift
//  HelloPrice
//
//  Created by devming on 2020/06/04.
//  Copyright © 2020 besteyes. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController<T: ViewModelType>: UIViewController, ViewModelBindableControllerType {
    
    var 👜 = DisposeBag()
    var viewModel: T!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModel() { }
}
