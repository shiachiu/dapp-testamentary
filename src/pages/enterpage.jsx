//dependencies
import React, { Component } from 'react'
import { Button, Col} from 'react-bootstrap'
import ReactFullpage from '@fullpage/react-fullpage';
//includes
import '../App.css';
import Layout from '../layout';




class EnterPage extends Component {
    componentDidMount() {
        this.loadBlockchainData()
        
    }

    async loadBlockchainData() {
        
    }

    constructor(props) {
        super(props)
        this.state = {
        }
        // this.Deploy=this.Deploy.bind(this);
        
    }
    async refreshPage() { 
        window.location.reload()
    }

    
    /*
    <style>
					.button {
    				background-color: #4CAF50,
    				border: none,
    				color: white,
    				padding: 15px 32px,
    				text-align: center,
    				text-decoration: none,
    				display: inline-block,
    				font-size: 16px,
    				margin: 4px 2px,
    				cursor: pointer,
					}
				</style>
    */


    render() {
        return (
            <Layout>
                
            <div className="app">
                            <div class="welcome" >
                                <div class="r">
                                <p>WELCOME TO <b>CRYPTOTRUST</b><br></br>WE ARE HERE TO PROTECT YOUR <b>VIRTUAL ASSETS</b></p>
                                </div>
                            </div>
                            
                            <div class="about " >
                            
                                
                           
                            <div class="a">
                                <p class="b"><b>-About us-</b></p>
                                <br></br>
                                <br></br>
                                <p>We are <b>CryptoTrust</b>,<br></br>provides an Encrypted Trust, also stand as your <b>virtual wallet guardian</b></p>
                                <br></br>
                                <p>We use blockchain as our base to build up all the function,<br></br>therefore all the data is <b>decentralized and immutable.</b></p>
                                <br></br>
                                <br></br>
                                <br></br>
                                <br></br><br></br>
                                <p class="bl">Slide down to see more.</p>
                                
                            </div>
                            
                            </div>
                            
                            <div class="main ">
                            <div class="out big">
                                <p>What can we do with cryptotrust?</p>
                            </div>
                            <div class="article section2 center">
                                <p class="big">We have two main function:</p>
                                <br></br>
                                <div data-azbox="" data-gjs-type="agjc-box" id="leftenter">
                                    <div class="bimg center" ></div>
                                    <div class="big center" >Backup-mechanism</div>
                                </div>
                                <div data-azbox="" data-gjs-type="agjc-box" id="rightenter">
                                    <div class="wimg center"></div>
                                    <div class="big center">Testamentary </div>  
                                </div>
                                    
                                <div data-azbox="" data-gjs-type="agjc-box" id="leftenter" >
                                    
                                <p >You can set the backup contract in advance. <br></br>Once if you lost your wallet password, you can come here to activate the backup contract<br></br>Then all your virtual currency in the previous wallet will be return to your new wallet.</p>    
                                </div>

                                
                                <div id="rightenter" >
                                <br></br>
                                <p>The testament function is for people who are willing to distribute their property secretly.<br></br>Testators can add more than one beneficiaries with the customized percentage</p>
                                <p> (N.B. Each proportion of designated beneficiary should add up to 100% )</p>
                                          
                                </div>
                               
                                
                            </div>
                            </div>
                            
                            <div class="article section2  center">
                            <p class="big">By this two function, <br></br>we can ensure that all the virtual currency can be circulated, and not wasted</p>
                            <br></br>
                                <div id="leftenter">
                                <p>Create your own back-up mechanism or testamentary</p>
                                <Button class="button" href="/Main" variant="outline-warning">Create your own.</Button>
                                </div>
                                <div id="rightenter">
                                <p>Activate your own back-up mechanism or testamentary</p>
                                <Button href="/ActivateMain" variant="outline-warning">Activate.</Button>
                                </div>
                            </div>
                           
                                
                         
            </div>
            </Layout> 
        ) 
    }
}
export default EnterPage;

/*<Nav.Link href="/Backup">Create</Nav.Link>
<Nav.Link href="/ActivateBackup">Activate</Nav.Link>
<Nav.Link href="/TestaManage">Testamentary</Nav.Link>
 <Col md={{ span: 12 }}><h5><b>GVA(Guardian of Virtual Assets) gives your assets GVA(Gross value added)</b></h5></Col>*/