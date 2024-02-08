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
        settingHomeView.nameSettingView.nmaeInputTextField.addTarget(self, action: #selector(TextFieldClicked), for: .editingDidBegin)
        settingHomeView.genderNameView.nmaeInputTextField.addTarget(self, action: #selector(TextFieldClicked), for: .editingDidBegin)
        settingHomeView.introduceView.nmaeInputTextField.addTarget(self, action: #selector(TextFieldClicked), for: .editingDidBegin)
        settingHomeView.linkView.nmaeInputTextField.addTarget(self, action: #selector(TextFieldClicked), for: .editingDidBegin)
        settingHomeView.userNameView.nmaeInputTextField.addTarget(self, action: #selector(TextFieldClicked), for: .editingDidBegin)
    }
    
    // MARK: 1번째로 생각해 볼건 매개변수에 무엇을 받아 올수 있는지
    // 일단은 방법이 몇개가 생각이 났는데
    // 각 텍스트 필드가 어떤 주소를 갖는가
    // 또는 레이어 이름을 할당해 주거나 -> 레이어 이름을 통해 로직을 개선해 보자
    // 하는 방법이 있을것 같다.
    @objc
    func TextFieldClicked(test : UITextField) {
        print(test)
        // print(test.layer.name)
        print("작동되는가?")
        guard let layerName = test.layer.name else {
            print("레이어 이름 못 가져오거나 망가짐")
            return
        }
        
        // 첫번째로 일치하는 것을 받오는데 그건 나의 이넘임
        guard let session = settingSession.allCases.first(where: { result in
            result.layerName == layerName
        }) else {
            print("문제가 발생 -> 내가 정의한 레이어 이름과 다름")
            return
        }
        print("세션----------------------")
        
        // MARK: 이제 이것을 더 줄여봐야함 session에 따라 해당하는 텍스트 필드, 텍스트 변수,
        // 중복되는것 : 텍스트가 존재하는가,
        // 중복 되지 않는것 : 각 텍스트 필드, 결과 각 세션,
    
        let value = sendTextFieldText(session: session)
        print("☺️☺️☺️☺️☺️☺️",value)
        profileInfoSettingViewController.text = value
        getTextFieldText(textField: test, session: session)
      
        present(profileInfoSettingViewController, animated: true)

    }
    
    
    // MARK: 받는 기능만 담당함.
    func getTextFieldText(textField: UITextField, session: settingSession) {
        profileInfoSettingViewController.settingInfo = {
            result in
            print("getTextFieldText")
            switch session {
            case .name:
                print("이름영역")
                self.name = result
            case .userName:
                print("사람이름영역")
                self.userName = result
            case .genderName:
                print("성별영역")
                self.gender = result
            case .introduce:
                print("소개영역")
                self.intro = result
            case .link:
                print("링크영역")
                self.link = result
            }
            textField.text = result
        }
    }
    
    func sendTextFieldText(session: settingSession) ->String? {
        switch session {
        case .name:
            return self.name ?? ""
        case .userName:
            return self.userName ?? ""
        case .genderName:
            return self.gender ?? ""
        case .introduce:
            return self.intro ?? ""
        case .link:
            return self.link ?? ""
        }
    }
    
    /*
     switch session {
     case .genderName:
         profileInfoSettingViewController.settingInfo = {
             result in
             print("genderName")
             if let gender = self.gender {
                 print("genderName 이름이 존재")
                 self.profileInfoSettingViewController.text = gender
             }
             print(result)
             self.settingHomeView.genderNameView.nmaeInputTextField.text = result
             self.gender = result
         }
     case .introduce :
         profileInfoSettingViewController.settingInfo = {
             result in
             print("introduce")
             if let intro = self.intro {
                 print(" introduce 이름이 존재")
                 self.profileInfoSettingViewController.text = intro
             }
             print(result)
             self.settingHomeView.introduceView.nmaeInputTextField.text = result
             self.intro = result
         }
     case .link:
         profileInfoSettingViewController.settingInfo = {
             result in
             print("link")
             if let link = self.link {
                 print("link 이름이 존재")
                 self.profileInfoSettingViewController.text = link
             }
             print(result)
             self.settingHomeView.linkView.nmaeInputTextField.text = result
             self.link = result
         }
     case .name:
         profileInfoSettingViewController.settingInfo = {
             result in
             print("name")
             if let name = self.name {
                 print("name 이름이 존재")
                 self.profileInfoSettingViewController.text = name
             }
             print(result)
             self.settingHomeView.nameSettingView.nmaeInputTextField.text = result
             self.name = result
         }
     case .userName:
         profileInfoSettingViewController.settingInfo = {
             result in
             print("userName")
             if let userName = self.userName {
                 print("userName 이름이 존재")
                 self.profileInfoSettingViewController.text = userName
             }
             print(result)
             self.settingHomeView.userNameView.nmaeInputTextField.text = result
             self.userName = result
         }
     }
     
     */
    
    //        // settingHomeView.nameSettingView.nameTextLabel.text =
    //        profileInfoSettingViewController.settingInfo = settingInfo(name:)
    //        profileInfoSettingViewController.settingInfo = {
    //            retsult in
    //            if let name = self.name {
    //                print("이름이 존재")
    //                self.profileInfoSettingViewController.text = name
    //            }
    //            print(retsult)
    //            self.settingHomeView.nameSettingView.nmaeInputTextField.text = retsult
    //            self.name = retsult
    //        }
    //        settingHomeView.endEditing(true)
    //
    // var settingInfo: ((String) -> Void)?
   /*
    case .genderName:
        profileInfoSettingViewController.settingInfo = {
            result in
            print("genderName")
            if let gender = self.gender {
                print("genderName 이름이 존재")
                self.profileInfoSettingViewController.text = gender
            } else {
                self.profileInfoSettingViewController.text = ""
            }
            print(result)
            self.settingHomeView.genderNameView.nmaeInputTextField.text = result
            self.gender = result
        }
    */
    
   
    
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




//        guard let session = settingSession.allCases.contains(where: { caseof in
//            if caseof.layerName == layerName{
//
//            }
//        }) else {
//            print("매치되는게 없는 사고")
//            return
//        }
