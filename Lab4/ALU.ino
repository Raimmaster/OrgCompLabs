int data1[] = {10, 11, 12, 13};
int data2[] = {4, 5, 6, 7};
int resultado[] = {30, 31, 32, 33};
int operacion[] = {50, 51, 52};
 
void setup(){
  Serial.begin(9600);
  for(int i = 0; i < 4; i++){
    pinMode(data1[i], OUTPUT);
    pinMode(data2[i], OUTPUT);
    pinMode(resultado[i], INPUT);
    if(i < 3)
      pinMode(operacion[i], OUTPUT);
  }
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
  //Declaracion de Variables
  String data1;
  String data2;
  String instruccion;
  int index = 0;
  bool continuar = false;
  //Final Declaracion de Variables
 
  //Extrayendo Informacion de Instruccion y Datas
  while (Serial.available() > 0){
    char temp = Serial.read();
    if(temp == ' '){
      index = index + 1;
    }
    if(index == 0){
      instruccion += temp;
    }else if(index == 1){
      data1 += temp;
    }else{
      data2 += temp;
    }
    continuar = true;
  }
  delay(100);
  if(!continuar)
    return;
  //Final Extrayendo Informacion de Instruccion y Datas
 
  //Convirtiendo a Bits
  //Data1
  int data1i = data1.toInt();
  String data1b = DecToBin(data1i);
  int data1s = data1b.length();;
 
  int rellenar = 4 - data1s;
  String mascara = "";
  for(int i = 0; i < rellenar; i ++){
    mascara+="0";
  }
  data1b = mascara + data1b;
 
  //Data2
  int data2i = data2.toInt();
  String data2b = DecToBin(data2i);
  int data2s = data2b.length();;
 
  rellenar = 4 - data2s;
  mascara = "";
  for(int i = 0; i < rellenar; i ++){
    mascara+="0";
  }
  data2b = mascara + data2b;
  //Final Conversion a Bits
 
  //Impresion de Datas
  Serial.print("Data1: ");
  Serial.print(data1b);
  Serial.println();
 
  Serial.print("Data2: ");
  Serial.print(data2b);
  Serial.println();
  //Final impresion de Datas
 
  //Data1 to FPGA
  for(int i = 0; i < 4; i++){
    digitalWrite(13-i, data1b[i] == '1' ? HIGH : LOW);
  }
 
  //Data2 to FPGA
  for(int i = 0; i < 4; i++){
    digitalWrite(7-i, data2b[i] == '1' ? HIGH : LOW);
  }
 
  /*
   * Operacion to FPGA
   * add
   * sub
   * and
   * or
   * xor
   */
   String ope = "";
   if(instruccion == "add")
    ope = "000";
   else if(instruccion == "sub")
    ope = "001";
  else if(instruccion == "and")
    ope = "010";
  else if(instruccion == "or")
    ope = "011";
  else
    ope = "100";
  if(ope == ""){
    Serial.println("Salio del ciclo");
    return;
  }
   for(int i = 0; i < 3; i++){
     digitalWrite(operacion[i], ope[i] == '1' ? HIGH : LOW);
   }
 
  delay(100);
 
  int data_in=0;
  for(int i = 0; i < 4; i++){
    int pot = pow(2, 3-i);
    int lectura = digitalRead(i+30);
    data_in += pot*lectura;
    Serial.print(">> ");
    Serial.println(lectura);
  }
  delay(100);
  Serial.print("Lectura: ");
  Serial.println(data_in);
 
  Serial.println("------------------");
  Serial.println();
}