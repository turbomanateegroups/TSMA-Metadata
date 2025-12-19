# Sellability Verification

This document provides verification that the TSMA token is fully sellable and does not contain honeypot mechanisms.

---
## Contract Information

- **Token Name:** TSMA  
- **Network:** BNB Smart Chain (BEP20)  
- **Contract Address:**  
  `0xFc972BF3EAd686d8195bcc9B780b1006c0c68F2c`
---
## Sellability Confirmation

TSMA tokens are fully sellable via PancakeSwap.

Successful sell transactions have already been executed on-chain, confirming that:
- No sell restrictions exist
- No honeypot logic is present
- No conditional transfer blocking is implemented

Sell operations are permissionless and follow standard BEP20 behavior.
---
## Technical Notes

- No blacklist or whitelist logic is used
- No owner-controlled transfer limitations exist
- No hidden conditions based on sender, receiver, or transaction amount

The contract allows unrestricted buy and sell operations.
---
## Evidence

On-chain sell transactions can be independently verified via BscScan and PancakeSwap records.

Specific transaction hashes can be provided upon request.
