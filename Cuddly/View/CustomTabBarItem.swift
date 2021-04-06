//
//  CustomTabBarItem.swift
//  Cuddly
//
//  Created by Haru on 2021/04/05.
//

import UIKit

class CustomTabBarItem: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // 스토리보드로 초기화 할 일 없으므로 작성 안 함
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 프로그래밍 방식으로 초기화했을 때
        // size 밑이랑 겹치게...해도 돼???
        // iPhone 11 Pro Max width size 기계별로 다르면 좋을텐데.
        let tabBarWidth: CGFloat = 414
        
        let itemWidth = tabBarWidth / 4.0
        let itemHeight: CGFloat = 90.0
        
        self.frame.size = CGSize(width: itemWidth, height: itemHeight)
        self.frame.origin.y = 0
        
        // highlight actions
        self.addTarget(self, action: #selector(bright(_:)), for: .touchDown)
        self.addTarget(self, action: #selector(returnAlpha(_:)), for: .touchUpInside)
                
    }
    
    // 정확한 값 없이 초기화할 때.. 안 될 수 있음
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    // function for setting image and title
    func setImageAndTitle(title: String, imageSystemName imageName: String, tag: Int) {
        // title
        self.setTitle(title, for: .normal)
        // font and color
        self.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 13)
        self.setTitleColor(.black, for: .normal)
        
        // image
        let image = UIImage(systemName: imageName, withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium))
        self.setImage(image, for: .normal)
        // color and no highlight
        self.tintColor = .black
        self.adjustsImageWhenHighlighted = false
        
        // tag
        self.tag = tag
    }
    
    func alignImageAndTitleCenter(image imageWidth: CGFloat, title titleWidth: CGFloat) {
        // image
        let imageTopBottom: CGFloat = 21.0
        self.imageEdgeInsets = UIEdgeInsets(top: -imageTopBottom,
                                            left: titleWidth / 2,
                                            bottom: imageTopBottom,
                                            right: -(titleWidth / 2))
        // title
        let titleTopBottom: CGFloat = 6.0
        self.titleEdgeInsets = UIEdgeInsets(top: titleTopBottom,
                                            left: -(imageWidth / 2),
                                            bottom: -titleTopBottom,
                                            right: imageWidth / 2)
    }
    
    @objc func bright(_ sender: UIButton) {
        let alphaValue: CGFloat = 0.4
        sender.titleLabel?.alpha = alphaValue
        sender.imageView?.alpha = alphaValue
    }

    @objc func returnAlpha(_ sender: UIButton) {
        sender.titleLabel?.alpha = 1
        sender.imageView?.alpha = 1
    }
}
