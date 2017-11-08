package com.iexpreso.proyectos.turnonoff;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Build;
import android.provider.Settings;
import android.support.annotation.NonNull;
import android.support.annotation.RequiresApi;
import android.support.v4.app.ActivityCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.github.nkzawa.emitter.Emitter;
import com.github.nkzawa.socketio.client.IO;
import com.github.nkzawa.socketio.client.Socket;

import org.json.JSONException;
import org.json.JSONObject;

import java.net.URISyntaxException;

public class MainActivity extends AppCompatActivity {

    private Button encender;
    private Button apagar;
    private TextView coordenates;
    private LocationManager locationManager;
    private LocationListener locationListener;
    private Socket mSocket;
    private String userName;


    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        this.userName = LoginActivity.getUserName();
        Toast.makeText(getApplicationContext(), "Bienvenido " + this.userName, Toast.LENGTH_SHORT).show();

        try {
            mSocket = IO.socket("http://localhost");
        } catch (URISyntaxException e) {}

        mSocket.connect();


        encender = (Button) findViewById(R.id.ON);
        encender.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Log.i("My Tag", "This is my first log");
            }
        });

        apagar = (Button) findViewById(R.id.OFF);
        apagar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                locationManager.removeUpdates(locationListener);
                Toast.makeText(getApplicationContext(), "Desactivado", Toast.LENGTH_SHORT).show();
                onDestroy();
            }
        });

        coordenates = (TextView) findViewById(R.id.COORDENATES);

        locationManager = (LocationManager) getSystemService(LOCATION_SERVICE);
        locationListener = new LocationListener() {
            @Override
            public void onLocationChanged(Location location) {
                coordenates.setText("\n " + location.getLatitude() + ", " + location.getLongitude());

                JSONObject obj = new JSONObject();
                try {
                    obj.put("Nombre", userName);
                } catch (JSONException e) {
                    e.printStackTrace();
                }
                try {
                    obj.put("Latitud", location.getLatitude());
                } catch (JSONException e) {
                    e.printStackTrace();
                }
                try {
                    obj.put("Longitud", location.getLongitude());
                } catch (JSONException e) {
                    e.printStackTrace();
                }
                mSocket.emit("Coordenates", obj);
            }

            @Override
            public void onStatusChanged(String s, int i, Bundle bundle) {

            }

            @Override
            public void onProviderEnabled(String s) {

            }

            @Override
            public void onProviderDisabled(String s) {
                Intent intent = new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
                startActivity(intent);
            }
        };
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            requestPermissions(new String []{
                    Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.INTERNET
            }, 10);
            return;
        }else{
            configureButton();
        }

    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        switch(requestCode) {
            case 10:
                if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    configureButton();
                }
        }
    }

    private void configureButton() {
        encender.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                locationManager.requestLocationUpdates("gps", 3000, 0, locationListener);
                Toast.makeText(getApplicationContext(), "Activado", Toast.LENGTH_SHORT).show();
            }
        });
    }


    public void onDestroy() {
        super.onDestroy();

        mSocket.disconnect();
    }

}
