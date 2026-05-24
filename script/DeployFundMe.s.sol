//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";   
import {HelperConfig} from "../script/HelperConfig.s.sol";

contract DeployFundMe is Script {
    // The next line runs before the vm.startBroadcast() is called
    // This will not be deployed because the `real` signed txs are happening
    // between the start and stop Broadcast lines.
    function run() external returns (FundMe) {
            // 1. Grab the config BEFORE the broadcast (saves gas, not a real tx)
            HelperConfig helperConfig = new HelperConfig();
            address ethUsdPriceFeed = helperConfig.activeNetworkConfig();
    
            // 2. Start the real deployment transaction
            vm.startBroadcast();
            
            // 3. THE FIX: Pass the extracted address into the parentheses
            FundMe fundMe = new FundMe(ethUsdPriceFeed); 
            
            vm.stopBroadcast();
    
            return fundMe;
        }    
}