pragma solidity 0.5.17;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.1/contracts/token/ERC20/ERC20Detailed.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.1/contracts/token/ERC20/ERC20Mintable.sol";

contract Token is ERC20Mintable, ERC20Detailed {
    constructor(string memory _name, string memory _symbol, uint8 _decimals)
        ERC20Detailed(_name, _symbol, _decimals)
        public
    {

    }
}
