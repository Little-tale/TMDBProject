//
//  HeaderButtonCell.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/5/24.
//

import UIKit
import SnapKit

class HeaderButtonCell: BaseCollectionViewCell {
    let button = UIButton()
    
    override func configureHierarchy() {
        contentView.addSubview(button)
    }
    override func configureLayout() {
        button.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
    }
    override func designView() {
        var buttonConfig = UIButton.Configuration.filled()
        
        buttonConfig.baseBackgroundColor = .clear
        buttonConfig.baseForegroundColor = .white
        buttonConfig.cornerStyle = .dynamic
        button.configuration = buttonConfig
    }
}

