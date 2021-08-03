This project is built on Remix (remix.ethereum.org)

For truffle (@openzeppelin/contracts": "^2.5.1") <- this package should be installed.

1. Deploy Token.sol with arguments token name, token symbol and decimal.
2. Change (OpenZeppelin/openzeppelin-contracts/blob/v2.5.1/contracts/crowdsale/Crowdsale.sol) Crowdsale.sol with this Crowdsale.sol for few minor changes.
3. Deploy Ico.sol.
4. Copy the address of contract Ico.sol and pass it in addMinter(_contractaddress) function. It will give the right to Ico contract to mint the tokens until crowdsale ends. The minted tokens will be added to the total supply automatically.
5. Pass address in addwhitelisted function to make someone whitelisted investor.
6. 1wei = 1$.
7. Minimum contribution should be more than 500 wei.
8. Setstage function is used to manually set the stage
		-> 0,0 for 1st phase(1st 15 days ) - rate will be changed to 25
		-> 1,0 for 2nd phase(2nd 15 days ) - rate will be changed to 20
		-> 2,1 for 3rd phase(1st week of 30 days ) - rate will be changed to 15
		-> 2,2 for 4th phase(2nd week of 30 days ) - rate will be changed to 10

	Alternatively, in Crowdsale.sol remove buyTokens and _getTokenAmount functions and uncomment the buyTokens and _getTokenAmount functions which were previously commented, and remove setstage function from ico.sol, and it will automatically change rates.
9. After crowdsale ends, run finalize function and it will send the funds raised during sale in the respective wallets with respective percents from ico contract.
