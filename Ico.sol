pragma solidity 0.5.17;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.1/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.1/contracts/ownership/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.1/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.1/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.1/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.1/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.1/contracts/crowdsale/validation/WhitelistCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.1/contracts/crowdsale/distribution/FinalizableCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.1/contracts/token/ERC20/ERC20Mintable.sol";

contract TokenCrowdsale is Ownable, Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, WhitelistCrowdsale, FinalizableCrowdsale {

    
  enum CrowdSaleStage {Private, Pre, Post }

  CrowdSaleStage public stage = CrowdSaleStage.Private;

  uint256 public reserveWallet   = 30;
  uint256 public InterestPayout  = 20;
  uint256 public TMHRWallet  = 10;
  uint256 public CGFundWallet = 13;
  uint256 public AirdropWallet = 2;
  uint256 public TokenSaleWallet = 25;
  uint256 public _rt;
  
  address payable reserve;
  address payable Interest;
  address payable TMHR;
  address payable CGFund;
  address payable Airdrop;
  address payable TokenSale;


  constructor(
    uint256 _rate,
    ERC20 _token,
    uint256 _cap,
    uint256 _openingTime,
    uint256 _closingTime,
    address payable _reserve,
    address payable _Interest,
    address payable _TMHR,
    address payable _CGFund,
    address payable _Airdrop,
    address payable _TokenSale
  )
    Crowdsale(_rate, address(this), _token)
    CappedCrowdsale(_cap)
    TimedCrowdsale(_openingTime, _closingTime)
    public
  {
  
    reserve  = _reserve;
    Interest = _Interest;
    TMHR = _TMHR;
    CGFund = _CGFund;
    Airdrop = _Airdrop;  
    TokenSale = _TokenSale;
  
  }
  

  function setStage(uint8 _stage, uint8 _week) public onlyOwner {
    if(uint(CrowdSaleStage.Private) == _stage) {
      stage = CrowdSaleStage.Private;
      setRate(25);
    } else if (uint(CrowdSaleStage.Pre) == _stage) {
      stage = CrowdSaleStage.Pre;
      setRate(20);
    } else if (uint(CrowdSaleStage.Post) == _stage) {
      stage = CrowdSaleStage.Post;
      if(_week == 1){
        setRate(15);
      }
      else if(_week == 2){
        setRate(10);
      }
      else if(_week == 3){
        setRate(5);
      }
      else{
        setRate(1);
      }
    }
  }
    
    
  
  
  function() payable external { 
    }
  
    function setRate(uint256 newrt) internal {
        _rt = newrt;
    }
  
   function changerate() public view returns(uint256){
       return _rt;
   }

  function _getTokenAmount(uint256 weiAmount) internal view returns (uint256) {
        return weiAmount.add(weiAmount.mul(_rt).div(100));
    } 
    
    
  function _finalization() internal {
    uint256 finalSupply = address(this).balance;
    reserve.transfer(finalSupply.mul(reserveWallet).div(100));
    Interest.transfer(finalSupply.mul(InterestPayout).div(100));
    TMHR.transfer(finalSupply.mul(TMHRWallet).div(100));
    CGFund.transfer(finalSupply.mul(CGFundWallet).div(100));
    Airdrop.transfer(finalSupply.mul(AirdropWallet).div(100));
    TokenSale.transfer(finalSupply.mul(TokenSaleWallet).div(100));

    super._finalization();
  }
  

}

