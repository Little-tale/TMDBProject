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
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let text = text else {
            return
        }
        ProfileNickNameSettingHomeView.nicknameTextField.text = text
    }
}

extension ProfileInfoSettingViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Actting Of textFieldShouldReturn ")
        
        guard let text = ProfileNickNameSettingHomeView.nicknameTextField.text else {
            print("글자가 없습니다.")
            return true
        }
        settingInfo?(text)
        dismiss(animated: true)
        return true
    }
}
