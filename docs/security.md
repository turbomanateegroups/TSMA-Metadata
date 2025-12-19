# Security Overview

This document provides a high-level security overview of the TSMA token contract deployed on BNB Smart Chain.

The purpose of this document is to assist security reviewers and ecosystem partners in understanding the contract's behavior.

---
## Contract Information

- **Token Name:** TSMA  
- **Network:** BNB Smart Chain (BEP20)  
- **Contract Address:**  
  `0xFc972BF3EAd686d8195bcc9B780b1006c0c68F2c`
---
## Security Characteristics

The TSMA contract follows a standard BEP20 implementation and does not include advanced or non-standard control logic.

The contract **does NOT contain**:
- Blacklist logic
- Whitelist logic
- Transfer restrictions
- Sell restrictions or honeypot mechanisms
- Hidden minting functions
- Owner-controlled parameter changes
- Trading cooldowns or wallet limitations
---
## Ownership and Control

- Contract ownership has been fully renounced
- No privileged roles or admin controls remain
- Contract behavior is immutable and permissionless
---
## Trading and Liquidity

- Trading is permissionless
- Liquidity is available on PancakeSwap
- Buy and sell operations are unrestricted
---
## Notes

This document is provided for transparency and security review purposes.  
Additional on-chain references or transaction evidence can be provided upon request.
