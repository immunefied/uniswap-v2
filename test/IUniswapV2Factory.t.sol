// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/interfaces/IERC20.sol";
import {IUniswapV2Factory} from "./interfaces/IUniswapV2Factory.sol";
import {IUniswapV2Router} from "./interfaces/IUniswapV2Router.sol";
import {IUniswapV2Pair} from "./interfaces/IUniswapV2Pair.sol";

contract IUniswapV2FactoryTest is Test {
    IUniswapV2Factory public factory = IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f);
    IERC20 public WETH = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    IERC20 public USDT = IERC20(0xdAC17F958D2ee523a2206206994597C13D831ec7);
    IERC20 public BNB = IERC20(0xB8c77482e45F1F44dE1745F52C74426C631bDD52);

    function setUp() public {
        vm.createSelectFork("mainnet", 19_708_589);
    }

    function testCreatePair() public {
        vm.rollFork(10_000_835 + 1); // Creation date of UniswapV2Factory
        address tokenPair = factory.createPair(address(WETH), address(USDT));

        assertEq(factory.allPairsLength(), 1);
        assertEq(factory.allPairs(0), tokenPair);
    }

    function testFail_Already_CreatedPair() public {
        address tokenPair = factory.createPair(address(WETH), address(USDT));
        assertEq(factory.allPairsLength(), 1);
        assertEq(factory.allPairs(0), tokenPair);
    }
}
