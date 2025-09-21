<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"> 
</head>
<body>

  <h1>💳 ATM System in Assembly Language</h1>

  <div class="section">
    <h2>📘 Overview</h2>
    <p>This project simulates a basic ATM system using assembly language on the emu8086 emulator. It allows users to perform essential banking operations such as login authentication, balance inquiry, cash withdrawal, deposit, and exit. The project was developed as part of the Microprocessors and Microcontrollers Lab at Green University of Bangladesh.</p>
  </div>

  <div class="section">
    <h2>🎯 Features</h2>
    <ul>
      <li>Secure user authentication using masked PIN input</li>
      <li>Balance inquiry with real-time feedback</li>
      <li>Cash withdrawal with range validation</li>
      <li>Cash deposit with range validation</li>
      <li>Exit process with confirmation message</li>
      <li>Error handling for invalid account, password, and transaction amounts</li>
    </ul>
  </div>

  <div class="section">
    <h2>🛠️ Technology Stack</h2>
    <ul>
      <li><strong>Language:</strong> Assembly (emu8086)</li>
      <li><strong>Platform:</strong> DOS emulator</li>
      <li><strong>Tools:</strong> emu8086 IDE</li>
    </ul>
  </div>

  <div class="section">
    <h2>📂 Project Structure</h2>
    <ul>
      <li><code>ATM v2.1.asm</code> – Main assembly source code</li>
      <li><code>ATM_Micro_Project_Project.pdf</code> – Lab report documentation</li>
    </ul>
  </div>

  <div class="section">
    <h2>🖼️ Screenshots</h2>
    <p>Sample emulator outputs:</p>
    <ul>
      <li>Login Screen and 1st interface</li>
      <img src="first interface.png" alt="Login Screen" width="600" height="400">
      <li>Balance Inquiry</li>
      <img src="checkbal.png" alt="Balance Check" width="600" height="400" >
      <li>Withdraw and Deposit Transactions</li>
      <img src="withdraw.png" alt="Withdraw Process" width="600" height="400" >
    <img src="deposit.png" alt="Deposit Process" width="600" height="400" >
      <li>Error Messages for Invalid Inputs</li>
      <img src="wr_deposit.png" alt=""width="400" height="300">
      <img src="wrpassword.png" alt=""width="400" height="300">
    </ul>
    <!-- Replace with actual image paths if available -->
    
    
    
  </div>

  <div class="section">
    <h2>🚀 Getting Started</h2>
    <ol>
      <li>Install emu8086 IDE</li>
      <li>Open <code>ATM v2.1.asm</code> in the IDE</li>
      <li>Compile and run the program</li>
      <li>Follow on-screen prompts to simulate ATM operations</li>
    </ol>
  </div>

  <div class="section">
    <h2>📈 Performance Evaluation</h2>
    <ul>
      <li>Modular code structure with clear function separation</li>
      <li>Efficient memory usage and input validation</li>
      <li>Real-time feedback and error handling</li>
    </ul>
  </div>

  <div class="section">
    <h2>⚠️ Limitations</h2>
    <ul>
      <li>Hardcoded credentials and balances</li>
      <li>No graphical interface</li>
      <li>Limited scalability and multi-user support</li>
    </ul>
  </div>

  <div class="section">
    <h2>🔮 Future Enhancements</h2>
    <ul>
      <li>Graphical User Interface (GUI)</li>
      <li>Biometric authentication</li>
      <li>Dynamic data storage using files or databases</li>
      <li>Transaction history logging</li>
      <li>Multi-account support</li>
      <li>Mobile application integration</li>
    </ul>
  </div>

  <!-- <div class="section">
    <h2>👨‍💻 Authors</h2>
    <table>
      <tr><th>Name</th><th>ID</th></tr>
      <tr><td>Md. Sabbir Hossain</td><td>221902126</td></tr>
      <tr><td>Md. Israil Fakir</td><td>221902125</td></tr>
    </table>
  </div> -->

</body>
</html>
