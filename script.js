
// Script.js
let signer;
let cliente;
const clienteAddress = "0x8712F55cFdc49F2a056e5D572771a5E7a40158d0";
const clienteAbi ='[{"inputs":[],"name":"enviarDeposito","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"address","name":"_cofre","type":"address"}],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"string","name":"acao","type":"string"},{"indexed":false,"internalType":"address","name":"usuario","type":"address"},{"indexed":false,"internalType":"uint256","name":"valor","type":"uint256"}],"name":"Interacao","type":"event"},{"inputs":[{"internalType":"uint256","name":"valor","type":"uint256"}],"name":"requisitarSaque","outputs":[],"stateMutability":"nonpayable","type":"function"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"para","type":"address"},{"indexed":false,"internalType":"uint256","name":"valor","type":"uint256"}],"name":"Transferencia","type":"event"},{"inputs":[{"internalType":"address","name":"destino","type":"address"},{"internalType":"uint256","name":"valor","type":"uint256"}],"name":"transferirETH","outputs":[],"stateMutability":"nonpayable","type":"function"},{"stateMutability":"payable","type":"receive"},{"inputs":[],"name":"cofreEndereco","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"verMeuSaldo","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"}]'; //cole o ABI aqui
window.onload = async () => {
    if (window.ethereum) {
        provider = new ethers.BrowserProvider(window.ethereum);
        await provider.send("eth_requestAccounts", []);
        signer = await provider.getSigner();
        cliente = new ethers.Contract(clienteAddress, clienteAbi, signer);
    }   else {
        alert("MetaMask não detectado.");
}
};
async function enviarDeposito() {
    const valorETH = document.getElementById("valor").value;
    const tx = await cliente.enviarDeposito({ value: ethers.parseEther(valorETH) });
    await tx.wait();
    document.getElementById("resultado").innerText = `Deposito confirmado!`;
}
async function verSaldo() {
    const saldo = await cliente.verMeuSaldo();
    document.getElementById("resultado").innerText = ` Saldo atual:
     ${ethers.formatEther(saldo)} ETH`;
}
async function requisitarSaque() {
    const valorETH = document.getElementById("valor").value;
    const tx = await cliente.requisitarSaque(ethers.parseEther(valorETH));
    await tx.wait();
    document.getElementById("resultado").innerText = `Saque solicitado!`;
}