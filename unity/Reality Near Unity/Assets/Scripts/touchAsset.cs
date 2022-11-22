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
            Ray ray = Camera.main.ScreenPointToRay(Input.GetTouch(0).position);
            RaycastHit hit;
            if(Physics.Raycast(ray, out hit))
            {
                if (hit.collider.CompareTag("onlineAsset") || hit.collider.gameObject == gameObject || hit.collider.gameObject.tag == "onlineAsset")
                {
                    GetComponent<UnityMessageManager>().SendMessageToFlutter("touchAsset");
                }
            }
        }
    }
}
