//SPDX-License-Identifer: MIT
pragma solidity ^0.8.21;

import {ModuleRegistry} from "@story/modules/ModuleRegistry.sol";
import {IPAssetRegistry} from "@story/IPAssetRegistry.sol";
import {LicenseRegistry} from "@story/modules/licensing/LicenseRegistry.sol";
import {LicensingModule, Licensing, SPUMLParams} from "@story/modules/licensing/LicensingModule.sol";
import {IPOrg} from "@story/ip-org/IPOrg.sol";
import {IPOrgController} from "@story/ip-org/IPOrgController.sol";
import {StoryProtocol} from "@story/StoryProtocol.sol";
import {RegistrationModule} from "@story/modules/registration/RegistrationModule.sol";
import {RelationshipModule} from "@story/modules/relationships/RelationshipModule.sol";
import {ShortString, ShortStrings} from "@openzeppelin/contracts/utils/ShortStrings.sol";
import {Test, console} from "forge-std/Test.sol";

contract TestStory is Test {
    using ShortStrings for *;
    // AccessControlSingleton-Impl =	0xFe033E3Ff0b2EED1120317684A26c0FF3b46E861;
    // AccessControlSingleton-Proxy =	0x9A5e3396d13436Ab6bFef6f0CF6C0b1F5C151736;
    ModuleRegistry modReg =
        ModuleRegistry(0x04f2D41e6c1a26C11E6bB090ABb8724b393246c2);
    IPAssetRegistry ipaReg =
        IPAssetRegistry(0x28B68E9C238497445C45b6426d28F5eC7feAb460);
    LicenseRegistry licReg =
        LicenseRegistry(0xE2BbA5B3B94A1aEadb59b01580641D18156CF5b7);
    // IPOrgController impl = (0xAa1d97F2f9e05693DBAdD23b9263E84201492cdd);
    IPOrgController proxy =
        IPOrgController(0xD0bFCB5EDac68B7bF68477d788319688E2B798e7);
    StoryProtocol story =
        StoryProtocol(0xEc95c31a5ed4A6323Da3AC1a2faD90d71b1b3F8f);
    RegistrationModule regMod =
        RegistrationModule(0x70a5485402a5F41022d3d318a9b7A79b47e83B12);
    RelationshipModule relMod =
        RelationshipModule(0xdbC14E28356Ed7466D987703C95C42f58f1732F5);
    LicensingModule licMod =
        LicensingModule(0x9DF2896fd46a9F331bafA48a91ad360502837426);

    address ipO_owner = makeAddr("ipO_owner");

    IPOrg ipOrg;

    function setUp() public {
        vm.deal(ipO_owner, 100 ether);
        vm.startPrank(ipO_owner);
        // create IPORG
        ipOrg = IPOrg(
            story.registerIpOrg(ipO_owner, "Remerger", "RMG", new string[](0))
        );
        // Create a licensing Framework
        ShortString[] memory channel_distribution = new ShortString[](2);
        channel_distribution[0] = "remix manager 1".toShortString();
        channel_distribution[1] = "remix manager 2".toShortString();
        // Configure the license framework for the IPASSET
        Licensing.ParamValue[] memory lParams = new Licensing.ParamValue[](3);
        lParams[0] = Licensing.ParamValue({
            tag: SPUMLParams.CHANNELS_OF_DISTRIBUTION.toShortString(),
            value: abi.encode(channel_distribution)
        });
        lParams[1] = Licensing.ParamValue({
            tag: SPUMLParams.ATTRIBUTION.toShortString(),
            value: abi.encode(true) // unset
        });
        lParams[2] = Licensing.ParamValue({
            tag: SPUMLParams.DERIVATIVES_ALLOWED.toShortString(),
            value: abi.encode(true)
        });

        Licensing.LicensingConfig memory config = Licensing.LicensingConfig({
            frameworkId: "1234",
            params: lParams,
            licensor: Licensing.LicensorConfig.Source
        });
        story.configureIpOrgLicensing(address(ipOrg), config);
        // create IPASSETS
        // story.registerIPAsset...
        // create a License
        // story.createLicense...
        vm.stopPrank();
    }

    function test_it_tries_to_work() public {
        assertTrue(false);
    }
}
