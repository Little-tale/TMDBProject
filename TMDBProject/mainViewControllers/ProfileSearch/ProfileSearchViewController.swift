//
//  ProfileSearchViewController.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/8/24.
//

import UIKit

class ProfileSearchViewController: StartBaseViewController {
    let homeView = ProfileSearchHomeView()
    var dataModel: NaverSearch = .init(total: 0, start: 0, display: 0, items: [])
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        URLSessionNaver.shared.fetchSession(type: NaverSearch.self, API: naverApi.searchImage(searchText: "짱구는못말려", APiKey: .search)) { result in
            switch result {
            case .success(let success):
                // print(success)
                self.dataModel = success
               
                self.homeView.genreHomeVIew.genreCollectionView.reloadData()
                print(self.dataModel)
            case .failure(let fail):
                print(fail)
            }
        }
    }
    
}

extension ProfileSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // print(dataModel.count)
        return dataModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartViewCollectIonvIewCell.reuseIdentifier, for: indexPath) as? StartViewCollectIonvIewCell else {
            print("셀 레지스터 문제이거나 애초에 셀이 잘못됨")
            return UICollectionViewCell()
        }
        cell.backgroundColor = .green
        let image = ImageManager.getImage(imageCase: .naverImage, image: dataModel.items[indexPath.row].thumbnail)
        cell.prepare(image: image, title: nil)
        return cell
    }

}
