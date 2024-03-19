import UIKit

final class SettingViewController: UIViewController {
    private var settingView: SettingView {
        view as! SettingView
    }
    private let viewModel = SettingViewModel()
    
    override func loadView() {
        view = SettingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingView.setDelegate(delegate: self)
        settingView.setDataSource(dataSource: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.topItem?.title = "환경설정"
        navigationController?.navigationBar.topItem?.searchController = nil
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemsCount(in: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.item(at: indexPath) == "화면 모드" {
            return 90
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.item(at: indexPath) == "화면 모드" {
            let cell = tableView.dequeueReusableCell(withIdentifier: DisplayModeCell.identifier, for: indexPath) as! DisplayModeCell
            cell.backgroundColor = UIColor(resource: .settingBackground)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = viewModel.item(at: indexPath)
        var content = cell.defaultContentConfiguration()
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = UIColor(resource: .settingBackground)
        content.image = UIImage(systemName: viewModel.icon(at: indexPath), withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .regular))
        content.imageProperties.tintColor = UIColor(resource: .appPrimary)
        content.text = item
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
        print(item)
    }
}
