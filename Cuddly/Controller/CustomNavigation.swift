//
//  CustomNavigationController.swift
//  Cuddly
//
//  Created by Haru on 2021/04/09.
//

import UIKit

protocol CustomNavigationDelegate: UIViewController {
    func handleLogOut()
}

class CustomNavigation {
    
    // MARK: - Properties
    
    var delegate: CustomNavigationDelegate?
    
    let height = 88
    var width: Int {
        return Int(superVC.view.frame.width)
    }
    
    let superVC: UIViewController!
    var csNavigationBar: UIView!
    var rightContainer: UIView!
    var userContainer: UIButton!
    var userImageView: UIImageView!
    var usernameLabel: UILabel!
    
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
    
    // MARK: - LeftButtonItems
    
    func initBackButton(tintWhite: Bool = false, dismiss: Bool = false, showTab: Bool = false) {
        
        let backButton = UIButton(type: .system)
        
        csNavigationBar.addSubview(backButton)
        
        configureButtonItem(backButton, imageName: "chevron.backward", tintWhite)
        
        setBackButtonConstraint(backButton)
        
        // add action method
        if dismiss == false {
            if showTab {
                backButton.addTarget(self, action: #selector(goBackWithShowingTab), for: .touchUpInside)
            } else {
                backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
            }
            
        } else {
            // call dismiss method. use for RecipeStepVC
            backButton.addTarget(self, action: #selector(goDismiss), for: .touchUpInside)
        }
    }
    
    
    // MARK: - RightButtonItems
    
    // add cart button on right
    func initCartButton(tintWhite: Bool = false) {
        
        configureRightContainer()
        
        let cartButton = UIButton(type: .system)
        self.rightContainer.addSubview(cartButton)
        
        configureButtonItem(cartButton, imageName: "cart", tintWhite)
        setOneItemConstraint(item: cartButton)
        
        // add action method
        cartButton.addTarget(self, action: #selector(cart), for: .touchUpInside)
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
        shareButton.addTarget(self, action: #selector(shareURL), for: .touchUpInside)
        bookmarkButton.addTarget(self, action: #selector(bookmark), for: .touchUpInside)
    }
    
    // add cart button and logOut button on right
    func initCartAndLogOutButton() {
        
        configureRightContainer()
        
        let cartButton = UIButton(type: .system)
        let logOutButton = UIButton(type: .system)
        
        self.rightContainer.addSubview(cartButton)
        self.rightContainer.addSubview(logOutButton)
        
        configureButtonItem(cartButton, imageName: "cart")
        configureButtonItem(logOutButton, imageName: "power")
        
        setTwoItemsConstraint(left: cartButton, right: logOutButton)
        
        // add action method
        cartButton.addTarget(self, action: #selector(cart), for: .touchUpInside)
        logOutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }

    
    // MARK: - Selectors
    
    @objc func goBack() {
        superVC.navigationController?.popViewController(animated: true)
    }
    
    @objc func goBackWithShowingTab() {
        let tab = superVC.tabBarController as! MainTabController
        tab.showTabBar()
        superVC.navigationController?.popViewController(animated: true)
    }
    
    @objc func goDismiss() {
        superVC.dismiss(animated: true, completion: nil)
    }
    
    @objc func shareURL() {
        print("DEBUG: share clicked")
    }
    
    @objc func bookmark() {
        print("DEBUG: bookmark clicked")
    }

    @objc func cart() {

        guard let vc = superVC.storyboard?.instantiateViewController(withIdentifier: K.id.cartVC) else { return }
        self.superVC.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func logout() {
        
        // check once to user by alert 
        let alertVC = UIAlertController(title: nil, message: "로그아웃 하시겠습니까?", preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "로그아웃", style: .destructive, handler: { _ in
            self.delegate?.handleLogOut()
        }))
        alertVC.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        delegate?.present(alertVC, animated: true, completion: nil)

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
    
    private func configureButtonItem(_ button: UIButton, imageName: String, _ tintWhite: Bool = false) {
        
        let image = UIImage(systemName: imageName, withConfiguration: UIImage.SymbolConfiguration(pointSize: itemPointSize, weight: .medium))
        button.setImage(image, for: .normal)
        if tintWhite {
            button.tintColor = .white
        } else {
            button.tintColor = .black
        }
    }
    
    private func configureUserContainer() {
        // Properties
        let containerWidth = superVC.view.frame.width * 0.38
        let containerHeight = itemPointSize * 4
    
        userContainer.backgroundColor = .cyan
        
        userContainer.translatesAutoresizingMaskIntoConstraints = false
        userContainer.leadingAnchor.constraint(equalTo: csNavigationBar.leadingAnchor).isActive = true
        userContainer.bottomAnchor.constraint(equalTo: csNavigationBar.bottomAnchor, constant: 24 ).isActive = true
        csNavigationBar.backgroundColor = .blue
        
        userContainer.widthAnchor.constraint(equalToConstant: containerWidth).isActive = true
        userContainer.heightAnchor.constraint(equalToConstant: containerHeight).isActive = true
    }
    

    // MARK: - Constraint
    
    private func setTitleConstraints(_ title: UILabel) {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerXAnchor.constraint(equalTo: csNavigationBar.centerXAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: csNavigationBar.bottomAnchor, constant: -10).isActive = true
    }
    
    private func setBackButtonConstraint(_ button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bottomAnchor.constraint(equalTo: csNavigationBar.bottomAnchor, constant: -14).isActive = true
        button.leadingAnchor.constraint(equalTo: csNavigationBar.leadingAnchor, constant: 25).isActive = true
    }
    
    private func setOneItemConstraint(item: UIButton) {
        item.translatesAutoresizingMaskIntoConstraints = false
        item.trailingAnchor.constraint(equalTo: rightContainer.trailingAnchor).isActive = true
        item.centerYAnchor.constraint(equalTo: rightContainer.centerYAnchor).isActive = true
    }
    
    private func setTwoItemsConstraint(left: UIButton, right: UIButton) {
        
        right.translatesAutoresizingMaskIntoConstraints = false
        right.trailingAnchor.constraint(equalTo: rightContainer.trailingAnchor).isActive = true
        right.centerYAnchor.constraint(equalTo: rightContainer.centerYAnchor).isActive = true
        
        left.translatesAutoresizingMaskIntoConstraints = false
        left.trailingAnchor.constraint(equalTo: right.leadingAnchor, constant: -12).isActive = true
        left.centerYAnchor.constraint(equalTo: rightContainer.centerYAnchor).isActive = true
    }
    
    private func setUserImageConstraint(item: UIImageView) {
        item.translatesAutoresizingMaskIntoConstraints = false
        item.leadingAnchor.constraint(equalTo: userContainer.leadingAnchor, constant: 10).isActive = true
        item.centerYAnchor.constraint(equalTo: userContainer.centerYAnchor).isActive = true
    }
}
