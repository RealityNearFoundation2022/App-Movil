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

    Vector3 StringToVector3(String scale){
        return new Vector3(float.Parse(scale.Split(",")[0]), float.Parse(scale.Split(",")[1]), float.Parse(scale.Split(",")[2]));
    }
    Quaternion StringToQuaternion(String val)
    {
        return new Quaternion(float.Parse(val.Split(",")[0]), float.Parse(val.Split(",")[1]), float.Parse(val.Split(",")[2]), float.Parse(val.Split(",")[3]));
    }

    public IEnumerator DownloadAssetBundleFromServer(String assetData)
    {
        GameObject go = null;
        String url = assetData.Split(" | ")[0];
        String scale = assetData.Split(" | ")[2];
        String position = assetData.Split(" | ")[3];
        String rotation = assetData.Split(" | ")[4];


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
        InstantiateGameObjectFromAssetBundle(go, scale,position,rotation);
    }

    private void InstantiateGameObjectFromAssetBundle(GameObject go, String scale, String position, String rotation)
    {
        if(go!=null){
            GameObject instenceGo = Instantiate(go);
            
            instenceGo.transform.position = Vector3.zero;
            //sacale object
            // instenceGo.transform.localScale = new Vector3(10f,10f,10f);
            // instenceGo.transform.rotation = new Quaternion(0, 180, 180,0);
            instenceGo.transform.rotation = StringToQuaternion(rotation);
            // instenceGo.transform.position = new Vector3(0f, 0f, 0.6f);
            instenceGo.transform.localScale = StringToVector3(scale);
            instenceGo.transform.position = StringToVector3(position);
        }
        else {
            Debug.LogWarning("your asset bundle go is null");
        }
    }

}
