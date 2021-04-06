//
//  CustomTabBarController.swift
//  Cuddly
//
//  Created by Haru on 2021/04/05.
//

import UIKit

class CustomTabBarController: UITabBarController {

    let customView = UIView()
    let tabItem01Home = CustomTabBarItem()
    let tabItem02Shop = CustomTabBarItem()
    let tabItem03Bookmark = CustomTabBarItem()
    let tabItem04MyPage = CustomTabBarItem()
    
    override func viewDidLoad() {
//        super.viewDidLoad()

        // Hide original TabBar 기존 탭바 숨기기
        tabBar.isHidden = true
        
        // TabBar size
        let width = self.view.frame.width
        let height: CGFloat = 90
        let x: CGFloat = 0
        let y = self.view.frame.height - height
        
        self.customView.frame = CGRect(x: x, y: y, width: width, height: height)
        self.customView.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.00)
        
        // add subview
        self.view.addSubview(customView)
        
        // origin(point) of tabItems, height width는 있음
        let tabItemWidth = self.customView.frame.size.width / 4
        
        // arrange items with x
        self.tabItem01Home.frame.origin.x = 0
        self.tabItem02Shop.frame.origin.x = tabItemWidth
        self.tabItem03Bookmark.frame.origin.x = tabItemWidth * 2
        self.tabItem04MyPage.frame.origin.x = tabItemWidth * 3
        
        // set image and title
        self.tabItem01Home.setImageAndTitle(title: "홈", imageSystemName: "house", tag: 0)
        self.tabItem02Shop.setImageAndTitle(title: "마켓", imageSystemName: "bag", tag: 1)
        self.tabItem03Bookmark.setImageAndTitle(title: "저장 목록", imageSystemName: "heart", tag: 2)
        self.tabItem04MyPage.setImageAndTitle(title: "마이페이지", imageSystemName: "person.circle", tag: 3)
 
        
        let items = [tabItem01Home, tabItem02Shop, tabItem03Bookmark, tabItem04MyPage]
        
        for item in items {
            // action method
            item.addTarget(self, action: #selector(tabItemClicked), for: .touchUpInside)
            
            // add subview
            self.customView.addSubview(item)
            
            // align center
            guard let imageWidth = item.imageView?.frame.width
            else { print("fail to unwrap item.imageView?.frame.width"); return}
            
            guard let titleWidth = item.titleLabel?.frame.width
            else { print("fail to unwrap item.titleLabel?.frame.width"); return}
            
            item.alignImageAndTitleCenter(image: imageWidth, title: titleWidth)
        }
        
    }
    
    @objc func tabItemClicked(_ sender: CustomTabBarItem) {
        // reset isSelected
        self.tabItem01Home.isSelected = false
        self.tabItem02Shop.isSelected = false
        self.tabItem03Bookmark.isSelected = false
        self.tabItem04MyPage.isSelected = false
        
        sender.isSelected = true
        
        self.selectedIndex = sender.tag
    }


}
