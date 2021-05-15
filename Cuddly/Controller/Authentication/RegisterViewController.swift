//
//  RegisterViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/05/14.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationController?.navigationBar.backgroundColor = .clear
//        self.navigationItem.backBarButtonItem?.tintColor = .white
        self.navigationController?.navigationBar.tintColor = .black
    }

    // MARK: - Selectors
    
    @IBAction func registerInButtonClicked(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let userName = userNameTextField.text  else {print("DEBUG: emptied any text field"); return}
        
        let credentials = AuthCredentials(email: email, password: password, userName: userName)
        
        AuthService.shared.registerUser(credentials: credentials) { error, reference in
            // whatever happens in this completion block means that sign up process has completed
            // successfully registered and logged in
            // use root view controller's method
            
            // get key window
            guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {return}
            
            // get root vc
            guard let tab = keyWindow.rootViewController as? CustomTabBarController else {return}
            
            tab.authenticateUserAndConfigureUI()
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Helpers
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
