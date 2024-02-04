/*
 
 */
import UIKit

class StartViewController: StartBaseViewController {

    let startView = StartView()
    // var data : [Int: [Searchs]] = [:]
    var model = SearchModel.self
    
    var dataModels : [Int: StartViewControllerModels] = [:]
    
    var startViewGeture: UITapGestureRecognizer?
    
    override func loadView() {
        self.view = startView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerDelegateDataSource()
        /// 서치 됨. 탑 됨, pop안됨 -> 트렌드 안됨 -> 모두 해결돰
        
        let group = DispatchGroup()
        // MARK: 그니까 즉 여기서 타입을 적는 이유가 나 이거씀 을 명시 하기 위해서다 라는 것이다.
        group.enter()
        TMDBAPIManager.shared.fetchSearchView(type: model, api: .trend(type: .day, language: .kor)) { results in
            //self.data[0] = results.results
            self.dataModels[0] = .trend(results)
            
            group.leave()
        }
        group.enter()
        TMDBAPIManager.shared.fetchSearchView(type: model, api: .top(language: .kor)) { results in
            //self.data[1] = results.results
            self.dataModels[1] = .top10(results)
            group.leave()
        }
        group.enter()
        TMDBAPIManager.shared.fetchSearchView(type: model, api: .popular(language: .kor)) { results in
            //self.data[2] = results.results
            self.dataModels[2] = .popular(results)
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.startView.trendTableView.reloadData()
        }
        
        searchBarRegister()
        navigationItem.title = "요즘 영화 뭐보지?"
        // 아ㅏ... 왜 자꾸 이름이 브싯해가지고 나를 이렇게 까지 고생시키는거야 망할 제스처 놈아
//        let uiViewGesture = UIGestureRecognizer(target: self.startView.self , action: #selector(viewEndEdition) )
//        uiViewGesture.isEnabled = true
//        self.startView.addGestureRecognizer(uiViewGesture)
        
        startViewGeture = UITapGestureRecognizer(target: self, action: #selector(viewEndEdition))
        startViewGeture?.isEnabled = false
        self.startView.addGestureRecognizer(startViewGeture ?? UITapGestureRecognizer())
    }
    @objc func viewEndEdition() {
        print(#function)
        startView.endEditing(true)
        startView.isUserInteractionEnabled = true
    }
    
    func searchBarRegister() {
        startView.searchBar.delegate = self
    }
}



// MARK: TableViewDelegate, DataSource

extension StartViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StartViewControllerTableCell.getIdentifier, for: indexPath) as! StartViewControllerTableCell
        
        cell.startCollectionView.dataSource = self
        cell.startCollectionView.delegate = self
        cell.startCollectionView.tag = indexPath.row
        cell.underLineLabel.text = SectionText.searchView.allCases[indexPath.row].rawValue
        
        cell.button.tag = indexPath.row
        cell.selectionStyle = .none
        
        cell.button.addTarget(self, action: #selector(nextView), for: .touchUpInside)
        
        return cell
    }
    
    // MARK: 오늘 나의 소중한 3시간 12분 45초를 여기에 쏟았다.
    // 다름아닌 저 제네릭을 이용한 전달방식으로 인해서...
    // 이유는 간단했다.
    ///func transitionView<T: UIViewController>(view: T, tresitionStyle: TransitionStyles) {
    //// let vc = T.self()
    ///이런식의 내용이였는데 난 바보다.....
    ///T 즉 타입을 받아서 그걸 생성하고 ㅋㅋㅋㅋㅋㅋㅋㅋ
    ///보내고 있다 참 어리석다.
    @objc func nextView(sender: UIButton) {
        
        let nextViewData = dataModels[sender.tag]
        
        let vc = AllListViewControler()
        
        switch nextViewData{
        case .top10(let model):
            vc.modelList = model.results
            vc.pageInCount = model.results.count
            vc.APIStyles = .top(language: .kor)
            vc.totalPageCount = model.total_pages
        case .trend(let model):
            vc.modelList = model.results
            vc.pageInCount = model.results.count
            vc.APIStyles = .trend(type: .day, language: .kor)
            vc.totalPageCount = model.total_pages
        case .popular(let model):
            vc.modelList = model.results
            vc.pageInCount = model.results.count
            vc.APIStyles = .popular(language: .kor)
            vc.totalPageCount = model.total_pages
        default : break
        }
            
        //vc.modelList = nextViewData
        print(#function)
        transitionView(viewInstens: vc , tresitionStyle: .present)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 3.7
    }
    
    func registerDelegateDataSource() {
        startView.trendTableView.dataSource = self
        startView.trendTableView.delegate = self
        
    }
    
}

// MARK: CollectionView Delegate, DataSource

extension StartViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let results = dataModels[collectionView.tag]
        switch results{
        case.top10(let datas) : return datas.results.count
        case.popular(let datas) : return datas.results.count
        case.trend(let datas) : return datas.results.count
        default : return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartViewCollectIonvIewCell.reuseIdentifier, for: indexPath) as! StartViewCollectIonvIewCell
        var cellForData: Searchs?
        
        let results = dataModels[collectionView.tag]
        
        switch results{
        case.top10(let datas) : cellForData = datas.results[indexPath.item]
        case.popular(let datas) : cellForData = datas.results[indexPath.item]
        case.trend(let datas) : cellForData = datas.results[indexPath.item]
        default : break
        }
        
        
        if let urlString = cellForData?.poster_path {
            let url = URL(string: ImageManager.baseImageUrl + urlString)
            cell.prepare(image: url , title: nil)
            return cell
        }
        
        cell.prepare(image: nil, title: cellForData?.name)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let results = dataModels[collectionView.tag]
        var id = 0
        switch results{
        case.top10(let datas) : id = datas.results[indexPath.item].id
        case.popular(let datas) : id = datas.results[indexPath.item].id
        case.trend(let datas) : id = datas.results[indexPath.item].id
        default : break
        }
        
        let vc = DetailViewController()
        vc.id = id
        transitionView(viewInstens: vc, tresitionStyle: .pushNavigation)
        
    }
}

extension StartViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let serchText = searchBar.text else {
            return
        }
        TMDBAPIManager.shared.fetchSearchView(type: SearchModel.self , api: .search(query: serchText, language: .kor)) { result in
            let vc = AllListViewControler()
            vc.modelList = result.results
            // spider man
            self.transitionView(viewInstens: vc.self, tresitionStyle: .present)
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        startViewGeture?.isEnabled = true
        print(startViewGeture?.isEnabled)
        return true
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        startViewGeture?.isEnabled = false
        return true
    }
}
