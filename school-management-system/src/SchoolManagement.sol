// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SchoolManagement {
    
    IERC20 public Token;

    constructor(address _tokenAddress) {
        Token = IERC20(_tokenAddress);
        admin = msg.sender;
    } 

    modifier onlyAdmin() {
      require(msg.sender == admin, "Only admin");
      _;
    }


    struct Student{
        string name;
        uint256 level;
        bool paid;
        uint256 paymentTimestamp;
    }

    struct Staff{
        string name;
        uint256 salary;
        bool paid;
        uint256 paymentTimestamp;
    }

    mapping(address => Student) public students;
    mapping(address => Staff) public staffs;

    address[] public studentLists;
    address[] public staffLists;
    address public admin;

    function registerStudent(address _student, string memory name, uint256 _level, uint256 _fee) public {

        require(_level >= 100 && _level <= 400, "level is not found");

        require(bytes(name).length > 0, "Name is required");

        require(Token.transferFrom(_student, address(this), _fee), "Payment failed");

        require(_fee > 0, "Account zero detected");

       students[_student] = Student({ name: name, level: _level, paid: true, paymentTimestamp: block.timestamp});
       studentLists.push(_student);
    }

    function registerStaff(address _staffAddress, string memory name, uint256 salary, uint256 _fee) public onlyAdmin {

        require(_staffAddress != address(0), "Account zero detected");

        require(bytes(name).length > 0, "Name is required");

        // Staff Payment

        require(Token.transferFrom(admin, _staffAddress, _fee), "Salary payment failed");

        staffs[_staffAddress] = Staff({ name: name, salary: salary, paid: true, paymentTimestamp: block.timestamp});

        staffLists.push(_staffAddress);
    }

    function getStudents() public view returns (address[] memory) {
        return studentLists;
    }

    function getStaffs() public view returns (address[] memory) {
        return staffLists;
    }

    function pricing(uint256 _level, string memory name) public pure {
        
        require(bytes(name).length > 0, "Name is required");

        require(_level >= 100 && _level <= 400, "You are not eligible");
    }

    function suspendStudent(uint256_id) external {
        for(uint256 i; i < students.length; i++) {
            if(students[i].id == _id) {
                students[i] = students[students.length - 1]
            }
            students[i].pop();
        }
    }

    function suspendStaff(uint256 _id) external {
        for(uint256 i; i < staffs.length; i++) {
            if(staffs[i].id == _id) {
                staffs[i] = staffs[staffs.length - 1]
                staffs[i].pop();
            }
        }
    }

    function staffPayment(address _staffAddress, uint256 _amount) public onlyAdmin {
        require(staffs[_staffAddress].salary >= amount, "Amount exceeds salary");
        require(Token.transfer(_staffAddress, amount), "Payment failed");
        staffs[_staffAddress].paymentTimestamp = block.timestamp;
    }

    function employStaff(address _staffAddress, string memory name uint256 salary) public onlyAdmin {
        staffs[_staffAddress] = Staff({
        name: name,
        salary: salary,
        paid: false,
        paymentTimestamp: 0,
        suspended: false
    });
    
    staffLists.push(_staffAddress);
    }

}