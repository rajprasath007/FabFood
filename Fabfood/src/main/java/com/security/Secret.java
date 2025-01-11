package com.security;

public class Secret {
	
	private static final long key = 3851224383L;
	
	private static final int intKey = 940722;
	
	public static int encrypt(int plainValue) {
        return plainValue ^ intKey;
    }

	public static int decrypt(int encryptedValue) {
    	return encryptedValue ^ intKey;
    }
	
	public static long encrypt(long plainValue) {
        return plainValue ^ key;
    }

	public static long decrypt(long encryptedValue) {
    	return encryptedValue ^ key;
    }
	
    public static String encrypt(String plainText) {
    	String encryptedText = "";
    	for(int i = 0 ; i < plainText.length() ; i++) {
    		encryptedText += (char)(plainText.charAt(i)+12);
    	}
        return encryptedText;
    }

    public static String decrypt(String encryptedText) {
    	String decryptedText = "";
    	for(int i = 0 ; i < encryptedText.length() ; i++) {
    		decryptedText += (char)(encryptedText.charAt(i)-12);
    	}
        return decryptedText;
    }
}

