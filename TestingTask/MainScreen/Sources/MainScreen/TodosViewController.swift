//
//  TodosViewController.swift
//  MainView
//
//  Created by Asqarov Diyorjon on 01/03/25.
//

import UIKit
import SnapKit

public class TodosViewController: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    private let viewModel: TodosViewModel
    
    // MARK: - Initializer
    public init(viewModel: TodosViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupBindings()
        viewModel.loadTodos()
    }
    
    // MARK: - UI Setup
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Todos"

        searchBar.delegate = self
        searchBar.placeholder = "Search Todos or Users"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TodoCell.self, forCellReuseIdentifier: "TodoCell")
        tableView.keyboardDismissMode = .onDrag
        tableView.estimatedRowHeight = 100 
        tableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        setupKeyboardDismissGesture()
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Bindings
    private func setupBindings() {
        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Keyboard Handling
    private func setupKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension TodosViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredTodosWithUser.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        let todoWithUser = viewModel.filteredTodosWithUser[indexPath.row]
        cell.configure(with: todoWithUser)
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.openDetailView(indexPath)
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            viewModel.loadMoreTodos()
        }
    }
}

// MARK: - UISearchBarDelegate
extension TodosViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchTodos(query: searchText)
    }
}
