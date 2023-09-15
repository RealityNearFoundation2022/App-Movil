using System.Collections;
using System.Collections.Generic;
using FlutterUnityIntegration;
using UnityEngine;

public class touchAsset : MonoBehaviour
{
    

    // Update is called once per frame
    void Update()
    {
        if(Input.touchCount>0 && Input.touches[0].phase == TouchPhase.Began)
        {
            GetComponent<UnityMessageManager>().SendMessageToFlutter("touchAsset");
        }
    }
}
