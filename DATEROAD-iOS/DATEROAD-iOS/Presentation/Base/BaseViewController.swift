//
//  BaseViewController.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 6/26/24.
//

import UIKit

import Lottie
import SnapKit
import Then

class BaseViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let backgroundView: UIView = UIView()
    
    let lottieView = LottieAnimationView(name: "clearLoading")
    
    
    // MARK: - UI Properties
    
    var onDismiss: (() -> Void)?
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    func setHierarchy() {}
    
    func setLayout() {}
    
    func setStyle() {
        self.view.backgroundColor = .drWhite
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func showLoadingView(type: String) {
        // 로딩 뷰 설정
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        lottieView.play()

        if type == StringLiterals.TabBar.home
            || type == StringLiterals.TabBar.myPage
            || type == StringLiterals.Course.course
            || type == StringLiterals.Amplitude.ViewPath.courseDetail
            || type == StringLiterals.ViewedCourse.title {
            backgroundView.backgroundColor = UIColor.clear
            lottieView.backgroundColor = UIColor.clear
        } else {
            backgroundView.backgroundColor = UIColor(resource: .drWhite)
            lottieView.backgroundColor = UIColor(resource: .drWhite)
        }
        
        
        // 로딩 뷰를 화면에 추가
        self.view.addSubviews(backgroundView, lottieView)
        
        if type == StringLiterals.DateSchedule.upcomingDate {
            backgroundView.snp.makeConstraints {
                $0.top.equalToSuperview().inset(104)
                $0.bottom.equalToSuperview().inset(view.frame.height * 0.11)
                $0.horizontalEdges.equalToSuperview()
            }
        } else if type == StringLiterals.Course.course {
            backgroundView.snp.makeConstraints {
                $0.top.equalToSuperview().inset(188)
                $0.bottom.equalToSuperview().inset(view.frame.height * 0.11)
                $0.horizontalEdges.equalToSuperview()
            }
        } else if type == StringLiterals.ViewedCourse.title {
            backgroundView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.bottom.equalToSuperview().inset(view.frame.height * 0.11)
                $0.horizontalEdges.equalToSuperview()
            }
        } else {
            backgroundView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        lottieView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func hideLoadingView() {
        // 로딩 뷰 중지 및 제거
        lottieView.stop()
        backgroundView.removeFromSuperview()
        lottieView.removeFromSuperview()
    }
    
    func presentAlertVC(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: StringLiterals.Alert.confirm, style: .cancel) { _ in
            self.navigationController?.popToRootViewController(animated: false)
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
 
    /// 키보드 외 영역 터치시 키보드 닫기
    func setupKeyboardDismissRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension BaseViewController {
    
    func presentBottomSheet(
        _ contentView: UIView,
        _ dimmedView: UIView,
        in viewController: UIViewController,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        self.modalPresentationStyle = .overFullScreen
        viewController.present(self, animated: false) {
            self.animateBottomSheetPresentation(
                contentView,
                dimmedView,
                animated: animated,
                completion: completion
            )
        }
    }
    
    func dismissBottomSheet(
        _ contentView: UIView,
        _ dimmedView: UIView,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                contentView.transform = CGAffineTransform(translationX: 0, y: ScreenUtils.height / 812 * 642)
                dimmedView.alpha = 0
            }, completion: { _ in
                self.dismiss(animated: false, completion: completion)
            })
        } else {
            dimmedView.alpha = 0
            self.dismiss(animated: false, completion: completion)
        }
    }
    
    private func animateBottomSheetPresentation(
        _ contentView: UIView,
        _ dimmedView: UIView,
        animated: Bool,
        completion: (() -> Void)? = nil
    ) {
        if animated {
            contentView.transform = CGAffineTransform(translationX: 0, y: ScreenUtils.height / 812 * 642)
            dimmedView.alpha = 0
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                dimmedView.alpha = 1
                contentView.transform = .identity
            }, completion: { _ in
                completion?()
            })
        } else {
            contentView.alpha = 1
            completion?()
        }
    }
    
}
