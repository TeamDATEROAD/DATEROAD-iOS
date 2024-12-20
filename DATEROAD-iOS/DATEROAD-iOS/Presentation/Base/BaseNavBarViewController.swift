//
//  BaseNavBarViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/1/24.
//

import UIKit

import Lottie
import SnapKit
import Then

class BaseNavBarViewController: UIViewController {
    
    // MARK: - UI Properties
    
    let topInsetView = UIView()
    
    var navigationBarView = UIView()
    
    var contentView = UIView()
    
    private var leftButton = UIButton()
    
    private var rightButton = UIButton()
    
    var titleLabel = UILabel()
    
    private let backgroundView: UIView = UIView()
    
    let lottieView = LottieAnimationView(name: "clearLoading")
    
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    func setHierarchy() {
        self.view.addSubviews(
            topInsetView,
            navigationBarView,
            contentView
        )
        self.navigationBarView.addSubviews(
            leftButton,
            titleLabel,
            rightButton
        )
    }
    
    func setLayout() {
        topInsetView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(topInsetView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(55)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        leftButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        rightButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    func setStyle() {
        self.view.backgroundColor = UIColor(resource: .drWhite)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        leftButton.isHidden = true
        
        rightButton.isHidden = true
        
        titleLabel.isHidden = true
    }
    
}


// MARK: - NavigationBar Custom Methods

extension BaseNavBarViewController {
    
    func setBackgroundColor(color: UIColor) {
        topInsetView.backgroundColor = color
        
        navigationBarView.backgroundColor = color
    }
    
    func setLeftButtonStyle(image: UIImage?) {
        leftButton.do {
            $0.isHidden = false
            $0.setImage(image, for: .normal)
        }
    }
    
    func setRightButtonStyle(image: UIImage?) {
        rightButton.do {
            $0.isHidden = false
            $0.setImage(image, for: .normal)
        }
    }
    
    func setRightBtnStyle() {
        rightButton.do {
            $0.contentHorizontalAlignment = .center
            var config = UIButton.Configuration.plain()
            var titleAttr = AttributedString.init(StringLiterals.AddCourseOrSchedule.AddFirstView.addScheduleRightBtn)
            titleAttr.font = UIFont.suit(.body_med_10)
            config.attributedTitle = titleAttr
            config.baseForegroundColor = UIColor(resource: .drWhite)
            config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
            config.buttonSize = .mini
            config.background.backgroundColor = UIColor(resource: .deepPurple)
            $0.configuration = config
            $0.isHidden = false
        }
        
        rightButton.snp.remakeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setLeftButtonAction(target: Any, action: Selector) {
        leftButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func setRightButtonAction(target: Any, action: Selector) {
        rightButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func setLeftBackButton() {
        setLeftButtonStyle(image: UIImage(named: "leftArrow"))
        setLeftButtonAction(target: self, action: #selector(backButtonTapped))
    }
    
    func setTitleLabelStyle(title: String?, alignment: NSTextAlignment) {
        titleLabel.do {
            $0.isHidden = false
            $0.text = title
            $0.font = UIFont(name: "SUIT-Bold", size: 20)
            $0.textColor = .black
            $0.textAlignment = alignment
        }
    }
    
    /// 키보드 외 영역 터치시 키보드 닫기
    func setupKeyboardDismissRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func showLoadingView(type: String? = nil, topInset: Int = 104) {
        // 로딩 뷰 설정
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        lottieView.play()
        
        if type == StringLiterals.TabBar.myPage
            || type == StringLiterals.AddCourseOrSchedule.addScheduleTitle {
            backgroundView.backgroundColor = UIColor.clear
            lottieView.backgroundColor = UIColor.clear
        } else {
            backgroundView.backgroundColor = UIColor(resource: .drWhite)
            lottieView.backgroundColor = UIColor(resource: .drWhite)
        }
        
        // 로딩 뷰를 화면에 추가
        self.view.addSubviews(backgroundView, lottieView)
        
        if type == nil {
            backgroundView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            
            lottieView.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        } else {
            backgroundView.snp.makeConstraints {
                $0.top.equalToSuperview().inset(topInset)
                $0.bottom.equalToSuperview().inset(view.frame.height * 0.11)
                $0.horizontalEdges.equalToSuperview()
            }
            
            lottieView.snp.makeConstraints {
                $0.verticalEdges.equalTo(backgroundView)
                $0.horizontalEdges.equalToSuperview()
            }
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
            self.navigationController?.popViewController(animated: false)
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    
}
