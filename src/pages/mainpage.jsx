//dependencies
import React, { Component } from 'react'
import { BrowserRouter as Router, Route, Link, Switch } from "react-router-dom";
import ReactBootstrap, { Navbar, Container, Nav, Button,  Form, Col, Row,DropdownButton} from 'react-bootstrap'
//includes
import '../App.css';
//import MainContract from "../contract/MainContract.json"
//contract address
import { MainContract_ABI, MainContract_ADDRESS } from '../config_maincontract.js'
//components
import getWeb3 from '../getWeb3'
import DropdownMenu from 'react-bootstrap/esm/DropdownMenu';
import DropdownItem from 'react-bootstrap/esm/DropdownItem';

//Run maincontract
/* 執行 deposit and withdraw 的畫面，還會顯示使用者錢包、合約地址、合約餘額、備援機制設定的帳號密碼(檢查用)  */ 
class MainPage extends Component {
    componentDidMount() {
        //window.location.reload(); 
        this.loadBlockchainData()
    }

    async loadBlockchainData() {
        //web3
        const web3 = await getWeb3();
        //netid
        const netId = await web3.eth.net.getId();
        this.setState({ netid: netId })
        //wallet accounts
        const accounts = await web3.eth.getAccounts()
        this.setState({ account: accounts[0] })

        /*
        error
        const deployedNetwork = MainContract.networks[netId];
        const contract_address = MainContract.networks[netId].address;
        */

        //main contract
        const mainContract = new web3.eth.Contract(MainContract_ABI, MainContract_ADDRESS)
        //const mainContract = new web3.eth.Contract(MainContract.abi, MainContract.networks[netId].address)
        this.setState({ mainContract })
        const contract_address = MainContract_ADDRESS;
        //const contract_address = mainContract.networks[netId].address;
        this.setState({ contract_address })

        //view contract data
        const balance = await mainContract.methods.getBalance().call()
        this.setState({ balance })
        const owners = await mainContract.methods.getOwners().call()
        this.setState({ owners })
        const email = await mainContract.methods.getEmail().call()
        this.setState({ email })
        const password = await mainContract.methods.getPassword().call()
        this.setState({ password })
    }
    constructor(props) {
        super(props)
        this.state = {
        account: '',
        contract_address:'',
        balance: 0,
        email: '',
        password: ''
        }
        this.Deposit = this.Deposit.bind(this);
        this.Withdraw = this.Withdraw.bind(this);
        
    }
    async Deposit(Amount) {
        this.state.mainContract.methods.deposit().send({ value: Amount.toString(), from: this.state.account })
        .once('receipt', (receipt) => {
            this.refreshPage()
    })}
    async Withdraw(Amount) {
        this.state.mainContract.methods.withdraw(Amount).send({ from: this.state.account })
        .once('receipt', (receipt) => {
            // alert(receipt)
            this.refreshPage()
        })
        .once('error', (error) => {
            // alert(error)
        })
    }
    async refreshPage() { 
        window.location.reload()
    }
    render() {
        return (
        <div id="navbar">
            <Navbar bg="light" variant="light">
                <Container>
                <Nav className="mr-auto">
                <Nav.Link href="/">Main</Nav.Link>
                <DropdownButton variant="light" id="dropdown-basic-button" title="Create">
                        <DropdownItem href="/Backup">Back-up</DropdownItem>
                        <DropdownItem href="/TestaManage">Testamentary</DropdownItem>
                </DropdownButton>
                <DropdownButton variant="light" id="dropdown-basic-button" title="Activate">
                        <DropdownItem href="/ActivateBackup">Back-up</DropdownItem>
                </DropdownButton>
                </Nav>
                <Navbar.Toggle />
                <Navbar.Collapse className="justify-content-end">
                    <Navbar.Text>
                    Signed in as: <a href="https://beautygang.fr/">Beauty</a>
                    </Navbar.Text>
                </Navbar.Collapse>
                </Container>
            </Navbar>
        <div className="App">
            <br></br>
            <h1><b>Hello, user !</b></h1>
            <br></br>
            <p><b>Wallet account:</b> {this.state.account}</p>
            <p><b>Contract address:</b> {this.state.contract_address}</p>
            <p><b>Contract balance:</b> {this.state.balance / 10**18} ether</p>
            <p><b>*Contract email:</b> {this.state.email}</p>
            <p><b>*Contract password:</b> {this.state.password}</p>
            <br></br>
            <div id="ether">
                <div>
                <Form>
                    <Form.Group id="ether">
                        <Row>
                        <Col md={{ span: 4, offset: 4 }}>
                        <Form.Label><b>Deposit or Withdraw Ether</b></Form.Label></Col>
                        <Col md={{ span: 2, offset: 5 }}>
                                <Form.Control
                                    id="Amount"
                                    ref={(input) => { 
                                        this.amount = input
                                    }} 
                                    type="number"  
                                    placeholder="Add ETH" 
                                    required/>
                            </Col>
                        </Row>
                    </Form.Group>
                    <br></br>
                    <Button variant="warning" onClick={(event) => {
                        event.preventDefault()
                        this.Deposit(this.amount.value * 10**18)
                    }}>Deposit</Button>{' '}
                    <Button  variant="secondary" onClick={(event) => {
                        event.preventDefault()
                        this.Withdraw(this.amount.value)
                    }}>Withdraw</Button>
                </Form>
                </div>
                {/* <button><a href='/Backup'>back</a></button> */}
            </div>    
        </div>
        </div>
        );
    }
}

export default MainPage;

/*<Nav.Link href="/">Main</Nav.Link>
                <Nav.Link href="/Backup">Create</Nav.Link>
                <Nav.Link href="/ActivateBackup">Activate</Nav.Link>
                <Nav.Link href="/TestaManage">Testamentary</Nav.Link>*/
