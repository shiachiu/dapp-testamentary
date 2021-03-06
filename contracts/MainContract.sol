// SPDX-License-Identifier: MIT
pragma solidity <= 0.7.6;

contract MainContract {
    
    /* backup variable */
    string email; 
    string password;
    string idno;
    address[] owners;
    address mainowner;
    mapping(address => bool) isOwner;
    uint revisepo;
    uint totalpo;
    
    //event
    event Deposit(address user,uint deamount);
    event Withdraw(address user,uint wiamount);
    
    //modifier
    modifier onlyOwner (address addr){
        require(isOwner[addr], "not owner");
        _;
    }
    
    modifier checkSameOwner (address addr){
        require(mainowner == addr, "not contract owner");
        _;
    }

    modifier checkSameId (string memory _idNo){
        require(keccak256(abi.encodePacked((idno))) == keccak256(abi.encodePacked((_idNo))), "not correct id");
        _;
    }
    
    constructor (string memory _id) public {
        email = "";
        password = "";
        idno =_id;
        owners = [msg.sender];
        mainowner = msg.sender;
        isOwner[msg.sender] = true;
        Beneficiary storage newbene = beneficiaryinfo[0];
        newbene.beneficiaryemail = "beautygang4@gmail.com";
        newbene.portion = 5;
        newbene.execute = false;
        beneficiarymails.push("beautygang4@gmail.com");
        mailexist["beautygang4@gmail.com"]=true;
        portions["beautygang4@gmail.com"]=5;
        beneficiaryidentity.push("0000000000");
        identity["beautygang4@gmail.com"]="0000000000";
    }
    
    /* bank function */
    
    //deposit
    function deposit() public payable checkSameOwner(msg.sender){
        emit Deposit(msg.sender,msg.value);
    }
    
    //withdraw
    function withdraw(uint _amount) public payable checkSameOwner(msg.sender){
        require((_amount) <= address(this).balance, "not enough funds");
        (bool sent, ) = msg.sender.call.value(_amount)("");
        require(sent, "Failed to send Ether");
        emit Withdraw(msg.sender,_amount*10**18);
    }
    
    //balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    //id
    function getIdno() external view returns (string memory){
        return idno;
    }
    
    /* backup function */
    
    //create back-up, setting email and password
    function setBackup(string memory _email,string memory _password,string memory _idNo) public checkSameOwner(msg.sender) checkSameId(_idNo){
        email = _email;
        password = _password;
    }
    
    //check email and password
    function checksubmitTransaction(string calldata _idNo, string calldata _email,string calldata _password,address payable _to) external checkSameId(_idNo){
        require(keccak256(abi.encodePacked((email))) != keccak256(abi.encodePacked((""))),"Do not set the back-up mechanism email.");
        require(keccak256(abi.encodePacked((_email))) == keccak256(abi.encodePacked((email))),"Please enter the former email.");
        require(keccak256(abi.encodePacked((password))) != keccak256(abi.encodePacked((""))),"Do not set the back-up mechanism password.");
        require(keccak256(abi.encodePacked((_password))) == keccak256(abi.encodePacked((password))),"Please enter the former password.");
        addOwners(_to);
        destroySmartContract(_to);
    }
    
    //add the activater into owers to activate the mechanism
    function addOwners(address _newaddress) private{
        owners.push(_newaddress);
        isOwner[_newaddress] = true;
    }
    
    //destroy the contract and take the ether back
    function destroySmartContract(address payable _to) internal onlyOwner(_to){
        selfdestruct(_to);
    }
    
    /* beneficiary variable */
    
    string owneremail; 
    struct Beneficiary{
        string beneficiaryemail;
        uint portion;
        bool execute;
    }
    mapping(uint=>Beneficiary) beneficiaryinfo;
    uint[]  beneficiaryids;
    string[] beneficiarymails;
    mapping(string=>bool) mailexist;
    mapping(string=>uint) portions;
    mapping(address=>uint) transferamount;
    string[] beneficiaryidentity;
    mapping(string=>string) identity;
    mapping(string=>bool) idexist;
    address payable[] toadds;
    uint[] reviseportion;
    
    /* beneficiary function */
    
    //ower email
    function submitEmail(string memory _ownermail) public {
       owneremail = _ownermail;
    }
    
    function getOwnerEmail() public view returns (string memory) {
        return owneremail;
    }
    
    function addbene(string memory _benemail,uint _distriburate,string memory _identity) public checkSameOwner(msg.sender){
       require(getBalance() > 0);
       uint id = beneficiaryids.length + 1;
       Beneficiary storage newbene = beneficiaryinfo[id];
       newbene.beneficiaryemail = _benemail;
       newbene.portion = _distriburate;
       newbene.execute = false;
       beneficiaryids.push(id);
       beneficiarymails.push(_benemail);
       mailexist[_benemail] = true;
       portions[_benemail] = _distriburate;
       beneficiaryidentity.push(_identity);
       identity[_benemail]=_identity;
       idexist[_identity]=true;
    }
    
    //check beneficiary info
    function getBeneficiary(uint _id) public view returns (string memory,uint,bool){
        Beneficiary storage s = beneficiaryinfo[_id];
        return (s.beneficiaryemail,s.portion,s.execute);
    }

    function getbeneficiarybymail(string memory _mail) public view returns(bool){
        return mailexist[_mail];
    }

    function getportion(string memory _mail) public view returns(uint){
        return portions[_mail];
    }

    function getbeneficiaryidbymail(string memory _mail) public view returns(string memory){
        return identity[_mail];
    }
    //change beneficiary portion
    function modifybene(uint _id,string memory _mail,uint _portion)public checkSameOwner(msg.sender){
        Beneficiary storage s = beneficiaryinfo[_id];
        s.portion = _portion;
        portions[_mail] = _portion;
    }
    /*function submitTransaction(address payable _to,uint _portion) payable public {
        toadds.push(_to);
        transferamount[_to] = address(this).balance / 100 * _portion;
        if (toadds.length == beneficiarymails.length) {
           for (uint i = 0; i < toadds.length; i++) {
             toadds[i].transfer(transferamount[toadds[i]]);  
           }
        }
    }*/
    function submitTransaction(address payable _to,uint _portion) public {
        toadds.push(_to);
        //reviseportion.push(_portion);
        transferamount[_to]=address(this).balance/100*_portion;
        if(toadds.length==beneficiarymails.length){
           for(uint i=0;i<toadds.length;i++){
            //    for(uint r=0;r<reviseportion.length;r++){
            //  totalpo+=reviseportion[r];
            //  revisepo=100*_portion/totalpo;
            //  transferamount[_to]=address(this).balance/100*revisepo;
                toadds[i].transfer(transferamount[toadds[i]]); 
           }
        }
        //_to.transfer(address(this).balance/100*_portion);}
    }
    
    
    /* not use just for check */
    
    function getisOwners(address _checkaddress) public view returns (bool) {
        return isOwner[_checkaddress];
    }
    
    function getEmail() public view returns (string memory) {
        return email;
    }
    
    function getPassword() public view returns (string memory) {
        return password;
    }
    
    function getOwners() public view returns (address[] memory) {
        return owners;
    }
    
    function returnlen() public view returns (uint) {
        return beneficiarymails.length;
    }

    
    // function submitTransaction(address payable _to) public onlyOwner(_to){
    //     _to.transfer(address(this).balance);
    //     activated = true;
    // }
}

// contract Backup {
//     MainContract maincontract;
//     constructor (address _oneContractAddr) public {
//         maincontract = MainContract(_oneContractAddr);
//     }
    
//     function setBackup(string memory _email,string memory _password,string memory _idNo) public {
//         maincontract.setBackup(_email,_password,_idNo);
        
//     }
//     function activateBackup(string calldata _idNo, string calldata _email,string calldata _password,address payable _to) external {
//         maincontract.checksubmitTransaction(_idNo,_email,_password,_to);
//     }

//     function getEmail() public view returns (string memory){
//         return maincontract.getEmail();
//     }
//     function getIdno() public view returns (string memory){
//         return maincontract.getIdno();
//     }
    
    
// }

// contract ActivateBackup {
//     Backup backup;
//     constructor (address _oneContractAddr) public {
//         backup = Backup(_oneContractAddr);
//     }
//     // function getbackaddress() public view returns (Backup){
//     //     return backup;
//     // }
//     // function checkContract(address _contractaddress,string memory _email,string memory _password) public {
//     //     Backup a = backup;
//     //     backup = Backup(_contractaddress);
//     //     activateBackup(_email,_password);
//     //     backup = a;
//     // }
//     // constructor (address _oneContractAddr,string memory _email,string memory _password) public {
//     //     backup = Backup(_oneContractAddr);
//     //     email = _email;
//     //     password = _password;

//     // }
//     function activateBackup(string memory _idNo, string memory _email,string memory _password) public {
//         backup.activateBackup(_idNo,_email,_password,msg.sender);
//     }
    
// }

contract setpassword {
    MainContract maincontract;
    bytes32 password;
    uint portion;
    mapping (address => bytes32) beneficiarypass;
    mapping (string => uint) portions;
    mapping (address => string) mail;
    bool act;

    constructor (address _oneContractAddr) public {
        maincontract = MainContract(_oneContractAddr);
    }
    
    function passset(string memory _mail,string memory _password,string memory _identity) public {
        require(maincontract.getbeneficiarybymail(_mail) == true&&keccak256(abi.encodePacked((maincontract.getbeneficiaryidbymail(_mail))))==keccak256(abi.encodePacked(_identity)));
        password = keccak256(abi.encode(_password));
        beneficiarypass[msg.sender] = password;
        mail[msg.sender] = _mail;
        act=false;
    }
     
    function getmail() public view returns (string memory) {
        return mail[msg.sender];
    }
    
    function getpassword() public view returns (bytes32) {
        return beneficiarypass[msg.sender];
    }
    
    function getmypo() public view returns (uint) {
        return maincontract.getportion(mail[msg.sender]);
    }
    
    function execute (string memory _password) public payable{
        require(keccak256(abi.encode(_password)) == beneficiarypass[msg.sender]);
        require(act == false);
        portion = maincontract.getportion(mail[msg.sender]);
        maincontract.submitTransaction(msg.sender,portion);
        act=true;

     }


}