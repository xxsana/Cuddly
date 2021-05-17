//
//  MyPageViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/05/17.
//

import UIKit
import Firebase

class MyPageViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var testLabel: UILabel?
    var navigation: CustomNavigation!
    var lbl: UILabel!

    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("DEBUG: MyPage view will appear")
        configureTestLabel()

    }
    

    // MARK: - Actions
    @IBAction func logOutTempClicked(_ sender: Any) {
        AuthService.shared.signOut()
    }
    
    // MARK: - Helpers
    
    func configureNavigation() {
        navigationController?.navigationBar.isHidden = true
        
        // custom navigation
        self.navigationController?.navigationBar.isHidden = true
        navigation = CustomNavigation(superVC: self)
        navigation.setTitle(as: "마이페이지")
        navigation.initCartButton()
    }
    
    func configureTestLabel() {

        testLabel?.text = User.currentUser?.username
    }

    

}


