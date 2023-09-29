import Web3 from "web3"; // Importez Web3.js ici

const ConnectWallet = () => {
  const handleConnectWallet = async () => {
    if ((window as any).ethereum) {
      try {
        // Demander l'accès au compte MetaMask
        const accounts = await (window as any).ethereum.request({
          method: "eth_requestAccounts",
        });

        // Créer une instance Web3 pour interagir avec MetaMask
        const web3 = new Web3((window as any).ethereum);

        // Vous pouvez maintenant utiliser web3 pour interagir avec le réseau Ethereum
        // Par exemple, obtenir le compte connecté
        const connectedAccount = accounts[0];
        console.log("Connected account:", connectedAccount);

        // Vous pouvez également appeler des fonctions Ethereum ici
        // Par exemple : const balance = await web3.eth.getBalance(connectedAccount);

      } catch (error) {
        console.error("Error connecting to MetaMask:", error);
      }
    } else {
      console.error("MetaMask not detected.");
    }
  };

  return (
    <div>
      {/* Bouton pour activer la connexion au portefeuille */}
      <button onClick={handleConnectWallet}>Connect Wallet</button>
      {/* ... */}
    </div>
  );
};

export default ConnectWallet;
