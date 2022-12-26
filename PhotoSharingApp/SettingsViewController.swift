//
//  SettingsViewController.swift
//  PhotoSharingApp
//
//  Created by Harun Demirkaya on 26.12.2022.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnLogOut(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toSignVC", sender: nil)
        } catch{
            print("Error")
        }
        
    }
}
