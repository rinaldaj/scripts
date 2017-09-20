use std::net::{TcpListener,TcpStream};
use std::io::Read;
use std::io::prelude::*;

fn handle_client(mut stream: TcpStream) {
    //do the thing
    let mut packet= [0;512] ;
    stream.read(&mut packet).unwrap();
   
   println!("connection established {}",String::from_utf8_lossy(&packet[..]));
    let response = String::from_utf8_lossy(&packet[..]);
    stream.write(response.as_bytes()).unwrap();
    stream.flush().unwrap();

}

fn main() {
    println!("starting server, ctrl-c to quit ");
    let listener = TcpListener::bind("127.0.0.1:8080").unwrap();
    for stream in listener.incoming(){
        handle_client(stream.unwrap());
    }
}
