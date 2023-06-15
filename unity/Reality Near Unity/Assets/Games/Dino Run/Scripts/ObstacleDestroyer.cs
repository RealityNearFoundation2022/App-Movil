using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObstacleDestroyer : MonoBehaviour
{

    [SerializeField] private GameObject[] obstacles;
    // Start is called before the first frame update
    void Start()
    {
    }



    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.gameObject.CompareTag("obstacle")) { 
            Destroy(collision.gameObject);
        }
    }

}
