#[allow(lint(share_owned, self_transfer))]
module collection::base_nft {

    use std::string::String;

    use sui::event;
    use sui::vec_map;
    use sui::display;
    use sui::package;

    // === Structs ===

    public struct AdminCap has key {
        id: UID
    }

    // ===== Events =====

    public struct NFTMinted has copy, drop {
        // The Object ID of the GOP
        token_id: ID,
        // The creator of the GOP
        creator: address,
        // The name of the GOP
        name: String,
    }

    public struct NFTBatchMinted has copy, drop {
        // The Object IDs of Batch Minted GOPs
        token_ids: vector<ID>,
        // The creator of the GOP
        creator: address,
        // The name of the GOP
        name: String,
        // number of tokens
        no_of_tokens: u64
    }

    public struct NFTBurned<phantom T> has copy, drop {
        // The Object ID of the NFT
        token_id: ID,
    }

    public struct TransferredObject<phantom T> has copy, drop {
        // The Object ID of the NFT
        token_id: ID,
        // address of receiver
        recipient: address
    }

    public struct NFTMetadataUpdated has copy, drop {
        /// Name for the token
        name: String,
        /// Description of the token
        description: String,
    }

    public struct AttributesUpdated<T, U> has copy, drop {
        key: T,
        value: U
    }

    // ===== Entrypoints =====

    /// Module initializer is called only once on module publish.
    fun init(ctx: &mut TxContext){
        transfer::transfer(AdminCap {
            id: object::new(ctx)
        }, tx_context::sender(ctx));
    }

    // === Public Functions ===
 
    /// Emits a NFTMinted
    public fun emit_mint_nft(id: ID, creator: address, name: String) {
        event::emit(NFTMinted {
            token_id: id,
            creator: creator,
            name: name,
        });
    }

    /// Emits a NFTBatchMinted
    public fun emit_batch_mint_nft(ids: vector<ID>, no_of_tokens: u64,creator: address, name: String) {
        event::emit(NFTBatchMinted {
            token_ids: ids,
            creator: creator,
            name: name,
            no_of_tokens: no_of_tokens
        });
    }

    /// Emits a NFTMetadataUpdated
    public fun emit_metadat_update(new_name: String, new_description: String) {
        event::emit(NFTMetadataUpdated{
            name: new_name,
            description: new_description,
        })
    }

    /// Emits an AttributesUpdated
    public fun emit_update_attributes<T: copy + drop, U: copy + drop>(id: T, value: U) {
        event::emit(AttributesUpdated{
            key: id,
            value: value
        })
    }

    /// Emits a NFTBurned
    public fun emit_burn_nft<T>(id: ID) {
        event::emit(NFTBurned<T> {
            token_id: id
        });
    }

    /// Emits a TransferredObject for object type T
    public fun emit_transfer_object<T>(id: ID, recipient: address) {
        emit_transfer<T>(id, recipient);
    }

    /// Transfer `publisher` to `recipient`
    /// Emits a TransferredObject for Publisher object
    public entry fun transfer_publisher_object(
        publisher_object: package::Publisher, recipient: address, _: &mut TxContext
    ) {
        let _id = object::id(&publisher_object);
        transfer::public_transfer(publisher_object, recipient);

        emit_transfer<package::Publisher>(_id, recipient);
    }

    /// Transfer `display` to `recipient`
    /// Emits a TransferredObject for object type display::Display<T>
    public entry fun transfer_display_object<T: key + store>(
        display_object: display::Display<T>, recipient: address, _: &mut TxContext
    ) {
        let _id = object::id(&display_object);
        transfer::public_transfer(display_object, recipient);

        emit_transfer<display::Display<T>>(_id, recipient);
    }

    /// Transfer `upgrade cap` to `recipient`
    /// Emits a TransferredObject for object type UpgradeCap
    public entry fun transfer_upgrade_object(
        upgrade_cap: package::UpgradeCap, recipient: address, _: &mut TxContext
    ) {
        let _id = object::id(&upgrade_cap);
        transfer::public_transfer(upgrade_cap, recipient);

        emit_transfer<package::UpgradeCap>(_id, recipient);
    }

    /// Remove and insert new value to Id key
    /// Emits an AttributesUpdated
    public fun update_attribute<T: copy + drop, U: copy + drop>(vector_map: &mut vec_map::VecMap<T, U>, id: T, value: U) {
        vec_map::remove(vector_map, &id);
        vec_map::insert(vector_map, id, value);

        event::emit(AttributesUpdated{
            key: id,
            value: value
        })
    }

    // === AdminCap Functions ===

    /// Transfer admin cap to new_owner
    /// Emits a TransferredObject for object type AdminCap
    public entry fun transfer_admin_cap(admin_cap: AdminCap, new_owner: address, _: &mut TxContext) {
        let _id = object::id(&admin_cap);
        transfer::transfer(admin_cap, new_owner);

        emit_transfer<AdminCap>(_id, new_owner);
    }

    // === Private Functions ===

    fun emit_transfer<T>(id: ID, recipient: address) {
        event::emit(TransferredObject<T> {
            token_id: id,
            recipient: recipient
        });
    }
}
