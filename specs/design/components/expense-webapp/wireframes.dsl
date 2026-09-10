screen MyClaims "Employee's own submitted claims and their status"
  navbar "Expense Tracker | My Claims -> MyClaims | Sign out"
  row
    heading "My Claims"
    right
    button "New Claim" primary -> NewClaim
  table "Date | Category | Amount | Status" -> ClaimDetail
    row "2026-09-01 | Travel | 120.00 | Submitted"
    row "2026-08-20 | Meals | 34.50 | Approved"
    row "2026-08-15 | Lodging | 210.00 | Rejected"

screen NewClaim "Employee submits a new expense claim"
  navbar "Expense Tracker | My Claims -> MyClaims | Sign out"
  heading "New Expense Claim"
  input "Amount"
  select "Category"
  input "Expense date"
  input "Receipt (upload)"
  row
    right
    button "Cancel" -> MyClaims
    button "Submit" primary -> MyClaims

screen ClaimDetail "View or edit a single claim, resubmit if rejected"
  navbar "Expense Tracker | My Claims -> MyClaims | Sign out"
  heading "Claim Detail"
  badge "Rejected" danger
  text "Amount: 210.00"
  text "Category: Lodging"
  text "Expense date: 2026-08-15"
  text "Receipt: receipt-0093.pdf"
  text "Manager comment: Missing itemized bill"
  row
    right
    button "Edit & Resubmit" primary -> NewClaim

screen PendingApprovals "Manager's queue of claims awaiting a decision"
  navbar "Expense Tracker | Pending Approvals -> PendingApprovals | Sign out"
  heading "Pending Approvals"
  table "Employee | Date | Category | Amount" -> ClaimReview
    row "J. Alvarez | 2026-09-01 | Travel | 120.00"
    row "S. Ito | 2026-08-30 | Meals | 45.00"

screen ClaimReview "Manager reviews one claim and decides"
  navbar "Expense Tracker | Pending Approvals -> PendingApprovals | Sign out"
  heading "Review Claim"
  text "Employee: J. Alvarez"
  text "Amount: 120.00"
  text "Category: Travel"
  text "Expense date: 2026-09-01"
  image "Receipt preview" 300x200
  textarea "Comment (optional)"
  row
    right
    button "Reject" danger -> PendingApprovals
    button "Approve" primary -> PendingApprovals

screen ApprovedClaims "Finance's list of approved, not-yet-exported claims"
  navbar "Expense Tracker | Approved Claims -> ApprovedClaims | Export History -> ExportHistory | Sign out"
  row
    heading "Approved Claims"
    right
    button "Export Selected" primary -> ExportHistory
  table "Employee | Date | Category | Amount"
    row "J. Alvarez | 2026-09-01 | Travel | 120.00"
    row "S. Ito | 2026-08-30 | Meals | 45.00"

screen ExportHistory "Finance's record of past payroll export batches"
  navbar "Expense Tracker | Approved Claims -> ApprovedClaims | Export History -> ExportHistory | Sign out"
  heading "Export History"
  table "Date | Claims | Exported By | File"
    row "2026-09-05 | 12 | Finance User | export-2026-09-05.csv"
    row "2026-08-22 | 9 | Finance User | export-2026-08-22.csv"

flow "Submit and track claims"
  role "Employee"
  description "An employee submits a claim and tracks it through approval, editing it if rejected"
  MyClaims
  NewClaim
  ClaimDetail

flow "Review pending claims"
  role "Manager"
  description "A manager reviews claims from direct reports and approves or rejects each"
  PendingApprovals
  ClaimReview

flow "Export approved claims"
  role "Finance"
  description "Finance reviews approved claims and exports a batch for payroll upload"
  ApprovedClaims
  ExportHistory
