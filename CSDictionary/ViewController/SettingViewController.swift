import UIKit

final class SettingViewController: UIViewController {
    private lazy var itemActions: [SettingOption: () -> Void] = [
        .contactDeveloper: {
            if let url = URL(string: "https://forms.gle/AeAvBSB5CdBKKJ9S9") {
                UIApplication.shared.open(url)
            }
        },
        .addCSKeyword: {
            if let url = URL(string: "https://forms.gle/ULz1fyu6DhmFxyB1A") {
                UIApplication.shared.open(url)
            }
        },
        .leaveReview: {
            if let url = URL(string: "itms-apps://itunes.apple.com/app/6480402361") {
                UIApplication.shared.open(url)
            }
        },
        .clearImageCache: {
            let alert = ConfirmManager.makeAlert(title: "캐시 지우기", message: "모든 캐시를 지우시겠습니까?") { [weak self] in
                ImageService.clearCache()
                self?.settingView.tableView.reloadData()
            }
            self.present(alert, animated: true)
        }
    ]
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
        
        AnalyticsManager.logEvent("setting_viewed")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.topItem?.title = "환경설정"
        navigationController?.navigationBar.topItem?.searchController = nil
        settingView.tableView.reloadData()
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
        if viewModel.option(at: indexPath) == .displayMode || viewModel.option(at: indexPath) == .textSize{
            return 90
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = viewModel.option(at: indexPath)
        if option == .displayMode {
            let cell = tableView.dequeueReusableCell(withIdentifier: DisplayModeCell.identifier, for: indexPath) as! DisplayModeCell
            cell.delegate = self
            cell.setFont()
            return cell
        }
        else if option == .textSize {
            let cell = tableView.dequeueReusableCell(withIdentifier: DynamicFontCell.identifier, for: indexPath) as! DynamicFontCell
            cell.delegate = self
            cell.setFont()
            return cell
        }
        else if option == .clearImageCache {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as! SettingCell
            cell.configure(option: option, description: "\(ImageService.formatBytes(ImageService.cacheSize()))")
            cell.setFont()
            cell.accessoryType = .none
            return cell
        }
        else if option == .notificationSetting {
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.identifier, for: indexPath) as! NotificationCell
            cell.configure(option: option)
            cell.setFont()
            cell.delegate = self
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as! SettingCell
            cell.configure(option: option)
            cell.setFont()
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        header?.textLabel?.text = viewModel.sectionTitle(at: section)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = viewModel.option(at: indexPath)
        itemActions[option]?()
        
        AnalyticsManager.logEvent("setting_option_clicked", parameters: ["option": option.title])
    }
}

extension SettingViewController: DisplayModeCellDelegate, DynamicFontCellDelegate, NotificationCellDelegate {
    func didChangeFontSize() {
        AnalyticsManager.logEvent("font_size_changed")
        settingView.tableView.reloadData()
    }
    
    func didChangeDisplayMode(to mode: UIUserInterfaceStyle) {
        AnalyticsManager.logEvent("display_mode_changed")
        DisplayManager.saveDisplayModeChoice(mode: mode)
        DisplayManager.setDisplayMode(mode: mode)
    }
    
    func notiClicked() {
        AnalyticsManager.logEvent("notification_setting_clicked")
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
}
