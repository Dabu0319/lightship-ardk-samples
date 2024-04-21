using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Launcher : MonoBehaviour
{
    public GameObject _prefab;
    public float speed = 5.0f; // 物体的速度

    void Update()
    {
#if UNITY_EDITOR
        if (Input.GetMouseButtonDown(0))
#else
        if (Input.touchCount > 0 && Input.GetTouch(0).phase == TouchPhase.Began)
#endif
        {
            // 在摄像机前面生成物体
            var pos = Camera.main.transform.position;
            var cameraForward = Camera.main.transform.forward;
            GameObject thing = Instantiate(_prefab, pos + (cameraForward * 0.1f), Quaternion.identity);

            // 计算从摄像机到点击位置的方向
            Vector3 direction = GetDirectionTowardsClick();
            
            // 使用协程移动物体
            StartCoroutine(MoveTowardsDirection(thing, direction));
        }
    }

    Vector3 GetDirectionTowardsClick()
    {
#if UNITY_EDITOR
        Vector3 mousePos = Input.mousePosition;
#else
        Vector3 mousePos = Input.GetTouch(0).position;
#endif
        mousePos.z = 10.0f; // 假设一个适当的距离
        Vector3 worldPos = Camera.main.ScreenToWorldPoint(mousePos);
        return (worldPos - Camera.main.transform.position).normalized;
    }

    IEnumerator MoveTowardsDirection(GameObject thing, Vector3 direction)
    {
        float elapsedTime = 0;
        while (elapsedTime < 5f) // 物体移动5秒
        {
            thing.transform.position += direction * speed * Time.deltaTime;
            elapsedTime += Time.deltaTime;
            yield return null;
        }
    }
}