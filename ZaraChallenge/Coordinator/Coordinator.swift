//
//  Coordinator.swift
//  ZaraChallenge
//
//  Created by Carlos Obregon on 25/09/23.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func start()
}
