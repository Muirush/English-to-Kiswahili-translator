package com.simon.group3languagetranslator;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.ml.common.modeldownload.FirebaseModelDownloadConditions;
import com.google.mlkit.nl.languageid.IdentifiedLanguage;
import com.google.mlkit.nl.languageid.LanguageIdentification;
import com.google.mlkit.nl.languageid.LanguageIdentificationOptions;
import com.google.mlkit.nl.languageid.LanguageIdentifier;
import com.google.mlkit.nl.translate.NaturalLanguageTranslateRegistrar;
import com.google.mlkit.nl.translate.TranslateLanguage;
import com.google.mlkit.nl.translate.Translation;
import com.google.mlkit.nl.translate.Translator;
import com.google.mlkit.nl.translate.TranslatorOptions;

public class MainActivity extends AppCompatActivity {
    TextView srcLang, tranLang,trans;
    EditText srcTxt;
    Button btTranslate;
    String stringSrc;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        srcLang = (TextView) findViewById(R.id.sourceLang);
        tranLang = (TextView) findViewById(R.id.TranslatedLang);
        trans = (TextView) findViewById(R.id.Translated);
        srcTxt = (EditText) findViewById(R.id.sourceText);
        btTranslate = (Button) findViewById(R.id.translate);
        btTranslate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                identifyLanguage();
            }
        });
    }

    private void identifyLanguage() {
        stringSrc = srcTxt.getText().toString();
        LanguageIdentifier identification = LanguageIdentification.getClient();
        tranLang.setText("Detecting");
        identification.identifyLanguage(stringSrc).addOnSuccessListener(new OnSuccessListener<String>() {
            @Override
            public void onSuccess(String s) {
                if (s.equals("und")){
                    Toast.makeText(MainActivity.this, "Language not detected", Toast.LENGTH_SHORT).show();
                }
                else{
                    getLanguageCode(s);
                }

            }
        });
    }

    private void getLanguageCode(String s) {
        String langCode;
        switch (s){
            case "en":
                langCode = TranslateLanguage.ENGLISH;
                tranLang.setText("English");
                break;
            case "sw":
                langCode = TranslateLanguage.SWAHILI;
                tranLang.setText("Swahili");
                break;

            default:
               langCode="";

        }
        translateText(langCode);
    }

    private void translateText(String langCode) {
        trans.setText("Translating...");
        TranslatorOptions options = new TranslatorOptions.Builder()
                //from lang
                .setSourceLanguage(langCode)
                //to lang
                .setTargetLanguage(TranslateLanguage.SWAHILI)

                .build();
       final   Translator translator = Translation.getClient(options);
         //Translator translator1 = LanguageIdentification.getClient().identifyLanguage(options);
        FirebaseModelDownloadConditions conditions =  new FirebaseModelDownloadConditions.Builder().build();
        translator.downloadModelIfNeeded( ).addOnSuccessListener(new OnSuccessListener<Void>() {
            @Override
            public void onSuccess(Void aVoid) {
            translator.translate(stringSrc).addOnSuccessListener(new OnSuccessListener<String>() {
                @Override
                public void onSuccess(String s) {
               trans.setText(s);
                }
            });
            }
        });




    }


}