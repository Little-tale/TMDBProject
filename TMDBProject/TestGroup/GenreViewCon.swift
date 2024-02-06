//
//  GenreViewCon.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/6/24.
//

import UIKit

/*
 필요한것.
 테이블 뷰 안에 컬렉션뷰
 */

class GenreViewCon: StartBaseViewController {
    let homeView = GenreHomeVIew()
    
    override func loadView() {
        self.view = homeView
    }
    
    override func configureHierarchy() {
        homeView.backgroundColor = .white
    }
    
    override func configureLayout() {
        
    }
    
    override func designView() {
        
    }
    
    
}

//extension GenreViewCon: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        //
//    }
//    
//    
//}


#Preview{
    GenreViewCon()
}

