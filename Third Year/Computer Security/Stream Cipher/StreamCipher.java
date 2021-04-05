import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Random;
import java.util.Scanner;

public class StreamCipher {
    public static Random setRandSeed(String key){
        Random random = new Random();
        try{
            Long seed = Long.parseLong(key);
            random = new Random(seed);
        }catch(NumberFormatException e){
            System.out.println("Key was not a number!!!!");
            System.exit(1);
        }
        return random;
    }
   public static void encrypt(String fileName, String key, String output, int bound) throws FileNotFoundException{
        try {
            // Checking files: Check input to make sure I can read from it and check output to make sure I can write to it.
            File outputCheck = new File(output);
            File inputCheck = new File(fileName);
            //System.out.println("---------------->"+ inputCheck.exists());
            //System.out.println("---------------->"+ inputCheck.canRead());
            if (outputCheck.exists()){
                if(!outputCheck.canWrite()){
                    System.out.println("The file does exist but you cannot write to it!");
                    System.exit(1);
                }
            }
            if(inputCheck.exists()){
                if(!inputCheck.canRead()){
                    System.out.println("You do not have permission to read the input file!");
                    System.exit(1);
                }
            }else{
                System.out.println("Input file does not exist!");
                System.exit(1);
            }
            

            Random random = setRandSeed(key);
            FileOutputStream outputFile = new FileOutputStream(output);
            FileInputStream input = new FileInputStream(fileName);
            System.out.println("Data in the file xor: ");
            int i = input.read();
           while(i != -1) {
               //System.out.println("Initial Input: "+(char)i + "("+i+")");
               int randomByte = random.nextInt(bound);
               //System.out.println("Rand Byte: "+randomByte);
               int xorValue = i^randomByte;
               //System.out.println("XORed Result: "+xorValue);
               outputFile.write(xorValue);
               i=input.read();
            }
            input.close();
            outputFile.close();
         }
         catch(Exception e) {
            System.out.print("Cannot Read from input file!");
         }
      }
    public static void main(String[] args) throws FileNotFoundException {
        System.out.println("Starting");
        // Reading in the parameters -> Need to do checks to make sure they are good
        String key = args[0];
        String infile = args[1];
        String output = args[2];
        if(infile.equals(output)) {
            System.out.println("Input file is the same as output file");
            System.exit(1);
        } 
        encrypt(infile, key, output, 256);
    }
        
}
