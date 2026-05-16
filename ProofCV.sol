// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract ProofCV {
    address public owner;
    uint256 public nextCertificateId = 1;

    struct Issuer {
        string name;
        bool active;
    }

    struct Certificate {
        uint256 id;
        address student;
        address issuer;
        string title;
        string description;
        uint256 issuedAt;
        bool revoked;
    }

    mapping(address => Issuer) public issuers;
    mapping(uint256 => Certificate) public certificates;
    mapping(address => uint256[]) private studentCertificates;

    event IssuerAdded(address indexed issuer, string name);
    event CertificateIssued(
        uint256 indexed certificateId,
        address indexed student,
        address indexed issuer,
        string title
    );
    event CertificateRevoked(uint256 indexed certificateId);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    modifier onlyActiveIssuer() {
        require(issuers[msg.sender].active, "Not active issuer");
        _;
    }

    constructor() {
        owner = msg.sender;
        issuers[msg.sender] = Issuer("ProofCV Admin", true);
    }

    function addIssuer(address issuerAddress, string memory name) external onlyOwner {
        require(issuerAddress != address(0), "Invalid issuer");
        issuers[issuerAddress] = Issuer(name, true);
        emit IssuerAdded(issuerAddress, name);
    }

    function issueCertificate(
        address student,
        string memory title,
        string memory description
    ) external onlyActiveIssuer returns (uint256) {
        require(student != address(0), "Invalid student");

        uint256 certId = nextCertificateId;

        certificates[certId] = Certificate({
            id: certId,
            student: student,
            issuer: msg.sender,
            title: title,
            description: description,
            issuedAt: block.timestamp,
            revoked: false
        });

        studentCertificates[student].push(certId);
        nextCertificateId++;

        emit CertificateIssued(certId, student, msg.sender, title);

        return certId;
    }

    function revokeCertificate(uint256 certificateId) external {
        Certificate storage cert = certificates[certificateId];

        require(cert.id != 0, "Certificate does not exist");
        require(
            msg.sender == cert.issuer || msg.sender == owner,
            "Only issuer or owner"
        );

        cert.revoked = true;

        emit CertificateRevoked(certificateId);
    }

    function verifyCertificate(uint256 certificateId)
        external
        view
        returns (
            bool exists,
            bool valid,
            address student,
            address issuer,
            string memory issuerName,
            string memory title,
            string memory description,
            uint256 issuedAt,
            bool revoked
        )
    {
        Certificate memory cert = certificates[certificateId];

        if (cert.id == 0) {
            return (
                false,
                false,
                address(0),
                address(0),
                "",
                "",
                "",
                0,
                false
            );
        }

        bool isValid = !cert.revoked && issuers[cert.issuer].active;

        return (
            true,
            isValid,
            cert.student,
            cert.issuer,
            issuers[cert.issuer].name,
            cert.title,
            cert.description,
            cert.issuedAt,
            cert.revoked
        );
    }

    function getStudentCertificates(address student)
        external
        view
        returns (uint256[] memory)
    {
        return studentCertificates[student];
    }
}