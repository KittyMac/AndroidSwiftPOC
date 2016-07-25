package com.smallplanet.arbiter;

import android.app.Activity;
import android.widget.TextView;
import android.os.Bundle;


public class Arbiter extends Activity
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

        /* Create a TextView and set its content.
         * the text is retrieved by calling a native
         * function.
         */
        TextView  tv = new TextView(this);
        tv.setText( ArbiterMain("Hello World From Java") );
        setContentView(tv);
    }

	// Native methods defined in Arbiter.c
	private static native String ArbiterMain(String name);
	
    static {
		
		System.loadLibrary("c++_shared");
		System.loadLibrary("scudata");
		System.loadLibrary("scuuc");
		System.loadLibrary("scui18n");
		System.loadLibrary("swiftCore");
		System.loadLibrary("swiftGlibc");
		
		//System.loadLibrary("swiftSwiftOnoneSupport");
			
        System.loadLibrary("arbiter");
    }
}
