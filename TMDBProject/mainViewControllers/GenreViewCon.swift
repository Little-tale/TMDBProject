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

//MARK: 알럿설정
class GenreViewCon: StartBaseViewController {
    let homeView = GenreHomeVIew()
    var genrModel: [GenreElement]?
    var colorArray : Array<UIColor> = []
    override func loadView() {
        self.view = homeView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        genrModel = []
        URLSessionManager.Shared.requestOfSession(type: Genre.self, request: URLAPI.genre(language: .kor)) { response in
            switch response{
            case .success(let success):
                self.genrModel?.append(contentsOf: success.genres)
                self.homeView.genreCollectionView.reloadData()
            case .failure(let fail):
                let alert = AlertManager.shared.getAlert(error: fail)
                self.present(alert, animated: true)
            }
        }
        navigationItem.title = "장르"
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
// 일단 색을 그냥 Array에 추가후 다시 참조해서 사용하도록 하였다,.
extension GenreViewCon: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genrModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCells.reuseableIdentiFier, for: indexPath) as? GenreCollectionViewCells else {
            print("cell레지스터 문제")
            return UICollectionViewCell()
        }
        colorArray.append(UIColor(red: CGFloat.random(in: 0...255) / 255, green: CGFloat.random(in: 0...150) / 255, blue: CGFloat.random(in: 0...150) / 255, alpha: 1))
        
        cell.backgroundColor = colorArray[indexPath.row]
        cell.layer.cornerRadius = 20
        
        guard let data = genrModel?[indexPath.row] else {
            print("데이터 문제")
            return UICollectionViewCell()
        }
        
        let text = data.name.replacingOccurrences(of: " ", with: "\n")
        
        cell.titleLabel.text = text
        cell.layer.name = String(data.id)
        
        return cell
    }
    
}


#Preview{
    GenreViewCon()
}

