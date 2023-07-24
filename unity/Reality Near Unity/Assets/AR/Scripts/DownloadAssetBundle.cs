using System.IO;
using UnityEngine;
using UnityEngine.Networking;
using System.Collections;
using FlutterUnityIntegration;
using System;

public class DownloadAssetBundle : MonoBehaviour
{

    const String API_REALITY_NEAR_IMGs = "https://api.realitynear.org";

    void Start()
    {
        Debug.Log("En Vuforia");
        GetComponent<UnityMessageManager>().SendMessageToFlutter("downloadAssetBundle");

    }

    Vector3 StringToVector3(String scale)
    {
        return new Vector3(float.Parse(scale.Split(",")[0]), float.Parse(scale.Split(",")[1]), float.Parse(scale.Split(",")[2]));
    }
    Quaternion StringToQuaternion(String val)
    {
        return new Quaternion(float.Parse(val.Split(",")[0]), float.Parse(val.Split(",")[1]), float.Parse(val.Split(",")[2]), float.Parse(val.Split(",")[3]));
    }



    public IEnumerator DownloadAssetBundleFromServer(String assetData)
    {
        GameObject go = null;
        String url = API_REALITY_NEAR_IMGs + assetData.Split(" | ")[0];
        String scale = assetData.Split(" | ")[1];
        String position = assetData.Split(" | ")[2];
        String rotation = assetData.Split(" | ")[3];


        using (UnityWebRequest www = UnityWebRequestAssetBundle.GetAssetBundle(url))
        {
            yield return www.SendWebRequest();

            if (www.result != UnityWebRequest.Result.Success)
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
                bundle.Unload(false);
                yield return new WaitForEndOfFrame();
            }
            www.Dispose();
        }
        InstantiateGameObjectFromAssetBundle(go, scale, position, rotation);
    }

    private void InstantiateGameObjectFromAssetBundle(GameObject go, String scale, String position, String rotation)
    {
        if (go != null)
        {
            GameObject instenceGo = Instantiate(go);

            instenceGo.transform.position = Vector3.zero;
            instenceGo.transform.eulerAngles = StringToVector3(rotation);
            instenceGo.transform.localScale = StringToVector3(scale);
            instenceGo.transform.position = StringToVector3(position);
        }
        else
        {
            Debug.LogWarning("your asset bundle go is null");
        }
    }

}
