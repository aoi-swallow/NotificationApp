//
//  AlertDataEntity.swift
//  NotificationApp
//
//  Created by 大川葵 on 2019/06/25.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RealmSwift

// MARK: AlertDataEntity
final class AlertDataEntity: Object {
    
    @objc dynamic var belonging: String = ""
    @objc dynamic var hour: Int = 0
    @objc dynamic var minute: Int = 0
    @objc dynamic var uuid: String = UUID().uuidString
    
    override static func primaryKey() -> String? {
        
        return "uuid"
    }
    
}
