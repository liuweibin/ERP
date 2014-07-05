package com.erp.core.web.util;

import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Signature;
import java.security.SignatureException;
import java.security.spec.KeySpec;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;



public class SHA1WithRSA {
    SHA1WithRSA() {
        init();
    }

    public static void main(String[] args){
        new SHA1WithRSA();
    }
    
    private void init() {
        prepare();
        doSenderWork();
        doReceiverWork();
    }

    // share by sender and receiver
    Signature sign = null;
    // belong to sender,it visible to sender and receiver
    PublicKey publicKey = null;
    // belong to sender,it is only visible to sender
    PrivateKey privateKey;

    private void prepare() {
        KeyPairGenerator keyGen = null;
        try {
            // 实例化一个RSA算法的公钥/私钥对生成器
            keyGen = KeyPairGenerator.getInstance("RSA");
        } catch (NoSuchAlgorithmException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        int keysize = 1024;
        // 设置公钥/私钥对的长度
        keyGen.initialize(keysize);
        // 生成一个RSA算法的公钥/私钥
        KeyPair keyPair = keyGen.generateKeyPair();
        privateKey = keyPair.getPrivate();
        publicKey = keyPair.getPublic();
        System.out.println("privateKey:"+new String(Base64.encode(privateKey.getEncoded()))+"\n,该Key可以保留在服务端");
        System.out.println("publicKey:"+new String(Base64.encode(publicKey.getEncoded()))+"\n,该Key可以保留在客户端");
        try {
            // 实例化一个用SHA算法进行散列，用RSA算法进行加密的Signature.
            sign = Signature.getInstance("SHA1WithRSA");
        } catch (NoSuchAlgorithmException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        //publicKey 字符串生成PublicKey对象方法
        String pub=new String(Base64.encode(publicKey.getEncoded()));
        try {
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            KeySpec ks = new X509EncodedKeySpec(Base64.decode(pub));
            publicKey=keyFactory.generatePublic(ks);
            String temp_pub=new String(Base64.encode(publicKey.getEncoded()));
            System.out.println("publicKey 生成校验成功？"+(pub.equals(temp_pub)));
        } catch (Exception e) {
            System.err.println(e.toString());
            e.printStackTrace();
        }
        
        //privateKey 字符串生成PrivateKey对象方法
        String pri=new String(Base64.encode(privateKey.getEncoded()));
        try {
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            KeySpec ks = new PKCS8EncodedKeySpec(Base64.decode(pri));
            privateKey=keyFactory.generatePrivate(ks);
            String temp_pri=new String(Base64.encode(privateKey.getEncoded()));
            System.out.println("privateKey 生成校验成功？"+(pri.equals(temp_pri)));
        } catch (Exception e) {
            System.err.println(e.toString());
            e.printStackTrace();
        }
    }

    void doSenderWork() {
        String words = "This is robin.How are you?";
        Message msg = new Message(words.getBytes());
        try {
            // 设置加密散列码用的私钥
            sign.initSign(privateKey);
        } catch (InvalidKeyException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        try {
            // 设置散列算法的输入
            sign.update(msg.getBody());
        } catch (SignatureException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        byte data[] = null;
        try {
            // 进行散列，对产生的散列码进行加密并返回
            data = sign.sign();
        } catch (SignatureException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        // 把加密后散列（即签名）加到消息中
        msg.setSignature(data);
        // 发送消息
        sendMsg(msg);
    }

    Message sendingMsg;

    void sendMsg(Message sendMsg) {
        sendingMsg = sendMsg;
        System.out.println("sending Message:"+new String(sendingMsg.getBody())+"signature:"+new String(Base64.encode(sendingMsg.getSignature())));
    }

    void doReceiverWork() {
        // 收到消息
        Message msg = getReceivedMsg();
        try {
            // 设置解密散列码用的公钥。
            sign.initVerify(publicKey);
        } catch (InvalidKeyException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        try {
            // 设置散列算法的输入
            sign.update(msg.getBody());
        } catch (SignatureException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        try {
            /*
             * 进行散列计算，比较计算所得散列码是否和解密的散列码是否一致。 一致则验证成功，否则失败
             */
            if (sign.verify(msg.getSignature())) {
                System.out.println("数字签名验证成功！"+new String(msg.getSignature()));
            } else {
                System.out.println("数字签名验证失败！");
            }
        } catch (SignatureException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    Message getReceivedMsg() {
        System.out.println("receiving Message"+new String(sendingMsg.getBody()));
        return sendingMsg;
    }
}

class Message {
    private byte[] body;
    private byte[] signature;

    Message(byte data[]) {
        body = data;
    }

    byte[] getBody() {
        return body;
    }

    byte[] getSignature() {
        return signature;
    }

    void setSignature(byte data[]) {
        signature = data;
    }
}