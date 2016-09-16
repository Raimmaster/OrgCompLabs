//int inst_pines[] = {22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37};//15 bits
int flags_pines[] = {38, 39, 40};//14 bits
int register_pines[] = {42,43,44,45,46,47,48, 49};
int register_addr[] = {50,51};
//int we_pin = 52;
//int finish_pin = 41;
//int addr_pin[] = {2,3,4,5,6,7,8,9};
//int addr = 0;
int flags[3];
 
void setup() {
  Serial.begin(9600);
  for (int i = 0; i < 15; i++) {
    if (i < 3) {
      if(i < 2)
        pinMode(register_addr[i], OUTPUT);
      pinMode(flags_pines[i], INPUT);
    }
    if(i < 8)
      pinMode(register_pines[i], INPUT);
    //pinMode(inst_pines[i], OUTPUT);
  }
  //pinMode(we_pin, OUTPUT);
//  pinMode(finish_pin, OUTPUT);
  Serial.println("Ingrese instruccion: ");
}

String DecToBin(int number)
{
  if ( number == 0 ) return "0";
  if ( number == 1 ) return "1";
 
  if ( number % 2 == 0 )
    return DecToBin(number / 2) + "0";
  else
    return DecToBin(number / 2) + "1";
}
/*
int InstToInt(String inst){
  int inst_int = 0;
  if(inst == "add"){
    inst_int = 1;
  }else if(inst == "sub"){
    inst_int = 2;
  }else if(inst == "or"){
    inst_int = 3;
  }else if(inst == "and"){
    inst_int = 4;
  }else if(inst == "xor"){
    inst_int = 5;
  }else if(inst == "mov"){
    inst_int = 6;
  }else if(inst == "lw"){
    inst_int = 7;
  }else if(inst == "sw"){
    inst_int = 8;
  }else if(inst == "li"){
    inst_int = 9;
  }else if(inst == "addi"){
    inst_int = 10;
  }else if(inst == "subi"){
    inst_int = 11;
  }else if(inst == "cmp"){
    inst_int = 12;
  }else if(inst == "jz"){
    inst_int = 13;
  }else if(inst == "jnz"){
    inst_int = 14;
  }else if(inst == "jg"){
    inst_int = 15;
  }else if(inst == "jl"){
    inst_int = 16;
  }else if(inst == "jump"){
    inst_int = 17;
  }
  return inst_int;
}*/

void leerRegistros(String instruccion[3]){
  Serial.print("Leyendo registro: ");
  Serial.print(instruccion[1]);
  Serial.print(" ");
  String dir = DecToBin(instruccion[1].toInt());
  Serial.print(dir);
  Serial.print(" ");
  while(dir.length() < 2)
    dir = "0" + dir;
  for(int i = 0; i < 2; i++){
    digitalWrite(register_addr[i], dir[1-i] == '1' ? HIGH : LOW);
    Serial.print(dir[i]);   
  }

  Serial.println();
  
  delay(150);
  int data_in = 0;
  for (int i = 0; i < 8; i++) {
    int pot = pow(2, i);
    int lectura = digitalRead(register_pines[i]);
    data_in += pot * lectura;
    Serial.print(">> ");
    Serial.println(lectura);
  }
  delay(100);
  Serial.print(instruccion[1]);
  Serial.print(": ");
  Serial.println(data_in);
  
  Serial.println("Registro Leido");
}
 
void loop() {
  delay(200);
  //Declaracion de Variables
  String instruccion[] = {"","",""};
  int index = 0;
  int we = 1;
  bool continuar = false;
  String rd = "", rs = "";
  String n = "";
  String L = "";
  String N = "";
 
  //Extrayendo Informacion de Instrucciones
  while (Serial.available() > 0) {
    char temp = Serial.read();
    if(temp == ' '){
      index++;
      continue;
    }
    instruccion[index] += temp;
    continuar = true;
  }

  if(!continuar)
    return;
  /*for(int i = 0; i < 3; i++)
    Serial.println(instruccion[i]);
  */
  String inst = instruccion[0];
  /*if(inst == "finish" || addr > 255){
    digitalWrite(we_pin, LOW);
    digitalWrite(finish_pin, HIGH);
    return;
  }else */if(inst == "read"){
    leerRegistros(instruccion);
    return;
  }

  return;
 /* int inst_int = InstToInt(inst);
  if(inst_int == 0)
    return;
  String inst_bin = DecToBin(inst_int);

  Serial.println(inst_bin);
  
  rd = DecToBin(instruccion[1].toInt());
  rs = DecToBin(instruccion[2].toInt());

  while(rd.length() < 2){
    rd = "0" + rd;
  }
  while(rs.length() < 2){
    rs = "0" + rs;
  }
  while(inst_bin.length() < 5){
    inst_bin = "0" + inst_bin;
  }
  
  L = rd;
  N = rs;
  while(N.length() < 8){
    N = "0" + N;
  }
  while(L.length() < 8){
    L = "0" + L;
  }
  
  String fpga = "";
  if (inst_int > 0){
    if (inst_int < 9 || inst_int == 12){
      //Serial.println("Debo mandar rd y rs mas 7 bits en ceros");
      fpga += inst_bin + rd + rs + "0000000";
      Serial.println(fpga);
    }else if(inst_int < 12){
      //Serial.println("Debo mandar rd y N mas 1 bits en ceros");
      fpga += inst_bin + rd + N + "0";
      Serial.println(fpga);
    }else{
      //Serial.println("Debo mandar L mas 3 bits en ceros");
      fpga += inst_bin + L + "000";
      Serial.println(fpga);
    }
  }
  digitalWrite(we_pin, we);

//  String addr_bin = DecToBin(addr);
  while(addr_bin.length() < 8)
    addr_bin = "0" + addr_bin;

  
  
  for(int i = 0; i < 16; i++){
    if(i<8)
      digitalWrite(addr_pin[i], addr_bin[i]);
    //digitalWrite(inst_pines[i], fpga[i] == '1' ? HIGH : LOW);
  }
//  addr+=1;
  return;
 
  delay(100);
  //Extrayendo estado de los flags
  for(int i=0; i<3; i++){
      flags[i] = digitalRead(flags_pines[i]);
  }
 
  delay(100);
  Serial.print("isZero: ");
  Serial.println(flags[0]);
  Serial.print("Sign: ");
  Serial.println(flags[1]);
  Serial.print("OverFlow:");
  Serial.println(flags[2]);
 
  Serial.println("------------------------------");
  Serial.println();
  */
}
