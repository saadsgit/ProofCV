# ProofCV

**ProofCV** is a verifiable credential system built on **Monad Testnet**.

It lets trusted issuers such as student clubs, workshop organizers, universities, hackathons, or training providers issue tamper-proof resume credentials to students. Anyone can publicly verify whether a certificate is real, who issued it, when it was issued, and whether it has been revoked.

---

## Live Demo

**Frontend:** https://proofcv.vercel.app

**Network:** Monad Testnet

**Smart Contract Address:** `0x243E0f85B8A9e8d7BE8D182B42C8f250D3d5B3c6`

---

## Problem

Students often list certificates, workshop attendance, club roles, hackathon participation, volunteering, and training experience on their CVs or LinkedIn profiles.

Most of these credentials are shared as PDFs, screenshots, or plain text claims. These are easy to fake, edit, backdate, or reuse.

For employers, clubs, organizers, and universities, verifying these claims usually means manually contacting the issuer. That process is slow, inconsistent, and often skipped.

---

## Solution

ProofCV gives trusted issuers a simple way to publish verifiable credential records onchain.

Each certificate records:

- Student wallet address
- Issuer wallet address
- Issuer name
- Certificate title
- Certificate description
- Issue timestamp
- Revocation status

Anyone can enter a certificate ID and verify the credential publicly.

Only approved issuer wallets can issue credentials. The admin wallet can add trusted issuers, and certificates can be revoked by the original issuer or the admin.

---

## Why Blockchain?

ProofCV uses blockchain because the core problem is trust.

With a normal database, users must trust the platform owner not to edit, delete, or fake credential records. With ProofCV, credential records are stored on Monad Testnet and can be independently verified.

Blockchain is useful here because:

- Students cannot fake credentials from unapproved issuers
- Credentials cannot be silently edited after issue
- Anyone can verify a credential without asking the issuer privately
- Revoked credentials remain visible as invalid
- Issuer permissions and revocation rules are enforced by the smart contract

---

## Key Features

- Public certificate verification
- Trusted issuer access control
- Onchain certificate issuance
- Certificate revocation
- Student wallet certificate lookup
- Admin-controlled issuer approval
- MetaMask integration
- Vercel-hosted frontend
- Smart contract deployed on Monad Testnet

---

## Demo Flow

1. Open the live frontend.
2. Verify an existing certificate ID.
3. Connect MetaMask on Monad Testnet.
4. Issue a new certificate to a student wallet.
5. Look up the student's certificate IDs.
6. Verify the newly issued certificate.
7. Revoke the certificate.
8. Verify again to show that the certificate becomes invalid/revoked.

---

## Tech Stack

- Solidity
- Remix IDE
- Monad Testnet
- MetaMask
- HTML
- CSS
- JavaScript
- ethers.js
- Vercel

---

## Smart Contract Overview

The main contract is `ProofCV.sol`.

### Main Functions

#### `addIssuer(address issuerAddress, string memory name)`

Admin-only function to approve a trusted issuer wallet.

#### `issueCertificate(address student, string memory title, string memory description)`

Allows an active issuer to issue a certificate to a student wallet.

#### `verifyCertificate(uint256 certificateId)`

Public function that returns certificate details and whether the certificate is valid.

#### `getStudentCertificates(address student)`

Public function that returns all certificate IDs linked to a student wallet.

#### `revokeCertificate(uint256 certificateId)`

Allows the original issuer or admin to revoke a certificate.

---

## Access Control

| Action | Permission |
|---|---|
| Verify certificate | Anyone |
| View student certificate IDs | Anyone |
| Issue certificate | Approved issuers only |
| Add issuer | Admin only |
| Revoke certificate | Original issuer or admin |

---

## Project Structure

```text
ProofCV/
├── ProofCV.sol
├── index.html
├── README.md
└── screenshots/
```

---

## Screenshots

Add uploaded screenshots here if required by the submission.

Example:

```markdown
![Homepage](screenshots/homepage.png)
![Valid Certificate](screenshots/valid-certificate.png)
![Revoked Certificate](screenshots/revoked-certificate.png)
```

---

## How to Run Locally

Clone the repository:

```bash
git clone https://github.com/saadsjit/ProofCV.git
cd ProofCV
```

Start a local server:

```bash
python -m http.server 5173
```

Open:

```text
http://localhost:5173
```

Make sure MetaMask is connected to Monad Testnet when issuing, revoking, or adding issuers.

Public verification works without connecting a wallet.

---

## Deployment

The frontend is deployed on Vercel:

```text
https://proofcv.vercel.app
```

The smart contract is deployed on Monad Testnet.

Contract address:

```text
PASTE_YOUR_CONTRACT_ADDRESS_HERE
```

---

## Future Improvements

- Downloadable PDF certificates
- QR code verification
- Certificate categories
- Issuer profile pages
- Better student profile dashboard
- IPFS or decentralized storage for certificate files
- Institution-level issuer management
- Search by student wallet, issuer, or credential type

---

## Built For

Monad Blitz Kuala Lumpur

---

## Author

Mohammed Saad
