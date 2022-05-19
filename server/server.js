const express = require("express");
const { createServer } = require("http");
const { Server } = require("socket.io");
var mysql= require("mysql");
var fs = require('fs');
var FileReader = require('filereader');
const { isNullOrUndefined } = require("util");
const port=7000;
const app = express();
app.use(express.static('public'));
app.get('/',(req,res)=>{
    res.status(200).json({name:"server"});
})

const httpServer = createServer(app);
const io = new Server(httpServer, { 
    cors:{
        origin:"*",
        methods:["GET","POST"],
    },
 });
//

var connection = mysql.createConnection({
    "host":"localhost",
    "user":"root",
    "password":"",
    "database":"realtimechatapp"
});
connection.connect();
function toBase64(arr) {
    //arr = new Uint8Array(arr) if it's an ArrayBuffer
    return btoa(
       arr.reduce((data, byte) => data + String.fromCharCode(byte), '')
    );
 }
const users={};
io.on("connection", (socket) => {
  console.log('hi someone is connected: '+socket.id);
   //Logging In
   socket.on("login",(data)=>{
    //console.log(data.email+data.password);
    connection.query('SELECT id,name FROM users WHERE email = "'+data.email+'" AND password = "'+data.password+'"', function(err,rows, fields) {
        if (err) throw err;
        if(rows.length == 0) {
        socket.emit('retuLogIn',null);
        } 
        else {
        socket.emit('retuLogIn',{id:rows[0]['id'],name:rows[0]['name']});
        }
        
      });


    });
    //Check if username is unique
    socket.on("uniqueUsername",(username)=>{
        connection.query("select * from users where name ='"+username+"'",function(err,rows,fields){
            if (err) throw err;
            if(rows.length == 0) {
               socket.emit('returnUnique',true);
       } 
       else {
           socket.emit('returnUnique',false);

       }
    })
    })
    //Registration
    socket.on("register",(data)=>{
        //console.log(data.email+data.password);
        connection.query("INSERT INTO users (name,email,password) VALUES ('"+data.name+"','"+data.email+"','"+data.password+"')",function(err,rows,fields){
             if (err) throw err;
             if(rows.length == 0) {
                socket.emit('retuReg',false);
        } 
        else {
            socket.emit('retuReg',true);

        }
        })
    })
    //New User logged in
    socket.on("new_user",(username)=>{
        //console.log("??"+username);
           users[username]=socket.id;
           //Tell others who is online
           io.emit("all_users",users);
    })
    //Retrieveing old message
    socket.on("old_msgs",(user1,user2)=>{
        connection.query("select * from messages where (sender_name ='"+user1+"' AND receiver_name='"+user2+"') OR (sender_name ='"+user2+"' AND receiver_name='"+user1+"')",function(err,rows,fields){
            if (err) throw err;
            if(rows.length == 0) {
               socket.emit('returnOld',null);
       } 
       else {
           let msgs=[];
           let content,media=null,msg="";
        for (var i = 0; i < rows.length; i++) {
           // console.log(typeof rows[i]['attachment']);
            //console.log(!rows[i]['attachment']);
           
            if(rows[i]['attachment']!="null"){
            content = fs.readFileSync(`./public/${rows[i]['attachment']}`);
           // console.log("??");
           // console.log(toBase64(content));
            media={content:`data:image/png;base64,`+toBase64(content),image:true}
            rows[i]['msg']="";
            }
            var x ={sender:rows[i]['sender_name'],receiver:rows[i]['receiver_name'],msg:rows[i]['msg'],media,avatar:'0.png',viewed:true}
            msgs.push(x);
            media=null;
        }
        socket.emit('returnOld',msgs);
       }
    })
    })
    //Send Message
    socket.on("send_message",(data)=>{
        console.log(data);
        const socketID = users[data.receiver];
        io.to(socketID).emit("new_message",data);
        //
        let msg,med,file;
        if(data.media==null){
            msg=data.msg;
            med =null
        }
        else if(data.msg===''){
            med=data.media.name;
            msg=null
            fs.writeFileSync("./public/"+data.media.name, data.media.file);
        }
            connection.query("INSERT INTO messages (sender_name,receiver_name,msg,attachment) VALUES ('"+data.sender+"','"+data.receiver+"','"+msg+"','"+med+"')",function(err,rows,fields){
                    if (err) throw err;
                    if(rows.length == 0) {
                    //   socket.emit('returnUnique',false);
                  //  console.log("no")
               } 
               else {
                 //  socket.emit('returnUnique',false);
                // console.log("yes")
               }
            })

        
    
       
    })
    //Disconnecting
  socket.on("disconnect",()=>{
      console.log(socket.id+" disconnected");
      //When user close the tab (disconnect) remove it from users array
      for(let user in users){
          if(users[user]===socket.id){
              delete users[user];
          }
      }
      //Refresh list of users after if any one disconnected
      io.emit("all_users",users);
  })
  
  
 

});

httpServer.listen(port);