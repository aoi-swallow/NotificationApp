//
//  ViewModelBase.swift
//  Bizoom
//
//  Created by 大川葵 on 2019/05/22.
//  Copyright © 2019 Nexceed. All rights reserved.
//

protocol ViewModel {
    associatedtype ViewController
    init(_ viewController: ViewController)
}
