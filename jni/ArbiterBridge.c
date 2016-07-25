#include <string.h>
#include <jni.h>
#include <stdint.h>
#include <stdio.h>

// Unfortunately this has to be hand-generated for now...
#define SWIFT_ARBITER _TF7Arbiter7ArbiterFSSSS


char * SWIFT_ARBITER(char *);

jstring Java_com_smallplanet_arbiter_Arbiter_ArbiterMain(JNIEnv*  env, jobject thiz, jstring inputString)
{
	char * jsonString = (char *)(*env)->GetStringUTFChars(env, inputString, 0);
	
	jsonString = SWIFT_ARBITER(jsonString);
	
	return (*env)->NewStringUTF(env, jsonString);
}

