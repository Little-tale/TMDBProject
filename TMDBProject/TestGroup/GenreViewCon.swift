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
        homeView.backgroundColor = .black
    }
    
    override func configureLayout() {
        
    }
    
    override func designView() {
        homeView.genreCollectionView.dataSource = self
        homeView.genreCollectionView.delegate = self
    }
    
    
}
// API 목적으로 색이 계속 바뀌는 문제를 알고 있음에도 기능에 중점을 두기로 했다.
// 뷰를 갑작스럽게 하나 더 만들게 되어서 급하게 장르 API 를 추가하고 여기서 구현해 보도록 하겠다.
extension GenreViewCon: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.reuseableIdentiFier, for: indexPath)
        cell.backgroundColor = UIColor(red: CGFloat.random(in: 0...255) / 255, green: CGFloat.random(in: 0...255) / 255, blue: CGFloat.random(in: 0...255) / 255, alpha: 1)
        cell.layer.cornerRadius = 20
        return cell
    }
    
    
}


#Preview{
    GenreViewCon()
}

