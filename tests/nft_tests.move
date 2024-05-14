#[test_only]
module collection::nft_tests {
    // Test attribute is placed before the `fun` keyword. Can be both above or
    // right before the `fun` keyword: `#[test] fun my_test() { ... }`
    // The name of the test would be `book::testing::simple_test`.
    #[test_only]
    use collection::nft;
    use sui::url;
    use std::string;
    use sui::tx_context;

    #[test_only] use sui::test_utils;
    #[test_only] use sui::test_scenario;
    #[test_only] use sui::display;

    #[test]
    // test `name` function
    fun nft_name_test() {
        let name = b"ARTI";
        let description = b"ARTI_NFT";
        let nft_url = b"ARTI_NFT";
        let fractionId = 12;
        let artfi_royalty = 4;
        let artist_royalty = 3;
        let staking_contract_royalty = 3;
        let royalty = nft::new_royalty(artfi_royalty, artist_royalty, staking_contract_royalty);
        let royalty_info = nft::new_royalty_info(royalty);
        let testNetNFt = nft::new_artfi_nft(
            string::utf8(name),
            string::utf8(description), 
            url::new_unsafe_from_bytes(nft_url), 
            fractionId,
            &mut royalty_info,
            &mut tx_context::dummy()
        );

        assert!(nft::name(&testNetNFt) == &string::utf8(b"ARTI"), 1);

        let dummy_address = @0xCAFE;
        sui::transfer::public_transfer(testNetNFt, dummy_address);
        test_utils::destroy<nft::RoyaltyInfo>(royalty_info);
        
    }

    // test `description` function
    #[test]
    fun nft_description_test() {
        let name = b"ARTI";
        let description = b"ARTI_NFT";
        let nft_url = b"ARTI_NFT";
        let fractionId = 12;
        let artfi_royalty = 4;
        let artist_royalty = 3;
        let staking_contract_royalty = 3;
        let royalty = nft::new_royalty(artfi_royalty, artist_royalty, staking_contract_royalty);
        let royalty_info = nft::new_royalty_info(royalty);
        let testNetNFt = nft::new_artfi_nft(
            string::utf8(name),
            string::utf8(description), 
            url::new_unsafe_from_bytes(nft_url), 
            fractionId,
            &mut royalty_info,
            &mut tx_context::dummy()
        );
        assert!(nft::description(&testNetNFt) == &string::utf8(b"ARTI_NFT"), 1);

        let dummy_address = @0xCAFE;
        sui::transfer::public_transfer(testNetNFt, dummy_address);
        test_utils::destroy<nft::RoyaltyInfo>(royalty_info);
        
    }

    #[test]
    // test `url` function
    fun nft_url_test() {
        let name = b"ARTI";
        let description = b"ARTI_NFT";
        let nft_url = b" ";
        let fractionId = 12;
        let artfi_royalty = 4;
        let artist_royalty = 3;
        let staking_contract_royalty = 3;
        let royalty = nft::new_royalty(artfi_royalty, artist_royalty, staking_contract_royalty);
        let royalty_info = nft::new_royalty_info(royalty); 
        let testNetNFt = nft::new_artfi_nft(
            string::utf8(name),
            string::utf8(description), 
            url::new_unsafe_from_bytes(nft_url), 
            fractionId,
            &mut royalty_info,
            &mut tx_context::dummy()
        );
        assert!(nft::url(&testNetNFt) ==  &url::new_unsafe_from_bytes(nft_url), 1);

        test_utils::destroy<nft::ArtFiNFT>(testNetNFt);
        test_utils::destroy<nft::RoyaltyInfo>(royalty_info);
    }

    #[test]
    // test `url` function
    fun nft_royalty_test() {
        let name = b"ARTI";
        let description = b"ARTI_NFT";
        let nft_url = b" ";
        let fractionId = 12;
        let artfi_royalty = 4;
        let artist_royalty = 3;
        let staking_contract_royalty = 3;
        let royalty = nft::new_royalty(artfi_royalty, artist_royalty, staking_contract_royalty);
        let royalty_info = nft::new_royalty_info(royalty); 
        let testNetNFt = nft::new_artfi_nft(
            string::utf8(name),
            string::utf8(description), 
            url::new_unsafe_from_bytes(nft_url), 
            fractionId,
            &mut royalty_info,
            &mut tx_context::dummy()
        );
        let royalty_instance = nft::new_royalty(4, 3, 3); 
        assert!(nft::royalty(&testNetNFt, &royalty_info) == royalty_instance, 1);

        test_utils::destroy<nft::ArtFiNFT>(testNetNFt);
        test_utils::destroy<nft::Royalty>(royalty_instance);
        test_utils::destroy<nft::RoyaltyInfo>(royalty_info);
    }

    #[test]
    // test `url` function
    fun nft_artfi_royalty_test() {
        let name = b"ARTI";
        let description = b"ARTI_NFT";
        let nft_url = b" ";
        let fractionId = 12;
        let artfi_royalty = 4;
        let artist_royalty = 3;
        let staking_contract_royalty = 3;
        let royalty = nft::new_royalty(artfi_royalty, artist_royalty, staking_contract_royalty);
        let royalty_info = nft::new_royalty_info(royalty); 
        let testNetNFt = nft::new_artfi_nft(
            string::utf8(name),
            string::utf8(description), 
            url::new_unsafe_from_bytes(nft_url), 
            fractionId,
            &mut royalty_info,
            &mut tx_context::dummy()
        );
        assert!(nft::artfi_royalty(&testNetNFt, &royalty_info) ==  4, 1);

        test_utils::destroy<nft::ArtFiNFT>(testNetNFt);
        test_utils::destroy<nft::RoyaltyInfo>(royalty_info);
    }

    #[test]
    // test `url` function
    fun nft_artist_royalty_test() {
        let name = b"ARTI";
        let description = b"ARTI_NFT";
        let nft_url = b" ";
        let fractionId = 12;
        let artfi_royalty = 4;
        let artist_royalty = 3;
        let staking_contract_royalty = 3;
        let royalty = nft::new_royalty(artfi_royalty, artist_royalty, staking_contract_royalty);
        let royalty_info = nft::new_royalty_info(royalty); 
        let testNetNFt = nft::new_artfi_nft(
            string::utf8(name),
            string::utf8(description), 
            url::new_unsafe_from_bytes(nft_url), 
            fractionId,
            &mut royalty_info,
            &mut tx_context::dummy()
        );
        assert!(nft::artist_royalty(&testNetNFt, &royalty_info) ==  3, 1);

        test_utils::destroy<nft::ArtFiNFT>(testNetNFt);
        test_utils::destroy<nft::RoyaltyInfo>(royalty_info);
    }

    #[test]
    // test `url` function
    fun nft_stakingContract_royalty_test() {
        let name = b"ARTI";
        let description = b"ARTI_NFT";
        let nft_url = b" ";
        let fractionId = 12;
        let artfi_royalty = 4;
        let artist_royalty = 3;
        let staking_contract_royalty = 3;
        let royalty = nft::new_royalty(artfi_royalty, artist_royalty, staking_contract_royalty);
        let royalti_info = nft::new_royalty_info(royalty);
        let testNetNFt = nft::new_artfi_nft(
            string::utf8(name),
            string::utf8(description), 
            url::new_unsafe_from_bytes(nft_url), 
            fractionId,
            &mut royalti_info,
            &mut tx_context::dummy()
        );
        assert!(nft::staking_contract_royalty(&testNetNFt, &royalti_info) ==  3, 1);

        test_utils::destroy<nft::ArtFiNFT>(testNetNFt);
        test_utils::destroy<nft::RoyaltyInfo>(royalti_info);
    }

    #[test]
    fun test_module_init() {

        let initial_owner = @0xCAFE;
        let final_owner = @0xFACE;

        let scenario = test_scenario::begin(initial_owner);
        {   
            test_scenario::sender(&scenario);

            nft::test_init(test_scenario::ctx(&mut scenario));

        };

        test_scenario::next_tx(&mut scenario,initial_owner);
        {
            let adminCap = test_scenario::take_from_sender<nft::AdminCap>(&scenario);

            nft::transfer_minter_cap(&adminCap, final_owner, test_scenario::ctx(&mut scenario));

             test_utils::destroy<nft::AdminCap>(adminCap);

        };

        test_scenario::end(scenario);
    }

    #[test]
    fun test_transfer_minter_cap() {

        let initial_owner = @0xCAFE;
        let final_owner = @0xFACE;

        let scenario = test_scenario::begin(initial_owner);
        {   
            test_scenario::sender(&scenario);

            nft::test_init(test_scenario::ctx(&mut scenario));

        };

        test_scenario::next_tx(&mut scenario,initial_owner);
        {
            let adminCap = test_scenario::take_from_sender<nft::AdminCap>(&scenario);

            nft::transfer_minter_cap(&adminCap, final_owner, test_scenario::ctx(&mut scenario));

             test_utils::destroy<nft::AdminCap>(adminCap);

        };

        test_scenario::end(scenario);
    }

    #[test]
    fun test_transfer_admin_cap() {

        let initial_owner = @0xCAFE;
        let final_owner = @0xFACE;

        let scenario = test_scenario::begin(initial_owner);
        {   
            test_scenario::sender(&scenario);

            nft::test_init(test_scenario::ctx(&mut scenario));

        };

        test_scenario::next_tx(&mut scenario,initial_owner);
        {
            let adminCap = test_scenario::take_from_sender<nft::AdminCap>(&scenario);

            nft::transfer_admin_cap(adminCap, final_owner);

        };

        test_scenario::end(scenario);
    }

    #[test]
    fun test_mint_nft() {

        let url = b" ";
        let fractionId = 12;

        let initial_owner = @0xCAFE;
        let final_owner = @0xFACE;

        let scenario = test_scenario::begin(initial_owner);
        {   
            test_scenario::sender(&scenario);

            nft::test_init(test_scenario::ctx(&mut scenario));

        };

        test_scenario::next_tx(&mut scenario, initial_owner);
        {

            let minterCap = test_scenario::take_from_sender<nft::MinterCap>(&scenario);
            let display_object = test_scenario::take_shared<display::Display<nft::ArtFiNFT>>(&scenario);
            let royalti_info = test_scenario::take_shared<nft::RoyaltyInfo>(&scenario);
            nft::mint_nft(
                &minterCap, 
                &display_object,
                url, 
                final_owner, 
                fractionId, 
                &mut royalti_info,
                test_scenario::ctx(&mut scenario)
            );

            test_utils::destroy<nft::MinterCap>(minterCap);
            test_scenario::return_shared<display::Display<nft::ArtFiNFT>>(display_object);
            test_scenario::return_shared(royalti_info);
        };

        test_scenario::next_tx(&mut scenario,final_owner);
        {
            let nftToken = test_scenario::take_from_sender<nft::ArtFiNFT>(&scenario);

            assert!(nft::name(&nftToken) == &string::utf8(b"ARTFI"), 1);
            assert!(nft::description(&nftToken) == &string::utf8(b"ARTFI_NFT"), 1);
            assert!(nft::url(&nftToken) == &url::new_unsafe_from_bytes(url), 1);
            let royalty_instance = nft::new_royalty(4, 3, 3);

            let royalti_info = test_scenario::take_shared<nft::RoyaltyInfo>(&scenario);
            assert!(nft::royalty(&nftToken, &royalti_info) == royalty_instance, 1);

            test_utils::destroy<nft::ArtFiNFT>(nftToken);
            test_utils::destroy<nft::Royalty>(royalty_instance);
            test_scenario::return_shared<nft::RoyaltyInfo>(royalti_info);
            
        };

        test_scenario::end(scenario);
    }

    #[test]
    fun test_mint_batch_nft() {

        let url = vector[b" "];
        let fractionId = vector[12];

        let initial_owner = @0xCAFE;
        let final_owner = @0xFACE;

        let scenario = test_scenario::begin(initial_owner);
        {   
            test_scenario::sender(&scenario);

            nft::test_init(test_scenario::ctx(&mut scenario));

        };

        test_scenario::next_tx(&mut scenario, initial_owner);
        {

            let minterCap = test_scenario::take_from_sender<nft::MinterCap>(&scenario);
            let display_object = test_scenario::take_shared<display::Display<nft::ArtFiNFT>>(&scenario);
            let royalty_info = test_scenario::take_shared<nft::RoyaltyInfo>(&scenario);

            nft::mint_nft_batch(
                &minterCap, 
                &display_object,
                &mut royalty_info,
                &url, 
                &vector[final_owner], 
                &fractionId, 
                test_scenario::ctx(&mut scenario)
            );

            test_utils::destroy<nft::MinterCap>(minterCap);
            test_scenario::return_shared<nft::RoyaltyInfo>(royalty_info);
            test_scenario::return_shared<display::Display<nft::ArtFiNFT>>(display_object);
        };

        test_scenario::next_tx(&mut scenario,final_owner);
        {
            let nftToken = test_scenario::take_from_sender<nft::ArtFiNFT>(&scenario);

            assert!(nft::name(&nftToken) == &string::utf8(b"ARTFI"), 1);
            assert!(nft::description(&nftToken) == &string::utf8(b"ARTFI_NFT"), 1);
            assert!(nft::url(&nftToken) == &url::new_unsafe_from_bytes(b" "), 1);

            let royalty_instance = nft::new_royalty(4, 3, 3);

            let royalty_info = test_scenario::take_shared<nft::RoyaltyInfo>(&scenario);
            assert!(nft::royalty(&nftToken, &royalty_info) == royalty_instance, 1);
            test_utils::destroy<nft::ArtFiNFT>(nftToken);
            test_utils::destroy<nft::Royalty>(royalty_instance);
            test_scenario::return_shared<nft::RoyaltyInfo>(royalty_info);
            
        };

        test_scenario::end(scenario);
    }

    #[test]
    fun test_transfer_nft() {

        let url = b" ";
        let fractionId = 12;

        let initial_owner = @0xCAFE;
        let final_owner = @0xFACE;
        let user = @0xEAFF;

        let scenario = test_scenario::begin(initial_owner);
        {   
            test_scenario::sender(&scenario);

            nft::test_init(test_scenario::ctx(&mut scenario));

        };

        test_scenario::next_tx(&mut scenario, initial_owner);
        {

            let minterCap = test_scenario::take_from_sender<nft::MinterCap>(&scenario);
            let display_object = test_scenario::take_shared<display::Display<nft::ArtFiNFT>>(&scenario);
            let royalty_info = test_scenario::take_shared<nft::RoyaltyInfo>(&scenario);

            nft::mint_nft(
                &minterCap, 
                &display_object,
                url, 
                final_owner, 
                fractionId, 
                &mut royalty_info,
                test_scenario::ctx(&mut scenario)
            );

            test_utils::destroy<nft::MinterCap>(minterCap);
            test_scenario::return_shared<display::Display<nft::ArtFiNFT>>(display_object);
            test_scenario::return_shared<nft::RoyaltyInfo>(royalty_info);
        };

        test_scenario::next_tx(&mut scenario,final_owner);
        {
            let nftToken = test_scenario::take_from_sender<nft::ArtFiNFT>(&scenario);

            nft::transfer_nft(nftToken, user, test_scenario::ctx(&mut scenario));
            
        };

        test_scenario::next_tx(&mut scenario, user);
        {
            let nftToken = test_scenario::take_from_sender<nft::ArtFiNFT>(&scenario);

            assert!(nft::name(&nftToken) == &string::utf8(b"ARTFI"), 1);
            assert!(nft::description(&nftToken) == &string::utf8(b"ARTFI_NFT"), 1);
            assert!(nft::url(&nftToken) == &url::new_unsafe_from_bytes(url), 1);
            let royalty_instance = nft::new_royalty(4, 3, 3);

            let royalty_info = test_scenario::take_shared<nft::RoyaltyInfo>(&scenario);
            assert!(nft::royalty(&nftToken, &royalty_info) == royalty_instance, 1);

            test_utils::destroy<nft::ArtFiNFT>(nftToken);
            test_utils::destroy<nft::Royalty>(royalty_instance);
            test_scenario::return_shared<nft::RoyaltyInfo>(royalty_info);
        };

        test_scenario::end(scenario);
    }

    #[test]
    #[expected_failure(abort_code = test_scenario::EEmptyInventory)] 
    fun test_burn_nft() {
        let url = b" ";
        let fractionId = 12;

        let initial_owner = @0xCAFE;
        let final_owner = @0xFACE;

        let scenario = test_scenario::begin(initial_owner);
        {   
            test_scenario::sender(&scenario);

            nft::test_init(test_scenario::ctx(&mut scenario));

        };

        test_scenario::next_tx(&mut scenario, initial_owner);
        {

            let minterCap = test_scenario::take_from_sender<nft::MinterCap>(&scenario);
            let display_object = test_scenario::take_from_sender<display::Display<nft::ArtFiNFT>>(&scenario);
            let royalty_info = test_scenario::take_shared<nft::RoyaltyInfo>(&scenario);

            nft::mint_nft(
                &minterCap, 
                &display_object,
                url, 
                final_owner, 
                fractionId, 
                &mut royalty_info,
                test_scenario::ctx(&mut scenario)
            );

            test_utils::destroy<nft::MinterCap>(minterCap);
            test_utils::destroy<display::Display<nft::ArtFiNFT>>(display_object);
            test_scenario::return_shared<nft::RoyaltyInfo>(royalty_info);
            
        };

        test_scenario::next_tx(&mut scenario,final_owner);
        let nftToken;
        {
            nftToken = test_scenario::take_from_sender<nft::ArtFiNFT>(&scenario);
        };

        test_scenario::next_tx(&mut scenario, initial_owner);
        {   
            let adminCap = test_scenario::take_from_sender<nft::AdminCap>(&scenario);
            let royalty_info = test_scenario::take_shared<nft::RoyaltyInfo>(&scenario);
            nft::burn(nftToken, &mut royalty_info, test_scenario::ctx(&mut scenario));
            test_utils::destroy<nft::AdminCap>(adminCap); 

            test_scenario::return_shared<nft::RoyaltyInfo>(royalty_info);
        };

        test_scenario::next_tx(&mut scenario, final_owner);
        {
            let nftToken = test_scenario::take_from_sender<nft::ArtFiNFT>(&scenario);

            test_utils::destroy<nft::ArtFiNFT>(nftToken);            
        };

        test_scenario::end(scenario);
    }

    #[test]
    #[expected_failure(abort_code = test_scenario::EEmptyInventory)] 
    fun test_will_error_on_transfer_minter_cap_by_other_address() {

        let initial_owner = @0xCAFE;
        let final_owner = @0xFACE;

        let scenario = test_scenario::begin(initial_owner);
        {   
            test_scenario::sender(&scenario);

            nft::test_init(test_scenario::ctx(&mut scenario));

        };

        test_scenario::next_tx(&mut scenario, final_owner);
        {
            let adminCap = test_scenario::take_from_sender<nft::AdminCap>(&scenario);

            nft::transfer_minter_cap(&adminCap, final_owner, test_scenario::ctx(&mut scenario));

            test_utils::destroy<nft::AdminCap>(adminCap);
        };
        
        test_scenario::end(scenario);
    }

    #[test]
    #[expected_failure(abort_code = test_scenario::EEmptyInventory)] 
    fun test_will_error_on_transfer_admin_cap_by_other_address() {

        let initial_owner = @0xCAFE;
        let final_owner = @0xFACE;

        let scenario = test_scenario::begin(initial_owner);
        {   
            test_scenario::sender(&scenario);

            nft::test_init(test_scenario::ctx(&mut scenario));

        };

        test_scenario::next_tx(&mut scenario, final_owner);
        {
            let adminCap = test_scenario::take_from_sender<nft::AdminCap>(&scenario);

            nft::transfer_admin_cap(adminCap, final_owner);

        };
        
        test_scenario::end(scenario);
    }

    #[test]
    #[expected_failure(abort_code = test_scenario::EEmptyInventory)]
    fun test_will_error_on_transfer_nft_by_other_address() {

        let url = b" ";
        let fractionId = 12;

        let initial_owner = @0xCAFE;
        let final_owner = @0xFACE;
        let user = @0xEAFF;

        let scenario = test_scenario::begin(initial_owner);
        {   
            test_scenario::sender(&scenario);

            nft::test_init(test_scenario::ctx(&mut scenario));

        };

        test_scenario::next_tx(&mut scenario, initial_owner);
        {

            let minterCap = test_scenario::take_from_sender<nft::MinterCap>(&scenario);
            let display_object = test_scenario::take_from_sender<display::Display<nft::ArtFiNFT>>(&scenario);
            let royalty_object = test_scenario::take_shared<nft::RoyaltyInfo>(&scenario);

            nft::mint_nft(
                &minterCap, 
                &display_object,
                url, 
                final_owner, 
                fractionId, 
                &mut royalty_object,
                test_scenario::ctx(&mut scenario)
            );

            test_utils::destroy<nft::MinterCap>(minterCap);
            test_utils::destroy<display::Display<nft::ArtFiNFT>>(display_object);
            test_scenario::return_shared<nft::RoyaltyInfo>(royalty_object);
        };

        test_scenario::next_tx(&mut scenario, initial_owner);
        {
            let nftToken = test_scenario::take_from_sender<nft::ArtFiNFT>(&scenario);

            nft::transfer_nft(nftToken, user, test_scenario::ctx(&mut scenario));
            
        };

        test_scenario::end(scenario);
    }

    #[test]
    #[expected_failure(abort_code = collection::nft::ELengthNotEqual)] 
    fun test_will_error_on_batch_mint_for_unequal_length_vector() {

        let url = vector[b" ", b"ARTI_NFT"];
        let fractionId = vector[12];

        let initial_owner = @0xCAFE;
        let final_owner = @0xFACE;

        let scenario = test_scenario::begin(initial_owner);
        {   
            test_scenario::sender(&scenario);

            nft::test_init(test_scenario::ctx(&mut scenario));

        };

        test_scenario::next_tx(&mut scenario, initial_owner);
        {

            let minterCap = test_scenario::take_from_sender<nft::MinterCap>(&scenario);
            let display_object = test_scenario::take_shared<display::Display<nft::ArtFiNFT>>(&scenario);
            let royalty_object = test_scenario::take_shared<nft::RoyaltyInfo>(&scenario);

            nft::mint_nft_batch(
                &minterCap, 
                &display_object,
                &mut royalty_object,
                &url, 
                &vector[final_owner], 
                &fractionId, 
                test_scenario::ctx(&mut scenario)
            );

            test_utils::destroy<nft::MinterCap>(minterCap);
            test_scenario::return_shared<display::Display<nft::ArtFiNFT>>(display_object);
            test_scenario::return_shared<nft::RoyaltyInfo>(royalty_object);
        };

        test_scenario::end(scenario);
    }
        
}
