//Box Six planes
Shader "MoncageBoxPlane"
{
	Properties
	{
		_color("Color", Color) = (1, 1, 1, 1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
		_planeStencilRef("PlaneStencilRef",Range(0,6))=0 // front1 left2 back3 right4 top5 bottom6
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry-5" }
		Cull Back
		ZWrite Off
		Stencil
		{
			Ref [_planeStencilRef]
			Pass Replace
		}
		
		//ColorMask 0
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow

		fixed4 _color;
		sampler2D _MainTex;
		half _Glossiness;
        half _Metallic;
		 
		struct Input
		{
			float2 uv_MainTex;
		};

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			fixed4 texColor = tex2D(_MainTex, i.uv_MainTex); 
            o.Albedo = texColor.rgb * _color.rgb; 
            o.Alpha = texColor.a * _color.a; 
			o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
			
		}



		ENDCG
	}


	Fallback "Diffuse"
}