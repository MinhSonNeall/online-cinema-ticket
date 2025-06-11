/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Constant;

/**
 *
 * @author HP
 */
public class IConstant {
    public static final String GOOGLE_CLIENT_ID = "266099726397-t6uec8o1gni790qbt50cip54ur00dq1o.apps.googleusercontent.com";

    public static final String GOOGLE_CLIENT_SECRET = "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";

    public static final String GOOGLE_REDIRECT_URI = "http://localhost:9999/OnlineCinemaTicket/loginGoogle";

    public static final String GOOGLE_GRANT_TYPE = "authorization_code";

    public static final String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";

    public static final String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";   
    
    //ket noi database
    
    public static final String DB_NAME = "movie_ticketing";
    public static final String DB_USER_NAME = "root";
    public static final String DB_PASSWORD = "123456"; // sua mk cua b
    public static final String DB_URL = "jdbc:mysql://localhost:3306/ "
            + IConstant.DB_NAME + "?autoReconnect=true&useSSL=false";
    public static final String DB_CLASSFORNAME = "com.mysql.cj.jdbc.Driver";

        


    
    
}
