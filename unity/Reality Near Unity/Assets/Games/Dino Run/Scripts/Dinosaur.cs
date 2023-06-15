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
    }

    // Update is called once per frame
    void Update()
    {
        bool isGrounded = Physics2D.OverlapCircle(groundCheck.position, radius, ground);
        dinoAnimator.SetBool("isGrounded", isGrounded);
        if (Input.touchCount > 0 && isGrounded)
        {
            dinoRb.velocity = Vector2.up * upForce;
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
