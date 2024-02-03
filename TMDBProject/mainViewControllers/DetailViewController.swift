//
//  DetailViewController.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/2/24.
//

import UIKit

class DetailViewController : DetailBaseView {
    
    let homeView = DetailView()
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        delegateDateSource()
    }
    func delegateDateSource() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
    }
}

//MARK: 테이블뷰 딜리게이트 데이타 소스
extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 진짜 다시봐도 이건 아닌것 같다 아마 이 제네릭은 여기까지다 개선된 버전으로 바꿔 보도록 노력해 보아야 한다. 멍청아
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReusableIdentifier<DetailPosterViewCell>.reuseableItentifier, for: indexPath) as! DetailPosterViewCell
            
            return cell
        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: ReusableIdentifier<UITableViewCell>.reuseableItentifier)!
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReusableIdentifier<DetailRecommendTableViewCell>.reuseableItentifier, for: indexPath) as! DetailRecommendTableViewCell
        
        cell.recommendColletionView.dataSource = self // <- 무슨 인스턴스? 나 임마 DetailViewController()
        cell.recommendColletionView.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


// MARK: 컬렉션뷰 딜리게이트 컬렉션뷰 데이타 소스

extension DetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartViewCollectIonvIewCell.reuseIdentifier, for: indexPath) as! StartViewCollectIonvIewCell
        
        
        return cell
    }
    
    
}
