//
//  LoginViewController.swift
//  initgram
//
//  Created by Kelvin Lui on 2/20/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signinButton.layer.cornerRadius = 10
        signupButton.layer.cornerRadius = 10
        
        usernameField.delegate = self
        passwordField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(_ sender: UIButton) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!, block: {(user: PFUser?, error: Error?) -> Void in
            if let user = user {
                print("You signed in as \(user.username!)")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else if let error = error {
                print(error.localizedDescription.description)
            }
        })
    }
    
    @IBAction func onSignUp(_ sender: UIButton) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground{ (success: Bool, error: Error?) -> Void in
            if success {
                print("Created an user.")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
