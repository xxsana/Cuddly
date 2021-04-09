//
//  CustomNavigationController.swift
//  Cuddly
//
//  Created by Haru on 2021/04/09.
//

import UIKit

class CustomNavigationController {
    
    let height = 67
    var width: Int!
    let navigationY = 39
    let buttonY = 54
    let superVC: UIViewController!
    var csNavigationBar: UIView!
    
    init(superVC: UIViewController) {
        self.superVC = superVC
        self.width = Int(superVC.view.frame.width)
    }
    
    func setUpNavigationBar() {
        csNavigationBar = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        superVC.view.addSubview(csNavigationBar)
    }
    
    func setTitle(as title: String) {
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: navigationY, width: width, height: height))

        // attributes
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        titleLabel.text = title

        // add to navigation bar
        self.csNavigationBar.addSubview(titleLabel)
    }
    
    func backButton() {
        
        // constants
        let imageSize: CGFloat = 16.0
        let buttonSize = 30
        let trailingX = 15
        
        let backButton = UIButton(type: .system)
        
        // attributes
        let backImage = UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: imageSize, weight: .medium))
        backButton.setImage(backImage, for: .normal)
        backButton.frame = CGRect(x: trailingX, y: buttonY, width: buttonSize, height: buttonSize)
        backButton.tintColor = .black
        
        // add to navigation bar
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)

        // add action method
        self.superVC.view.addSubview(backButton)
    }
    
    
    func shareAndBookmarkButton() {

        // constants
        let buttonWidth = 35
        let buttonHeight = 30
        let imageSize: CGFloat = 16.0
        let trailingX = 15
        let rightX = self.width - trailingX + 2
        
        // buttons (right first)
        let bookmarkImage = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: imageSize, weight: .medium))
        let bookmarkButton = UIButton(type: .system)
        bookmarkButton.setImage(bookmarkImage, for: .normal)
        bookmarkButton.frame = CGRect(x: rightX - buttonWidth, y: buttonY, width: buttonWidth, height: buttonHeight)
        bookmarkButton.tintColor = .black
        
        let shareImage = UIImage(systemName: "paperplane", withConfiguration: UIImage.SymbolConfiguration(pointSize: imageSize, weight: .medium))
        let shareButton = UIButton(type: .system)
        shareButton.setImage(shareImage, for: .normal)
        shareButton.frame = CGRect(x: rightX - buttonWidth*2, y: buttonY, width: buttonWidth, height: buttonHeight)
        shareButton.tintColor = .black
        
        // add to navigation bar
        self.csNavigationBar.addSubview(bookmarkButton)
        self.csNavigationBar.addSubview(shareButton)
        
        // add action method
        shareButton.addTarget(self, action: #selector(shareClicked), for: .touchUpInside)
        bookmarkButton.addTarget(self, action: #selector(bookmarkClicked), for: .touchUpInside)
    }
    
    @objc func goBack() {
        superVC.dismiss(animated: true, completion: nil)
    }
    
    @objc func shareClicked() {
        print("share clicked")
    }
    
    @objc func bookmarkClicked() {
        print("bookmark clicked")
    }
}


