using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Random = System.Random;

public class BallDetect : MonoBehaviour
{
    public Material planeMaterial;
    public Material targetBallMaterial;
    void Start()
    {
        planeMaterial = GetComponent<Renderer>().material;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Cube"))
        {
            //destroy the cube
            //Destroy(other.gameObject);
            //change random color
            
            //planeMaterial.SetColor( "_Color", UnityEngine.Random.ColorHSV());
            //change target ball material random color
            
            Color worldColor = UnityEngine.Random.ColorHSV();
            
            planeMaterial.SetColor("_color", worldColor);
            
            //set the other object material to the plane material
            other.gameObject.GetComponent<Renderer>().material = targetBallMaterial;
            targetBallMaterial.SetColor("_Color0", worldColor);
            
            
            
        }
    }
}
