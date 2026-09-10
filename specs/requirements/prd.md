# rl1 — PRD

## Problem Statement

Employees who pay for business expenses out of pocket today have no consistent  
way to request reimbursement: claims travel as emails, spreadsheets or paper  
receipts, managers approve them informally, and finance has to manually  
reassemble everything that was approved before it can be paid out through  
payroll. This is slow, easy to lose track of, and gives finance no reliable,

auditable record of what was approved and what still needs to be paid.

## Solution

A system where employees submit expense claims online, their manager reviews
and approves or rejects each one, and finance can pull together every approved
claim into a single export that feeds the payroll run — replacing the
email/spreadsheet shuffle with one tracked flow from submission to payout.

## Actors

- **Employee** — submits expense claims, tracks their status, and can edit and
resubmit a claim their manager rejected.
- **Manager** — reviews the expense claims submitted by their direct reports
and approves or rejects each one.
- **Finance** — reviews approved claims across the organization and exports
them for payroll processing.

## User Stories

1. As an employee, I want to submit an expense claim with an amount, category,
date, and receipt, so that I can request reimbursement for a business
expense.
2. As an employee, I want to see the status of every claim I've submitted, so
that I know whether it's pending, approved, or rejected.
3. As an employee, I want to edit a rejected claim and resubmit it, so that I
can correct whatever the manager flagged without starting over.
4. As a manager, I want to see the pending expense claims submitted by my
direct reports, so that I know what's waiting on my review.
5. As a manager, I want to approve or reject a claim, so that valid expenses
move toward payment and invalid ones go back to the employee.
6. As finance, I want to see every approved claim that hasn't been exported
yet, so that I know what's ready to go to payroll.
7. As finance, I want to export a batch of approved claims to a downloadable
file, so that I can upload it into our payroll system.
8. As finance, I want claims to be marked as exported once they're in a
payroll batch, so that the same claim is never paid out twice.

## Product Decisions

- Employees sign in via SSO through Thunder, the platform identity provider
(organization default).
- Approval is single-level: each claim goes to the employee's assigned direct
manager only; there is no higher-level or amount-based escalation.
- A rejected claim is not final — the employee can edit and resubmit the same
claim, which sends it back through approval.
- Finance exports approved claims as a downloadable file (e.g. CSV) for manual
upload into whatever payroll system the organization uses; there is no live
integration with a specific payroll vendor.
- Every employee has exactly one assigned manager, maintained in an
admin-managed employee directory; claim routing reads this assignment.
- Expense categories come from a predefined list (e.g. Travel, Meals, Lodging,
Other) that finance maintains, rather than free text.
- A receipt attachment is required on every claim submission.
- Employees and managers receive an email notification when a claim's status
changes (submitted, approved, rejected).
- All claims are recorded in a single organizational currency; multi-currency
claims are not supported. *assumed*

## Out of Scope

- Multi-level or amount-based approval escalation.
- Direct API integration with a named payroll vendor.
- Multi-currency expense claims.
- Mileage or per-diem calculators — claims are entered as a flat amount.
- Reassigning a claim to a different manager after submission.

## Open Questions

1. What columns/format does the payroll export file need to match the
organization's actual payroll system's import requirements?
2. Is there a per-category spending limit or policy (e.g. a cap on meal
expenses) that should block or flag a claim at submission time?

## Further Notes

None.