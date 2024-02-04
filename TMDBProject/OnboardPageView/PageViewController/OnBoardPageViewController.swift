import UIKit

//MARK: 1번 중요한건 각 뷰를 넣으려 했는데 안됨
// 뷰컨 기반이라고 되어 있드라 울지말고 해보자

class OnBoardPageViewController: BasePageViewController {
    
    
    var viewContollers: [UIViewController?] =  []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let firstViewCon = StartOnBoard()
        let secondViewCon = SecondOnBoard()
        //let thirdViewCon = StartOnBoard()
        viewContollers = [firstViewCon, secondViewCon] //, thirdViewCon]
        register()
    }
    
    func register() {
        self.delegate = self
        self.dataSource = self
        // 아니 스타일을 이시점에서는 get만 가능하다.
        
        // self.transitionStyle = .scroll
        // 난 이렇게 넘겨주면 될줄 알았으나 크나큰 착각이였다
        // 이건 첫뷰컨트롤러가 무엇인지 정하는 거였다.
        
        // 첫번째 뷰 컨트롤러를 보여질 화면 즉 현재 페이지로 구성
        guard let firstViewCon = viewContollers[0] else {
            return
        }
        
        setViewControllers([firstViewCon], direction: .forward, animated: true)
    }
}
extension OnBoardPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    // 이전 페이지 뷰컨트롤러를 반환 받는 메서드 즉
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // 이때 전뷰를 받아왔는데 첫번째 인덱스와 같다면...? 가 아니다. 난 바보다 firsIndex라고 해서 첫번째 인덱스에 있는
        // 뷰컨과 이뷰컨을 비교하라는줄 알았다 멍청이다
        // 그게아니라 처음부터 쭉 보다가 첫번째로 같은 인덱스를 반환하는 메서드 였던 거시기
        //  Array<UIViewController>.Index
        guard let nowIndex = viewControllers?.firstIndex(of: viewController) else {
            // 즉
            // 내 배열에 없는 뷰컨을 주신다면 때려 치세요 라는 내용
            return nil
        }
        // 이제 여기서 현재 -1 은 전뷰 인덱스 겠지?
        let beforeIndex = nowIndex - 1
        // 만약 전뷰인덱스가 0보다 작다고?
        if beforeIndex - 1 < 0 {
            // 그램 때려쳐
            return nil
        }
        // 전뷰인덱스가 맞다면
        return viewContollers[beforeIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let nowIndex = viewContollers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = nowIndex + 1
        
        
        return nextIndex > viewControllers?.count ?? 0 ? nil : viewContollers[nextIndex]
        
    }
    
    
}

