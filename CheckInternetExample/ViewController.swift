//
//  ViewController.swift
//  CheckInternetExample
//
//  Created by John Codeos on 3/8/20.
//  Copyright © 2020 John Codeos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var internetStatusLabel: UILabel!

    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability

        switch reachability.connection {
        case .wifi:
            print("Wifi Connection")
            self.internetStatusLabel.text = "Wifi Connection"
        case .cellular:
            print("Cellular Connection")
            self.internetStatusLabel.text = "Cellular Connection"
        case .unavailable:
            print("No Connection")
            self.internetStatusLabel.text = "No Connection"
        case .none:
            print("No Connection")
            self.internetStatusLabel.text = "No Connection"
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
}
