//
//  StartViewLabel.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/2/24.
//

import UIKit


class UnderLineLabel : UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var width : CGFloat = 2
    
    func design() {
        let line = CALayer()
        line.borderColor = UIColor.red.cgColor
        line.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
        line.borderWidth = width
        
        self.layer.addSublayer(line)
        self.textColor = .white
        
    
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        design()
    }
    
    func setWidth(width: CGFloat) {
        self.width = width
    }
    
}
