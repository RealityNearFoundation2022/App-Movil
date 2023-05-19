using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Dinosaur : MonoBehaviour
{
    //Variable para controlar la fuerza del salto - viene desde el inspector
    [SerializeField] private float upForce;
    [SerializeField] private Transform groundCheck;
    [SerializeField] private LayerMask ground;
    [SerializeField] private float radius;

    private Rigidbody2D dinoRb;
    private Animator dinoAnimator;
    // Start is called before the first frame update
    void Start()
    {
        dinoRb = GetComponent<Rigidbody2D>();
        dinoAnimator = GetComponent<Animator>();
        Debug.Log("HOLA Dinosaurio");
        Debug.Log("dinoRb es " + dinoRb.name);
    }

    // Update is called once per frame
    void Update()
    {
        bool isGrounded = Physics2D.OverlapCircle(groundCheck.position, radius, ground);
        dinoAnimator.SetBool("isGrounded", isGrounded);
        if (Input.touchCount > 0)
        {
            Debug.Log("Toco la pantalla");
            Debug.Log("isGrounded: "+ isGrounded.ToString());
            Debug.Log("dinoRb en toque es " + dinoRb.name);

            if (isGrounded)
            {
                //SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
                //Time.timeScale = 1f;
                dinoRb.AddForce(Vector2.up * 35);
            }

        }
    }


    private void OnDrawGizmos()
    {
        Gizmos.DrawWireSphere(groundCheck.position, radius);
    }

    private void OnCollisionEnter2D(Collision2D collision)
    {
        if(collision.gameObject.CompareTag("obstacle"))
        {
            DinoGameManager.Instance.ShowGameOverScreen();
            dinoAnimator.SetTrigger("die");
            Time.timeScale = 0f;
        }
    }
}
