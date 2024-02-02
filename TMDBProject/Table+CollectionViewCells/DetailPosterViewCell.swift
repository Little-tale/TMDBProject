
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
            make.height.equalTo(UIScreen.main.bounds.height / 1.7).priority(501)
        }
        detailView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(ImageView)
            make.height.equalTo(180).priority(502)
        }
        
    }
    override func designView() {
        contentView.backgroundColor = .white
        ImageView.backgroundColor = .red
        detailView.backgroundColor = .gray
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        ImageView.layer.cornerRadius = 12
        ImageView.clipsToBounds = true
        
        
    }
    
    
}
