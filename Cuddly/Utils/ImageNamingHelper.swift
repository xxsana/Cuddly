//
//  ImageNamingHelper.swift
//  Cuddly
//
//  Created by Haru on 2021/06/01.
//

import UIKit

struct ImageNamingHelper {
    func creatDesc(with id: String, to: Int) -> [UIImage?]{
        var images: [UIImage?] = []
        
        for i in 1...to {
            images.append(UIImage(named: "\(id)_\(i)"))
        }
        return images
    }
}
