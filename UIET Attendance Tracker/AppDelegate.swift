//
//  AppDelegate.swift
//  UIET Attendance Tracker
//
//  Created by Harshit Jindal on 16/07/19.
//  Copyright © 2019 Harshit Jindal. All rights reserved.
//

import UIKit
import UserNotifications
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    let notificationCenter = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        do {
            print(Realm.Configuration.defaultConfiguration.fileURL)
            _ = try Realm()
        } catch {
            print(error.localizedDescription)
        }
        
        let notificationsRegisteredKey = "enabled"
        let defaults = UserDefaults.standard
        var notificationsRegistered = defaults.bool(forKey: notificationsRegisteredKey)
        if !notificationsRegistered {
            defaults.set(true, forKey: notificationsRegisteredKey)
        }
        
        if notificationsRegistered {
            print("Notifications Registered")
            registerDailyNotifications()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func registerDailyNotifications() {
        //Confirm Delegete and request for permission
        notificationCenter.delegate = self
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
        
        content.title = "Daily Attendance Reminder"
        content.body = "Please Mark Your Attendance"
        
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.hour = 17    // 17:00 hours
        //        let dateMatching = Calendar.current.dateComponents([.weekday, .hour], from: DateComponents(hour: 17))
        
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }


}
