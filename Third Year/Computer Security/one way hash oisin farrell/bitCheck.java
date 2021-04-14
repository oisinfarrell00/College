public class bitCheck {
        public static char[] stringToCharArr(String input){
        input = input.toUpperCase();
        char[] ch = new char[input.length()];
        for (int i = 0; i < input.length(); i++) {
            ch[i] = input.charAt(i);
        }
        return ch;
    }

    public static String charToBinary(char[] input){
        String output = "";
        for(int i = 0; i<input.length; i++){
            switch(input[i]){
                case 'A':
                    output += "1010";
                    break;
                case 'B':
                    output += "1011";
                    break;
                case 'C':
                    output += "1100";
                    break;
                case 'D':
                    output += "1101";
                    break;
                case 'E':
                    output += "1110";
                    break;
                case 'F':
                    output += "1111";
                    break;
                case '0':
                    output += "0000";
                    break;
                case '1':
                    output += "0001";
                    break;
                case '2':
                    output += "0010";
                    break;
                case '3':
                    output += "0011";
                    break;
                case '4':
                    output += "0100";
                    break;
                case '5':
                    output += "0101";
                    break;
                case '6':
                    output += "0110";
                    break;
                case '7':
                    output += "0111";
                    break;
                case '8':
                    output += "1000";
                    break;
                case '9':
                    output += "1001";
                    break;
            }
        }
        return output;
    }
    public static int checkBits(char[] input1, char[] input2){
        int counter=0;
        for(int i=0; i<input1.length; i++){
            if(input1[i] == input2[i]){
                counter++;
            }
        }
        return counter;
    }
       public static void main(String[] args) {
        String hash1 = args[0];
        String hash2 = args[1];
        char[] h1 = stringToCharArr(hash1);
        char[] h2 = stringToCharArr(hash2);
        String h1Check = charToBinary(h1);
        String h2Check = charToBinary(h2);
        char[] binh1 = stringToCharArr(h1Check);
        char[] binh2 = stringToCharArr(h2Check);
        System.out.println("Similar bits: " + checkBits(binh1, binh2));   
    }
        
}
