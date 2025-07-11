// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./interfaceICofre.sol";

contract Cofre is ICofre {

    mapping (address => uint256) public creditos;

    event Deposito(address indexed de, uint256 valor);
    event Saque(address indexed para, uint256 valor);

    function depositar() external payable {
        require(msg.value > 0, "envie algum ether");
        creditos[msg.sender] += msg.value;
        emit Deposito(msg.sender, msg.value);
    }
    
    function consultarSaldo(address usuario) external view returns (uint256) {
        return creditos[usuario];
    }

    function sacar(uint256 valor) external {
        require(creditos[msg.sender] >= valor, "saldo insuficiente");
        creditos[msg.sender] -= valor;
        (bool success, ) = payable(msg.sender).call{value: valor}("");
        require(success, "Transferencia falhou...");
        emit Saque(msg.sender, valor);
    }
}