  import { useAccount, useConnect, useDisconnect } from 'wagmi'
  import { InjectedConnector } from 'wagmi/connectors/injected'

  const Profile = () => {
    const { isConnected } = useAccount()
    const { connect } = useConnect({
      connector: new InjectedConnector(),
    })
    const { disconnect } = useDisconnect()

    if (isConnected)
      return (
        <div>
          <button className="btn btn-outline btn-success rounded-full" onClick={() => disconnect()}>disconnect</button>
        </div>
      )
    return <button className="btn btn-outline btn-success rounded-full" onClick={() => connect()}>Connect Wallet</button>
  }

  export default Profile;
