//
//  AlertDataModel.swift
//  NotificationApp
//
//  Created by 大川葵 on 2019/06/25.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RealmSwift
import UserNotifications

// MARK: - AlertDataModel
protocol AlertDataModel {
    
    func createAlertData(name: String, hour: Int, minute: Int)
    func readAlertData() -> [AlertDataEntity]
    func deleteAlertData(uuid: String)
}

class AlertDataModelImpl: AlertDataModel {
    
    let realm = try! Realm()
    let center = UNUserNotificationCenter.current()
    
    func createAlertData(name: String, hour: Int, minute: Int) {
        
        let alertData = AlertDataEntity()
        alertData.belonging = name
        alertData.hour = hour
        alertData.minute = minute
        
        try! realm.write {
            self.realm.add(alertData)
        }
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print(error)
        }
        let content = UNMutableNotificationContent()
        
        content.title = NSString.localizedUserNotificationString(forKey: "携行品チェック", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "\(name)持った？", arguments: nil)
        content.sound = UNNotificationSound.default
        
        var date = DateComponents()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        date.hour = hour
        formatter.dateFormat = "mm"
        date.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let request = UNNotificationRequest(identifier: name, content: content, trigger: trigger)
        
        // 通知を登録
        center.add(request) { (error : Error?) in
            if error != nil {
                print(error)
            }
        }
    }
    
    func readAlertData() -> [AlertDataEntity] {
        
        let data = Array(realm.objects(AlertDataEntity.self))
        return data
    }
    
    func deleteAlertData(uuid: String) {
        
        let selected = realm.object(ofType: AlertDataEntity.self, forPrimaryKey: uuid)
        center.removePendingNotificationRequests(withIdentifiers: [selected!.belonging])
        try! realm.write {
            self.realm.delete(selected!)
        }
    }
}
