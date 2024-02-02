
/*
 1. 필요한것.
 -> 이미지뷰
 -> 이름
 -> 줄거리
 -> 날짜
 
 */
import UIKit
import SnapKit

class DetailPosterViewCell : BaseTableViewCell {
    
    let ImageView = UIImageView()
    let detailView = overviewView()
    
    override func configureHierarchy() {
        contentView.addSubview(ImageView)
        ImageView.addSubview(detailView)
    }
    
    override func configureLayout() {
        ImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(UIScreen.main.bounds.height / 2.4)
        }
        detailView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(ImageView)
            make.height.equalTo(80).priority(500)
        }
        
    }
    override func designView() {
        contentView.backgroundColor = .white
    }
    
    
}
