//
//  ProfileSearchViewController.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/8/24.
//

import UIKit

class ProfileSearchViewController: StartBaseViewController {
    let homeView = ProfileSearchHomeView()
    
    override func loadView() {
        self.view = homeView
    }
    
    override func designView() {
        register()
        placeHolder()
    }
    func register(){
        homeView.genreHomeVIew.genreCollectionView.dataSource = self
        homeView.genreHomeVIew.genreCollectionView.delegate = self
    }
    func placeHolder(){
        homeView.searchBar.placeholder = "캐릭터 이름을 검색해보세요!!!"
    }
    
}

extension ProfileSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartViewCollectIonvIewCell.reuseIdentifier, for: indexPath) as? StartViewCollectIonvIewCell else {
            print("셀 레지스터 문제이거나 애초에 셀이 잘못됨")
            return UICollectionViewCell()
        }
        cell.backgroundColor = .green
        
        return cell
    }

}
