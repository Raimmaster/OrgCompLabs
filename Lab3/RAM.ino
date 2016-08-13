
void setup(){
  Serial.begin(9600);
  for(int i = 0; i < 4; i++){
    pinMode(i+10, OUTPUT);
    pinMode(i+4, OUTPUT);
    pinMode(i+50, INPUT);
  }
  pinMode(8, OUTPUT);
  Serial.println("Ingrese instruccion:");
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

void loop(){
  int write_enable = 0;
  String addr;
  String data;
  String instruccion;
  int index = 0;
  bool continuar = false;
  while (Serial.available() > 0){
    char temp = Serial.read();
    if(temp == ' '){
      index = index + 1;
    }
    if(index == 0){
      instruccion += temp;
    }else if(index == 1){
      addr += temp;
    }else{
      data += temp;
    }
    continuar = true;
  }
  delay(100);
  if(!continuar)
    return;
  addr.trim();
  data.trim();
  
  /*Serial.print(instruccion);
  Serial.println();
  Serial.print(addr);
  Serial.println();
  Serial.print(data);
  Serial.println();
  */

  //Convirtiendo a Bits
  int addri = addr.toInt();
  int datai = data.toInt();

  String addrb = DecToBin(addri);
  int addrs = addrb.length();;

  int rellenar = 4 - addrs;
  String mascara = "";
  for(int i = 0; i < rellenar; i ++){
    mascara+="0";
  }
  mascara.trim();
  addrb = mascara + addrb;

  Serial.print("Address: ");
  Serial.print(addrb);
  Serial.println();

  String datab = DecToBin(datai);
  int datas = datab.length();

  rellenar = 4 - datas;
  mascara = "";
  for(int i = 0; i < rellenar; i ++){
    mascara+="0";
  }
  mascara.trim();
  datab = mascara + datab;

  Serial.print("Data: ");
  Serial.print(datab);
  Serial.println();
  

  for(int i = 0; i < 4; i++){
    digitalWrite(13-i, addrb[i] == '1' ? HIGH : LOW);
  }

  if(instruccion == "write"){
    for(int i = 0; i < 4; i++){
      digitalWrite(7-i, datab[i] == '1' ? HIGH : LOW);
    }
  }

  digitalWrite(8, instruccion == "write" ? HIGH : LOW);

  delay(100);

  if(instruccion == "read"){
    int data_in=0;
    for(int i = 0; i < 4; i++){
      int pot = pow(2, 3-i);
      int lectura = digitalRead(i+50);
      data_in += pot*lectura;
      //Serial.println(">> " + lectura);
    }
    delay(100);
    Serial.print("Lectura: ");
    Serial.println(data_in);
  }
  Serial.println();
}