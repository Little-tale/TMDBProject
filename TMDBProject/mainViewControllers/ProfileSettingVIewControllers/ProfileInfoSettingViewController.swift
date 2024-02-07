//
//  ProfileSettionViewController.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/7/24.
//

import UIKit

class ProfileInfoSettingViewController : StartBaseViewController {
    
    let ProfileNickNameSettingHomeView = ProfileSettingHomeView()
    
    var settingInfo : ((String) -> Void)?
    var text : String?
    
    
    override func loadView() {
        self.view = ProfileNickNameSettingHomeView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // textFieldLogic()
        ProfileNickNameSettingHomeView.nicknameTextField.delegate = self
    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//       
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // print(text)
        guard let text = text else {
            self.text = ""
            return
        }
        ProfileNickNameSettingHomeView.nicknameTextField.text = text
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        text = ""
        // print(text)
    }
}

extension ProfileInfoSettingViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Actting Of textFieldShouldReturn ")
        guard let text = ProfileNickNameSettingHomeView.nicknameTextField.text else {
            print("글자가 없습니다.")
            return true
        }
        self.text = ""
        settingInfo?(text)
        
        dismiss(animated: true)
        return true
    }
}

/*
 guard let session = settingSession.allCases.first(where: { sessions in
     textField.layer.name == sessions.layerName
 }) else {
     print("일치하는 세션 이름이 없음 -> textFieldShouldReturn ")
     return true
 }
         
 
 switch session {
 case .genderName:
 case .introduce:
 case .link :
 case .name :
 case .userName :
 }
 */
