//
//  settingBoxView.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/7/24.
//

import UIKit
import SnapKit

class settingBoxView: BaseView {
    let nameTextLabel = UILabel()
    let nmaeInputTextField = UITextField()
    
       
    
    
    override func configureHierarchy() {
        self.addSubview(nameTextLabel)
        self.addSubview(nmaeInputTextField)
    }
    override func configureLayout() {
        nameTextLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(self.safeAreaLayoutGuide)
            make.width.equalTo(100)
        }
        nmaeInputTextField.snp.makeConstraints { make in
            make.leading.equalTo(nameTextLabel.snp.trailing)
            make.verticalEdges.equalTo(nameTextLabel)
            make.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }
    override func designView() {
        nmaeInputTextField.textColor = .white
    }
    
}
