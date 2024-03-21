import UIKit

final class CSListViewController: UIViewController {
    private let viewModel = CSListViewModel()
    private var listView: CSListView {
        view as! CSListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listViewConfigure()
    }
    
    override func loadView() {
        view = CSListView(viewModel: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.topItem?.title = "CS 리스트"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .tabbar
        appearance.shadowColor = .separator
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        listView.tableView.reloadData()
        listView.setSearchController(delegate: self, navigationController: navigationController!)
    }
    
    private func listViewConfigure() {
        listView.setDelegate(delegate: self)
        listView.setDataSource(dataSource: self)
    }
}

extension CSListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemsCount(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = viewModel.item(at: indexPath)
        var content = cell.defaultContentConfiguration()
        cell.selectionStyle = .none
        content.text = item.name
        content.textProperties.font = FontManager.getSelectedFont()
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = UIColor(resource: .background)
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        header?.textLabel?.text = viewModel.sections[section]
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.item(at: indexPath)
        let detailVC = CSDetailViewController(item: item)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


extension CSListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        viewModel.isSearching = !searchText.isEmpty
        viewModel.filterItems(for: searchText)
        listView.tableView.reloadData()
    }
}
