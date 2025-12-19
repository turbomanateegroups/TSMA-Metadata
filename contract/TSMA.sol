// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title TurboS Manatee (TSMA)
 * @notice Clean ERC20/BEP20: fixed supply, no tax, no blacklist, no pause.
 *         Owner exists only for optional renounceOwnership (no privileged functions).
 */
contract TurboSManateeTSMA {
    // -------------------------
    // Metadata
    // -------------------------
    string public constant name = "TurboS Manatee";
    string public constant symbol = "TSMA";
    uint8  public constant decimals = 18;

    uint256 public constant TOTAL_SUPPLY = 100_000_000 * 10**18;

    // -------------------------
    // Storage
    // -------------------------
    uint256 private _totalSupply;
    mapping(address => uint256) private _bal;
    mapping(address => mapping(address => uint256)) private _allow;

    address private _owner;

    // -------------------------
    // Errors (cheaper than revert strings)
    // -------------------------
    error NotOwner();
    error ZeroAddress();
    error InsufficientBalance();
    error InsufficientAllowance();

    // -------------------------
    // Events (ERC20 standard + ownership)
    // -------------------------
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    // -------------------------
    // Modifiers
    // -------------------------
    modifier onlyOwner() {
        if (msg.sender != _owner) revert NotOwner();
        _;
    }

    // -------------------------
    // Constructor
    // -------------------------
    /**
     * @param initialReceiver The address that receives the full fixed supply at deployment
     */
    constructor(address initialReceiver) {
        if (initialReceiver == address(0)) revert ZeroAddress();

        _owner = msg.sender;
        emit OwnershipTransferred(address(0), _owner);

        _mint(initialReceiver, TOTAL_SUPPLY);
    }

    // -------------------------
    // Owner view
    // -------------------------
    function owner() external view returns (address) {
        return _owner;
    }

    /**
     * @notice Renounce ownership (owner becomes address(0)).
     *         This does NOT affect transfers; token remains fully transferable.
     */
    function renounceOwnership() external onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    // -------------------------
    // ERC20 views
    // -------------------------
    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _bal[account];
    }

    function allowance(address account, address spender) external view returns (uint256) {
        return _allow[account][spender];
    }

    // -------------------------
    // ERC20 core
    // -------------------------
    function transfer(address to, uint256 amount) external returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        uint256 cur = _allow[from][msg.sender];
        if (cur < amount) revert InsufficientAllowance();

        unchecked {
            _allow[from][msg.sender] = cur - amount;
        }
        emit Approval(from, msg.sender, _allow[from][msg.sender]);

        _transfer(from, to, amount);
        return true;
    }

    // -------------------------
    // Allowance helpers (better UX)
    // -------------------------
    function increaseAllowance(address spender, uint256 added) external returns (bool) {
        _approve(msg.sender, spender, _allow[msg.sender][spender] + added);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtracted) external returns (bool) {
        uint256 cur = _allow[msg.sender][spender];
        if (cur < subtracted) revert InsufficientAllowance();
        unchecked {
            _approve(msg.sender, spender, cur - subtracted);
        }
        return true;
    }

    // -------------------------
    // Internal functions
    // -------------------------
    function _transfer(address from, address to, uint256 amount) internal {
        if (from == address(0) || to == address(0)) revert ZeroAddress();

        uint256 fromBal = _bal[from];
        if (fromBal < amount) revert InsufficientBalance();

        unchecked {
            _bal[from] = fromBal - amount;
        }
        _bal[to] += amount;

        emit Transfer(from, to, amount);
    }

    function _mint(address account, uint256 amount) internal {
        if (account == address(0)) revert ZeroAddress();
        _totalSupply += amount;
        _bal[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    function _approve(address account, address spender, uint256 amount) internal {
        if (account == address(0) || spender == address(0)) revert ZeroAddress();
        _allow[account][spender] = amount;
        emit Approval(account, spender, amount);
    }
}
