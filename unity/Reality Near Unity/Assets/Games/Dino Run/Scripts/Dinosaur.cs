using System.Collections;
using System.Collections.Generic;
using UnityEngine;

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
    }

    // Update is called once per frame
    void Update()
    {
        bool isGrounded = Physics2D.OverlapCircle(groundCheck.position, radius, ground);
        dinoAnimator.SetBool("isGrounded", isGrounded);

        //Detecta cuando hay un toque en la pantalla
        if (Input.touchCount > 0)
        {
            //Hcer un Salto, si esta tocando el piso
            if (isGrounded) { 
                dinoRb.AddForce(Vector2.up * upForce);
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
            dinoAnimator.SetTrigger("Die");
            Time.timeScale = 0f;
        }
    }
}
