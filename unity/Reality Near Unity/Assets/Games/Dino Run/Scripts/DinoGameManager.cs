using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;

public class DinoGameManager : MonoBehaviour
{
    [SerializeField] private GameObject gameOverScreen;
    [SerializeField] private TMP_Text scoreTxt;
    [SerializeField] private float initialScrollSpeed;

    private int score;
    private float timer;
    private float scrollSpeed;

    public static DinoGameManager Instance { get; private set; }

    private void Awake()
    {
        if(Instance != null && Instance != this)
        {
            Destroy(this);
        } else
        {
            Instance = this;
        }
    }

    // Update is called once per frame
    void Update()
    {
        UpdateScore();
        UpdateSpeed();
    }

    public void ShowGameOverScreen()
    {
        gameOverScreen.SetActive(true);
    }

    public void RestartScene()
    {
        gameOverScreen.SetActive(false);
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        Time.timeScale = 1f;
    }

    private void UpdateScore()
    {
        int scorePerSeconds = 5;

        timer += Time.deltaTime;
        score = (int)(timer * scorePerSeconds);
        scoreTxt.text = string.Format("{0:0000000}", score);
    }

    public float GetScrollSpeed()
    {
        return scrollSpeed;
    }

    private void UpdateSpeed(){
        float speedDivider = 10f;
        scrollSpeed = initialScrollSpeed + timer/speedDivider;
    }
}
