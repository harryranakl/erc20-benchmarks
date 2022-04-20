// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import {DSTest} from "@ds-test/test.sol";
import {Test, stdError} from "@forge-std/Test.sol";

import {ERC20Mock} from "../mocks/ERC20Mock.sol";
import {console} from "../utils/Console.sol";


contract ERC20Test is DSTest, Test {
    ERC20Mock m20;
    address initialAccount;
    address alice = 0x000000000000000000636F6e736F6c652e6c6f67;
    address bob  = 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045;

    function setUp() public {
        // console.log('setUp', msg.sender);
        initialAccount = msg.sender;
        m20 = new ERC20Mock('ERC20MOCKBENCH','E20B', initialAccount, 1e18);
    }

    function testName() public {
        // console.log('testName', msg.sender);
        assertEq(m20.name(),'ERC20MOCKBENCH');
    }

    function testSymbol() public {
        // console.log('testSymbol', msg.sender);
        assertEq(m20.symbol(),'E20B');
    }

    function testSupply() public {
        // console.log('testSupply', msg.sender);
        assertEq(m20.totalSupply(),1e18);
    }

    function testBalance() public {
        // console.log('testBalance', msg.sender);
        assertEq(m20.balanceOf(initialAccount), 1e18);
    }

    function testMint() public {
        console.log('testMint', msg.sender);
        console.log('testMint 1e18', m20.totalSupply());
        m20.mint(msg.sender, 1000000);
        console.log('testMint 1e18 + 1000000', m20.totalSupply());
        assertEq(m20.totalSupply(),1e18 + 1000000);
    }

    function testBurn() public {
        console.log('testBurn', msg.sender);
        console.log('testBurn 1e18', m20.totalSupply());
        m20.mint(msg.sender, 1000000);
        console.log('testBurn 1e18 + 1000000', m20.totalSupply());
        m20.burn(initialAccount, 1000000);
        console.log('testBurn 1e18 - 1000000', m20.totalSupply());
        assertEq(m20.totalSupply(),1e18);
    }

    function testMintFuzz(uint256 t) public {
        console.log('testMintFuzz', msg.sender);
        console.log('testMintFuzz', t, m20.totalSupply());
        if(t < m20.totalSupply()){
            m20.mint(msg.sender, t);
            console.log('testMintFuzz', t, m20.totalSupply());
            m20.burn(msg.sender, t);
            console.log('testMintFuzz', t, m20.totalSupply());
        } else{
            m20.mint(msg.sender, t);
            vm.expectRevert(stdError.arithmeticError);
            // assertTrue(true);
        }
    }

    // function testMintAlice1000() public {
    //     // console.log('testMintAlice1000', msg.sender);
    //     assertEq(m20.balanceOf(alice), 0);
    //     m20.mint(alice, 1000);
    //     assertEq(m20.balanceOf(alice), 1000);
    // }

    // function testMintAlice1000_2() public {
    //     // console.log('testMintAlice1000_2', msg.sender);
    //     assertEq(m20.balanceOf(alice), 0);
    //     m20.mint(alice, 1000**2);
    //     assertEq(m20.balanceOf(alice), 1000**2);
    // }
}