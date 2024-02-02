
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
    
    let backDropImageView = UIImageView()
    let miniPosterView = UIImageView()
    let detailView = overviewView()
    
    override func configureHierarchy() {
        contentView.addSubview(backDropImageView)
        backDropImageView.addSubview(detailView)
        backDropImageView.addSubview(miniPosterView)
    }
    
    override func configureLayout() {
        backDropImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(UIScreen.main.bounds.height / 1.7).priority(100)
        }
        detailView.snp.makeConstraints { make in
            
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.bottom.equalTo(backDropImageView.snp.bottom).inset(8)
            make.height.equalTo(200)
        }
        
        miniPosterView.snp.makeConstraints { make in
            make.bottom.equalTo(detailView.snp.top).inset( -12 )
            make.leading.equalTo(detailView.snp.leading).inset(4)
            make.width.equalTo(100)
            make.height.equalTo(miniPosterView.snp.width).multipliedBy(1.5)
        }
    }
    override func designView() {
        contentView.backgroundColor = .black
       // backDropImageView.backgroundColor = .red
        // detailView.backgroundColor = .gray
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        backDropImageView.layer.cornerRadius = 12
        backDropImageView.clipsToBounds = true
        // miniPosterView.backgroundColor = .blue
        miniPosterView.layer.cornerRadius = 12
        miniPosterView.clipsToBounds = true
    }
    
    
}
