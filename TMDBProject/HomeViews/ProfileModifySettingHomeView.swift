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
    let userNameView = settingBoxView()
    let genderNameView = settingBoxView()
    let introduceView = settingBoxView()
    let linkView = settingBoxView()
    
    lazy var settingViews = [nameSettingView, userNameView, genderNameView, introduceView, linkView]
    // let fieldNames = ["이름","사용자이름","성별 대명사", "소개", "링크"]

    
    override func configureHierarchy() {
        self.addSubview(profileImageView)
        self.addSubview(nameSettingView)
        self.addSubview(userNameView)
        self.addSubview(genderNameView)
        self.addSubview(introduceView)
        self.addSubview(linkView)
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
        userNameView.snp.makeConstraints { make in
            make.top.equalTo(nameSettingView.snp.bottom).inset( -8 )
            make.height.equalTo(60)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        genderNameView.snp.makeConstraints { make in
            make.top.equalTo(userNameView.snp.bottom).inset( -8 )
            make.height.equalTo(60)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        introduceView.snp.makeConstraints { make in
            make.top.equalTo(genderNameView.snp.bottom).inset( -8 )
            make.height.equalTo(60)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        linkView.snp.makeConstraints { make in
            make.top.equalTo(introduceView.snp.bottom).inset( -8 )
            make.height.equalTo(60)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        
    }
    override func designView() {
        self.backgroundColor = .black
       
        profileImageView.clipsToBounds = true
        
        nameSettingView.nameTextLabel.backgroundColor = .blue
        nameSettingView.nmaeInputTextField.backgroundColor = .red
        nameSetting()
        
        
//        for i in 0...(fieldNames.count - 1) {
//            settingViews[i].nameTextLabel.text = fieldNames[i]
//            // 레이어 이름 로직 추가
//            // settingViews[i].nmaeInputTextField.layer.name  = fieldNames[i]
//            // print(settingViews[i].nmaeInputTextField.layer.name)
//            settingViews[i].nameTextLabel.textColor = .white
//            
//            settingViews[i].nmaeInputTextField.layer.name = settingSession.allCases[i].layerName
//            
//        }
        // print(settingSession.allCases.count) 5
        for i in 0...(settingSession.allCases.count - 1) {
            settingViews[i].nameTextLabel.text = settingSession.allCases[i].layerName
            settingViews[i].nmaeInputTextField.layer.name = settingSession.allCases[i].layerName
            settingViews[i].nameTextLabel.textColor = .white
            
        }
        
    }
    
    func nameSetting() {
        nameSettingView.nameTextLabel.text = " 이름"
    }
    
    

}

//extension ProfileSettingHomeView: UITextFieldDelegate {
//    
//}
