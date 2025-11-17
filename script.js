 const posts = {
  1:`<h2>Learning Embedded Systems</h2>
     <p>I began my embedded journey with simple Arduino projects like blinking LEDs. Over time, I explored sensors, communication protocols like I2C and UART, and even moved on to ESP32 for Wi-Fi and Bluetooth connectivity. The key lesson: start small, experiment, and build step by step.</p>` ,
  2:`<h2>LoRa for IoT Projects</h2>
     <p>LoRa is great for low-power, long-range communication in IoT. By combining LoRa with microcontrollers, we can build smart agriculture systems, environmental monitors, and even emergency alert systems. Its cost efficiency makes it ideal for large-scale deployment.</p>` ,
  3:`<h2>Vehicle Simulation with SUMO</h2>
     <p>SUMO (Simulation of Urban Mobility) is an open-source tool that models traffic flow. It helps researchers test algorithms for smart cities, traffic lights, and VANET communication. By linking SUMO with NS2, we can simulate both mobility and network behavior.</p>`
};

function openPost(id){
  document.getElementById('modalContent').innerHTML = posts[id];
  document.getElementById('modal').style.display='block';
}
function closePost(){
  document.getElementById('modal').style.display='none';
}
function login(){
  let u=document.getElementById('username').value;
  let p=document.getElementById('password').value;
  if(u==='student'&&p==='pass123') alert('Login successful 🎉');
  else alert('❌ Invalid credentials');
} 
