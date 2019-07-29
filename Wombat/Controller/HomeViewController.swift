
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var netProgressView: UIProgressView!
    @IBOutlet weak var cpuProgressView: UIProgressView!
    @IBOutlet weak var ramProgressView: UIProgressView!
    @IBOutlet weak var netStakedLabel: UILabel!
    @IBOutlet weak var cpuStakedLabel: UILabel!
    @IBOutlet weak var netTotalKBLabel: UILabel!
    @IBOutlet weak var cpuTotalMSLabel: UILabel!
    @IBOutlet weak var ramTotalKBLabel: UILabel!
    @IBOutlet weak var netPercentageLabel: UILabel!
    @IBOutlet weak var cpuPercentageLabel: UILabel!
    @IBOutlet weak var ramPercentageLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    lazy var presenter = HomePresenter(repository: HomeRepository(), delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        additonalSetup()
        
    }
    
    private func additonalSetup() {
        presenter.getAccountInfo(with: "xoxoxoxo2354")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (image: UIImage(named: "add")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(addClicked))
    }
    
    @objc func addClicked() {
        let alertController: UIAlertController = UIAlertController(title: "", message: "Add Account Number", preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
        }
        alertController.addAction(cancelAction)
        let nextAction: UIAlertAction = UIAlertAction(title: "Search", style: .default) { action -> Void in
            let text = (alertController.textFields?.first)?.text
            self.presenter.getAccountInfo(with: text ?? "")
        }
        alertController.addAction(nextAction)
        alertController.addTextField { (textField) -> Void in
        }
        present(alertController, animated: true, completion: nil)
    }
}

extension HomeViewController: HomeDelegate{
    
    func finishPerformingHomeWithSuccess() {
        
        self.title = presenter.accountInfoModel.accountName
        let strBalance = presenter.accountInfoModel.coreLiquidBalance ?? "0"
        var indexDot : Int  = 0
        if let index = strBalance.firstIndex(of: ".") {
            indexDot = strBalance.distance(from: strBalance.startIndex, to: index)
        }
        let font:UIFont? = UIFont(name: "Helvetica", size:25)
        let fontSuper:UIFont? = UIFont(name: "Helvetica", size:18)
        let attString:NSMutableAttributedString = NSMutableAttributedString(string:strBalance, attributes: [.font:font!])
        
        attString.setAttributes([.font:fontSuper!,.baselineOffset:0], range: NSRange(location:(indexDot),length:((presenter.accountInfoModel.coreLiquidBalance?.count ?? 0) - indexDot)))
        
        balanceLabel.attributedText = attString
        netStakedLabel.text = presenter.accountInfoModel.netWeight
        cpuStakedLabel.text = presenter.accountInfoModel.cpuWeight
        
        let netpercentage : Double = (presenter.accountInfoModel.netLimitUsed ?? 0) / (presenter.accountInfoModel.netLimitMax ?? 0) * 100
        
        netPercentageLabel.text = String(format: "%.2f%", netpercentage) + "%"
        
        let cpupercentage : Double = (presenter.accountInfoModel.cpuLimitUsed ?? 0) / (presenter.accountInfoModel.cpuLimitMax ?? 0) * 100
        cpuPercentageLabel.text = String(format: "%.2f%", cpupercentage) + "%"
        
        let rampercentage : Double = (presenter.accountInfoModel.ramBytes ?? 0) / (presenter.accountInfoModel.ramQuota ?? 0) * 100
        ramPercentageLabel.text = String(format: "%.2f%", rampercentage) + "%"
        
        netTotalKBLabel.text = "(\("\(((String((presenter.accountInfoModel.netLimitUsed ?? 0) ) + "/" + (String(presenter.accountInfoModel.netLimitMax ?? 0)))))"))"
        
        cpuTotalMSLabel.text =  "(\("\(((String((presenter.accountInfoModel.cpuLimitUsed ?? 0) ) + "/" + (String(presenter.accountInfoModel.cpuLimitMax ?? 0)))))"))"
        
        ramTotalKBLabel.text =   "(\("\(((String((presenter.accountInfoModel.ramBytes ?? 0) ) + "/" + (String(presenter.accountInfoModel.ramQuota ?? 0)))))"))"
        
        netProgressView.setProgress(Float((presenter.accountInfoModel.netLimitUsed ?? 0) / (presenter.accountInfoModel.netLimitMax ?? 0)), animated: true)
        
        cpuProgressView.setProgress(Float((presenter.accountInfoModel.cpuLimitUsed ?? 0) / (presenter.accountInfoModel.cpuLimitMax ?? 0)), animated: true)
        
        ramProgressView.setProgress(Float((presenter.accountInfoModel.ramBytes ?? 0) / (presenter.accountInfoModel.ramQuota ?? 0)), animated: true)
    }
    
    func finishPerformingHomeWithError(error: String) {
        showAlert(title: "Error", message: error, actionTitles: ["Ok"], actions:[{action1 in
            }, nil])
    }
}
