SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DocumentVerification{
    address public admin;
    mapping(address => bool)public VerifiedUsers;
    mapping(string => address)private documentOwner;

    //events to notify the actions done in contract to Dapps
    event UserVerified(address user);
    event DocumentUploaded(string ipfsHash, address user)

    //modifiers for restricting the access
    modifier onlyAdmin(){
        require(msg.sender == admin, "Only admin is allowed to perfrom this action");
        _;
    }

    modifier onlyVerified(){
        require(VerifiedUsers[msg.sender], "User not verified");
        _;
    }

    //constructor to set the admin
    constructor(){
        admin = msg.sender;
    }

    //function to verify the users
    function verifyUser(address user) external onlyAdmin{
        VerifiedUsers[user] = true;
        emit UserVerified(user);
    }

    //function to upload the document
    function uploadDocument(string memory ipfsHash) external onlyVerified{
        require(documentOwner[ipfsHash] == address(0), "Document already exists");
        documentOwner[ipfsHash] = msg.sender;
        emit DocumentUploaded(msg.sender, ipfsHash);
    }

    //function to verify the document 
    function verifyDocument(string memory ipfsHash) external view returns(address){
        return documentOwner[ipfsHash];
    }
}
