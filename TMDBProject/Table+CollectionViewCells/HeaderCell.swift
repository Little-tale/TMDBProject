//
//  HeaderCell.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/3/24.
//

import UIKit
import SnapKit
import Kingfisher

class HeaderCell: BaseCollectionViewCell {
    
    let backDrop = UIImageView()
    
    
    override func configureHierarchy() {
        contentView.addSubview(backDrop)
    }
    override func configureLayout() {
        backDrop.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    override func designView() {
        backDrop.contentMode = .scaleAspectFill
        backDrop.backgroundColor = .white
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setImage(image: nil)
    }
    func setImage(image: URL?) {
        print(image)
        backDrop.kf.setImage(with: image, options: [.transition(.fade(0.4)), .forceTransition])
    }
    
}
