// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//  Updated by Avinash on 11/03/23.

import Foundation

// MARK: - DashboardBriefModel
struct DashboardBriefModel: Codable {
    let success: String
    let data: [DashboardBrief]
    let message: String
}

// MARK: - Datum
struct DashboardBrief: Codable {
    let todayDeliveriesCount, pendingApprovalsCount: Int
    let spendingsConsolidated: [SpendingsConsolidated]
    
    enum CodingKeys: String, CodingKey {
        case todayDeliveriesCount = "today_deliveries_count"
        case pendingApprovalsCount = "pending_approvals_count"
        case spendingsConsolidated = "spendings_consolidated"
    }
}


