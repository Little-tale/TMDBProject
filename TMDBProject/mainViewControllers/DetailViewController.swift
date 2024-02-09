//
//  DetailViewController.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/2/24.
//

import UIKit

final class DetailViewController : DetailBaseViewController {
    
    private let homeView = DetailView()
   
    private var detailViewModel : [Int: DetailViewModels] = [ : ]
    // 한번에는 무린가?
    
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
            // [ V ] 모델레이어 이름 넣고 싶은데
            self.detailViewModel[0] = .detail(result)
            //self.detailViewModel.
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
        navigationItem.title = "검색결과"
    }
    private func delegateDateSource() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
    }
}

//MARK: 테이블뷰 딜리게이트 데이타 소스
extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        // print( tableView.layer.name )
        print(section)
        return detailViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let model = detailViewModel[indexPath.row]
        switch model {
        case .detail(let detailInfo):
            let cell = tableView.dequeueReusableCell(withIdentifier: ReusableIdentifier<DetailPosterViewCell>.reuseableItentifier, for: indexPath) as! DetailPosterViewCell
            
            // 수정중
            cell.prepareForInfo(name: detailInfo.name, overView: detailInfo.overView, date: detailInfo.first_air_date)
            
            let backUrl = ImageManager.getImage(imageCase: .detail, image: detailInfo.backdropPath)
            let posterUrl = ImageManager.getImage(imageCase: .detail, image: detailInfo.poster_path)
            
            cell.prepare(backDropImage: backUrl, miniPoster: posterUrl)
            return cell
            
            // 캐스트 모델
        case .cast(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: ReusableIdentifier<DetailRecommendTableViewCell>.reuseableItentifier, for: indexPath) as! DetailRecommendTableViewCell
            cell.recommendColletionView.dataSource = self
            cell.recommendColletionView.delegate = self
            cell.recommendColletionView.tag = indexPath.row
            cell.headerLabel.text = SectionText.DetailView.allCases[indexPath.row].rawValue
            cell.selectionStyle = .none
            return cell
            
            // 추천 모델 스타일
        case .recommendations(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: ReusableIdentifier<DetailRecommendTableViewCell>.reuseableItentifier, for: indexPath) as! DetailRecommendTableViewCell
            
            cell.recommendColletionView.dataSource = self 
            cell.recommendColletionView.delegate = self
            cell.recommendColletionView.tag = indexPath.row
            cell.headerLabel.text = SectionText.DetailView.allCases[indexPath.row].rawValue
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
        // 데이타 별 갯수가 다른 경우대비
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
            let imageString = ImageManager.getImage(imageCase: .detail, image: castInfos.profile_path)
            cell.prepareCrewPoster(image: imageString, title: name)
            print(name)
            
            return cell
            
        case .recommendations(let recommedInfo):
            let recommeds = recommedInfo.results[indexPath.item]
            let name = recommeds.name
            let castPoster = recommeds.poster_path
            let posterUrl = ImageManager.getImage(imageCase: .detail, image: castPoster)
            cell.prepare(image: posterUrl, title: name)
            
            return cell
        default : return cell
        }
    }
}




// // 불가능 -> 단일변수로는 앙됨
// var detailModel <T:Decodable> = []
// 아래 방식은 Decodable 로 다 받아서 구분지으려 했으나 들어가면 타입이 손실됨
// 즉 애매해짐
// var detailViewModel : [Int: Decodable] = [:]

// MARK: 해당 뷰에서 사용할 Enum(타입가능)으로 넣어준다.
//  var detailViewModel : [DeDetailViewModels] = []
// 또다른 문제 이렇게하면 순서가 보장이 안된다.
// 딕셔너리로 순서 잡으려고 한다. 딕셔너리는 순서를 보장 못하지만 키가 인덱스 패스면 되지 않을까?

// var detailViewModel : [Int: DetailViewModels] = [ : ]
// 좀더 뜯어 고쳐 볼 준비 하려고 한다....!
// Any? 로 다양하게 더 받은후에
// 키는 layer.name이나 다른게 들어갈수 있으면 넣으면 되지 않을까?
//var detailViewModel : [DetailViewModels.self: DetailViewModels] = [ : ]

// 일단 위에처럼은 불가능
// 놀랍게도 이건또 됨
// var detailViewModel : [UIView: DetailViewModels] = [ : ]
// 전혀 생각이 안떠오른다....
