//
//  ProfileViewInTable.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/8/24.
//

import UIKit

/*
 이젠 여기서는 테이블뷰를 넣어서 할 예정이다.
 수정창은 재활용 해서 테이블 뷰에서 어떻게 해줄지 고민해보자
 case .name:
     "이름"
 case .userName:
     "사용자이름"
 case .genderName:
     "성별 대명사"
 case .introduce:
     "소개"
 case .link:
     "링크"
 */

class ProfileViewInTable: StartBaseViewController {
    // 테이블 헤더에 넣자
    let imageInfoView = ProfileViewImage()
    let homeView = ProfileTableInHomeView()
    
    // 다음뷰
    let nextViewController = ProfileInfoSettingViewController()
    
    var valueDic: [String : String] = [:]
    
    override func loadView() {
        self.view = homeView
    }
    override func designView() {
        register()
        imageInfoView.clipsToBounds = true
    }
    func register(){
        homeView.infoTableView.dataSource = self
        homeView.infoTableView.delegate = self
    }
}

// MARK: 프로필 설정란들 컨트롤
extension ProfileViewInTable : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingSession.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let  cell = tableView.dequeueReusableCell(withIdentifier: ProfileInfoTableCell.reuseableIdentiFier, for: indexPath) as? ProfileInfoTableCell else {
            print("ProfileInfoTableCell register Erorr")
            return UITableViewCell()
        }
        cell.textField.layer.name  = settingSession.allCases[indexPath.row].layerName
        cell.titlelabel.text = settingSession.allCases[indexPath.row].layerName
        cell.textField.delegate = self
        
        cell.textField.text = valueDic[cell.textField.layer.name!]

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return imageInfoView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 130
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileInfoTableCell.reuseableIdentiFier) as? ProfileInfoTableCell else {
//            print("내 예상과 다른 셀임")
//            return
//        }
//        
//        guard cell.textField.text != "" else {
//            print("현재는 테이블뷰 셀에는 텍스트가 없구만유")
//            return
//        }
//        // print(cell.textField.text)
//        print("현재 테이블뷰 셀에 텍스트가 있음")
//    }

}

extension ProfileViewInTable: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        homeView.endEditing(true)
        let vc = nextViewController
       
        present(vc, animated: true)
        print("인식확인")
        
        guard let textFieldLayerName = findTextField(textField: textField) else {
            print("텍스트 필드 이름 못받아옴 :textFieldShouldBeginEditing")
            return true
        }
    
        vc.settingInfo = {
            results in
            self.valueDic[textFieldLayerName] = results
            // print(self.valueDic[textFieldLayerName])
            self.homeView.infoTableView.reloadData()
        }
        // 테이블 뷰의 셀의 텍스트 필드에 접근해야 하는데.
        
        return true
    }
    
    
    func findTextField(textField: UITextField) -> String?{
        guard let textFieldLayerName = textField.layer.name else {
            print("텍슽 필드 이름 존재 여부 확인좀: findTextField")
            return nil
        }
        
        guard let textField = settingSession.allCases.first(where: { session in
            session.layerName == textFieldLayerName

        }) else {
            print("일치하는 레이어 이름이 없음: settingSession.allCases.first")
            return nil
        }
        print("이름",textField.layerName)
        return textField.layerName
    }
    
}
