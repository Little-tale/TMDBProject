//
//  StartViewControllerTableCell.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/2/24.
//

import UIKit
import SnapKit

class StartViewControllerTableCell : UITableViewCell {
    static var getIdentifier : String {
        return String(describing: self)
    }
    lazy var startCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    
    
    let underLineLabel = UnderLineLabel()
    let button = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierachy()
        register()
        designButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierachy(){
        contentView.addSubview(underLineLabel)
        contentView.addSubview(button)
        contentView.addSubview(startCollectionView)
    }
    
    func configureLayout(){
        underLineLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView).inset(4)
            make.height.equalTo(40)
        }
        button.snp.makeConstraints { make in
            make.trailing.equalTo(contentView)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        startCollectionView.snp.makeConstraints { make in
            make.top.equalTo(underLineLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView)
        }
    }
    
    func designView() {
        self.backgroundColor = .black
        self.contentView.backgroundColor = .black
        startCollectionView.backgroundColor = .black
        underLineLabel.setWidth(width: 10)
        
    }
    func designButton(){
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .white
        config.title = "크게보기"
        config.cornerStyle = .large
        config.buttonSize = .mini
        button.configuration = config
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayout()
        designView()
    }
    
    
}

// MARK: Layout
extension StartViewControllerTableCell {
    
    var collectionViewLayout : UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 110 , height: 160)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        layout.scrollDirection = .horizontal
        return layout
    }
    
}
// MARK: Register

extension StartViewControllerTableCell {
    func register(){
        startCollectionView.register(StartViewCollectIonvIewCell.self, forCellWithReuseIdentifier: StartViewCollectIonvIewCell.reuseIdentifier)
    }
}
