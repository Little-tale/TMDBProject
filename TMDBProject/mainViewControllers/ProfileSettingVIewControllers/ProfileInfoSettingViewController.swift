//
//  ProfileSettionViewController.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/7/24.
//

import UIKit

class ProfileInfoSettingViewController : StartBaseViewController {
    let ProfileNickNameSettingHomeView = ProfileSettingHomeView()
    
    override func loadView() {
        self.view = ProfileNickNameSettingHomeView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldLogic()
        ProfileNickNameSettingHomeView.nicknameTextField.delegate = self
    }
    
    
    func textFieldLogic() {
        
    }
}

extension ProfileInfoSettingViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Actting Of textFieldShouldReturn ")
        return true
    }
}
