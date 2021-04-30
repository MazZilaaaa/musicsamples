//
//  AppDelegate.swift
//  audioTest
//
//  Created by Mike Lazer-Walker on 6/14/16.
//  Copyright © 2016 Mike Lazer-Walker. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
    }

}

