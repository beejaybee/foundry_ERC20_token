// SPDX-License-Identifier:MIT

pragma solidity 0.8.27;

import {Test} from "forge-std/Test.sol";
import {BeejayToken} from "src/BeejayToken.sol";
import {DeployBeejayToken} from "script/DeployBeejayToken.sol";


contract BeejayTokenTest is Test {
    BeejayToken public beejayToken;
    DeployBeejayToken public deployer;

    address bob = makeAddr("bob");
    address sodiq = makeAddr("sodiq");

    uint256 public constant STARTING_BALANCE = 200 ether;
    uint256 public constant INITIAL_SUPPLY = 100000000 ether;


    function setUp() public {
        deployer = new DeployBeejayToken();
        beejayToken = deployer.run();

        vm.prank(address(msg.sender));
        beejayToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public view {
        assert(STARTING_BALANCE == beejayToken.balanceOf(bob));
    }

    function testTranfer() public {
        uint256 amount = 100;
        uint256 initial_balance = beejayToken.balanceOf(bob);
        vm.prank(bob);
        beejayToken.transfer(sodiq, amount);
        assert(beejayToken.balanceOf(bob) == initial_balance - amount);
    }

    function testAllowanceWorks() public {
        uint256 initialAllowance = 1000;
        uint256 transferAmount = 500;

        //Bob approves Sodiq to spend token on his behalf
        vm.prank(bob);
        beejayToken.approve(sodiq, initialAllowance);

        vm.prank(sodiq);
        beejayToken.transferFrom(bob, sodiq, transferAmount);

        assert(beejayToken.balanceOf(sodiq) == transferAmount);
        assert(beejayToken.balanceOf(bob) == STARTING_BALANCE - transferAmount);
    }


    function testInitialSupplyOfToken() public view {
        assert(beejayToken.totalSupply() == INITIAL_SUPPLY);
    }

    function testDeployerBalance() public view {
        uint256 deployerBalance = INITIAL_SUPPLY - STARTING_BALANCE;
        assert(beejayToken.balanceOf(msg.sender) == deployerBalance);
    }

    function testAllowanceAfterTransferFrom() public {
        uint256 initialAllowance = 200 ether;
        uint256 transferAmount = 100 ether;

        vm.prank(bob);
        beejayToken.approve(sodiq, initialAllowance);

        vm.prank(sodiq);
        beejayToken.transferFrom(bob, sodiq, transferAmount);

        assertEq(beejayToken.allowance(bob, sodiq), initialAllowance - transferAmount);
    }

}