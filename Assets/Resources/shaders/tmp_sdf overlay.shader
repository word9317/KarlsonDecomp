Shader "TextMeshPro/Distance Field Overlay"
{
	Properties
	{
		_FaceTex ("Face Texture", 2D) = "white" {}
		_FaceUVSpeedX ("Face UV Speed X", Range(-5, 5)) = 0
		_FaceUVSpeedY ("Face UV Speed Y", Range(-5, 5)) = 0
		_FaceColor ("Face Color", Color) = (1,1,1,1)
		_FaceDilate ("Face Dilate", Range(-1, 1)) = 0
		_OutlineColor ("Outline Color", Color) = (0,0,0,1)
		_OutlineTex ("Outline Texture", 2D) = "white" {}
		_OutlineUVSpeedX ("Outline UV Speed X", Range(-5, 5)) = 0
		_OutlineUVSpeedY ("Outline UV Speed Y", Range(-5, 5)) = 0
		_OutlineWidth ("Outline Thickness", Range(0, 1)) = 0
		_OutlineSoftness ("Outline Softness", Range(0, 1)) = 0
		_Bevel ("Bevel", Range(0, 1)) = 0.5
		_BevelOffset ("Bevel Offset", Range(-0.5, 0.5)) = 0
		_BevelWidth ("Bevel Width", Range(-0.5, 0.5)) = 0
		_BevelClamp ("Bevel Clamp", Range(0, 1)) = 0
		_BevelRoundness ("Bevel Roundness", Range(0, 1)) = 0
		_LightAngle ("Light Angle", Range(0, 6.2831855)) = 3.1416
		_SpecularColor ("Specular", Color) = (1,1,1,1)
		_SpecularPower ("Specular", Range(0, 4)) = 2
		_Reflectivity ("Reflectivity", Range(5, 15)) = 10
		_Diffuse ("Diffuse", Range(0, 1)) = 0.5
		_Ambient ("Ambient", Range(1, 0)) = 0.5
		_BumpMap ("Normal map", 2D) = "bump" {}
		_BumpOutline ("Bump Outline", Range(0, 1)) = 0
		_BumpFace ("Bump Face", Range(0, 1)) = 0
		_ReflectFaceColor ("Reflection Color", Color) = (0,0,0,1)
		_ReflectOutlineColor ("Reflection Color", Color) = (0,0,0,1)
		_Cube ("Reflection Cubemap", Cube) = "black" {}
		_EnvMatrixRotation ("Texture Rotation", Vector) = (0,0,0,0)
		_UnderlayColor ("Border Color", Color) = (0,0,0,0.5)
		_UnderlayOffsetX ("Border OffsetX", Range(-1, 1)) = 0
		_UnderlayOffsetY ("Border OffsetY", Range(-1, 1)) = 0
		_UnderlayDilate ("Border Dilate", Range(-1, 1)) = 0
		_UnderlaySoftness ("Border Softness", Range(0, 1)) = 0
		_GlowColor ("Color", Color) = (0,1,0,0.5)
		_GlowOffset ("Offset", Range(-1, 1)) = 0
		_GlowInner ("Inner", Range(0, 1)) = 0.05
		_GlowOuter ("Outer", Range(0, 1)) = 0.05
		_GlowPower ("Falloff", Range(1, 0)) = 0.75
		_WeightNormal ("Weight Normal", Float) = 0
		_WeightBold ("Weight Bold", Float) = 0.5
		_ShaderFlags ("Flags", Float) = 0
		_ScaleRatioA ("Scale RatioA", Float) = 1
		_ScaleRatioB ("Scale RatioB", Float) = 1
		_ScaleRatioC ("Scale RatioC", Float) = 1
		_MainTex ("Font Atlas", 2D) = "white" {}
		_TextureWidth ("Texture Width", Float) = 512
		_TextureHeight ("Texture Height", Float) = 512
		_GradientScale ("Gradient Scale", Float) = 5
		_ScaleX ("Scale X", Float) = 1
		_ScaleY ("Scale Y", Float) = 1
		_PerspectiveFilter ("Perspective Correction", Range(0, 1)) = 0.875
		_Sharpness ("Sharpness", Range(-1, 1)) = 0
		_VertexOffsetX ("Vertex OffsetX", Float) = 0
		_VertexOffsetY ("Vertex OffsetY", Float) = 0
		_MaskCoord ("Mask Coordinates", Vector) = (0,0,32767,32767)
		_ClipRect ("Clip Rect", Vector) = (-32767,-32767,32767,32767)
		_MaskSoftnessX ("Mask SoftnessX", Float) = 0
		_MaskSoftnessY ("Mask SoftnessY", Float) = 0
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255
		_ColorMask ("Color Mask", Float) = 15
	}
	SubShader
	{
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Overlay" "RenderType" = "Transparent" }
		Pass
		{
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Overlay" "RenderType" = "Transparent" }
			Blend One OneMinusSrcAlpha
			ColorMask [_ColorMask]
			ZTest Always
			ZWrite Off
			Cull [_CullMode]
			Stencil
			{
				Ref [_Stencil]
				ReadMask [_StencilReadMask]
				WriteMask [_StencilWriteMask]
				Comp [_StencilComp]
				Pass [_StencilOp]
				Fail Keep
				ZFail Keep
			}
			Fog
			{
				Mode Off
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 38375

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#pragma multi_compile _ UNITY_UI_ALPHACLIP
			#pragma multi_compile _ UNITY_UI_CLIP_RECT


			#if !defined(UNITY_UI_ALPHACLIP) && !defined(UNITY_UI_CLIP_RECT)

			float _FaceDilate;
			float _OutlineSoftness;
			float _OutlineWidth;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;
			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[32];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[8];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float2 vertex_input_3;
			static float2 vertex_input_4;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static float4 vertex_output_6;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : COLOR; // COLOR
				float2 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float2 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_4 : TEXCOORD2; // TEXCOORD_2
				float3 vertex_output_5 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_60 = vertex_input_0.x + vertex_uniform_buffer_0[23u].z;
				precise float vertex_unnamed_61 = vertex_input_0.y + vertex_uniform_buffer_0[23u].w;
				precise float vertex_unnamed_68 = vertex_unnamed_61 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_69 = vertex_unnamed_61 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_70 = vertex_unnamed_61 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_71 = vertex_unnamed_61 * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_92 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_60, vertex_unnamed_68));
				float vertex_unnamed_93 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_60, vertex_unnamed_69));
				float vertex_unnamed_94 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_60, vertex_unnamed_70));
				precise float vertex_unnamed_103 = vertex_unnamed_92 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_104 = vertex_unnamed_93 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_105 = vertex_unnamed_94 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_106 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_60, vertex_unnamed_71)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_117 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_92);
				precise float vertex_unnamed_119 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_93);
				precise float vertex_unnamed_120 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_94);
				precise float vertex_unnamed_127 = vertex_unnamed_117 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_128 = vertex_unnamed_119 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_129 = vertex_unnamed_120 + vertex_uniform_buffer_1[4u].z;
				precise float vertex_unnamed_137 = vertex_unnamed_104 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_138 = vertex_unnamed_104 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_139 = vertex_unnamed_104 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_140 = vertex_unnamed_104 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_173 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_106, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_105, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_103, vertex_unnamed_140)));
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_106, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_105, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_103, vertex_unnamed_137)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_106, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_105, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_103, vertex_unnamed_138)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_106, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_105, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_103, vertex_unnamed_139)));
				gl_Position.w = vertex_unnamed_173;
				vertex_output_1.x = vertex_input_2.x;
				vertex_output_1.y = vertex_input_2.y;
				vertex_output_1.z = vertex_input_2.z;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				precise float vertex_unnamed_205 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_206 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_224 = abs(mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_205)) * vertex_uniform_buffer_0[28u].y;
				precise float vertex_unnamed_225 = abs(mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_206)) * vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_226 = vertex_unnamed_173 / vertex_unnamed_224;
				precise float vertex_unnamed_227 = vertex_unnamed_173 / vertex_unnamed_225;
				precise float vertex_unnamed_239 = 0.25f / mad(vertex_uniform_buffer_0[27u].x, 0.25f, vertex_unnamed_226);
				precise float vertex_unnamed_240 = 0.25f / mad(vertex_uniform_buffer_0[27u].y, 0.25f, vertex_unnamed_227);
				vertex_output_4.z = vertex_unnamed_239;
				vertex_output_4.w = vertex_unnamed_240;
				float vertex_unnamed_243 = rsqrt(dot(float2(vertex_unnamed_226, vertex_unnamed_227), float2(vertex_unnamed_226, vertex_unnamed_227)));
				precise float vertex_unnamed_250 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[28u].x;
				precise float vertex_unnamed_255 = vertex_uniform_buffer_0[29u].x + 1.0f;
				precise float vertex_unnamed_257 = vertex_unnamed_250 * vertex_unnamed_255;
				precise float vertex_unnamed_258 = vertex_unnamed_257 * vertex_unnamed_243;
				precise float vertex_unnamed_262 = (-0.0f) - vertex_uniform_buffer_0[28u].w;
				precise float vertex_unnamed_263 = vertex_unnamed_262 + 1.0f;
				precise float vertex_unnamed_265 = abs(vertex_unnamed_258) * vertex_unnamed_263;
				precise float vertex_unnamed_266 = (-0.0f) - vertex_unnamed_265;
				float vertex_unnamed_279 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_293 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_307 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_313 = rsqrt(dot(float3(vertex_unnamed_279, vertex_unnamed_293, vertex_unnamed_307), float3(vertex_unnamed_279, vertex_unnamed_293, vertex_unnamed_307)));
				precise float vertex_unnamed_314 = vertex_unnamed_313 * vertex_unnamed_279;
				precise float vertex_unnamed_315 = vertex_unnamed_313 * vertex_unnamed_293;
				precise float vertex_unnamed_316 = vertex_unnamed_313 * vertex_unnamed_307;
				float vertex_unnamed_320 = rsqrt(dot(float3(vertex_unnamed_127, vertex_unnamed_128, vertex_unnamed_129), float3(vertex_unnamed_127, vertex_unnamed_128, vertex_unnamed_129)));
				precise float vertex_unnamed_321 = vertex_unnamed_320 * vertex_unnamed_127;
				precise float vertex_unnamed_322 = vertex_unnamed_320 * vertex_unnamed_128;
				precise float vertex_unnamed_323 = vertex_unnamed_320 * vertex_unnamed_129;
				float vertex_unnamed_339 = asfloat((vertex_uniform_buffer_3[8u].w == 0.0f) ? asuint(mad(abs(dot(float3(vertex_unnamed_314, vertex_unnamed_315, vertex_unnamed_316), float3(vertex_unnamed_321, vertex_unnamed_322, vertex_unnamed_323))), mad(vertex_unnamed_243, vertex_unnamed_257, vertex_unnamed_266), vertex_unnamed_265)) : asuint(vertex_unnamed_258));
				precise float vertex_unnamed_352 = (-0.0f) - vertex_uniform_buffer_0[22u].y;
				precise float vertex_unnamed_356 = vertex_unnamed_352 + vertex_uniform_buffer_0[22u].z;
				precise float vertex_unnamed_368 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_356, vertex_uniform_buffer_0[22u].y), 0.25f, vertex_uniform_buffer_0[4u].x) * vertex_uniform_buffer_0[22u].w;
				precise float vertex_unnamed_369 = vertex_unnamed_368 * 0.5f;
				vertex_output_3.y = vertex_unnamed_339;
				vertex_output_3.w = vertex_unnamed_369;
				precise float vertex_unnamed_373 = 0.5f / vertex_unnamed_339;
				precise float vertex_unnamed_377 = (-0.0f) - vertex_uniform_buffer_0[6u].x;
				precise float vertex_unnamed_385 = (-0.0f) - vertex_uniform_buffer_0[4u].y;
				precise float vertex_unnamed_390 = (-0.0f) - vertex_unnamed_373;
				precise float vertex_unnamed_392 = (-0.0f) - vertex_unnamed_368;
				vertex_output_3.x = mad(vertex_unnamed_392, 0.5f, mad(mad(vertex_unnamed_385, vertex_uniform_buffer_0[22u].w, mad(vertex_unnamed_377, vertex_uniform_buffer_0[22u].w, 1.0f)), 0.5f, vertex_unnamed_390));
				precise float vertex_unnamed_395 = (-0.0f) - vertex_unnamed_368;
				precise float vertex_unnamed_397 = vertex_unnamed_373 + mad(vertex_unnamed_395, 0.5f, 0.5f);
				vertex_output_3.z = vertex_unnamed_397;
				precise float vertex_unnamed_416 = (-0.0f) - min(max(vertex_uniform_buffer_0[26u].x, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_417 = (-0.0f) - min(max(vertex_uniform_buffer_0[26u].y, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_421 = (-0.0f) - min(max(vertex_uniform_buffer_0[26u].z, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_422 = (-0.0f) - min(max(vertex_uniform_buffer_0[26u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_423 = vertex_unnamed_421 + mad(vertex_unnamed_60, 2.0f, vertex_unnamed_416);
				precise float vertex_unnamed_424 = vertex_unnamed_422 + mad(vertex_unnamed_61, 2.0f, vertex_unnamed_417);
				vertex_output_4.x = vertex_unnamed_423;
				vertex_output_4.y = vertex_unnamed_424;
				precise float vertex_unnamed_433 = vertex_unnamed_128 * vertex_uniform_buffer_0[12u].x;
				precise float vertex_unnamed_434 = vertex_unnamed_128 * vertex_uniform_buffer_0[12u].y;
				precise float vertex_unnamed_435 = vertex_unnamed_128 * vertex_uniform_buffer_0[12u].z;
				vertex_output_5.x = mad(vertex_uniform_buffer_0[13u].x, vertex_unnamed_129, mad(vertex_uniform_buffer_0[11u].x, vertex_unnamed_127, vertex_unnamed_433));
				vertex_output_5.y = mad(vertex_uniform_buffer_0[13u].y, vertex_unnamed_129, mad(vertex_uniform_buffer_0[11u].y, vertex_unnamed_127, vertex_unnamed_434));
				vertex_output_5.z = mad(vertex_uniform_buffer_0[13u].z, vertex_unnamed_129, mad(vertex_uniform_buffer_0[11u].z, vertex_unnamed_127, vertex_unnamed_435));
				precise float vertex_unnamed_459 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_461 = floor(vertex_unnamed_459);
				precise float vertex_unnamed_462 = (-0.0f) - vertex_unnamed_461;
				precise float vertex_unnamed_467 = vertex_unnamed_461 * 0.001953125f;
				precise float vertex_unnamed_469 = mad(vertex_unnamed_462, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_6.x = mad(vertex_unnamed_467, vertex_uniform_buffer_0[30u].x, vertex_uniform_buffer_0[30u].z);
				vertex_output_6.y = mad(vertex_unnamed_469, vertex_uniform_buffer_0[30u].y, vertex_uniform_buffer_0[30u].w);
				vertex_output_6.z = mad(vertex_unnamed_467, vertex_uniform_buffer_0[31u].x, vertex_uniform_buffer_0[31u].z);
				vertex_output_6.w = mad(vertex_unnamed_469, vertex_uniform_buffer_0[31u].y, vertex_uniform_buffer_0[31u].w);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(_FaceDilate, vertex_uniform_buffer_0[4][1], vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], _OutlineSoftness, vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[6] = float4(_OutlineWidth, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[11] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				vertex_uniform_buffer_0[12] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				vertex_uniform_buffer_0[13] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				vertex_uniform_buffer_0[14] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], _WeightNormal, vertex_uniform_buffer_0[22][2], vertex_uniform_buffer_0[22][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], vertex_uniform_buffer_0[22][1], _WeightBold, vertex_uniform_buffer_0[22][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], vertex_uniform_buffer_0[22][1], vertex_uniform_buffer_0[22][2], _ScaleRatioA);

				vertex_uniform_buffer_0[23] = float4(vertex_uniform_buffer_0[23][0], vertex_uniform_buffer_0[23][1], _VertexOffsetX, vertex_uniform_buffer_0[23][3]);

				vertex_uniform_buffer_0[23] = float4(vertex_uniform_buffer_0[23][0], vertex_uniform_buffer_0[23][1], vertex_uniform_buffer_0[23][2], _VertexOffsetY);

				vertex_uniform_buffer_0[26] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[27] = float4(_MaskSoftnessX, vertex_uniform_buffer_0[27][1], vertex_uniform_buffer_0[27][2], vertex_uniform_buffer_0[27][3]);

				vertex_uniform_buffer_0[27] = float4(vertex_uniform_buffer_0[27][0], _MaskSoftnessY, vertex_uniform_buffer_0[27][2], vertex_uniform_buffer_0[27][3]);

				vertex_uniform_buffer_0[28] = float4(_GradientScale, vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], _ScaleX, vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], _ScaleY, vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[29] = float4(_Sharpness, vertex_uniform_buffer_0[29][1], vertex_uniform_buffer_0[29][2], vertex_uniform_buffer_0[29][3]);

				vertex_uniform_buffer_0[30] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[31] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

				vertex_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], vertex_uniform_buffer_1[4][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_3[5] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				vertex_uniform_buffer_3[6] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				vertex_uniform_buffer_3[7] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				vertex_uniform_buffer_3[8] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

				vertex_uniform_buffer_3[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_3[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_3[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_3[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}


			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _ScaleRatioA;
			float4 _Time;

			static float4 fragment_uniform_buffer_0[23];
			static float4 fragment_uniform_buffer_1[1];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_4 : TEXCOORD2; // TEXCOORD_2
				float3 fragment_input_5 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_6 : TEXCOORD5; // TEXCOORD_5
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_230)
			{
				if (fragment_unnamed_230)
				{
					discard_state = true;
				}
			}

			void discard_exit()
			{
				if (discard_state)
				{
					discard;
				}
			}

			void frag_main()
			{
				discard_state = false;
				float4 fragment_unnamed_57 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_59 = fragment_unnamed_57.w;
				precise float fragment_unnamed_62 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_64 = fragment_unnamed_59 + fragment_unnamed_62;
				precise float fragment_unnamed_65 = (-0.0f) - fragment_unnamed_59;
				precise float fragment_unnamed_69 = fragment_unnamed_65 + fragment_input_3.z;
				discard_cond(fragment_unnamed_64 < 0.0f);
				precise float fragment_unnamed_84 = fragment_uniform_buffer_0[6u].x * fragment_uniform_buffer_0[22u].w;
				precise float fragment_unnamed_87 = fragment_unnamed_84 * fragment_input_3.y;
				precise float fragment_unnamed_91 = fragment_unnamed_87 * 0.5f;
				precise float fragment_unnamed_100 = (-0.0f) - fragment_unnamed_91;
				precise float fragment_unnamed_102 = sqrt(min(fragment_unnamed_87, 1.0f)) * clamp(mad(fragment_unnamed_69, fragment_input_3.y, fragment_unnamed_91), 0.0f, 1.0f);
				float4 fragment_unnamed_119 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[4u].z, fragment_uniform_buffer_1[0u].y, fragment_input_6.z), mad(fragment_uniform_buffer_0[4u].w, fragment_uniform_buffer_1[0u].y, fragment_input_6.w)));
				precise float fragment_unnamed_132 = fragment_unnamed_119.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_133 = fragment_unnamed_119.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_134 = fragment_unnamed_119.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_135 = fragment_unnamed_119.w * fragment_uniform_buffer_0[5u].w;
				precise float fragment_unnamed_136 = fragment_unnamed_135 * fragment_unnamed_132;
				precise float fragment_unnamed_137 = fragment_unnamed_135 * fragment_unnamed_133;
				precise float fragment_unnamed_138 = fragment_unnamed_135 * fragment_unnamed_134;
				precise float fragment_unnamed_150 = fragment_input_1.x * fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_151 = fragment_input_1.y * fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_152 = fragment_input_1.z * fragment_uniform_buffer_0[3u].z;
				float4 fragment_unnamed_167 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[2u].x, fragment_uniform_buffer_1[0u].y, fragment_input_6.x), mad(fragment_uniform_buffer_0[2u].y, fragment_uniform_buffer_1[0u].y, fragment_input_6.y)));
				precise float fragment_unnamed_173 = fragment_unnamed_150 * fragment_unnamed_167.x;
				precise float fragment_unnamed_174 = fragment_unnamed_151 * fragment_unnamed_167.y;
				precise float fragment_unnamed_175 = fragment_unnamed_152 * fragment_unnamed_167.z;
				precise float fragment_unnamed_179 = fragment_unnamed_167.w * fragment_uniform_buffer_0[3u].w;
				precise float fragment_unnamed_180 = fragment_unnamed_173 * fragment_unnamed_179;
				precise float fragment_unnamed_181 = fragment_unnamed_174 * fragment_unnamed_179;
				precise float fragment_unnamed_182 = fragment_unnamed_175 * fragment_unnamed_179;
				precise float fragment_unnamed_183 = (-0.0f) - fragment_unnamed_180;
				precise float fragment_unnamed_184 = (-0.0f) - fragment_unnamed_181;
				precise float fragment_unnamed_185 = (-0.0f) - fragment_unnamed_182;
				precise float fragment_unnamed_186 = (-0.0f) - fragment_unnamed_179;
				precise float fragment_unnamed_187 = fragment_unnamed_136 + fragment_unnamed_183;
				precise float fragment_unnamed_188 = fragment_unnamed_137 + fragment_unnamed_184;
				precise float fragment_unnamed_189 = fragment_unnamed_138 + fragment_unnamed_185;
				precise float fragment_unnamed_190 = fragment_unnamed_135 + fragment_unnamed_186;
				precise float fragment_unnamed_201 = fragment_uniform_buffer_0[4u].y * fragment_uniform_buffer_0[22u].w;
				precise float fragment_unnamed_204 = fragment_unnamed_201 * fragment_input_3.y;
				precise float fragment_unnamed_209 = mad(fragment_unnamed_204, 0.5f, mad(fragment_unnamed_69, fragment_input_3.y, fragment_unnamed_100)) / mad(fragment_unnamed_201, fragment_input_3.y, 1.0f);
				precise float fragment_unnamed_211 = (-0.0f) - clamp(fragment_unnamed_209, 0.0f, 1.0f);
				precise float fragment_unnamed_212 = fragment_unnamed_211 + 1.0f;
				precise float fragment_unnamed_213 = fragment_unnamed_212 * mad(fragment_unnamed_102, fragment_unnamed_187, fragment_unnamed_180);
				precise float fragment_unnamed_214 = fragment_unnamed_212 * mad(fragment_unnamed_102, fragment_unnamed_188, fragment_unnamed_181);
				precise float fragment_unnamed_215 = fragment_unnamed_212 * mad(fragment_unnamed_102, fragment_unnamed_189, fragment_unnamed_182);
				precise float fragment_unnamed_216 = fragment_unnamed_212 * mad(fragment_unnamed_102, fragment_unnamed_190, fragment_unnamed_179);
				precise float fragment_unnamed_219 = fragment_unnamed_213 * fragment_input_1.w;
				precise float fragment_unnamed_220 = fragment_unnamed_214 * fragment_input_1.w;
				precise float fragment_unnamed_221 = fragment_unnamed_215 * fragment_input_1.w;
				precise float fragment_unnamed_222 = fragment_unnamed_216 * fragment_input_1.w;
				fragment_output_0.x = fragment_unnamed_219;
				fragment_output_0.y = fragment_unnamed_220;
				fragment_output_0.z = fragment_unnamed_221;
				fragment_output_0.w = fragment_unnamed_222;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[2][1], fragment_uniform_buffer_0[2][2], fragment_uniform_buffer_0[2][3]);

				fragment_uniform_buffer_0[2] = float4(fragment_uniform_buffer_0[2][0], _FaceUVSpeedY, fragment_uniform_buffer_0[2][2], fragment_uniform_buffer_0[2][3]);

				fragment_uniform_buffer_0[3] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _OutlineSoftness, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], fragment_uniform_buffer_0[4][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[5] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[6] = float4(_OutlineWidth, fragment_uniform_buffer_0[6][1], fragment_uniform_buffer_0[6][2], fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[22] = float4(fragment_uniform_buffer_0[22][0], fragment_uniform_buffer_0[22][1], fragment_uniform_buffer_0[22][2], _ScaleRatioA);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // !defined(UNITY_UI_ALPHACLIP) && !defined(UNITY_UI_CLIP_RECT)


			#if defined(UNITY_UI_ALPHACLIP) && !defined(UNITY_UI_CLIP_RECT)

			float _FaceDilate;
			float _OutlineSoftness;
			float _OutlineWidth;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;
			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[32];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[8];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float2 vertex_input_3;
			static float2 vertex_input_4;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static float4 vertex_output_6;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : COLOR; // COLOR
				float2 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float2 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_4 : TEXCOORD2; // TEXCOORD_2
				float3 vertex_output_5 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_60 = vertex_input_0.x + vertex_uniform_buffer_0[23u].z;
				precise float vertex_unnamed_61 = vertex_input_0.y + vertex_uniform_buffer_0[23u].w;
				precise float vertex_unnamed_68 = vertex_unnamed_61 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_69 = vertex_unnamed_61 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_70 = vertex_unnamed_61 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_71 = vertex_unnamed_61 * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_92 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_60, vertex_unnamed_68));
				float vertex_unnamed_93 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_60, vertex_unnamed_69));
				float vertex_unnamed_94 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_60, vertex_unnamed_70));
				precise float vertex_unnamed_103 = vertex_unnamed_92 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_104 = vertex_unnamed_93 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_105 = vertex_unnamed_94 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_106 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_60, vertex_unnamed_71)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_117 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_92);
				precise float vertex_unnamed_119 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_93);
				precise float vertex_unnamed_120 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_94);
				precise float vertex_unnamed_127 = vertex_unnamed_117 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_128 = vertex_unnamed_119 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_129 = vertex_unnamed_120 + vertex_uniform_buffer_1[4u].z;
				precise float vertex_unnamed_137 = vertex_unnamed_104 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_138 = vertex_unnamed_104 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_139 = vertex_unnamed_104 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_140 = vertex_unnamed_104 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_173 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_106, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_105, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_103, vertex_unnamed_140)));
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_106, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_105, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_103, vertex_unnamed_137)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_106, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_105, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_103, vertex_unnamed_138)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_106, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_105, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_103, vertex_unnamed_139)));
				gl_Position.w = vertex_unnamed_173;
				vertex_output_1.x = vertex_input_2.x;
				vertex_output_1.y = vertex_input_2.y;
				vertex_output_1.z = vertex_input_2.z;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				precise float vertex_unnamed_205 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_206 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_224 = abs(mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_205)) * vertex_uniform_buffer_0[28u].y;
				precise float vertex_unnamed_225 = abs(mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_206)) * vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_226 = vertex_unnamed_173 / vertex_unnamed_224;
				precise float vertex_unnamed_227 = vertex_unnamed_173 / vertex_unnamed_225;
				precise float vertex_unnamed_239 = 0.25f / mad(vertex_uniform_buffer_0[27u].x, 0.25f, vertex_unnamed_226);
				precise float vertex_unnamed_240 = 0.25f / mad(vertex_uniform_buffer_0[27u].y, 0.25f, vertex_unnamed_227);
				vertex_output_4.z = vertex_unnamed_239;
				vertex_output_4.w = vertex_unnamed_240;
				float vertex_unnamed_243 = rsqrt(dot(float2(vertex_unnamed_226, vertex_unnamed_227), float2(vertex_unnamed_226, vertex_unnamed_227)));
				precise float vertex_unnamed_250 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[28u].x;
				precise float vertex_unnamed_255 = vertex_uniform_buffer_0[29u].x + 1.0f;
				precise float vertex_unnamed_257 = vertex_unnamed_250 * vertex_unnamed_255;
				precise float vertex_unnamed_258 = vertex_unnamed_257 * vertex_unnamed_243;
				precise float vertex_unnamed_262 = (-0.0f) - vertex_uniform_buffer_0[28u].w;
				precise float vertex_unnamed_263 = vertex_unnamed_262 + 1.0f;
				precise float vertex_unnamed_265 = abs(vertex_unnamed_258) * vertex_unnamed_263;
				precise float vertex_unnamed_266 = (-0.0f) - vertex_unnamed_265;
				float vertex_unnamed_279 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_293 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_307 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_313 = rsqrt(dot(float3(vertex_unnamed_279, vertex_unnamed_293, vertex_unnamed_307), float3(vertex_unnamed_279, vertex_unnamed_293, vertex_unnamed_307)));
				precise float vertex_unnamed_314 = vertex_unnamed_313 * vertex_unnamed_279;
				precise float vertex_unnamed_315 = vertex_unnamed_313 * vertex_unnamed_293;
				precise float vertex_unnamed_316 = vertex_unnamed_313 * vertex_unnamed_307;
				float vertex_unnamed_320 = rsqrt(dot(float3(vertex_unnamed_127, vertex_unnamed_128, vertex_unnamed_129), float3(vertex_unnamed_127, vertex_unnamed_128, vertex_unnamed_129)));
				precise float vertex_unnamed_321 = vertex_unnamed_320 * vertex_unnamed_127;
				precise float vertex_unnamed_322 = vertex_unnamed_320 * vertex_unnamed_128;
				precise float vertex_unnamed_323 = vertex_unnamed_320 * vertex_unnamed_129;
				float vertex_unnamed_339 = asfloat((vertex_uniform_buffer_3[8u].w == 0.0f) ? asuint(mad(abs(dot(float3(vertex_unnamed_314, vertex_unnamed_315, vertex_unnamed_316), float3(vertex_unnamed_321, vertex_unnamed_322, vertex_unnamed_323))), mad(vertex_unnamed_243, vertex_unnamed_257, vertex_unnamed_266), vertex_unnamed_265)) : asuint(vertex_unnamed_258));
				precise float vertex_unnamed_352 = (-0.0f) - vertex_uniform_buffer_0[22u].y;
				precise float vertex_unnamed_356 = vertex_unnamed_352 + vertex_uniform_buffer_0[22u].z;
				precise float vertex_unnamed_368 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_356, vertex_uniform_buffer_0[22u].y), 0.25f, vertex_uniform_buffer_0[4u].x) * vertex_uniform_buffer_0[22u].w;
				precise float vertex_unnamed_369 = vertex_unnamed_368 * 0.5f;
				vertex_output_3.y = vertex_unnamed_339;
				vertex_output_3.w = vertex_unnamed_369;
				precise float vertex_unnamed_373 = 0.5f / vertex_unnamed_339;
				precise float vertex_unnamed_377 = (-0.0f) - vertex_uniform_buffer_0[6u].x;
				precise float vertex_unnamed_385 = (-0.0f) - vertex_uniform_buffer_0[4u].y;
				precise float vertex_unnamed_390 = (-0.0f) - vertex_unnamed_373;
				precise float vertex_unnamed_392 = (-0.0f) - vertex_unnamed_368;
				vertex_output_3.x = mad(vertex_unnamed_392, 0.5f, mad(mad(vertex_unnamed_385, vertex_uniform_buffer_0[22u].w, mad(vertex_unnamed_377, vertex_uniform_buffer_0[22u].w, 1.0f)), 0.5f, vertex_unnamed_390));
				precise float vertex_unnamed_395 = (-0.0f) - vertex_unnamed_368;
				precise float vertex_unnamed_397 = vertex_unnamed_373 + mad(vertex_unnamed_395, 0.5f, 0.5f);
				vertex_output_3.z = vertex_unnamed_397;
				precise float vertex_unnamed_416 = (-0.0f) - min(max(vertex_uniform_buffer_0[26u].x, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_417 = (-0.0f) - min(max(vertex_uniform_buffer_0[26u].y, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_421 = (-0.0f) - min(max(vertex_uniform_buffer_0[26u].z, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_422 = (-0.0f) - min(max(vertex_uniform_buffer_0[26u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_423 = vertex_unnamed_421 + mad(vertex_unnamed_60, 2.0f, vertex_unnamed_416);
				precise float vertex_unnamed_424 = vertex_unnamed_422 + mad(vertex_unnamed_61, 2.0f, vertex_unnamed_417);
				vertex_output_4.x = vertex_unnamed_423;
				vertex_output_4.y = vertex_unnamed_424;
				precise float vertex_unnamed_433 = vertex_unnamed_128 * vertex_uniform_buffer_0[12u].x;
				precise float vertex_unnamed_434 = vertex_unnamed_128 * vertex_uniform_buffer_0[12u].y;
				precise float vertex_unnamed_435 = vertex_unnamed_128 * vertex_uniform_buffer_0[12u].z;
				vertex_output_5.x = mad(vertex_uniform_buffer_0[13u].x, vertex_unnamed_129, mad(vertex_uniform_buffer_0[11u].x, vertex_unnamed_127, vertex_unnamed_433));
				vertex_output_5.y = mad(vertex_uniform_buffer_0[13u].y, vertex_unnamed_129, mad(vertex_uniform_buffer_0[11u].y, vertex_unnamed_127, vertex_unnamed_434));
				vertex_output_5.z = mad(vertex_uniform_buffer_0[13u].z, vertex_unnamed_129, mad(vertex_uniform_buffer_0[11u].z, vertex_unnamed_127, vertex_unnamed_435));
				precise float vertex_unnamed_459 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_461 = floor(vertex_unnamed_459);
				precise float vertex_unnamed_462 = (-0.0f) - vertex_unnamed_461;
				precise float vertex_unnamed_467 = vertex_unnamed_461 * 0.001953125f;
				precise float vertex_unnamed_469 = mad(vertex_unnamed_462, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_6.x = mad(vertex_unnamed_467, vertex_uniform_buffer_0[30u].x, vertex_uniform_buffer_0[30u].z);
				vertex_output_6.y = mad(vertex_unnamed_469, vertex_uniform_buffer_0[30u].y, vertex_uniform_buffer_0[30u].w);
				vertex_output_6.z = mad(vertex_unnamed_467, vertex_uniform_buffer_0[31u].x, vertex_uniform_buffer_0[31u].z);
				vertex_output_6.w = mad(vertex_unnamed_469, vertex_uniform_buffer_0[31u].y, vertex_uniform_buffer_0[31u].w);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(_FaceDilate, vertex_uniform_buffer_0[4][1], vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], _OutlineSoftness, vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[6] = float4(_OutlineWidth, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[11] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				vertex_uniform_buffer_0[12] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				vertex_uniform_buffer_0[13] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				vertex_uniform_buffer_0[14] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], _WeightNormal, vertex_uniform_buffer_0[22][2], vertex_uniform_buffer_0[22][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], vertex_uniform_buffer_0[22][1], _WeightBold, vertex_uniform_buffer_0[22][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], vertex_uniform_buffer_0[22][1], vertex_uniform_buffer_0[22][2], _ScaleRatioA);

				vertex_uniform_buffer_0[23] = float4(vertex_uniform_buffer_0[23][0], vertex_uniform_buffer_0[23][1], _VertexOffsetX, vertex_uniform_buffer_0[23][3]);

				vertex_uniform_buffer_0[23] = float4(vertex_uniform_buffer_0[23][0], vertex_uniform_buffer_0[23][1], vertex_uniform_buffer_0[23][2], _VertexOffsetY);

				vertex_uniform_buffer_0[26] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[27] = float4(_MaskSoftnessX, vertex_uniform_buffer_0[27][1], vertex_uniform_buffer_0[27][2], vertex_uniform_buffer_0[27][3]);

				vertex_uniform_buffer_0[27] = float4(vertex_uniform_buffer_0[27][0], _MaskSoftnessY, vertex_uniform_buffer_0[27][2], vertex_uniform_buffer_0[27][3]);

				vertex_uniform_buffer_0[28] = float4(_GradientScale, vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], _ScaleX, vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], _ScaleY, vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[29] = float4(_Sharpness, vertex_uniform_buffer_0[29][1], vertex_uniform_buffer_0[29][2], vertex_uniform_buffer_0[29][3]);

				vertex_uniform_buffer_0[30] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[31] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

				vertex_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], vertex_uniform_buffer_1[4][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_3[5] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				vertex_uniform_buffer_3[6] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				vertex_uniform_buffer_3[7] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				vertex_uniform_buffer_3[8] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

				vertex_uniform_buffer_3[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_3[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_3[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_3[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}


			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _ScaleRatioA;
			float4 _Time;

			static float4 fragment_uniform_buffer_0[23];
			static float4 fragment_uniform_buffer_1[1];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_4 : TEXCOORD2; // TEXCOORD_2
				float3 fragment_input_5 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_6 : TEXCOORD5; // TEXCOORD_5
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_233)
			{
				if (fragment_unnamed_233)
				{
					discard_state = true;
				}
			}

			void discard_exit()
			{
				if (discard_state)
				{
					discard;
				}
			}

			void frag_main()
			{
				discard_state = false;
				float4 fragment_unnamed_57 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_59 = fragment_unnamed_57.w;
				precise float fragment_unnamed_62 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_64 = fragment_unnamed_59 + fragment_unnamed_62;
				precise float fragment_unnamed_65 = (-0.0f) - fragment_unnamed_59;
				precise float fragment_unnamed_69 = fragment_unnamed_65 + fragment_input_3.z;
				discard_cond(fragment_unnamed_64 < 0.0f);
				precise float fragment_unnamed_84 = fragment_uniform_buffer_0[6u].x * fragment_uniform_buffer_0[22u].w;
				precise float fragment_unnamed_87 = fragment_unnamed_84 * fragment_input_3.y;
				precise float fragment_unnamed_91 = fragment_unnamed_87 * 0.5f;
				precise float fragment_unnamed_100 = (-0.0f) - fragment_unnamed_91;
				precise float fragment_unnamed_102 = sqrt(min(fragment_unnamed_87, 1.0f)) * clamp(mad(fragment_unnamed_69, fragment_input_3.y, fragment_unnamed_91), 0.0f, 1.0f);
				float4 fragment_unnamed_119 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[4u].z, fragment_uniform_buffer_1[0u].y, fragment_input_6.z), mad(fragment_uniform_buffer_0[4u].w, fragment_uniform_buffer_1[0u].y, fragment_input_6.w)));
				precise float fragment_unnamed_132 = fragment_unnamed_119.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_133 = fragment_unnamed_119.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_134 = fragment_unnamed_119.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_135 = fragment_unnamed_119.w * fragment_uniform_buffer_0[5u].w;
				precise float fragment_unnamed_136 = fragment_unnamed_135 * fragment_unnamed_132;
				precise float fragment_unnamed_137 = fragment_unnamed_135 * fragment_unnamed_133;
				precise float fragment_unnamed_138 = fragment_unnamed_135 * fragment_unnamed_134;
				precise float fragment_unnamed_150 = fragment_input_1.x * fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_151 = fragment_input_1.y * fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_152 = fragment_input_1.z * fragment_uniform_buffer_0[3u].z;
				float4 fragment_unnamed_167 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[2u].x, fragment_uniform_buffer_1[0u].y, fragment_input_6.x), mad(fragment_uniform_buffer_0[2u].y, fragment_uniform_buffer_1[0u].y, fragment_input_6.y)));
				precise float fragment_unnamed_173 = fragment_unnamed_150 * fragment_unnamed_167.x;
				precise float fragment_unnamed_174 = fragment_unnamed_151 * fragment_unnamed_167.y;
				precise float fragment_unnamed_175 = fragment_unnamed_152 * fragment_unnamed_167.z;
				precise float fragment_unnamed_179 = fragment_unnamed_167.w * fragment_uniform_buffer_0[3u].w;
				precise float fragment_unnamed_180 = fragment_unnamed_173 * fragment_unnamed_179;
				precise float fragment_unnamed_181 = fragment_unnamed_174 * fragment_unnamed_179;
				precise float fragment_unnamed_182 = fragment_unnamed_175 * fragment_unnamed_179;
				precise float fragment_unnamed_183 = (-0.0f) - fragment_unnamed_180;
				precise float fragment_unnamed_184 = (-0.0f) - fragment_unnamed_181;
				precise float fragment_unnamed_185 = (-0.0f) - fragment_unnamed_182;
				precise float fragment_unnamed_186 = (-0.0f) - fragment_unnamed_179;
				precise float fragment_unnamed_187 = fragment_unnamed_136 + fragment_unnamed_183;
				precise float fragment_unnamed_188 = fragment_unnamed_137 + fragment_unnamed_184;
				precise float fragment_unnamed_189 = fragment_unnamed_138 + fragment_unnamed_185;
				precise float fragment_unnamed_190 = fragment_unnamed_135 + fragment_unnamed_186;
				float fragment_unnamed_194 = mad(fragment_unnamed_102, fragment_unnamed_190, fragment_unnamed_179);
				precise float fragment_unnamed_201 = fragment_uniform_buffer_0[4u].y * fragment_uniform_buffer_0[22u].w;
				precise float fragment_unnamed_204 = fragment_unnamed_201 * fragment_input_3.y;
				precise float fragment_unnamed_209 = mad(fragment_unnamed_204, 0.5f, mad(fragment_unnamed_69, fragment_input_3.y, fragment_unnamed_100)) / mad(fragment_unnamed_201, fragment_input_3.y, 1.0f);
				precise float fragment_unnamed_211 = (-0.0f) - clamp(fragment_unnamed_209, 0.0f, 1.0f);
				precise float fragment_unnamed_212 = fragment_unnamed_211 + 1.0f;
				precise float fragment_unnamed_215 = fragment_unnamed_212 * mad(fragment_unnamed_102, fragment_unnamed_187, fragment_unnamed_180);
				precise float fragment_unnamed_216 = fragment_unnamed_212 * mad(fragment_unnamed_102, fragment_unnamed_188, fragment_unnamed_181);
				precise float fragment_unnamed_217 = fragment_unnamed_212 * mad(fragment_unnamed_102, fragment_unnamed_189, fragment_unnamed_182);
				precise float fragment_unnamed_218 = fragment_unnamed_212 * fragment_unnamed_194;
				precise float fragment_unnamed_221 = fragment_unnamed_215 * fragment_input_1.w;
				precise float fragment_unnamed_222 = fragment_unnamed_216 * fragment_input_1.w;
				precise float fragment_unnamed_223 = fragment_unnamed_217 * fragment_input_1.w;
				precise float fragment_unnamed_224 = fragment_unnamed_218 * fragment_input_1.w;
				fragment_output_0.x = fragment_unnamed_221;
				fragment_output_0.y = fragment_unnamed_222;
				fragment_output_0.z = fragment_unnamed_223;
				fragment_output_0.w = fragment_unnamed_224;
				discard_cond(mad(fragment_unnamed_194, fragment_unnamed_212, -0.001000000047497451305389404296875f) < 0.0f);
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[2][1], fragment_uniform_buffer_0[2][2], fragment_uniform_buffer_0[2][3]);

				fragment_uniform_buffer_0[2] = float4(fragment_uniform_buffer_0[2][0], _FaceUVSpeedY, fragment_uniform_buffer_0[2][2], fragment_uniform_buffer_0[2][3]);

				fragment_uniform_buffer_0[3] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _OutlineSoftness, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], fragment_uniform_buffer_0[4][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[5] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[6] = float4(_OutlineWidth, fragment_uniform_buffer_0[6][1], fragment_uniform_buffer_0[6][2], fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[22] = float4(fragment_uniform_buffer_0[22][0], fragment_uniform_buffer_0[22][1], fragment_uniform_buffer_0[22][2], _ScaleRatioA);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(UNITY_UI_ALPHACLIP) && !defined(UNITY_UI_CLIP_RECT)


			#if defined(UNITY_UI_CLIP_RECT) && !defined(UNITY_UI_ALPHACLIP)

			float _FaceDilate;
			float _OutlineSoftness;
			float _OutlineWidth;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;
			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[32];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[8];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float2 vertex_input_3;
			static float2 vertex_input_4;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static float4 vertex_output_6;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : COLOR; // COLOR
				float2 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float2 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_4 : TEXCOORD2; // TEXCOORD_2
				float3 vertex_output_5 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_60 = vertex_input_0.x + vertex_uniform_buffer_0[23u].z;
				precise float vertex_unnamed_61 = vertex_input_0.y + vertex_uniform_buffer_0[23u].w;
				precise float vertex_unnamed_68 = vertex_unnamed_61 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_69 = vertex_unnamed_61 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_70 = vertex_unnamed_61 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_71 = vertex_unnamed_61 * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_92 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_60, vertex_unnamed_68));
				float vertex_unnamed_93 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_60, vertex_unnamed_69));
				float vertex_unnamed_94 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_60, vertex_unnamed_70));
				precise float vertex_unnamed_103 = vertex_unnamed_92 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_104 = vertex_unnamed_93 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_105 = vertex_unnamed_94 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_106 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_60, vertex_unnamed_71)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_117 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_92);
				precise float vertex_unnamed_119 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_93);
				precise float vertex_unnamed_120 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_94);
				precise float vertex_unnamed_127 = vertex_unnamed_117 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_128 = vertex_unnamed_119 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_129 = vertex_unnamed_120 + vertex_uniform_buffer_1[4u].z;
				precise float vertex_unnamed_137 = vertex_unnamed_104 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_138 = vertex_unnamed_104 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_139 = vertex_unnamed_104 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_140 = vertex_unnamed_104 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_173 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_106, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_105, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_103, vertex_unnamed_140)));
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_106, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_105, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_103, vertex_unnamed_137)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_106, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_105, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_103, vertex_unnamed_138)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_106, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_105, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_103, vertex_unnamed_139)));
				gl_Position.w = vertex_unnamed_173;
				vertex_output_1.x = vertex_input_2.x;
				vertex_output_1.y = vertex_input_2.y;
				vertex_output_1.z = vertex_input_2.z;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				precise float vertex_unnamed_205 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_206 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_224 = abs(mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_205)) * vertex_uniform_buffer_0[28u].y;
				precise float vertex_unnamed_225 = abs(mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_206)) * vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_226 = vertex_unnamed_173 / vertex_unnamed_224;
				precise float vertex_unnamed_227 = vertex_unnamed_173 / vertex_unnamed_225;
				precise float vertex_unnamed_239 = 0.25f / mad(vertex_uniform_buffer_0[27u].x, 0.25f, vertex_unnamed_226);
				precise float vertex_unnamed_240 = 0.25f / mad(vertex_uniform_buffer_0[27u].y, 0.25f, vertex_unnamed_227);
				vertex_output_4.z = vertex_unnamed_239;
				vertex_output_4.w = vertex_unnamed_240;
				float vertex_unnamed_243 = rsqrt(dot(float2(vertex_unnamed_226, vertex_unnamed_227), float2(vertex_unnamed_226, vertex_unnamed_227)));
				precise float vertex_unnamed_250 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[28u].x;
				precise float vertex_unnamed_255 = vertex_uniform_buffer_0[29u].x + 1.0f;
				precise float vertex_unnamed_257 = vertex_unnamed_250 * vertex_unnamed_255;
				precise float vertex_unnamed_258 = vertex_unnamed_257 * vertex_unnamed_243;
				precise float vertex_unnamed_262 = (-0.0f) - vertex_uniform_buffer_0[28u].w;
				precise float vertex_unnamed_263 = vertex_unnamed_262 + 1.0f;
				precise float vertex_unnamed_265 = abs(vertex_unnamed_258) * vertex_unnamed_263;
				precise float vertex_unnamed_266 = (-0.0f) - vertex_unnamed_265;
				float vertex_unnamed_279 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_293 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_307 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_313 = rsqrt(dot(float3(vertex_unnamed_279, vertex_unnamed_293, vertex_unnamed_307), float3(vertex_unnamed_279, vertex_unnamed_293, vertex_unnamed_307)));
				precise float vertex_unnamed_314 = vertex_unnamed_313 * vertex_unnamed_279;
				precise float vertex_unnamed_315 = vertex_unnamed_313 * vertex_unnamed_293;
				precise float vertex_unnamed_316 = vertex_unnamed_313 * vertex_unnamed_307;
				float vertex_unnamed_320 = rsqrt(dot(float3(vertex_unnamed_127, vertex_unnamed_128, vertex_unnamed_129), float3(vertex_unnamed_127, vertex_unnamed_128, vertex_unnamed_129)));
				precise float vertex_unnamed_321 = vertex_unnamed_320 * vertex_unnamed_127;
				precise float vertex_unnamed_322 = vertex_unnamed_320 * vertex_unnamed_128;
				precise float vertex_unnamed_323 = vertex_unnamed_320 * vertex_unnamed_129;
				float vertex_unnamed_339 = asfloat((vertex_uniform_buffer_3[8u].w == 0.0f) ? asuint(mad(abs(dot(float3(vertex_unnamed_314, vertex_unnamed_315, vertex_unnamed_316), float3(vertex_unnamed_321, vertex_unnamed_322, vertex_unnamed_323))), mad(vertex_unnamed_243, vertex_unnamed_257, vertex_unnamed_266), vertex_unnamed_265)) : asuint(vertex_unnamed_258));
				precise float vertex_unnamed_352 = (-0.0f) - vertex_uniform_buffer_0[22u].y;
				precise float vertex_unnamed_356 = vertex_unnamed_352 + vertex_uniform_buffer_0[22u].z;
				precise float vertex_unnamed_368 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_356, vertex_uniform_buffer_0[22u].y), 0.25f, vertex_uniform_buffer_0[4u].x) * vertex_uniform_buffer_0[22u].w;
				precise float vertex_unnamed_369 = vertex_unnamed_368 * 0.5f;
				vertex_output_3.y = vertex_unnamed_339;
				vertex_output_3.w = vertex_unnamed_369;
				precise float vertex_unnamed_373 = 0.5f / vertex_unnamed_339;
				precise float vertex_unnamed_377 = (-0.0f) - vertex_uniform_buffer_0[6u].x;
				precise float vertex_unnamed_385 = (-0.0f) - vertex_uniform_buffer_0[4u].y;
				precise float vertex_unnamed_390 = (-0.0f) - vertex_unnamed_373;
				precise float vertex_unnamed_392 = (-0.0f) - vertex_unnamed_368;
				vertex_output_3.x = mad(vertex_unnamed_392, 0.5f, mad(mad(vertex_unnamed_385, vertex_uniform_buffer_0[22u].w, mad(vertex_unnamed_377, vertex_uniform_buffer_0[22u].w, 1.0f)), 0.5f, vertex_unnamed_390));
				precise float vertex_unnamed_395 = (-0.0f) - vertex_unnamed_368;
				precise float vertex_unnamed_397 = vertex_unnamed_373 + mad(vertex_unnamed_395, 0.5f, 0.5f);
				vertex_output_3.z = vertex_unnamed_397;
				precise float vertex_unnamed_416 = (-0.0f) - min(max(vertex_uniform_buffer_0[26u].x, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_417 = (-0.0f) - min(max(vertex_uniform_buffer_0[26u].y, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_421 = (-0.0f) - min(max(vertex_uniform_buffer_0[26u].z, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_422 = (-0.0f) - min(max(vertex_uniform_buffer_0[26u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_423 = vertex_unnamed_421 + mad(vertex_unnamed_60, 2.0f, vertex_unnamed_416);
				precise float vertex_unnamed_424 = vertex_unnamed_422 + mad(vertex_unnamed_61, 2.0f, vertex_unnamed_417);
				vertex_output_4.x = vertex_unnamed_423;
				vertex_output_4.y = vertex_unnamed_424;
				precise float vertex_unnamed_433 = vertex_unnamed_128 * vertex_uniform_buffer_0[12u].x;
				precise float vertex_unnamed_434 = vertex_unnamed_128 * vertex_uniform_buffer_0[12u].y;
				precise float vertex_unnamed_435 = vertex_unnamed_128 * vertex_uniform_buffer_0[12u].z;
				vertex_output_5.x = mad(vertex_uniform_buffer_0[13u].x, vertex_unnamed_129, mad(vertex_uniform_buffer_0[11u].x, vertex_unnamed_127, vertex_unnamed_433));
				vertex_output_5.y = mad(vertex_uniform_buffer_0[13u].y, vertex_unnamed_129, mad(vertex_uniform_buffer_0[11u].y, vertex_unnamed_127, vertex_unnamed_434));
				vertex_output_5.z = mad(vertex_uniform_buffer_0[13u].z, vertex_unnamed_129, mad(vertex_uniform_buffer_0[11u].z, vertex_unnamed_127, vertex_unnamed_435));
				precise float vertex_unnamed_459 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_461 = floor(vertex_unnamed_459);
				precise float vertex_unnamed_462 = (-0.0f) - vertex_unnamed_461;
				precise float vertex_unnamed_467 = vertex_unnamed_461 * 0.001953125f;
				precise float vertex_unnamed_469 = mad(vertex_unnamed_462, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_6.x = mad(vertex_unnamed_467, vertex_uniform_buffer_0[30u].x, vertex_uniform_buffer_0[30u].z);
				vertex_output_6.y = mad(vertex_unnamed_469, vertex_uniform_buffer_0[30u].y, vertex_uniform_buffer_0[30u].w);
				vertex_output_6.z = mad(vertex_unnamed_467, vertex_uniform_buffer_0[31u].x, vertex_uniform_buffer_0[31u].z);
				vertex_output_6.w = mad(vertex_unnamed_469, vertex_uniform_buffer_0[31u].y, vertex_uniform_buffer_0[31u].w);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(_FaceDilate, vertex_uniform_buffer_0[4][1], vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], _OutlineSoftness, vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[6] = float4(_OutlineWidth, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[11] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				vertex_uniform_buffer_0[12] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				vertex_uniform_buffer_0[13] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				vertex_uniform_buffer_0[14] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], _WeightNormal, vertex_uniform_buffer_0[22][2], vertex_uniform_buffer_0[22][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], vertex_uniform_buffer_0[22][1], _WeightBold, vertex_uniform_buffer_0[22][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], vertex_uniform_buffer_0[22][1], vertex_uniform_buffer_0[22][2], _ScaleRatioA);

				vertex_uniform_buffer_0[23] = float4(vertex_uniform_buffer_0[23][0], vertex_uniform_buffer_0[23][1], _VertexOffsetX, vertex_uniform_buffer_0[23][3]);

				vertex_uniform_buffer_0[23] = float4(vertex_uniform_buffer_0[23][0], vertex_uniform_buffer_0[23][1], vertex_uniform_buffer_0[23][2], _VertexOffsetY);

				vertex_uniform_buffer_0[26] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[27] = float4(_MaskSoftnessX, vertex_uniform_buffer_0[27][1], vertex_uniform_buffer_0[27][2], vertex_uniform_buffer_0[27][3]);

				vertex_uniform_buffer_0[27] = float4(vertex_uniform_buffer_0[27][0], _MaskSoftnessY, vertex_uniform_buffer_0[27][2], vertex_uniform_buffer_0[27][3]);

				vertex_uniform_buffer_0[28] = float4(_GradientScale, vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], _ScaleX, vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], _ScaleY, vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[29] = float4(_Sharpness, vertex_uniform_buffer_0[29][1], vertex_uniform_buffer_0[29][2], vertex_uniform_buffer_0[29][3]);

				vertex_uniform_buffer_0[30] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[31] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

				vertex_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], vertex_uniform_buffer_1[4][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_3[5] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				vertex_uniform_buffer_3[6] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				vertex_uniform_buffer_3[7] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				vertex_uniform_buffer_3[8] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

				vertex_uniform_buffer_3[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_3[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_3[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_3[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}


			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _ScaleRatioA;
			float4 _ClipRect;
			float4 _Time;

			static float4 fragment_uniform_buffer_0[27];
			static float4 fragment_uniform_buffer_1[1];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_4 : TEXCOORD2; // TEXCOORD_2
				float3 fragment_input_5 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_6 : TEXCOORD5; // TEXCOORD_5
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_266)
			{
				if (fragment_unnamed_266)
				{
					discard_state = true;
				}
			}

			void discard_exit()
			{
				if (discard_state)
				{
					discard;
				}
			}

			void frag_main()
			{
				discard_state = false;
				float4 fragment_unnamed_57 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_59 = fragment_unnamed_57.w;
				precise float fragment_unnamed_62 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_64 = fragment_unnamed_59 + fragment_unnamed_62;
				precise float fragment_unnamed_65 = (-0.0f) - fragment_unnamed_59;
				precise float fragment_unnamed_69 = fragment_unnamed_65 + fragment_input_3.z;
				discard_cond(fragment_unnamed_64 < 0.0f);
				precise float fragment_unnamed_84 = fragment_uniform_buffer_0[6u].x * fragment_uniform_buffer_0[22u].w;
				precise float fragment_unnamed_87 = fragment_unnamed_84 * fragment_input_3.y;
				precise float fragment_unnamed_91 = fragment_unnamed_87 * 0.5f;
				precise float fragment_unnamed_100 = (-0.0f) - fragment_unnamed_91;
				precise float fragment_unnamed_102 = sqrt(min(fragment_unnamed_87, 1.0f)) * clamp(mad(fragment_unnamed_69, fragment_input_3.y, fragment_unnamed_91), 0.0f, 1.0f);
				float4 fragment_unnamed_119 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[4u].z, fragment_uniform_buffer_1[0u].y, fragment_input_6.z), mad(fragment_uniform_buffer_0[4u].w, fragment_uniform_buffer_1[0u].y, fragment_input_6.w)));
				precise float fragment_unnamed_132 = fragment_unnamed_119.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_133 = fragment_unnamed_119.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_134 = fragment_unnamed_119.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_135 = fragment_unnamed_119.w * fragment_uniform_buffer_0[5u].w;
				precise float fragment_unnamed_136 = fragment_unnamed_135 * fragment_unnamed_132;
				precise float fragment_unnamed_137 = fragment_unnamed_135 * fragment_unnamed_133;
				precise float fragment_unnamed_138 = fragment_unnamed_135 * fragment_unnamed_134;
				precise float fragment_unnamed_150 = fragment_input_1.x * fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_151 = fragment_input_1.y * fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_152 = fragment_input_1.z * fragment_uniform_buffer_0[3u].z;
				float4 fragment_unnamed_167 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[2u].x, fragment_uniform_buffer_1[0u].y, fragment_input_6.x), mad(fragment_uniform_buffer_0[2u].y, fragment_uniform_buffer_1[0u].y, fragment_input_6.y)));
				precise float fragment_unnamed_173 = fragment_unnamed_150 * fragment_unnamed_167.x;
				precise float fragment_unnamed_174 = fragment_unnamed_151 * fragment_unnamed_167.y;
				precise float fragment_unnamed_175 = fragment_unnamed_152 * fragment_unnamed_167.z;
				precise float fragment_unnamed_179 = fragment_unnamed_167.w * fragment_uniform_buffer_0[3u].w;
				precise float fragment_unnamed_180 = fragment_unnamed_173 * fragment_unnamed_179;
				precise float fragment_unnamed_181 = fragment_unnamed_174 * fragment_unnamed_179;
				precise float fragment_unnamed_182 = fragment_unnamed_175 * fragment_unnamed_179;
				precise float fragment_unnamed_183 = (-0.0f) - fragment_unnamed_180;
				precise float fragment_unnamed_184 = (-0.0f) - fragment_unnamed_181;
				precise float fragment_unnamed_185 = (-0.0f) - fragment_unnamed_182;
				precise float fragment_unnamed_186 = (-0.0f) - fragment_unnamed_179;
				precise float fragment_unnamed_187 = fragment_unnamed_136 + fragment_unnamed_183;
				precise float fragment_unnamed_188 = fragment_unnamed_137 + fragment_unnamed_184;
				precise float fragment_unnamed_189 = fragment_unnamed_138 + fragment_unnamed_185;
				precise float fragment_unnamed_190 = fragment_unnamed_135 + fragment_unnamed_186;
				precise float fragment_unnamed_201 = fragment_uniform_buffer_0[4u].y * fragment_uniform_buffer_0[22u].w;
				precise float fragment_unnamed_204 = fragment_unnamed_201 * fragment_input_3.y;
				precise float fragment_unnamed_209 = mad(fragment_unnamed_204, 0.5f, mad(fragment_unnamed_69, fragment_input_3.y, fragment_unnamed_100)) / mad(fragment_unnamed_201, fragment_input_3.y, 1.0f);
				precise float fragment_unnamed_211 = (-0.0f) - clamp(fragment_unnamed_209, 0.0f, 1.0f);
				precise float fragment_unnamed_212 = fragment_unnamed_211 + 1.0f;
				precise float fragment_unnamed_213 = fragment_unnamed_212 * mad(fragment_unnamed_102, fragment_unnamed_187, fragment_unnamed_180);
				precise float fragment_unnamed_214 = fragment_unnamed_212 * mad(fragment_unnamed_102, fragment_unnamed_188, fragment_unnamed_181);
				precise float fragment_unnamed_215 = fragment_unnamed_212 * mad(fragment_unnamed_102, fragment_unnamed_189, fragment_unnamed_182);
				precise float fragment_unnamed_216 = fragment_unnamed_212 * mad(fragment_unnamed_102, fragment_unnamed_190, fragment_unnamed_179);
				precise float fragment_unnamed_221 = (-0.0f) - fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_223 = (-0.0f) - fragment_uniform_buffer_0[26u].y;
				precise float fragment_unnamed_228 = fragment_unnamed_221 + fragment_uniform_buffer_0[26u].z;
				precise float fragment_unnamed_229 = fragment_unnamed_223 + fragment_uniform_buffer_0[26u].w;
				precise float fragment_unnamed_233 = (-0.0f) - abs(fragment_input_4.x);
				precise float fragment_unnamed_237 = (-0.0f) - abs(fragment_input_4.y);
				precise float fragment_unnamed_238 = fragment_unnamed_228 + fragment_unnamed_233;
				precise float fragment_unnamed_239 = fragment_unnamed_229 + fragment_unnamed_237;
				precise float fragment_unnamed_244 = fragment_unnamed_238 * fragment_input_4.z;
				precise float fragment_unnamed_245 = fragment_unnamed_239 * fragment_input_4.w;
				precise float fragment_unnamed_248 = clamp(fragment_unnamed_245, 0.0f, 1.0f) * clamp(fragment_unnamed_244, 0.0f, 1.0f);
				precise float fragment_unnamed_249 = fragment_unnamed_213 * fragment_unnamed_248;
				precise float fragment_unnamed_250 = fragment_unnamed_214 * fragment_unnamed_248;
				precise float fragment_unnamed_251 = fragment_unnamed_215 * fragment_unnamed_248;
				precise float fragment_unnamed_252 = fragment_unnamed_216 * fragment_unnamed_248;
				precise float fragment_unnamed_255 = fragment_unnamed_249 * fragment_input_1.w;
				precise float fragment_unnamed_256 = fragment_unnamed_250 * fragment_input_1.w;
				precise float fragment_unnamed_257 = fragment_unnamed_251 * fragment_input_1.w;
				precise float fragment_unnamed_258 = fragment_unnamed_252 * fragment_input_1.w;
				fragment_output_0.x = fragment_unnamed_255;
				fragment_output_0.y = fragment_unnamed_256;
				fragment_output_0.z = fragment_unnamed_257;
				fragment_output_0.w = fragment_unnamed_258;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[2][1], fragment_uniform_buffer_0[2][2], fragment_uniform_buffer_0[2][3]);

				fragment_uniform_buffer_0[2] = float4(fragment_uniform_buffer_0[2][0], _FaceUVSpeedY, fragment_uniform_buffer_0[2][2], fragment_uniform_buffer_0[2][3]);

				fragment_uniform_buffer_0[3] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _OutlineSoftness, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], fragment_uniform_buffer_0[4][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[5] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[6] = float4(_OutlineWidth, fragment_uniform_buffer_0[6][1], fragment_uniform_buffer_0[6][2], fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[22] = float4(fragment_uniform_buffer_0[22][0], fragment_uniform_buffer_0[22][1], fragment_uniform_buffer_0[22][2], _ScaleRatioA);

				fragment_uniform_buffer_0[26] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(UNITY_UI_CLIP_RECT) && !defined(UNITY_UI_ALPHACLIP)


			#if defined(UNITY_UI_ALPHACLIP) && defined(UNITY_UI_CLIP_RECT)

			float _FaceDilate;
			float _OutlineSoftness;
			float _OutlineWidth;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float4 _ClipRect;
			float _MaskSoftnessX;
			float _MaskSoftnessY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;
			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[32];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[8];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float2 vertex_input_3;
			static float2 vertex_input_4;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static float4 vertex_output_6;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : COLOR; // COLOR
				float2 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float2 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : COLOR; // COLOR
				float2 vertex_output_2 : TEXCOORD; // TEXCOORD
				float4 vertex_output_3 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_4 : TEXCOORD2; // TEXCOORD_2
				float3 vertex_output_5 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_60 = vertex_input_0.x + vertex_uniform_buffer_0[23u].z;
				precise float vertex_unnamed_61 = vertex_input_0.y + vertex_uniform_buffer_0[23u].w;
				precise float vertex_unnamed_68 = vertex_unnamed_61 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_69 = vertex_unnamed_61 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_70 = vertex_unnamed_61 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_71 = vertex_unnamed_61 * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_92 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_60, vertex_unnamed_68));
				float vertex_unnamed_93 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_60, vertex_unnamed_69));
				float vertex_unnamed_94 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_60, vertex_unnamed_70));
				precise float vertex_unnamed_103 = vertex_unnamed_92 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_104 = vertex_unnamed_93 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_105 = vertex_unnamed_94 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_106 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_60, vertex_unnamed_71)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_117 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_92);
				precise float vertex_unnamed_119 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_93);
				precise float vertex_unnamed_120 = (-0.0f) - mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_94);
				precise float vertex_unnamed_127 = vertex_unnamed_117 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_128 = vertex_unnamed_119 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_129 = vertex_unnamed_120 + vertex_uniform_buffer_1[4u].z;
				precise float vertex_unnamed_137 = vertex_unnamed_104 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_138 = vertex_unnamed_104 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_139 = vertex_unnamed_104 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_140 = vertex_unnamed_104 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_173 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_106, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_105, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_103, vertex_unnamed_140)));
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_106, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_105, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_103, vertex_unnamed_137)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_106, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_105, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_103, vertex_unnamed_138)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_106, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_105, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_103, vertex_unnamed_139)));
				gl_Position.w = vertex_unnamed_173;
				vertex_output_1.x = vertex_input_2.x;
				vertex_output_1.y = vertex_input_2.y;
				vertex_output_1.z = vertex_input_2.z;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				precise float vertex_unnamed_205 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_206 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_224 = abs(mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_205)) * vertex_uniform_buffer_0[28u].y;
				precise float vertex_unnamed_225 = abs(mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_206)) * vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_226 = vertex_unnamed_173 / vertex_unnamed_224;
				precise float vertex_unnamed_227 = vertex_unnamed_173 / vertex_unnamed_225;
				precise float vertex_unnamed_239 = 0.25f / mad(vertex_uniform_buffer_0[27u].x, 0.25f, vertex_unnamed_226);
				precise float vertex_unnamed_240 = 0.25f / mad(vertex_uniform_buffer_0[27u].y, 0.25f, vertex_unnamed_227);
				vertex_output_4.z = vertex_unnamed_239;
				vertex_output_4.w = vertex_unnamed_240;
				float vertex_unnamed_243 = rsqrt(dot(float2(vertex_unnamed_226, vertex_unnamed_227), float2(vertex_unnamed_226, vertex_unnamed_227)));
				precise float vertex_unnamed_250 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[28u].x;
				precise float vertex_unnamed_255 = vertex_uniform_buffer_0[29u].x + 1.0f;
				precise float vertex_unnamed_257 = vertex_unnamed_250 * vertex_unnamed_255;
				precise float vertex_unnamed_258 = vertex_unnamed_257 * vertex_unnamed_243;
				precise float vertex_unnamed_262 = (-0.0f) - vertex_uniform_buffer_0[28u].w;
				precise float vertex_unnamed_263 = vertex_unnamed_262 + 1.0f;
				precise float vertex_unnamed_265 = abs(vertex_unnamed_258) * vertex_unnamed_263;
				precise float vertex_unnamed_266 = (-0.0f) - vertex_unnamed_265;
				float vertex_unnamed_279 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_293 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_307 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_313 = rsqrt(dot(float3(vertex_unnamed_279, vertex_unnamed_293, vertex_unnamed_307), float3(vertex_unnamed_279, vertex_unnamed_293, vertex_unnamed_307)));
				precise float vertex_unnamed_314 = vertex_unnamed_313 * vertex_unnamed_279;
				precise float vertex_unnamed_315 = vertex_unnamed_313 * vertex_unnamed_293;
				precise float vertex_unnamed_316 = vertex_unnamed_313 * vertex_unnamed_307;
				float vertex_unnamed_320 = rsqrt(dot(float3(vertex_unnamed_127, vertex_unnamed_128, vertex_unnamed_129), float3(vertex_unnamed_127, vertex_unnamed_128, vertex_unnamed_129)));
				precise float vertex_unnamed_321 = vertex_unnamed_320 * vertex_unnamed_127;
				precise float vertex_unnamed_322 = vertex_unnamed_320 * vertex_unnamed_128;
				precise float vertex_unnamed_323 = vertex_unnamed_320 * vertex_unnamed_129;
				float vertex_unnamed_339 = asfloat((vertex_uniform_buffer_3[8u].w == 0.0f) ? asuint(mad(abs(dot(float3(vertex_unnamed_314, vertex_unnamed_315, vertex_unnamed_316), float3(vertex_unnamed_321, vertex_unnamed_322, vertex_unnamed_323))), mad(vertex_unnamed_243, vertex_unnamed_257, vertex_unnamed_266), vertex_unnamed_265)) : asuint(vertex_unnamed_258));
				precise float vertex_unnamed_352 = (-0.0f) - vertex_uniform_buffer_0[22u].y;
				precise float vertex_unnamed_356 = vertex_unnamed_352 + vertex_uniform_buffer_0[22u].z;
				precise float vertex_unnamed_368 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_356, vertex_uniform_buffer_0[22u].y), 0.25f, vertex_uniform_buffer_0[4u].x) * vertex_uniform_buffer_0[22u].w;
				precise float vertex_unnamed_369 = vertex_unnamed_368 * 0.5f;
				vertex_output_3.y = vertex_unnamed_339;
				vertex_output_3.w = vertex_unnamed_369;
				precise float vertex_unnamed_373 = 0.5f / vertex_unnamed_339;
				precise float vertex_unnamed_377 = (-0.0f) - vertex_uniform_buffer_0[6u].x;
				precise float vertex_unnamed_385 = (-0.0f) - vertex_uniform_buffer_0[4u].y;
				precise float vertex_unnamed_390 = (-0.0f) - vertex_unnamed_373;
				precise float vertex_unnamed_392 = (-0.0f) - vertex_unnamed_368;
				vertex_output_3.x = mad(vertex_unnamed_392, 0.5f, mad(mad(vertex_unnamed_385, vertex_uniform_buffer_0[22u].w, mad(vertex_unnamed_377, vertex_uniform_buffer_0[22u].w, 1.0f)), 0.5f, vertex_unnamed_390));
				precise float vertex_unnamed_395 = (-0.0f) - vertex_unnamed_368;
				precise float vertex_unnamed_397 = vertex_unnamed_373 + mad(vertex_unnamed_395, 0.5f, 0.5f);
				vertex_output_3.z = vertex_unnamed_397;
				precise float vertex_unnamed_416 = (-0.0f) - min(max(vertex_uniform_buffer_0[26u].x, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_417 = (-0.0f) - min(max(vertex_uniform_buffer_0[26u].y, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_421 = (-0.0f) - min(max(vertex_uniform_buffer_0[26u].z, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_422 = (-0.0f) - min(max(vertex_uniform_buffer_0[26u].w, -20000000000.0f), 20000000000.0f);
				precise float vertex_unnamed_423 = vertex_unnamed_421 + mad(vertex_unnamed_60, 2.0f, vertex_unnamed_416);
				precise float vertex_unnamed_424 = vertex_unnamed_422 + mad(vertex_unnamed_61, 2.0f, vertex_unnamed_417);
				vertex_output_4.x = vertex_unnamed_423;
				vertex_output_4.y = vertex_unnamed_424;
				precise float vertex_unnamed_433 = vertex_unnamed_128 * vertex_uniform_buffer_0[12u].x;
				precise float vertex_unnamed_434 = vertex_unnamed_128 * vertex_uniform_buffer_0[12u].y;
				precise float vertex_unnamed_435 = vertex_unnamed_128 * vertex_uniform_buffer_0[12u].z;
				vertex_output_5.x = mad(vertex_uniform_buffer_0[13u].x, vertex_unnamed_129, mad(vertex_uniform_buffer_0[11u].x, vertex_unnamed_127, vertex_unnamed_433));
				vertex_output_5.y = mad(vertex_uniform_buffer_0[13u].y, vertex_unnamed_129, mad(vertex_uniform_buffer_0[11u].y, vertex_unnamed_127, vertex_unnamed_434));
				vertex_output_5.z = mad(vertex_uniform_buffer_0[13u].z, vertex_unnamed_129, mad(vertex_uniform_buffer_0[11u].z, vertex_unnamed_127, vertex_unnamed_435));
				precise float vertex_unnamed_459 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_461 = floor(vertex_unnamed_459);
				precise float vertex_unnamed_462 = (-0.0f) - vertex_unnamed_461;
				precise float vertex_unnamed_467 = vertex_unnamed_461 * 0.001953125f;
				precise float vertex_unnamed_469 = mad(vertex_unnamed_462, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_6.x = mad(vertex_unnamed_467, vertex_uniform_buffer_0[30u].x, vertex_uniform_buffer_0[30u].z);
				vertex_output_6.y = mad(vertex_unnamed_469, vertex_uniform_buffer_0[30u].y, vertex_uniform_buffer_0[30u].w);
				vertex_output_6.z = mad(vertex_unnamed_467, vertex_uniform_buffer_0[31u].x, vertex_uniform_buffer_0[31u].z);
				vertex_output_6.w = mad(vertex_unnamed_469, vertex_uniform_buffer_0[31u].y, vertex_uniform_buffer_0[31u].w);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(_FaceDilate, vertex_uniform_buffer_0[4][1], vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], _OutlineSoftness, vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[6] = float4(_OutlineWidth, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[11] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				vertex_uniform_buffer_0[12] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				vertex_uniform_buffer_0[13] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				vertex_uniform_buffer_0[14] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], _WeightNormal, vertex_uniform_buffer_0[22][2], vertex_uniform_buffer_0[22][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], vertex_uniform_buffer_0[22][1], _WeightBold, vertex_uniform_buffer_0[22][3]);

				vertex_uniform_buffer_0[22] = float4(vertex_uniform_buffer_0[22][0], vertex_uniform_buffer_0[22][1], vertex_uniform_buffer_0[22][2], _ScaleRatioA);

				vertex_uniform_buffer_0[23] = float4(vertex_uniform_buffer_0[23][0], vertex_uniform_buffer_0[23][1], _VertexOffsetX, vertex_uniform_buffer_0[23][3]);

				vertex_uniform_buffer_0[23] = float4(vertex_uniform_buffer_0[23][0], vertex_uniform_buffer_0[23][1], vertex_uniform_buffer_0[23][2], _VertexOffsetY);

				vertex_uniform_buffer_0[26] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				vertex_uniform_buffer_0[27] = float4(_MaskSoftnessX, vertex_uniform_buffer_0[27][1], vertex_uniform_buffer_0[27][2], vertex_uniform_buffer_0[27][3]);

				vertex_uniform_buffer_0[27] = float4(vertex_uniform_buffer_0[27][0], _MaskSoftnessY, vertex_uniform_buffer_0[27][2], vertex_uniform_buffer_0[27][3]);

				vertex_uniform_buffer_0[28] = float4(_GradientScale, vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], _ScaleX, vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], _ScaleY, vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[29] = float4(_Sharpness, vertex_uniform_buffer_0[29][1], vertex_uniform_buffer_0[29][2], vertex_uniform_buffer_0[29][3]);

				vertex_uniform_buffer_0[30] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[31] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

				vertex_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], vertex_uniform_buffer_1[4][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_3[5] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				vertex_uniform_buffer_3[6] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				vertex_uniform_buffer_3[7] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				vertex_uniform_buffer_3[8] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

				vertex_uniform_buffer_3[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_3[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_3[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_3[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}


			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _ScaleRatioA;
			float4 _ClipRect;
			float4 _Time;

			static float4 fragment_uniform_buffer_0[27];
			static float4 fragment_uniform_buffer_1[1];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : COLOR; // COLOR
				float2 fragment_input_2 : TEXCOORD; // TEXCOORD
				float4 fragment_input_3 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_4 : TEXCOORD2; // TEXCOORD_2
				float3 fragment_input_5 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_6 : TEXCOORD5; // TEXCOORD_5
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_269)
			{
				if (fragment_unnamed_269)
				{
					discard_state = true;
				}
			}

			void discard_exit()
			{
				if (discard_state)
				{
					discard;
				}
			}

			void frag_main()
			{
				discard_state = false;
				float4 fragment_unnamed_57 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_59 = fragment_unnamed_57.w;
				precise float fragment_unnamed_62 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_64 = fragment_unnamed_59 + fragment_unnamed_62;
				precise float fragment_unnamed_65 = (-0.0f) - fragment_unnamed_59;
				precise float fragment_unnamed_69 = fragment_unnamed_65 + fragment_input_3.z;
				discard_cond(fragment_unnamed_64 < 0.0f);
				precise float fragment_unnamed_84 = fragment_uniform_buffer_0[6u].x * fragment_uniform_buffer_0[22u].w;
				precise float fragment_unnamed_87 = fragment_unnamed_84 * fragment_input_3.y;
				precise float fragment_unnamed_91 = fragment_unnamed_87 * 0.5f;
				precise float fragment_unnamed_100 = (-0.0f) - fragment_unnamed_91;
				precise float fragment_unnamed_102 = sqrt(min(fragment_unnamed_87, 1.0f)) * clamp(mad(fragment_unnamed_69, fragment_input_3.y, fragment_unnamed_91), 0.0f, 1.0f);
				float4 fragment_unnamed_119 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[4u].z, fragment_uniform_buffer_1[0u].y, fragment_input_6.z), mad(fragment_uniform_buffer_0[4u].w, fragment_uniform_buffer_1[0u].y, fragment_input_6.w)));
				precise float fragment_unnamed_132 = fragment_unnamed_119.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_133 = fragment_unnamed_119.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_134 = fragment_unnamed_119.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_135 = fragment_unnamed_119.w * fragment_uniform_buffer_0[5u].w;
				precise float fragment_unnamed_136 = fragment_unnamed_135 * fragment_unnamed_132;
				precise float fragment_unnamed_137 = fragment_unnamed_135 * fragment_unnamed_133;
				precise float fragment_unnamed_138 = fragment_unnamed_135 * fragment_unnamed_134;
				precise float fragment_unnamed_150 = fragment_input_1.x * fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_151 = fragment_input_1.y * fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_152 = fragment_input_1.z * fragment_uniform_buffer_0[3u].z;
				float4 fragment_unnamed_167 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[2u].x, fragment_uniform_buffer_1[0u].y, fragment_input_6.x), mad(fragment_uniform_buffer_0[2u].y, fragment_uniform_buffer_1[0u].y, fragment_input_6.y)));
				precise float fragment_unnamed_173 = fragment_unnamed_150 * fragment_unnamed_167.x;
				precise float fragment_unnamed_174 = fragment_unnamed_151 * fragment_unnamed_167.y;
				precise float fragment_unnamed_175 = fragment_unnamed_152 * fragment_unnamed_167.z;
				precise float fragment_unnamed_179 = fragment_unnamed_167.w * fragment_uniform_buffer_0[3u].w;
				precise float fragment_unnamed_180 = fragment_unnamed_173 * fragment_unnamed_179;
				precise float fragment_unnamed_181 = fragment_unnamed_174 * fragment_unnamed_179;
				precise float fragment_unnamed_182 = fragment_unnamed_175 * fragment_unnamed_179;
				precise float fragment_unnamed_183 = (-0.0f) - fragment_unnamed_180;
				precise float fragment_unnamed_184 = (-0.0f) - fragment_unnamed_181;
				precise float fragment_unnamed_185 = (-0.0f) - fragment_unnamed_182;
				precise float fragment_unnamed_186 = (-0.0f) - fragment_unnamed_179;
				precise float fragment_unnamed_187 = fragment_unnamed_136 + fragment_unnamed_183;
				precise float fragment_unnamed_188 = fragment_unnamed_137 + fragment_unnamed_184;
				precise float fragment_unnamed_189 = fragment_unnamed_138 + fragment_unnamed_185;
				precise float fragment_unnamed_190 = fragment_unnamed_135 + fragment_unnamed_186;
				precise float fragment_unnamed_201 = fragment_uniform_buffer_0[4u].y * fragment_uniform_buffer_0[22u].w;
				precise float fragment_unnamed_204 = fragment_unnamed_201 * fragment_input_3.y;
				precise float fragment_unnamed_209 = mad(fragment_unnamed_204, 0.5f, mad(fragment_unnamed_69, fragment_input_3.y, fragment_unnamed_100)) / mad(fragment_unnamed_201, fragment_input_3.y, 1.0f);
				precise float fragment_unnamed_211 = (-0.0f) - clamp(fragment_unnamed_209, 0.0f, 1.0f);
				precise float fragment_unnamed_212 = fragment_unnamed_211 + 1.0f;
				precise float fragment_unnamed_213 = fragment_unnamed_212 * mad(fragment_unnamed_102, fragment_unnamed_187, fragment_unnamed_180);
				precise float fragment_unnamed_214 = fragment_unnamed_212 * mad(fragment_unnamed_102, fragment_unnamed_188, fragment_unnamed_181);
				precise float fragment_unnamed_215 = fragment_unnamed_212 * mad(fragment_unnamed_102, fragment_unnamed_189, fragment_unnamed_182);
				precise float fragment_unnamed_216 = fragment_unnamed_212 * mad(fragment_unnamed_102, fragment_unnamed_190, fragment_unnamed_179);
				precise float fragment_unnamed_221 = (-0.0f) - fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_223 = (-0.0f) - fragment_uniform_buffer_0[26u].y;
				precise float fragment_unnamed_228 = fragment_unnamed_221 + fragment_uniform_buffer_0[26u].z;
				precise float fragment_unnamed_229 = fragment_unnamed_223 + fragment_uniform_buffer_0[26u].w;
				precise float fragment_unnamed_233 = (-0.0f) - abs(fragment_input_4.x);
				precise float fragment_unnamed_237 = (-0.0f) - abs(fragment_input_4.y);
				precise float fragment_unnamed_238 = fragment_unnamed_228 + fragment_unnamed_233;
				precise float fragment_unnamed_239 = fragment_unnamed_229 + fragment_unnamed_237;
				precise float fragment_unnamed_244 = fragment_unnamed_238 * fragment_input_4.z;
				precise float fragment_unnamed_245 = fragment_unnamed_239 * fragment_input_4.w;
				precise float fragment_unnamed_248 = clamp(fragment_unnamed_245, 0.0f, 1.0f) * clamp(fragment_unnamed_244, 0.0f, 1.0f);
				precise float fragment_unnamed_251 = fragment_unnamed_213 * fragment_unnamed_248;
				precise float fragment_unnamed_252 = fragment_unnamed_214 * fragment_unnamed_248;
				precise float fragment_unnamed_253 = fragment_unnamed_215 * fragment_unnamed_248;
				precise float fragment_unnamed_254 = fragment_unnamed_216 * fragment_unnamed_248;
				precise float fragment_unnamed_257 = fragment_unnamed_251 * fragment_input_1.w;
				precise float fragment_unnamed_258 = fragment_unnamed_252 * fragment_input_1.w;
				precise float fragment_unnamed_259 = fragment_unnamed_253 * fragment_input_1.w;
				precise float fragment_unnamed_260 = fragment_unnamed_254 * fragment_input_1.w;
				fragment_output_0.x = fragment_unnamed_257;
				fragment_output_0.y = fragment_unnamed_258;
				fragment_output_0.z = fragment_unnamed_259;
				fragment_output_0.w = fragment_unnamed_260;
				discard_cond(mad(fragment_unnamed_216, fragment_unnamed_248, -0.001000000047497451305389404296875f) < 0.0f);
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[2][1], fragment_uniform_buffer_0[2][2], fragment_uniform_buffer_0[2][3]);

				fragment_uniform_buffer_0[2] = float4(fragment_uniform_buffer_0[2][0], _FaceUVSpeedY, fragment_uniform_buffer_0[2][2], fragment_uniform_buffer_0[2][3]);

				fragment_uniform_buffer_0[3] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _OutlineSoftness, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], fragment_uniform_buffer_0[4][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[5] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[6] = float4(_OutlineWidth, fragment_uniform_buffer_0[6][1], fragment_uniform_buffer_0[6][2], fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[22] = float4(fragment_uniform_buffer_0[22][0], fragment_uniform_buffer_0[22][1], fragment_uniform_buffer_0[22][2], _ScaleRatioA);

				fragment_uniform_buffer_0[26] = float4(_ClipRect[0], _ClipRect[1], _ClipRect[2], _ClipRect[3]);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(UNITY_UI_ALPHACLIP) && defined(UNITY_UI_CLIP_RECT)


			ENDHLSL
		}
	}
	FallBack "TextMeshPro/Mobile/Distance Field"
	CustomEditor "TMPro.EditorUtilities.TMP_SDFShaderGUI"
}
