//
//  GenreCollectionViewCells.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/6/24.
//

import UIKit
import SnapKit

final class GenreCollectionViewCells: BaseCollectionViewCell {

    let titleLabel: UILabel = {
       let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textColor = .white
        view.numberOfLines = 3
        view.textAlignment = .center
        //view.layer.borderWidth = 0.2
        
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
    }
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.safeAreaLayoutGuide)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide).inset(-18)
            make.height.equalTo(100)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(4)
        }
    }

}
