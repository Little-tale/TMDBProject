//
//  GenreHomeVIew.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/6/24.
//

import UIKit
import SnapKit

class GenreHomeVIew: BaseView {
    let genreTabelView = UITableView()
    
    
    override func configureHierarchy() {
        self.addSubview(genreTabelView)
    }
    override func configureLayout() {
        genreTabelView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    
    
}
