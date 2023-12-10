//SPDX-License-Identifer: MIT
pragma solidity ^0.8.21;

import "@story/modules/ModuleRegistry.sol";
import "@story/IPAssetRegistry.sol";
import "@story/modules/licensing/LicenseRegistry.sol";
import "@story/modules/licensing/LicensingModule.sol";
import "@story/ip-org/IPOrg.sol";
import "@story/ip-org/IPOrgController.sol";
import "@story/StoryProtocol.sol";
import "@story/modules/registration/RegistrationModule.sol";
import "@story/modules/relationships/RelationshipModule.sol";
import "forge-std/Test.sol";

contract TestStory is Test {
    // AccessControlSingleton-Impl =	0xFe033E3Ff0b2EED1120317684A26c0FF3b46E861;
    // AccessControlSingleton-Proxy =	0x9A5e3396d13436Ab6bFef6f0CF6C0b1F5C151736;
    ModuleRegistry modReg = 0x04f2D41e6c1a26C11E6bB090ABb8724b393246c2;
    IPAssetRegistry ipaReg = 0x28B68E9C238497445C45b6426d28F5eC7feAb460;
    LicenseRegistry licReg = 0xE2BbA5B3B94A1aEadb59b01580641D18156CF5b7;
    // IPOrgController impl = 0xAa1d97F2f9e05693DBAdD23b9263E84201492cdd;
    IPOrgController proxy = 0xD0bFCB5EDac68B7bF68477d788319688E2B798e7;
    StoryProtocol story = 0xEc95c31a5ed4A6323Da3AC1a2faD90d71b1b3F8f;
    RegistrationModule regMod = 0x70a5485402a5F41022d3d318a9b7A79b47e83B12;
    RelationshipModule relMod = 0xdbC14E28356Ed7466D987703C95C42f58f1732F5;
    LicensingModule licMod = 0x9DF2896fd46a9F331bafA48a91ad360502837426;

    address ipO_owner = makeAddr("ipO_owner");

    IPOrg ipOrg;

    function setUp() public {
        // create IPORG
        ipOrg = IPOrg(
            story.registerIpOrg(ipO_owner, "Remerger", "RMG", new string[](0))
        );
        // Create a licensing Framework

        // Configure the license framework for the IPASSET
        LicensingConfig memory config = LicensingConfig({
            frameworkId: "1234",
            params: ParamValue[],
            licensor: Licensing.LicensorConfig.Source
        });
        story.configureIpOrgLicensing(address(ipOrg), config);
        // create IPASSETS
        // story.registerIPAsset...
        // create a License
        // story.createLicense...
        assertTrue(false);
    }
}
