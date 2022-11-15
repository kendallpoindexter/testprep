import UIKit
import SDWebImage

class EmployeeListViewController: UIViewController {
    enum Section {
        case main
    }
    
    @IBOutlet weak var employeeListTableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var dataSource: UITableViewDiffableDataSource<Section, Employee>?
    private let viewModel = EmployeeListViewModel()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeeListTableView.delegate = self
        viewModel.delegate = self
        startActivityIndicator()
        configureDataSource()
        viewModel.fetchEmployeeDirectory()
        employeeListTableView.refreshControl = refreshControl
        refreshControl.addTarget(viewModel,
                                 action: #selector(viewModel.fetchEmployeeDirectory),
                                 for: .valueChanged)
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: employeeListTableView, cellProvider: { tableView, indexPath, employee in
            let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath) as! EmployeeTableViewCell
            cell.configureCell(employee: employee)
            return cell
        })
    }
    
    private func updateUI() {
        if viewModel.employeeList.isEmpty {
            employeeListTableView.setEmptyState(with: "The employee directory is empty")
        } else {
            employeeListTableView.restore()
            
            var snapshot = NSDiffableDataSourceSnapshot<Section, Employee>()
            snapshot.appendSections([.main])
            snapshot.appendItems(viewModel.employeeList, toSection: .main)
            
            dataSource?.apply(snapshot)
        }
    }
    
    private func startActivityIndicator() {
        activityIndicator.startAnimating()
        loadingView.isHidden = false
        employeeListTableView.isHidden = true
    }
    
    private func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
        employeeListTableView.isHidden = false
    }
}

// MARK: - ViewModel Delegate Methods
extension EmployeeListViewController: EmployeeListViewModelDelegate {
    func didFetchEmployeeDirectory() {
        refreshControl.endRefreshing()
        stopActivityIndicator()
        updateUI()
    }
    
    func didFailToFetchEmployeeDirectory(error: Error) {
        refreshControl.endRefreshing()
        stopActivityIndicator()
        handleErrorAlert(with: error as! NetworkErrors)
    }
}

// MARK: - TableView Delegate Methods
extension EmployeeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        employeeListTableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Error handling
extension EmployeeListViewController {
    private func handleErrorAlert(with error: NetworkErrors) {
        switch error {
        case .failedToDecodeData, .invalidURL:
            presentErrorAlert(with: "We are working on the issue. Please comeback soon.", action: nil)
        case .invalidHttpResponse, .networkSessionFailed:
            let action = UIAlertAction(title: "Retry", style: .default, handler: { [weak self] _ in
                self?.viewModel.fetchEmployeeDirectory()
                self?.startActivityIndicator()
            })
            
            presentErrorAlert(with: "Please check your connection and retry", action: action)
        }
    }
    
    private func presentErrorAlert(with message: String, action: UIAlertAction?) {
        let alert = createErrorAlert(with: message)
        
        guard let action = action else {
            present(alert, animated: true)
            return
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func createErrorAlert(with message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Opps! An Error Occured", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { [weak self] _ in
            self?.employeeListTableView.setEmptyState(with: "We are experiencing an outage. Don't worry we will have things back up and running soon! \nPlease check your connection and try pull to refresh.")
        }))
        
        return alert
    }
}
