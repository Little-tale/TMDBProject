//
//  GenreViewController.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/5/24.
//

import UIKit

class GenreViewController : StartBaseViewController {
    
    let homeView = GenreHomeView()
    
    override func loadView() {
        self.view = homeView
    }
    override func designView() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        homeView.buttonsHeaderView.buttonsColletionView.delegate = self
        homeView.buttonsHeaderView.buttonsColletionView.dataSource = self
    }
}

extension GenreViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseableIdentiFier, for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Test "
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    
}

extension GenreViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderButtonCell.reuseableIdentiFier, for: indexPath) as? HeaderButtonCell else {
            print("레지스터 문제?")
            return UICollectionViewCell()
        }
       
        cell.backgroundColor = .red
        return cell
        
    }
    
    
}
