//
//  TodoDetailsViewController.swift
//  MainScreen
//
//  Created by Asqarov Diyorjon on 03/03/25.
//


import UIKit
import SnapKit
import Module

public class TodoDetailsViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let viewModel: TodoDetailsViewModel

    public init(viewModel: TodoDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Todo Details"

        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailCell")
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension TodoDetailsViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.detailSections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.detailSections[section].count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        let detailItem = viewModel.detailSections[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        cell.textLabel?.text = "\(detailItem.title): \(detailItem.value)"
        cell.textLabel?.numberOfLines = 0
        return cell
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Todo Information"
        case 1: return "User Details"
        case 2: return "Address"
        case 3: return "Geolocation"
        default: return nil
        }
    }
}
