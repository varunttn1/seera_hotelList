//
//  AppDelegate.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        self.appCoordinator = AppCoordinator(window: window!)
        self.appCoordinator.start()
        setAppLanguageOnLaunch()
        return true
    }

    func setAppLanguageOnLaunch() {
        if let localLang = Locale.preferredLanguages.first {
            print(localLang)
            let deviceLanguage = localLang.components(separatedBy: "-")
            print(deviceLanguage.first!)
            print(getAppLanguage)
//            if getAppLanguage() == languageNone {
                if languageEn == deviceLanguage.first {
                    setAppLanguage(languageCode: languageEn)
                }else if languageAr == deviceLanguage.first {
                    setAppLanguage(languageCode: languageAr)
                }else {
                    setAppLanguage(languageCode: languageAr)
                }
//            }
        }
    }
    
    


}

