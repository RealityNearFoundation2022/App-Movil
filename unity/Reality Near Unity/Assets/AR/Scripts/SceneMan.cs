using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneMan : MonoBehaviour
{
    public void LoadScene(string sceneName)
    {
        Debug.Log("cargando escena "+sceneName);

        SceneManager.LoadScene(sceneName);
    }

}
