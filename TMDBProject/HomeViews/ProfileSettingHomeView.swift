//
//  ProfileSettingHomeView.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/7/24.
//

import UIKit
import SnapKit

class ProfileSettingHomeView: BaseView {
    
    let nicknameTextField = UITextField()
    var nickNameText : ((String) -> Void)? {
        didSet {
            
        }
    }
    override func designView() {
        self.backgroundColor = .black
        nicknameTextField.backgroundColor = .white
    }
    
    override func configureHierarchy() {
        self.addSubview(nicknameTextField)
    }
    override func configureLayout() {
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(14)
            make.height.equalTo(40)
        }
    }
    
}
