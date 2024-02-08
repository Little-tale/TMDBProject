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
    var totalCount = 0
    var totalPage = 1
    
    var getImageName: ((String) -> Void)?
    
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
        homeView.searchBar.delegate = self
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
        totalCount = dataModel.total
        return dataModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartViewCollectIonvIewCell.reuseIdentifier, for: indexPath) as? StartViewCollectIonvIewCell else {
            print("셀 레지스터 문제이거나 애초에 셀이 잘못됨")
            return UICollectionViewCell()
        }
        cell.backgroundColor = .gray
        let image = ImageManager.getImage(imageCase: .naverImage, image: dataModel.items[indexPath.row].thumbnail)
        
        // collectionView.layer.name = dataModel.items[indexPath.row].thumbnail
        print(dataModel.items[indexPath.row].thumbnail,"🐥🐥🐥🐥🐥🐥🐥🐥🐥🐥🐥🐥🐥🐥")
        cell.prepare(image: image, title: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        backView(image: dataModel.items[indexPath.row].thumbnail)
    }
    
    func backView(image: String) {
        print(image,"😗😗😗😗😗😗😗😗😗😗😗😗😗")
        getImageName?(image)
        self.dismiss(animated: true)
    }

}


extension ProfileSearchViewController: UISearchBarDelegate{
    TextField
}


//extension ProfileSearchViewController: UICollectionViewDataSourcePrefetching {
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//            //print("프리패칭 인덱스 패스 : ",indexPath.row)
//            
////            if presentItemCount - 10 <= indexPath.row && pageNum <= totalPageCount{
////                presentItemCount += pageInCount
////                pageNum += 1
////                TMDBAPIManager.shared.fetchOnlyForAllListView(type: SearchModel.self, api: APIStyles ?? .top(language: .kor), pageNum: pageNum) { results in
////                    self.modelList?.append(contentsOf: results.results)
////                }
////            }
//            
//            
//            
//        }
//        func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
//            print("불러오기 안할꼬야 ", indexPaths)
//            //print("이건 전혀 감이 안온다.")
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
//        
//    }
//}
