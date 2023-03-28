//
//  LoginViewController.swift
//  LegoMinifig
//
//  Created by Nicola Rigoni on 22/03/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let loginManager: LoginManager = LoginManager()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        checkUserLoggedIn()
    }
     
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
//    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        print("login pressed")
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text
        else { return }
        performLogin(email: email, password: password)
    }
    
    private func checkUserLoggedIn() {
        if let token = defaults.string(forKey: "user_token"), token != ""  {
            print("check login \(token)")
            segue()
        }
    }
    
    private func performLogin(email: String, password: String) {
        Task {
            do {
                if let userToken = try await loginManager.fetchUserToken(email: email, password: password) {
                    defaults.set(userToken, forKey: "user_token")
                    segue()
                }
                
            } catch {
                print("catched error \(error.localizedDescription)")
            }
            
        }
    }
    
    private func segue() {
        emailTextField.text = ""
        passwordTextField.text = ""
        self.performSegue(withIdentifier: "goToYourMinifigures", sender: self)
        
    }
    
    

}
