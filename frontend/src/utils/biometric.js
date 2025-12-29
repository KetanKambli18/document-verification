export async function verifyBiometricI(){
    if(!window.PublicKeyCredential){
        alert("Biometric authentication not supported.");
        return false;
    }

    try{
        const credential = await navigator.credentials.get({
            publicKey:{
                challenge: new Uint8Array(32),
                timeout: 60000,
                userVerification: "required",
            },
        });

        return credential !== null;
    }

    catch(err){
        console.error("Biometric authntication failed",err);
        return false;
    }
}