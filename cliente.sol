// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./interfaceICofre.sol";

contract Cliente {
    address public cofreEndereco;

    event Interacao(string acao, address usuario, uint256 valor);
    event Transferencia(address para, uint256 valor);

    constructor (address _cofre) {
        cofreEndereco = _cofre;
    }

    receive() external payable {}

    function enviarDeposito() external payable  {
        require(msg.value > 0, "precisa enviar algum ether");
        ICofre(cofreEndereco).depositar{value: msg.value}();
        emit Interacao("deposito", msg.sender, msg.value);
    }

    function verMeuSaldo() external view returns (uint256) {
        return ICofre(cofreEndereco).consultarSaldo(address(this));
    }

    function requisitarSaque(uint256 valor) external {
        ICofre(cofreEndereco).sacar(valor);
        emit Interacao("saque", msg.sender, valor);
    }

    function transferirETH(address destino, uint256 valor) external {
        require(destino != address(0), "Endereco destino invalido");
        require(address(this).balance >= valor, "Saldo insuficiente no contrato");
        
        payable(destino).transfer(valor);
        emit Transferencia(destino, valor);
    }
}