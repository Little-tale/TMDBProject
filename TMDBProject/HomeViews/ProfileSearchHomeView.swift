//
//  ProfileSearchViewController.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/8/24.
//

import UIKit
import SnapKit

class ProfileSearchHomeView: BaseView {
    
    let genreHomeVIew = GenreHomeVIew()
    lazy var searchBar: UISearchBar = {
        var view = UISearchBar()
        view.barStyle = .black
        view.searchBarStyle = .minimal
        view.searchTextField.leftView?.tintColor = .white
        return view
    }()
    
    override func configureHierarchy() {
        self.addSubview(searchBar)
        self.addSubview(genreHomeVIew)
    }
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(32)
        }
        genreHomeVIew.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
      
    }
    
}
