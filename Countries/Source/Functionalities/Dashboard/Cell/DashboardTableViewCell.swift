//
//  DashboardTableViewCell.swift
//  Countries
//
//  Created by Konrad Belzowski on 01/12/2020.
//

import UIKit

public class DashboardTableViewCell: UITableViewCell {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    
    public var viewModel: DashboardTableViewCellViewModel? {
        didSet {
            setupView()
        }
    }
    
    //
    // MARK: - Methods
    //
    
    private func setupView() {
        nameLabel.text = viewModel?.countryModel.name
        regionLabel.text = viewModel?.countryModel.region
        capitalLabel.text = viewModel?.countryModel.capital
    }
}
