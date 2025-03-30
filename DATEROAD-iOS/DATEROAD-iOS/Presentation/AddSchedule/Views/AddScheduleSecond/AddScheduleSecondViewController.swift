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
        broughtDataHandling()
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
            $0.horizontalEdges.equalToSuperview().inset(ScreenUtils.width * 16/375)
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
        
        addScheduleSecondView.inAddScheduleSecondView.datePlaceTextField.delegate = self
    }
    
    func bindViewModel() {
        self.viewModel.outputIsSuccessPostData.bind { [weak self] isSuccess in
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
                self?.viewModel.inputPreparePostSchedule.value = true
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
        
        viewModel.outputEditBtnEnableState.bind { [weak self] enableState in
            guard let enableState else {return}
            self?.addScheduleSecondView.editBtnState(isAble: enableState)
        }
        
        viewModel.outputDatePlace.lazyBind { [weak self] value in
            guard let value else {return}
            self?.addScheduleSecondView.inAddScheduleSecondView.updateDatePlace(text: value)
            self?.checkAddPlaceBtnState()
        }
        
        viewModel.outputTimeRequire.lazyBind { [weak self] value in
            guard let value else {return}
            self?.addScheduleSecondView.inAddScheduleSecondView.updatetimeRequire(text: value)
            self?.checkAddPlaceBtnState()
        }
        
        viewModel.outputSuccessedAddPlcae.lazyBind { [weak self] _ in
            guard let self else {return}
            self.viewModel.inputCheckEditBtnState.value = true
            self.addScheduleSecondView.inAddScheduleSecondView.finishAddPlace()
            self.viewModel.inputValidateRegisterBtn.value = true
            self.addScheduleSecondView.addPlaceCollectionView.reloadData()
        }
        
        self.viewModel.outputIstValidateRegisterBtn.bind { [weak self] isValid in
            self?.addScheduleSecondView.changeNextBtnState(flag: isValid ?? false)
        }
    }
    
    func setAddTarget() {
        addScheduleSecondView.editButton.addTarget(self, action: #selector(toggleEditMode), for: .touchUpInside)
        
        addScheduleSecondView.inAddScheduleSecondView.addPlaceButton.addTarget(self, action: #selector(tapAddPlaceBtn), for: .touchUpInside)
        
        addScheduleSecondView.nextBtn.addTarget(self, action: #selector(didTapNextBtn), for: .touchUpInside)
        
        addScheduleSecondView.inAddScheduleSecondView.timeRequireButton.addTarget(self, action: #selector(didTapTimeRequireButton), for: .touchUpInside)
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
    
    private func broughtDataHandling() {
        viewModel.inputPrepareBroughtData.value = true
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
                                                        titleText: StringLiterals.AddCourseOrSchedule.AddCourseAlert.alertScheduelTitleLabel,
                                                        longButton: DRTextButton(title: StringLiterals.AddCourseOrSchedule.AddCourseAlert.doneButton, buttonName: .bold_purple_10))
        customAlertVC.delegate = self
        customAlertVC.modalPresentationStyle = .overFullScreen
        self.present(customAlertVC, animated: false)
    }
    
    
    // MARK: - @objc Methods
    
    /// '완료' 버튼 관련
    @objc
    func didTapNextBtn() {
        addScheduleSecondView.nextBtn.isUserInteractionEnabled = false
        viewModel.inputPreparePostSchedule.value = true
    }
    
    /// '소요시간' 관련
    @objc
    func didTapTimeRequireButton() {
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
        viewModel.inputValidateAddPlcae.value = true
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
        
        viewModel.dataSourceOfAddPlaceCollectionView.value?.remove(at: indexPath.item)
        addScheduleSecondView.addPlaceCollectionView.deleteItems(at: [indexPath])
        viewModel.inputValidateRegisterBtn.value = true
        
        //여기서 datasource가 1개 미만이면
        let dataSourceCnt = viewModel.dataSourceOfAddPlaceCollectionView.value?.count ?? 1
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
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let trimmedText = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        viewModel.inputDatePlace.value = trimmedText
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
        return viewModel.dataSourceOfAddPlaceCollectionView.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == addScheduleSecondView.addPlaceCollectionView {
            guard
                let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AddSecondViewCollectionViewCell.cellIdentifier,
                for: indexPath)
                    as? AddSecondViewCollectionViewCell,
                let model = viewModel.dataSourceOfAddPlaceCollectionView.value
            else { return UICollectionViewCell() }
            
            cell.configure(model: model[indexPath.item])
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
    
    //드래그 cell Preview
    func collectionView(_ collectionView: UICollectionView,
                        dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        print(#function)
        
        let parameters = UIDragPreviewParameters()
        parameters.visiblePath = UIBezierPath(roundedRect: collectionView.cellForItem(at: indexPath)?.bounds ?? .zero,
                                              cornerRadius: 14) // 원하는 cornerRadius 적용
        return parameters
    }
    
    //들고있던 cell을 이동시켜 cell의 index가 바뀌었을 때 동작
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        print(#function, "케케몬몬몬")
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
                guard var body = viewModel.dataSourceOfAddPlaceCollectionView.value else { return }
                
                let movedItem = body.remove(at: sourceIndexPath.item)
                body.insert(movedItem, at: destinationIndexPath.item)
                viewModel.dataSourceOfAddPlaceCollectionView.value = body
                
                collectionView.performBatchUpdates {
                    collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
                }
                
                coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
            }
        }
    }

    
}


// MARK: - UICollectionViewDragDelegate Method

extension AddScheduleSecondViewController: UICollectionViewDragDelegate {
    
    //롱핸들프래스로 cell이 들렸을 때 동작
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        print(#function)
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

