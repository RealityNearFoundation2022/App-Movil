using System.Collections;
using System.Collections.Generic;
using FlutterUnityIntegration;
using UnityEngine;

public class Screenshot : MonoBehaviour
{
    public void TakeScreenshot()
    {
        // Toma una captura de pantalla de la pantalla completa
        Texture2D tex = new Texture2D(Screen.width, Screen.height, TextureFormat.RGB24, false);
        tex.ReadPixels(new Rect(0, 0, Screen.width, Screen.height), 0, 0);
        tex.Apply();

        // Codifica la textura en formato PNG y convierte los datos en una cadena codificada en Base64
        byte[] bytes = tex.EncodeToPNG();
        string encoded = System.Convert.ToBase64String(bytes);

        // Destruye la textura
        Destroy(tex);

        // Envía la cadena codificada en Base64 al widget de Flutter
        UnityMessageManager.Instance.SendMessageToFlutter(encoded);
    }
}
