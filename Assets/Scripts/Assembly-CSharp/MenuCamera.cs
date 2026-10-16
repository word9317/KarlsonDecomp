using UnityEngine;

public class MenuCamera : MonoBehaviour
{
    private Vector3 startPos;
    private Vector3 optionsPos = new Vector3(0f, 3.6f, 8f);
    private Vector3 playPos = new Vector3(1f, 4.6f, 5.5f);
    private Vector3 aboutPos = new Vector3(1f, 5.5f, 5.5f);
    
    private Vector3 desiredPos;
    private Quaternion desiredRot;

    private Quaternion startRot;
    private Quaternion optionsRot;
    private Quaternion playRot;
    private Quaternion aboutRot;

    public float moveSpeed = 5f;
    public float rotSpeed = 5f;

    private void Start()
    {
        startPos = transform.position;
        desiredPos = startPos;
        
        optionsPos += startPos;
        playPos += startPos;
        aboutPos += startPos;

        startRot = transform.rotation;
        desiredRot = startRot;

        optionsRot = startRot * Quaternion.Euler(0f, 0f, 0f);
        playRot = startRot * Quaternion.Euler(0f, 90f, 0f);
        aboutRot = startRot * Quaternion.Euler(-90f, 0f, 0f);
    }

    private void Update()
    {
        transform.position = Vector3.Lerp(transform.position, desiredPos, Time.deltaTime * moveSpeed);
        transform.rotation = Quaternion.Slerp(transform.rotation, desiredRot, Time.deltaTime * rotSpeed);
    }

    public void Options()
    {
        desiredPos = optionsPos;
        desiredRot = optionsRot;
    }

    public void Main()
    {
        desiredPos = startPos;
        desiredRot = startRot;
    }

    public void Play()
    {
        desiredPos = playPos;
        desiredRot = playRot;
    }

    public void About()
    {
        desiredPos = aboutPos;
        desiredRot = aboutRot;
    }
}