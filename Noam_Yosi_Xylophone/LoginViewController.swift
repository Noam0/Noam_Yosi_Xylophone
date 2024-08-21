//
//  LoginViewController.swift
//  Noam_Yosi_Xylophone
//
//  Created by nir nir on 17/08/2024.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    
    @IBAction func loginClicked(_ sender: UIButton) {
        
        
        guard let email = emailTextField.text else { return}
        guard let password = passwordTextField.text else {return }
        
        Auth.auth().signIn(withEmail: email, password: password) { Firebaseresult, error in
           if let e = error {
                print("error")
           }else{
               self.performSegue(withIdentifier: "goToNext", sender: self)
            }
        }
    }
    

}
