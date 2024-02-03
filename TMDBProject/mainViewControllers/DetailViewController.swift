//
//  DetailViewController.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/2/24.
//

import UIKit

class DetailViewController : DetailBaseView {
    
    let homeView = DetailView()
    // 불가능 -> 단일변수로는 앙됨
    // var detailModel <T:Decodable> = []
    // 아래 방식은 Decodable 로 다 받아서 구분지으려 했으나 들어가면 타입이 손실됨
    // 즉 애매해짐
    // var detailViewModel : [Int: Decodable] = [:]
    
    // MARK: 해당 뷰에서 사용할 Enum(타입가능)으로 넣어준다.
    //  var detailViewModel : [DeDetailViewModels] = []
    // 또다른 문제 이렇게하면 순서가 보장이 안된다.
    // 딕셔너리로 순서 잡으려고 한다. 딕셔너리는 순서를 보장 못하지만 키가 인덱스 패스면 되지 않을까?
    var detailViewModel : [Int: DetailViewModels] = [ : ]
    
    var id = 93405
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        delegateDateSource()
        let group = DispatchGroup()
        group.enter()
        TMDBAPIManager.shared.fetchDetailView(type: DetailModel.self, api: .detail(id: self.id, language: .kor)) {
            result in
            // MARK: 이때 어떤 케이스(이것도 타입이 됨) 인지 정하고 모델을 넣어주면 모델 타입의 손실을 막을수 있다.
            self.detailViewModel[0] = .detail(result)
            group.leave()
        }
        group.enter()
        TMDBAPIManager.shared.fetchDetailView(type: CastModel.self, api: .crew(id: self.id)) {
            result in
            self.detailViewModel[1] = .cast(result)
            group.leave()
        }
        group.enter()
        TMDBAPIManager.shared.fetchDetailView(type: DetailModels.self, api: .recommend(id: self.id, language: .kor)) {
            result in
            self.detailViewModel[2] = .recommendations( result )
            group.leave()
        }
        group.notify(queue: .main) {
            self.homeView.tableView.reloadData()
        }
        
    }
    func delegateDateSource() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
    }
}

//MARK: 테이블뷰 딜리게이트 데이타 소스
extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 진짜 다시봐도 이건 아닌것 같다 아마 이 제네릭은 여기까지다 개선된 버전으로 바꿔 보도록 노력해 보아야 한다. 멍청아
        
        // 아니 왜자꾸 자동완성 안되누 다 쳐야 하누
        let model = detailViewModel[indexPath.row]
        switch model {
        case .detail(let detailInfo):
            let cell = tableView.dequeueReusableCell(withIdentifier: ReusableIdentifier<DetailPosterViewCell>.reuseableItentifier, for: indexPath) as! DetailPosterViewCell
            if let backdropString = detailInfo.backdropPath {
               
                guard let posterString = detailInfo.poster_path else {
                    
                    let backurl = ImageManager.getImage(imageCase: .detail , image: backdropString)
                    cell.prepare(backDropImage: backurl, miniPoster: nil)
                    
                    cell.detailView.nameLabel.text = detailInfo.name
                    cell.detailView.overViewLabel.text = detailInfo.overView
                    cell.detailView.dateLabel.text = detailInfo.first_air_date
                    return cell
    
                }
                let backurl = ImageManager.getImage(imageCase: .detail , image: backdropString)
                let posterUrl = ImageManager.getImage(imageCase: .detail, image: posterString)
                cell.prepare(backDropImage: backurl, miniPoster: posterUrl)
                
                cell.detailView.nameLabel.text = detailInfo.name
                cell.detailView.overViewLabel.text = detailInfo.overView
                cell.detailView.dateLabel.text = detailInfo.first_air_date
                
                return cell
            }
            
           
            
        case .cast(let castInfo):
            let cell = tableView.dequeueReusableCell(withIdentifier: ReusableIdentifier<DetailRecommendTableViewCell>.reuseableItentifier, for: indexPath) as! DetailRecommendTableViewCell
            cell.recommendColletionView.dataSource = self
            cell.recommendColletionView.delegate = self
            cell.recommendColletionView.tag = indexPath.row
            return cell
        case .recommendations(let recommendInfo):
            let cell = tableView.dequeueReusableCell(withIdentifier: ReusableIdentifier<DetailRecommendTableViewCell>.reuseableItentifier, for: indexPath) as! DetailRecommendTableViewCell
            
            cell.recommendColletionView.dataSource = self // <- 무슨 인스턴스? 나 임마 DetailViewController()
            cell.recommendColletionView.delegate = self
            cell.recommendColletionView.tag = indexPath.row
            cell.selectionStyle = .none
            return cell
        case .none:
            print("none")
        }
        let cell = UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


// MARK: 컬렉션뷰 딜리게이트 컬렉션뷰 데이타 소스

extension DetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let datas = detailViewModel[collectionView.tag]
        switch datas {
        case .cast(let castInfo):
            return castInfo.cast.count
        case .recommendations(let recommedInfo):
            return recommedInfo.results.count
        default : return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartViewCollectIonvIewCell.reuseIdentifier, for: indexPath) as! StartViewCollectIonvIewCell
        let datas = detailViewModel[collectionView.tag]
        switch datas {
        case .cast(let castInfo):
            let castInfos = castInfo.cast[indexPath.item]
            let name = castInfos.name
            
            if let castProfile = castInfos.profile_path {
                let posterUrl = ImageManager.getImage(imageCase: .detail, image: castProfile)
                
                cell.prepareCrewPoster(image: posterUrl, title: name)
                return cell
            }
            // print(castInfos.profile_path)
            cell.prepare(image: nil, title: name)
            return cell
            
        case .recommendations(let recommedInfo):
            let recommeds = recommedInfo.results[indexPath.item]
            let name = recommeds.name
            
            if let castPoster = recommeds.poster_path {
                let posterUrl = ImageManager.getImage(imageCase: .detail, image: castPoster)
                
                cell.prepare(image: posterUrl, title: name)
                return cell
            }
            cell.prepare(image: nil, title: name)
            return cell
        default : return cell
        }
    }
}


