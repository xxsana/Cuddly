//
//  FakeTabBarController.swift
//  Cuddly
//
//  Created by Haru on 2021/04/06.
//

import UIKit

struct RecipeTabBarController {
    
    let superVC: UIViewController
    
    let customTabBar = UIView()
    
    let tabItem01Home = CustomTabBarItem()
    let tabItem02Comment = CustomTabBarItem()
    let tabItem03Bookmark = CustomTabBarItem()
    let tabItem04LinkedProduct = CustomTabBarItem()
    
    init(superView: UIViewController) {
        
        self.superVC = superView
        
        // TabBar size
        let width = self.superVC.view.frame.width
        let height: CGFloat = 90
        let x: CGFloat = 0
        let y = self.superVC.view.frame.height - height
        
        self.customTabBar.frame = CGRect(x: x, y: y, width: width, height: height)
        self.customTabBar.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.00)
        
        // add subview
        self.superVC.view.addSubview(customTabBar)
        
        // origin(point) of tabItems, height width는 있음
        let tabItemWidth = self.customTabBar.frame.size.width / 4
        
        // arrange items with x
        self.tabItem01Home.frame.origin.x = 0
        self.tabItem02Comment.frame.origin.x = tabItemWidth
        self.tabItem03Bookmark.frame.origin.x = tabItemWidth * 2
        self.tabItem04LinkedProduct.frame.origin.x = tabItemWidth * 3
        
        // set image and title
        self.tabItem01Home.setImageAndTitle(title: "홈", imageSystemName: "house", tag: 0)
        self.tabItem02Comment.setImageAndTitle(title: "댓글", imageSystemName: "square.and.pencil", tag: 1)
        self.tabItem03Bookmark.setImageAndTitle(title: "저장 목록", imageSystemName: "heart", tag: 2)
        self.tabItem04LinkedProduct.setImageAndTitle(title: "관련제품", imageSystemName: "cart", tag: 3)
        
        let items = [tabItem01Home, tabItem02Comment, tabItem03Bookmark, tabItem04LinkedProduct]
        
        for item in items {
            //// LATER -- action method
//            item.addTarget(self, action: #selector(tabItemClickedForMain), for: .touchUpInside)
            
            // add subview
            self.customTabBar.addSubview(item)
            
            // align center
            guard let imageWidth = item.imageView?.frame.width
            else { print("fail to unwrap item.imageView?.frame.width"); return}
            
            guard let titleWidth = item.titleLabel?.frame.width
            else { print("fail to unwrap item.titleLabel?.frame.width"); return}
            
            item.alignImageAndTitleCenter(image: imageWidth, title: titleWidth)
        }
    }
  
    //// LATER --
//    @objc func tabItemClickedForMain(_ sender: CustomTabBarItem) {
//
//
//        // reset isSelected
//        self.tabItem01Home.isSelected = false
//        self.tabItem02Shop.isSelected = false
//        self.tabItem03Bookmark.isSelected = false
//        self.tabItem04MyPage.isSelected = false
//
//        sender.isSelected = true
//
//        self.selectedIndex = sender.tag
//
//
//    }
}
