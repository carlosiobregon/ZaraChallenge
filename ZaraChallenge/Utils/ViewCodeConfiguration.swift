//
//  ViewCodeConfiguration.swift
//  ZaraChallenge
//
//  Created by Carlos Obregon on 24/09/23.
//

import Foundation

protocol ViewCodeConfiguration {
    func buildHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewCodeConfiguration {

    func configureViews() {}
    
    func applyViewCode() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
}
