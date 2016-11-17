//
//  ViewController.swift
//  UIDevice
//
//  Created by 彭盛凇 on 2016/11/17.
//  Copyright © 2016年 huangbaoche. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let device = UIDevice.current
     
        device.beginGeneratingDeviceOrientationNotifications()                               //通知 开关，默认开
        device.isBatteryMonitoringEnabled = true                                             //是否开启 电池信息检查
        device.isProximityMonitoringEnabled = true                                           //是否开启 顶部控制器
        device.playInputClick()
        
        print("device.name----------------------\(device.name)")                             //设备名称
        print("device.model---------------------\(device.model)")                            //设备模式
        print("device.localizedModel------------\(device.localizedModel)")                   //本地设备模式
        print("device.systemName----------------\(device.systemName)")                       //系统名称
        print("device.systemVersion-------------\(device.systemVersion)")                    //系统版本号
        print("device.identifierForVendor-------\(device.identifierForVendor)")              //UUID 6.0之后
        print("device.isMultitaskingSupported---\(device.isMultitaskingSupported)")
        print("device.userInterfaceIdiom--------\(device.userInterfaceIdiom.hashValue)")               //设备交互界面类型

        /*！ 设备交互界面类型
         typedef NS_ENUM(NSInteger, UIUserInterfaceIdiom) {
         UIUserInterfaceIdiomUnspecified = -1,
         UIUserInterfaceIdiomPhone NS_ENUM_AVAILABLE_IOS(3_2), // iPhone and iPod touch style UI
         UIUserInterfaceIdiomPad NS_ENUM_AVAILABLE_IOS(3_2), // iPad style UI
         UIUserInterfaceIdiomTV NS_ENUM_AVAILABLE_IOS(9_0), // Apple TV style UI
         };
         */

        if device.isGeneratingDeviceOrientationNotifications {
            NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        }
        
        //顶部控制器
        NotificationCenter.default.addObserver(self, selector: #selector(deviceProximityStateDidChange), name: NSNotification.Name.UIDeviceProximityStateDidChange, object: nil)
        //电池
        NotificationCenter.default.addObserver(self, selector: #selector(deviceBatteryStateDidChange), name: NSNotification.Name.UIDeviceBatteryStateDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deviceBatteryLevelDidChange), name: NSNotification.Name.UIDeviceBatteryLevelDidChange, object: nil)
        
    }
    
    func deviceOrientationDidChange() {
        
        print("device.orientation----------------\(UIDevice.current.orientation.hashValue)")
        
        /*! 上 下 左 右 正 反
         typedef NS_ENUM(NSInteger, UIDeviceOrientation) {
         UIDeviceOrientationUnknown,
         UIDeviceOrientationPortrait,            // Device oriented vertically, home button on the bottom
         UIDeviceOrientationPortraitUpsideDown,  // Device oriented vertically, home button on the top
         UIDeviceOrientationLandscapeLeft,       // Device oriented horizontally, home button on the right
         UIDeviceOrientationLandscapeRight,      // Device oriented horizontally, home button on the left
         UIDeviceOrientationFaceUp,              // Device oriented flat, face up
         UIDeviceOrientationFaceDown             // Device oriented flat, face down
         } __TVOS_PROHIBITED;
         */
        
        
        // 系统默认 inline 函数，判断是否竖屏，横屏，其实就是 上面的 （上或者下）和 （左或者右）。
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            print("Portrait")
        }
        
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            print("Landscape")
        }

    }
    // 是否 接近 顶部的 距离传感器（正中央上面的原点！贴膜的朋友，可以看到膜是缺口的哦~），遮住屏幕会变黑，打电话时贴脸就黑一样，对应有通知。
    func deviceProximityStateDidChange() {
        
        if UIDevice.current.proximityState {
            print("要遮住了")
        }else {
             print("走开了")
        }
        
    }
    //MARK: 电池相关🔋
    func deviceBatteryStateDidChange() {
        print("device.batteryState--------------\(UIDevice.current.batteryState.rawValue)")
        
        /*
         public enum UIDeviceBatteryState : Int {
         
         
         case unknown
         
         case unplugged // on battery, discharging
         
         case charging // plugged in, less than 100%
         
         case full // plugged in, at 100%
         }

         */
    }
    
    func deviceBatteryLevelDidChange() {
        print("device.batteryLevel--------------\(UIDevice.current.batteryLevel)")                     //电量 手机显示%97 打印0.97
    }
    

    
}

