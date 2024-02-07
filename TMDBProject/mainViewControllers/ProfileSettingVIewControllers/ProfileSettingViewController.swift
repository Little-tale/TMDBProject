//
//  ProfileSettingViewController.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/7/24.
//

/*
 navigation
 Image x2
 nameLabel
 nickNmae Label
 genderLel..... 디자인 겹침 즉이건 하나로
 
 TableView InsetGrouped 에 커스템 셀을 넣어서 해결하는 것으로 하고
 밑에 추가적인건 스킵하겠음
 */
import UIKit
import SnapKit
//MARK: 프로필 편집 도입부 뷰컨
class ProfileSettingViewController : StartBaseViewController {
    let settingHomeView = ProfileModifySettingHomeView()
    let profileInfoSettingViewController = ProfileInfoSettingViewController()
    
    override func loadView() {
        self.view = settingHomeView
        
    }
    
    override func configureHierarchy() {
        
    }
    override func configureLayout() {
        
    }
    override func designView() {
        settingHomeView.nameSettingView.nmaeInputTextField.addTarget(self, action: #selector(nameClicked), for: .editingDidBegin)
    }
    @objc
    func nameClicked() {
        print("작동되는가?")
        present(profileInfoSettingViewController, animated: true)
        settingHomeView.endEditing(true)
    }
}
