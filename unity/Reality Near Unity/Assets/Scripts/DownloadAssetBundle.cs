 using System.IO;
using UnityEngine;
using UnityEngine.Networking;
using System.Collections;
using FlutterUnityIntegration;
using System;

public class DownloadAssetBundle : MonoBehaviour
{
    // public string url = "https://drive.google.com/u/0/uc?id=1L-QRUZDxhXM74csegJi4p7UIl1zp-8N-&export=download";
    // Start is called before the first frame update
    // void start()
    // {
    //    StartCoroutine(DownloadAssetBundleFromServer());
    // }

    public IEnumerator DownloadAssetBundleFromServer(String assetData)
    {
        GameObject go = null;
        String url = assetData.Split(" | ")[0];


        using (UnityWebRequest www = UnityWebRequestAssetBundle.GetAssetBundle(url))
        {
            yield return www.SendWebRequest();

            if(www.isNetworkError || www.isHttpError)
            {
                Debug.Log(www.error);
            }
            else
            {
                AssetBundle bundle = DownloadHandlerAssetBundle.GetContent(www);
                go = bundle.LoadAsset(bundle.GetAllAssetNames()[0]) as GameObject;
                go.tag = "onlineAsset";
                go.AddComponent<touchAsset>();
                go.AddComponent<UnityMessageManager>();
                go.AddComponent<BoxCollider>();
                go.AddComponent<Collider>();
                bundle.Unload(false);
            yield return new WaitForEndOfFrame();            }
            www.Dispose();
        }
        InstantiateGameObjectFromAssetBundle(go);
    }

    private void InstantiateGameObjectFromAssetBundle(GameObject go)
    {
        if(go!=null){
            GameObject instenceGo = Instantiate(go);
            
            instenceGo.transform.position = Vector3.zero;
            //sacale object
            instenceGo.transform.localScale = new Vector3(10f,10f,10f);
            instenceGo.transform.rotation = new Quaternion(0, 180, 180,0);
            instenceGo.transform.position = new Vector3(0f, 0f, 0.6f);
           


        }
        else {
            Debug.LogWarning("your asset bundle go is null");
        }
    }

}
