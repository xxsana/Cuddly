//
//  CustomNavigationController.swift
//  Cuddly
//
//  Created by Haru on 2021/04/09.
//

import UIKit

class CustomNavigation {
    
    // MARK: - Properties
    
    let height = 88
    var width: Int {
        return Int(superVC.view.frame.width)
    }
    
    let superVC: UIViewController!
    var csNavigationBar: UIView!
    var rightContainer: UIView!
    let itemPointSize: CGFloat = 16.0
    
    
    // MARK: - Configure
    
    init(superVC: UIViewController) {
        self.superVC = superVC
        self.configureBar()
    }
    
    private func configureBar() {
        csNavigationBar = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        superVC.view.addSubview(csNavigationBar)
    }
    

    // MARK: - Title
    
    // add navigation title using given parameter
    func setTitle(as title: String) {
        
        let titleLabel = UILabel()
        self.csNavigationBar.addSubview(titleLabel)

        // attributes
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        titleLabel.sizeToFit()
        titleLabel.text = title
        
        setTitleConstraints(titleLabel)
    }
    
    // MARK: - BackButton
    
    func initBackButton(dismiss: Bool = false, tintWhite: Bool = false) {
        
        let backButton = UIButton(type: .system)
        csNavigationBar.addSubview(backButton)
        
        configureButtonItem(backButton, imageName: "chevron.backward", tintWhite)
        
        setBackButtonConstraint(backButton)
        
        // add action method
        if dismiss == false {
            backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        } else {
            // call dismiss method. use for RecipeStepVC
            backButton.addTarget(self, action: #selector(goDismiss), for: .touchUpInside)
        }
    }
    
    
    // MARK: - RightButtonItems
    
    // add cart button on right
    func initCartButton() {
        
        configureRightContainer()
        
        let cartButton = UIButton(type: .system)
        self.rightContainer.addSubview(cartButton)
        
        configureButtonItem(cartButton, imageName: "cart", false)
        setOneItemConstraint(item: cartButton)
        
        // add action method
        cartButton.addTarget(self, action: #selector(cartClicked), for: .touchUpInside)
    }

    
    // add share button and bookmark button on right
    func initShareAndBookmarkButton(tintWhite: Bool = false) {

        configureRightContainer()
        
        let shareButton = UIButton(type: .system)
        let bookmarkButton = UIButton(type: .system)
        
        self.rightContainer.addSubview(shareButton)
        self.rightContainer.addSubview(bookmarkButton)
        
        configureButtonItem(shareButton, imageName: "paperplane", tintWhite)
        configureButtonItem(bookmarkButton, imageName: "heart", tintWhite)
        
        setTwoItemsConstraint(left: shareButton, right: bookmarkButton)

        // add action method
        shareButton.addTarget(self, action: #selector(shareClicked), for: .touchUpInside)
        bookmarkButton.addTarget(self, action: #selector(bookmarkClicked), for: .touchUpInside)
    }
    
    

    
    // MARK: - Selectors
    
    @objc func goBack() {
        superVC.navigationController?.popViewController(animated: true)
    }
    
    @objc func goDismiss() {
        superVC.dismiss(animated: true, completion: nil)
    }
    
    @objc func shareClicked() {
        print("share clicked")
    }
    
    @objc func bookmarkClicked() {
        print("bookmark clicked")
    }

    @objc func cartClicked() {
        print("cart clicked")
    }

    
    // MARK: - ConfigureMethods
    
    private func configureRightContainer() {
        // Properties
        let containerWidth = superVC.view.frame.width * 0.18
        let containerHeight = itemPointSize * 2
        
        rightContainer = UIView()
        self.csNavigationBar.addSubview(rightContainer)
        
        rightContainer.translatesAutoresizingMaskIntoConstraints = false
        rightContainer.trailingAnchor.constraint(equalTo: csNavigationBar.trailingAnchor, constant: -21).isActive = true
        rightContainer.bottomAnchor.constraint(equalTo: csNavigationBar.bottomAnchor, constant: -5).isActive = true
        rightContainer.widthAnchor.constraint(equalToConstant: containerWidth).isActive = true
        rightContainer.heightAnchor.constraint(equalToConstant: containerHeight).isActive = true
    }
    
    private func configureButtonItem(_ button: UIButton, imageName: String, _ tintWhite: Bool) {
        
        let image = UIImage(systemName: imageName, withConfiguration: UIImage.SymbolConfiguration(pointSize: itemPointSize, weight: .medium))
        button.setImage(image, for: .normal)
        if tintWhite {
            button.tintColor = .white
        } else {
            button.tintColor = .black
        }
    }

    // MARK: - Constraint
    
    private func setTitleConstraints(_ title: UILabel) {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerXAnchor.constraint(equalTo: csNavigationBar.centerXAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: csNavigationBar.bottomAnchor, constant: -10).isActive = true
    }
    
    func setBackButtonConstraint(_ button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bottomAnchor.constraint(equalTo: csNavigationBar.bottomAnchor, constant: -14).isActive = true
        button.leadingAnchor.constraint(equalTo: csNavigationBar.leadingAnchor, constant: 25).isActive = true
    }
    
    func setOneItemConstraint(item: UIButton) {
        item.translatesAutoresizingMaskIntoConstraints = false
        item.trailingAnchor.constraint(equalTo: rightContainer.trailingAnchor).isActive = true
        item.centerYAnchor.constraint(equalTo: rightContainer.centerYAnchor).isActive = true
    }
    
    func setTwoItemsConstraint(left: UIButton, right: UIButton) {
        
        right.translatesAutoresizingMaskIntoConstraints = false
        right.trailingAnchor.constraint(equalTo: rightContainer.trailingAnchor).isActive = true
        right.centerYAnchor.constraint(equalTo: rightContainer.centerYAnchor).isActive = true
        
        left.translatesAutoresizingMaskIntoConstraints = false
        left.trailingAnchor.constraint(equalTo: right.leadingAnchor, constant: -7).isActive = true
        left.centerYAnchor.constraint(equalTo: rightContainer.centerYAnchor).isActive = true
    }
    
}
