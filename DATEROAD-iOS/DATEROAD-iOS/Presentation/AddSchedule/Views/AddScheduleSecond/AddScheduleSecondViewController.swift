//
//  AddScheduleSecondViewController.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/18/24.
//

import UIKit

import SnapKit
import Then

final class AddScheduleSecondViewController: BaseNavBarViewController {
    
    // MARK: - UI Properties
    
    private var addScheduleSecondView = AddScheduleSecondView()
    
    private let viewModel: AddScheduleViewModel
    
    private var alertVC: AddScheduleBottomSheetViewController?
    
    private let errorView: DRErrorViewController = DRErrorViewController()
    
    
    // MARK: - Initializer
    
    init(viewModel: AddScheduleViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setStyle()
        setTitleLabelStyle(title: StringLiterals.AddCourseOrSchedule.addScheduleTitle, alignment: .center)
        setLeftBackButton()
        setAddTarget()
        setDelegate()
        registerCell()
        bindViewModel()
        pastDateBindViewModel()
        setupKeyboardDismissRecognizer()
    }
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        super.setHierarchy()
        
        contentView.addSubview(addScheduleSecondView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        addScheduleSecondView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(4)
        }
    }
    
    override func setStyle() {
        super.setStyle()
        
        addScheduleSecondView.do {
            $0.isUserInteractionEnabled = true
            $0.backgroundColor = UIColor(resource: .drWhite)
        }
    }
    
}


// MARK: - AddScheduleSecondVC Methods

private extension AddScheduleSecondViewController {
    
    func registerCell() {
        addScheduleSecondView.addPlaceCollectionView.register(AddSecondViewCollectionViewCell.self, forCellWithReuseIdentifier: AddSecondViewCollectionViewCell.cellIdentifier)
    }
    
    func setDelegate() {
        addScheduleSecondView.addPlaceCollectionView.do {
            $0.delegate = self
            $0.dragDelegate = self
            $0.dropDelegate = self
            $0.dataSource = self
        }
        
        [addScheduleSecondView.inAddScheduleSecondView.datePlaceTextField, addScheduleSecondView.inAddScheduleSecondView.timeRequireTextField].forEach {
            $0.delegate = self
        }
    }
    
    
    
    func bindViewModel() {
        self.viewModel.isSuccessPostData.bind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess {
                self?.successDone()
            }
        }
        
        self.viewModel.onFailNetwork.bind { [weak self] onFailure in
            guard let onFailure else { return }
            
            // 에러 발생 시 에러 뷰로 push
            if onFailure {
                let errorVC = DRErrorViewController()
                
                // DRErrorViewController가 닫힐 때의 동작 정의
                errorVC.onDismiss = {
                    print("🚀onDismiss 출동🚀")
                    // 일정 등록 2 로딩뷰, 에러뷰 false 설정
                    self?.viewModel.onFailNetwork.value = false
                    self?.viewModel.onLoading.value = false
                    self?.addScheduleSecondView.nextBtn.isUserInteractionEnabled = true
                }
                
                self?.navigationController?.pushViewController(errorVC, animated: false)
            }
        }
        
        self.viewModel.onLoading.bind { [weak self] onLoading in
            guard let onLoading, let onFailNetwork = self?.viewModel.onFailNetwork.value else { return }
            
            if !onFailNetwork {
                onLoading ? self?.showLoadingView(type: StringLiterals.TabBar.myPage) : self?.hideLoadingView()
            }
        }
        
        self.viewModel.onReissueSuccess.bind { [weak self] onSuccess in
            guard let onSuccess else { return }
            if onSuccess {
                self?.viewModel.postAddScheduel()
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
        
        viewModel.outputEditBtnEnableState.bind { [weak self] enableState in
            guard let enableState else {return}
            self?.addScheduleSecondView.editBtnState(isAble: enableState)
        }
        
        viewModel.datePlace.bind { [weak self] date in
            guard let text = date else {return}
            self?.addScheduleSecondView.inAddScheduleSecondView.updateDatePlace(text: text)
            self?.viewModel.addScheduleAmplitude.dateDetailLocation = !(self?.viewModel.datePlace.value?.isEmpty ?? true)
            self?.checkAddPlaceBtnState()
        }
        
        viewModel.outputTimeRequire.lazyBind { [weak self] value in
            guard let value else {return}
            self?.addScheduleSecondView.inAddScheduleSecondView.updatetimeRequire(text: value)
            self?.checkAddPlaceBtnState()
        }
        
        self.viewModel.isChange = { [weak self] in
            guard let cnt = self?.viewModel.addPlaceCollectionViewDataSource.count else {return}
            print(cnt)
            
            self?.viewModel.inputCheckEditBtnState.value = true
//            self?.viewModel.isDataSourceNotEmpty()
            
            
            
//            let state = self?.viewModel.editBtnEnableState.value ?? false
            
//            self?.addScheduleSecondView.editBtnState(isAble: state)
            
            self?.addScheduleSecondView.inAddScheduleSecondView.finishAddPlace()
            
            self?.viewModel.isSourceMoreThanOne()
            
            self?.addScheduleSecondView.addPlaceCollectionView.reloadData()
        }
        
        self.viewModel.isValidOfSecondNextBtn.bind { [weak self] date in
            self?.addScheduleSecondView.changeNextBtnState(flag: date ?? false)
        }
    }
    
    func setAddTarget() {
        addScheduleSecondView.editButton.addTarget(self, action: #selector(toggleEditMode), for: .touchUpInside)
        
        addScheduleSecondView.inAddScheduleSecondView.addPlaceButton.addTarget(self, action: #selector(tapAddPlaceBtn), for: .touchUpInside)
        
        addScheduleSecondView.nextBtn.addTarget(self, action: #selector(didTapNextBtn), for: .touchUpInside)
    }
    
    func checkAddPlaceBtnState() {
        let flag = self.viewModel.isAbleAddBtn()
        self.addScheduleSecondView.inAddScheduleSecondView.changeAddPlaceButtonState(flag: flag)
    }
    
    /// '등록 완료' 이후 tabBarVC를 통해 화면 전환
    func goBackOriginVCForAddSchedule() {
        let tabbarVC = TabBarController()
        tabbarVC.selectedIndex = 2
        navigationController?.popToPreviousViewController(ofType: AddScheduleFirstViewController.self, defaultViewController: tabbarVC)
    }
    
}


//MARK: - AddScheduleFirstViewController: BaseNavBarViewController

extension AddScheduleSecondViewController {
    
    private func pastDateBindViewModel() {
        if viewModel.isBroughtData  {
            for i in viewModel.pastDatePlaces {
                if let doubleValue = Double(String(i.duration)) {
                    let text = doubleValue.truncatingRemainder(dividingBy: 1) == 0 ?
                    String(Int(doubleValue)) : String(doubleValue)
                    viewModel.tapAddBtn(datePlace: i.title, timeRequire: "\(text) 시간")
                } else {
                    viewModel.tapAddBtn(datePlace: i.title, timeRequire: "\(String(i.duration)) 시간")
                }
            }
            viewModel.pastDatePlaces.removeAll()
            AmplitudeManager.shared.trackEvent(StringLiterals.Amplitude.EventName.viewAddBringcourse2)
        } else {
            AmplitudeManager.shared.trackEvent(StringLiterals.Amplitude.EventName.viewAddSchedule2)
        }
    }
    
    @objc
    override func backButtonTapped() {
        viewModel.addScheduleAmplitude.sendAmplitudeEvent(step: 2)
        super.backButtonTapped()
    }
    
}


//MARK: - AddScheduleSecondViewController: '일정등록 뷰2 프로퍼티' 관련 함수

private extension AddScheduleSecondViewController {
    // 등록 완료 alertVC도 blurView 페이드인 적용 미정
    func successDone() {
        let customAlertVC = DRCustomAlertViewController(rightActionType: .none,
                                                        alertTextType: .hasDecription,
                                                        alertButtonType: .oneButton,
                                                        titleText: StringLiterals.AddCourseOrSchedule.AddCourseAlert.alertScheduelTitleLabel,
                                                        longButtonText: StringLiterals.AddCourseOrSchedule.AddCourseAlert.doneButton)
        customAlertVC.delegate = self
        customAlertVC.modalPresentationStyle = .overFullScreen
        self.present(customAlertVC, animated: false)
    }
    
    
    // MARK: - @objc Methods
    
    /// '완료' 버튼 관련
    @objc
    func didTapNextBtn() {
        addScheduleSecondView.nextBtn.isUserInteractionEnabled = false
        viewModel.postAddScheduel()
    }
    
    /// '소요시간' 관련
    @objc
    func textFieldTapped(_ textField: UITextField) {
        let alertVC = AddScheduleBottomSheetViewController(viewModel: viewModel)
        alertVC.addSheetView = AddScheduleBottomSheetView(isCustomPicker: true)
        
        self.alertVC = alertVC // alertVC를 인스턴스 변수에 저장
        addScheduleSecondView.inAddScheduleSecondView.datePlaceTextField.resignFirstResponder()
        
        DispatchQueue.main.async {
            alertVC.presentBottomSheet(in: self)
        }
    }
    
    /// '장소 등록 +' 버튼 관련
    @objc
    func tapAddPlaceBtn() {
        viewModel.tapAddBtn(datePlace: viewModel.datePlace.value ?? "", timeRequire: viewModel.outputTimeRequire.value ?? "")
    }
    
    /// '편집' 버튼 관련
    @objc
    func toggleEditMode() {
        viewModel.isEditMode.toggle()
        let collectionView = addScheduleSecondView.addPlaceCollectionView
        
        let flag = viewModel.isEditMode
        print("현재 editButton editBtnEnableState.value 값 ::: \(flag)")
        
        collectionView.visibleCells.forEach { cell in
            if let customCell = cell as? AddSecondViewCollectionViewCell {
                customCell.updateEditMode(flag: flag)
                customCell.moveAbleButton.removeTarget(nil, action: nil, for: .allEvents)
                if flag {
                    customCell.moveAbleButton.addTarget(self, action: #selector(removeCell(sender:)), for: .touchUpInside)
                } else {
                    customCell.moveAbleButton.addTarget(self, action: #selector(moveCell(sender:)), for: .touchUpInside)
                }
            }
        }
        addScheduleSecondView.updateEditBtnText(flag: flag)
        
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
    }
    
    /// 장소 리스트 'X' 버튼 관련: list에 있는 장소 삭제
    @objc
    func removeCell(sender: UIButton) {
        guard let cell = sender.superview?.superview as? AddSecondViewCollectionViewCell,
              let indexPath = addScheduleSecondView.addPlaceCollectionView.indexPath(for: cell) else { return }
        
        viewModel.addPlaceCollectionViewDataSource.remove(at: indexPath.item)
        addScheduleSecondView.addPlaceCollectionView.deleteItems(at: [indexPath])
        viewModel.isSourceMoreThanOne()
        
        //여기서 datasource가 1개 미만이면
        let dataSourceCnt = viewModel.addPlaceCollectionViewDataSource.count
        if dataSourceCnt < 1 {
            cell.updateEditMode(flag: false)
            addScheduleSecondView.updateEditBtnText(flag: false)
            addScheduleSecondView.editBtnState(isAble: false)
            viewModel.isEditMode = false
        }
    }
    
    /// '=' 버튼 관련
    @objc
    func moveCell(sender: UIButton) {
    }
    
}


// MARK: - UITextFieldDelegate Methods

extension AddScheduleSecondViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField != addScheduleSecondView.inAddScheduleSecondView.timeRequireTextField {
            return true
        } else {
            textFieldTapped(textField)
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let trimmedText = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let text = trimmedText, !text.isEmpty {
            viewModel.datePlace.value = text
            print(text)
        } else {
            viewModel.datePlace.value = ""
            print("공란")
        }
    }
    
}


// MARK: - UICollectionViewDelegate Methods

extension AddScheduleSecondViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }
    
}


// MARK: - UICollectionViewDataSource Methods

extension AddScheduleSecondViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.addPlaceCollectionViewDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == addScheduleSecondView.addPlaceCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AddSecondViewCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? AddSecondViewCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configure(model: viewModel.addPlaceCollectionViewDataSource[indexPath.item])
            cell.updateEditMode(flag: viewModel.isEditMode)
            cell.moveAbleButton.removeTarget(nil, action: nil, for: .allEvents)
            if viewModel.isEditMode {
                cell.moveAbleButton.addTarget(self, action: #selector(removeCell(sender:)), for: .touchUpInside)
            } else {
                cell.moveAbleButton.addTarget(self, action: #selector(moveCell(sender:)), for: .touchUpInside)
            }
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
}


// MARK: - UICollectionViewDropDelegate Methods

extension AddScheduleSecondViewController: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        if collectionView == addScheduleSecondView.addPlaceCollectionView {
            var destinationIndexPath: IndexPath
            if let indexPath = coordinator.destinationIndexPath {
                destinationIndexPath = indexPath
            } else {
                let row = collectionView.numberOfItems(inSection: 0)
                destinationIndexPath = IndexPath(item: row - 1, section: 0)
            }
            
            if coordinator.proposal.operation == .move {
                reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView == addScheduleSecondView.addPlaceCollectionView {
            if collectionView.hasActiveDrag {
                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        if collectionView == addScheduleSecondView.addPlaceCollectionView {
            if let item = coordinator.items.first, let sourceIndexPath = item.sourceIndexPath {
                collectionView.performBatchUpdates({
                    let temp = viewModel.addPlaceCollectionViewDataSource[sourceIndexPath.item]
                    viewModel.addPlaceCollectionViewDataSource.remove(at: sourceIndexPath.item)
                    viewModel.addPlaceCollectionViewDataSource.insert(temp, at: destinationIndexPath.item)
                    collectionView.deleteItems(at: [sourceIndexPath])
                    collectionView.insertItems(at: [destinationIndexPath])
                }) { done in
                    //
                }
                coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
            }
//            viewModel.updatePlaceCollectionView()
        }
    }
    
}


// MARK: - UICollectionViewDragDelegate Method

extension AddScheduleSecondViewController: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return []
    }
    
}


// MARK: - DRCustomAlertDelegate Method

extension AddScheduleSecondViewController: DRCustomAlertDelegate {
    
    func exit() {
        addScheduleSecondView.nextBtn.isUserInteractionEnabled = true
        goBackOriginVCForAddSchedule()
    }
    
}

