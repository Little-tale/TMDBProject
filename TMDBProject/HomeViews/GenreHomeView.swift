//
//  GenreHomeView.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/5/24.
//

/*
 이부분은 시간이 나면 계속해서 업데이트 할 예정이다.
 
 필요한 UI
    ColletionReuableView (Header) 취소 테이블뷰로 변경 헤더뷰 달기
    
 */
//import UIKit
//import SnapKit
//
//class GenreHomeView: BaseView {
//    let buttonsHeaderView =  GenreTableHeaderView()
//    let tableView = UITableView(frame: .zero, style: .grouped)
//    
//    override func configureHierarchy() {
//        self.addSubview(buttonsHeaderView)
//        self.addSubview(tableView)
//        self.backgroundColor = .black
//        register()
//    }
//    override func configureLayout() {
//        buttonsHeaderView.snp.makeConstraints { make in
//            make.horizontalEdges.top.equalTo(self.safeAreaLayoutGuide)
//            make.height.equalTo(50)
//        }
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(buttonsHeaderView.snp.bottom)
//            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
//        }
//    }
//    func register() {
//        tableView.register(GenreTableViewCell.self, forCellReuseIdentifier: GenreTableViewCell.reuseableIdentiFier)
//        buttonsHeaderView.clipsToBounds = true
//    }
//}

