//
//  UIDevice+Extension.swift
//  ZaraChallenge
//
//  Created by Carlos Obregon on 24/09/23.
//

import UIKit

extension UIDevice {
    /// Check if current device is phone idiom
    static let isiPhone = UIDevice.current.userInterfaceIdiom == .phone
}
