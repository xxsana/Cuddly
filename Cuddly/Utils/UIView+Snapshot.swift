//
//  UIView+Snapshot.swift
//  Cuddly
//
//  Created by Haru on 2021/04/09.
//

import UIKit

extension UIView {
    // render the view within the view's bounds, then capture it as image
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image(actions: { rendererContext in
                    layer.render(in: rendererContext.cgContext)
        })
    }
}
