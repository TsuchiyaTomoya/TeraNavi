package ttc.util;

import java.util.UUID;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public abstract class UniqueKeyGenerator{
    public static String generateKeys(){
    
        String uId = UUID.randomUUID().toString();

        


        return uId;
    }
    
    public static String getHashCode(String uId){

        MessageDigest md5 = null;
        
        try{
            md5 = MessageDigest.getInstance("MD5");
        }catch(NoSuchAlgorithmException e){
            e.printStackTrace();
        }
        
        md5.update(uId.getBytes());
        byte[] hash = md5.digest();
        
        String mdStr = hexString(hash);
        
        
        
        
        return mdStr;
    }
    
    private static String hexString(byte[] bin){
        String str = "";
        int size = bin.length;
        
        for(int i = 0;i < size;i++){
            int n = bin[i];
            if(i < 0){
                n += 256;
            }
            String hex = Integer.toHexString(n);
            
            if(hex.length() == 1){
                hex = "0" + hex;
            }
            
            str += hex;
        }
        
        return str;
    }
}
