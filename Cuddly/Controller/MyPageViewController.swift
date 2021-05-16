//
//  MyPageViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/05/17.
//

import UIKit

class MyPageViewController: UIViewController {

    // MARK: - Properties
    
    var user: User? {
        didSet {
            print("DEBUG: Didset user in My page controlelr..")
        }
    }
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        testLabel.text = user?.email
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
