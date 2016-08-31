int op_pines[] = {24, 25, 28, 29, 32};//2 bits
int flags_pines[] = {33, 34, 35, 38, 42, 43, 44, 45, 48, 49, 50, 51, 22, 23};//14 bits
int flags[14];

void setup() {
  Serial.begin(9600);
  for (int i = 0; i < 14; i++) {
    if (i < 5) {
      pinMode(op_pines[i], OUTPUT);
    }
    pinMode(flags_pines[i], INPUT);
  }
  Serial.println("Ingrese operacion(5 bits, en caso introducir menos, se tomaran como los menos significativos):");
}

void loop() {
  delay(200);
  //Declaracion de Variables
  String op = "";
  bool continuar = false;

  //Extrayendo Informacion de Instrucciones
  while (Serial.available() > 0) {
    char temp = Serial.read();
    op += temp;
    continuar = true;
  }
  if(!continuar)
    return;

  Serial.print("Operacion: ");
  Serial.println(op);
  
  Serial.print("Datos");  
  delay(1000);
  for(int i=4; i>0; i--){
    digitalWrite(op_pines[i], op[i] == '1' ? HIGH : LOW);
  }
  Serial.println("");
  
  delay(1000);
  //Extrayendo estado de los flags
  for(int i=0; i < 14; i++){
      flags[i] = digitalRead(flags_pines[i]);
  }

  delay(100);
  //33, 34, 35, 38, 42, 43, 44, 45, 48, 49, 50, 51, 22, 23
  Serial.print("reg Write: "); //33
  Serial.println(flags[0]);
  Serial.print("is Move: "); //34
  Serial.println(flags[1]);
  Serial.print("is Mem Access:"); //35
  Serial.println(flags[2]);
  Serial.print("is immediate: "); //38
  Serial.println(flags[3]);
  Serial.print("ALU function: "); //42, 43, 44
  Serial.print(flags[4]);
  Serial.print(flags[5]);
  Serial.println(flags[6]);
  Serial.print("flags write: "); //45
  Serial.println(flags[7]);
  Serial.print("dm write enable: "); //48
  Serial.println(flags[8]);
  Serial.print("js jz: ");//49
  Serial.println(flags[9]);
  Serial.print("is jnz: ");//50
  Serial.println(flags[10]);
  Serial.print("js jl: ");//51
  Serial.println(flags[11]);
  Serial.print("is jg: ");//22
  Serial.println(flags[12]);
  Serial.print("is jump: ");//23
  Serial.println(flags[13]);

  Serial.println("------------------------------");
  Serial.println();
}
