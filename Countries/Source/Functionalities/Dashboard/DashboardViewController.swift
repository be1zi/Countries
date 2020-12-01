//
//  DashboardViewController.swift
//  Countries
//
//  Created by Konrad Belzowski on 30/11/2020.
//

import UIKit
import RxSwift

public class DashboardViewController: UIViewController {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControll = UIRefreshControl()
    private let viewModel = DashboardViewModel()
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Lifecycle
    //
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        setupRx()
    }
    
    //
    // MARK: - Methods
    //
    
    private func configureTableView() {
        
        let cellName = viewModel.cellName
        let nibName = UINib(nibName: cellName, bundle: nil)
        
        tableView.register(nibName, forCellReuseIdentifier: cellName)
        tableView.refreshControl = refreshControll
    }
    
    //
    // MARK: - Actions
    //
    
    private func setupRx() {
        
        viewModel.countriesSubject.subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.isUpdating.subscribe(onNext: { [weak self] isUpdating in
            if !isUpdating {
                self?.refreshControll.endRefreshing()
            }
        }).disposed(by: disposeBag)
        
        refreshControll.rx.controlEvent(.valueChanged).subscribe(onNext: { [weak self] _ in
            self?.viewModel.getAllCountries()
        }).disposed(by: disposeBag)
    }
}

extension DashboardViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countriesSubject.value.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellName, for: indexPath) as? DashboardTableViewCell else {
            return UITableViewCell()
        }
        
        if viewModel.countriesSubject.value.indices.contains(indexPath.row) {
            let model = viewModel.countriesSubject.value[indexPath.row]
            cell.viewModel = DashboardTableViewCellViewModel(model: model)
        }
        
        return cell
    }
}
