//
//  OnboardLabel.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/4/24.
//

import UIKit

class OnboardLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        designLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        designLabel()
    }
    
    func designLabel() {
        self.font = .systemFont(ofSize: 26, weight: .bold)
        self.textColor = .white
        self.numberOfLines = 3
        self.textAlignment = .center
        self.layer.cornerRadius = 8
    }
}
