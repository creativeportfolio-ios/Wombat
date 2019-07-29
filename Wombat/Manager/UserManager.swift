
import Foundation

class UserManager {
    
    static let shared: UserManager = UserManager()
    
    func getAccountInfo(username: String, completion: @escaping CompletionBlock) {
        let accountRequest = WombatHttpRouter.postInfo(name: username)
        NetworkManager.makeRequest(accountRequest)
            .onSuccess { (response: AccountInfoModel) in
                completion(true, response)
            }
            .onFailure { error in
                completion(false,nil)
            }.onComplete { _ in
        }
    }
}
