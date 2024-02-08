//
//  ProfileTableInHomeView.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/8/24.
//

import UIKit
/*
 테이블 뷰 헤더뷰에 이미지 두개와 버튼이 들어있는 뷰를 사용해 보도록 하겠다.
 */
class ProfileTableInHomeView: BaseView {
    
    let infoTableView = UITableView()
    
    
    override func configureHierarchy() {
        self.addSubview(infoTableView)
    }
    override func configureLayout() {
        infoTableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    override func designView() {
        self.backgroundColor = .green
        registerTableCell()
    }
    
    func registerTableCell() {
        infoTableView.register(ProfileInfoTableCell.self, forCellReuseIdentifier: ProfileInfoTableCell.reuseableIdentiFier)
        infoTableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseableIdentiFier)
    }
}
