package com.iexpreso.proyectos.turnonoff;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

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
                 validate(user.getText().toString(), password.getText().toString());
            }
        });
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
