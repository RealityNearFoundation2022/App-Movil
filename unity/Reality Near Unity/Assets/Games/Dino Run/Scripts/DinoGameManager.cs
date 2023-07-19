using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;
using FlutterUnityIntegration;

public class DinoGameManager : MonoBehaviour
{
    [SerializeField] private GameObject gameOverScreen;
    [SerializeField] private TMP_Text scoreTxt;
    [SerializeField] private TMP_Text highScoreTxt;
    [SerializeField] private GameObject highScoreGO;
    [SerializeField] private float initialScrollSpeed;

    private int score;
    private float timer;
    private float scrollSpeed;

    public static DinoGameManager Instance { get; private set; }

    void Start()
    {
        GetComponent<UnityMessageManager>().SendMessageToFlutter("getHighScore");
    
    }

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
        scoreTxt.text = string.Format("{0:0}", score);
    }

    public float GetScrollSpeed()
    {
        return scrollSpeed;
    }

    public void getHighScore(string highScore) {
        Debug.Log("unity recibio: " + highScore);
        if (highScore != "") {
            highScoreTxt.text = "High Score: " + highScore;
            highScoreGO.SetActive(true);
        }
    }

    public void setHighScore() {
        int currentScore = int.Parse(scoreTxt.text);
        int highScore = int.Parse(highScoreTxt.text.Split(":")[1]);
        if (currentScore > highScore) {
            string message = "setHighScore - " + scoreTxt.text;
            GetComponent<UnityMessageManager>().SendMessageToFlutter(message);            
        }
    }

    private void UpdateSpeed(){
        float speedDivider = 11f;
        scrollSpeed = initialScrollSpeed + timer/speedDivider;
    }
}
