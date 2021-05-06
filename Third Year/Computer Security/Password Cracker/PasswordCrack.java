import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.Iterator;
import java.util.concurrent.CopyOnWriteArrayList;


public class PasswordCrack {
    public static CopyOnWriteArrayList <String> encryptedPasswords; // = new CopyOnWriteArrayList<String>();
    public static ArrayList<String> usernames; // = new ArrayList<>();

    // Reading in the dictionary and adding it to a list of possible words 
    public static ArrayList<String> readDict(String filename) throws FileNotFoundException{
        ArrayList<String> dictionary = new ArrayList<>();
        BufferedReader br = null;
        try {
            String strCurrentLine;
            br = new BufferedReader(new FileReader(filename));
            while ((strCurrentLine = br.readLine()) != null) {
                dictionary.add(strCurrentLine);
            }
        } catch(Exception e){
            System.out.println("Error reading from given file: " + filename);
            System.exit(1);
        }
        return dictionary;
    }



    // Reading in the password file, adding first/last names to possible words
    public static void readEncrpytPsswrd(String filename) throws FileNotFoundException{
        encryptedPasswords = new CopyOnWriteArrayList<String>();
        usernames = new ArrayList<String>();
        BufferedReader br = null;
        try {
            String strCurrentLine;
            br = new BufferedReader(new FileReader(filename));
            while ((strCurrentLine = br.readLine()) != null) {
                String[] arr = strCurrentLine.split(":");
                String passwordAndSalt = arr[1];
                String[] fullName = arr[4].split(" ");
                usernames.add(fullName[0]);
                usernames.add(fullName[fullName.length -1]);
                encryptedPasswords.add(passwordAndSalt);
            }
        } catch(Exception e){
            System.out.println("Error reading from file: " + filename);
            System.exit(1);
        }
    }


    public static void addCommonPasswords(ArrayList<String> wordsToGuess){
        wordsToGuess.add("1234");
        wordsToGuess.add("12345");
        wordsToGuess.add("123456");
        wordsToGuess.add("1234567");
        wordsToGuess.add("12345678");
        wordsToGuess.add("123456789");
        wordsToGuess.add("1234567890");
        wordsToGuess.add("admin");
        wordsToGuess.add("username");
        wordsToGuess.add("login");
        wordsToGuess.add("football");
        wordsToGuess.add("baseball");
        wordsToGuess.add("welcome");
        wordsToGuess.add("qwerty");
        wordsToGuess.add("dragon");
        wordsToGuess.add("master");
        wordsToGuess.add("monkey");
        wordsToGuess.add("unknown");
        wordsToGuess.add("sunshine");
        wordsToGuess.add("princess");
        wordsToGuess.add("iloveyou");
        wordsToGuess.add("solo");
        wordsToGuess.add("abc123");
        wordsToGuess.add("111111");
        wordsToGuess.add("1qaz2wsx");
        wordsToGuess.add("asdfgh");
        wordsToGuess.add("password123");
        wordsToGuess.add("password");
        wordsToGuess.add("cat");
        wordsToGuess.add("dog");
        wordsToGuess.add("letmein");
        wordsToGuess.add("qwertyuiop");
        wordsToGuess.add("starwars");
        wordsToGuess.add("sweden");
        wordsToGuess.add("cat");
        wordsToGuess.add("login");
        wordsToGuess.add("passw0rd");
    }

    public static void main(String[] args) throws FileNotFoundException {
        if(args.length!=2){
            System.out.println("Invalid input");
            System.exit(1);
        }
        File file = new File(args[0]);
        if(!file.exists()){
            System.out.println(args[0]+" does not exist");
            System.exit(1);
        }
        File file1 = new File(args[1]);
        if(!file1.exists()){
            System.out.println(args[1]+" does not exist");
            System.exit(1);
        }

        String dictionary = args[0];
        String encrypt_psswrd = args[1];
        ArrayList<String> wordsToGuess = new ArrayList<>();
        wordsToGuess = readDict(dictionary);
        readEncrpytPsswrd(encrypt_psswrd);
        wordsToGuess.addAll(usernames);
        addCommonPasswords(wordsToGuess);
        int numOfThreads = Runtime.getRuntime().availableProcessors();
        for(int i=0; i<numOfThreads;i++){
            final MyThread myThread = new MyThread(i, numOfThreads, wordsToGuess);
            myThread.start();
        }
    }

public static ArrayList<String> mangled(ArrayList <String> wordsToMangle){   
    ArrayList <String> mangledWords = new ArrayList <String>();
    char[] characters = "abcdefghijklmnopqrstuvwxyz".toCharArray();
    for (int i=0; i<wordsToMangle.size();i++){
        String word = wordsToMangle.get(i);
        if(word.length()!=0){
            // If a word is greater than 8 discussion forum: " doesn't matter what comes after the 8th character"
            if(word.length()<=8){
                mangledWords.add(checkPassword(deleteFirstChar(word)));
                mangledWords.add(checkPassword(deleteLastChar(word)));
                mangledWords.add(checkPassword(duplicate(word)));
                for(int j=0; j<characters.length; j++){
                    checkPassword(prepend(word, characters[j]));
                    checkPassword(append(word, characters[j]));
                    checkPassword(prependCap(word, characters[j]));
                    checkPassword(appendCap(word, characters[j]));
                }
                char[] numbers = "0123456789".toCharArray();
                for(int j=0; j<10; j++){
                    checkPassword(prepend(word, numbers[j]));
                    checkPassword(append(word, numbers[j]));
                }
            }

            mangledWords.add(checkPassword(reverse(word)));
            mangledWords.add(checkPassword(reflect(word)));
            mangledWords.add(checkPassword(reflect1(word)));
            mangledWords.add(checkPassword(uppercase(word)));
            mangledWords.add(checkPassword(lowercase(word)));
            mangledWords.add(checkPassword(capitalize(word)));
            mangledWords.add(checkPassword(ncapitalize(word)));
            mangledWords.add(checkPassword(toggleCase1(word)));
            mangledWords.add(checkPassword(toggleCase2(word)));
        }
    }
    return mangledWords;
 }



public static String checkPassword(String potential){
        Iterator<String> it = encryptedPasswords.iterator();
        while(it.hasNext()){
            // Hashing the encrypted password and the plain text password
            // results in the same hash if you encrypted the salt and plaintext password
            String password = it.next();
            String hashPass = jcrypt.crypt(password, potential);
            if(encryptedPasswords.contains(hashPass)){
                System.out.println(potential);
                encryptedPasswords.remove(hashPass);
            }
        }
        return potential;
    }

public static String prepend(String input, char c){
    return (input+c);
}

public static String append(String input, char c){
    return (c+input);
}

public static String prependCap(String input, char c){
    return (input+Character.toUpperCase(c));
}

public static String appendCap(String input, char c){
    return (Character.toUpperCase(c)+input);
}

public static String deleteFirstChar(String input){
    return (input.substring(1));
}

public static String deleteLastChar(String input){
    return ((input).substring(0, input.length() - 1));
}

public static String reverse(String input){
    return (new StringBuilder(input).reverse().toString());
}

public static String duplicate(String input){
    return (input+input);
}

public static String reflect(String input){
    return (input+new StringBuilder(input).reverse().toString());
}

public static String reflect1(String input){
    return (new StringBuilder(input).reverse().toString()+input);
}

public static String uppercase(String input){
    return (input.toUpperCase());
}


public static String lowercase(String input){
    return (input.toLowerCase());
}


public static String capitalize(String input){
    return (input.substring(0, 1).toUpperCase() + input.substring(1));
}

public static String ncapitalize(String input){
    return (input.substring(0, 1).toLowerCase() + input.substring(1).toUpperCase());
}

public static String toggleCase1(String input){
    String toggled_word = "";
    for(int i=0; i<input.length();i++){
        if(i%2==0){
            toggled_word+= input.substring(i, i+1).toUpperCase();
        }
        else{
            toggled_word+= input.substring(i, i+1).toLowerCase();
        }
    }
    return toggled_word;
}

public static String toggleCase2(String input){
    String toggled_word = "";
    for(int i=0; i<input.length();i++){
        if(i%2!=0){
            toggled_word+= input.substring(i, i+1).toUpperCase();
        }
        else{
            toggled_word+= input.substring(i, i+1).toLowerCase();
        }
    }
    return toggled_word;
}    

    static class MyThread extends Thread{
        int threadNum;
        int numOfThreads;
        ArrayList <String> fullDict;
        MyThread(int threadNum, int numOfThreads, ArrayList<String> fullDict){
            this.threadNum=threadNum;
            this.numOfThreads=numOfThreads;
            this.fullDict=fullDict;
        }

        public void run(){
            ArrayList <String> threadWords = new ArrayList<>();
            ArrayList <String> threadMangled = new ArrayList<>();
            for(int i=threadNum; i<fullDict.size(); i+=numOfThreads){
                PasswordCrack.checkPassword(fullDict.get(i).toString());
                threadWords.add(fullDict.get(i).toString());
            }
            threadMangled=mangled(threadWords);
            while(encryptedPasswords.size()!=0){
                threadMangled=mangled(threadMangled);
            }
        }
    }
}