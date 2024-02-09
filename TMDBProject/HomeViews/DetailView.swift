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
        self.tableView.backgroundColor = .black
        // tableView.backgroundColor = .green
        // MARK: 제네릭을 통해서 시도는 해봤는데 더 길어지니까 좋은 방법인가 애매해진다.
        register()
        
    }
    
    private func register() {
        tableView.register(DetailPosterViewCell.self, forCellReuseIdentifier: ReusableIdentifier<DetailPosterViewCell>.reuseableItentifier )
        tableView.register(DetailRecommendTableViewCell.self, forCellReuseIdentifier: ReusableIdentifier<DetailRecommendTableViewCell>.reuseableItentifier)
    }
}
