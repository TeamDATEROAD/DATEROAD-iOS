//
//  ImageCarouselCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//

import UIKit

import SnapKit
import Then

protocol ImageCarouselDelegate: AnyObject {
    
    func didSwipeImage(index: Int, vc: UIPageViewController, vcData: [UIViewController])
    
}

final class ImageCarouselCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    let pageControllView = BottomPageControllView()
    
    
    // MARK: - Properties
    
    var vcData: [UIViewController] = []
    
    var thumbnailModel: ThumbnailModel?
    
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    weak var delegate: ImageCarouselDelegate?
    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        // 이미지 리소스 해제 및 다운로드 작업 취소
        vcData.forEach { vc in
            if let imageView = vc.view.subviews.first as? UIImageView {
                imageView.image = nil
                imageView.kf.cancelDownloadTask()
            }
        }
    }
    
    func setPageVC(thumbnailModel: [ThumbnailModel]) {
        vcData = thumbnailModel.map { thumbnail in
            let vc = UIViewController()
            let imageView = UIImageView()
            
            imageView.kfSetImage(with: thumbnail.imageUrl)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            vc.view.addSubview(imageView)
            
            imageView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            return vc
        }
        setVCInPageVC()
    }
    
    override func setHierarchy() {
        self.addSubview(pageViewController.view)
    }
    
    override func setLayout() {
        pageViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setVCInPageVC() {
        if let firstVC = vcData.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
        }
    }
    
    func setDelegate() {
        pageViewController.delegate = self
        pageViewController.dataSource = self
    }
    
    func setAccess(isAccess: Bool) {
        if isAccess {
            pageViewController.delegate = self
            pageViewController.dataSource = self
        } else {
            pageViewController.delegate = nil
            pageViewController.dataSource = nil
        }
    }
    
}

extension ImageCarouselCell: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = vcData.firstIndex(of: currentVC) else { return }
        self.delegate?.didSwipeImage(index: currentIndex, vc: pageViewController, vcData: vcData)
    }
    
}

extension ImageCarouselCell: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = vcData.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        
        return previousIndex < 0 ? nil : vcData[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = vcData.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        
        return nextIndex == vcData.count ? nil : vcData[nextIndex]
    }
    
}
