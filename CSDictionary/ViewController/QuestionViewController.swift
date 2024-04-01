import UIKit

final class QuestionViewController: UIViewController {
    private let viewModel = QuestionViewModel()
    private var questionView: QuestionView {
        view as! QuestionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listViewConfigure()
        
        AnalyticsManager.logEvent("question_viewed")
        fetchCSItems()
    }

    func fetchCSItems() {
        Task {
            await viewModel.fetchItems()
        }
    }
    
    override func loadView() {
        view = QuestionView(viewModel: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.topItem?.title = "문제집"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .tabbar
        appearance.shadowColor = .separator
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        questionView.tableView.reloadData()
        questionView.setSearchController(delegate: self, navigationController: navigationController!)
    }
    
    private func listViewConfigure() {
        questionView.setDelegate(delegate: self)
        questionView.setDataSource(dataSource: self)
    }
}

extension QuestionViewController: UITableViewDelegate, UITableViewDataSource {
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
        content.text = item.question
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
        AnalyticsManager.logEvent("question_list_item_selected", parameters: ["item": viewModel.item(at: indexPath).question])
        let item = viewModel.item(at: indexPath)
        let detailVC = QuestionDetailViewController(item: item)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension QuestionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        viewModel.isSearching = !searchText.isEmpty
        viewModel.filterItems(for: searchText)
        questionView.tableView.reloadData()
    }
}
