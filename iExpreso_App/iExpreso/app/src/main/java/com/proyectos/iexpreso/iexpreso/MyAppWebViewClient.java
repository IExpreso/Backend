package com.proyectos.iexpreso.iexpreso;

import android.content.Intent;
import android.webkit.WebView;
import android.net.Uri;
import android.view.View;
import android.webkit.WebView;
import android.webkit.WebViewClient;

/**
 * Created by miguelcabral on 11/11/17.
 */

public class MyAppWebViewClient extends WebViewClient {

    public boolean shouldOverrideUrlLoading(WebView view, String url){

            view.loadUrl(url);
            return true;
        }
}