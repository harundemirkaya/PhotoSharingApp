//
//  ViewController.swift
//  PhotoSharingApp
//
//  Created by Harun Demirkaya on 26.12.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnLogin(_ sender: Any) {
        if txtFieldEmail.text != "" && txtFieldPassword.text != ""{
            Auth.auth().signIn(withEmail: txtFieldEmail.text!, password: txtFieldPassword.text!) { authDataResult, err in
                if err != nil{
                    self.alertMessage(title: "Error", description: err!.localizedDescription)
                } else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else{
            self.alertMessage(title: "Error", description: "Please fill in all fields")
        }
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        if txtFieldEmail.text != "" && txtFieldPassword.text != ""{
            Auth.auth().createUser(withEmail: txtFieldEmail.text!, password: txtFieldPassword.text!) { authDataResult, err in
                if err != nil{
                    self.alertMessage(title: "Error", description: err!.localizedDescription)
                } else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else{
            self.alertMessage(title: "Error", description: "Please fill in all fields")
        }
    }
    
    func alertMessage(title: String, description: String){
        let alertMessage = UIAlertController(title: title, message: description, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Okey", style: UIAlertAction.Style.default)
        alertMessage.addAction(okButton)
        self.present(alertMessage, animated: true)
        
    }
}

