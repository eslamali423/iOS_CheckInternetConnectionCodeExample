//
//  ViewController.swift
//  CheckInternetConnection
//
//  Created by Eslam Ali  on 31/03/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "home"
        if NetworkMonitor.shared.isConnected {
            print("you're connected")
        }else  {
            print("you're not connected")
            let alert = UIAlertController(title: "Internet Connection", message: "No Internet Connection, please connect the Internet", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }


}

