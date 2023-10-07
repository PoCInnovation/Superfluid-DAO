  import { useAccount, useConnect, useDisconnect } from 'wagmi'
  import { InjectedConnector } from 'wagmi/connectors/injected'

  const Profile = () => {
    const { address, isConnected } = useAccount()
    const { connect } = useConnect({
      connector: new InjectedConnector(),
    })
    const { disconnect } = useDisconnect()

    if (isConnected)
      return (
        <div>
          Connected to {address}
          <button onClick={() => disconnect()}>Disconnect</button>
        </div>
      )
    return <button className="btn btn-outline btn-success rounded-full" onClick={() => connect()}>Connect Wallet</button>
  }

  export default Profile;
