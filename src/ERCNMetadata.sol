// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "src/ERCN.sol";

contract ERCNMetadata is ERCN {
    /// @dev Thrown when the id does not exist.
    /// @param id The id of the token.
    error InvalidId(uint256 id);

    /// @notice The name of the token.
    string public name = "Example ERCN Metadata";

    /// @notice The symbol of the token.
    string public symbol = "EEM";

    /// @notice The URI for each id.
    /// @param id The id of the token.
    /// @return The URI of the token.
    function tokenURI(uint256 id) public view returns (string memory) {
        if (totalSupply[id] == 0) revert InvalidId(id);
        return string(abi.encodePacked("<base_uri>/", toString(id)));
    }
}

// author: Solady (https://github.com/vectorized/solady/blob/main/src/utils/LibString.sol)
function toString(uint256 value) pure returns (string memory str) {
    /// @solidity memory-safe-assembly
    assembly {
        str := add(mload(0x40), 0x80)
        mstore(0x40, add(str, 0x20))
        mstore(str, 0)
        let end := str
        let w := not(0)
        for { let temp := value } 1 {} {
            str := add(str, w)
            mstore8(str, add(48, mod(temp, 10)))
            temp := div(temp, 10)
            if iszero(temp) { break }
        }
        let length := sub(end, str)
        str := sub(str, 0x20)
        mstore(str, length)
    }
}
