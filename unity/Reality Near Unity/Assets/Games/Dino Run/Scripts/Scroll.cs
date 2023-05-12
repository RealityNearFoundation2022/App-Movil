using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Scroll : MonoBehaviour
{


    private float scrollSpeed = 5f;

    // Update is called once per frame
    void Update()
    {
        transform.Translate(Vector2.left * scrollSpeed * Time.deltaTime);
    }
}
