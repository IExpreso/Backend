package com.iexpreso.proyectos.turnonoff;

import android.Manifest;
import android.annotation.SuppressLint;
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
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import io.socket.client.Ack;
import io.socket.client.IO;
import io.socket.client.Socket;
import io.socket.emitter.Emitter;

import org.json.JSONException;
import org.json.JSONObject;

import java.net.URISyntaxException;

public class MainActivity extends AppCompatActivity {

    private Button encender;
    private Button apagar;
    private Button logoff;
    private TextView coordenates;
    private TextView enabled;
    private Spinner rutas;
    private LocationManager locationManager;
    private LocationListener locationListener;
    private Socket socket;
    private String userName;
    private String ruta = "Chapultepec";
    private int changed = 0;
    private String token;


    @RequiresApi(api = Build.VERSION_CODES.M)

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        enabled = (TextView) findViewById(R.id.textViewEnabled);

        token = getIntent().getStringExtra("token");

        //Log.i("token", token);

        try {
            IO.Options opts = new IO.Options();
            opts.query = "token=" + token;
            socket = IO.socket("http://ec2-34-208-222-53.us-west-2.compute.amazonaws.com:3000/api/drive/" + ruta, opts);
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
        socket.on(Socket.EVENT_CONNECT, new Emitter.Listener() {

            @Override
            public void call(Object... args) {
                socket.emit("foo", "hi");
            }

        }).on("event", new Emitter.Listener() {

            @Override
            public void call(Object... args) {}

        }).on(Socket.EVENT_DISCONNECT, new Emitter.Listener() {

            @Override
            public void call(Object... args) {}

        }).on(Socket.EVENT_ERROR, new Emitter.Listener() {
            @Override
            public void call(Object... args) {
                 Toast.makeText(getApplicationContext(), "Error", Toast.LENGTH_SHORT).show();
            }
        });
        socket.connect();

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
                enabled.setBackgroundResource(R.color.colorOrange);
                socket.disconnect();
                enabled.setText("Apagado");

            }
        });

        rutas = (Spinner) findViewById(R.id.Ruta);
        rutas.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {
                Toast.makeText(MainActivity.this, adapterView.getSelectedItem().toString(), Toast.LENGTH_SHORT).show();
                ruta = adapterView.getSelectedItem().toString();
                socket.disconnect();


                try {
                    IO.Options opts = new IO.Options();
                    opts.query = "token=" + token;
                    socket = IO.socket("http://ec2-34-208-222-53.us-west-2.compute.amazonaws.com:3000/api/drive/" + ruta, opts);
                } catch (URISyntaxException e) {
                    e.printStackTrace();
                }
                socket.connect();
            }

            @Override
            public void onNothingSelected(AdapterView<?> adapterView) {

            }
        });

        logoff = (Button) findViewById(R.id.LogOff);
        logoff.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(MainActivity.this, LoginActivity.class);
                startActivity(intent);
                socket.disconnect();

            }
        });

        coordenates = (TextView) findViewById(R.id.COORDENATES);

        locationManager = (LocationManager) getSystemService(LOCATION_SERVICE);
        locationListener = new LocationListener() {

            public void onLocationChanged(Location location) {
                coordenates.setText("Coordenadas:\n" + location.getLatitude() + ", " + location.getLongitude() + "\n" + changed);
                Log.i("coordenates", location.getLatitude() + ", " + location.getLongitude());
                changed++;
                enabled.setBackgroundResource(R.color.colorGreen);
                enabled.setText("Encendido");

                JSONObject obj = new JSONObject();
                try {
                    obj.put("lat", location.getLatitude());
                    obj.put("lng", location.getLongitude());
                    socket.emit("update", obj);
                }
                catch (JSONException e) {
                    e.printStackTrace();
                }

            }

            public void onStatusChanged(String s, int i, Bundle bundle) {
            }

            public void onProviderEnabled(String s) {
            }

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
            public void onClick(View view) {
                coordenates.setText("Esperando...");
                locationManager.requestLocationUpdates("gps", 500, 0, locationListener);
                Toast.makeText(getApplicationContext(), "Activando", Toast.LENGTH_SHORT).show();
            }
        });
    }

    public void onDestroy() {
        super.onDestroy();

        socket.disconnect();
    }
}
