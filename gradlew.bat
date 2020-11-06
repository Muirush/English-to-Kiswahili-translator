package com.simon.smartmechanic;

import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.firestore.DocumentReference;
import com.google.firebase.firestore.FirebaseFirestore;

import java.util.HashMap;
import java.util.Map;

public class driverSignup extends AppCompatActivity {
    public static final String TAG = "TAG";
    private EditText edu1,edu2, edu3, edu4,edu5,edu6;
    private Button btnS;
    private FirebaseAuth Fauth;
    private FirebaseFirestore FFbs;
    String userIds;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_driver_signup);
        edu1 = (EditText) findViewById(R.id.DnameI);
        edu2 = (EditText) findViewById(R.id.DphoneI);
        edu3 = (EditText) findViewById(R.id.DidI);
        edu4 = (EditText) findViewById(R.id.DemailI);
        edu5 = (EditText) findViewById(R.id.DpassI);
        edu6 = (EditText) findViewById(R.id.DpassI2);
        btnS = (Button) findViewById(R.id.btnCreateAccountD);
        Fauth =  FirebaseAuth.getInstance();
        FFbs = FirebaseFirestore.getInstance();
        if (Fauth.getCurrentUser() != null){
            startActivity(new Intent(getApplicationContext(),driverPanel.class));
            finish();
        }

        btnS.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

               final String Dname = edu1.getText().toString().trim();
               final String Dphone = edu2.getText().toString().trim();
               final String Did = edu3.getText().toString().trim();
               final String Demail = ed