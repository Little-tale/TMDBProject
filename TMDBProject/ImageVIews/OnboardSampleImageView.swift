//
//  OnboardSampleVIew.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/4/24.
//

import UIKit

class OnboardSampleImageView : UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        designView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func designView() {
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 0.2
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
        
    }
}
