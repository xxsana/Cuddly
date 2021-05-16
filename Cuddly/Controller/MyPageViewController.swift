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
    
    var user: User? {
        didSet {
            print("DEBUG: Didset user in My page controlelr..")
//            testLabel.text = user?.username
        }
    }
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
//        print("DEBUG: MyPage view did load")
//        testLabel.text = user?.username
//        print("DEBUG: email : \(user?.email)")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        testLabel.text = user?.username
//        print("DEBUG: MyPage view will appear")
    }
    

    // MARK: - Actions
    @IBAction func logOutTempClicked(_ sender: Any) {
        AuthService.shared.signOut()
    }
    

}
