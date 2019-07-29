
import Foundation

class HomePresenter {
    private var repository: HomeRepository?
    private weak var delegate: HomeDelegate?
    
    var accountInfoModel = AccountInfoModel()
    
    init(repository: HomeRepository, delegate: HomeDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
  
    func getAccountInfo(with username: String) {
      
        repository?.getAccount(with: username, completion: { [weak self] (success, response) in
            if success, let user = response as? AccountInfoModel{
              
                self?.accountInfoModel = user
                self?.delegate?.finishPerformingHomeWithSuccess()
            } else {
                if let error = response as? String {
                    self?.delegate?.finishPerformingHomeWithError(error: error)
                }
            }
        })
    }
}
