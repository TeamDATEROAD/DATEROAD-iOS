//
//  SearchPlaceViewController.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 3/31/25.
//

import UIKit

final class SearchPlaceViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    let dimmedView: DRDimmedView = DRDimmedView()
    
    let searchPlaceView: SearchPlaceView = SearchPlaceView()
    
    
    // MARK: - UI Properties

    private var viewModel: SearchPlaceViewModel
    
    
    // MARK: - Life Cycles
    
    init(_ viewModel: SearchPlaceViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        bindViewModel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        initialSearchPlaceBottomSheet()
    }
    
    override func setHierarchy() {
        self.view.addSubviews(dimmedView, searchPlaceView)
    }
    
    override func setLayout() {
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchPlaceView.snp.makeConstraints {
            $0.height.equalTo(ScreenUtils.height / 812 * 642)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }

    override func setStyle() {
        self.view.backgroundColor = UIColor.clear
    }
}


// MARK: - Methods

private extension SearchPlaceViewController {

    func setDelegate() {
        dimmedView.delegate = self
        searchPlaceView.delegate = self
        searchPlaceView.placeTableView.do {
            $0.delegate = self
            $0.dataSource = self
        }
    }

    func bindViewModel() {
        // 입력된 키워드
        viewModel.inputPlace.bind { [weak self] input in
            guard let input else { return }
            
            Task {
                await self?.viewModel.getSearchPlace()
            }
        }
        
        // 키워드 검색 결과를 담은 데이터
        viewModel.filteredSearchPlaceData.bind { [weak self] filteredData in
            guard let filteredData,
                  let initial = self?.viewModel.initialBottomSheet.value
            else { return }
            
            let isEmpty = filteredData.count == 0
            if !initial {                                                     // 처음 시트가 열린 게 아닌 경우 -> 맨 처음 띄웠을 때만 엠티뷰 생략 위함
                self?.searchPlaceView.updatePlaceView(isEmpty)
            }
            self?.searchPlaceView.placeTableView.reloadData()                 // 데이터가 필터링 되고, 필터링된 데이터가 존재하는 경우 하단 장소 컬뷰 reload
            self?.viewModel.initialBottomSheet.value = false
        }
    }
    
    // clear 버튼 탭 or 바텀 시트 x 버튼 탭 시 데이터 및 UI 초기화 메소드
    func initialSearchPlaceBottomSheet() {
        searchPlaceView.searchPlaceTextField.text = ""                        // 텍스트 필드 텍스트 초기화
        viewModel.inputPlace.value = ""                                       // 텍스트 필드 인풋 바인딩 변수 초기화
        viewModel.initialBottomSheet.value = true                             // 엠티뷰 띄우지 않도록 초기화
        viewModel.filteredSearchPlaceData.value = []                          // 데이터 초기화
        searchPlaceView.updatePlaceView(false)                                // 엠티뷰 말고 빈 테이블 뷰 뜨도록 초기화
        searchPlaceView.placeTableView.reloadData()
    }
    
}


// MARK: - DimmedView Delegates

extension SearchPlaceViewController: DimmedViewDelegate {
    
    func didTapDimmedView() {
        self.view.endEditing(true)
        self.dismissBottomSheet(searchPlaceView, dimmedView)
    }
    
}


// MARK: - SearchPlaceView Delegates

extension SearchPlaceViewController: SearchPlaceDelegate {
    
    func didTapCloseButton() {
        self.view.endEditing(true)
        self.dismissBottomSheet(searchPlaceView, dimmedView)
    }
    
    func didTapClearButton() {
        initialSearchPlaceBottomSheet()
    }
    
    func editSearchPlaceTextField() {
        viewModel.inputPlace.value = searchPlaceView.searchPlaceTextField.text
        print("입력 장소 : \(String(describing: viewModel.inputPlace.value))")
    }
    
}


// MARK: - PlaceTableView Delegates & DataSource

extension SearchPlaceViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let filteredSearchPlaceData = viewModel.filteredSearchPlaceData.value else { return 0 }
        return filteredSearchPlaceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchPlaceTableViewCell.cellIdentifier, for: indexPath) as? SearchPlaceTableViewCell
        else { return UITableViewCell() }
        
        guard let filteredSearchPlaceData = viewModel.filteredSearchPlaceData.value else { return UITableViewCell() }
        cell.bindData(filteredSearchPlaceData[indexPath.item])
        
        return cell
    }
    
}

extension SearchPlaceViewController: UITableViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)  // 테이블뷰 스크롤 시 키보드 내려가도록 하기 위함
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: - 코스 및 일정 등록 뷰와 연결
        guard let searchPlaceData = viewModel.searchPlaceData.value else { return }
        print("선택 장소 : \(searchPlaceData[indexPath.item].name) & \(searchPlaceData[indexPath.item].address)")
    }
    
}

