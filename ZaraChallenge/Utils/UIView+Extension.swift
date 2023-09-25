//
//  UIView+Extension.swift
//  ZaraChallenge
//
//  Created by Carlos Obregon on 24/09/23.
//

import UIKit

extension UIView {
    /// Add multiple subviews
    /// - Parameter views: Variadic views
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
