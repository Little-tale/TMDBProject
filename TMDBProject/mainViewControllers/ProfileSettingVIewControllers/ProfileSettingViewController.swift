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

/*
 하나 하나 다 노가다로 해주려 했으나 너무나 비효율 적이다 라고 판단됨 슬슬 로직을 분리해 보고 유연하게 해보자
 */


//MARK: 프로필 편집 도입부 뷰컨
class ProfileSettingViewController : StartBaseViewController {
    let settingHomeView = ProfileModifySettingHomeView()
    let profileInfoSettingViewController = ProfileInfoSettingViewController()
    
    var name : String?
    var gender : String?
    var userName: String?
    var intro: String?
    var link : String?
    
    override func loadView() {
        self.view = settingHomeView
        
    }
    
    override func configureHierarchy() {
        
    }
    override func configureLayout() {
        
    }
    override func designView() {
        settingHomeView.nameSettingView.nmaeInputTextField.addTarget(self, action: #selector(nameClicked), for: .editingDidBegin)
        settingHomeView.genderNameView.nmaeInputTextField.addTarget(self, action: #selector(genderClicked), for: .editingDidBegin)
        
    }
    
    // MARK: 1번째로 생각해 볼건 매개변수에 무엇을 받아 올수 있는지
    // 일단은 방법이 몇개가 생각이 났는데
    // 각 텍스트 필드가 어떤 주소를 갖는가
    // 또는 레이어 이름을 할당해 주거나 -> 레이어 이름을 통해 로직을 개선해 보자
    // 하는 방법이 있을것 같다.
    @objc
    func nameClicked(test : UITextField) {
        print(test)
        print(test.layer.name)
        
        print("작동되는가?")
        
    
        
        
        
        present(profileInfoSettingViewController, animated: true)
        // settingHomeView.nameSettingView.nameTextLabel.text =
        profileInfoSettingViewController.settingInfo = {
            retsult in
            if let name = self.name {
                print("이름이 존재")
                self.profileInfoSettingViewController.text = name
            }
            print(retsult)
            self.settingHomeView.nameSettingView.nmaeInputTextField.text = retsult
            self.name = retsult
        }
        settingHomeView.endEditing(true)
    }
    @objc
    func genderClicked(test : UITextField) {
        
        print(test)
        print("작동되는가?")
        present(profileInfoSettingViewController, animated: true)
        // settingHomeView.nameSettingView.nameTextLabel.text =
        profileInfoSettingViewController.settingInfo = {
            retsult in
            if let name = self.name {
                print("이름이 존재")
                self.profileInfoSettingViewController.text = name
            }
            print(retsult)
            self.settingHomeView.nameSettingView.nmaeInputTextField.text = retsult
            self.name = retsult
        }
        settingHomeView.endEditing(true)
    }
    
    
    
    
    
}
