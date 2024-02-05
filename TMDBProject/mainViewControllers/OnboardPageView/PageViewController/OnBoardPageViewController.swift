import UIKit

//MARK: 1번 중요한건 각 뷰를 넣으려 했는데 안됨
// 뷰컨 기반이라고 되어 있드라 울지말고 해보자

class OnBoardPageViewController: BasePageViewController {
    
    
    var viewContollerList: [UIViewController?] =  []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        let firstViewCon = StartOnBoard()
        let secondViewCon = SecondOnBoard()
        let thirdViewCon = LastViewController()
        // 한 1시간 정도 왜 자꾸 갯수가 한개지 하고 테스트 해본결과
        // 원래 아래 변수님 성함이 viewControllers 이셨는데
        // 원래있는 이름이랑 충돌이 났었나봄 ㅠ
        viewContollerList = [firstViewCon, secondViewCon, thirdViewCon]
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
        guard let firstViewCon = viewContollerList[0] else {
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
        print(#function)
        print(viewContollerList.count)
        guard let nowIndex = viewContollerList.firstIndex(of: viewController) else {
            // 즉
            // 내 배열에 없는 뷰컨을 주신다면 때려 치세요 라는 내용
            return nil
        }
        // 이제 여기서 현재 -1 은 전뷰 인덱스 겠지?
        let beforeIndex = nowIndex - 1
        print(beforeIndex,"전 인덱스")
        // 만약 전뷰인덱스가 0보다 작다고?
        if beforeIndex < 0 {
            // 그램 때려쳐
            return nil
        }
        // 전뷰인덱스가 맞다면
        print(beforeIndex,"전 인덱스")
        return viewContollerList[beforeIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print(#function)
        
        guard let nowIndex = viewContollerList.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = nowIndex + 1
        print(nextIndex,"다음인덱스")
        return nextIndex >= viewContollerList.count ? nil : viewContollerList[nextIndex]
        
    }
    // UIPageViewController Indicators 추가방법
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewContollerList.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        print(pageViewController, "🔥")
        print(viewContollerList.first,"☑️")
        print(viewControllers?.first,"👺")
        
        // 밑에 출력결과를 보면 알수 있듯이 viewControllerList와 viewControllers의 각 시작이 같은지가
        // 중요하다 하지만 위에서 잘맞추었다고 해서 변경되지 않을 보장은 없을것이다.
//        guard let viewFirst =  viewControllers?.first,
//              let myviewListFirst = viewContollerList.first else {
//            return 0
//        }
//        if viewFirst == myviewListFirst {
//            return 0
//        }
//        return 0
        
        // 하지만 위에 코드는 항상 인스턴스의 주소가 같다는 보장이 없다
        // 주소를 떠나서 런타임중 뷰컨트롤러 인스턴스가 변경된다면?
        // 어느위치에 있는지 알아내는 방법도 아니게 될거다.
        // 그렇기 때문에 차라리
        
        // 뷰컨스에 계신 신성한 첫번째 뷰시여
            // 만약 저의 리스트에서 신성하신 첫번째 뷰가 계신다면...
        guard let viewFirst = viewControllers?.first,
              let myViewIndexOf = viewContollerList.firstIndex(of: viewFirst) else{
            // 그것이 첫번째 이오니 0을 반환하겠나이다.
            return 0
        }
        return 0
        // 그래서 이방법을 잭님이 알려주신거다.
    }
    /*
     <TMDBProject.OnBoardPageViewController: 0x13d80f400> 🔥
     Optional(Optional(<TMDBProject.StartOnBoard: 0x13af06900>)) ☑️
     Optional(<TMDBProject.StartOnBoard: 0x13af06900>) 👺
     <TMDBProject.OnBoardPageViewController: 0x13d80f400> 🔥
     Optional(Optional(<TMDBProject.StartOnBoard: 0x13af06900>)) ☑️
     Optional(<TMDBProject.StartOnBoard: 0x13af06900>) 👺
     */
}

