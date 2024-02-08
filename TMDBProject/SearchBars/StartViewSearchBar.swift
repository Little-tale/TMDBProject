//
//  StartViewSearchBar.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/2/24.
//

import UIKit

final class StarViewSearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        designSearchBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func designSearchBar(){
        self.searchBarStyle = .minimal
        self.barStyle = .black
        self.placeholder = "영화, 드라마 등 검색해보세요~!"
    }
}
