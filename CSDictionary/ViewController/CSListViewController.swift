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
    
    private func listViewConfigure() {
        listView.setDelegate(delegate: self)
        listView.setDataSource(dataSource: self)
    }
}

extension CSListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getSectionsCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let itemDictionary = viewModel.getItemDictionary()
        if let items = itemDictionary[viewModel.getSection(at: section)] {
            return items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let itemDictionary = viewModel.getItemDictionary()
        if let items = itemDictionary[viewModel.getSection(at: indexPath.section)] {
            cell.textLabel?.text = items[indexPath.row].name
        }
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = UIColor(resource: .background)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        header?.textLabel?.text = viewModel.getSection(at: section)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemDictionary = viewModel.getItemDictionary()
        if let items = itemDictionary[viewModel.getSection(at: indexPath.section)] {
            let item = items[indexPath.row]
            let detailVC = CSDetailViewController(item: item)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
