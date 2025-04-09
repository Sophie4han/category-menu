import UIKit
import SnapKit

class MainMenu: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
   
    let genreImages: [String: [String]] = [
        "스포츠": ["high", "big", "slam", "blue", "H2", "tennis", "yudo", "glof", "oneout", "free", "pedal", "gungdo"],
        "호러": ["ghoul", "mirae", "another", "piando", "invasion", "mis", "noa", "Ibitz", "humanity", "body", "six", "pumpkin"],
        "로맨스": ["kimini", "finger", "yamada", "kokoro", "moon", "star", "hananoi", "phantom"],
        "액션": ["one", "punch", "demon", "kaisen", "spy", "eight", "naruto", "bleach", "dragon", "hunter", "inu", "revenge"],
        "그때 그 시절": ["survive", "scary", "maple", "rome", "maho", "popular", "far", "jolla", "number", "three", "why", "math"]
    ]
    
    var currentImages: [String] = []
    let collectionLayout = UICollectionViewFlowLayout()
    let pageControl = UIPageControl()
    
   //초기화(대상에 따라 내용 변경됨)
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.collectionViewLayout = collectionLayout
        currentImages = genreImages["스포츠"] ?? [] // 기본으로 선택되어 있는 장르
        
        setupLayout()
        setupCollectionView()
        setupPageControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //레이아웃
    private func setupLayout() {
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 4, height: 180)
        collectionLayout.minimumInteritemSpacing = 0
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.sectionInset = .zero
    }
    //컬렉션뷰
    private func setupCollectionView() {
        self.backgroundColor = .clear
        self.register(MangaCollectionViewCell.self, forCellWithReuseIdentifier: MangaCollectionViewCell.identifier)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isPagingEnabled = true
    }

    
    //페이지 -> 동그라미 세개
    private func setupPageControl() {
        pageControl.numberOfPages = Int(ceil(Double(currentImages.count) / 4.0))
        pageControl.currentPage = 0
        //현재 보고 있는 페이지 버튼
        pageControl.currentPageIndicatorTintColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
        //기본 페이지 버튼
        pageControl.pageIndicatorTintColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 0.7)
        
        self.superview?.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(self.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    // 카테고리마다 적합한 페이지 뜨게,,
    @objc func genreTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle,
              let images = genreImages[title] else { return }
        
        currentImages = images
        pageControl.numberOfPages = Int(ceil(Double(currentImages.count) / 4.0))
        pageControl.currentPage = 0
        setContentOffset(.zero, animated: false)
        reloadData()
    }

    //수평 스크롤
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let currentPage = Int(round(scrollView.contentOffset.x / pageWidth))
        pageControl.currentPage = currentPage
    }
    
   //gpt
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: MangaCollectionViewCell.identifier, for: indexPath) as? MangaCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(imageName: currentImages[indexPath.item])
        return cell
    }
}
