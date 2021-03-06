//
//  UserInfoViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/05/17.
//

import UIKit
import Firebase

struct UserInfoData {
    let icon: String
    let label: String
}

class UserInfoViewController: UIViewController {

    // MARK: - Properties
    var navigation: CustomNavigation!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var infoTableVIew: UITableView!
    
    var tableData: [UserInfoData] = [
        UserInfoData(icon: "heart.text.square", label: "주문 / 배송 내역"),
        UserInfoData(icon: "arrow.left.arrow.right.circle", label: "교환 / 반품 / 취소"),
        UserInfoData(icon: "creditcard", label: "간편결제"),
        UserInfoData(icon: "megaphone", label: "공지사항"),
        UserInfoData(icon: "person.fill.questionmark", label: "자주 묻는 질문"),
        UserInfoData(icon: "plus.message", label: "문의하기")
    ]
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
        
        updateUserLabel()
        
        tableViewDelegate()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        updateUserLabel()

    }
    

    // MARK: - Actions

    
    // MARK: - Helpers
    
    func configureNavigation() {
        navigationController?.navigationBar.isHidden = true
        
        // custom navigation
        self.navigationController?.navigationBar.isHidden = true
        navigation = CustomNavigation(superVC: self)
        
        // init cart and logout button
        navigation.initCartAndLogOutButton()
        
        // delegate
        navigation.logoutDelegate = self
    }

    func updateUserLabel() {
        // change usernameLabel.text
        userLabel.text = User.currentUser?.username
        
    }

    func tableViewDelegate() {
        infoTableVIew.dataSource = self
        infoTableVIew.delegate = self
    }

}

// MARK: - Extension Table View Delegate

extension UserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = infoTableVIew.dequeueReusableCell(withIdentifier: UserCell.id, for: indexPath) as! UserCell
        let value = tableData[indexPath.row]
        cell.configure(value.icon, value.label)
        
        return cell
    }

}

extension UserInfoViewController: LogoutDelegate {

    func handleLogOut() {
        
        // open recipe view controller
        self.tabBarController?.selectedIndex = 0
        
        // log user out
        User.currentUser = nil
        AuthService.shared.signOut()
        
        // reset user defaults
        UserDefaults.standard.removeObject(forKey: K.Firebase.userAddress)
        
        // pop up log in view controller
        guard let logInVC = self.storyboard?.instantiateViewController(withIdentifier: K.id.logInVC) else { return }
        let nav = UINavigationController(rootViewController: logInVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
}
