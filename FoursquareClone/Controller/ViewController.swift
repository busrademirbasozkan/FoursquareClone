//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Büşra Özkan on 8.01.2023.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
    }

    //Sign In İşlemleri
    @IBAction func signInButton(_ sender: Any) {
        if userNameText.text != "" && passwordText.text != ""{
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { (user, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    //Segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
        }else{
            makeAlert(titleInput: "Error", messageInput: "UserName or Password is nil")
        }
        
    }
    
    
    //Sign Up İşlemleri
    @IBAction func signUpButton(_ sender: Any) {
        if userNameText.text != "" && passwordText.text != "" {
            let user = PFUser()
            user.username = userNameText.text!
            user.password = passwordText.text!
            
            user.signUpInBackground { (success, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    //Segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
        }else{
            makeAlert(titleInput: "Error", messageInput: "UserName or Password is nil")
        }
        
    }
    
    
    //Hata Mesajı
    func makeAlert(titleInput : String , messageInput : String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

