//
//  Comment.swift
//  Cuddly
//
//  Created by Haru on 2021/03/28.
//

import UIKit

struct Comment {
    let id: String
    let date: String
    var voteUp = 0
    var voteDown = 0
    var title: String
    var content: String
    var images: [UIImage]?
    
}
