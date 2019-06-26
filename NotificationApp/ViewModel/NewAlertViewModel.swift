//
//  NewAlertViewModel.swift
//  NotificationApp
//
//  Created by 大川葵 on 2019/06/25.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: NewAlertViewModel
final class NewAlertViewModel: ViewModel {
    
    typealias ViewController = NewAlertViewController
    
    
    // MARK: ViewModel
    
    init(_ viewController: NewAlertViewController) {
        
        self.viewController = viewController
        self.alertDataModel = AlertDataModelImpl()
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    
    
    // MARK: Internal
    
    var alertDataModel: AlertDataModel
    private(set) var dismissToggle = PublishRelay<Void>()
    
    func tapRegisterButton(name: String, hour: Int, minute: Int) {
        
        alertDataModel.createAlertData(name: name, hour: hour, minute: minute)
        dismissToggle.accept(())
    }
}
