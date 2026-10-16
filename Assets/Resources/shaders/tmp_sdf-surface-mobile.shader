Shader "TextMeshPro/Mobile/Distance Field (Surface)"
{
	Properties
	{
		_FaceTex ("Fill Texture", 2D) = "white" {}
		_FaceColor ("Fill Color", Color) = (1,1,1,1)
		_FaceDilate ("Face Dilate", Range(-1, 1)) = 0
		_OutlineColor ("Outline Color", Color) = (0,0,0,1)
		_OutlineTex ("Outline Texture", 2D) = "white" {}
		_OutlineWidth ("Outline Thickness", Range(0, 1)) = 0
		_OutlineSoftness ("Outline Softness", Range(0, 1)) = 0
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
	}
	SubShader
	{
		LOD 300
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass
		{
			Name "FORWARD"
			LOD 300
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			ZWrite Off
			Cull [_CullMode]
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 10770

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#pragma shader_feature DIRECTIONAL
			#pragma shader_feature LIGHTPROBE_SH
			#pragma shader_feature VERTEXLIGHT_ON


			#if defined(DIRECTIONAL) && !defined(LIGHTPROBE_SH) && !defined(VERTEXLIGHT_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _FaceDilate;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _MainTex_ST;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;
			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4 unity_SHBr;
			float4 unity_SHBg;
			float4 unity_SHBb;
			float4 unity_SHC;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[35];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[46];
			static float4 vertex_uniform_buffer_3[10];
			static float4 vertex_uniform_buffer_4[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float2 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;
			static float3 vertex_output_7;
			static float3 vertex_output_8;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : TANGENT; // TANGENT
				float3 vertex_input_2 : NORMAL; // NORMAL
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_input_7 : COLOR; // COLOR
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float2 vertex_output_2 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float4 vertex_output_6 : COLOR; // COLOR
				float3 vertex_output_7 : TEXCOORD6; // TEXCOORD_6
				float3 vertex_output_8 : TEXCOORD7; // TEXCOORD_7
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_71 = vertex_input_0.x + vertex_uniform_buffer_0[25u].z;
				precise float vertex_unnamed_72 = vertex_input_0.y + vertex_uniform_buffer_0[25u].w;
				precise float vertex_unnamed_79 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].x;
				precise float vertex_unnamed_80 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].y;
				precise float vertex_unnamed_81 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].z;
				precise float vertex_unnamed_82 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].w;
				float vertex_unnamed_103 = mad(vertex_uniform_buffer_3[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].x, vertex_unnamed_71, vertex_unnamed_79));
				float vertex_unnamed_104 = mad(vertex_uniform_buffer_3[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].y, vertex_unnamed_71, vertex_unnamed_80));
				float vertex_unnamed_105 = mad(vertex_uniform_buffer_3[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].z, vertex_unnamed_71, vertex_unnamed_81));
				precise float vertex_unnamed_114 = vertex_unnamed_103 + vertex_uniform_buffer_3[3u].x;
				precise float vertex_unnamed_115 = vertex_unnamed_104 + vertex_uniform_buffer_3[3u].y;
				precise float vertex_unnamed_116 = vertex_unnamed_105 + vertex_uniform_buffer_3[3u].z;
				precise float vertex_unnamed_117 = mad(vertex_uniform_buffer_3[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].w, vertex_unnamed_71, vertex_unnamed_82)) + vertex_uniform_buffer_3[3u].w;
				float vertex_unnamed_125 = mad(vertex_uniform_buffer_3[3u].x, vertex_input_0.w, vertex_unnamed_103);
				float vertex_unnamed_126 = mad(vertex_uniform_buffer_3[3u].y, vertex_input_0.w, vertex_unnamed_104);
				float vertex_unnamed_127 = mad(vertex_uniform_buffer_3[3u].z, vertex_input_0.w, vertex_unnamed_105);
				precise float vertex_unnamed_135 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].x;
				precise float vertex_unnamed_136 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].y;
				precise float vertex_unnamed_137 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].z;
				precise float vertex_unnamed_138 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_4[20u].x, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].x, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].x, vertex_unnamed_114, vertex_unnamed_135)));
				gl_Position.y = mad(vertex_uniform_buffer_4[20u].y, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].y, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].y, vertex_unnamed_114, vertex_unnamed_136)));
				gl_Position.z = mad(vertex_uniform_buffer_4[20u].z, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].z, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].z, vertex_unnamed_114, vertex_unnamed_137)));
				gl_Position.w = mad(vertex_uniform_buffer_4[20u].w, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].w, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].w, vertex_unnamed_114, vertex_unnamed_138)));
				precise float vertex_unnamed_179 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_181 = floor(vertex_unnamed_179);
				precise float vertex_unnamed_182 = (-0.0f) - vertex_unnamed_181;
				precise float vertex_unnamed_188 = vertex_unnamed_181 * 0.001953125f;
				precise float vertex_unnamed_190 = mad(vertex_unnamed_182, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_1.z = mad(vertex_unnamed_188, vertex_uniform_buffer_0[33u].x, vertex_uniform_buffer_0[33u].z);
				vertex_output_1.w = mad(vertex_unnamed_190, vertex_uniform_buffer_0[33u].y, vertex_uniform_buffer_0[33u].w);
				vertex_output_2.x = mad(vertex_unnamed_188, vertex_uniform_buffer_0[34u].x, vertex_uniform_buffer_0[34u].z);
				vertex_output_2.y = mad(vertex_unnamed_190, vertex_uniform_buffer_0[34u].y, vertex_uniform_buffer_0[34u].w);
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[32u].x, vertex_uniform_buffer_0[32u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[32u].y, vertex_uniform_buffer_0[32u].w);
				precise float vertex_unnamed_248 = (-0.0f) - vertex_uniform_buffer_0[24u].y;
				precise float vertex_unnamed_252 = vertex_unnamed_248 + vertex_uniform_buffer_0[24u].z;
				precise float vertex_unnamed_266 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_252, vertex_uniform_buffer_0[24u].y), 0.25f, vertex_uniform_buffer_0[6u].x) * vertex_uniform_buffer_0[24u].w;
				precise float vertex_unnamed_267 = vertex_unnamed_266 * 0.5f;
				vertex_output_2.x = vertex_unnamed_267;
				precise float vertex_unnamed_273 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].w;
				float vertex_unnamed_285 = mad(vertex_uniform_buffer_4[20u].w, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].w, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].w, vertex_unnamed_114, vertex_unnamed_273)));
				precise float vertex_unnamed_293 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_4[6u].x;
				precise float vertex_unnamed_294 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_4[6u].y;
				precise float vertex_unnamed_310 = mad(vertex_uniform_buffer_4[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_293) * vertex_uniform_buffer_0[30u].y;
				precise float vertex_unnamed_311 = mad(vertex_uniform_buffer_4[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_294) * vertex_uniform_buffer_0[30u].z;
				precise float vertex_unnamed_312 = vertex_unnamed_285 / vertex_unnamed_310;
				precise float vertex_unnamed_313 = vertex_unnamed_285 / vertex_unnamed_311;
				float vertex_unnamed_317 = rsqrt(dot(float2(vertex_unnamed_312, vertex_unnamed_313), float2(vertex_unnamed_312, vertex_unnamed_313)));
				precise float vertex_unnamed_324 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[30u].x;
				precise float vertex_unnamed_329 = vertex_uniform_buffer_0[31u].x + 1.0f;
				precise float vertex_unnamed_331 = vertex_unnamed_324 * vertex_unnamed_329;
				precise float vertex_unnamed_332 = vertex_unnamed_317 * vertex_unnamed_331;
				precise float vertex_unnamed_336 = (-0.0f) - vertex_uniform_buffer_0[30u].w;
				precise float vertex_unnamed_337 = vertex_unnamed_336 + 1.0f;
				precise float vertex_unnamed_338 = vertex_unnamed_337 * vertex_unnamed_332;
				precise float vertex_unnamed_339 = (-0.0f) - vertex_unnamed_338;
				precise float vertex_unnamed_350 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_3[5u].x;
				precise float vertex_unnamed_351 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_3[5u].y;
				precise float vertex_unnamed_352 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_3[5u].z;
				precise float vertex_unnamed_380 = mad(vertex_uniform_buffer_3[6u].x, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_3[4u].x, vertex_uniform_buffer_1[4u].x, vertex_unnamed_350)) + vertex_uniform_buffer_3[7u].x;
				precise float vertex_unnamed_381 = mad(vertex_uniform_buffer_3[6u].y, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_3[4u].y, vertex_uniform_buffer_1[4u].x, vertex_unnamed_351)) + vertex_uniform_buffer_3[7u].y;
				precise float vertex_unnamed_382 = mad(vertex_uniform_buffer_3[6u].z, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_3[4u].z, vertex_uniform_buffer_1[4u].x, vertex_unnamed_352)) + vertex_uniform_buffer_3[7u].z;
				precise float vertex_unnamed_385 = (-0.0f) - vertex_unnamed_71;
				precise float vertex_unnamed_386 = (-0.0f) - vertex_unnamed_72;
				precise float vertex_unnamed_387 = (-0.0f) - vertex_input_0.z;
				precise float vertex_unnamed_388 = vertex_unnamed_385 + vertex_unnamed_380;
				precise float vertex_unnamed_389 = vertex_unnamed_386 + vertex_unnamed_381;
				precise float vertex_unnamed_390 = vertex_unnamed_387 + vertex_unnamed_382;
				float vertex_unnamed_397 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_unnamed_388, vertex_unnamed_389, vertex_unnamed_390));
				float vertex_unnamed_406 = float(int((-((0.0f < vertex_unnamed_397) ? 4294967295u : 0u)) + ((vertex_unnamed_397 < 0.0f) ? 4294967295u : 0u)));
				precise float vertex_unnamed_413 = vertex_unnamed_406 * vertex_input_2.x;
				precise float vertex_unnamed_414 = vertex_unnamed_406 * vertex_input_2.y;
				precise float vertex_unnamed_415 = vertex_unnamed_406 * vertex_input_2.z;
				float vertex_unnamed_421 = dot(float3(vertex_unnamed_413, vertex_unnamed_414, vertex_unnamed_415), float3(vertex_uniform_buffer_3[4u].xyz));
				float vertex_unnamed_429 = dot(float3(vertex_unnamed_413, vertex_unnamed_414, vertex_unnamed_415), float3(vertex_uniform_buffer_3[5u].xyz));
				float vertex_unnamed_437 = dot(float3(vertex_unnamed_413, vertex_unnamed_414, vertex_unnamed_415), float3(vertex_uniform_buffer_3[6u].xyz));
				float vertex_unnamed_443 = rsqrt(dot(float3(vertex_unnamed_421, vertex_unnamed_429, vertex_unnamed_437), float3(vertex_unnamed_421, vertex_unnamed_429, vertex_unnamed_437)));
				precise float vertex_unnamed_444 = vertex_unnamed_443 * vertex_unnamed_421;
				precise float vertex_unnamed_445 = vertex_unnamed_443 * vertex_unnamed_429;
				precise float vertex_unnamed_446 = vertex_unnamed_443 * vertex_unnamed_437;
				precise float vertex_unnamed_447 = vertex_unnamed_443 * vertex_unnamed_437;
				precise float vertex_unnamed_448 = (-0.0f) - vertex_unnamed_125;
				precise float vertex_unnamed_449 = (-0.0f) - vertex_unnamed_126;
				precise float vertex_unnamed_450 = (-0.0f) - vertex_unnamed_127;
				precise float vertex_unnamed_456 = vertex_unnamed_448 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_457 = vertex_unnamed_449 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_458 = vertex_unnamed_450 + vertex_uniform_buffer_1[4u].z;
				float vertex_unnamed_462 = rsqrt(dot(float3(vertex_unnamed_456, vertex_unnamed_457, vertex_unnamed_458), float3(vertex_unnamed_456, vertex_unnamed_457, vertex_unnamed_458)));
				precise float vertex_unnamed_463 = vertex_unnamed_456 * vertex_unnamed_462;
				precise float vertex_unnamed_464 = vertex_unnamed_457 * vertex_unnamed_462;
				precise float vertex_unnamed_465 = vertex_unnamed_458 * vertex_unnamed_462;
				vertex_output_2.y = mad(abs(dot(float3(vertex_unnamed_444, vertex_unnamed_445, vertex_unnamed_447), float3(vertex_unnamed_463, vertex_unnamed_464, vertex_unnamed_465))), mad(vertex_unnamed_317, vertex_unnamed_331, vertex_unnamed_339), vertex_unnamed_338);
				vertex_output_3.w = vertex_unnamed_125;
				precise float vertex_unnamed_480 = vertex_input_1.y * vertex_uniform_buffer_3[1u].y;
				precise float vertex_unnamed_481 = vertex_input_1.y * vertex_uniform_buffer_3[1u].z;
				precise float vertex_unnamed_482 = vertex_input_1.y * vertex_uniform_buffer_3[1u].x;
				float vertex_unnamed_500 = mad(vertex_uniform_buffer_3[2u].y, vertex_input_1.z, mad(vertex_uniform_buffer_3[0u].y, vertex_input_1.x, vertex_unnamed_480));
				float vertex_unnamed_501 = mad(vertex_uniform_buffer_3[2u].z, vertex_input_1.z, mad(vertex_uniform_buffer_3[0u].z, vertex_input_1.x, vertex_unnamed_481));
				float vertex_unnamed_502 = mad(vertex_uniform_buffer_3[2u].x, vertex_input_1.z, mad(vertex_uniform_buffer_3[0u].x, vertex_input_1.x, vertex_unnamed_482));
				float vertex_unnamed_506 = rsqrt(dot(float3(vertex_unnamed_500, vertex_unnamed_501, vertex_unnamed_502), float3(vertex_unnamed_500, vertex_unnamed_501, vertex_unnamed_502)));
				precise float vertex_unnamed_507 = vertex_unnamed_506 * vertex_unnamed_500;
				precise float vertex_unnamed_508 = vertex_unnamed_506 * vertex_unnamed_501;
				precise float vertex_unnamed_509 = vertex_unnamed_506 * vertex_unnamed_502;
				precise float vertex_unnamed_510 = vertex_unnamed_507 * vertex_unnamed_447;
				precise float vertex_unnamed_511 = vertex_unnamed_508 * vertex_unnamed_444;
				precise float vertex_unnamed_512 = vertex_unnamed_509 * vertex_unnamed_445;
				precise float vertex_unnamed_513 = (-0.0f) - vertex_unnamed_510;
				precise float vertex_unnamed_514 = (-0.0f) - vertex_unnamed_511;
				precise float vertex_unnamed_515 = (-0.0f) - vertex_unnamed_512;
				precise float vertex_unnamed_525 = vertex_input_1.w * vertex_uniform_buffer_3[9u].w;
				precise float vertex_unnamed_526 = vertex_unnamed_525 * mad(vertex_unnamed_445, vertex_unnamed_508, vertex_unnamed_513);
				precise float vertex_unnamed_527 = vertex_unnamed_525 * mad(vertex_unnamed_447, vertex_unnamed_509, vertex_unnamed_514);
				precise float vertex_unnamed_528 = vertex_unnamed_525 * mad(vertex_unnamed_444, vertex_unnamed_507, vertex_unnamed_515);
				vertex_output_3.y = vertex_unnamed_526;
				vertex_output_3.z = vertex_unnamed_444;
				vertex_output_3.x = vertex_unnamed_509;
				vertex_output_4.x = vertex_unnamed_507;
				vertex_output_5.x = vertex_unnamed_508;
				vertex_output_4.w = vertex_unnamed_126;
				vertex_output_5.w = vertex_unnamed_127;
				vertex_output_4.z = vertex_unnamed_445;
				vertex_output_4.y = vertex_unnamed_527;
				vertex_output_5.y = vertex_unnamed_528;
				vertex_output_5.z = vertex_unnamed_447;
				vertex_output_6.x = vertex_input_7.x;
				vertex_output_6.y = vertex_input_7.y;
				vertex_output_6.z = vertex_input_7.z;
				vertex_output_6.w = vertex_input_7.w;
				precise float vertex_unnamed_558 = vertex_unnamed_457 * vertex_uniform_buffer_0[14u].x;
				precise float vertex_unnamed_559 = vertex_unnamed_457 * vertex_uniform_buffer_0[14u].y;
				precise float vertex_unnamed_560 = vertex_unnamed_457 * vertex_uniform_buffer_0[14u].z;
				vertex_output_7.x = mad(vertex_uniform_buffer_0[15u].x, vertex_unnamed_458, mad(vertex_uniform_buffer_0[13u].x, vertex_unnamed_456, vertex_unnamed_558));
				vertex_output_7.y = mad(vertex_uniform_buffer_0[15u].y, vertex_unnamed_458, mad(vertex_uniform_buffer_0[13u].y, vertex_unnamed_456, vertex_unnamed_559));
				vertex_output_7.z = mad(vertex_uniform_buffer_0[15u].z, vertex_unnamed_458, mad(vertex_uniform_buffer_0[13u].z, vertex_unnamed_456, vertex_unnamed_560));
				precise float vertex_unnamed_582 = vertex_unnamed_445 * vertex_unnamed_445;
				precise float vertex_unnamed_583 = (-0.0f) - vertex_unnamed_582;
				float vertex_unnamed_584 = mad(vertex_unnamed_444, vertex_unnamed_444, vertex_unnamed_583);
				precise float vertex_unnamed_585 = vertex_unnamed_445 * vertex_unnamed_444;
				precise float vertex_unnamed_586 = vertex_unnamed_447 * vertex_unnamed_445;
				precise float vertex_unnamed_587 = vertex_unnamed_446 * vertex_unnamed_446;
				precise float vertex_unnamed_588 = vertex_unnamed_444 * vertex_unnamed_447;
				vertex_output_8.x = mad(vertex_uniform_buffer_2[45u].x, vertex_unnamed_584, dot(float4(vertex_uniform_buffer_2[42u]), float4(vertex_unnamed_585, vertex_unnamed_586, vertex_unnamed_587, vertex_unnamed_588)));
				vertex_output_8.y = mad(vertex_uniform_buffer_2[45u].y, vertex_unnamed_584, dot(float4(vertex_uniform_buffer_2[43u]), float4(vertex_unnamed_585, vertex_unnamed_586, vertex_unnamed_587, vertex_unnamed_588)));
				vertex_output_8.z = mad(vertex_uniform_buffer_2[45u].z, vertex_unnamed_584, dot(float4(vertex_uniform_buffer_2[44u]), float4(vertex_unnamed_585, vertex_unnamed_586, vertex_unnamed_587, vertex_unnamed_588)));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_FaceDilate, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[13] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				vertex_uniform_buffer_0[14] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				vertex_uniform_buffer_0[15] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				vertex_uniform_buffer_0[16] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], _WeightNormal, vertex_uniform_buffer_0[24][2], vertex_uniform_buffer_0[24][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], vertex_uniform_buffer_0[24][1], _WeightBold, vertex_uniform_buffer_0[24][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], vertex_uniform_buffer_0[24][1], vertex_uniform_buffer_0[24][2], _ScaleRatioA);

				vertex_uniform_buffer_0[25] = float4(vertex_uniform_buffer_0[25][0], vertex_uniform_buffer_0[25][1], _VertexOffsetX, vertex_uniform_buffer_0[25][3]);

				vertex_uniform_buffer_0[25] = float4(vertex_uniform_buffer_0[25][0], vertex_uniform_buffer_0[25][1], vertex_uniform_buffer_0[25][2], _VertexOffsetY);

				vertex_uniform_buffer_0[30] = float4(_GradientScale, vertex_uniform_buffer_0[30][1], vertex_uniform_buffer_0[30][2], vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], _ScaleX, vertex_uniform_buffer_0[30][2], vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], vertex_uniform_buffer_0[30][1], _ScaleY, vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], vertex_uniform_buffer_0[30][1], vertex_uniform_buffer_0[30][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[31] = float4(_Sharpness, vertex_uniform_buffer_0[31][1], vertex_uniform_buffer_0[31][2], vertex_uniform_buffer_0[31][3]);

				vertex_uniform_buffer_0[32] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_0[33] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[34] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

				vertex_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], vertex_uniform_buffer_1[4][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[42] = float4(unity_SHBr[0], unity_SHBr[1], unity_SHBr[2], unity_SHBr[3]);

				vertex_uniform_buffer_2[43] = float4(unity_SHBg[0], unity_SHBg[1], unity_SHBg[2], unity_SHBg[3]);

				vertex_uniform_buffer_2[44] = float4(unity_SHBb[0], unity_SHBb[1], unity_SHBb[2], unity_SHBb[3]);

				vertex_uniform_buffer_2[45] = float4(unity_SHC[0], unity_SHC[1], unity_SHC[2], unity_SHC[3]);

				vertex_uniform_buffer_3[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_3[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_3[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_3[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_3[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_3[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_3[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_3[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				vertex_uniform_buffer_4[5] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				vertex_uniform_buffer_4[6] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				vertex_uniform_buffer_4[7] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				vertex_uniform_buffer_4[8] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

				vertex_uniform_buffer_4[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_4[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_4[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_4[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vertex_input_7 = stage_input.vertex_input_7;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				return stage_output;
			}


			float4 _LightColor0;
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
			float4 _WorldSpaceLightPos0;
			float4 unity_SHAr;
			float4 unity_SHAg;
			float4 unity_SHAb;
			float4 unity_OcclusionMaskSelector;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[25];
			static float4 fragment_uniform_buffer_1[1];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_input_6;
			static float3 fragment_input_7;
			static float3 fragment_input_8;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float2 fragment_input_2 : TEXCOORD5; // TEXCOORD_5
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
				float4 fragment_input_6 : COLOR; // COLOR
				float3 fragment_input_7 : TEXCOORD6; // TEXCOORD_6
				float3 fragment_input_8 : TEXCOORD7; // TEXCOORD_7
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_79 = (-0.0f) - _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
				precise float fragment_unnamed_81 = fragment_unnamed_79 + 0.5f;
				precise float fragment_unnamed_85 = (-0.0f) - fragment_input_2.x;
				precise float fragment_unnamed_86 = fragment_unnamed_81 + fragment_unnamed_85;
				float fragment_unnamed_90 = mad(fragment_unnamed_86, fragment_input_2.y, 0.5f);
				precise float fragment_unnamed_100 = fragment_uniform_buffer_0[8u].x * fragment_uniform_buffer_0[24u].w;
				precise float fragment_unnamed_108 = fragment_uniform_buffer_0[6u].y * fragment_uniform_buffer_0[24u].w;
				precise float fragment_unnamed_111 = fragment_unnamed_100 * fragment_input_2.y;
				precise float fragment_unnamed_112 = fragment_unnamed_108 * fragment_input_2.y;
				precise float fragment_unnamed_130 = fragment_input_6.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_131 = fragment_input_6.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_132 = fragment_input_6.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_133 = fragment_input_6.w * fragment_uniform_buffer_0[5u].w;
				precise float fragment_unnamed_139 = fragment_input_6.w * fragment_uniform_buffer_0[7u].w;
				float4 fragment_unnamed_155 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[4u].x, fragment_uniform_buffer_1[0u].y, fragment_input_1.z), mad(fragment_uniform_buffer_0[4u].y, fragment_uniform_buffer_1[0u].y, fragment_input_1.w)));
				precise float fragment_unnamed_161 = fragment_unnamed_130 * fragment_unnamed_155.x;
				precise float fragment_unnamed_162 = fragment_unnamed_131 * fragment_unnamed_155.y;
				precise float fragment_unnamed_163 = fragment_unnamed_132 * fragment_unnamed_155.z;
				precise float fragment_unnamed_164 = fragment_unnamed_133 * fragment_unnamed_155.w;
				float4 fragment_unnamed_179 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[6u].z, fragment_uniform_buffer_1[0u].y, fragment_input_2.x), mad(fragment_uniform_buffer_0[6u].w, fragment_uniform_buffer_1[0u].y, fragment_input_2.y)));
				precise float fragment_unnamed_190 = fragment_unnamed_179.x * fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_191 = fragment_unnamed_179.y * fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_192 = fragment_unnamed_179.z * fragment_uniform_buffer_0[7u].z;
				precise float fragment_unnamed_193 = fragment_unnamed_139 * fragment_unnamed_179.w;
				precise float fragment_unnamed_194 = (-0.0f) - fragment_unnamed_111;
				precise float fragment_unnamed_201 = mad(fragment_unnamed_112, 0.5f, mad(fragment_unnamed_194, 0.5f, fragment_unnamed_90)) / mad(fragment_unnamed_108, fragment_input_2.y, 1.0f);
				precise float fragment_unnamed_203 = (-0.0f) - clamp(fragment_unnamed_201, 0.0f, 1.0f);
				precise float fragment_unnamed_204 = fragment_unnamed_203 + 1.0f;
				precise float fragment_unnamed_209 = sqrt(min(fragment_unnamed_111, 1.0f)) * clamp(mad(fragment_unnamed_111, 0.5f, fragment_unnamed_90), 0.0f, 1.0f);
				precise float fragment_unnamed_210 = fragment_unnamed_164 * fragment_unnamed_161;
				precise float fragment_unnamed_211 = fragment_unnamed_164 * fragment_unnamed_162;
				precise float fragment_unnamed_212 = fragment_unnamed_164 * fragment_unnamed_163;
				precise float fragment_unnamed_213 = fragment_unnamed_190 * fragment_unnamed_193;
				precise float fragment_unnamed_214 = fragment_unnamed_191 * fragment_unnamed_193;
				precise float fragment_unnamed_215 = fragment_unnamed_192 * fragment_unnamed_193;
				precise float fragment_unnamed_216 = (-0.0f) - fragment_unnamed_210;
				precise float fragment_unnamed_217 = (-0.0f) - fragment_unnamed_211;
				precise float fragment_unnamed_218 = (-0.0f) - fragment_unnamed_212;
				precise float fragment_unnamed_219 = (-0.0f) - fragment_unnamed_164;
				precise float fragment_unnamed_220 = fragment_unnamed_216 + fragment_unnamed_213;
				precise float fragment_unnamed_221 = fragment_unnamed_217 + fragment_unnamed_214;
				precise float fragment_unnamed_222 = fragment_unnamed_218 + fragment_unnamed_215;
				precise float fragment_unnamed_223 = fragment_unnamed_219 + fragment_unnamed_193;
				precise float fragment_unnamed_228 = fragment_unnamed_204 * mad(fragment_unnamed_209, fragment_unnamed_220, fragment_unnamed_210);
				precise float fragment_unnamed_229 = fragment_unnamed_204 * mad(fragment_unnamed_209, fragment_unnamed_221, fragment_unnamed_211);
				precise float fragment_unnamed_230 = fragment_unnamed_204 * mad(fragment_unnamed_209, fragment_unnamed_222, fragment_unnamed_212);
				precise float fragment_unnamed_231 = fragment_unnamed_204 * mad(fragment_unnamed_209, fragment_unnamed_223, fragment_unnamed_164);
				float fragment_unnamed_232 = max(fragment_unnamed_231, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_234 = fragment_unnamed_228 / fragment_unnamed_232;
				precise float fragment_unnamed_235 = fragment_unnamed_229 / fragment_unnamed_232;
				precise float fragment_unnamed_236 = fragment_unnamed_230 / fragment_unnamed_232;
				bool fragment_unnamed_241 = fragment_uniform_buffer_3[0u].x == 1.0f;
				float fragment_unnamed_342;
				float fragment_unnamed_343;
				float fragment_unnamed_344;
				float fragment_unnamed_345;
				if (fragment_unnamed_241)
				{
					bool fragment_unnamed_245 = fragment_uniform_buffer_3[0u].y == 1.0f;
					precise float fragment_unnamed_253 = fragment_input_4.w * fragment_uniform_buffer_3[2u].x;
					precise float fragment_unnamed_254 = fragment_input_4.w * fragment_uniform_buffer_3[2u].y;
					precise float fragment_unnamed_255 = fragment_input_4.w * fragment_uniform_buffer_3[2u].z;
					precise float fragment_unnamed_281 = mad(fragment_uniform_buffer_3[3u].x, fragment_input_5.w, mad(fragment_uniform_buffer_3[1u].x, fragment_input_3.w, fragment_unnamed_253)) + fragment_uniform_buffer_3[4u].x;
					precise float fragment_unnamed_282 = mad(fragment_uniform_buffer_3[3u].y, fragment_input_5.w, mad(fragment_uniform_buffer_3[1u].y, fragment_input_3.w, fragment_unnamed_254)) + fragment_uniform_buffer_3[4u].y;
					precise float fragment_unnamed_283 = mad(fragment_uniform_buffer_3[3u].z, fragment_input_5.w, mad(fragment_uniform_buffer_3[1u].z, fragment_input_3.w, fragment_unnamed_255)) + fragment_uniform_buffer_3[4u].z;
					precise float fragment_unnamed_305 = (-0.0f) - fragment_uniform_buffer_3[6u].x;
					precise float fragment_unnamed_307 = (-0.0f) - fragment_uniform_buffer_3[6u].y;
					precise float fragment_unnamed_309 = (-0.0f) - fragment_uniform_buffer_3[6u].z;
					precise float fragment_unnamed_310 = asfloat(fragment_unnamed_245 ? asuint(fragment_unnamed_281) : asuint(fragment_input_3.w)) + fragment_unnamed_305;
					precise float fragment_unnamed_311 = asfloat(fragment_unnamed_245 ? asuint(fragment_unnamed_282) : asuint(fragment_input_4.w)) + fragment_unnamed_307;
					precise float fragment_unnamed_312 = asfloat(fragment_unnamed_245 ? asuint(fragment_unnamed_283) : asuint(fragment_input_5.w)) + fragment_unnamed_309;
					precise float fragment_unnamed_318 = fragment_unnamed_310 * fragment_uniform_buffer_3[5u].x;
					precise float fragment_unnamed_319 = fragment_unnamed_311 * fragment_uniform_buffer_3[5u].y;
					precise float fragment_unnamed_320 = fragment_unnamed_312 * fragment_uniform_buffer_3[5u].z;
					float4 fragment_unnamed_331 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_uniform_buffer_3[0u].z, 0.5f, 0.75f), mad(fragment_unnamed_318, 0.25f, 0.75f)), fragment_unnamed_319, fragment_unnamed_320));
					fragment_unnamed_342 = fragment_unnamed_331.x;
					fragment_unnamed_343 = fragment_unnamed_331.y;
					fragment_unnamed_344 = fragment_unnamed_331.z;
					fragment_unnamed_345 = fragment_unnamed_331.w;
				}
				else
				{
					fragment_unnamed_342 = asfloat(1065353216u);
					fragment_unnamed_343 = asfloat(1065353216u);
					fragment_unnamed_344 = asfloat(1065353216u);
					fragment_unnamed_345 = asfloat(1065353216u);
				}
				float fragment_unnamed_356 = clamp(dot(float4(fragment_unnamed_342, fragment_unnamed_343, fragment_unnamed_344, fragment_unnamed_345), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f);
				float fragment_unnamed_366 = rsqrt(dot(float3(fragment_input_3.z, fragment_input_4.z, fragment_input_5.z), float3(fragment_input_3.z, fragment_input_4.z, fragment_input_5.z)));
				precise float fragment_unnamed_367 = fragment_unnamed_366 * fragment_input_3.z;
				precise float fragment_unnamed_368 = fragment_unnamed_366 * fragment_input_4.z;
				precise float fragment_unnamed_369 = fragment_unnamed_366 * fragment_input_5.z;
				precise float fragment_unnamed_375 = fragment_unnamed_356 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_376 = fragment_unnamed_356 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_377 = fragment_unnamed_356 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_535;
				float fragment_unnamed_536;
				float fragment_unnamed_537;
				if (fragment_unnamed_241)
				{
					bool fragment_unnamed_381 = fragment_uniform_buffer_3[0u].y == 1.0f;
					precise float fragment_unnamed_389 = fragment_input_4.w * fragment_uniform_buffer_3[2u].x;
					precise float fragment_unnamed_390 = fragment_input_4.w * fragment_uniform_buffer_3[2u].y;
					precise float fragment_unnamed_391 = fragment_input_4.w * fragment_uniform_buffer_3[2u].z;
					precise float fragment_unnamed_417 = mad(fragment_uniform_buffer_3[3u].x, fragment_input_5.w, mad(fragment_uniform_buffer_3[1u].x, fragment_input_3.w, fragment_unnamed_389)) + fragment_uniform_buffer_3[4u].x;
					precise float fragment_unnamed_418 = mad(fragment_uniform_buffer_3[3u].y, fragment_input_5.w, mad(fragment_uniform_buffer_3[1u].y, fragment_input_3.w, fragment_unnamed_390)) + fragment_uniform_buffer_3[4u].y;
					precise float fragment_unnamed_419 = mad(fragment_uniform_buffer_3[3u].z, fragment_input_5.w, mad(fragment_uniform_buffer_3[1u].z, fragment_input_3.w, fragment_unnamed_391)) + fragment_uniform_buffer_3[4u].z;
					precise float fragment_unnamed_441 = (-0.0f) - fragment_uniform_buffer_3[6u].x;
					precise float fragment_unnamed_443 = (-0.0f) - fragment_uniform_buffer_3[6u].y;
					precise float fragment_unnamed_445 = (-0.0f) - fragment_uniform_buffer_3[6u].z;
					precise float fragment_unnamed_446 = asfloat(fragment_unnamed_381 ? asuint(fragment_unnamed_417) : asuint(fragment_input_3.w)) + fragment_unnamed_441;
					precise float fragment_unnamed_447 = asfloat(fragment_unnamed_381 ? asuint(fragment_unnamed_418) : asuint(fragment_input_4.w)) + fragment_unnamed_443;
					precise float fragment_unnamed_448 = asfloat(fragment_unnamed_381 ? asuint(fragment_unnamed_419) : asuint(fragment_input_5.w)) + fragment_unnamed_445;
					precise float fragment_unnamed_454 = fragment_unnamed_446 * fragment_uniform_buffer_3[5u].x;
					precise float fragment_unnamed_455 = fragment_unnamed_447 * fragment_uniform_buffer_3[5u].y;
					precise float fragment_unnamed_456 = fragment_unnamed_448 * fragment_uniform_buffer_3[5u].z;
					precise float fragment_unnamed_457 = fragment_unnamed_454 * 0.25f;
					precise float fragment_unnamed_461 = fragment_uniform_buffer_3[0u].z * 0.5f;
					precise float fragment_unnamed_465 = (-0.0f) - fragment_uniform_buffer_3[0u].z;
					float fragment_unnamed_468 = min(mad(fragment_unnamed_465, 0.5f, 0.25f), max(fragment_unnamed_457, fragment_unnamed_461));
					precise float fragment_unnamed_476 = fragment_unnamed_468 + 0.25f;
					precise float fragment_unnamed_477 = fragment_unnamed_455 + 0.0f;
					precise float fragment_unnamed_478 = fragment_unnamed_456 + 0.0f;
					precise float fragment_unnamed_485 = fragment_unnamed_468 + 0.5f;
					precise float fragment_unnamed_486 = fragment_unnamed_455 + 0.0f;
					precise float fragment_unnamed_487 = fragment_unnamed_456 + 0.0f;
					float fragment_unnamed_494 = asfloat(1065353216u);
					fragment_unnamed_535 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_476, fragment_unnamed_477, fragment_unnamed_478))), float4(fragment_unnamed_367, fragment_unnamed_368, fragment_unnamed_369, fragment_unnamed_494));
					fragment_unnamed_536 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_485, fragment_unnamed_486, fragment_unnamed_487))), float4(fragment_unnamed_367, fragment_unnamed_368, fragment_unnamed_369, fragment_unnamed_494));
					fragment_unnamed_537 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_468, fragment_unnamed_455, fragment_unnamed_456))), float4(fragment_unnamed_367, fragment_unnamed_368, fragment_unnamed_369, fragment_unnamed_494));
				}
				else
				{
					float fragment_unnamed_504 = asfloat(1065353216u);
					fragment_unnamed_535 = dot(float4(fragment_uniform_buffer_2[40u]), float4(fragment_unnamed_367, fragment_unnamed_368, fragment_unnamed_369, fragment_unnamed_504));
					fragment_unnamed_536 = dot(float4(fragment_uniform_buffer_2[41u]), float4(fragment_unnamed_367, fragment_unnamed_368, fragment_unnamed_369, fragment_unnamed_504));
					fragment_unnamed_537 = dot(float4(fragment_uniform_buffer_2[39u]), float4(fragment_unnamed_367, fragment_unnamed_368, fragment_unnamed_369, fragment_unnamed_504));
				}
				precise float fragment_unnamed_544 = fragment_unnamed_537 + fragment_input_8.x;
				precise float fragment_unnamed_545 = fragment_unnamed_535 + fragment_input_8.y;
				precise float fragment_unnamed_546 = fragment_unnamed_536 + fragment_input_8.z;
				precise float fragment_unnamed_553 = log2(max(fragment_unnamed_544, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_555 = log2(max(fragment_unnamed_545, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_556 = log2(max(fragment_unnamed_546, 0.0f)) * 0.4166666567325592041015625f;
				float fragment_unnamed_576 = max(dot(float3(fragment_unnamed_367, fragment_unnamed_368, fragment_unnamed_369), float3(fragment_uniform_buffer_2[0u].xyz)), 0.0f);
				precise float fragment_unnamed_577 = fragment_unnamed_234 * fragment_unnamed_375;
				precise float fragment_unnamed_578 = fragment_unnamed_235 * fragment_unnamed_376;
				precise float fragment_unnamed_579 = fragment_unnamed_236 * fragment_unnamed_377;
				precise float fragment_unnamed_580 = fragment_unnamed_234 * max(mad(exp2(fragment_unnamed_553), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f);
				precise float fragment_unnamed_581 = fragment_unnamed_235 * max(mad(exp2(fragment_unnamed_555), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f);
				precise float fragment_unnamed_582 = fragment_unnamed_236 * max(mad(exp2(fragment_unnamed_556), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f);
				fragment_output_0.x = mad(fragment_unnamed_577, fragment_unnamed_576, fragment_unnamed_580);
				fragment_output_0.y = mad(fragment_unnamed_578, fragment_unnamed_576, fragment_unnamed_581);
				fragment_output_0.z = mad(fragment_unnamed_579, fragment_unnamed_576, fragment_unnamed_582);
				fragment_output_0.w = fragment_unnamed_231;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[4] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _FaceUVSpeedY, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[5] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], _OutlineSoftness, fragment_uniform_buffer_0[6][2], fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], fragment_uniform_buffer_0[6][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], fragment_uniform_buffer_0[6][1], fragment_uniform_buffer_0[6][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[7] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[8] = float4(_OutlineWidth, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[24] = float4(fragment_uniform_buffer_0[24][0], fragment_uniform_buffer_0[24][1], fragment_uniform_buffer_0[24][2], _ScaleRatioA);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_uniform_buffer_2[39] = float4(unity_SHAr[0], unity_SHAr[1], unity_SHAr[2], unity_SHAr[3]);

				fragment_uniform_buffer_2[40] = float4(unity_SHAg[0], unity_SHAg[1], unity_SHAg[2], unity_SHAg[3]);

				fragment_uniform_buffer_2[41] = float4(unity_SHAb[0], unity_SHAb[1], unity_SHAb[2], unity_SHAb[3]);

				fragment_uniform_buffer_2[46] = float4(unity_OcclusionMaskSelector[0], unity_OcclusionMaskSelector[1], unity_OcclusionMaskSelector[2], unity_OcclusionMaskSelector[3]);

				fragment_uniform_buffer_3[0] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_3[1] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_3[2] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_3[3] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_3[4] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_3[5] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], fragment_uniform_buffer_3[5][3]);

				fragment_uniform_buffer_3[6] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], fragment_uniform_buffer_3[6][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(DIRECTIONAL) && !defined(LIGHTPROBE_SH) && !defined(VERTEXLIGHT_ON)


			#if defined(DIRECTIONAL) && defined(LIGHTPROBE_SH) && !defined(VERTEXLIGHT_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _FaceDilate;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _MainTex_ST;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;
			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4 unity_SHBr;
			float4 unity_SHBg;
			float4 unity_SHBb;
			float4 unity_SHC;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[35];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[46];
			static float4 vertex_uniform_buffer_3[10];
			static float4 vertex_uniform_buffer_4[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float2 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;
			static float3 vertex_output_7;
			static float3 vertex_output_8;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : TANGENT; // TANGENT
				float3 vertex_input_2 : NORMAL; // NORMAL
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_input_7 : COLOR; // COLOR
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float2 vertex_output_2 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float4 vertex_output_6 : COLOR; // COLOR
				float3 vertex_output_7 : TEXCOORD6; // TEXCOORD_6
				float3 vertex_output_8 : TEXCOORD7; // TEXCOORD_7
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_71 = vertex_input_0.x + vertex_uniform_buffer_0[25u].z;
				precise float vertex_unnamed_72 = vertex_input_0.y + vertex_uniform_buffer_0[25u].w;
				precise float vertex_unnamed_79 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].x;
				precise float vertex_unnamed_80 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].y;
				precise float vertex_unnamed_81 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].z;
				precise float vertex_unnamed_82 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].w;
				float vertex_unnamed_103 = mad(vertex_uniform_buffer_3[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].x, vertex_unnamed_71, vertex_unnamed_79));
				float vertex_unnamed_104 = mad(vertex_uniform_buffer_3[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].y, vertex_unnamed_71, vertex_unnamed_80));
				float vertex_unnamed_105 = mad(vertex_uniform_buffer_3[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].z, vertex_unnamed_71, vertex_unnamed_81));
				precise float vertex_unnamed_114 = vertex_unnamed_103 + vertex_uniform_buffer_3[3u].x;
				precise float vertex_unnamed_115 = vertex_unnamed_104 + vertex_uniform_buffer_3[3u].y;
				precise float vertex_unnamed_116 = vertex_unnamed_105 + vertex_uniform_buffer_3[3u].z;
				precise float vertex_unnamed_117 = mad(vertex_uniform_buffer_3[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].w, vertex_unnamed_71, vertex_unnamed_82)) + vertex_uniform_buffer_3[3u].w;
				float vertex_unnamed_125 = mad(vertex_uniform_buffer_3[3u].x, vertex_input_0.w, vertex_unnamed_103);
				float vertex_unnamed_126 = mad(vertex_uniform_buffer_3[3u].y, vertex_input_0.w, vertex_unnamed_104);
				float vertex_unnamed_127 = mad(vertex_uniform_buffer_3[3u].z, vertex_input_0.w, vertex_unnamed_105);
				precise float vertex_unnamed_135 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].x;
				precise float vertex_unnamed_136 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].y;
				precise float vertex_unnamed_137 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].z;
				precise float vertex_unnamed_138 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_4[20u].x, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].x, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].x, vertex_unnamed_114, vertex_unnamed_135)));
				gl_Position.y = mad(vertex_uniform_buffer_4[20u].y, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].y, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].y, vertex_unnamed_114, vertex_unnamed_136)));
				gl_Position.z = mad(vertex_uniform_buffer_4[20u].z, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].z, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].z, vertex_unnamed_114, vertex_unnamed_137)));
				gl_Position.w = mad(vertex_uniform_buffer_4[20u].w, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].w, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].w, vertex_unnamed_114, vertex_unnamed_138)));
				precise float vertex_unnamed_179 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_181 = floor(vertex_unnamed_179);
				precise float vertex_unnamed_182 = (-0.0f) - vertex_unnamed_181;
				precise float vertex_unnamed_188 = vertex_unnamed_181 * 0.001953125f;
				precise float vertex_unnamed_190 = mad(vertex_unnamed_182, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_1.z = mad(vertex_unnamed_188, vertex_uniform_buffer_0[33u].x, vertex_uniform_buffer_0[33u].z);
				vertex_output_1.w = mad(vertex_unnamed_190, vertex_uniform_buffer_0[33u].y, vertex_uniform_buffer_0[33u].w);
				vertex_output_2.x = mad(vertex_unnamed_188, vertex_uniform_buffer_0[34u].x, vertex_uniform_buffer_0[34u].z);
				vertex_output_2.y = mad(vertex_unnamed_190, vertex_uniform_buffer_0[34u].y, vertex_uniform_buffer_0[34u].w);
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[32u].x, vertex_uniform_buffer_0[32u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[32u].y, vertex_uniform_buffer_0[32u].w);
				precise float vertex_unnamed_248 = (-0.0f) - vertex_uniform_buffer_0[24u].y;
				precise float vertex_unnamed_252 = vertex_unnamed_248 + vertex_uniform_buffer_0[24u].z;
				precise float vertex_unnamed_266 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_252, vertex_uniform_buffer_0[24u].y), 0.25f, vertex_uniform_buffer_0[6u].x) * vertex_uniform_buffer_0[24u].w;
				precise float vertex_unnamed_267 = vertex_unnamed_266 * 0.5f;
				vertex_output_2.x = vertex_unnamed_267;
				precise float vertex_unnamed_273 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].w;
				float vertex_unnamed_285 = mad(vertex_uniform_buffer_4[20u].w, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].w, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].w, vertex_unnamed_114, vertex_unnamed_273)));
				precise float vertex_unnamed_293 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_4[6u].x;
				precise float vertex_unnamed_294 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_4[6u].y;
				precise float vertex_unnamed_310 = mad(vertex_uniform_buffer_4[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_293) * vertex_uniform_buffer_0[30u].y;
				precise float vertex_unnamed_311 = mad(vertex_uniform_buffer_4[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_294) * vertex_uniform_buffer_0[30u].z;
				precise float vertex_unnamed_312 = vertex_unnamed_285 / vertex_unnamed_310;
				precise float vertex_unnamed_313 = vertex_unnamed_285 / vertex_unnamed_311;
				float vertex_unnamed_317 = rsqrt(dot(float2(vertex_unnamed_312, vertex_unnamed_313), float2(vertex_unnamed_312, vertex_unnamed_313)));
				precise float vertex_unnamed_324 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[30u].x;
				precise float vertex_unnamed_329 = vertex_uniform_buffer_0[31u].x + 1.0f;
				precise float vertex_unnamed_331 = vertex_unnamed_324 * vertex_unnamed_329;
				precise float vertex_unnamed_332 = vertex_unnamed_317 * vertex_unnamed_331;
				precise float vertex_unnamed_336 = (-0.0f) - vertex_uniform_buffer_0[30u].w;
				precise float vertex_unnamed_337 = vertex_unnamed_336 + 1.0f;
				precise float vertex_unnamed_338 = vertex_unnamed_337 * vertex_unnamed_332;
				precise float vertex_unnamed_339 = (-0.0f) - vertex_unnamed_338;
				precise float vertex_unnamed_350 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_3[5u].x;
				precise float vertex_unnamed_351 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_3[5u].y;
				precise float vertex_unnamed_352 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_3[5u].z;
				precise float vertex_unnamed_380 = mad(vertex_uniform_buffer_3[6u].x, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_3[4u].x, vertex_uniform_buffer_1[4u].x, vertex_unnamed_350)) + vertex_uniform_buffer_3[7u].x;
				precise float vertex_unnamed_381 = mad(vertex_uniform_buffer_3[6u].y, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_3[4u].y, vertex_uniform_buffer_1[4u].x, vertex_unnamed_351)) + vertex_uniform_buffer_3[7u].y;
				precise float vertex_unnamed_382 = mad(vertex_uniform_buffer_3[6u].z, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_3[4u].z, vertex_uniform_buffer_1[4u].x, vertex_unnamed_352)) + vertex_uniform_buffer_3[7u].z;
				precise float vertex_unnamed_385 = (-0.0f) - vertex_unnamed_71;
				precise float vertex_unnamed_386 = (-0.0f) - vertex_unnamed_72;
				precise float vertex_unnamed_387 = (-0.0f) - vertex_input_0.z;
				precise float vertex_unnamed_388 = vertex_unnamed_385 + vertex_unnamed_380;
				precise float vertex_unnamed_389 = vertex_unnamed_386 + vertex_unnamed_381;
				precise float vertex_unnamed_390 = vertex_unnamed_387 + vertex_unnamed_382;
				float vertex_unnamed_397 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_unnamed_388, vertex_unnamed_389, vertex_unnamed_390));
				float vertex_unnamed_406 = float(int((-((0.0f < vertex_unnamed_397) ? 4294967295u : 0u)) + ((vertex_unnamed_397 < 0.0f) ? 4294967295u : 0u)));
				precise float vertex_unnamed_413 = vertex_unnamed_406 * vertex_input_2.x;
				precise float vertex_unnamed_414 = vertex_unnamed_406 * vertex_input_2.y;
				precise float vertex_unnamed_415 = vertex_unnamed_406 * vertex_input_2.z;
				float vertex_unnamed_421 = dot(float3(vertex_unnamed_413, vertex_unnamed_414, vertex_unnamed_415), float3(vertex_uniform_buffer_3[4u].xyz));
				float vertex_unnamed_429 = dot(float3(vertex_unnamed_413, vertex_unnamed_414, vertex_unnamed_415), float3(vertex_uniform_buffer_3[5u].xyz));
				float vertex_unnamed_437 = dot(float3(vertex_unnamed_413, vertex_unnamed_414, vertex_unnamed_415), float3(vertex_uniform_buffer_3[6u].xyz));
				float vertex_unnamed_443 = rsqrt(dot(float3(vertex_unnamed_421, vertex_unnamed_429, vertex_unnamed_437), float3(vertex_unnamed_421, vertex_unnamed_429, vertex_unnamed_437)));
				precise float vertex_unnamed_444 = vertex_unnamed_443 * vertex_unnamed_421;
				precise float vertex_unnamed_445 = vertex_unnamed_443 * vertex_unnamed_429;
				precise float vertex_unnamed_446 = vertex_unnamed_443 * vertex_unnamed_437;
				precise float vertex_unnamed_447 = vertex_unnamed_443 * vertex_unnamed_437;
				precise float vertex_unnamed_448 = (-0.0f) - vertex_unnamed_125;
				precise float vertex_unnamed_449 = (-0.0f) - vertex_unnamed_126;
				precise float vertex_unnamed_450 = (-0.0f) - vertex_unnamed_127;
				precise float vertex_unnamed_456 = vertex_unnamed_448 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_457 = vertex_unnamed_449 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_458 = vertex_unnamed_450 + vertex_uniform_buffer_1[4u].z;
				float vertex_unnamed_462 = rsqrt(dot(float3(vertex_unnamed_456, vertex_unnamed_457, vertex_unnamed_458), float3(vertex_unnamed_456, vertex_unnamed_457, vertex_unnamed_458)));
				precise float vertex_unnamed_463 = vertex_unnamed_456 * vertex_unnamed_462;
				precise float vertex_unnamed_464 = vertex_unnamed_457 * vertex_unnamed_462;
				precise float vertex_unnamed_465 = vertex_unnamed_458 * vertex_unnamed_462;
				vertex_output_2.y = mad(abs(dot(float3(vertex_unnamed_444, vertex_unnamed_445, vertex_unnamed_447), float3(vertex_unnamed_463, vertex_unnamed_464, vertex_unnamed_465))), mad(vertex_unnamed_317, vertex_unnamed_331, vertex_unnamed_339), vertex_unnamed_338);
				vertex_output_3.w = vertex_unnamed_125;
				precise float vertex_unnamed_480 = vertex_input_1.y * vertex_uniform_buffer_3[1u].y;
				precise float vertex_unnamed_481 = vertex_input_1.y * vertex_uniform_buffer_3[1u].z;
				precise float vertex_unnamed_482 = vertex_input_1.y * vertex_uniform_buffer_3[1u].x;
				float vertex_unnamed_500 = mad(vertex_uniform_buffer_3[2u].y, vertex_input_1.z, mad(vertex_uniform_buffer_3[0u].y, vertex_input_1.x, vertex_unnamed_480));
				float vertex_unnamed_501 = mad(vertex_uniform_buffer_3[2u].z, vertex_input_1.z, mad(vertex_uniform_buffer_3[0u].z, vertex_input_1.x, vertex_unnamed_481));
				float vertex_unnamed_502 = mad(vertex_uniform_buffer_3[2u].x, vertex_input_1.z, mad(vertex_uniform_buffer_3[0u].x, vertex_input_1.x, vertex_unnamed_482));
				float vertex_unnamed_506 = rsqrt(dot(float3(vertex_unnamed_500, vertex_unnamed_501, vertex_unnamed_502), float3(vertex_unnamed_500, vertex_unnamed_501, vertex_unnamed_502)));
				precise float vertex_unnamed_507 = vertex_unnamed_506 * vertex_unnamed_500;
				precise float vertex_unnamed_508 = vertex_unnamed_506 * vertex_unnamed_501;
				precise float vertex_unnamed_509 = vertex_unnamed_506 * vertex_unnamed_502;
				precise float vertex_unnamed_510 = vertex_unnamed_507 * vertex_unnamed_447;
				precise float vertex_unnamed_511 = vertex_unnamed_508 * vertex_unnamed_444;
				precise float vertex_unnamed_512 = vertex_unnamed_509 * vertex_unnamed_445;
				precise float vertex_unnamed_513 = (-0.0f) - vertex_unnamed_510;
				precise float vertex_unnamed_514 = (-0.0f) - vertex_unnamed_511;
				precise float vertex_unnamed_515 = (-0.0f) - vertex_unnamed_512;
				precise float vertex_unnamed_525 = vertex_input_1.w * vertex_uniform_buffer_3[9u].w;
				precise float vertex_unnamed_526 = vertex_unnamed_525 * mad(vertex_unnamed_445, vertex_unnamed_508, vertex_unnamed_513);
				precise float vertex_unnamed_527 = vertex_unnamed_525 * mad(vertex_unnamed_447, vertex_unnamed_509, vertex_unnamed_514);
				precise float vertex_unnamed_528 = vertex_unnamed_525 * mad(vertex_unnamed_444, vertex_unnamed_507, vertex_unnamed_515);
				vertex_output_3.y = vertex_unnamed_526;
				vertex_output_3.z = vertex_unnamed_444;
				vertex_output_3.x = vertex_unnamed_509;
				vertex_output_4.x = vertex_unnamed_507;
				vertex_output_5.x = vertex_unnamed_508;
				vertex_output_4.w = vertex_unnamed_126;
				vertex_output_5.w = vertex_unnamed_127;
				vertex_output_4.z = vertex_unnamed_445;
				vertex_output_4.y = vertex_unnamed_527;
				vertex_output_5.y = vertex_unnamed_528;
				vertex_output_5.z = vertex_unnamed_447;
				vertex_output_6.x = vertex_input_7.x;
				vertex_output_6.y = vertex_input_7.y;
				vertex_output_6.z = vertex_input_7.z;
				vertex_output_6.w = vertex_input_7.w;
				precise float vertex_unnamed_558 = vertex_unnamed_457 * vertex_uniform_buffer_0[14u].x;
				precise float vertex_unnamed_559 = vertex_unnamed_457 * vertex_uniform_buffer_0[14u].y;
				precise float vertex_unnamed_560 = vertex_unnamed_457 * vertex_uniform_buffer_0[14u].z;
				vertex_output_7.x = mad(vertex_uniform_buffer_0[15u].x, vertex_unnamed_458, mad(vertex_uniform_buffer_0[13u].x, vertex_unnamed_456, vertex_unnamed_558));
				vertex_output_7.y = mad(vertex_uniform_buffer_0[15u].y, vertex_unnamed_458, mad(vertex_uniform_buffer_0[13u].y, vertex_unnamed_456, vertex_unnamed_559));
				vertex_output_7.z = mad(vertex_uniform_buffer_0[15u].z, vertex_unnamed_458, mad(vertex_uniform_buffer_0[13u].z, vertex_unnamed_456, vertex_unnamed_560));
				precise float vertex_unnamed_582 = vertex_unnamed_445 * vertex_unnamed_445;
				precise float vertex_unnamed_583 = (-0.0f) - vertex_unnamed_582;
				float vertex_unnamed_584 = mad(vertex_unnamed_444, vertex_unnamed_444, vertex_unnamed_583);
				precise float vertex_unnamed_585 = vertex_unnamed_445 * vertex_unnamed_444;
				precise float vertex_unnamed_586 = vertex_unnamed_447 * vertex_unnamed_445;
				precise float vertex_unnamed_587 = vertex_unnamed_446 * vertex_unnamed_446;
				precise float vertex_unnamed_588 = vertex_unnamed_444 * vertex_unnamed_447;
				vertex_output_8.x = mad(vertex_uniform_buffer_2[45u].x, vertex_unnamed_584, dot(float4(vertex_uniform_buffer_2[42u]), float4(vertex_unnamed_585, vertex_unnamed_586, vertex_unnamed_587, vertex_unnamed_588)));
				vertex_output_8.y = mad(vertex_uniform_buffer_2[45u].y, vertex_unnamed_584, dot(float4(vertex_uniform_buffer_2[43u]), float4(vertex_unnamed_585, vertex_unnamed_586, vertex_unnamed_587, vertex_unnamed_588)));
				vertex_output_8.z = mad(vertex_uniform_buffer_2[45u].z, vertex_unnamed_584, dot(float4(vertex_uniform_buffer_2[44u]), float4(vertex_unnamed_585, vertex_unnamed_586, vertex_unnamed_587, vertex_unnamed_588)));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_FaceDilate, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[13] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				vertex_uniform_buffer_0[14] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				vertex_uniform_buffer_0[15] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				vertex_uniform_buffer_0[16] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], _WeightNormal, vertex_uniform_buffer_0[24][2], vertex_uniform_buffer_0[24][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], vertex_uniform_buffer_0[24][1], _WeightBold, vertex_uniform_buffer_0[24][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], vertex_uniform_buffer_0[24][1], vertex_uniform_buffer_0[24][2], _ScaleRatioA);

				vertex_uniform_buffer_0[25] = float4(vertex_uniform_buffer_0[25][0], vertex_uniform_buffer_0[25][1], _VertexOffsetX, vertex_uniform_buffer_0[25][3]);

				vertex_uniform_buffer_0[25] = float4(vertex_uniform_buffer_0[25][0], vertex_uniform_buffer_0[25][1], vertex_uniform_buffer_0[25][2], _VertexOffsetY);

				vertex_uniform_buffer_0[30] = float4(_GradientScale, vertex_uniform_buffer_0[30][1], vertex_uniform_buffer_0[30][2], vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], _ScaleX, vertex_uniform_buffer_0[30][2], vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], vertex_uniform_buffer_0[30][1], _ScaleY, vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], vertex_uniform_buffer_0[30][1], vertex_uniform_buffer_0[30][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[31] = float4(_Sharpness, vertex_uniform_buffer_0[31][1], vertex_uniform_buffer_0[31][2], vertex_uniform_buffer_0[31][3]);

				vertex_uniform_buffer_0[32] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_0[33] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[34] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

				vertex_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], vertex_uniform_buffer_1[4][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[42] = float4(unity_SHBr[0], unity_SHBr[1], unity_SHBr[2], unity_SHBr[3]);

				vertex_uniform_buffer_2[43] = float4(unity_SHBg[0], unity_SHBg[1], unity_SHBg[2], unity_SHBg[3]);

				vertex_uniform_buffer_2[44] = float4(unity_SHBb[0], unity_SHBb[1], unity_SHBb[2], unity_SHBb[3]);

				vertex_uniform_buffer_2[45] = float4(unity_SHC[0], unity_SHC[1], unity_SHC[2], unity_SHC[3]);

				vertex_uniform_buffer_3[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_3[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_3[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_3[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_3[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_3[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_3[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_3[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				vertex_uniform_buffer_4[5] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				vertex_uniform_buffer_4[6] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				vertex_uniform_buffer_4[7] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				vertex_uniform_buffer_4[8] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

				vertex_uniform_buffer_4[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_4[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_4[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_4[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vertex_input_7 = stage_input.vertex_input_7;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				return stage_output;
			}


			float4 _LightColor0;
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
			float4 _WorldSpaceLightPos0;
			float4 unity_SHAr;
			float4 unity_SHAg;
			float4 unity_SHAb;
			float4 unity_OcclusionMaskSelector;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[25];
			static float4 fragment_uniform_buffer_1[1];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_input_6;
			static float3 fragment_input_7;
			static float3 fragment_input_8;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float2 fragment_input_2 : TEXCOORD5; // TEXCOORD_5
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
				float4 fragment_input_6 : COLOR; // COLOR
				float3 fragment_input_7 : TEXCOORD6; // TEXCOORD_6
				float3 fragment_input_8 : TEXCOORD7; // TEXCOORD_7
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_79 = (-0.0f) - _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
				precise float fragment_unnamed_81 = fragment_unnamed_79 + 0.5f;
				precise float fragment_unnamed_85 = (-0.0f) - fragment_input_2.x;
				precise float fragment_unnamed_86 = fragment_unnamed_81 + fragment_unnamed_85;
				float fragment_unnamed_90 = mad(fragment_unnamed_86, fragment_input_2.y, 0.5f);
				precise float fragment_unnamed_100 = fragment_uniform_buffer_0[8u].x * fragment_uniform_buffer_0[24u].w;
				precise float fragment_unnamed_108 = fragment_uniform_buffer_0[6u].y * fragment_uniform_buffer_0[24u].w;
				precise float fragment_unnamed_111 = fragment_unnamed_100 * fragment_input_2.y;
				precise float fragment_unnamed_112 = fragment_unnamed_108 * fragment_input_2.y;
				precise float fragment_unnamed_130 = fragment_input_6.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_131 = fragment_input_6.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_132 = fragment_input_6.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_133 = fragment_input_6.w * fragment_uniform_buffer_0[5u].w;
				precise float fragment_unnamed_139 = fragment_input_6.w * fragment_uniform_buffer_0[7u].w;
				float4 fragment_unnamed_155 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[4u].x, fragment_uniform_buffer_1[0u].y, fragment_input_1.z), mad(fragment_uniform_buffer_0[4u].y, fragment_uniform_buffer_1[0u].y, fragment_input_1.w)));
				precise float fragment_unnamed_161 = fragment_unnamed_130 * fragment_unnamed_155.x;
				precise float fragment_unnamed_162 = fragment_unnamed_131 * fragment_unnamed_155.y;
				precise float fragment_unnamed_163 = fragment_unnamed_132 * fragment_unnamed_155.z;
				precise float fragment_unnamed_164 = fragment_unnamed_133 * fragment_unnamed_155.w;
				float4 fragment_unnamed_179 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[6u].z, fragment_uniform_buffer_1[0u].y, fragment_input_2.x), mad(fragment_uniform_buffer_0[6u].w, fragment_uniform_buffer_1[0u].y, fragment_input_2.y)));
				precise float fragment_unnamed_190 = fragment_unnamed_179.x * fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_191 = fragment_unnamed_179.y * fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_192 = fragment_unnamed_179.z * fragment_uniform_buffer_0[7u].z;
				precise float fragment_unnamed_193 = fragment_unnamed_139 * fragment_unnamed_179.w;
				precise float fragment_unnamed_194 = (-0.0f) - fragment_unnamed_111;
				precise float fragment_unnamed_201 = mad(fragment_unnamed_112, 0.5f, mad(fragment_unnamed_194, 0.5f, fragment_unnamed_90)) / mad(fragment_unnamed_108, fragment_input_2.y, 1.0f);
				precise float fragment_unnamed_203 = (-0.0f) - clamp(fragment_unnamed_201, 0.0f, 1.0f);
				precise float fragment_unnamed_204 = fragment_unnamed_203 + 1.0f;
				precise float fragment_unnamed_209 = sqrt(min(fragment_unnamed_111, 1.0f)) * clamp(mad(fragment_unnamed_111, 0.5f, fragment_unnamed_90), 0.0f, 1.0f);
				precise float fragment_unnamed_210 = fragment_unnamed_164 * fragment_unnamed_161;
				precise float fragment_unnamed_211 = fragment_unnamed_164 * fragment_unnamed_162;
				precise float fragment_unnamed_212 = fragment_unnamed_164 * fragment_unnamed_163;
				precise float fragment_unnamed_213 = fragment_unnamed_190 * fragment_unnamed_193;
				precise float fragment_unnamed_214 = fragment_unnamed_191 * fragment_unnamed_193;
				precise float fragment_unnamed_215 = fragment_unnamed_192 * fragment_unnamed_193;
				precise float fragment_unnamed_216 = (-0.0f) - fragment_unnamed_210;
				precise float fragment_unnamed_217 = (-0.0f) - fragment_unnamed_211;
				precise float fragment_unnamed_218 = (-0.0f) - fragment_unnamed_212;
				precise float fragment_unnamed_219 = (-0.0f) - fragment_unnamed_164;
				precise float fragment_unnamed_220 = fragment_unnamed_216 + fragment_unnamed_213;
				precise float fragment_unnamed_221 = fragment_unnamed_217 + fragment_unnamed_214;
				precise float fragment_unnamed_222 = fragment_unnamed_218 + fragment_unnamed_215;
				precise float fragment_unnamed_223 = fragment_unnamed_219 + fragment_unnamed_193;
				precise float fragment_unnamed_228 = fragment_unnamed_204 * mad(fragment_unnamed_209, fragment_unnamed_220, fragment_unnamed_210);
				precise float fragment_unnamed_229 = fragment_unnamed_204 * mad(fragment_unnamed_209, fragment_unnamed_221, fragment_unnamed_211);
				precise float fragment_unnamed_230 = fragment_unnamed_204 * mad(fragment_unnamed_209, fragment_unnamed_222, fragment_unnamed_212);
				precise float fragment_unnamed_231 = fragment_unnamed_204 * mad(fragment_unnamed_209, fragment_unnamed_223, fragment_unnamed_164);
				float fragment_unnamed_232 = max(fragment_unnamed_231, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_234 = fragment_unnamed_228 / fragment_unnamed_232;
				precise float fragment_unnamed_235 = fragment_unnamed_229 / fragment_unnamed_232;
				precise float fragment_unnamed_236 = fragment_unnamed_230 / fragment_unnamed_232;
				bool fragment_unnamed_241 = fragment_uniform_buffer_3[0u].x == 1.0f;
				float fragment_unnamed_342;
				float fragment_unnamed_343;
				float fragment_unnamed_344;
				float fragment_unnamed_345;
				if (fragment_unnamed_241)
				{
					bool fragment_unnamed_245 = fragment_uniform_buffer_3[0u].y == 1.0f;
					precise float fragment_unnamed_253 = fragment_input_4.w * fragment_uniform_buffer_3[2u].x;
					precise float fragment_unnamed_254 = fragment_input_4.w * fragment_uniform_buffer_3[2u].y;
					precise float fragment_unnamed_255 = fragment_input_4.w * fragment_uniform_buffer_3[2u].z;
					precise float fragment_unnamed_281 = mad(fragment_uniform_buffer_3[3u].x, fragment_input_5.w, mad(fragment_uniform_buffer_3[1u].x, fragment_input_3.w, fragment_unnamed_253)) + fragment_uniform_buffer_3[4u].x;
					precise float fragment_unnamed_282 = mad(fragment_uniform_buffer_3[3u].y, fragment_input_5.w, mad(fragment_uniform_buffer_3[1u].y, fragment_input_3.w, fragment_unnamed_254)) + fragment_uniform_buffer_3[4u].y;
					precise float fragment_unnamed_283 = mad(fragment_uniform_buffer_3[3u].z, fragment_input_5.w, mad(fragment_uniform_buffer_3[1u].z, fragment_input_3.w, fragment_unnamed_255)) + fragment_uniform_buffer_3[4u].z;
					precise float fragment_unnamed_305 = (-0.0f) - fragment_uniform_buffer_3[6u].x;
					precise float fragment_unnamed_307 = (-0.0f) - fragment_uniform_buffer_3[6u].y;
					precise float fragment_unnamed_309 = (-0.0f) - fragment_uniform_buffer_3[6u].z;
					precise float fragment_unnamed_310 = asfloat(fragment_unnamed_245 ? asuint(fragment_unnamed_281) : asuint(fragment_input_3.w)) + fragment_unnamed_305;
					precise float fragment_unnamed_311 = asfloat(fragment_unnamed_245 ? asuint(fragment_unnamed_282) : asuint(fragment_input_4.w)) + fragment_unnamed_307;
					precise float fragment_unnamed_312 = asfloat(fragment_unnamed_245 ? asuint(fragment_unnamed_283) : asuint(fragment_input_5.w)) + fragment_unnamed_309;
					precise float fragment_unnamed_318 = fragment_unnamed_310 * fragment_uniform_buffer_3[5u].x;
					precise float fragment_unnamed_319 = fragment_unnamed_311 * fragment_uniform_buffer_3[5u].y;
					precise float fragment_unnamed_320 = fragment_unnamed_312 * fragment_uniform_buffer_3[5u].z;
					float4 fragment_unnamed_331 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_uniform_buffer_3[0u].z, 0.5f, 0.75f), mad(fragment_unnamed_318, 0.25f, 0.75f)), fragment_unnamed_319, fragment_unnamed_320));
					fragment_unnamed_342 = fragment_unnamed_331.x;
					fragment_unnamed_343 = fragment_unnamed_331.y;
					fragment_unnamed_344 = fragment_unnamed_331.z;
					fragment_unnamed_345 = fragment_unnamed_331.w;
				}
				else
				{
					fragment_unnamed_342 = asfloat(1065353216u);
					fragment_unnamed_343 = asfloat(1065353216u);
					fragment_unnamed_344 = asfloat(1065353216u);
					fragment_unnamed_345 = asfloat(1065353216u);
				}
				float fragment_unnamed_356 = clamp(dot(float4(fragment_unnamed_342, fragment_unnamed_343, fragment_unnamed_344, fragment_unnamed_345), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f);
				float fragment_unnamed_366 = rsqrt(dot(float3(fragment_input_3.z, fragment_input_4.z, fragment_input_5.z), float3(fragment_input_3.z, fragment_input_4.z, fragment_input_5.z)));
				precise float fragment_unnamed_367 = fragment_unnamed_366 * fragment_input_3.z;
				precise float fragment_unnamed_368 = fragment_unnamed_366 * fragment_input_4.z;
				precise float fragment_unnamed_369 = fragment_unnamed_366 * fragment_input_5.z;
				precise float fragment_unnamed_375 = fragment_unnamed_356 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_376 = fragment_unnamed_356 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_377 = fragment_unnamed_356 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_535;
				float fragment_unnamed_536;
				float fragment_unnamed_537;
				if (fragment_unnamed_241)
				{
					bool fragment_unnamed_381 = fragment_uniform_buffer_3[0u].y == 1.0f;
					precise float fragment_unnamed_389 = fragment_input_4.w * fragment_uniform_buffer_3[2u].x;
					precise float fragment_unnamed_390 = fragment_input_4.w * fragment_uniform_buffer_3[2u].y;
					precise float fragment_unnamed_391 = fragment_input_4.w * fragment_uniform_buffer_3[2u].z;
					precise float fragment_unnamed_417 = mad(fragment_uniform_buffer_3[3u].x, fragment_input_5.w, mad(fragment_uniform_buffer_3[1u].x, fragment_input_3.w, fragment_unnamed_389)) + fragment_uniform_buffer_3[4u].x;
					precise float fragment_unnamed_418 = mad(fragment_uniform_buffer_3[3u].y, fragment_input_5.w, mad(fragment_uniform_buffer_3[1u].y, fragment_input_3.w, fragment_unnamed_390)) + fragment_uniform_buffer_3[4u].y;
					precise float fragment_unnamed_419 = mad(fragment_uniform_buffer_3[3u].z, fragment_input_5.w, mad(fragment_uniform_buffer_3[1u].z, fragment_input_3.w, fragment_unnamed_391)) + fragment_uniform_buffer_3[4u].z;
					precise float fragment_unnamed_441 = (-0.0f) - fragment_uniform_buffer_3[6u].x;
					precise float fragment_unnamed_443 = (-0.0f) - fragment_uniform_buffer_3[6u].y;
					precise float fragment_unnamed_445 = (-0.0f) - fragment_uniform_buffer_3[6u].z;
					precise float fragment_unnamed_446 = asfloat(fragment_unnamed_381 ? asuint(fragment_unnamed_417) : asuint(fragment_input_3.w)) + fragment_unnamed_441;
					precise float fragment_unnamed_447 = asfloat(fragment_unnamed_381 ? asuint(fragment_unnamed_418) : asuint(fragment_input_4.w)) + fragment_unnamed_443;
					precise float fragment_unnamed_448 = asfloat(fragment_unnamed_381 ? asuint(fragment_unnamed_419) : asuint(fragment_input_5.w)) + fragment_unnamed_445;
					precise float fragment_unnamed_454 = fragment_unnamed_446 * fragment_uniform_buffer_3[5u].x;
					precise float fragment_unnamed_455 = fragment_unnamed_447 * fragment_uniform_buffer_3[5u].y;
					precise float fragment_unnamed_456 = fragment_unnamed_448 * fragment_uniform_buffer_3[5u].z;
					precise float fragment_unnamed_457 = fragment_unnamed_454 * 0.25f;
					precise float fragment_unnamed_461 = fragment_uniform_buffer_3[0u].z * 0.5f;
					precise float fragment_unnamed_465 = (-0.0f) - fragment_uniform_buffer_3[0u].z;
					float fragment_unnamed_468 = min(mad(fragment_unnamed_465, 0.5f, 0.25f), max(fragment_unnamed_457, fragment_unnamed_461));
					precise float fragment_unnamed_476 = fragment_unnamed_468 + 0.25f;
					precise float fragment_unnamed_477 = fragment_unnamed_455 + 0.0f;
					precise float fragment_unnamed_478 = fragment_unnamed_456 + 0.0f;
					precise float fragment_unnamed_485 = fragment_unnamed_468 + 0.5f;
					precise float fragment_unnamed_486 = fragment_unnamed_455 + 0.0f;
					precise float fragment_unnamed_487 = fragment_unnamed_456 + 0.0f;
					float fragment_unnamed_494 = asfloat(1065353216u);
					fragment_unnamed_535 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_476, fragment_unnamed_477, fragment_unnamed_478))), float4(fragment_unnamed_367, fragment_unnamed_368, fragment_unnamed_369, fragment_unnamed_494));
					fragment_unnamed_536 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_485, fragment_unnamed_486, fragment_unnamed_487))), float4(fragment_unnamed_367, fragment_unnamed_368, fragment_unnamed_369, fragment_unnamed_494));
					fragment_unnamed_537 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_468, fragment_unnamed_455, fragment_unnamed_456))), float4(fragment_unnamed_367, fragment_unnamed_368, fragment_unnamed_369, fragment_unnamed_494));
				}
				else
				{
					float fragment_unnamed_504 = asfloat(1065353216u);
					fragment_unnamed_535 = dot(float4(fragment_uniform_buffer_2[40u]), float4(fragment_unnamed_367, fragment_unnamed_368, fragment_unnamed_369, fragment_unnamed_504));
					fragment_unnamed_536 = dot(float4(fragment_uniform_buffer_2[41u]), float4(fragment_unnamed_367, fragment_unnamed_368, fragment_unnamed_369, fragment_unnamed_504));
					fragment_unnamed_537 = dot(float4(fragment_uniform_buffer_2[39u]), float4(fragment_unnamed_367, fragment_unnamed_368, fragment_unnamed_369, fragment_unnamed_504));
				}
				precise float fragment_unnamed_544 = fragment_unnamed_537 + fragment_input_8.x;
				precise float fragment_unnamed_545 = fragment_unnamed_535 + fragment_input_8.y;
				precise float fragment_unnamed_546 = fragment_unnamed_536 + fragment_input_8.z;
				precise float fragment_unnamed_553 = log2(max(fragment_unnamed_544, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_555 = log2(max(fragment_unnamed_545, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_556 = log2(max(fragment_unnamed_546, 0.0f)) * 0.4166666567325592041015625f;
				float fragment_unnamed_576 = max(dot(float3(fragment_unnamed_367, fragment_unnamed_368, fragment_unnamed_369), float3(fragment_uniform_buffer_2[0u].xyz)), 0.0f);
				precise float fragment_unnamed_577 = fragment_unnamed_234 * fragment_unnamed_375;
				precise float fragment_unnamed_578 = fragment_unnamed_235 * fragment_unnamed_376;
				precise float fragment_unnamed_579 = fragment_unnamed_236 * fragment_unnamed_377;
				precise float fragment_unnamed_580 = fragment_unnamed_234 * max(mad(exp2(fragment_unnamed_553), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f);
				precise float fragment_unnamed_581 = fragment_unnamed_235 * max(mad(exp2(fragment_unnamed_555), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f);
				precise float fragment_unnamed_582 = fragment_unnamed_236 * max(mad(exp2(fragment_unnamed_556), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f);
				fragment_output_0.x = mad(fragment_unnamed_577, fragment_unnamed_576, fragment_unnamed_580);
				fragment_output_0.y = mad(fragment_unnamed_578, fragment_unnamed_576, fragment_unnamed_581);
				fragment_output_0.z = mad(fragment_unnamed_579, fragment_unnamed_576, fragment_unnamed_582);
				fragment_output_0.w = fragment_unnamed_231;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[4] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _FaceUVSpeedY, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[5] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], _OutlineSoftness, fragment_uniform_buffer_0[6][2], fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], fragment_uniform_buffer_0[6][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], fragment_uniform_buffer_0[6][1], fragment_uniform_buffer_0[6][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[7] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[8] = float4(_OutlineWidth, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[24] = float4(fragment_uniform_buffer_0[24][0], fragment_uniform_buffer_0[24][1], fragment_uniform_buffer_0[24][2], _ScaleRatioA);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_uniform_buffer_2[39] = float4(unity_SHAr[0], unity_SHAr[1], unity_SHAr[2], unity_SHAr[3]);

				fragment_uniform_buffer_2[40] = float4(unity_SHAg[0], unity_SHAg[1], unity_SHAg[2], unity_SHAg[3]);

				fragment_uniform_buffer_2[41] = float4(unity_SHAb[0], unity_SHAb[1], unity_SHAb[2], unity_SHAb[3]);

				fragment_uniform_buffer_2[46] = float4(unity_OcclusionMaskSelector[0], unity_OcclusionMaskSelector[1], unity_OcclusionMaskSelector[2], unity_OcclusionMaskSelector[3]);

				fragment_uniform_buffer_3[0] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_3[1] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_3[2] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_3[3] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_3[4] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_3[5] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], fragment_uniform_buffer_3[5][3]);

				fragment_uniform_buffer_3[6] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], fragment_uniform_buffer_3[6][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(DIRECTIONAL) && defined(LIGHTPROBE_SH) && !defined(VERTEXLIGHT_ON)


			#if defined(DIRECTIONAL) && defined(LIGHTPROBE_SH) && defined(VERTEXLIGHT_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _FaceDilate;
			float4x4 _EnvMatrix;
			float _WeightNormal;
			float _WeightBold;
			float _ScaleRatioA;
			float _VertexOffsetX;
			float _VertexOffsetY;
			float _GradientScale;
			float _ScaleX;
			float _ScaleY;
			float _PerspectiveFilter;
			float _Sharpness;
			float4 _MainTex_ST;
			float4 _FaceTex_ST;
			float4 _OutlineTex_ST;
			float3 _WorldSpaceCameraPos;
			float4 _ScreenParams;
			float4 unity_4LightPosX0;
			float4 unity_4LightPosY0;
			float4 unity_4LightPosZ0;
			float4 unity_4LightAtten0;
			float4 unity_LightColor[8];
			float4 unity_SHBr;
			float4 unity_SHBg;
			float4 unity_SHBb;
			float4 unity_SHC;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[35];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[46];
			static float4 vertex_uniform_buffer_3[10];
			static float4 vertex_uniform_buffer_4[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float4 vertex_output_1;
			static float2 vertex_output_2;
			static float2 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;
			static float3 vertex_output_7;
			static float3 vertex_output_8;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float4 vertex_input_1 : TANGENT; // TANGENT
				float3 vertex_input_2 : NORMAL; // NORMAL
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_input_7 : COLOR; // COLOR
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float2 vertex_output_2 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float4 vertex_output_6 : COLOR; // COLOR
				float3 vertex_output_7 : TEXCOORD6; // TEXCOORD_6
				float3 vertex_output_8 : TEXCOORD7; // TEXCOORD_7
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_71 = vertex_input_0.x + vertex_uniform_buffer_0[25u].z;
				precise float vertex_unnamed_72 = vertex_input_0.y + vertex_uniform_buffer_0[25u].w;
				precise float vertex_unnamed_79 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].x;
				precise float vertex_unnamed_80 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].y;
				precise float vertex_unnamed_81 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].z;
				precise float vertex_unnamed_82 = vertex_unnamed_72 * vertex_uniform_buffer_3[1u].w;
				float vertex_unnamed_103 = mad(vertex_uniform_buffer_3[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].x, vertex_unnamed_71, vertex_unnamed_79));
				float vertex_unnamed_104 = mad(vertex_uniform_buffer_3[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].y, vertex_unnamed_71, vertex_unnamed_80));
				float vertex_unnamed_105 = mad(vertex_uniform_buffer_3[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].z, vertex_unnamed_71, vertex_unnamed_81));
				precise float vertex_unnamed_114 = vertex_unnamed_103 + vertex_uniform_buffer_3[3u].x;
				precise float vertex_unnamed_115 = vertex_unnamed_104 + vertex_uniform_buffer_3[3u].y;
				precise float vertex_unnamed_116 = vertex_unnamed_105 + vertex_uniform_buffer_3[3u].z;
				precise float vertex_unnamed_117 = mad(vertex_uniform_buffer_3[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].w, vertex_unnamed_71, vertex_unnamed_82)) + vertex_uniform_buffer_3[3u].w;
				float vertex_unnamed_125 = mad(vertex_uniform_buffer_3[3u].x, vertex_input_0.w, vertex_unnamed_103);
				float vertex_unnamed_126 = mad(vertex_uniform_buffer_3[3u].y, vertex_input_0.w, vertex_unnamed_104);
				float vertex_unnamed_127 = mad(vertex_uniform_buffer_3[3u].z, vertex_input_0.w, vertex_unnamed_105);
				precise float vertex_unnamed_135 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].x;
				precise float vertex_unnamed_136 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].y;
				precise float vertex_unnamed_137 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].z;
				precise float vertex_unnamed_138 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_4[20u].x, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].x, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].x, vertex_unnamed_114, vertex_unnamed_135)));
				gl_Position.y = mad(vertex_uniform_buffer_4[20u].y, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].y, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].y, vertex_unnamed_114, vertex_unnamed_136)));
				gl_Position.z = mad(vertex_uniform_buffer_4[20u].z, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].z, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].z, vertex_unnamed_114, vertex_unnamed_137)));
				gl_Position.w = mad(vertex_uniform_buffer_4[20u].w, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].w, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].w, vertex_unnamed_114, vertex_unnamed_138)));
				precise float vertex_unnamed_179 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_181 = floor(vertex_unnamed_179);
				precise float vertex_unnamed_182 = (-0.0f) - vertex_unnamed_181;
				precise float vertex_unnamed_188 = vertex_unnamed_181 * 0.001953125f;
				precise float vertex_unnamed_190 = mad(vertex_unnamed_182, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_1.z = mad(vertex_unnamed_188, vertex_uniform_buffer_0[33u].x, vertex_uniform_buffer_0[33u].z);
				vertex_output_1.w = mad(vertex_unnamed_190, vertex_uniform_buffer_0[33u].y, vertex_uniform_buffer_0[33u].w);
				vertex_output_2.x = mad(vertex_unnamed_188, vertex_uniform_buffer_0[34u].x, vertex_uniform_buffer_0[34u].z);
				vertex_output_2.y = mad(vertex_unnamed_190, vertex_uniform_buffer_0[34u].y, vertex_uniform_buffer_0[34u].w);
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[32u].x, vertex_uniform_buffer_0[32u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[32u].y, vertex_uniform_buffer_0[32u].w);
				precise float vertex_unnamed_248 = (-0.0f) - vertex_uniform_buffer_0[24u].y;
				precise float vertex_unnamed_252 = vertex_unnamed_248 + vertex_uniform_buffer_0[24u].z;
				precise float vertex_unnamed_266 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_252, vertex_uniform_buffer_0[24u].y), 0.25f, vertex_uniform_buffer_0[6u].x) * vertex_uniform_buffer_0[24u].w;
				precise float vertex_unnamed_267 = vertex_unnamed_266 * 0.5f;
				vertex_output_2.x = vertex_unnamed_267;
				precise float vertex_unnamed_273 = vertex_unnamed_115 * vertex_uniform_buffer_4[18u].w;
				float vertex_unnamed_285 = mad(vertex_uniform_buffer_4[20u].w, vertex_unnamed_117, mad(vertex_uniform_buffer_4[19u].w, vertex_unnamed_116, mad(vertex_uniform_buffer_4[17u].w, vertex_unnamed_114, vertex_unnamed_273)));
				precise float vertex_unnamed_293 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_4[6u].x;
				precise float vertex_unnamed_294 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_4[6u].y;
				precise float vertex_unnamed_310 = mad(vertex_uniform_buffer_4[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_293) * vertex_uniform_buffer_0[30u].y;
				precise float vertex_unnamed_311 = mad(vertex_uniform_buffer_4[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_294) * vertex_uniform_buffer_0[30u].z;
				precise float vertex_unnamed_312 = vertex_unnamed_285 / vertex_unnamed_310;
				precise float vertex_unnamed_313 = vertex_unnamed_285 / vertex_unnamed_311;
				float vertex_unnamed_317 = rsqrt(dot(float2(vertex_unnamed_312, vertex_unnamed_313), float2(vertex_unnamed_312, vertex_unnamed_313)));
				precise float vertex_unnamed_324 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[30u].x;
				precise float vertex_unnamed_329 = vertex_uniform_buffer_0[31u].x + 1.0f;
				precise float vertex_unnamed_331 = vertex_unnamed_324 * vertex_unnamed_329;
				precise float vertex_unnamed_332 = vertex_unnamed_317 * vertex_unnamed_331;
				precise float vertex_unnamed_336 = (-0.0f) - vertex_uniform_buffer_0[30u].w;
				precise float vertex_unnamed_337 = vertex_unnamed_336 + 1.0f;
				precise float vertex_unnamed_338 = vertex_unnamed_337 * vertex_unnamed_332;
				precise float vertex_unnamed_339 = (-0.0f) - vertex_unnamed_338;
				precise float vertex_unnamed_350 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_3[5u].x;
				precise float vertex_unnamed_351 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_3[5u].y;
				precise float vertex_unnamed_352 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_3[5u].z;
				precise float vertex_unnamed_380 = mad(vertex_uniform_buffer_3[6u].x, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_3[4u].x, vertex_uniform_buffer_1[4u].x, vertex_unnamed_350)) + vertex_uniform_buffer_3[7u].x;
				precise float vertex_unnamed_381 = mad(vertex_uniform_buffer_3[6u].y, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_3[4u].y, vertex_uniform_buffer_1[4u].x, vertex_unnamed_351)) + vertex_uniform_buffer_3[7u].y;
				precise float vertex_unnamed_382 = mad(vertex_uniform_buffer_3[6u].z, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_3[4u].z, vertex_uniform_buffer_1[4u].x, vertex_unnamed_352)) + vertex_uniform_buffer_3[7u].z;
				precise float vertex_unnamed_385 = (-0.0f) - vertex_unnamed_71;
				precise float vertex_unnamed_386 = (-0.0f) - vertex_unnamed_72;
				precise float vertex_unnamed_387 = (-0.0f) - vertex_input_0.z;
				precise float vertex_unnamed_388 = vertex_unnamed_385 + vertex_unnamed_380;
				precise float vertex_unnamed_389 = vertex_unnamed_386 + vertex_unnamed_381;
				precise float vertex_unnamed_390 = vertex_unnamed_387 + vertex_unnamed_382;
				float vertex_unnamed_397 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_unnamed_388, vertex_unnamed_389, vertex_unnamed_390));
				float vertex_unnamed_406 = float(int((-((0.0f < vertex_unnamed_397) ? 4294967295u : 0u)) + ((vertex_unnamed_397 < 0.0f) ? 4294967295u : 0u)));
				precise float vertex_unnamed_413 = vertex_unnamed_406 * vertex_input_2.x;
				precise float vertex_unnamed_414 = vertex_unnamed_406 * vertex_input_2.y;
				precise float vertex_unnamed_415 = vertex_unnamed_406 * vertex_input_2.z;
				float vertex_unnamed_421 = dot(float3(vertex_unnamed_413, vertex_unnamed_414, vertex_unnamed_415), float3(vertex_uniform_buffer_3[4u].xyz));
				float vertex_unnamed_429 = dot(float3(vertex_unnamed_413, vertex_unnamed_414, vertex_unnamed_415), float3(vertex_uniform_buffer_3[5u].xyz));
				float vertex_unnamed_437 = dot(float3(vertex_unnamed_413, vertex_unnamed_414, vertex_unnamed_415), float3(vertex_uniform_buffer_3[6u].xyz));
				float vertex_unnamed_443 = rsqrt(dot(float3(vertex_unnamed_421, vertex_unnamed_429, vertex_unnamed_437), float3(vertex_unnamed_421, vertex_unnamed_429, vertex_unnamed_437)));
				precise float vertex_unnamed_444 = vertex_unnamed_443 * vertex_unnamed_421;
				precise float vertex_unnamed_445 = vertex_unnamed_443 * vertex_unnamed_429;
				precise float vertex_unnamed_446 = vertex_unnamed_443 * vertex_unnamed_437;
				precise float vertex_unnamed_447 = vertex_unnamed_443 * vertex_unnamed_437;
				precise float vertex_unnamed_448 = (-0.0f) - vertex_unnamed_125;
				precise float vertex_unnamed_449 = (-0.0f) - vertex_unnamed_126;
				precise float vertex_unnamed_450 = (-0.0f) - vertex_unnamed_127;
				precise float vertex_unnamed_456 = vertex_unnamed_448 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_457 = vertex_unnamed_449 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_458 = vertex_unnamed_450 + vertex_uniform_buffer_1[4u].z;
				float vertex_unnamed_462 = rsqrt(dot(float3(vertex_unnamed_456, vertex_unnamed_457, vertex_unnamed_458), float3(vertex_unnamed_456, vertex_unnamed_457, vertex_unnamed_458)));
				precise float vertex_unnamed_463 = vertex_unnamed_456 * vertex_unnamed_462;
				precise float vertex_unnamed_464 = vertex_unnamed_457 * vertex_unnamed_462;
				precise float vertex_unnamed_465 = vertex_unnamed_458 * vertex_unnamed_462;
				vertex_output_2.y = mad(abs(dot(float3(vertex_unnamed_444, vertex_unnamed_445, vertex_unnamed_447), float3(vertex_unnamed_463, vertex_unnamed_464, vertex_unnamed_465))), mad(vertex_unnamed_317, vertex_unnamed_331, vertex_unnamed_339), vertex_unnamed_338);
				precise float vertex_unnamed_479 = vertex_input_1.y * vertex_uniform_buffer_3[1u].y;
				precise float vertex_unnamed_480 = vertex_input_1.y * vertex_uniform_buffer_3[1u].z;
				precise float vertex_unnamed_481 = vertex_input_1.y * vertex_uniform_buffer_3[1u].x;
				float vertex_unnamed_499 = mad(vertex_uniform_buffer_3[2u].y, vertex_input_1.z, mad(vertex_uniform_buffer_3[0u].y, vertex_input_1.x, vertex_unnamed_479));
				float vertex_unnamed_500 = mad(vertex_uniform_buffer_3[2u].z, vertex_input_1.z, mad(vertex_uniform_buffer_3[0u].z, vertex_input_1.x, vertex_unnamed_480));
				float vertex_unnamed_501 = mad(vertex_uniform_buffer_3[2u].x, vertex_input_1.z, mad(vertex_uniform_buffer_3[0u].x, vertex_input_1.x, vertex_unnamed_481));
				float vertex_unnamed_505 = rsqrt(dot(float3(vertex_unnamed_499, vertex_unnamed_500, vertex_unnamed_501), float3(vertex_unnamed_499, vertex_unnamed_500, vertex_unnamed_501)));
				precise float vertex_unnamed_506 = vertex_unnamed_505 * vertex_unnamed_499;
				precise float vertex_unnamed_507 = vertex_unnamed_505 * vertex_unnamed_500;
				precise float vertex_unnamed_508 = vertex_unnamed_505 * vertex_unnamed_501;
				precise float vertex_unnamed_509 = vertex_unnamed_506 * vertex_unnamed_447;
				precise float vertex_unnamed_510 = vertex_unnamed_507 * vertex_unnamed_444;
				precise float vertex_unnamed_511 = vertex_unnamed_508 * vertex_unnamed_445;
				precise float vertex_unnamed_512 = (-0.0f) - vertex_unnamed_509;
				precise float vertex_unnamed_513 = (-0.0f) - vertex_unnamed_510;
				precise float vertex_unnamed_514 = (-0.0f) - vertex_unnamed_511;
				precise float vertex_unnamed_524 = vertex_input_1.w * vertex_uniform_buffer_3[9u].w;
				precise float vertex_unnamed_525 = vertex_unnamed_524 * mad(vertex_unnamed_445, vertex_unnamed_507, vertex_unnamed_512);
				precise float vertex_unnamed_526 = vertex_unnamed_524 * mad(vertex_unnamed_447, vertex_unnamed_508, vertex_unnamed_513);
				precise float vertex_unnamed_527 = vertex_unnamed_524 * mad(vertex_unnamed_444, vertex_unnamed_506, vertex_unnamed_514);
				vertex_output_3.y = vertex_unnamed_525;
				vertex_output_3.z = vertex_unnamed_444;
				vertex_output_3.x = vertex_unnamed_508;
				vertex_output_3.w = vertex_unnamed_125;
				vertex_output_4.x = vertex_unnamed_506;
				vertex_output_5.x = vertex_unnamed_507;
				vertex_output_4.z = vertex_unnamed_445;
				vertex_output_4.y = vertex_unnamed_526;
				vertex_output_5.y = vertex_unnamed_527;
				vertex_output_4.w = vertex_unnamed_126;
				vertex_output_5.z = vertex_unnamed_447;
				vertex_output_5.w = vertex_unnamed_127;
				vertex_output_6.x = vertex_input_7.x;
				vertex_output_6.y = vertex_input_7.y;
				vertex_output_6.z = vertex_input_7.z;
				vertex_output_6.w = vertex_input_7.w;
				precise float vertex_unnamed_558 = vertex_unnamed_457 * vertex_uniform_buffer_0[14u].x;
				precise float vertex_unnamed_559 = vertex_unnamed_457 * vertex_uniform_buffer_0[14u].y;
				precise float vertex_unnamed_560 = vertex_unnamed_457 * vertex_uniform_buffer_0[14u].z;
				vertex_output_7.x = mad(vertex_uniform_buffer_0[15u].x, vertex_unnamed_458, mad(vertex_uniform_buffer_0[13u].x, vertex_unnamed_456, vertex_unnamed_558));
				vertex_output_7.y = mad(vertex_uniform_buffer_0[15u].y, vertex_unnamed_458, mad(vertex_uniform_buffer_0[13u].y, vertex_unnamed_456, vertex_unnamed_559));
				vertex_output_7.z = mad(vertex_uniform_buffer_0[15u].z, vertex_unnamed_458, mad(vertex_uniform_buffer_0[13u].z, vertex_unnamed_456, vertex_unnamed_560));
				precise float vertex_unnamed_582 = (-0.0f) - vertex_unnamed_126;
				precise float vertex_unnamed_589 = vertex_unnamed_582 + vertex_uniform_buffer_2[4u].x;
				precise float vertex_unnamed_590 = vertex_unnamed_582 + vertex_uniform_buffer_2[4u].y;
				precise float vertex_unnamed_591 = vertex_unnamed_582 + vertex_uniform_buffer_2[4u].z;
				precise float vertex_unnamed_592 = vertex_unnamed_582 + vertex_uniform_buffer_2[4u].w;
				precise float vertex_unnamed_593 = vertex_unnamed_445 * vertex_unnamed_589;
				precise float vertex_unnamed_594 = vertex_unnamed_445 * vertex_unnamed_590;
				precise float vertex_unnamed_595 = vertex_unnamed_445 * vertex_unnamed_591;
				precise float vertex_unnamed_596 = vertex_unnamed_445 * vertex_unnamed_592;
				precise float vertex_unnamed_597 = vertex_unnamed_589 * vertex_unnamed_589;
				precise float vertex_unnamed_598 = vertex_unnamed_590 * vertex_unnamed_590;
				precise float vertex_unnamed_599 = vertex_unnamed_591 * vertex_unnamed_591;
				precise float vertex_unnamed_600 = vertex_unnamed_592 * vertex_unnamed_592;
				precise float vertex_unnamed_601 = (-0.0f) - vertex_unnamed_125;
				precise float vertex_unnamed_608 = vertex_unnamed_601 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_609 = vertex_unnamed_601 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_610 = vertex_unnamed_601 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_611 = vertex_unnamed_601 + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_612 = (-0.0f) - vertex_unnamed_127;
				precise float vertex_unnamed_619 = vertex_unnamed_612 + vertex_uniform_buffer_2[5u].x;
				precise float vertex_unnamed_620 = vertex_unnamed_612 + vertex_uniform_buffer_2[5u].y;
				precise float vertex_unnamed_621 = vertex_unnamed_612 + vertex_uniform_buffer_2[5u].z;
				precise float vertex_unnamed_622 = vertex_unnamed_612 + vertex_uniform_buffer_2[5u].w;
				float vertex_unnamed_639 = max(mad(vertex_unnamed_619, vertex_unnamed_619, mad(vertex_unnamed_608, vertex_unnamed_608, vertex_unnamed_597)), 9.9999999747524270787835121154785e-07f);
				float vertex_unnamed_641 = max(mad(vertex_unnamed_620, vertex_unnamed_620, mad(vertex_unnamed_609, vertex_unnamed_609, vertex_unnamed_598)), 9.9999999747524270787835121154785e-07f);
				float vertex_unnamed_642 = max(mad(vertex_unnamed_621, vertex_unnamed_621, mad(vertex_unnamed_610, vertex_unnamed_610, vertex_unnamed_599)), 9.9999999747524270787835121154785e-07f);
				float vertex_unnamed_643 = max(mad(vertex_unnamed_622, vertex_unnamed_622, mad(vertex_unnamed_611, vertex_unnamed_611, vertex_unnamed_600)), 9.9999999747524270787835121154785e-07f);
				precise float vertex_unnamed_658 = 1.0f / mad(vertex_unnamed_639, vertex_uniform_buffer_2[6u].x, 1.0f);
				precise float vertex_unnamed_659 = 1.0f / mad(vertex_unnamed_641, vertex_uniform_buffer_2[6u].y, 1.0f);
				precise float vertex_unnamed_660 = 1.0f / mad(vertex_unnamed_642, vertex_uniform_buffer_2[6u].z, 1.0f);
				precise float vertex_unnamed_661 = 1.0f / mad(vertex_unnamed_643, vertex_uniform_buffer_2[6u].w, 1.0f);
				precise float vertex_unnamed_662 = mad(vertex_unnamed_619, vertex_unnamed_447, mad(vertex_unnamed_608, vertex_unnamed_444, vertex_unnamed_593)) * rsqrt(vertex_unnamed_639);
				precise float vertex_unnamed_663 = mad(vertex_unnamed_620, vertex_unnamed_447, mad(vertex_unnamed_609, vertex_unnamed_444, vertex_unnamed_594)) * rsqrt(vertex_unnamed_641);
				precise float vertex_unnamed_664 = mad(vertex_unnamed_621, vertex_unnamed_446, mad(vertex_unnamed_610, vertex_unnamed_444, vertex_unnamed_595)) * rsqrt(vertex_unnamed_642);
				precise float vertex_unnamed_665 = mad(vertex_unnamed_622, vertex_unnamed_447, mad(vertex_unnamed_611, vertex_unnamed_444, vertex_unnamed_596)) * rsqrt(vertex_unnamed_643);
				precise float vertex_unnamed_670 = vertex_unnamed_658 * max(vertex_unnamed_662, 0.0f);
				precise float vertex_unnamed_671 = vertex_unnamed_659 * max(vertex_unnamed_663, 0.0f);
				precise float vertex_unnamed_672 = vertex_unnamed_660 * max(vertex_unnamed_664, 0.0f);
				precise float vertex_unnamed_673 = vertex_unnamed_661 * max(vertex_unnamed_665, 0.0f);
				precise float vertex_unnamed_680 = vertex_unnamed_671 * vertex_uniform_buffer_2[8u].x;
				precise float vertex_unnamed_681 = vertex_unnamed_671 * vertex_uniform_buffer_2[8u].y;
				precise float vertex_unnamed_682 = vertex_unnamed_671 * vertex_uniform_buffer_2[8u].z;
				float vertex_unnamed_704 = mad(vertex_uniform_buffer_2[10u].x, vertex_unnamed_673, mad(vertex_uniform_buffer_2[9u].x, vertex_unnamed_672, mad(vertex_uniform_buffer_2[7u].x, vertex_unnamed_670, vertex_unnamed_680)));
				float vertex_unnamed_705 = mad(vertex_uniform_buffer_2[10u].y, vertex_unnamed_673, mad(vertex_uniform_buffer_2[9u].y, vertex_unnamed_672, mad(vertex_uniform_buffer_2[7u].y, vertex_unnamed_670, vertex_unnamed_681)));
				float vertex_unnamed_706 = mad(vertex_uniform_buffer_2[10u].z, vertex_unnamed_673, mad(vertex_uniform_buffer_2[9u].z, vertex_unnamed_672, mad(vertex_uniform_buffer_2[7u].z, vertex_unnamed_670, vertex_unnamed_682)));
				precise float vertex_unnamed_716 = vertex_unnamed_445 * vertex_unnamed_445;
				precise float vertex_unnamed_717 = (-0.0f) - vertex_unnamed_716;
				float vertex_unnamed_718 = mad(vertex_unnamed_444, vertex_unnamed_444, vertex_unnamed_717);
				precise float vertex_unnamed_719 = vertex_unnamed_445 * vertex_unnamed_444;
				precise float vertex_unnamed_720 = vertex_unnamed_447 * vertex_unnamed_445;
				precise float vertex_unnamed_721 = vertex_unnamed_446 * vertex_unnamed_446;
				precise float vertex_unnamed_722 = vertex_unnamed_444 * vertex_unnamed_447;
				vertex_output_8.x = mad(vertex_unnamed_704, mad(vertex_unnamed_704, mad(vertex_unnamed_704, 0.305306017398834228515625f, 0.6821711063385009765625f), 0.01252287812530994415283203125f), mad(vertex_uniform_buffer_2[45u].x, vertex_unnamed_718, dot(float4(vertex_uniform_buffer_2[42u]), float4(vertex_unnamed_719, vertex_unnamed_720, vertex_unnamed_721, vertex_unnamed_722))));
				vertex_output_8.y = mad(vertex_unnamed_705, mad(vertex_unnamed_705, mad(vertex_unnamed_705, 0.305306017398834228515625f, 0.6821711063385009765625f), 0.01252287812530994415283203125f), mad(vertex_uniform_buffer_2[45u].y, vertex_unnamed_718, dot(float4(vertex_uniform_buffer_2[43u]), float4(vertex_unnamed_719, vertex_unnamed_720, vertex_unnamed_721, vertex_unnamed_722))));
				vertex_output_8.z = mad(vertex_unnamed_706, mad(vertex_unnamed_706, mad(vertex_unnamed_706, 0.305306017398834228515625f, 0.6821711063385009765625f), 0.01252287812530994415283203125f), mad(vertex_uniform_buffer_2[45u].z, vertex_unnamed_718, dot(float4(vertex_uniform_buffer_2[44u]), float4(vertex_unnamed_719, vertex_unnamed_720, vertex_unnamed_721, vertex_unnamed_722))));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_FaceDilate, vertex_uniform_buffer_0[6][1], vertex_uniform_buffer_0[6][2], vertex_uniform_buffer_0[6][3]);

				vertex_uniform_buffer_0[13] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				vertex_uniform_buffer_0[14] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				vertex_uniform_buffer_0[15] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				vertex_uniform_buffer_0[16] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], _WeightNormal, vertex_uniform_buffer_0[24][2], vertex_uniform_buffer_0[24][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], vertex_uniform_buffer_0[24][1], _WeightBold, vertex_uniform_buffer_0[24][3]);

				vertex_uniform_buffer_0[24] = float4(vertex_uniform_buffer_0[24][0], vertex_uniform_buffer_0[24][1], vertex_uniform_buffer_0[24][2], _ScaleRatioA);

				vertex_uniform_buffer_0[25] = float4(vertex_uniform_buffer_0[25][0], vertex_uniform_buffer_0[25][1], _VertexOffsetX, vertex_uniform_buffer_0[25][3]);

				vertex_uniform_buffer_0[25] = float4(vertex_uniform_buffer_0[25][0], vertex_uniform_buffer_0[25][1], vertex_uniform_buffer_0[25][2], _VertexOffsetY);

				vertex_uniform_buffer_0[30] = float4(_GradientScale, vertex_uniform_buffer_0[30][1], vertex_uniform_buffer_0[30][2], vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], _ScaleX, vertex_uniform_buffer_0[30][2], vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], vertex_uniform_buffer_0[30][1], _ScaleY, vertex_uniform_buffer_0[30][3]);

				vertex_uniform_buffer_0[30] = float4(vertex_uniform_buffer_0[30][0], vertex_uniform_buffer_0[30][1], vertex_uniform_buffer_0[30][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[31] = float4(_Sharpness, vertex_uniform_buffer_0[31][1], vertex_uniform_buffer_0[31][2], vertex_uniform_buffer_0[31][3]);

				vertex_uniform_buffer_0[32] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_0[33] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[34] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

				vertex_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], vertex_uniform_buffer_1[4][3]);

				vertex_uniform_buffer_1[6] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				vertex_uniform_buffer_2[3] = float4(unity_4LightPosX0[0], unity_4LightPosX0[1], unity_4LightPosX0[2], unity_4LightPosX0[3]);

				vertex_uniform_buffer_2[4] = float4(unity_4LightPosY0[0], unity_4LightPosY0[1], unity_4LightPosY0[2], unity_4LightPosY0[3]);

				vertex_uniform_buffer_2[5] = float4(unity_4LightPosZ0[0], unity_4LightPosZ0[1], unity_4LightPosZ0[2], unity_4LightPosZ0[3]);

				vertex_uniform_buffer_2[6] = float4(unity_4LightAtten0[0], unity_4LightAtten0[1], unity_4LightAtten0[2], unity_4LightAtten0[3]);

				vertex_uniform_buffer_2[7] = float4(unity_LightColor[0][0], unity_LightColor[0][1], unity_LightColor[0][2], unity_LightColor[0][3]);
				vertex_uniform_buffer_2[8] = float4(unity_LightColor[1][0], unity_LightColor[1][1], unity_LightColor[1][2], unity_LightColor[1][3]);
				vertex_uniform_buffer_2[9] = float4(unity_LightColor[2][0], unity_LightColor[2][1], unity_LightColor[2][2], unity_LightColor[2][3]);
				vertex_uniform_buffer_2[10] = float4(unity_LightColor[3][0], unity_LightColor[3][1], unity_LightColor[3][2], unity_LightColor[3][3]);
				vertex_uniform_buffer_2[11] = float4(unity_LightColor[4][0], unity_LightColor[4][1], unity_LightColor[4][2], unity_LightColor[4][3]);
				vertex_uniform_buffer_2[12] = float4(unity_LightColor[5][0], unity_LightColor[5][1], unity_LightColor[5][2], unity_LightColor[5][3]);
				vertex_uniform_buffer_2[13] = float4(unity_LightColor[6][0], unity_LightColor[6][1], unity_LightColor[6][2], unity_LightColor[6][3]);
				vertex_uniform_buffer_2[14] = float4(unity_LightColor[7][0], unity_LightColor[7][1], unity_LightColor[7][2], unity_LightColor[7][3]);

				vertex_uniform_buffer_2[42] = float4(unity_SHBr[0], unity_SHBr[1], unity_SHBr[2], unity_SHBr[3]);

				vertex_uniform_buffer_2[43] = float4(unity_SHBg[0], unity_SHBg[1], unity_SHBg[2], unity_SHBg[3]);

				vertex_uniform_buffer_2[44] = float4(unity_SHBb[0], unity_SHBb[1], unity_SHBb[2], unity_SHBb[3]);

				vertex_uniform_buffer_2[45] = float4(unity_SHC[0], unity_SHC[1], unity_SHC[2], unity_SHC[3]);

				vertex_uniform_buffer_3[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_3[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_3[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_3[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_3[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_3[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_3[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_3[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				vertex_uniform_buffer_4[5] = float4(glstate_matrix_projection[0][0], glstate_matrix_projection[1][0], glstate_matrix_projection[2][0], glstate_matrix_projection[3][0]);
				vertex_uniform_buffer_4[6] = float4(glstate_matrix_projection[0][1], glstate_matrix_projection[1][1], glstate_matrix_projection[2][1], glstate_matrix_projection[3][1]);
				vertex_uniform_buffer_4[7] = float4(glstate_matrix_projection[0][2], glstate_matrix_projection[1][2], glstate_matrix_projection[2][2], glstate_matrix_projection[3][2]);
				vertex_uniform_buffer_4[8] = float4(glstate_matrix_projection[0][3], glstate_matrix_projection[1][3], glstate_matrix_projection[2][3], glstate_matrix_projection[3][3]);

				vertex_uniform_buffer_4[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_4[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_4[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_4[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vertex_input_7 = stage_input.vertex_input_7;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				return stage_output;
			}

			#endif // defined(DIRECTIONAL) && defined(LIGHTPROBE_SH) && defined(VERTEXLIGHT_ON)


			// Fallback Shader Code
			#ifndef ANY_SHADER_VARIANT_ACTIVE

			// https://docs.unity3d.com/Manual/SL-UnityShaderVariables.html
			float4x4 unity_MatrixMVP;

			struct Vertex_Stage_Input
			{
				float3 pos : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float4 pos : SV_POSITION;
			};

			Vertex_Stage_Output vert(Vertex_Stage_Input input)
			{
				Vertex_Stage_Output output;
				output.pos = mul(unity_MatrixMVP, float4(input.pos, 1.0));
				return output;
			}

			float4 frag(Vertex_Stage_Output input) : SV_TARGET
			{
				// Output solid grey color (e.g., 50% grey)
				return float4(0.5, 0.5, 0.5, 1.0); // RGBA
			}

			#endif // !ANY_SHADER_VARIANT_ACTIVE


			ENDHLSL
		}
		Pass
		{
			Name "Caster"
			LOD 300
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			ColorMask RGB
			Cull Off
			Offset 1, 1
			Fog
			{
				Mode Off
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 128069

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#pragma shader_feature SHADOWS_CUBE
			#pragma shader_feature SHADOWS_DEPTH


			#if defined(SHADOWS_DEPTH) && !defined(SHADOWS_CUBE)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _MainTex_ST;
			float4 _OutlineTex_ST;
			float _OutlineWidth;
			float _FaceDilate;
			float _ScaleRatioA;
			float4 unity_LightShadowBias;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[5];
			static float4 vertex_uniform_buffer_1[6];
			static float4 vertex_uniform_buffer_2[4];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float2 vertex_output_1;
			static float2 vertex_output_1;
			static float vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TEXCOORD; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float2 vertex_output_1 : TEXCOORD3; // TEXCOORD_3
				float vertex_output_2 : TEXCOORD2; // TEXCOORD_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_54 = vertex_input_0.y * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_55 = vertex_input_0.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_56 = vertex_input_0.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_2[1u].w;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_0.x, vertex_unnamed_54)) + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_0.x, vertex_unnamed_55)) + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_0.x, vertex_unnamed_56)) + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_input_0.x, vertex_unnamed_57)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_138 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				precise float vertex_unnamed_142 = vertex_uniform_buffer_1[5u].x / vertex_unnamed_138;
				precise float vertex_unnamed_147 = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_91, vertex_unnamed_104))) + max(min(vertex_unnamed_142, 0.0f), -1.0f);
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.w = vertex_unnamed_138;
				precise float vertex_unnamed_152 = (-0.0f) - vertex_unnamed_147;
				precise float vertex_unnamed_154 = vertex_unnamed_152 + min(vertex_unnamed_138, vertex_unnamed_147);
				gl_Position.z = mad(vertex_uniform_buffer_1[5u].y, vertex_unnamed_154, vertex_unnamed_147);
				vertex_output_1.x = mad(vertex_input_2.x, vertex_uniform_buffer_0[2u].x, vertex_uniform_buffer_0[2u].z);
				vertex_output_1.y = mad(vertex_input_2.y, vertex_uniform_buffer_0[2u].y, vertex_uniform_buffer_0[2u].w);
				vertex_output_1.x = mad(vertex_input_2.x, vertex_uniform_buffer_0[3u].x, vertex_uniform_buffer_0[3u].z);
				vertex_output_1.y = mad(vertex_input_2.y, vertex_uniform_buffer_0[3u].y, vertex_uniform_buffer_0[3u].w);
				precise float vertex_unnamed_195 = (-0.0f) - vertex_uniform_buffer_0[4u].x;
				precise float vertex_unnamed_204 = (-0.0f) - vertex_uniform_buffer_0[4u].y;
				precise float vertex_unnamed_209 = mad(vertex_unnamed_204, vertex_uniform_buffer_0[4u].z, mad(vertex_unnamed_195, vertex_uniform_buffer_0[4u].z, 1.0f)) * 0.5f;
				vertex_output_2 = vertex_unnamed_209;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_0[3] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

				vertex_uniform_buffer_0[4] = float4(_OutlineWidth, vertex_uniform_buffer_0[4][1], vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], _FaceDilate, vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], vertex_uniform_buffer_0[4][1], _ScaleRatioA, vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_1[5] = float4(unity_LightShadowBias[0], unity_LightShadowBias[1], unity_LightShadowBias[2], unity_LightShadowBias[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_3[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_3[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_3[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}


			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float fragment_input_2;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
				float2 fragment_input_1 : TEXCOORD3; // TEXCOORD_3
				float fragment_input_2 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_56)
			{
				if (fragment_unnamed_56)
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
				precise float fragment_unnamed_39 = (-0.0f) - fragment_input_2;
				precise float fragment_unnamed_41 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w + fragment_unnamed_39;
				discard_cond(fragment_unnamed_41 < 0.0f);
				fragment_output_0.x = 0.0f;
				fragment_output_0.y = 0.0f;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(SHADOWS_DEPTH) && !defined(SHADOWS_CUBE)


			#if defined(SHADOWS_CUBE) && !defined(SHADOWS_DEPTH)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _MainTex_ST;
			float4 _OutlineTex_ST;
			float _OutlineWidth;
			float _FaceDilate;
			float _ScaleRatioA;
			float4 unity_LightShadowBias;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[5];
			static float4 vertex_uniform_buffer_1[6];
			static float4 vertex_uniform_buffer_2[4];
			static float4 vertex_uniform_buffer_3[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float2 vertex_output_1;
			static float2 vertex_output_1;
			static float vertex_output_2;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TEXCOORD; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float2 vertex_output_1 : TEXCOORD3; // TEXCOORD_3
				float vertex_output_2 : TEXCOORD2; // TEXCOORD_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_54 = vertex_input_0.y * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_55 = vertex_input_0.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_56 = vertex_input_0.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_2[1u].w;
				precise float vertex_unnamed_91 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_0.x, vertex_unnamed_54)) + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_92 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_0.x, vertex_unnamed_55)) + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_93 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_0.x, vertex_unnamed_56)) + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_94 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_input_0.x, vertex_unnamed_57)) + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_102 = vertex_unnamed_92 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_103 = vertex_unnamed_92 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_104 = vertex_unnamed_92 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_105 = vertex_unnamed_92 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_137 = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_93, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_91, vertex_unnamed_104)));
				float vertex_unnamed_138 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_93, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_91, vertex_unnamed_105)));
				precise float vertex_unnamed_140 = (-0.0f) - vertex_unnamed_137;
				precise float vertex_unnamed_142 = vertex_unnamed_140 + min(vertex_unnamed_138, vertex_unnamed_137);
				gl_Position.z = mad(vertex_uniform_buffer_1[5u].y, vertex_unnamed_142, vertex_unnamed_137);
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_93, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_91, vertex_unnamed_102)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_93, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_91, vertex_unnamed_103)));
				gl_Position.w = vertex_unnamed_138;
				vertex_output_1.x = mad(vertex_input_2.x, vertex_uniform_buffer_0[2u].x, vertex_uniform_buffer_0[2u].z);
				vertex_output_1.y = mad(vertex_input_2.y, vertex_uniform_buffer_0[2u].y, vertex_uniform_buffer_0[2u].w);
				vertex_output_1.x = mad(vertex_input_2.x, vertex_uniform_buffer_0[3u].x, vertex_uniform_buffer_0[3u].z);
				vertex_output_1.y = mad(vertex_input_2.y, vertex_uniform_buffer_0[3u].y, vertex_uniform_buffer_0[3u].w);
				precise float vertex_unnamed_186 = (-0.0f) - vertex_uniform_buffer_0[4u].x;
				precise float vertex_unnamed_195 = (-0.0f) - vertex_uniform_buffer_0[4u].y;
				precise float vertex_unnamed_200 = mad(vertex_unnamed_195, vertex_uniform_buffer_0[4u].z, mad(vertex_unnamed_186, vertex_uniform_buffer_0[4u].z, 1.0f)) * 0.5f;
				vertex_output_2 = vertex_unnamed_200;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[2] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_0[3] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

				vertex_uniform_buffer_0[4] = float4(_OutlineWidth, vertex_uniform_buffer_0[4][1], vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], _FaceDilate, vertex_uniform_buffer_0[4][2], vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_0[4] = float4(vertex_uniform_buffer_0[4][0], vertex_uniform_buffer_0[4][1], _ScaleRatioA, vertex_uniform_buffer_0[4][3]);

				vertex_uniform_buffer_1[5] = float4(unity_LightShadowBias[0], unity_LightShadowBias[1], unity_LightShadowBias[2], unity_LightShadowBias[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_3[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_3[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_3[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_3[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}


			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float fragment_input_2;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
				float2 fragment_input_1 : TEXCOORD3; // TEXCOORD_3
				float fragment_input_2 : TEXCOORD2; // TEXCOORD_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_56)
			{
				if (fragment_unnamed_56)
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
				precise float fragment_unnamed_39 = (-0.0f) - fragment_input_2;
				precise float fragment_unnamed_41 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w + fragment_unnamed_39;
				discard_cond(fragment_unnamed_41 < 0.0f);
				fragment_output_0.x = 0.0f;
				fragment_output_0.y = 0.0f;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(SHADOWS_CUBE) && !defined(SHADOWS_DEPTH)


			// Fallback Shader Code
			#ifndef ANY_SHADER_VARIANT_ACTIVE

			// https://docs.unity3d.com/Manual/SL-UnityShaderVariables.html
			float4x4 unity_MatrixMVP;

			struct Vertex_Stage_Input
			{
				float3 pos : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float4 pos : SV_POSITION;
			};

			Vertex_Stage_Output vert(Vertex_Stage_Input input)
			{
				Vertex_Stage_Output output;
				output.pos = mul(unity_MatrixMVP, float4(input.pos, 1.0));
				return output;
			}

			float4 frag(Vertex_Stage_Output input) : SV_TARGET
			{
				// Output solid grey color (e.g., 50% grey)
				return float4(0.5, 0.5, 0.5, 1.0); // RGBA
			}

			#endif // !ANY_SHADER_VARIANT_ACTIVE


			ENDHLSL
		}
	}
	CustomEditor "TMPro.EditorUtilities.TMP_SDFShaderGUI"
}
