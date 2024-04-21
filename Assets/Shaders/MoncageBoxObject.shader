//Inbox Target Shader
Shader "MoncageBoxObject"
{
	Properties
	{
		_Color0("Main Color", Color) = (1,1,1,0)
		_MainTex("Main Texture", 2D) = "white" {}
		_StencilRef2Show("Stencil Ref 2 Show", Range(0,6)) = 0  // 0: not show, 1: show
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		Stencil
		{
			Ref [_StencilRef2Show]
			Comp Equal // compare the stencil buffer value with the reference value
		}
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color0;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			o.Albedo = ( _Color0 * tex2D( _MainTex, uv_MainTex ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
}