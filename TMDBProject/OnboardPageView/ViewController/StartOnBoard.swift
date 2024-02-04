//
//  FirstOnBoard.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/4/24.
//

import UIKit
import SnapKit


class StartOnBoard: StartBaseViewController {
    let imageView = OnboardSampleImageView(frame: .zero)
    let explainLabel = OnboardLabel()
    
    
    override func configureHierarchy() {
        self.view.backgroundColor = .black
        self.view.addSubview(imageView)
        self.view.addSubview(explainLabel)
    }
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            // make.centerY.equalTo(view.safeAreaLayoutGuide).offset( -60 )
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.width.equalTo(UIScreen.main.bounds.width / 1.5 )
            make.height.equalTo(imageView.snp.width).multipliedBy(1.7)
        }
        explainLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset( -12 )
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.lessThanOrEqualTo(100)
            // make.horizontalEdges.lessThanOrEqualTo(view.safeAreaLayoutGuide).inset(40)
            make.leading.greaterThanOrEqualTo(view.safeAreaLayoutGuide).inset(40)
            make.trailing.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(-40)
        }
    }
    override func designView() {
        imageView.backgroundColor = .brown
        imageView.image = UIImage(named: OnboardEnum.first.image)
        imageView.contentMode = .scaleAspectFill
        explainLabel.backgroundColor = .red
        explainLabel.numberOfLines = 3
        explainLabel.clipsToBounds = true
        explainLabel.text = OnboardEnum.first.text
    }
    
    
}

