//
//  ViewController.swift
//  IDFASample
//
//  Created by yaiwamoto on 01/12/2020.
//

import UIKit
import AppTrackingTransparency
import AdSupport

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(ASIdentifierManager.shared().isAdvertisingTrackingEnabled, ASIdentifierManager.shared().advertisingIdentifier.uuidString)
        
        if #available(iOS 14, *) {
            switch ATTrackingManager.trackingAuthorizationStatus {
            case .authorized:
                print("Allow Tracking")
                print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
            case .denied:
                print("😭拒否")
                print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
            case .restricted:
                print("🥺制限")
            case .notDetermined:
                // 設定アプリで許可していてダイアログの設定が初回の場合に通る
                showRequestTrackingAuthorizationAlert()
            @unknown default:
                fatalError()
            }
        } else {// iOS14未満
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                print("Allow Tracking")
                print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
            } else {
                print("🥺制限")
            }
        }
    }
    
    ///Alert表示
    private func showRequestTrackingAuthorizationAlert() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                switch status {
                case .authorized:
                    print("🎉")
                    //IDFA取得
                    print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
                case .denied, .restricted, .notDetermined:
                    print("😭")
                @unknown default:
                    fatalError()
                }
            })
        }
    }
} 
