//SPDX-License-Identifer: MIT
pragma solidity ^0.8.19;

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

// "AccessControlSingleton-Impl": "0xC97Bf3B002354E35B026f546802Df337471F9394",
//     "AccessControlSingleton-Proxy": "0xb98C744a2b9e5DF92302Feda41437C52653bBB79",
//     "IPAssetRegistry": "0x60B51a24eB4748E75E2015F83dDEF212D4529439",
//     "IPOrgController-Impl": "0x54B146692C73DE6985D84A5c4a82F7187829a272",
//     "IPOrgController-Proxy": "0x1498Ecc8a1cA7cCeAF1E1789F2f9Cf86Fe9CDBfB",
//     "LicenseRegistry": "0x9a75984bc44924d3379344085A25c893AE8c45f2",
//     "LicensingFrameworkRepo": "0xDE810424341F5a42F60D57dfd3Ae84ddad79158a",
//     "LicensingModule": "0x4F63a203e4120fb0a5B877A96ba1e5499E7BA1D7",
//     "MockERC721": "0x314581504F3b64aAeF805Dcae4e2A20b2AA80Db4",
//     "ModuleRegistry": "0x45204F4291103be222B7c93eDE252d3f5Cbf3710",
//     "PolygonTokenHook": "0x6DD16148A958054F0dC5F77444031Ff6E11E6c6F",
//     "RegistrationModule": "0x8a38a8527922c34dA72A57a3ca8c3a2D99dA2547",
//     "RelationshipModule": "0xf9B73593d7C525153dD2801D5bDc697DA1F2DCa2",
//     "StoryProtocol": "0xcb733fD57B99212e60696Fd6605154BeEBA11bDe",
//     "TokenGatedHook": "0x8bc85DC6983B72df1F0A3ccA7B1c5D8c72Cb9983"

contract TestStory is Test {
    using ShortStrings for *;
    // AccessControlSingleton-Impl =	0xFe033E3Ff0b2EED1120317684A26c0FF3b46E861;
    // AccessControlSingleton-Proxy =	0x9A5e3396d13436Ab6bFef6f0CF6C0b1F5C151736;
    ModuleRegistry modReg =
        ModuleRegistry(0x45204F4291103be222B7c93eDE252d3f5Cbf3710);
    IPAssetRegistry ipaReg =
        IPAssetRegistry(0x60B51a24eB4748E75E2015F83dDEF212D4529439);
    LicenseRegistry licReg =
        LicenseRegistry(0x9a75984bc44924d3379344085A25c893AE8c45f2);
    // IPOrgController impl = (0xAa1d97F2f9e05693DBAdD23b9263E84201492cdd);
    IPOrgController proxy =
        IPOrgController(0x1498Ecc8a1cA7cCeAF1E1789F2f9Cf86Fe9CDBfB);
    StoryProtocol story =
        StoryProtocol(0xcb733fD57B99212e60696Fd6605154BeEBA11bDe);
    RegistrationModule regMod =
        RegistrationModule(0x8a38a8527922c34dA72A57a3ca8c3a2D99dA2547);
    RelationshipModule relMod =
        RelationshipModule(0xf9B73593d7C525153dD2801D5bDc697DA1F2DCa2);
    LicensingModule licMod =
        LicensingModule(0x4F63a203e4120fb0a5B877A96ba1e5499E7BA1D7);

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
        Licensing.ParamValue[] memory lParams = new Licensing.ParamValue[](0);

        Licensing.LicensingConfig memory config = Licensing.LicensingConfig({
            frameworkId: SPUMLParams.FRAMEWORK_ID,
            params: lParams,
            licensor: Licensing.LicensorConfig.Source
        });
        story.configureIpOrgLicensing(address(ipOrg), config);
        // create IPASSETS
        // story.registerIPAsset...
        // create a License
        lParams = new Licensing.ParamValue[](3);
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
        Licensing.LicenseCreation memory licenseCreateConfig = Licensing
            .LicenseCreation({parentLicenseId: 0, ipaId: 0, params: lParams});

        story.createLicense(address(ipOrg), licenseCreateConfig);
        // create an IP ASSET when you're the owner of the license, it will work
        vm.stopPrank();
    }

    function test_it_tries_to_work() public {
        assertTrue(false);
    }
}
