//
//  AuthViewController.swift
//  vkNewsClean
//
//  Created by Никита Ломовцев on 18.09.2021.
//

import UIKit
import VK_ios_sdk

class AuthViewController: UIViewController {

    private var authService = SceneDelegate.shared().authService
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
    @IBAction func signInTouch(_ sender: UIButton) {
        authService!.wakeUpSession()
    }
    

}

