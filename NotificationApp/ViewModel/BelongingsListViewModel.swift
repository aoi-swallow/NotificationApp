//
//  BelongingsListViewModel.swift
//  NotificationApp
//
//  Created by 大川葵 on 2019/06/25.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UserNotifications
import RxSwift
import RxCocoa

final class BelongingsListViewModel: ViewModel {
    
    typealias ViewController = BelongingsListViewController
    
    
    // MARK: ViewModel
    
    init(_ viewController: BelongingsListViewController) {
        
        self.viewController = viewController
        self.alertDataModel = AlertDataModelImpl()
        
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    
    
    // MARK: Internal
    
    var alertDataModel: AlertDataModel
    var alertData: [AlertDataEntity] = []
    private(set) var segueToggle = PublishRelay<Void>()
    private(set) var refreshToggle = PublishRelay<Void>()
    
    func getData() {
        
        self.alertData = alertDataModel.readAlertData()
        refreshToggle.accept(())
    }
    
    func tapAddButton() {
        
        segueToggle.accept(())
    }
    
    func deleteAction(index: Int) {
        
        let uuid = alertData[index].uuid
        alertData.remove(at: index)
        alertDataModel.deleteAlertData(uuid: uuid)
    }
}
