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
    
    private func settingAction(option: SettingOption) {
        switch option {
        case .contactDeveloper:
            if let url = URL(string: "https://forms.gle/AeAvBSB5CdBKKJ9S9") {
                UIApplication.shared.open(url)
            }
        case .addCSKeyword:
            if let url = URL(string: "https://forms.gle/ULz1fyu6DhmFxyB1A") {
                UIApplication.shared.open(url)
            }
        case .displayMode:
            break
        case .textSize:
            break
        case .leaveReview:
            if let url = URL(string: "itms-apps://itunes.apple.com/app/1592949834") {
                UIApplication.shared.open(url)
            }
            break
        case .notificationSetting:
            break
        case .clearImageCache:
            break
        case .removeAds:
            break
        }
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource, DisplayModeCellDelegate {
    func didChangeDisplayMode(to mode: UIUserInterfaceStyle) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
        for windowScene in windowScenes {
            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = mode
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemsCount(in: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.option(at: indexPath) == .displayMode {
            return 90
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingOption = viewModel.option(at: indexPath)
        if settingOption == .displayMode {
            let cell = tableView.dequeueReusableCell(withIdentifier: DisplayModeCell.identifier, for: indexPath) as! DisplayModeCell
            cell.backgroundColor = UIColor(resource: .settingBackground)
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = viewModel.item(at: indexPath)
        var content = cell.defaultContentConfiguration()
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(resource: .settingBackground)
        content.image = UIImage(systemName: viewModel.icon(at: indexPath), withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .regular))
        content.imageProperties.tintColor = UIColor(resource: .appPrimary)
        content.text = item.title
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        header?.textLabel?.text = viewModel.sectionTitle(at: section)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = viewModel.option(at: indexPath)
        settingAction(option: option)
    }
}
