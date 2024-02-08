//
//  ProfileViewInTable.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/8/24.
//

import UIKit
import Kingfisher
/*
 이젠 여기서는 테이블뷰를 넣어서 할 예정이다.
 수정창은 재활용 해서 테이블 뷰에서 어떻게 해줄지 고민해보자
 
 이미지 검색뷰?(네이버 이미지 API 혹은 UnsplashAPI)
 이미지 셀 선택 > 선택한 이미지 프로필 뷰에 역 값전달해서 보여주기
 */

final class ProfileInTableCaseViewController: StartBaseViewController {
    // 테이블 헤더에 넣자
    let imageInfoView = ProfileViewImage()
    let homeView = ProfileTableInHomeView()
    var imageName = ""
    
    // 다음뷰
    let nextViewController = ProfileInfoSettingViewController()
    
    var valueDic: [String : String?] = [:]
    
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
        imageInfoView.ProfileImageView.addTarget(self, action: #selector(profileImageClicked), for: .touchUpInside)
    
    }
    @objc func profileImageClicked(){
        print("클릭")
        let vc = ProfileSearchViewController()
        vc.getImageName = {
            result in
            print("😍😍😍😍😍😍😍",result)
            self.imageName = result
            self.imageViewSetting(image: result)
        }
        present(vc,animated: true)
    }
  
   
    func imageViewSetting(image: String) {
        let url = URL(string: image)
        imageInfoView.ProfileImageView.kf.setImage(with: url, for: .normal)
    }
}

// MARK: 프로필 설정란들 컨트롤
extension ProfileInTableCaseViewController : UITableViewDelegate, UITableViewDataSource {
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
        
        cell.textField.text = valueDic[cell.textField.layer.name!] ?? " "
        
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


}

extension ProfileInTableCaseViewController: UITextFieldDelegate {
    // MARK: 텍스트 시작시 값전달   과 역 값전달 시전
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let vc = nextViewController
        
        guard let textFieldLayerName = findTextField(textField: textField) else {
            print("텍스트 필드 이름 못받아옴 :textFieldShouldBeginEditing")
            return true
        }
        
        vc.text = valueDic[textFieldLayerName] ?? ""
        
        present(vc, animated: true)
        print("인식확인")
        
        // 역값전달 시점 + 클로저의 캡쳐
        vc.settingInfo = {
            results in
            self.valueDic[textFieldLayerName] = results
           
            self.homeView.infoTableView.reloadData()
        }
        // self.homeView.endEditing(true)
        // false를 반환하여 키보드 안올라오게 처리
        return false
    }
    
    
    // MARK: 텍스트 필드 찾기 레이어 이름 찾기
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
