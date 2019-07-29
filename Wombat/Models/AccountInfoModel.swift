
import Foundation
import ObjectMapper

class AccountInfoModel: Mappable {
    
    var accountName : String?
    var coreLiquidBalance : String?
    var netWeight : String?
    var cpuWeight : String?
    var ramBytes : Double?
    var ramQuota : Double?
    var netLimitUsed : Double?
    var netLimitMax : Double?
    var cpuLimitUsed : Double?
    var cpuLimitMax : Double?
  
    init() {
        
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        accountName <- map["account_name"]
        coreLiquidBalance <- map["core_liquid_balance"]
        netWeight <- map["total_resources.net_weight"]
        cpuWeight <- map["total_resources.cpu_weight"]
        ramBytes <- map["total_resources.ram_bytes"]
        ramQuota <- map["ram_quota"]
        netLimitUsed <- map["net_limit.used"]
        netLimitMax <- map["net_limit.max"]
        cpuLimitUsed <- map["cpu_limit.used"]
        cpuLimitMax <- map["cpu_limit.max"]
    }
}
