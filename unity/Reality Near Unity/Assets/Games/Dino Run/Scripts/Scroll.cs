using System.Collections;
using System.Collections.Generic;
using UnityEngine.SceneManagement;
using UnityEngine;

public class Scroll : MonoBehaviour
{

    // Update is called once per frame
    void Update()
    {
        transform.Translate(Vector2.left * DinoGameManager.Instance.GetScrollSpeed() * Time.deltaTime);
    }
}
