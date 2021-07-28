//
//  AppDelegate.swift
//  FilmAPI
//
//  Created by Artem  on 06.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let service = FilmNetworkService()
        let assembly = MainAssembly()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = assembly.createMainScreen()
        window?.makeKeyAndVisible()
        return true
        
    }

}

