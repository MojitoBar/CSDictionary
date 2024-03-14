import UIKit

final class CSListViewController: UIViewController {
    private let sections: [String] = ["자료구조", "알고리즘", "네트워크"]
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return 3
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.fetchItem(at: indexPath.row).name
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = UIColor(resource: .background)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        header?.textLabel?.text = sections[section]
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = CSDetailViewController(item: viewModel.fetchItem(at: indexPath.row))
        detailVC.title = viewModel.fetchItem(at: indexPath.row).name
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
