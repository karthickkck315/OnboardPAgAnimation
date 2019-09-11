import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var slides:[Slide] = [];
    var arrayValues = Array<Dictionary<String,Any>>()
    override func viewDidLoad() {
        super.viewDidLoad()
        
         arrayValues = [["title":"A real-life bear","image":#imageLiteral(resourceName: "ic_onboarding_4"),"subtitle":"Did you know that Winnie the chubby little cubby was based on a real, young bear in London"],["title":"A real-life bear","image":#imageLiteral(resourceName: "ic_onboarding_1"),"subtitle":"Did you know that Winnie the chubby little cubby was based on a real, young bear in London"],["title":"A real-life bear","image":#imageLiteral(resourceName: "ic_onboarding_3"),"subtitle":"Did you know that Winnie the chubby little cubby was based on a real, young bear in London"],["title":"A real-life bear","image":#imageLiteral(resourceName: "ic_onboarding_3"),"subtitle":"Did you know that Winnie the chubby little cubby was based on a real, young bear in London"]]
        
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func createSlides() -> [Slide] {

        let array : NSMutableArray = NSMutableArray()
        for i in 0 ..< arrayValues.count {
            let dict = arrayValues[i]
            let slide:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide.backgroundColor = .blue
            slide.imageView.image = dict["image"] as? UIImage
            slide.labelTitle.text = dict["title"] as? String
            slide.labelTitle.textColor = .white
            slide.labelDesc.text = dict["subtitle"] as? String
            slide.labelDesc.textColor = .white
            array.add(slide)
        }
        return array as! [Slide]
    }
    
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.35) {
            
            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.35-percentOffset.x)/0.35, y: (0.35-percentOffset.x)/0.35)
            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.33, y: percentOffset.x/0.33)
            print("0")
        } else if(percentOffset.x > 0.35 && percentOffset.x <= 0.70) {
            print("1")
            slides[1].imageView.transform = CGAffineTransform(scaleX: (0.70-percentOffset.x)/0.35, y: (0.70-percentOffset.x)/0.35)
            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.66, y: percentOffset.x/0.66)
            
        } else if(percentOffset.x > 0.70 && percentOffset.x <= 1) {
            print("2")
            slides[2].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.35, y: (1-percentOffset.x)/0.35)
            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
            
        }
    }
    
    
    
    
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
    }
}

