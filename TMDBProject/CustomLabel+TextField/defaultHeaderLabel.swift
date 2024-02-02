//
//  defaultHeaderLabel.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/3/24.
//

import UIKit

class DefaultHeaderLabel : UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func design() {

        self.textColor = .white
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        design()
    }
    
}
