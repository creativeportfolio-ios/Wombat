
import Foundation

struct HomeRepository {
    func getAccount(with username: String, completion: @escaping CompletionBlock){
        UserManager.shared.getAccountInfo(username: username, completion: completion)
    }
}
