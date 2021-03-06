package com.simon.smartmechanic;

import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.firestore.FirebaseFirestore;

public class driverLogin extends AppCompatActivity {
private EditText et1, et2;
private Button btButton;
private FirebaseAuth fAt;
    private FirebaseFirestore firebaseFirestore;
    private FirebaseAuth fireAuth;
    String userId;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_driver_login);

        et1 = (EditText)  findViewById(R.id.EmailDL);
        et2 = (EditText) findViewById(R.id.paswordInputD);
        btButton = (Button) findViewById(R.id.btn_loginD);
        fAt = FirebaseAuth.getInstance();
        if (fireAuth.getCurrentUser() != null){
            Intent inte = new Intent(driverLogin.this, driverPanel.class);
            startActivity(inte);
            finish();
        }
        btButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String Demail = et1.getText().toString().trim();
                String Dpass = et2.getText().toString().trim();
                if(TextUtils.isEmpty(Demail)){
                    et1.setError("Email required");
                    return;
                }
                if (TextUtils.isEmpty(Dpass)){
                    et2.setError("Password required");
                    return;
                }
                if(Dpass.length() < 6){
                    et2.setError("Password too short");
                    return;
                }

                else{
                    fAt.signInWithEmailAndPassword(Demail, Dpass).addOnCompleteListener(new OnCompleteListener<AuthResult>() {
                        @Override
                        public void onComplete(@NonNull Task<AuthResult> task) {
                            if (task.isSuccessful()){
                                Intent inte = new Intent(driverLogin.this, driverPanel.class);
                                startActivity(inte);
                                finish();
                            }

                        }
                    });

                }

            }
        });
    }

    public void dri(View view) {
        Intent intent = new Intent(driverLogin.this, driverSignup.class);
        startActivity(intent);
        finish();


    }
}

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      