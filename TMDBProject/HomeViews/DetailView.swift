//
//  DetailView.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/2/24.
//

import UIKit


class DetailView: BaseView {
    let tableView = UITableView()
    
    override func configureHierarchy(){
        self.addSubview(tableView)
    }
    override func configureLayout(){
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    override func designView(){
        self.backgroundColor = .black
        tableView.backgroundColor = .green
    }
}
