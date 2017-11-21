package com.iexpreso.proyectos.turnonoff;

import android.content.Intent;
import android.media.session.MediaSession;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import org.json.JSONObject;

import java.io.DataInput;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class LoginActivity extends AppCompatActivity {

    private EditText user;
    private EditText password;
    private Button go;
    private static String userName;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        user = (EditText) findViewById(R.id.User);
        password = (EditText) findViewById(R.id.Password);
        go = (Button) findViewById(R.id.IR);

        go.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                 //validate(user.getText().toString(), password.getText().toString());
                 sendPost(user.getText().toString(), password.getText().toString());
            }
        });
    }

    public void sendPost(final String user, final String password) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    URL url = new URL("http://10.43.50.250:3000/login");
                    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                    conn.setRequestMethod("POST");
                    conn.setRequestProperty("Content-Type", "application/json;charset=UTF-8");
                    conn.setRequestProperty("Accept", "application/json");
                    conn.setDoOutput(true);
                    conn.setDoInput(true);

                    JSONObject jsonParam = new JSONObject();
                    jsonParam.put("email", user);
                    jsonParam.put("password", password);

                    Log.i("JSON", jsonParam.toString());
                    DataOutputStream os = new DataOutputStream(conn.getOutputStream());
                    //os.writeBytes(URLEncoder.encode(jsonParam.toString(), "UTF-8"));
                    os.writeBytes(jsonParam.toString());


                    os.flush();
                    os.close();


                    InputStream in = conn.getInputStream();
                    InputStreamReader inputStreamReader = new InputStreamReader(in);

                    String postData = "";

                    int inputStreamData = inputStreamReader.read();
                    while (inputStreamData != -1) {
                        char currentData = (char) inputStreamData;
                        inputStreamData = inputStreamReader.read();
                        postData += currentData;
                    }

                    Log.i("STATUS", postData);

                    if(String.valueOf(conn.getResponseCode()).equals("200")){
                        String token = new JSONObject(postData).getString("token");
                        Intent intent = new Intent(LoginActivity.this, MainActivity.class);
                        intent.putExtra("token", token);
                        startActivity(intent);
                    }
                    else{
                        Toast.makeText(getApplicationContext(), "Reintentar", Toast.LENGTH_SHORT).show();
                    }


                    Log.i("STATUS", String.valueOf(conn.getResponseCode()));
                    Log.i("MSG", conn.getResponseMessage());

                    conn.disconnect();
                } catch (Exception e) {
                    e.printStackTrace();
                    //Toast.makeText(getApplicationContext(), e.getMessage(), Toast.LENGTH_SHORT).show();
                }
            }
        });

        thread.start();
    }


    private void validate(String user, String password){

        if(user.equals("Miguel") && password.equals("1234")){
            this.userName = user;
            Intent intent = new Intent(LoginActivity.this, MainActivity.class);
            startActivity(intent);
        }
        else{
            Toast.makeText(getApplicationContext(), "Reintentar", Toast.LENGTH_SHORT).show();
        }
    }

    public static String getUserName(){
        return userName;
    }

}
