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
        .displayMode: {},
        .textSize: {},
        .leaveReview: {
            if let url = URL(string: "itms-apps://itunes.apple.com/app/1592949834") {
                UIApplication.shared.open(url)
            }
        },
        .notificationSetting: {},
        .clearImageCache: {
            let alert = ConfirmManager.makeAlert(title: "캐시 지우기", message: "모든 캐시를 지우시겠습니까?") { [weak self] in
                ImageService.clearCache()
                self?.settingView.tableView.reloadData()
            }
            self.present(alert, animated: true)
        },
        .removeAds: {}
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
        if viewModel.option(at: indexPath) == .displayMode {
            return 90
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = viewModel.option(at: indexPath)
        if option == .displayMode {
            let cell = tableView.dequeueReusableCell(withIdentifier: DisplayModeCell.identifier, for: indexPath) as! DisplayModeCell
            cell.delegate = self
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as! SettingCell
        if option == .clearImageCache {
            cell.configure(option: option, description: "\(ImageService.formatBytes(ImageService.cacheSize()))")
            return cell
        }
        cell.configure(option: option)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        header?.textLabel?.text = viewModel.sectionTitle(at: section)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = viewModel.option(at: indexPath)
        itemActions[option]?()
    }
}

extension SettingViewController: DisplayModeCellDelegate {
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
}
