//
//  ProfileModifySettingHomeView.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/7/24.
//

import UIKit
import SnapKit
class ProfileModifySettingHomeView: BaseView {
    
    let profileImageView = ProfileViewImage()
    // let nickNameLabel = UILabel()
    // let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let nameSettingView = settingBoxView()
    
    override func configureHierarchy() {
        self.addSubview(profileImageView)
        self.addSubview(nameSettingView)
        
        // self.addSubview(nickNameLabel)
        // self.addSubview(tableView)
    }
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width / 2)
            make.height.equalTo(140).priority(600)
            make.centerX.top.equalTo(self.safeAreaLayoutGuide)
        }

        nameSettingView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).inset( -8 )
            make.height.equalTo(60)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }

        
    }
    override func designView() {
        self.backgroundColor = .black
        // profileImageView.backgroundColor = .brown
        profileImageView.clipsToBounds = true
        // tableView.backgroundColor = .blue
        // profileImageView.
        // profileImageView.ProfileImageView.backgroundColor = .lightGray]
        // nameSettingView.backgroundColor = .blue
        nameSettingView.nameTextLabel.backgroundColor = .blue
        nameSettingView.nmaeInputTextField.backgroundColor = .red
        nameSetting()
        
        nameSettingView.nmaeInputTextField.placeholder = "이름을 수정해 보세요"
        
    }
    
    func nameSetting() {
        nameSettingView.nameTextLabel.text = " 이름"
    }
    
    

}

//extension ProfileSettingHomeView: UITextFieldDelegate {
//    
//}
