//
//  TeestTabController.swift
//  Cuddly
//
//  Created by Haru on 2021/05/17.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {

    // MARK: - Properties
    
    let customTabBar = UIView()
    let tabItem01Home = CustomTabBarItem()
    let tabItem02Shop = CustomTabBarItem()
    let tabItem03Bookmark = CustomTabBarItem()
    let tabItem04MyPage = CustomTabBarItem()
    
    var user: User? {
        didSet {
            // 값이 set 되었을 때 실행 될 메소드
            print("DEBUG: Did set user in main tab..")
            
//            guard let nav = viewControllers?[3] as? UINavigationController else {return}
//
//            guard let myPage = nav.viewControllers.last as? MyPageViewController else {return}
//
//            myPage.user = user

        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {

        configureViewControllers()
        authenticateUser()
        fetchUser()

    }
    
    // MARK: - API
    
    // check if user is logged in
    func authenticateUser() {
        if Auth.auth().currentUser == nil {
            print("DEBUG: User is NOT logged in")
            
            // present Log in view controller
            DispatchQueue.main.async {
                guard let logInVC = self.storyboard?.instantiateViewController(withIdentifier: K.id.logInVC) else { return }
                let nav = UINavigationController(rootViewController: logInVC)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            print("DEBUG: User is logged in")
        }
    }
    
    func fetchUser() {
        UserService.shared.fetchUser { user in
            self.user = user
        }
    }
    
    // MARK: - Selectors
    
    @objc func tabItemClickedForMain(_ sender: CustomTabBarItem) {
        
        // reset isSelected
        self.tabItem01Home.isSelected = false
        self.tabItem02Shop.isSelected = false
        self.tabItem03Bookmark.isSelected = false
        self.tabItem04MyPage.isSelected = false
        
        sender.isSelected = true
        
        self.selectedIndex = sender.tag

    }
    
    // MARK: - Helpers
    
    func configureViewControllers() {
        
        // Hide original TabBar
        tabBar.isHidden = true
        
        // TabBar size
        let width = self.view.frame.width
        let height: CGFloat = 90
        let x: CGFloat = 0
        let y = self.view.frame.height - height
        
        self.customTabBar.frame = CGRect(x: x, y: y, width: width, height: height)
        self.customTabBar.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.00)
        
        // add subview
        self.view.addSubview(customTabBar)
        
        // origin(point) of tabItems, height width는 있음
        let tabItemWidth = self.customTabBar.frame.size.width / 4
        
        // set image and title
        self.tabItem01Home.setImageAndTitle(title: "홈", imageSystemName: "house", tag: 0)
        self.tabItem02Shop.setImageAndTitle(title: "마켓", imageSystemName: "bag", tag: 1)
        self.tabItem03Bookmark.setImageAndTitle(title: "저장 목록", imageSystemName: "heart", tag: 2)
        self.tabItem04MyPage.setImageAndTitle(title: "마이페이지", imageSystemName: "person.circle", tag: 3)
        
        let items = [tabItem01Home, tabItem02Shop, tabItem03Bookmark, tabItem04MyPage]
        
        var widthValue: CGFloat = 0
        for item in items {
            // add subview
            self.customTabBar.addSubview(item)
            
            // arrange items with x
            item.frame.origin.x = widthValue
            widthValue += tabItemWidth
            
            // action method
            item.addTarget(self, action: #selector(tabItemClickedForMain), for: .touchUpInside)
            
            // align center
            guard let imageWidth = item.imageView?.frame.width else { return }
            
            guard let titleWidth = item.titleLabel?.frame.width else { return }
            
            item.alignImageAndTitleCenter(image: imageWidth, title: titleWidth)
        }
    }
        
}
