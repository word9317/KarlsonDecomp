Shader "TextMeshPro/Distance Field (Surface)"
{
	Properties
	{
		_FaceTex ("Fill Texture", 2D) = "white" {}
		_FaceUVSpeedX ("Face UV Speed X", Range(-5, 5)) = 0
		_FaceUVSpeedY ("Face UV Speed Y", Range(-5, 5)) = 0
		_FaceColor ("Fill Color", Color) = (1,1,1,1)
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
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_BumpOutline ("Bump Outline", Range(0, 1)) = 0.5
		_BumpFace ("Bump Face", Range(0, 1)) = 0.5
		_ReflectFaceColor ("Face Color", Color) = (0,0,0,1)
		_ReflectOutlineColor ("Outline Color", Color) = (0,0,0,1)
		_Cube ("Reflection Cubemap", Cube) = "black" {}
		_EnvMatrixRotation ("Texture Rotation", Vector) = (0,0,0,0)
		_SpecColor ("Specular Color", Color) = (0,0,0,1)
		_FaceShininess ("Face Shininess", Range(0, 1)) = 0
		_OutlineShininess ("Outline Shininess", Range(0, 1)) = 0
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
			GpuProgramID 8719

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
			float4 _SpecColor;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float4 _ReflectFaceColor;
			float4 _ReflectOutlineColor;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;
			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_SHAr;
			float4 unity_SHAg;
			float4 unity_SHAb;
			float4 unity_OcclusionMaskSelector;
			float4x4 unity_ObjectToWorld;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[32];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[4];
			static float4 fragment_uniform_buffer_4[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			Texture2D<float4> _BumpMap;
			TextureCube<float4> _Cube;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_BumpMap;
			SamplerState sampler_Cube;
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
				precise float fragment_unnamed_89 = (-0.0f) - fragment_input_3.w;
				precise float fragment_unnamed_91 = (-0.0f) - fragment_input_4.w;
				precise float fragment_unnamed_92 = (-0.0f) - fragment_input_5.w;
				precise float fragment_unnamed_101 = fragment_unnamed_89 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_102 = fragment_unnamed_91 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_103 = fragment_unnamed_92 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_108 = rsqrt(dot(float3(fragment_unnamed_101, fragment_unnamed_102, fragment_unnamed_103), float3(fragment_unnamed_101, fragment_unnamed_102, fragment_unnamed_103)));
				precise float fragment_unnamed_114 = 1.0f / fragment_uniform_buffer_0[29u].z;
				precise float fragment_unnamed_116 = 1.0f / fragment_uniform_buffer_0[29u].w;
				float fragment_unnamed_117 = asfloat(0u);
				precise float fragment_unnamed_118 = (-0.0f) - fragment_unnamed_114;
				precise float fragment_unnamed_119 = (-0.0f) - fragment_unnamed_117;
				precise float fragment_unnamed_120 = (-0.0f) - fragment_unnamed_116;
				precise float fragment_unnamed_126 = fragment_unnamed_118 + fragment_input_1.x;
				precise float fragment_unnamed_127 = fragment_unnamed_119 + fragment_input_1.y;
				precise float fragment_unnamed_128 = fragment_unnamed_119 + fragment_input_1.x;
				precise float fragment_unnamed_129 = fragment_unnamed_120 + fragment_input_1.y;
				precise float fragment_unnamed_140 = fragment_unnamed_114 + fragment_input_1.x;
				precise float fragment_unnamed_141 = fragment_unnamed_117 + fragment_input_1.y;
				precise float fragment_unnamed_142 = fragment_unnamed_117 + fragment_input_1.x;
				precise float fragment_unnamed_143 = fragment_unnamed_116 + fragment_input_1.y;
				precise float fragment_unnamed_160 = (-0.0f) - _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
				precise float fragment_unnamed_161 = fragment_unnamed_160 + 0.5f;
				precise float fragment_unnamed_165 = (-0.0f) - fragment_input_2.x;
				precise float fragment_unnamed_166 = fragment_unnamed_161 + fragment_unnamed_165;
				float fragment_unnamed_169 = mad(fragment_unnamed_166, fragment_input_2.y, 0.5f);
				precise float fragment_unnamed_178 = fragment_uniform_buffer_0[8u].x * fragment_uniform_buffer_0[24u].w;
				precise float fragment_unnamed_186 = fragment_uniform_buffer_0[6u].y * fragment_uniform_buffer_0[24u].w;
				precise float fragment_unnamed_189 = fragment_unnamed_178 * fragment_input_2.y;
				precise float fragment_unnamed_190 = fragment_unnamed_186 * fragment_input_2.y;
				precise float fragment_unnamed_206 = fragment_input_6.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_207 = fragment_input_6.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_208 = fragment_input_6.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_209 = fragment_input_6.w * fragment_uniform_buffer_0[5u].w;
				precise float fragment_unnamed_215 = fragment_input_6.w * fragment_uniform_buffer_0[7u].w;
				float4 fragment_unnamed_230 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[4u].x, fragment_uniform_buffer_1[0u].y, fragment_input_1.z), mad(fragment_uniform_buffer_0[4u].y, fragment_uniform_buffer_1[0u].y, fragment_input_1.w)));
				precise float fragment_unnamed_236 = fragment_unnamed_206 * fragment_unnamed_230.x;
				precise float fragment_unnamed_237 = fragment_unnamed_207 * fragment_unnamed_230.y;
				precise float fragment_unnamed_238 = fragment_unnamed_208 * fragment_unnamed_230.z;
				precise float fragment_unnamed_239 = fragment_unnamed_209 * fragment_unnamed_230.w;
				float4 fragment_unnamed_254 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[6u].z, fragment_uniform_buffer_1[0u].y, fragment_input_2.x), mad(fragment_uniform_buffer_0[6u].w, fragment_uniform_buffer_1[0u].y, fragment_input_2.y)));
				precise float fragment_unnamed_265 = fragment_unnamed_254.x * fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_266 = fragment_unnamed_254.y * fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_267 = fragment_unnamed_254.z * fragment_uniform_buffer_0[7u].z;
				precise float fragment_unnamed_268 = fragment_unnamed_215 * fragment_unnamed_254.w;
				precise float fragment_unnamed_269 = (-0.0f) - fragment_unnamed_189;
				precise float fragment_unnamed_275 = mad(fragment_unnamed_190, 0.5f, mad(fragment_unnamed_269, 0.5f, fragment_unnamed_169)) / mad(fragment_unnamed_186, fragment_input_2.y, 1.0f);
				precise float fragment_unnamed_277 = (-0.0f) - clamp(fragment_unnamed_275, 0.0f, 1.0f);
				precise float fragment_unnamed_278 = fragment_unnamed_277 + 1.0f;
				float fragment_unnamed_280 = clamp(mad(fragment_unnamed_189, 0.5f, fragment_unnamed_169), 0.0f, 1.0f);
				precise float fragment_unnamed_283 = fragment_unnamed_280 * sqrt(min(fragment_unnamed_189, 1.0f));
				precise float fragment_unnamed_284 = fragment_unnamed_239 * fragment_unnamed_236;
				precise float fragment_unnamed_285 = fragment_unnamed_239 * fragment_unnamed_237;
				precise float fragment_unnamed_286 = fragment_unnamed_239 * fragment_unnamed_238;
				precise float fragment_unnamed_287 = fragment_unnamed_265 * fragment_unnamed_268;
				precise float fragment_unnamed_288 = fragment_unnamed_266 * fragment_unnamed_268;
				precise float fragment_unnamed_289 = fragment_unnamed_267 * fragment_unnamed_268;
				precise float fragment_unnamed_290 = (-0.0f) - fragment_unnamed_284;
				precise float fragment_unnamed_291 = (-0.0f) - fragment_unnamed_285;
				precise float fragment_unnamed_292 = (-0.0f) - fragment_unnamed_286;
				precise float fragment_unnamed_293 = (-0.0f) - fragment_unnamed_239;
				precise float fragment_unnamed_294 = fragment_unnamed_290 + fragment_unnamed_287;
				precise float fragment_unnamed_295 = fragment_unnamed_291 + fragment_unnamed_288;
				precise float fragment_unnamed_296 = fragment_unnamed_292 + fragment_unnamed_289;
				precise float fragment_unnamed_297 = fragment_unnamed_293 + fragment_unnamed_268;
				precise float fragment_unnamed_302 = fragment_unnamed_278 * mad(fragment_unnamed_283, fragment_unnamed_294, fragment_unnamed_284);
				precise float fragment_unnamed_303 = fragment_unnamed_278 * mad(fragment_unnamed_283, fragment_unnamed_295, fragment_unnamed_285);
				precise float fragment_unnamed_304 = fragment_unnamed_278 * mad(fragment_unnamed_283, fragment_unnamed_296, fragment_unnamed_286);
				precise float fragment_unnamed_305 = fragment_unnamed_278 * mad(fragment_unnamed_283, fragment_unnamed_297, fragment_unnamed_239);
				float fragment_unnamed_306 = max(fragment_unnamed_305, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_308 = fragment_unnamed_302 / fragment_unnamed_306;
				precise float fragment_unnamed_309 = fragment_unnamed_303 / fragment_unnamed_306;
				precise float fragment_unnamed_310 = fragment_unnamed_304 / fragment_unnamed_306;
				precise float fragment_unnamed_314 = fragment_uniform_buffer_0[24u].x * 0.5f;
				precise float fragment_unnamed_315 = (-0.0f) - fragment_unnamed_314;
				float fragment_unnamed_319 = frac(abs(fragment_unnamed_314));
				precise float fragment_unnamed_320 = (-0.0f) - fragment_unnamed_319;
				bool fragment_unnamed_322 = ((fragment_unnamed_314 >= fragment_unnamed_315) ? fragment_unnamed_319 : fragment_unnamed_320) >= 0.5f;
				precise float fragment_unnamed_328 = fragment_input_2.x + fragment_uniform_buffer_0[8u].z;
				precise float fragment_unnamed_329 = fragment_unnamed_328 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_126, fragment_unnamed_127)).w;
				precise float fragment_unnamed_330 = fragment_unnamed_328 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_140, fragment_unnamed_141)).w;
				precise float fragment_unnamed_331 = fragment_unnamed_328 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_128, fragment_unnamed_129)).w;
				precise float fragment_unnamed_332 = fragment_unnamed_328 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_142, fragment_unnamed_143)).w;
				precise float fragment_unnamed_339 = fragment_uniform_buffer_0[8u].w + fragment_uniform_buffer_0[8u].x;
				float fragment_unnamed_340 = max(fragment_unnamed_339, 0.00999999977648258209228515625f);
				precise float fragment_unnamed_342 = fragment_unnamed_329 + (-0.5f);
				precise float fragment_unnamed_344 = fragment_unnamed_330 + (-0.5f);
				precise float fragment_unnamed_345 = fragment_unnamed_331 + (-0.5f);
				precise float fragment_unnamed_346 = fragment_unnamed_332 + (-0.5f);
				precise float fragment_unnamed_347 = fragment_unnamed_342 / fragment_unnamed_340;
				precise float fragment_unnamed_348 = fragment_unnamed_344 / fragment_unnamed_340;
				precise float fragment_unnamed_349 = fragment_unnamed_345 / fragment_unnamed_340;
				precise float fragment_unnamed_350 = fragment_unnamed_346 / fragment_unnamed_340;
				precise float fragment_unnamed_351 = fragment_unnamed_347 + 0.5f;
				precise float fragment_unnamed_352 = fragment_unnamed_348 + 0.5f;
				precise float fragment_unnamed_353 = fragment_unnamed_349 + 0.5f;
				precise float fragment_unnamed_354 = fragment_unnamed_350 + 0.5f;
				float fragment_unnamed_355 = clamp(fragment_unnamed_351, 0.0f, 1.0f);
				float fragment_unnamed_356 = clamp(fragment_unnamed_352, 0.0f, 1.0f);
				float fragment_unnamed_357 = clamp(fragment_unnamed_353, 0.0f, 1.0f);
				float fragment_unnamed_358 = clamp(fragment_unnamed_354, 0.0f, 1.0f);
				precise float fragment_unnamed_366 = (-0.0f) - abs(mad(fragment_unnamed_355, 2.0f, -1.0f));
				precise float fragment_unnamed_368 = (-0.0f) - abs(mad(fragment_unnamed_356, 2.0f, -1.0f));
				precise float fragment_unnamed_370 = (-0.0f) - abs(mad(fragment_unnamed_357, 2.0f, -1.0f));
				precise float fragment_unnamed_372 = (-0.0f) - abs(mad(fragment_unnamed_358, 2.0f, -1.0f));
				precise float fragment_unnamed_373 = fragment_unnamed_366 + 1.0f;
				precise float fragment_unnamed_374 = fragment_unnamed_368 + 1.0f;
				precise float fragment_unnamed_375 = fragment_unnamed_370 + 1.0f;
				precise float fragment_unnamed_376 = fragment_unnamed_372 + 1.0f;
				float fragment_unnamed_386 = asfloat(fragment_unnamed_322 ? asuint(fragment_unnamed_373) : asuint(fragment_unnamed_355));
				float fragment_unnamed_388 = asfloat(fragment_unnamed_322 ? asuint(fragment_unnamed_374) : asuint(fragment_unnamed_356));
				float fragment_unnamed_390 = asfloat(fragment_unnamed_322 ? asuint(fragment_unnamed_375) : asuint(fragment_unnamed_357));
				float fragment_unnamed_392 = asfloat(fragment_unnamed_322 ? asuint(fragment_unnamed_376) : asuint(fragment_unnamed_358));
				precise float fragment_unnamed_393 = fragment_unnamed_386 * 1.57079601287841796875f;
				precise float fragment_unnamed_395 = fragment_unnamed_388 * 1.57079601287841796875f;
				precise float fragment_unnamed_396 = fragment_unnamed_390 * 1.57079601287841796875f;
				precise float fragment_unnamed_397 = fragment_unnamed_392 * 1.57079601287841796875f;
				precise float fragment_unnamed_402 = (-0.0f) - fragment_unnamed_386;
				precise float fragment_unnamed_403 = (-0.0f) - fragment_unnamed_388;
				precise float fragment_unnamed_404 = (-0.0f) - fragment_unnamed_390;
				precise float fragment_unnamed_405 = (-0.0f) - fragment_unnamed_392;
				precise float fragment_unnamed_406 = fragment_unnamed_402 + sin(fragment_unnamed_393);
				precise float fragment_unnamed_407 = fragment_unnamed_403 + sin(fragment_unnamed_395);
				precise float fragment_unnamed_408 = fragment_unnamed_404 + sin(fragment_unnamed_396);
				precise float fragment_unnamed_409 = fragment_unnamed_405 + sin(fragment_unnamed_397);
				precise float fragment_unnamed_421 = (-0.0f) - fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_422 = fragment_unnamed_421 + 1.0f;
				precise float fragment_unnamed_430 = fragment_unnamed_340 * fragment_uniform_buffer_0[8u].y;
				precise float fragment_unnamed_435 = fragment_unnamed_430 * fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_436 = fragment_unnamed_435 * (-2.0f);
				precise float fragment_unnamed_438 = min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_406, fragment_unnamed_386), fragment_unnamed_422) * fragment_unnamed_436;
				precise float fragment_unnamed_439 = min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_408, fragment_unnamed_390), fragment_unnamed_422) * fragment_unnamed_436;
				precise float fragment_unnamed_440 = (-0.0f) - fragment_unnamed_439;
				precise float fragment_unnamed_441 = (-0.0f) - fragment_unnamed_438;
				float fragment_unnamed_442 = mad(min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_409, fragment_unnamed_392), fragment_unnamed_422), fragment_unnamed_436, fragment_unnamed_440);
				float fragment_unnamed_443 = mad(min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_407, fragment_unnamed_388), fragment_unnamed_422), fragment_unnamed_436, fragment_unnamed_441);
				float fragment_unnamed_444 = asfloat(3212836864u);
				float fragment_unnamed_446 = asfloat(1065353216u);
				float fragment_unnamed_451 = rsqrt(dot(float2(fragment_unnamed_443, fragment_unnamed_446), float2(fragment_unnamed_443, fragment_unnamed_446)));
				precise float fragment_unnamed_452 = fragment_unnamed_451 * 1.0f;
				precise float fragment_unnamed_453 = fragment_unnamed_451 * 0.0f;
				precise float fragment_unnamed_454 = fragment_unnamed_451 * fragment_unnamed_443;
				float fragment_unnamed_458 = rsqrt(dot(float2(fragment_unnamed_444, fragment_unnamed_442), float2(fragment_unnamed_444, fragment_unnamed_442)));
				precise float fragment_unnamed_460 = fragment_unnamed_458 * fragment_unnamed_444;
				precise float fragment_unnamed_461 = fragment_unnamed_458 * fragment_unnamed_442;
				precise float fragment_unnamed_462 = fragment_unnamed_458 * asfloat(0u);
				precise float fragment_unnamed_463 = fragment_unnamed_460 * fragment_unnamed_454;
				precise float fragment_unnamed_464 = fragment_unnamed_461 * fragment_unnamed_452;
				precise float fragment_unnamed_465 = fragment_unnamed_462 * fragment_unnamed_453;
				precise float fragment_unnamed_466 = (-0.0f) - fragment_unnamed_463;
				precise float fragment_unnamed_467 = (-0.0f) - fragment_unnamed_464;
				precise float fragment_unnamed_468 = (-0.0f) - fragment_unnamed_465;
				float4 fragment_unnamed_477 = _BumpMap.Sample(sampler_BumpMap, float2(fragment_input_1.z, fragment_input_1.w));
				precise float fragment_unnamed_482 = fragment_unnamed_477.w * fragment_unnamed_477.x;
				float fragment_unnamed_483 = mad(fragment_unnamed_482, 2.0f, -1.0f);
				float fragment_unnamed_484 = mad(fragment_unnamed_477.y, 2.0f, -1.0f);
				precise float fragment_unnamed_489 = (-0.0f) - min(dot(float2(fragment_unnamed_483, fragment_unnamed_484), float2(fragment_unnamed_483, fragment_unnamed_484)), 1.0f);
				precise float fragment_unnamed_490 = fragment_unnamed_489 + 1.0f;
				precise float fragment_unnamed_495 = (-0.0f) - fragment_uniform_buffer_0[9u].w;
				precise float fragment_unnamed_499 = fragment_unnamed_495 + fragment_uniform_buffer_0[9u].z;
				float fragment_unnamed_503 = mad(fragment_unnamed_280, fragment_unnamed_499, fragment_uniform_buffer_0[9u].w);
				precise float fragment_unnamed_510 = (-0.0f) - mad(fragment_unnamed_305, mad(fragment_unnamed_483, fragment_unnamed_503, -0.0f), 0.0f);
				precise float fragment_unnamed_511 = (-0.0f) - mad(fragment_unnamed_305, mad(fragment_unnamed_484, fragment_unnamed_503, -0.0f), 0.0f);
				precise float fragment_unnamed_512 = (-0.0f) - mad(fragment_unnamed_305, mad(sqrt(fragment_unnamed_490), fragment_unnamed_503, -1.0f), 1.0f);
				precise float fragment_unnamed_513 = mad(fragment_unnamed_453, fragment_unnamed_461, fragment_unnamed_466) + fragment_unnamed_510;
				precise float fragment_unnamed_514 = mad(fragment_unnamed_454, fragment_unnamed_462, fragment_unnamed_467) + fragment_unnamed_511;
				precise float fragment_unnamed_515 = mad(fragment_unnamed_452, fragment_unnamed_460, fragment_unnamed_468) + fragment_unnamed_512;
				float fragment_unnamed_519 = rsqrt(dot(float3(fragment_unnamed_513, fragment_unnamed_514, fragment_unnamed_515), float3(fragment_unnamed_513, fragment_unnamed_514, fragment_unnamed_515)));
				precise float fragment_unnamed_520 = fragment_unnamed_519 * fragment_unnamed_513;
				precise float fragment_unnamed_521 = fragment_unnamed_519 * fragment_unnamed_514;
				precise float fragment_unnamed_522 = fragment_unnamed_519 * fragment_unnamed_515;
				precise float fragment_unnamed_528 = fragment_unnamed_521 * fragment_uniform_buffer_3[1u].x;
				precise float fragment_unnamed_529 = fragment_unnamed_521 * fragment_uniform_buffer_3[1u].y;
				precise float fragment_unnamed_530 = fragment_unnamed_521 * fragment_uniform_buffer_3[1u].z;
				float fragment_unnamed_544 = mad(fragment_uniform_buffer_3[2u].x, fragment_unnamed_522, mad(fragment_uniform_buffer_3[0u].x, fragment_unnamed_520, fragment_unnamed_528));
				float fragment_unnamed_545 = mad(fragment_uniform_buffer_3[2u].y, fragment_unnamed_522, mad(fragment_uniform_buffer_3[0u].y, fragment_unnamed_520, fragment_unnamed_529));
				float fragment_unnamed_546 = mad(fragment_uniform_buffer_3[2u].z, fragment_unnamed_522, mad(fragment_uniform_buffer_3[0u].z, fragment_unnamed_520, fragment_unnamed_530));
				float fragment_unnamed_553 = dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_unnamed_544, fragment_unnamed_545, fragment_unnamed_546));
				precise float fragment_unnamed_556 = fragment_unnamed_553 + fragment_unnamed_553;
				precise float fragment_unnamed_557 = (-0.0f) - fragment_unnamed_556;
				float4 fragment_unnamed_569 = _Cube.Sample(sampler_Cube, float3(mad(fragment_unnamed_544, fragment_unnamed_557, fragment_input_7.x), mad(fragment_unnamed_545, fragment_unnamed_557, fragment_input_7.y), mad(fragment_unnamed_546, fragment_unnamed_557, fragment_input_7.z)));
				precise float fragment_unnamed_578 = (-0.0f) - fragment_uniform_buffer_0[10u].x;
				precise float fragment_unnamed_580 = (-0.0f) - fragment_uniform_buffer_0[10u].y;
				precise float fragment_unnamed_582 = (-0.0f) - fragment_uniform_buffer_0[10u].z;
				precise float fragment_unnamed_589 = fragment_unnamed_578 + fragment_uniform_buffer_0[11u].x;
				precise float fragment_unnamed_590 = fragment_unnamed_580 + fragment_uniform_buffer_0[11u].y;
				precise float fragment_unnamed_591 = fragment_unnamed_582 + fragment_uniform_buffer_0[11u].z;
				precise float fragment_unnamed_600 = fragment_unnamed_569.x * mad(fragment_unnamed_280, fragment_unnamed_589, fragment_uniform_buffer_0[10u].x);
				precise float fragment_unnamed_601 = fragment_unnamed_569.y * mad(fragment_unnamed_280, fragment_unnamed_590, fragment_uniform_buffer_0[10u].y);
				precise float fragment_unnamed_602 = fragment_unnamed_569.z * mad(fragment_unnamed_280, fragment_unnamed_591, fragment_uniform_buffer_0[10u].z);
				precise float fragment_unnamed_607 = (-0.0f) - fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_611 = fragment_unnamed_607 + fragment_uniform_buffer_0[31u].z;
				bool fragment_unnamed_619 = fragment_uniform_buffer_4[0u].x == 1.0f;
				float fragment_unnamed_713;
				float fragment_unnamed_714;
				float fragment_unnamed_715;
				float fragment_unnamed_716;
				if (fragment_unnamed_619)
				{
					bool fragment_unnamed_623 = fragment_uniform_buffer_4[0u].y == 1.0f;
					precise float fragment_unnamed_631 = fragment_input_4.w * fragment_uniform_buffer_4[2u].x;
					precise float fragment_unnamed_632 = fragment_input_4.w * fragment_uniform_buffer_4[2u].y;
					precise float fragment_unnamed_633 = fragment_input_4.w * fragment_uniform_buffer_4[2u].z;
					precise float fragment_unnamed_659 = mad(fragment_uniform_buffer_4[3u].x, fragment_input_5.w, mad(fragment_uniform_buffer_4[1u].x, fragment_input_3.w, fragment_unnamed_631)) + fragment_uniform_buffer_4[4u].x;
					precise float fragment_unnamed_660 = mad(fragment_uniform_buffer_4[3u].y, fragment_input_5.w, mad(fragment_uniform_buffer_4[1u].y, fragment_input_3.w, fragment_unnamed_632)) + fragment_uniform_buffer_4[4u].y;
					precise float fragment_unnamed_661 = mad(fragment_uniform_buffer_4[3u].z, fragment_input_5.w, mad(fragment_uniform_buffer_4[1u].z, fragment_input_3.w, fragment_unnamed_633)) + fragment_uniform_buffer_4[4u].z;
					precise float fragment_unnamed_677 = (-0.0f) - fragment_uniform_buffer_4[6u].x;
					precise float fragment_unnamed_679 = (-0.0f) - fragment_uniform_buffer_4[6u].y;
					precise float fragment_unnamed_681 = (-0.0f) - fragment_uniform_buffer_4[6u].z;
					precise float fragment_unnamed_682 = asfloat(fragment_unnamed_623 ? asuint(fragment_unnamed_659) : asuint(fragment_input_3.w)) + fragment_unnamed_677;
					precise float fragment_unnamed_683 = asfloat(fragment_unnamed_623 ? asuint(fragment_unnamed_660) : asuint(fragment_input_4.w)) + fragment_unnamed_679;
					precise float fragment_unnamed_684 = asfloat(fragment_unnamed_623 ? asuint(fragment_unnamed_661) : asuint(fragment_input_5.w)) + fragment_unnamed_681;
					precise float fragment_unnamed_690 = fragment_unnamed_682 * fragment_uniform_buffer_4[5u].x;
					precise float fragment_unnamed_691 = fragment_unnamed_683 * fragment_uniform_buffer_4[5u].y;
					precise float fragment_unnamed_692 = fragment_unnamed_684 * fragment_uniform_buffer_4[5u].z;
					float4 fragment_unnamed_703 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_690, 0.25f, 0.75f), mad(fragment_uniform_buffer_4[0u].z, 0.5f, 0.75f)), fragment_unnamed_691, fragment_unnamed_692));
					fragment_unnamed_713 = fragment_unnamed_703.x;
					fragment_unnamed_714 = fragment_unnamed_703.y;
					fragment_unnamed_715 = fragment_unnamed_703.z;
					fragment_unnamed_716 = fragment_unnamed_703.w;
				}
				else
				{
					fragment_unnamed_713 = asfloat(1065353216u);
					fragment_unnamed_714 = asfloat(1065353216u);
					fragment_unnamed_715 = asfloat(1065353216u);
					fragment_unnamed_716 = asfloat(1065353216u);
				}
				float fragment_unnamed_727 = clamp(dot(float4(fragment_unnamed_713, fragment_unnamed_714, fragment_unnamed_715, fragment_unnamed_716), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f);
				precise float fragment_unnamed_734 = (-0.0f) - fragment_unnamed_520;
				precise float fragment_unnamed_735 = (-0.0f) - fragment_unnamed_521;
				precise float fragment_unnamed_736 = (-0.0f) - fragment_unnamed_522;
				float fragment_unnamed_737 = dot(float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z), float3(fragment_unnamed_734, fragment_unnamed_735, fragment_unnamed_736));
				precise float fragment_unnamed_746 = (-0.0f) - fragment_unnamed_520;
				precise float fragment_unnamed_747 = (-0.0f) - fragment_unnamed_521;
				precise float fragment_unnamed_748 = (-0.0f) - fragment_unnamed_522;
				float fragment_unnamed_749 = dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_unnamed_746, fragment_unnamed_747, fragment_unnamed_748));
				precise float fragment_unnamed_758 = (-0.0f) - fragment_unnamed_520;
				precise float fragment_unnamed_759 = (-0.0f) - fragment_unnamed_521;
				precise float fragment_unnamed_760 = (-0.0f) - fragment_unnamed_522;
				float fragment_unnamed_761 = dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_unnamed_758, fragment_unnamed_759, fragment_unnamed_760));
				float fragment_unnamed_767 = rsqrt(dot(float3(fragment_unnamed_737, fragment_unnamed_749, fragment_unnamed_761), float3(fragment_unnamed_737, fragment_unnamed_749, fragment_unnamed_761)));
				precise float fragment_unnamed_768 = fragment_unnamed_767 * fragment_unnamed_737;
				precise float fragment_unnamed_769 = fragment_unnamed_767 * fragment_unnamed_749;
				precise float fragment_unnamed_770 = fragment_unnamed_767 * fragment_unnamed_761;
				precise float fragment_unnamed_776 = fragment_unnamed_727 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_777 = fragment_unnamed_727 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_778 = fragment_unnamed_727 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_930;
				float fragment_unnamed_931;
				float fragment_unnamed_932;
				if (fragment_unnamed_619)
				{
					bool fragment_unnamed_782 = fragment_uniform_buffer_4[0u].y == 1.0f;
					precise float fragment_unnamed_790 = fragment_input_4.w * fragment_uniform_buffer_4[2u].x;
					precise float fragment_unnamed_791 = fragment_input_4.w * fragment_uniform_buffer_4[2u].y;
					precise float fragment_unnamed_792 = fragment_input_4.w * fragment_uniform_buffer_4[2u].z;
					precise float fragment_unnamed_818 = mad(fragment_uniform_buffer_4[3u].x, fragment_input_5.w, mad(fragment_uniform_buffer_4[1u].x, fragment_input_3.w, fragment_unnamed_790)) + fragment_uniform_buffer_4[4u].x;
					precise float fragment_unnamed_819 = mad(fragment_uniform_buffer_4[3u].y, fragment_input_5.w, mad(fragment_uniform_buffer_4[1u].y, fragment_input_3.w, fragment_unnamed_791)) + fragment_uniform_buffer_4[4u].y;
					precise float fragment_unnamed_820 = mad(fragment_uniform_buffer_4[3u].z, fragment_input_5.w, mad(fragment_uniform_buffer_4[1u].z, fragment_input_3.w, fragment_unnamed_792)) + fragment_uniform_buffer_4[4u].z;
					precise float fragment_unnamed_836 = (-0.0f) - fragment_uniform_buffer_4[6u].x;
					precise float fragment_unnamed_838 = (-0.0f) - fragment_uniform_buffer_4[6u].y;
					precise float fragment_unnamed_840 = (-0.0f) - fragment_uniform_buffer_4[6u].z;
					precise float fragment_unnamed_841 = asfloat(fragment_unnamed_782 ? asuint(fragment_unnamed_818) : asuint(fragment_input_3.w)) + fragment_unnamed_836;
					precise float fragment_unnamed_842 = asfloat(fragment_unnamed_782 ? asuint(fragment_unnamed_819) : asuint(fragment_input_4.w)) + fragment_unnamed_838;
					precise float fragment_unnamed_843 = asfloat(fragment_unnamed_782 ? asuint(fragment_unnamed_820) : asuint(fragment_input_5.w)) + fragment_unnamed_840;
					precise float fragment_unnamed_849 = fragment_unnamed_841 * fragment_uniform_buffer_4[5u].x;
					precise float fragment_unnamed_850 = fragment_unnamed_842 * fragment_uniform_buffer_4[5u].y;
					precise float fragment_unnamed_851 = fragment_unnamed_843 * fragment_uniform_buffer_4[5u].z;
					precise float fragment_unnamed_852 = fragment_unnamed_849 * 0.25f;
					precise float fragment_unnamed_856 = fragment_uniform_buffer_4[0u].z * 0.5f;
					precise float fragment_unnamed_860 = (-0.0f) - fragment_uniform_buffer_4[0u].z;
					float fragment_unnamed_863 = min(mad(fragment_unnamed_860, 0.5f, 0.25f), max(fragment_unnamed_856, fragment_unnamed_852));
					precise float fragment_unnamed_871 = fragment_unnamed_863 + 0.25f;
					precise float fragment_unnamed_872 = fragment_unnamed_850 + 0.0f;
					precise float fragment_unnamed_873 = fragment_unnamed_851 + 0.0f;
					precise float fragment_unnamed_880 = fragment_unnamed_863 + 0.5f;
					precise float fragment_unnamed_881 = fragment_unnamed_850 + 0.0f;
					precise float fragment_unnamed_882 = fragment_unnamed_851 + 0.0f;
					float fragment_unnamed_889 = asfloat(1065353216u);
					fragment_unnamed_930 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_863, fragment_unnamed_850, fragment_unnamed_851))), float4(fragment_unnamed_768, fragment_unnamed_769, fragment_unnamed_770, fragment_unnamed_889));
					fragment_unnamed_931 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_871, fragment_unnamed_872, fragment_unnamed_873))), float4(fragment_unnamed_768, fragment_unnamed_769, fragment_unnamed_770, fragment_unnamed_889));
					fragment_unnamed_932 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_880, fragment_unnamed_881, fragment_unnamed_882))), float4(fragment_unnamed_768, fragment_unnamed_769, fragment_unnamed_770, fragment_unnamed_889));
				}
				else
				{
					float fragment_unnamed_899 = asfloat(1065353216u);
					fragment_unnamed_930 = dot(float4(fragment_uniform_buffer_2[39u]), float4(fragment_unnamed_768, fragment_unnamed_769, fragment_unnamed_770, fragment_unnamed_899));
					fragment_unnamed_931 = dot(float4(fragment_uniform_buffer_2[40u]), float4(fragment_unnamed_768, fragment_unnamed_769, fragment_unnamed_770, fragment_unnamed_899));
					fragment_unnamed_932 = dot(float4(fragment_uniform_buffer_2[41u]), float4(fragment_unnamed_768, fragment_unnamed_769, fragment_unnamed_770, fragment_unnamed_899));
				}
				precise float fragment_unnamed_939 = fragment_unnamed_930 + fragment_input_8.x;
				precise float fragment_unnamed_940 = fragment_unnamed_931 + fragment_input_8.y;
				precise float fragment_unnamed_941 = fragment_unnamed_932 + fragment_input_8.z;
				precise float fragment_unnamed_948 = log2(max(fragment_unnamed_939, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_950 = log2(max(fragment_unnamed_940, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_951 = log2(max(fragment_unnamed_941, 0.0f)) * 0.4166666567325592041015625f;
				float fragment_unnamed_968 = mad(fragment_unnamed_101, fragment_unnamed_108, fragment_uniform_buffer_2[0u].x);
				float fragment_unnamed_969 = mad(fragment_unnamed_102, fragment_unnamed_108, fragment_uniform_buffer_2[0u].y);
				float fragment_unnamed_970 = mad(fragment_unnamed_103, fragment_unnamed_108, fragment_uniform_buffer_2[0u].z);
				float fragment_unnamed_974 = rsqrt(dot(float3(fragment_unnamed_968, fragment_unnamed_969, fragment_unnamed_970), float3(fragment_unnamed_968, fragment_unnamed_969, fragment_unnamed_970)));
				precise float fragment_unnamed_975 = fragment_unnamed_974 * fragment_unnamed_968;
				precise float fragment_unnamed_976 = fragment_unnamed_974 * fragment_unnamed_969;
				precise float fragment_unnamed_977 = fragment_unnamed_974 * fragment_unnamed_970;
				float fragment_unnamed_986 = max(dot(float3(fragment_unnamed_768, fragment_unnamed_769, fragment_unnamed_770), float3(fragment_uniform_buffer_2[0u].xyz)), 0.0f);
				precise float fragment_unnamed_991 = mad(fragment_unnamed_280, fragment_unnamed_611, fragment_uniform_buffer_0[31u].y) * 128.0f;
				precise float fragment_unnamed_994 = log2(max(dot(float3(fragment_unnamed_768, fragment_unnamed_769, fragment_unnamed_770), float3(fragment_unnamed_975, fragment_unnamed_976, fragment_unnamed_977)), 0.0f)) * fragment_unnamed_991;
				float fragment_unnamed_995 = exp2(fragment_unnamed_994);
				precise float fragment_unnamed_996 = fragment_unnamed_776 * fragment_unnamed_308;
				precise float fragment_unnamed_997 = fragment_unnamed_777 * fragment_unnamed_309;
				precise float fragment_unnamed_998 = fragment_unnamed_778 * fragment_unnamed_310;
				precise float fragment_unnamed_1004 = fragment_unnamed_776 * fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_1005 = fragment_unnamed_777 * fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_1006 = fragment_unnamed_778 * fragment_uniform_buffer_0[3u].z;
				precise float fragment_unnamed_1007 = fragment_unnamed_995 * fragment_unnamed_1004;
				precise float fragment_unnamed_1008 = fragment_unnamed_995 * fragment_unnamed_1005;
				precise float fragment_unnamed_1009 = fragment_unnamed_995 * fragment_unnamed_1006;
				fragment_output_0.x = mad(fragment_unnamed_600, fragment_unnamed_305, mad(fragment_unnamed_308, max(mad(exp2(fragment_unnamed_948), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f), mad(fragment_unnamed_996, fragment_unnamed_986, fragment_unnamed_1007)));
				fragment_output_0.y = mad(fragment_unnamed_601, fragment_unnamed_305, mad(fragment_unnamed_309, max(mad(exp2(fragment_unnamed_950), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f), mad(fragment_unnamed_997, fragment_unnamed_986, fragment_unnamed_1008)));
				fragment_output_0.z = mad(fragment_unnamed_602, fragment_unnamed_305, mad(fragment_unnamed_310, max(mad(exp2(fragment_unnamed_951), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f), mad(fragment_unnamed_998, fragment_unnamed_986, fragment_unnamed_1009)));
				fragment_output_0.w = fragment_unnamed_305;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[3] = float4(_SpecColor[0], _SpecColor[1], _SpecColor[2], _SpecColor[3]);

				fragment_uniform_buffer_0[4] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _FaceUVSpeedY, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[5] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], _OutlineSoftness, fragment_uniform_buffer_0[6][2], fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], fragment_uniform_buffer_0[6][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], fragment_uniform_buffer_0[6][1], fragment_uniform_buffer_0[6][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[7] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[8] = float4(_OutlineWidth, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _Bevel, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], fragment_uniform_buffer_0[8][1], _BevelOffset, fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], _BevelWidth);

				fragment_uniform_buffer_0[9] = float4(_BevelClamp, fragment_uniform_buffer_0[9][1], fragment_uniform_buffer_0[9][2], fragment_uniform_buffer_0[9][3]);

				fragment_uniform_buffer_0[9] = float4(fragment_uniform_buffer_0[9][0], _BevelRoundness, fragment_uniform_buffer_0[9][2], fragment_uniform_buffer_0[9][3]);

				fragment_uniform_buffer_0[9] = float4(fragment_uniform_buffer_0[9][0], fragment_uniform_buffer_0[9][1], _BumpOutline, fragment_uniform_buffer_0[9][3]);

				fragment_uniform_buffer_0[9] = float4(fragment_uniform_buffer_0[9][0], fragment_uniform_buffer_0[9][1], fragment_uniform_buffer_0[9][2], _BumpFace);

				fragment_uniform_buffer_0[10] = float4(_ReflectFaceColor[0], _ReflectFaceColor[1], _ReflectFaceColor[2], _ReflectFaceColor[3]);

				fragment_uniform_buffer_0[11] = float4(_ReflectOutlineColor[0], _ReflectOutlineColor[1], _ReflectOutlineColor[2], _ReflectOutlineColor[3]);

				fragment_uniform_buffer_0[24] = float4(_ShaderFlags, fragment_uniform_buffer_0[24][1], fragment_uniform_buffer_0[24][2], fragment_uniform_buffer_0[24][3]);

				fragment_uniform_buffer_0[24] = float4(fragment_uniform_buffer_0[24][0], fragment_uniform_buffer_0[24][1], fragment_uniform_buffer_0[24][2], _ScaleRatioA);

				fragment_uniform_buffer_0[29] = float4(fragment_uniform_buffer_0[29][0], fragment_uniform_buffer_0[29][1], _TextureWidth, fragment_uniform_buffer_0[29][3]);

				fragment_uniform_buffer_0[29] = float4(fragment_uniform_buffer_0[29][0], fragment_uniform_buffer_0[29][1], fragment_uniform_buffer_0[29][2], _TextureHeight);

				fragment_uniform_buffer_0[30] = float4(_GradientScale, fragment_uniform_buffer_0[30][1], fragment_uniform_buffer_0[30][2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(fragment_uniform_buffer_0[31][0], _FaceShininess, fragment_uniform_buffer_0[31][2], fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_0[31] = float4(fragment_uniform_buffer_0[31][0], fragment_uniform_buffer_0[31][1], _OutlineShininess, fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_uniform_buffer_2[39] = float4(unity_SHAr[0], unity_SHAr[1], unity_SHAr[2], unity_SHAr[3]);

				fragment_uniform_buffer_2[40] = float4(unity_SHAg[0], unity_SHAg[1], unity_SHAg[2], unity_SHAg[3]);

				fragment_uniform_buffer_2[41] = float4(unity_SHAb[0], unity_SHAb[1], unity_SHAb[2], unity_SHAb[3]);

				fragment_uniform_buffer_2[46] = float4(unity_OcclusionMaskSelector[0], unity_OcclusionMaskSelector[1], unity_OcclusionMaskSelector[2], unity_OcclusionMaskSelector[3]);

				fragment_uniform_buffer_3[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				fragment_uniform_buffer_3[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				fragment_uniform_buffer_3[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				fragment_uniform_buffer_3[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				fragment_uniform_buffer_4[0] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_4[1] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_4[2] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_4[3] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_4[4] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_4[5] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], fragment_uniform_buffer_4[5][3]);

				fragment_uniform_buffer_4[6] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], fragment_uniform_buffer_4[6][3]);

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
			float4 _SpecColor;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float4 _ReflectFaceColor;
			float4 _ReflectOutlineColor;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;
			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_SHAr;
			float4 unity_SHAg;
			float4 unity_SHAb;
			float4 unity_OcclusionMaskSelector;
			float4x4 unity_ObjectToWorld;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[32];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[4];
			static float4 fragment_uniform_buffer_4[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			Texture2D<float4> _BumpMap;
			TextureCube<float4> _Cube;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_BumpMap;
			SamplerState sampler_Cube;
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
				precise float fragment_unnamed_89 = (-0.0f) - fragment_input_3.w;
				precise float fragment_unnamed_91 = (-0.0f) - fragment_input_4.w;
				precise float fragment_unnamed_92 = (-0.0f) - fragment_input_5.w;
				precise float fragment_unnamed_101 = fragment_unnamed_89 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_102 = fragment_unnamed_91 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_103 = fragment_unnamed_92 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_108 = rsqrt(dot(float3(fragment_unnamed_101, fragment_unnamed_102, fragment_unnamed_103), float3(fragment_unnamed_101, fragment_unnamed_102, fragment_unnamed_103)));
				precise float fragment_unnamed_114 = 1.0f / fragment_uniform_buffer_0[29u].z;
				precise float fragment_unnamed_116 = 1.0f / fragment_uniform_buffer_0[29u].w;
				float fragment_unnamed_117 = asfloat(0u);
				precise float fragment_unnamed_118 = (-0.0f) - fragment_unnamed_114;
				precise float fragment_unnamed_119 = (-0.0f) - fragment_unnamed_117;
				precise float fragment_unnamed_120 = (-0.0f) - fragment_unnamed_116;
				precise float fragment_unnamed_126 = fragment_unnamed_118 + fragment_input_1.x;
				precise float fragment_unnamed_127 = fragment_unnamed_119 + fragment_input_1.y;
				precise float fragment_unnamed_128 = fragment_unnamed_119 + fragment_input_1.x;
				precise float fragment_unnamed_129 = fragment_unnamed_120 + fragment_input_1.y;
				precise float fragment_unnamed_140 = fragment_unnamed_114 + fragment_input_1.x;
				precise float fragment_unnamed_141 = fragment_unnamed_117 + fragment_input_1.y;
				precise float fragment_unnamed_142 = fragment_unnamed_117 + fragment_input_1.x;
				precise float fragment_unnamed_143 = fragment_unnamed_116 + fragment_input_1.y;
				precise float fragment_unnamed_160 = (-0.0f) - _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
				precise float fragment_unnamed_161 = fragment_unnamed_160 + 0.5f;
				precise float fragment_unnamed_165 = (-0.0f) - fragment_input_2.x;
				precise float fragment_unnamed_166 = fragment_unnamed_161 + fragment_unnamed_165;
				float fragment_unnamed_169 = mad(fragment_unnamed_166, fragment_input_2.y, 0.5f);
				precise float fragment_unnamed_178 = fragment_uniform_buffer_0[8u].x * fragment_uniform_buffer_0[24u].w;
				precise float fragment_unnamed_186 = fragment_uniform_buffer_0[6u].y * fragment_uniform_buffer_0[24u].w;
				precise float fragment_unnamed_189 = fragment_unnamed_178 * fragment_input_2.y;
				precise float fragment_unnamed_190 = fragment_unnamed_186 * fragment_input_2.y;
				precise float fragment_unnamed_206 = fragment_input_6.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_207 = fragment_input_6.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_208 = fragment_input_6.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_209 = fragment_input_6.w * fragment_uniform_buffer_0[5u].w;
				precise float fragment_unnamed_215 = fragment_input_6.w * fragment_uniform_buffer_0[7u].w;
				float4 fragment_unnamed_230 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[4u].x, fragment_uniform_buffer_1[0u].y, fragment_input_1.z), mad(fragment_uniform_buffer_0[4u].y, fragment_uniform_buffer_1[0u].y, fragment_input_1.w)));
				precise float fragment_unnamed_236 = fragment_unnamed_206 * fragment_unnamed_230.x;
				precise float fragment_unnamed_237 = fragment_unnamed_207 * fragment_unnamed_230.y;
				precise float fragment_unnamed_238 = fragment_unnamed_208 * fragment_unnamed_230.z;
				precise float fragment_unnamed_239 = fragment_unnamed_209 * fragment_unnamed_230.w;
				float4 fragment_unnamed_254 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[6u].z, fragment_uniform_buffer_1[0u].y, fragment_input_2.x), mad(fragment_uniform_buffer_0[6u].w, fragment_uniform_buffer_1[0u].y, fragment_input_2.y)));
				precise float fragment_unnamed_265 = fragment_unnamed_254.x * fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_266 = fragment_unnamed_254.y * fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_267 = fragment_unnamed_254.z * fragment_uniform_buffer_0[7u].z;
				precise float fragment_unnamed_268 = fragment_unnamed_215 * fragment_unnamed_254.w;
				precise float fragment_unnamed_269 = (-0.0f) - fragment_unnamed_189;
				precise float fragment_unnamed_275 = mad(fragment_unnamed_190, 0.5f, mad(fragment_unnamed_269, 0.5f, fragment_unnamed_169)) / mad(fragment_unnamed_186, fragment_input_2.y, 1.0f);
				precise float fragment_unnamed_277 = (-0.0f) - clamp(fragment_unnamed_275, 0.0f, 1.0f);
				precise float fragment_unnamed_278 = fragment_unnamed_277 + 1.0f;
				float fragment_unnamed_280 = clamp(mad(fragment_unnamed_189, 0.5f, fragment_unnamed_169), 0.0f, 1.0f);
				precise float fragment_unnamed_283 = fragment_unnamed_280 * sqrt(min(fragment_unnamed_189, 1.0f));
				precise float fragment_unnamed_284 = fragment_unnamed_239 * fragment_unnamed_236;
				precise float fragment_unnamed_285 = fragment_unnamed_239 * fragment_unnamed_237;
				precise float fragment_unnamed_286 = fragment_unnamed_239 * fragment_unnamed_238;
				precise float fragment_unnamed_287 = fragment_unnamed_265 * fragment_unnamed_268;
				precise float fragment_unnamed_288 = fragment_unnamed_266 * fragment_unnamed_268;
				precise float fragment_unnamed_289 = fragment_unnamed_267 * fragment_unnamed_268;
				precise float fragment_unnamed_290 = (-0.0f) - fragment_unnamed_284;
				precise float fragment_unnamed_291 = (-0.0f) - fragment_unnamed_285;
				precise float fragment_unnamed_292 = (-0.0f) - fragment_unnamed_286;
				precise float fragment_unnamed_293 = (-0.0f) - fragment_unnamed_239;
				precise float fragment_unnamed_294 = fragment_unnamed_290 + fragment_unnamed_287;
				precise float fragment_unnamed_295 = fragment_unnamed_291 + fragment_unnamed_288;
				precise float fragment_unnamed_296 = fragment_unnamed_292 + fragment_unnamed_289;
				precise float fragment_unnamed_297 = fragment_unnamed_293 + fragment_unnamed_268;
				precise float fragment_unnamed_302 = fragment_unnamed_278 * mad(fragment_unnamed_283, fragment_unnamed_294, fragment_unnamed_284);
				precise float fragment_unnamed_303 = fragment_unnamed_278 * mad(fragment_unnamed_283, fragment_unnamed_295, fragment_unnamed_285);
				precise float fragment_unnamed_304 = fragment_unnamed_278 * mad(fragment_unnamed_283, fragment_unnamed_296, fragment_unnamed_286);
				precise float fragment_unnamed_305 = fragment_unnamed_278 * mad(fragment_unnamed_283, fragment_unnamed_297, fragment_unnamed_239);
				float fragment_unnamed_306 = max(fragment_unnamed_305, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_308 = fragment_unnamed_302 / fragment_unnamed_306;
				precise float fragment_unnamed_309 = fragment_unnamed_303 / fragment_unnamed_306;
				precise float fragment_unnamed_310 = fragment_unnamed_304 / fragment_unnamed_306;
				precise float fragment_unnamed_314 = fragment_uniform_buffer_0[24u].x * 0.5f;
				precise float fragment_unnamed_315 = (-0.0f) - fragment_unnamed_314;
				float fragment_unnamed_319 = frac(abs(fragment_unnamed_314));
				precise float fragment_unnamed_320 = (-0.0f) - fragment_unnamed_319;
				bool fragment_unnamed_322 = ((fragment_unnamed_314 >= fragment_unnamed_315) ? fragment_unnamed_319 : fragment_unnamed_320) >= 0.5f;
				precise float fragment_unnamed_328 = fragment_input_2.x + fragment_uniform_buffer_0[8u].z;
				precise float fragment_unnamed_329 = fragment_unnamed_328 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_126, fragment_unnamed_127)).w;
				precise float fragment_unnamed_330 = fragment_unnamed_328 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_140, fragment_unnamed_141)).w;
				precise float fragment_unnamed_331 = fragment_unnamed_328 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_128, fragment_unnamed_129)).w;
				precise float fragment_unnamed_332 = fragment_unnamed_328 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_142, fragment_unnamed_143)).w;
				precise float fragment_unnamed_339 = fragment_uniform_buffer_0[8u].w + fragment_uniform_buffer_0[8u].x;
				float fragment_unnamed_340 = max(fragment_unnamed_339, 0.00999999977648258209228515625f);
				precise float fragment_unnamed_342 = fragment_unnamed_329 + (-0.5f);
				precise float fragment_unnamed_344 = fragment_unnamed_330 + (-0.5f);
				precise float fragment_unnamed_345 = fragment_unnamed_331 + (-0.5f);
				precise float fragment_unnamed_346 = fragment_unnamed_332 + (-0.5f);
				precise float fragment_unnamed_347 = fragment_unnamed_342 / fragment_unnamed_340;
				precise float fragment_unnamed_348 = fragment_unnamed_344 / fragment_unnamed_340;
				precise float fragment_unnamed_349 = fragment_unnamed_345 / fragment_unnamed_340;
				precise float fragment_unnamed_350 = fragment_unnamed_346 / fragment_unnamed_340;
				precise float fragment_unnamed_351 = fragment_unnamed_347 + 0.5f;
				precise float fragment_unnamed_352 = fragment_unnamed_348 + 0.5f;
				precise float fragment_unnamed_353 = fragment_unnamed_349 + 0.5f;
				precise float fragment_unnamed_354 = fragment_unnamed_350 + 0.5f;
				float fragment_unnamed_355 = clamp(fragment_unnamed_351, 0.0f, 1.0f);
				float fragment_unnamed_356 = clamp(fragment_unnamed_352, 0.0f, 1.0f);
				float fragment_unnamed_357 = clamp(fragment_unnamed_353, 0.0f, 1.0f);
				float fragment_unnamed_358 = clamp(fragment_unnamed_354, 0.0f, 1.0f);
				precise float fragment_unnamed_366 = (-0.0f) - abs(mad(fragment_unnamed_355, 2.0f, -1.0f));
				precise float fragment_unnamed_368 = (-0.0f) - abs(mad(fragment_unnamed_356, 2.0f, -1.0f));
				precise float fragment_unnamed_370 = (-0.0f) - abs(mad(fragment_unnamed_357, 2.0f, -1.0f));
				precise float fragment_unnamed_372 = (-0.0f) - abs(mad(fragment_unnamed_358, 2.0f, -1.0f));
				precise float fragment_unnamed_373 = fragment_unnamed_366 + 1.0f;
				precise float fragment_unnamed_374 = fragment_unnamed_368 + 1.0f;
				precise float fragment_unnamed_375 = fragment_unnamed_370 + 1.0f;
				precise float fragment_unnamed_376 = fragment_unnamed_372 + 1.0f;
				float fragment_unnamed_386 = asfloat(fragment_unnamed_322 ? asuint(fragment_unnamed_373) : asuint(fragment_unnamed_355));
				float fragment_unnamed_388 = asfloat(fragment_unnamed_322 ? asuint(fragment_unnamed_374) : asuint(fragment_unnamed_356));
				float fragment_unnamed_390 = asfloat(fragment_unnamed_322 ? asuint(fragment_unnamed_375) : asuint(fragment_unnamed_357));
				float fragment_unnamed_392 = asfloat(fragment_unnamed_322 ? asuint(fragment_unnamed_376) : asuint(fragment_unnamed_358));
				precise float fragment_unnamed_393 = fragment_unnamed_386 * 1.57079601287841796875f;
				precise float fragment_unnamed_395 = fragment_unnamed_388 * 1.57079601287841796875f;
				precise float fragment_unnamed_396 = fragment_unnamed_390 * 1.57079601287841796875f;
				precise float fragment_unnamed_397 = fragment_unnamed_392 * 1.57079601287841796875f;
				precise float fragment_unnamed_402 = (-0.0f) - fragment_unnamed_386;
				precise float fragment_unnamed_403 = (-0.0f) - fragment_unnamed_388;
				precise float fragment_unnamed_404 = (-0.0f) - fragment_unnamed_390;
				precise float fragment_unnamed_405 = (-0.0f) - fragment_unnamed_392;
				precise float fragment_unnamed_406 = fragment_unnamed_402 + sin(fragment_unnamed_393);
				precise float fragment_unnamed_407 = fragment_unnamed_403 + sin(fragment_unnamed_395);
				precise float fragment_unnamed_408 = fragment_unnamed_404 + sin(fragment_unnamed_396);
				precise float fragment_unnamed_409 = fragment_unnamed_405 + sin(fragment_unnamed_397);
				precise float fragment_unnamed_421 = (-0.0f) - fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_422 = fragment_unnamed_421 + 1.0f;
				precise float fragment_unnamed_430 = fragment_unnamed_340 * fragment_uniform_buffer_0[8u].y;
				precise float fragment_unnamed_435 = fragment_unnamed_430 * fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_436 = fragment_unnamed_435 * (-2.0f);
				precise float fragment_unnamed_438 = min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_406, fragment_unnamed_386), fragment_unnamed_422) * fragment_unnamed_436;
				precise float fragment_unnamed_439 = min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_408, fragment_unnamed_390), fragment_unnamed_422) * fragment_unnamed_436;
				precise float fragment_unnamed_440 = (-0.0f) - fragment_unnamed_439;
				precise float fragment_unnamed_441 = (-0.0f) - fragment_unnamed_438;
				float fragment_unnamed_442 = mad(min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_409, fragment_unnamed_392), fragment_unnamed_422), fragment_unnamed_436, fragment_unnamed_440);
				float fragment_unnamed_443 = mad(min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_407, fragment_unnamed_388), fragment_unnamed_422), fragment_unnamed_436, fragment_unnamed_441);
				float fragment_unnamed_444 = asfloat(3212836864u);
				float fragment_unnamed_446 = asfloat(1065353216u);
				float fragment_unnamed_451 = rsqrt(dot(float2(fragment_unnamed_443, fragment_unnamed_446), float2(fragment_unnamed_443, fragment_unnamed_446)));
				precise float fragment_unnamed_452 = fragment_unnamed_451 * 1.0f;
				precise float fragment_unnamed_453 = fragment_unnamed_451 * 0.0f;
				precise float fragment_unnamed_454 = fragment_unnamed_451 * fragment_unnamed_443;
				float fragment_unnamed_458 = rsqrt(dot(float2(fragment_unnamed_444, fragment_unnamed_442), float2(fragment_unnamed_444, fragment_unnamed_442)));
				precise float fragment_unnamed_460 = fragment_unnamed_458 * fragment_unnamed_444;
				precise float fragment_unnamed_461 = fragment_unnamed_458 * fragment_unnamed_442;
				precise float fragment_unnamed_462 = fragment_unnamed_458 * asfloat(0u);
				precise float fragment_unnamed_463 = fragment_unnamed_460 * fragment_unnamed_454;
				precise float fragment_unnamed_464 = fragment_unnamed_461 * fragment_unnamed_452;
				precise float fragment_unnamed_465 = fragment_unnamed_462 * fragment_unnamed_453;
				precise float fragment_unnamed_466 = (-0.0f) - fragment_unnamed_463;
				precise float fragment_unnamed_467 = (-0.0f) - fragment_unnamed_464;
				precise float fragment_unnamed_468 = (-0.0f) - fragment_unnamed_465;
				float4 fragment_unnamed_477 = _BumpMap.Sample(sampler_BumpMap, float2(fragment_input_1.z, fragment_input_1.w));
				precise float fragment_unnamed_482 = fragment_unnamed_477.w * fragment_unnamed_477.x;
				float fragment_unnamed_483 = mad(fragment_unnamed_482, 2.0f, -1.0f);
				float fragment_unnamed_484 = mad(fragment_unnamed_477.y, 2.0f, -1.0f);
				precise float fragment_unnamed_489 = (-0.0f) - min(dot(float2(fragment_unnamed_483, fragment_unnamed_484), float2(fragment_unnamed_483, fragment_unnamed_484)), 1.0f);
				precise float fragment_unnamed_490 = fragment_unnamed_489 + 1.0f;
				precise float fragment_unnamed_495 = (-0.0f) - fragment_uniform_buffer_0[9u].w;
				precise float fragment_unnamed_499 = fragment_unnamed_495 + fragment_uniform_buffer_0[9u].z;
				float fragment_unnamed_503 = mad(fragment_unnamed_280, fragment_unnamed_499, fragment_uniform_buffer_0[9u].w);
				precise float fragment_unnamed_510 = (-0.0f) - mad(fragment_unnamed_305, mad(fragment_unnamed_483, fragment_unnamed_503, -0.0f), 0.0f);
				precise float fragment_unnamed_511 = (-0.0f) - mad(fragment_unnamed_305, mad(fragment_unnamed_484, fragment_unnamed_503, -0.0f), 0.0f);
				precise float fragment_unnamed_512 = (-0.0f) - mad(fragment_unnamed_305, mad(sqrt(fragment_unnamed_490), fragment_unnamed_503, -1.0f), 1.0f);
				precise float fragment_unnamed_513 = mad(fragment_unnamed_453, fragment_unnamed_461, fragment_unnamed_466) + fragment_unnamed_510;
				precise float fragment_unnamed_514 = mad(fragment_unnamed_454, fragment_unnamed_462, fragment_unnamed_467) + fragment_unnamed_511;
				precise float fragment_unnamed_515 = mad(fragment_unnamed_452, fragment_unnamed_460, fragment_unnamed_468) + fragment_unnamed_512;
				float fragment_unnamed_519 = rsqrt(dot(float3(fragment_unnamed_513, fragment_unnamed_514, fragment_unnamed_515), float3(fragment_unnamed_513, fragment_unnamed_514, fragment_unnamed_515)));
				precise float fragment_unnamed_520 = fragment_unnamed_519 * fragment_unnamed_513;
				precise float fragment_unnamed_521 = fragment_unnamed_519 * fragment_unnamed_514;
				precise float fragment_unnamed_522 = fragment_unnamed_519 * fragment_unnamed_515;
				precise float fragment_unnamed_528 = fragment_unnamed_521 * fragment_uniform_buffer_3[1u].x;
				precise float fragment_unnamed_529 = fragment_unnamed_521 * fragment_uniform_buffer_3[1u].y;
				precise float fragment_unnamed_530 = fragment_unnamed_521 * fragment_uniform_buffer_3[1u].z;
				float fragment_unnamed_544 = mad(fragment_uniform_buffer_3[2u].x, fragment_unnamed_522, mad(fragment_uniform_buffer_3[0u].x, fragment_unnamed_520, fragment_unnamed_528));
				float fragment_unnamed_545 = mad(fragment_uniform_buffer_3[2u].y, fragment_unnamed_522, mad(fragment_uniform_buffer_3[0u].y, fragment_unnamed_520, fragment_unnamed_529));
				float fragment_unnamed_546 = mad(fragment_uniform_buffer_3[2u].z, fragment_unnamed_522, mad(fragment_uniform_buffer_3[0u].z, fragment_unnamed_520, fragment_unnamed_530));
				float fragment_unnamed_553 = dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_unnamed_544, fragment_unnamed_545, fragment_unnamed_546));
				precise float fragment_unnamed_556 = fragment_unnamed_553 + fragment_unnamed_553;
				precise float fragment_unnamed_557 = (-0.0f) - fragment_unnamed_556;
				float4 fragment_unnamed_569 = _Cube.Sample(sampler_Cube, float3(mad(fragment_unnamed_544, fragment_unnamed_557, fragment_input_7.x), mad(fragment_unnamed_545, fragment_unnamed_557, fragment_input_7.y), mad(fragment_unnamed_546, fragment_unnamed_557, fragment_input_7.z)));
				precise float fragment_unnamed_578 = (-0.0f) - fragment_uniform_buffer_0[10u].x;
				precise float fragment_unnamed_580 = (-0.0f) - fragment_uniform_buffer_0[10u].y;
				precise float fragment_unnamed_582 = (-0.0f) - fragment_uniform_buffer_0[10u].z;
				precise float fragment_unnamed_589 = fragment_unnamed_578 + fragment_uniform_buffer_0[11u].x;
				precise float fragment_unnamed_590 = fragment_unnamed_580 + fragment_uniform_buffer_0[11u].y;
				precise float fragment_unnamed_591 = fragment_unnamed_582 + fragment_uniform_buffer_0[11u].z;
				precise float fragment_unnamed_600 = fragment_unnamed_569.x * mad(fragment_unnamed_280, fragment_unnamed_589, fragment_uniform_buffer_0[10u].x);
				precise float fragment_unnamed_601 = fragment_unnamed_569.y * mad(fragment_unnamed_280, fragment_unnamed_590, fragment_uniform_buffer_0[10u].y);
				precise float fragment_unnamed_602 = fragment_unnamed_569.z * mad(fragment_unnamed_280, fragment_unnamed_591, fragment_uniform_buffer_0[10u].z);
				precise float fragment_unnamed_607 = (-0.0f) - fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_611 = fragment_unnamed_607 + fragment_uniform_buffer_0[31u].z;
				bool fragment_unnamed_619 = fragment_uniform_buffer_4[0u].x == 1.0f;
				float fragment_unnamed_713;
				float fragment_unnamed_714;
				float fragment_unnamed_715;
				float fragment_unnamed_716;
				if (fragment_unnamed_619)
				{
					bool fragment_unnamed_623 = fragment_uniform_buffer_4[0u].y == 1.0f;
					precise float fragment_unnamed_631 = fragment_input_4.w * fragment_uniform_buffer_4[2u].x;
					precise float fragment_unnamed_632 = fragment_input_4.w * fragment_uniform_buffer_4[2u].y;
					precise float fragment_unnamed_633 = fragment_input_4.w * fragment_uniform_buffer_4[2u].z;
					precise float fragment_unnamed_659 = mad(fragment_uniform_buffer_4[3u].x, fragment_input_5.w, mad(fragment_uniform_buffer_4[1u].x, fragment_input_3.w, fragment_unnamed_631)) + fragment_uniform_buffer_4[4u].x;
					precise float fragment_unnamed_660 = mad(fragment_uniform_buffer_4[3u].y, fragment_input_5.w, mad(fragment_uniform_buffer_4[1u].y, fragment_input_3.w, fragment_unnamed_632)) + fragment_uniform_buffer_4[4u].y;
					precise float fragment_unnamed_661 = mad(fragment_uniform_buffer_4[3u].z, fragment_input_5.w, mad(fragment_uniform_buffer_4[1u].z, fragment_input_3.w, fragment_unnamed_633)) + fragment_uniform_buffer_4[4u].z;
					precise float fragment_unnamed_677 = (-0.0f) - fragment_uniform_buffer_4[6u].x;
					precise float fragment_unnamed_679 = (-0.0f) - fragment_uniform_buffer_4[6u].y;
					precise float fragment_unnamed_681 = (-0.0f) - fragment_uniform_buffer_4[6u].z;
					precise float fragment_unnamed_682 = asfloat(fragment_unnamed_623 ? asuint(fragment_unnamed_659) : asuint(fragment_input_3.w)) + fragment_unnamed_677;
					precise float fragment_unnamed_683 = asfloat(fragment_unnamed_623 ? asuint(fragment_unnamed_660) : asuint(fragment_input_4.w)) + fragment_unnamed_679;
					precise float fragment_unnamed_684 = asfloat(fragment_unnamed_623 ? asuint(fragment_unnamed_661) : asuint(fragment_input_5.w)) + fragment_unnamed_681;
					precise float fragment_unnamed_690 = fragment_unnamed_682 * fragment_uniform_buffer_4[5u].x;
					precise float fragment_unnamed_691 = fragment_unnamed_683 * fragment_uniform_buffer_4[5u].y;
					precise float fragment_unnamed_692 = fragment_unnamed_684 * fragment_uniform_buffer_4[5u].z;
					float4 fragment_unnamed_703 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_690, 0.25f, 0.75f), mad(fragment_uniform_buffer_4[0u].z, 0.5f, 0.75f)), fragment_unnamed_691, fragment_unnamed_692));
					fragment_unnamed_713 = fragment_unnamed_703.x;
					fragment_unnamed_714 = fragment_unnamed_703.y;
					fragment_unnamed_715 = fragment_unnamed_703.z;
					fragment_unnamed_716 = fragment_unnamed_703.w;
				}
				else
				{
					fragment_unnamed_713 = asfloat(1065353216u);
					fragment_unnamed_714 = asfloat(1065353216u);
					fragment_unnamed_715 = asfloat(1065353216u);
					fragment_unnamed_716 = asfloat(1065353216u);
				}
				float fragment_unnamed_727 = clamp(dot(float4(fragment_unnamed_713, fragment_unnamed_714, fragment_unnamed_715, fragment_unnamed_716), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f);
				precise float fragment_unnamed_734 = (-0.0f) - fragment_unnamed_520;
				precise float fragment_unnamed_735 = (-0.0f) - fragment_unnamed_521;
				precise float fragment_unnamed_736 = (-0.0f) - fragment_unnamed_522;
				float fragment_unnamed_737 = dot(float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z), float3(fragment_unnamed_734, fragment_unnamed_735, fragment_unnamed_736));
				precise float fragment_unnamed_746 = (-0.0f) - fragment_unnamed_520;
				precise float fragment_unnamed_747 = (-0.0f) - fragment_unnamed_521;
				precise float fragment_unnamed_748 = (-0.0f) - fragment_unnamed_522;
				float fragment_unnamed_749 = dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_unnamed_746, fragment_unnamed_747, fragment_unnamed_748));
				precise float fragment_unnamed_758 = (-0.0f) - fragment_unnamed_520;
				precise float fragment_unnamed_759 = (-0.0f) - fragment_unnamed_521;
				precise float fragment_unnamed_760 = (-0.0f) - fragment_unnamed_522;
				float fragment_unnamed_761 = dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_unnamed_758, fragment_unnamed_759, fragment_unnamed_760));
				float fragment_unnamed_767 = rsqrt(dot(float3(fragment_unnamed_737, fragment_unnamed_749, fragment_unnamed_761), float3(fragment_unnamed_737, fragment_unnamed_749, fragment_unnamed_761)));
				precise float fragment_unnamed_768 = fragment_unnamed_767 * fragment_unnamed_737;
				precise float fragment_unnamed_769 = fragment_unnamed_767 * fragment_unnamed_749;
				precise float fragment_unnamed_770 = fragment_unnamed_767 * fragment_unnamed_761;
				precise float fragment_unnamed_776 = fragment_unnamed_727 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_777 = fragment_unnamed_727 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_778 = fragment_unnamed_727 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_930;
				float fragment_unnamed_931;
				float fragment_unnamed_932;
				if (fragment_unnamed_619)
				{
					bool fragment_unnamed_782 = fragment_uniform_buffer_4[0u].y == 1.0f;
					precise float fragment_unnamed_790 = fragment_input_4.w * fragment_uniform_buffer_4[2u].x;
					precise float fragment_unnamed_791 = fragment_input_4.w * fragment_uniform_buffer_4[2u].y;
					precise float fragment_unnamed_792 = fragment_input_4.w * fragment_uniform_buffer_4[2u].z;
					precise float fragment_unnamed_818 = mad(fragment_uniform_buffer_4[3u].x, fragment_input_5.w, mad(fragment_uniform_buffer_4[1u].x, fragment_input_3.w, fragment_unnamed_790)) + fragment_uniform_buffer_4[4u].x;
					precise float fragment_unnamed_819 = mad(fragment_uniform_buffer_4[3u].y, fragment_input_5.w, mad(fragment_uniform_buffer_4[1u].y, fragment_input_3.w, fragment_unnamed_791)) + fragment_uniform_buffer_4[4u].y;
					precise float fragment_unnamed_820 = mad(fragment_uniform_buffer_4[3u].z, fragment_input_5.w, mad(fragment_uniform_buffer_4[1u].z, fragment_input_3.w, fragment_unnamed_792)) + fragment_uniform_buffer_4[4u].z;
					precise float fragment_unnamed_836 = (-0.0f) - fragment_uniform_buffer_4[6u].x;
					precise float fragment_unnamed_838 = (-0.0f) - fragment_uniform_buffer_4[6u].y;
					precise float fragment_unnamed_840 = (-0.0f) - fragment_uniform_buffer_4[6u].z;
					precise float fragment_unnamed_841 = asfloat(fragment_unnamed_782 ? asuint(fragment_unnamed_818) : asuint(fragment_input_3.w)) + fragment_unnamed_836;
					precise float fragment_unnamed_842 = asfloat(fragment_unnamed_782 ? asuint(fragment_unnamed_819) : asuint(fragment_input_4.w)) + fragment_unnamed_838;
					precise float fragment_unnamed_843 = asfloat(fragment_unnamed_782 ? asuint(fragment_unnamed_820) : asuint(fragment_input_5.w)) + fragment_unnamed_840;
					precise float fragment_unnamed_849 = fragment_unnamed_841 * fragment_uniform_buffer_4[5u].x;
					precise float fragment_unnamed_850 = fragment_unnamed_842 * fragment_uniform_buffer_4[5u].y;
					precise float fragment_unnamed_851 = fragment_unnamed_843 * fragment_uniform_buffer_4[5u].z;
					precise float fragment_unnamed_852 = fragment_unnamed_849 * 0.25f;
					precise float fragment_unnamed_856 = fragment_uniform_buffer_4[0u].z * 0.5f;
					precise float fragment_unnamed_860 = (-0.0f) - fragment_uniform_buffer_4[0u].z;
					float fragment_unnamed_863 = min(mad(fragment_unnamed_860, 0.5f, 0.25f), max(fragment_unnamed_856, fragment_unnamed_852));
					precise float fragment_unnamed_871 = fragment_unnamed_863 + 0.25f;
					precise float fragment_unnamed_872 = fragment_unnamed_850 + 0.0f;
					precise float fragment_unnamed_873 = fragment_unnamed_851 + 0.0f;
					precise float fragment_unnamed_880 = fragment_unnamed_863 + 0.5f;
					precise float fragment_unnamed_881 = fragment_unnamed_850 + 0.0f;
					precise float fragment_unnamed_882 = fragment_unnamed_851 + 0.0f;
					float fragment_unnamed_889 = asfloat(1065353216u);
					fragment_unnamed_930 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_863, fragment_unnamed_850, fragment_unnamed_851))), float4(fragment_unnamed_768, fragment_unnamed_769, fragment_unnamed_770, fragment_unnamed_889));
					fragment_unnamed_931 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_871, fragment_unnamed_872, fragment_unnamed_873))), float4(fragment_unnamed_768, fragment_unnamed_769, fragment_unnamed_770, fragment_unnamed_889));
					fragment_unnamed_932 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_880, fragment_unnamed_881, fragment_unnamed_882))), float4(fragment_unnamed_768, fragment_unnamed_769, fragment_unnamed_770, fragment_unnamed_889));
				}
				else
				{
					float fragment_unnamed_899 = asfloat(1065353216u);
					fragment_unnamed_930 = dot(float4(fragment_uniform_buffer_2[39u]), float4(fragment_unnamed_768, fragment_unnamed_769, fragment_unnamed_770, fragment_unnamed_899));
					fragment_unnamed_931 = dot(float4(fragment_uniform_buffer_2[40u]), float4(fragment_unnamed_768, fragment_unnamed_769, fragment_unnamed_770, fragment_unnamed_899));
					fragment_unnamed_932 = dot(float4(fragment_uniform_buffer_2[41u]), float4(fragment_unnamed_768, fragment_unnamed_769, fragment_unnamed_770, fragment_unnamed_899));
				}
				precise float fragment_unnamed_939 = fragment_unnamed_930 + fragment_input_8.x;
				precise float fragment_unnamed_940 = fragment_unnamed_931 + fragment_input_8.y;
				precise float fragment_unnamed_941 = fragment_unnamed_932 + fragment_input_8.z;
				precise float fragment_unnamed_948 = log2(max(fragment_unnamed_939, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_950 = log2(max(fragment_unnamed_940, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_951 = log2(max(fragment_unnamed_941, 0.0f)) * 0.4166666567325592041015625f;
				float fragment_unnamed_968 = mad(fragment_unnamed_101, fragment_unnamed_108, fragment_uniform_buffer_2[0u].x);
				float fragment_unnamed_969 = mad(fragment_unnamed_102, fragment_unnamed_108, fragment_uniform_buffer_2[0u].y);
				float fragment_unnamed_970 = mad(fragment_unnamed_103, fragment_unnamed_108, fragment_uniform_buffer_2[0u].z);
				float fragment_unnamed_974 = rsqrt(dot(float3(fragment_unnamed_968, fragment_unnamed_969, fragment_unnamed_970), float3(fragment_unnamed_968, fragment_unnamed_969, fragment_unnamed_970)));
				precise float fragment_unnamed_975 = fragment_unnamed_974 * fragment_unnamed_968;
				precise float fragment_unnamed_976 = fragment_unnamed_974 * fragment_unnamed_969;
				precise float fragment_unnamed_977 = fragment_unnamed_974 * fragment_unnamed_970;
				float fragment_unnamed_986 = max(dot(float3(fragment_unnamed_768, fragment_unnamed_769, fragment_unnamed_770), float3(fragment_uniform_buffer_2[0u].xyz)), 0.0f);
				precise float fragment_unnamed_991 = mad(fragment_unnamed_280, fragment_unnamed_611, fragment_uniform_buffer_0[31u].y) * 128.0f;
				precise float fragment_unnamed_994 = log2(max(dot(float3(fragment_unnamed_768, fragment_unnamed_769, fragment_unnamed_770), float3(fragment_unnamed_975, fragment_unnamed_976, fragment_unnamed_977)), 0.0f)) * fragment_unnamed_991;
				float fragment_unnamed_995 = exp2(fragment_unnamed_994);
				precise float fragment_unnamed_996 = fragment_unnamed_776 * fragment_unnamed_308;
				precise float fragment_unnamed_997 = fragment_unnamed_777 * fragment_unnamed_309;
				precise float fragment_unnamed_998 = fragment_unnamed_778 * fragment_unnamed_310;
				precise float fragment_unnamed_1004 = fragment_unnamed_776 * fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_1005 = fragment_unnamed_777 * fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_1006 = fragment_unnamed_778 * fragment_uniform_buffer_0[3u].z;
				precise float fragment_unnamed_1007 = fragment_unnamed_995 * fragment_unnamed_1004;
				precise float fragment_unnamed_1008 = fragment_unnamed_995 * fragment_unnamed_1005;
				precise float fragment_unnamed_1009 = fragment_unnamed_995 * fragment_unnamed_1006;
				fragment_output_0.x = mad(fragment_unnamed_600, fragment_unnamed_305, mad(fragment_unnamed_308, max(mad(exp2(fragment_unnamed_948), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f), mad(fragment_unnamed_996, fragment_unnamed_986, fragment_unnamed_1007)));
				fragment_output_0.y = mad(fragment_unnamed_601, fragment_unnamed_305, mad(fragment_unnamed_309, max(mad(exp2(fragment_unnamed_950), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f), mad(fragment_unnamed_997, fragment_unnamed_986, fragment_unnamed_1008)));
				fragment_output_0.z = mad(fragment_unnamed_602, fragment_unnamed_305, mad(fragment_unnamed_310, max(mad(exp2(fragment_unnamed_951), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f), mad(fragment_unnamed_998, fragment_unnamed_986, fragment_unnamed_1009)));
				fragment_output_0.w = fragment_unnamed_305;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[3] = float4(_SpecColor[0], _SpecColor[1], _SpecColor[2], _SpecColor[3]);

				fragment_uniform_buffer_0[4] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _FaceUVSpeedY, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[5] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], _OutlineSoftness, fragment_uniform_buffer_0[6][2], fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], fragment_uniform_buffer_0[6][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], fragment_uniform_buffer_0[6][1], fragment_uniform_buffer_0[6][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[7] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[8] = float4(_OutlineWidth, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _Bevel, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], fragment_uniform_buffer_0[8][1], _BevelOffset, fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], _BevelWidth);

				fragment_uniform_buffer_0[9] = float4(_BevelClamp, fragment_uniform_buffer_0[9][1], fragment_uniform_buffer_0[9][2], fragment_uniform_buffer_0[9][3]);

				fragment_uniform_buffer_0[9] = float4(fragment_uniform_buffer_0[9][0], _BevelRoundness, fragment_uniform_buffer_0[9][2], fragment_uniform_buffer_0[9][3]);

				fragment_uniform_buffer_0[9] = float4(fragment_uniform_buffer_0[9][0], fragment_uniform_buffer_0[9][1], _BumpOutline, fragment_uniform_buffer_0[9][3]);

				fragment_uniform_buffer_0[9] = float4(fragment_uniform_buffer_0[9][0], fragment_uniform_buffer_0[9][1], fragment_uniform_buffer_0[9][2], _BumpFace);

				fragment_uniform_buffer_0[10] = float4(_ReflectFaceColor[0], _ReflectFaceColor[1], _ReflectFaceColor[2], _ReflectFaceColor[3]);

				fragment_uniform_buffer_0[11] = float4(_ReflectOutlineColor[0], _ReflectOutlineColor[1], _ReflectOutlineColor[2], _ReflectOutlineColor[3]);

				fragment_uniform_buffer_0[24] = float4(_ShaderFlags, fragment_uniform_buffer_0[24][1], fragment_uniform_buffer_0[24][2], fragment_uniform_buffer_0[24][3]);

				fragment_uniform_buffer_0[24] = float4(fragment_uniform_buffer_0[24][0], fragment_uniform_buffer_0[24][1], fragment_uniform_buffer_0[24][2], _ScaleRatioA);

				fragment_uniform_buffer_0[29] = float4(fragment_uniform_buffer_0[29][0], fragment_uniform_buffer_0[29][1], _TextureWidth, fragment_uniform_buffer_0[29][3]);

				fragment_uniform_buffer_0[29] = float4(fragment_uniform_buffer_0[29][0], fragment_uniform_buffer_0[29][1], fragment_uniform_buffer_0[29][2], _TextureHeight);

				fragment_uniform_buffer_0[30] = float4(_GradientScale, fragment_uniform_buffer_0[30][1], fragment_uniform_buffer_0[30][2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(fragment_uniform_buffer_0[31][0], _FaceShininess, fragment_uniform_buffer_0[31][2], fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_0[31] = float4(fragment_uniform_buffer_0[31][0], fragment_uniform_buffer_0[31][1], _OutlineShininess, fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_uniform_buffer_2[39] = float4(unity_SHAr[0], unity_SHAr[1], unity_SHAr[2], unity_SHAr[3]);

				fragment_uniform_buffer_2[40] = float4(unity_SHAg[0], unity_SHAg[1], unity_SHAg[2], unity_SHAg[3]);

				fragment_uniform_buffer_2[41] = float4(unity_SHAb[0], unity_SHAb[1], unity_SHAb[2], unity_SHAb[3]);

				fragment_uniform_buffer_2[46] = float4(unity_OcclusionMaskSelector[0], unity_OcclusionMaskSelector[1], unity_OcclusionMaskSelector[2], unity_OcclusionMaskSelector[3]);

				fragment_uniform_buffer_3[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				fragment_uniform_buffer_3[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				fragment_uniform_buffer_3[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				fragment_uniform_buffer_3[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				fragment_uniform_buffer_4[0] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_4[1] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_4[2] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_4[3] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_4[4] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_4[5] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], fragment_uniform_buffer_4[5][3]);

				fragment_uniform_buffer_4[6] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], fragment_uniform_buffer_4[6][3]);

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
			Name "FORWARD"
			LOD 300
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha One
			ColorMask RGB
			ZWrite Off
			Cull [_CullMode]
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 76001

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#pragma shader_feature DIRECTIONAL
			#pragma shader_feature DIRECTIONAL_COOKIE
			#pragma shader_feature POINT
			#pragma shader_feature POINT_COOKIE
			#pragma shader_feature SPOT


			#if defined(POINT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToLight;
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
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[39];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[10];
			static float4 vertex_uniform_buffer_3[21];
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
			static float3 vertex_output_3;
			static float3 vertex_output_4;
			static float3 vertex_output_5;
			static float3 vertex_output_6;
			static float4 vertex_output_7;
			static float3 vertex_output_8;
			static float3 vertex_output_9;

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
				float2 vertex_output_2 : TEXCOORD6; // TEXCOORD_6
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float3 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float3 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float3 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_7 : COLOR; // COLOR
				float3 vertex_output_8 : TEXCOORD7; // TEXCOORD_7
				float3 vertex_output_9 : TEXCOORD8; // TEXCOORD_8
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_67 = vertex_input_0.x + vertex_uniform_buffer_0[29u].z;
				precise float vertex_unnamed_68 = vertex_input_0.y + vertex_uniform_buffer_0[29u].w;
				precise float vertex_unnamed_75 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_76 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_77 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_78 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_99 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_67, vertex_unnamed_75));
				float vertex_unnamed_100 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_67, vertex_unnamed_76));
				float vertex_unnamed_101 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_67, vertex_unnamed_77));
				float vertex_unnamed_102 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_67, vertex_unnamed_78));
				precise float vertex_unnamed_110 = vertex_unnamed_99 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_111 = vertex_unnamed_100 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_112 = vertex_unnamed_101 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_113 = vertex_unnamed_102 + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_121 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_122 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_123 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_124 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_110, vertex_unnamed_121)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_110, vertex_unnamed_122)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_110, vertex_unnamed_123)));
				gl_Position.w = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_110, vertex_unnamed_124)));
				precise float vertex_unnamed_165 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_167 = floor(vertex_unnamed_165);
				precise float vertex_unnamed_168 = (-0.0f) - vertex_unnamed_167;
				precise float vertex_unnamed_174 = vertex_unnamed_167 * 0.001953125f;
				precise float vertex_unnamed_176 = mad(vertex_unnamed_168, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_1.z = mad(vertex_unnamed_174, vertex_uniform_buffer_0[37u].x, vertex_uniform_buffer_0[37u].z);
				vertex_output_1.w = mad(vertex_unnamed_176, vertex_uniform_buffer_0[37u].y, vertex_uniform_buffer_0[37u].w);
				vertex_output_2.x = mad(vertex_unnamed_174, vertex_uniform_buffer_0[38u].x, vertex_uniform_buffer_0[38u].z);
				vertex_output_2.y = mad(vertex_unnamed_176, vertex_uniform_buffer_0[38u].y, vertex_uniform_buffer_0[38u].w);
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[36u].x, vertex_uniform_buffer_0[36u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[36u].y, vertex_uniform_buffer_0[36u].w);
				precise float vertex_unnamed_223 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_235 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_110, vertex_unnamed_223)));
				precise float vertex_unnamed_244 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_245 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_261 = mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_244) * vertex_uniform_buffer_0[34u].y;
				precise float vertex_unnamed_262 = mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_245) * vertex_uniform_buffer_0[34u].z;
				precise float vertex_unnamed_263 = vertex_unnamed_235 / vertex_unnamed_261;
				precise float vertex_unnamed_264 = vertex_unnamed_235 / vertex_unnamed_262;
				float vertex_unnamed_268 = rsqrt(dot(float2(vertex_unnamed_263, vertex_unnamed_264), float2(vertex_unnamed_263, vertex_unnamed_264)));
				precise float vertex_unnamed_275 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[34u].x;
				precise float vertex_unnamed_280 = vertex_uniform_buffer_0[35u].x + 1.0f;
				precise float vertex_unnamed_282 = vertex_unnamed_280 * vertex_unnamed_275;
				precise float vertex_unnamed_283 = vertex_unnamed_268 * vertex_unnamed_282;
				precise float vertex_unnamed_287 = (-0.0f) - vertex_uniform_buffer_0[34u].w;
				precise float vertex_unnamed_288 = vertex_unnamed_287 + 1.0f;
				precise float vertex_unnamed_289 = vertex_unnamed_288 * vertex_unnamed_283;
				precise float vertex_unnamed_290 = (-0.0f) - vertex_unnamed_289;
				precise float vertex_unnamed_301 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].x;
				precise float vertex_unnamed_302 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].y;
				precise float vertex_unnamed_303 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].z;
				precise float vertex_unnamed_331 = mad(vertex_uniform_buffer_2[6u].x, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].x, vertex_uniform_buffer_1[4u].x, vertex_unnamed_301)) + vertex_uniform_buffer_2[7u].x;
				precise float vertex_unnamed_332 = mad(vertex_uniform_buffer_2[6u].y, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].y, vertex_uniform_buffer_1[4u].x, vertex_unnamed_302)) + vertex_uniform_buffer_2[7u].y;
				precise float vertex_unnamed_333 = mad(vertex_uniform_buffer_2[6u].z, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].z, vertex_uniform_buffer_1[4u].x, vertex_unnamed_303)) + vertex_uniform_buffer_2[7u].z;
				precise float vertex_unnamed_336 = (-0.0f) - vertex_unnamed_67;
				precise float vertex_unnamed_337 = (-0.0f) - vertex_unnamed_68;
				precise float vertex_unnamed_338 = (-0.0f) - vertex_input_0.z;
				precise float vertex_unnamed_339 = vertex_unnamed_336 + vertex_unnamed_331;
				precise float vertex_unnamed_340 = vertex_unnamed_337 + vertex_unnamed_332;
				precise float vertex_unnamed_341 = vertex_unnamed_338 + vertex_unnamed_333;
				float vertex_unnamed_348 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_unnamed_339, vertex_unnamed_340, vertex_unnamed_341));
				float vertex_unnamed_360 = float(int((-((0.0f < vertex_unnamed_348) ? 4294967295u : 0u)) + ((vertex_unnamed_348 < 0.0f) ? 4294967295u : 0u)));
				precise float vertex_unnamed_367 = vertex_unnamed_360 * vertex_input_2.x;
				precise float vertex_unnamed_368 = vertex_unnamed_360 * vertex_input_2.y;
				precise float vertex_unnamed_369 = vertex_unnamed_360 * vertex_input_2.z;
				float vertex_unnamed_375 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_383 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_391 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_397 = rsqrt(dot(float3(vertex_unnamed_391, vertex_unnamed_375, vertex_unnamed_383), float3(vertex_unnamed_391, vertex_unnamed_375, vertex_unnamed_383)));
				precise float vertex_unnamed_398 = vertex_unnamed_397 * vertex_unnamed_391;
				precise float vertex_unnamed_399 = vertex_unnamed_397 * vertex_unnamed_375;
				precise float vertex_unnamed_400 = vertex_unnamed_397 * vertex_unnamed_383;
				float vertex_unnamed_408 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_99);
				float vertex_unnamed_409 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_100);
				float vertex_unnamed_410 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_101);
				float vertex_unnamed_419 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_99);
				float vertex_unnamed_420 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_100);
				float vertex_unnamed_421 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_101);
				float vertex_unnamed_422 = mad(vertex_uniform_buffer_2[3u].w, vertex_input_0.w, vertex_unnamed_102);
				precise float vertex_unnamed_423 = (-0.0f) - vertex_unnamed_408;
				precise float vertex_unnamed_424 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_425 = (-0.0f) - vertex_unnamed_410;
				precise float vertex_unnamed_431 = vertex_unnamed_423 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_432 = vertex_unnamed_424 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_433 = vertex_unnamed_425 + vertex_uniform_buffer_1[4u].z;
				vertex_output_6.x = vertex_unnamed_408;
				vertex_output_6.y = vertex_unnamed_409;
				vertex_output_6.z = vertex_unnamed_410;
				float vertex_unnamed_440 = rsqrt(dot(float3(vertex_unnamed_431, vertex_unnamed_432, vertex_unnamed_433), float3(vertex_unnamed_431, vertex_unnamed_432, vertex_unnamed_433)));
				precise float vertex_unnamed_441 = vertex_unnamed_440 * vertex_unnamed_431;
				precise float vertex_unnamed_442 = vertex_unnamed_440 * vertex_unnamed_432;
				precise float vertex_unnamed_443 = vertex_unnamed_440 * vertex_unnamed_433;
				vertex_output_2.y = mad(abs(dot(float3(vertex_unnamed_399, vertex_unnamed_400, vertex_unnamed_398), float3(vertex_unnamed_441, vertex_unnamed_442, vertex_unnamed_443))), mad(vertex_unnamed_268, vertex_unnamed_282, vertex_unnamed_290), vertex_unnamed_289);
				precise float vertex_unnamed_461 = (-0.0f) - vertex_uniform_buffer_0[28u].y;
				precise float vertex_unnamed_465 = vertex_unnamed_461 + vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_478 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_465, vertex_uniform_buffer_0[28u].y), 0.25f, vertex_uniform_buffer_0[10u].x) * vertex_uniform_buffer_0[28u].w;
				precise float vertex_unnamed_479 = vertex_unnamed_478 * 0.5f;
				vertex_output_2.x = vertex_unnamed_479;
				vertex_output_3.z = vertex_unnamed_399;
				precise float vertex_unnamed_490 = vertex_input_1.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_491 = vertex_input_1.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_492 = vertex_input_1.y * vertex_uniform_buffer_2[1u].x;
				float vertex_unnamed_510 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_1.x, vertex_unnamed_490));
				float vertex_unnamed_511 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_1.x, vertex_unnamed_491));
				float vertex_unnamed_512 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_1.x, vertex_unnamed_492));
				float vertex_unnamed_516 = rsqrt(dot(float3(vertex_unnamed_510, vertex_unnamed_511, vertex_unnamed_512), float3(vertex_unnamed_510, vertex_unnamed_511, vertex_unnamed_512)));
				precise float vertex_unnamed_517 = vertex_unnamed_516 * vertex_unnamed_510;
				precise float vertex_unnamed_518 = vertex_unnamed_516 * vertex_unnamed_511;
				precise float vertex_unnamed_519 = vertex_unnamed_516 * vertex_unnamed_512;
				precise float vertex_unnamed_520 = vertex_unnamed_398 * vertex_unnamed_517;
				precise float vertex_unnamed_521 = vertex_unnamed_399 * vertex_unnamed_518;
				precise float vertex_unnamed_522 = vertex_unnamed_400 * vertex_unnamed_519;
				precise float vertex_unnamed_523 = (-0.0f) - vertex_unnamed_520;
				precise float vertex_unnamed_524 = (-0.0f) - vertex_unnamed_521;
				precise float vertex_unnamed_525 = (-0.0f) - vertex_unnamed_522;
				precise float vertex_unnamed_535 = vertex_input_1.w * vertex_uniform_buffer_2[9u].w;
				precise float vertex_unnamed_536 = vertex_unnamed_535 * mad(vertex_unnamed_400, vertex_unnamed_518, vertex_unnamed_523);
				precise float vertex_unnamed_537 = vertex_unnamed_535 * mad(vertex_unnamed_398, vertex_unnamed_519, vertex_unnamed_524);
				precise float vertex_unnamed_538 = vertex_unnamed_535 * mad(vertex_unnamed_399, vertex_unnamed_517, vertex_unnamed_525);
				vertex_output_3.y = vertex_unnamed_536;
				vertex_output_3.x = vertex_unnamed_519;
				vertex_output_4.z = vertex_unnamed_400;
				vertex_output_5.z = vertex_unnamed_398;
				vertex_output_4.x = vertex_unnamed_517;
				vertex_output_5.x = vertex_unnamed_518;
				vertex_output_4.y = vertex_unnamed_537;
				vertex_output_5.y = vertex_unnamed_538;
				vertex_output_7.x = vertex_input_7.x;
				vertex_output_7.y = vertex_input_7.y;
				vertex_output_7.z = vertex_input_7.z;
				vertex_output_7.w = vertex_input_7.w;
				precise float vertex_unnamed_564 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].x;
				precise float vertex_unnamed_565 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].y;
				precise float vertex_unnamed_566 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].z;
				vertex_output_8.x = mad(vertex_uniform_buffer_0[19u].x, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].x, vertex_unnamed_431, vertex_unnamed_564));
				vertex_output_8.y = mad(vertex_uniform_buffer_0[19u].y, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].y, vertex_unnamed_431, vertex_unnamed_565));
				vertex_output_8.z = mad(vertex_uniform_buffer_0[19u].z, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].z, vertex_unnamed_431, vertex_unnamed_566));
				precise float vertex_unnamed_591 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_592 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].y;
				precise float vertex_unnamed_593 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].z;
				vertex_output_9.x = mad(vertex_uniform_buffer_0[7u].x, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].x, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].x, vertex_unnamed_419, vertex_unnamed_591)));
				vertex_output_9.y = mad(vertex_uniform_buffer_0[7u].y, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].y, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].y, vertex_unnamed_419, vertex_unnamed_592)));
				vertex_output_9.z = mad(vertex_uniform_buffer_0[7u].z, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].z, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].z, vertex_unnamed_419, vertex_unnamed_593)));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				vertex_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				vertex_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				vertex_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				vertex_uniform_buffer_0[10] = float4(_FaceDilate, vertex_uniform_buffer_0[10][1], vertex_uniform_buffer_0[10][2], vertex_uniform_buffer_0[10][3]);

				vertex_uniform_buffer_0[17] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				vertex_uniform_buffer_0[18] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				vertex_uniform_buffer_0[19] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				vertex_uniform_buffer_0[20] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], _WeightNormal, vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], _WeightBold, vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], _ScaleRatioA);

				vertex_uniform_buffer_0[29] = float4(vertex_uniform_buffer_0[29][0], vertex_uniform_buffer_0[29][1], _VertexOffsetX, vertex_uniform_buffer_0[29][3]);

				vertex_uniform_buffer_0[29] = float4(vertex_uniform_buffer_0[29][0], vertex_uniform_buffer_0[29][1], vertex_uniform_buffer_0[29][2], _VertexOffsetY);

				vertex_uniform_buffer_0[34] = float4(_GradientScale, vertex_uniform_buffer_0[34][1], vertex_uniform_buffer_0[34][2], vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], _ScaleX, vertex_uniform_buffer_0[34][2], vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], vertex_uniform_buffer_0[34][1], _ScaleY, vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], vertex_uniform_buffer_0[34][1], vertex_uniform_buffer_0[34][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[35] = float4(_Sharpness, vertex_uniform_buffer_0[35][1], vertex_uniform_buffer_0[35][2], vertex_uniform_buffer_0[35][3]);

				vertex_uniform_buffer_0[36] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_0[37] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[38] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

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

				vertex_uniform_buffer_2[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

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
				stage_output.vertex_output_9 = vertex_output_9;
				return stage_output;
			}


			float4 _LightColor0;
			float4 _SpecColor;
			float4x4 unity_WorldToLight;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;
			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_OcclusionMaskSelector;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[36];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			Texture2D<float4> _BumpMap;
			Texture2D<float4> _LightTexture0;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_LightTexture0;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_BumpMap;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_input_7;
			static float3 fragment_input_8;
			static float3 fragment_input_9;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float2 fragment_input_2 : TEXCOORD6; // TEXCOORD_6
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float3 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
				float3 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
				float3 fragment_input_6 : TEXCOORD5; // TEXCOORD_5
				float4 fragment_input_7 : COLOR; // COLOR
				float3 fragment_input_8 : TEXCOORD7; // TEXCOORD_7
				float3 fragment_input_9 : TEXCOORD8; // TEXCOORD_8
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_80 = (-0.0f) - fragment_input_6.x;
				precise float fragment_unnamed_85 = (-0.0f) - fragment_input_6.y;
				precise float fragment_unnamed_89 = (-0.0f) - fragment_input_6.z;
				precise float fragment_unnamed_96 = fragment_unnamed_80 + fragment_uniform_buffer_2[0u].x;
				precise float fragment_unnamed_97 = fragment_unnamed_85 + fragment_uniform_buffer_2[0u].y;
				precise float fragment_unnamed_98 = fragment_unnamed_89 + fragment_uniform_buffer_2[0u].z;
				float fragment_unnamed_103 = rsqrt(dot(float3(fragment_unnamed_96, fragment_unnamed_97, fragment_unnamed_98), float3(fragment_unnamed_96, fragment_unnamed_97, fragment_unnamed_98)));
				precise float fragment_unnamed_104 = fragment_unnamed_103 * fragment_unnamed_96;
				precise float fragment_unnamed_105 = fragment_unnamed_103 * fragment_unnamed_97;
				precise float fragment_unnamed_106 = fragment_unnamed_103 * fragment_unnamed_98;
				precise float fragment_unnamed_109 = (-0.0f) - fragment_input_6.x;
				precise float fragment_unnamed_112 = (-0.0f) - fragment_input_6.y;
				precise float fragment_unnamed_115 = (-0.0f) - fragment_input_6.z;
				precise float fragment_unnamed_122 = fragment_unnamed_109 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_123 = fragment_unnamed_112 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_124 = fragment_unnamed_115 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_128 = rsqrt(dot(float3(fragment_unnamed_122, fragment_unnamed_123, fragment_unnamed_124), float3(fragment_unnamed_122, fragment_unnamed_123, fragment_unnamed_124)));
				precise float fragment_unnamed_134 = 1.0f / fragment_uniform_buffer_0[33u].z;
				precise float fragment_unnamed_136 = 1.0f / fragment_uniform_buffer_0[33u].w;
				float fragment_unnamed_137 = asfloat(0u);
				precise float fragment_unnamed_138 = (-0.0f) - fragment_unnamed_134;
				precise float fragment_unnamed_139 = (-0.0f) - fragment_unnamed_137;
				precise float fragment_unnamed_140 = (-0.0f) - fragment_unnamed_136;
				precise float fragment_unnamed_145 = fragment_unnamed_138 + fragment_input_1.x;
				precise float fragment_unnamed_146 = fragment_unnamed_139 + fragment_input_1.y;
				precise float fragment_unnamed_147 = fragment_unnamed_139 + fragment_input_1.x;
				precise float fragment_unnamed_148 = fragment_unnamed_140 + fragment_input_1.y;
				precise float fragment_unnamed_159 = fragment_unnamed_134 + fragment_input_1.x;
				precise float fragment_unnamed_160 = fragment_unnamed_137 + fragment_input_1.y;
				precise float fragment_unnamed_161 = fragment_unnamed_137 + fragment_input_1.x;
				precise float fragment_unnamed_162 = fragment_unnamed_136 + fragment_input_1.y;
				precise float fragment_unnamed_179 = (-0.0f) - _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
				precise float fragment_unnamed_180 = fragment_unnamed_179 + 0.5f;
				precise float fragment_unnamed_184 = (-0.0f) - fragment_input_2.x;
				precise float fragment_unnamed_185 = fragment_unnamed_180 + fragment_unnamed_184;
				float fragment_unnamed_188 = mad(fragment_unnamed_185, fragment_input_2.y, 0.5f);
				precise float fragment_unnamed_197 = fragment_uniform_buffer_0[12u].x * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_205 = fragment_uniform_buffer_0[10u].y * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_208 = fragment_unnamed_197 * fragment_input_2.y;
				precise float fragment_unnamed_209 = fragment_unnamed_205 * fragment_input_2.y;
				precise float fragment_unnamed_226 = fragment_input_7.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_227 = fragment_input_7.y * fragment_uniform_buffer_0[9u].y;
				precise float fragment_unnamed_228 = fragment_input_7.z * fragment_uniform_buffer_0[9u].z;
				precise float fragment_unnamed_229 = fragment_input_7.w * fragment_uniform_buffer_0[9u].w;
				precise float fragment_unnamed_236 = fragment_input_7.w * fragment_uniform_buffer_0[11u].w;
				float4 fragment_unnamed_252 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[8u].x, fragment_uniform_buffer_1[0u].y, fragment_input_1.z), mad(fragment_uniform_buffer_0[8u].y, fragment_uniform_buffer_1[0u].y, fragment_input_1.w)));
				precise float fragment_unnamed_258 = fragment_unnamed_226 * fragment_unnamed_252.x;
				precise float fragment_unnamed_259 = fragment_unnamed_227 * fragment_unnamed_252.y;
				precise float fragment_unnamed_260 = fragment_unnamed_228 * fragment_unnamed_252.z;
				precise float fragment_unnamed_261 = fragment_unnamed_229 * fragment_unnamed_252.w;
				float4 fragment_unnamed_276 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[10u].z, fragment_uniform_buffer_1[0u].y, fragment_input_2.x), mad(fragment_uniform_buffer_0[10u].w, fragment_uniform_buffer_1[0u].y, fragment_input_2.y)));
				precise float fragment_unnamed_287 = fragment_unnamed_276.x * fragment_uniform_buffer_0[11u].x;
				precise float fragment_unnamed_288 = fragment_unnamed_276.y * fragment_uniform_buffer_0[11u].y;
				precise float fragment_unnamed_289 = fragment_unnamed_276.z * fragment_uniform_buffer_0[11u].z;
				precise float fragment_unnamed_290 = fragment_unnamed_236 * fragment_unnamed_276.w;
				precise float fragment_unnamed_291 = (-0.0f) - fragment_unnamed_208;
				precise float fragment_unnamed_297 = mad(fragment_unnamed_209, 0.5f, mad(fragment_unnamed_291, 0.5f, fragment_unnamed_188)) / mad(fragment_unnamed_205, fragment_input_2.y, 1.0f);
				precise float fragment_unnamed_299 = (-0.0f) - clamp(fragment_unnamed_297, 0.0f, 1.0f);
				precise float fragment_unnamed_300 = fragment_unnamed_299 + 1.0f;
				float fragment_unnamed_302 = clamp(mad(fragment_unnamed_208, 0.5f, fragment_unnamed_188), 0.0f, 1.0f);
				precise float fragment_unnamed_305 = fragment_unnamed_302 * sqrt(min(fragment_unnamed_208, 1.0f));
				precise float fragment_unnamed_306 = fragment_unnamed_261 * fragment_unnamed_258;
				precise float fragment_unnamed_307 = fragment_unnamed_261 * fragment_unnamed_259;
				precise float fragment_unnamed_308 = fragment_unnamed_261 * fragment_unnamed_260;
				precise float fragment_unnamed_309 = fragment_unnamed_287 * fragment_unnamed_290;
				precise float fragment_unnamed_310 = fragment_unnamed_288 * fragment_unnamed_290;
				precise float fragment_unnamed_311 = fragment_unnamed_289 * fragment_unnamed_290;
				precise float fragment_unnamed_312 = (-0.0f) - fragment_unnamed_306;
				precise float fragment_unnamed_313 = (-0.0f) - fragment_unnamed_307;
				precise float fragment_unnamed_314 = (-0.0f) - fragment_unnamed_308;
				precise float fragment_unnamed_315 = (-0.0f) - fragment_unnamed_261;
				precise float fragment_unnamed_316 = fragment_unnamed_312 + fragment_unnamed_309;
				precise float fragment_unnamed_317 = fragment_unnamed_313 + fragment_unnamed_310;
				precise float fragment_unnamed_318 = fragment_unnamed_314 + fragment_unnamed_311;
				precise float fragment_unnamed_319 = fragment_unnamed_315 + fragment_unnamed_290;
				precise float fragment_unnamed_324 = fragment_unnamed_300 * mad(fragment_unnamed_305, fragment_unnamed_316, fragment_unnamed_306);
				precise float fragment_unnamed_325 = fragment_unnamed_300 * mad(fragment_unnamed_305, fragment_unnamed_317, fragment_unnamed_307);
				precise float fragment_unnamed_326 = fragment_unnamed_300 * mad(fragment_unnamed_305, fragment_unnamed_318, fragment_unnamed_308);
				precise float fragment_unnamed_327 = fragment_unnamed_300 * mad(fragment_unnamed_305, fragment_unnamed_319, fragment_unnamed_261);
				float fragment_unnamed_328 = max(fragment_unnamed_327, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_330 = fragment_unnamed_324 / fragment_unnamed_328;
				precise float fragment_unnamed_331 = fragment_unnamed_325 / fragment_unnamed_328;
				precise float fragment_unnamed_332 = fragment_unnamed_326 / fragment_unnamed_328;
				precise float fragment_unnamed_336 = fragment_uniform_buffer_0[28u].x * 0.5f;
				precise float fragment_unnamed_337 = (-0.0f) - fragment_unnamed_336;
				float fragment_unnamed_341 = frac(abs(fragment_unnamed_336));
				precise float fragment_unnamed_342 = (-0.0f) - fragment_unnamed_341;
				bool fragment_unnamed_344 = ((fragment_unnamed_336 >= fragment_unnamed_337) ? fragment_unnamed_341 : fragment_unnamed_342) >= 0.5f;
				precise float fragment_unnamed_350 = fragment_input_2.x + fragment_uniform_buffer_0[12u].z;
				precise float fragment_unnamed_351 = fragment_unnamed_350 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_145, fragment_unnamed_146)).w;
				precise float fragment_unnamed_352 = fragment_unnamed_350 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_159, fragment_unnamed_160)).w;
				precise float fragment_unnamed_353 = fragment_unnamed_350 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_147, fragment_unnamed_148)).w;
				precise float fragment_unnamed_354 = fragment_unnamed_350 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_161, fragment_unnamed_162)).w;
				precise float fragment_unnamed_361 = fragment_uniform_buffer_0[12u].w + fragment_uniform_buffer_0[12u].x;
				float fragment_unnamed_362 = max(fragment_unnamed_361, 0.00999999977648258209228515625f);
				precise float fragment_unnamed_364 = fragment_unnamed_351 + (-0.5f);
				precise float fragment_unnamed_366 = fragment_unnamed_352 + (-0.5f);
				precise float fragment_unnamed_367 = fragment_unnamed_353 + (-0.5f);
				precise float fragment_unnamed_368 = fragment_unnamed_354 + (-0.5f);
				precise float fragment_unnamed_369 = fragment_unnamed_364 / fragment_unnamed_362;
				precise float fragment_unnamed_370 = fragment_unnamed_366 / fragment_unnamed_362;
				precise float fragment_unnamed_371 = fragment_unnamed_367 / fragment_unnamed_362;
				precise float fragment_unnamed_372 = fragment_unnamed_368 / fragment_unnamed_362;
				precise float fragment_unnamed_373 = fragment_unnamed_369 + 0.5f;
				precise float fragment_unnamed_374 = fragment_unnamed_370 + 0.5f;
				precise float fragment_unnamed_375 = fragment_unnamed_371 + 0.5f;
				precise float fragment_unnamed_376 = fragment_unnamed_372 + 0.5f;
				float fragment_unnamed_377 = clamp(fragment_unnamed_373, 0.0f, 1.0f);
				float fragment_unnamed_378 = clamp(fragment_unnamed_374, 0.0f, 1.0f);
				float fragment_unnamed_379 = clamp(fragment_unnamed_375, 0.0f, 1.0f);
				float fragment_unnamed_380 = clamp(fragment_unnamed_376, 0.0f, 1.0f);
				precise float fragment_unnamed_388 = (-0.0f) - abs(mad(fragment_unnamed_377, 2.0f, -1.0f));
				precise float fragment_unnamed_390 = (-0.0f) - abs(mad(fragment_unnamed_378, 2.0f, -1.0f));
				precise float fragment_unnamed_392 = (-0.0f) - abs(mad(fragment_unnamed_379, 2.0f, -1.0f));
				precise float fragment_unnamed_394 = (-0.0f) - abs(mad(fragment_unnamed_380, 2.0f, -1.0f));
				precise float fragment_unnamed_395 = fragment_unnamed_388 + 1.0f;
				precise float fragment_unnamed_396 = fragment_unnamed_390 + 1.0f;
				precise float fragment_unnamed_397 = fragment_unnamed_392 + 1.0f;
				precise float fragment_unnamed_398 = fragment_unnamed_394 + 1.0f;
				float fragment_unnamed_408 = asfloat(fragment_unnamed_344 ? asuint(fragment_unnamed_395) : asuint(fragment_unnamed_377));
				float fragment_unnamed_410 = asfloat(fragment_unnamed_344 ? asuint(fragment_unnamed_396) : asuint(fragment_unnamed_378));
				float fragment_unnamed_412 = asfloat(fragment_unnamed_344 ? asuint(fragment_unnamed_397) : asuint(fragment_unnamed_379));
				float fragment_unnamed_414 = asfloat(fragment_unnamed_344 ? asuint(fragment_unnamed_398) : asuint(fragment_unnamed_380));
				precise float fragment_unnamed_415 = fragment_unnamed_408 * 1.57079601287841796875f;
				precise float fragment_unnamed_417 = fragment_unnamed_410 * 1.57079601287841796875f;
				precise float fragment_unnamed_418 = fragment_unnamed_412 * 1.57079601287841796875f;
				precise float fragment_unnamed_419 = fragment_unnamed_414 * 1.57079601287841796875f;
				precise float fragment_unnamed_424 = (-0.0f) - fragment_unnamed_408;
				precise float fragment_unnamed_425 = (-0.0f) - fragment_unnamed_410;
				precise float fragment_unnamed_426 = (-0.0f) - fragment_unnamed_412;
				precise float fragment_unnamed_427 = (-0.0f) - fragment_unnamed_414;
				precise float fragment_unnamed_428 = fragment_unnamed_424 + sin(fragment_unnamed_415);
				precise float fragment_unnamed_429 = fragment_unnamed_425 + sin(fragment_unnamed_417);
				precise float fragment_unnamed_430 = fragment_unnamed_426 + sin(fragment_unnamed_418);
				precise float fragment_unnamed_431 = fragment_unnamed_427 + sin(fragment_unnamed_419);
				precise float fragment_unnamed_443 = (-0.0f) - fragment_uniform_buffer_0[13u].x;
				precise float fragment_unnamed_444 = fragment_unnamed_443 + 1.0f;
				precise float fragment_unnamed_452 = fragment_unnamed_362 * fragment_uniform_buffer_0[12u].y;
				precise float fragment_unnamed_457 = fragment_unnamed_452 * fragment_uniform_buffer_0[34u].x;
				precise float fragment_unnamed_458 = fragment_unnamed_457 * (-2.0f);
				precise float fragment_unnamed_460 = min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_428, fragment_unnamed_408), fragment_unnamed_444) * fragment_unnamed_458;
				precise float fragment_unnamed_461 = min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_430, fragment_unnamed_412), fragment_unnamed_444) * fragment_unnamed_458;
				precise float fragment_unnamed_462 = (-0.0f) - fragment_unnamed_461;
				precise float fragment_unnamed_463 = (-0.0f) - fragment_unnamed_460;
				float fragment_unnamed_464 = mad(min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_431, fragment_unnamed_414), fragment_unnamed_444), fragment_unnamed_458, fragment_unnamed_462);
				float fragment_unnamed_465 = mad(min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_429, fragment_unnamed_410), fragment_unnamed_444), fragment_unnamed_458, fragment_unnamed_463);
				float fragment_unnamed_466 = asfloat(3212836864u);
				float fragment_unnamed_468 = asfloat(1065353216u);
				float fragment_unnamed_473 = rsqrt(dot(float2(fragment_unnamed_465, fragment_unnamed_468), float2(fragment_unnamed_465, fragment_unnamed_468)));
				precise float fragment_unnamed_474 = fragment_unnamed_473 * 1.0f;
				precise float fragment_unnamed_475 = fragment_unnamed_473 * 0.0f;
				precise float fragment_unnamed_476 = fragment_unnamed_473 * fragment_unnamed_465;
				float fragment_unnamed_480 = rsqrt(dot(float2(fragment_unnamed_466, fragment_unnamed_464), float2(fragment_unnamed_466, fragment_unnamed_464)));
				precise float fragment_unnamed_482 = fragment_unnamed_480 * fragment_unnamed_466;
				precise float fragment_unnamed_483 = fragment_unnamed_480 * fragment_unnamed_464;
				precise float fragment_unnamed_484 = fragment_unnamed_480 * asfloat(0u);
				precise float fragment_unnamed_485 = fragment_unnamed_482 * fragment_unnamed_476;
				precise float fragment_unnamed_486 = fragment_unnamed_483 * fragment_unnamed_474;
				precise float fragment_unnamed_487 = fragment_unnamed_484 * fragment_unnamed_475;
				precise float fragment_unnamed_488 = (-0.0f) - fragment_unnamed_485;
				precise float fragment_unnamed_489 = (-0.0f) - fragment_unnamed_486;
				precise float fragment_unnamed_490 = (-0.0f) - fragment_unnamed_487;
				float4 fragment_unnamed_499 = _BumpMap.Sample(sampler_BumpMap, float2(fragment_input_1.z, fragment_input_1.w));
				precise float fragment_unnamed_504 = fragment_unnamed_499.w * fragment_unnamed_499.x;
				float fragment_unnamed_505 = mad(fragment_unnamed_504, 2.0f, -1.0f);
				float fragment_unnamed_506 = mad(fragment_unnamed_499.y, 2.0f, -1.0f);
				precise float fragment_unnamed_511 = (-0.0f) - min(dot(float2(fragment_unnamed_505, fragment_unnamed_506), float2(fragment_unnamed_505, fragment_unnamed_506)), 1.0f);
				precise float fragment_unnamed_512 = fragment_unnamed_511 + 1.0f;
				precise float fragment_unnamed_517 = (-0.0f) - fragment_uniform_buffer_0[13u].w;
				precise float fragment_unnamed_521 = fragment_unnamed_517 + fragment_uniform_buffer_0[13u].z;
				float fragment_unnamed_525 = mad(fragment_unnamed_302, fragment_unnamed_521, fragment_uniform_buffer_0[13u].w);
				precise float fragment_unnamed_532 = (-0.0f) - mad(fragment_unnamed_327, mad(fragment_unnamed_505, fragment_unnamed_525, -0.0f), 0.0f);
				precise float fragment_unnamed_533 = (-0.0f) - mad(fragment_unnamed_327, mad(fragment_unnamed_506, fragment_unnamed_525, -0.0f), 0.0f);
				precise float fragment_unnamed_534 = (-0.0f) - mad(fragment_unnamed_327, mad(sqrt(fragment_unnamed_512), fragment_unnamed_525, -1.0f), 1.0f);
				precise float fragment_unnamed_535 = mad(fragment_unnamed_475, fragment_unnamed_483, fragment_unnamed_488) + fragment_unnamed_532;
				precise float fragment_unnamed_536 = mad(fragment_unnamed_476, fragment_unnamed_484, fragment_unnamed_489) + fragment_unnamed_533;
				precise float fragment_unnamed_537 = mad(fragment_unnamed_474, fragment_unnamed_482, fragment_unnamed_490) + fragment_unnamed_534;
				float fragment_unnamed_541 = rsqrt(dot(float3(fragment_unnamed_535, fragment_unnamed_536, fragment_unnamed_537), float3(fragment_unnamed_535, fragment_unnamed_536, fragment_unnamed_537)));
				precise float fragment_unnamed_542 = fragment_unnamed_541 * fragment_unnamed_535;
				precise float fragment_unnamed_543 = fragment_unnamed_541 * fragment_unnamed_536;
				precise float fragment_unnamed_544 = fragment_unnamed_541 * fragment_unnamed_537;
				precise float fragment_unnamed_549 = (-0.0f) - fragment_uniform_buffer_0[35u].y;
				precise float fragment_unnamed_553 = fragment_unnamed_549 + fragment_uniform_buffer_0[35u].z;
				precise float fragment_unnamed_565 = fragment_input_6.y * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_566 = fragment_input_6.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_567 = fragment_input_6.y * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_594 = mad(fragment_uniform_buffer_0[6u].x, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].x, fragment_input_6.x, fragment_unnamed_565)) + fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_595 = mad(fragment_uniform_buffer_0[6u].y, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].y, fragment_input_6.x, fragment_unnamed_566)) + fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_596 = mad(fragment_uniform_buffer_0[6u].z, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].z, fragment_input_6.x, fragment_unnamed_567)) + fragment_uniform_buffer_0[7u].z;
				float fragment_unnamed_691;
				float fragment_unnamed_692;
				float fragment_unnamed_693;
				float fragment_unnamed_694;
				if (fragment_uniform_buffer_3[0u].x == 1.0f)
				{
					bool fragment_unnamed_604 = fragment_uniform_buffer_3[0u].y == 1.0f;
					precise float fragment_unnamed_612 = fragment_input_6.y * fragment_uniform_buffer_3[2u].x;
					precise float fragment_unnamed_613 = fragment_input_6.y * fragment_uniform_buffer_3[2u].y;
					precise float fragment_unnamed_614 = fragment_input_6.y * fragment_uniform_buffer_3[2u].z;
					precise float fragment_unnamed_640 = mad(fragment_uniform_buffer_3[3u].x, fragment_input_6.z, mad(fragment_uniform_buffer_3[1u].x, fragment_input_6.x, fragment_unnamed_612)) + fragment_uniform_buffer_3[4u].x;
					precise float fragment_unnamed_641 = mad(fragment_uniform_buffer_3[3u].y, fragment_input_6.z, mad(fragment_uniform_buffer_3[1u].y, fragment_input_6.x, fragment_unnamed_613)) + fragment_uniform_buffer_3[4u].y;
					precise float fragment_unnamed_642 = mad(fragment_uniform_buffer_3[3u].z, fragment_input_6.z, mad(fragment_uniform_buffer_3[1u].z, fragment_input_6.x, fragment_unnamed_614)) + fragment_uniform_buffer_3[4u].z;
					precise float fragment_unnamed_655 = (-0.0f) - fragment_uniform_buffer_3[6u].x;
					precise float fragment_unnamed_657 = (-0.0f) - fragment_uniform_buffer_3[6u].y;
					precise float fragment_unnamed_659 = (-0.0f) - fragment_uniform_buffer_3[6u].z;
					precise float fragment_unnamed_660 = (fragment_unnamed_604 ? fragment_unnamed_640 : fragment_input_6.x) + fragment_unnamed_655;
					precise float fragment_unnamed_661 = (fragment_unnamed_604 ? fragment_unnamed_641 : fragment_input_6.y) + fragment_unnamed_657;
					precise float fragment_unnamed_662 = (fragment_unnamed_604 ? fragment_unnamed_642 : fragment_input_6.z) + fragment_unnamed_659;
					precise float fragment_unnamed_668 = fragment_unnamed_660 * fragment_uniform_buffer_3[5u].x;
					precise float fragment_unnamed_669 = fragment_unnamed_661 * fragment_uniform_buffer_3[5u].y;
					precise float fragment_unnamed_670 = fragment_unnamed_662 * fragment_uniform_buffer_3[5u].z;
					float4 fragment_unnamed_681 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_668, 0.25f, 0.75f), mad(fragment_uniform_buffer_3[0u].z, 0.5f, 0.75f)), fragment_unnamed_669, fragment_unnamed_670));
					fragment_unnamed_691 = fragment_unnamed_681.x;
					fragment_unnamed_692 = fragment_unnamed_681.y;
					fragment_unnamed_693 = fragment_unnamed_681.z;
					fragment_unnamed_694 = fragment_unnamed_681.w;
				}
				else
				{
					fragment_unnamed_691 = asfloat(1065353216u);
					fragment_unnamed_692 = asfloat(1065353216u);
					fragment_unnamed_693 = asfloat(1065353216u);
					fragment_unnamed_694 = asfloat(1065353216u);
				}
				precise float fragment_unnamed_713 = clamp(dot(float4(fragment_unnamed_691, fragment_unnamed_692, fragment_unnamed_693, fragment_unnamed_694), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f) * _LightTexture0.Sample(sampler_LightTexture0, dot(float3(fragment_unnamed_594, fragment_unnamed_595, fragment_unnamed_596), float3(fragment_unnamed_594, fragment_unnamed_595, fragment_unnamed_596)).xx).x;
				precise float fragment_unnamed_720 = (-0.0f) - fragment_unnamed_542;
				precise float fragment_unnamed_721 = (-0.0f) - fragment_unnamed_543;
				precise float fragment_unnamed_722 = (-0.0f) - fragment_unnamed_544;
				float fragment_unnamed_723 = dot(float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z), float3(fragment_unnamed_720, fragment_unnamed_721, fragment_unnamed_722));
				precise float fragment_unnamed_732 = (-0.0f) - fragment_unnamed_542;
				precise float fragment_unnamed_733 = (-0.0f) - fragment_unnamed_543;
				precise float fragment_unnamed_734 = (-0.0f) - fragment_unnamed_544;
				float fragment_unnamed_735 = dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_unnamed_732, fragment_unnamed_733, fragment_unnamed_734));
				precise float fragment_unnamed_744 = (-0.0f) - fragment_unnamed_542;
				precise float fragment_unnamed_745 = (-0.0f) - fragment_unnamed_543;
				precise float fragment_unnamed_746 = (-0.0f) - fragment_unnamed_544;
				float fragment_unnamed_747 = dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_unnamed_744, fragment_unnamed_745, fragment_unnamed_746));
				float fragment_unnamed_753 = rsqrt(dot(float3(fragment_unnamed_723, fragment_unnamed_735, fragment_unnamed_747), float3(fragment_unnamed_723, fragment_unnamed_735, fragment_unnamed_747)));
				precise float fragment_unnamed_754 = fragment_unnamed_753 * fragment_unnamed_723;
				precise float fragment_unnamed_755 = fragment_unnamed_753 * fragment_unnamed_735;
				precise float fragment_unnamed_756 = fragment_unnamed_753 * fragment_unnamed_747;
				precise float fragment_unnamed_762 = fragment_unnamed_713 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_763 = fragment_unnamed_713 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_764 = fragment_unnamed_713 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_765 = mad(fragment_unnamed_122, fragment_unnamed_128, fragment_unnamed_104);
				float fragment_unnamed_766 = mad(fragment_unnamed_123, fragment_unnamed_128, fragment_unnamed_105);
				float fragment_unnamed_767 = mad(fragment_unnamed_124, fragment_unnamed_128, fragment_unnamed_106);
				float fragment_unnamed_771 = rsqrt(dot(float3(fragment_unnamed_765, fragment_unnamed_766, fragment_unnamed_767), float3(fragment_unnamed_765, fragment_unnamed_766, fragment_unnamed_767)));
				precise float fragment_unnamed_772 = fragment_unnamed_771 * fragment_unnamed_765;
				precise float fragment_unnamed_773 = fragment_unnamed_771 * fragment_unnamed_766;
				precise float fragment_unnamed_774 = fragment_unnamed_771 * fragment_unnamed_767;
				float fragment_unnamed_781 = max(dot(float3(fragment_unnamed_754, fragment_unnamed_755, fragment_unnamed_756), float3(fragment_unnamed_104, fragment_unnamed_105, fragment_unnamed_106)), 0.0f);
				precise float fragment_unnamed_783 = mad(fragment_unnamed_302, fragment_unnamed_553, fragment_uniform_buffer_0[35u].y) * 128.0f;
				precise float fragment_unnamed_786 = log2(max(dot(float3(fragment_unnamed_754, fragment_unnamed_755, fragment_unnamed_756), float3(fragment_unnamed_772, fragment_unnamed_773, fragment_unnamed_774)), 0.0f)) * fragment_unnamed_783;
				float fragment_unnamed_787 = exp2(fragment_unnamed_786);
				precise float fragment_unnamed_788 = fragment_unnamed_330 * fragment_unnamed_762;
				precise float fragment_unnamed_789 = fragment_unnamed_331 * fragment_unnamed_763;
				precise float fragment_unnamed_790 = fragment_unnamed_332 * fragment_unnamed_764;
				precise float fragment_unnamed_796 = fragment_unnamed_762 * fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_797 = fragment_unnamed_763 * fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_798 = fragment_unnamed_764 * fragment_uniform_buffer_0[3u].z;
				precise float fragment_unnamed_799 = fragment_unnamed_787 * fragment_unnamed_796;
				precise float fragment_unnamed_800 = fragment_unnamed_787 * fragment_unnamed_797;
				precise float fragment_unnamed_801 = fragment_unnamed_787 * fragment_unnamed_798;
				fragment_output_0.x = mad(fragment_unnamed_788, fragment_unnamed_781, fragment_unnamed_799);
				fragment_output_0.y = mad(fragment_unnamed_789, fragment_unnamed_781, fragment_unnamed_800);
				fragment_output_0.z = mad(fragment_unnamed_790, fragment_unnamed_781, fragment_unnamed_801);
				fragment_output_0.w = fragment_unnamed_327;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[3] = float4(_SpecColor[0], _SpecColor[1], _SpecColor[2], _SpecColor[3]);

				fragment_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				fragment_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				fragment_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				fragment_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_uniform_buffer_0[8] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _FaceUVSpeedY, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[9] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], _OutlineSoftness, fragment_uniform_buffer_0[10][2], fragment_uniform_buffer_0[10][3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], fragment_uniform_buffer_0[10][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[10][3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], fragment_uniform_buffer_0[10][1], fragment_uniform_buffer_0[10][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[11] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[12] = float4(_OutlineWidth, fragment_uniform_buffer_0[12][1], fragment_uniform_buffer_0[12][2], fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], _Bevel, fragment_uniform_buffer_0[12][2], fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], fragment_uniform_buffer_0[12][1], _BevelOffset, fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], fragment_uniform_buffer_0[12][1], fragment_uniform_buffer_0[12][2], _BevelWidth);

				fragment_uniform_buffer_0[13] = float4(_BevelClamp, fragment_uniform_buffer_0[13][1], fragment_uniform_buffer_0[13][2], fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], _BevelRoundness, fragment_uniform_buffer_0[13][2], fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], fragment_uniform_buffer_0[13][1], _BumpOutline, fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], fragment_uniform_buffer_0[13][1], fragment_uniform_buffer_0[13][2], _BumpFace);

				fragment_uniform_buffer_0[28] = float4(_ShaderFlags, fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], fragment_uniform_buffer_0[28][3]);

				fragment_uniform_buffer_0[28] = float4(fragment_uniform_buffer_0[28][0], fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], _ScaleRatioA);

				fragment_uniform_buffer_0[33] = float4(fragment_uniform_buffer_0[33][0], fragment_uniform_buffer_0[33][1], _TextureWidth, fragment_uniform_buffer_0[33][3]);

				fragment_uniform_buffer_0[33] = float4(fragment_uniform_buffer_0[33][0], fragment_uniform_buffer_0[33][1], fragment_uniform_buffer_0[33][2], _TextureHeight);

				fragment_uniform_buffer_0[34] = float4(_GradientScale, fragment_uniform_buffer_0[34][1], fragment_uniform_buffer_0[34][2], fragment_uniform_buffer_0[34][3]);

				fragment_uniform_buffer_0[35] = float4(fragment_uniform_buffer_0[35][0], _FaceShininess, fragment_uniform_buffer_0[35][2], fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_0[35] = float4(fragment_uniform_buffer_0[35][0], fragment_uniform_buffer_0[35][1], _OutlineShininess, fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

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
				fragment_input_9 = stage_input.fragment_input_9;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(POINT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE)


			#if defined(DIRECTIONAL) && !defined(POINT) && !defined(SPOT) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE)
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
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[35];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[10];
			static float4 vertex_uniform_buffer_3[21];
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
			static float3 vertex_output_3;
			static float3 vertex_output_4;
			static float3 vertex_output_5;
			static float3 vertex_output_6;
			static float4 vertex_output_7;
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
				float2 vertex_output_2 : TEXCOORD6; // TEXCOORD_6
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float3 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float3 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float3 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_7 : COLOR; // COLOR
				float3 vertex_output_8 : TEXCOORD7; // TEXCOORD_7
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_66 = vertex_input_0.x + vertex_uniform_buffer_0[25u].z;
				precise float vertex_unnamed_67 = vertex_input_0.y + vertex_uniform_buffer_0[25u].w;
				precise float vertex_unnamed_74 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_75 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_76 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_77 = vertex_unnamed_67 * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_98 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_66, vertex_unnamed_74));
				float vertex_unnamed_99 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_66, vertex_unnamed_75));
				float vertex_unnamed_100 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_66, vertex_unnamed_76));
				precise float vertex_unnamed_109 = vertex_unnamed_98 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_110 = vertex_unnamed_99 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_111 = vertex_unnamed_100 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_112 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_66, vertex_unnamed_77)) + vertex_uniform_buffer_2[3u].w;
				float vertex_unnamed_120 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_98);
				float vertex_unnamed_121 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_99);
				float vertex_unnamed_122 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_100);
				precise float vertex_unnamed_130 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_131 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_132 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_133 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_109, vertex_unnamed_130)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_109, vertex_unnamed_131)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_109, vertex_unnamed_132)));
				gl_Position.w = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_109, vertex_unnamed_133)));
				precise float vertex_unnamed_174 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_176 = floor(vertex_unnamed_174);
				precise float vertex_unnamed_177 = (-0.0f) - vertex_unnamed_176;
				precise float vertex_unnamed_183 = vertex_unnamed_176 * 0.001953125f;
				precise float vertex_unnamed_185 = mad(vertex_unnamed_177, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_1.z = mad(vertex_unnamed_183, vertex_uniform_buffer_0[33u].x, vertex_uniform_buffer_0[33u].z);
				vertex_output_1.w = mad(vertex_unnamed_185, vertex_uniform_buffer_0[33u].y, vertex_uniform_buffer_0[33u].w);
				vertex_output_2.x = mad(vertex_unnamed_183, vertex_uniform_buffer_0[34u].x, vertex_uniform_buffer_0[34u].z);
				vertex_output_2.y = mad(vertex_unnamed_185, vertex_uniform_buffer_0[34u].y, vertex_uniform_buffer_0[34u].w);
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[32u].x, vertex_uniform_buffer_0[32u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[32u].y, vertex_uniform_buffer_0[32u].w);
				precise float vertex_unnamed_232 = vertex_unnamed_110 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_244 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_111, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_109, vertex_unnamed_232)));
				precise float vertex_unnamed_253 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_254 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_270 = mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_253) * vertex_uniform_buffer_0[30u].y;
				precise float vertex_unnamed_271 = mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_254) * vertex_uniform_buffer_0[30u].z;
				precise float vertex_unnamed_272 = vertex_unnamed_244 / vertex_unnamed_270;
				precise float vertex_unnamed_273 = vertex_unnamed_244 / vertex_unnamed_271;
				float vertex_unnamed_277 = rsqrt(dot(float2(vertex_unnamed_272, vertex_unnamed_273), float2(vertex_unnamed_272, vertex_unnamed_273)));
				precise float vertex_unnamed_284 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[30u].x;
				precise float vertex_unnamed_289 = vertex_uniform_buffer_0[31u].x + 1.0f;
				precise float vertex_unnamed_291 = vertex_unnamed_284 * vertex_unnamed_289;
				precise float vertex_unnamed_292 = vertex_unnamed_277 * vertex_unnamed_291;
				precise float vertex_unnamed_296 = (-0.0f) - vertex_uniform_buffer_0[30u].w;
				precise float vertex_unnamed_297 = vertex_unnamed_296 + 1.0f;
				precise float vertex_unnamed_298 = vertex_unnamed_297 * vertex_unnamed_292;
				precise float vertex_unnamed_299 = (-0.0f) - vertex_unnamed_298;
				precise float vertex_unnamed_310 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].x;
				precise float vertex_unnamed_311 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].y;
				precise float vertex_unnamed_312 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].z;
				precise float vertex_unnamed_340 = mad(vertex_uniform_buffer_2[6u].x, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].x, vertex_uniform_buffer_1[4u].x, vertex_unnamed_310)) + vertex_uniform_buffer_2[7u].x;
				precise float vertex_unnamed_341 = mad(vertex_uniform_buffer_2[6u].y, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].y, vertex_uniform_buffer_1[4u].x, vertex_unnamed_311)) + vertex_uniform_buffer_2[7u].y;
				precise float vertex_unnamed_342 = mad(vertex_uniform_buffer_2[6u].z, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].z, vertex_uniform_buffer_1[4u].x, vertex_unnamed_312)) + vertex_uniform_buffer_2[7u].z;
				precise float vertex_unnamed_345 = (-0.0f) - vertex_unnamed_66;
				precise float vertex_unnamed_346 = (-0.0f) - vertex_unnamed_67;
				precise float vertex_unnamed_347 = (-0.0f) - vertex_input_0.z;
				precise float vertex_unnamed_348 = vertex_unnamed_345 + vertex_unnamed_340;
				precise float vertex_unnamed_349 = vertex_unnamed_346 + vertex_unnamed_341;
				precise float vertex_unnamed_350 = vertex_unnamed_347 + vertex_unnamed_342;
				float vertex_unnamed_357 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_unnamed_348, vertex_unnamed_349, vertex_unnamed_350));
				float vertex_unnamed_369 = float(int((-((0.0f < vertex_unnamed_357) ? 4294967295u : 0u)) + ((vertex_unnamed_357 < 0.0f) ? 4294967295u : 0u)));
				precise float vertex_unnamed_376 = vertex_unnamed_369 * vertex_input_2.x;
				precise float vertex_unnamed_377 = vertex_unnamed_369 * vertex_input_2.y;
				precise float vertex_unnamed_378 = vertex_unnamed_369 * vertex_input_2.z;
				float vertex_unnamed_384 = dot(float3(vertex_unnamed_376, vertex_unnamed_377, vertex_unnamed_378), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_392 = dot(float3(vertex_unnamed_376, vertex_unnamed_377, vertex_unnamed_378), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_400 = dot(float3(vertex_unnamed_376, vertex_unnamed_377, vertex_unnamed_378), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_406 = rsqrt(dot(float3(vertex_unnamed_400, vertex_unnamed_384, vertex_unnamed_392), float3(vertex_unnamed_400, vertex_unnamed_384, vertex_unnamed_392)));
				precise float vertex_unnamed_407 = vertex_unnamed_406 * vertex_unnamed_400;
				precise float vertex_unnamed_408 = vertex_unnamed_406 * vertex_unnamed_384;
				precise float vertex_unnamed_409 = vertex_unnamed_406 * vertex_unnamed_392;
				precise float vertex_unnamed_410 = (-0.0f) - vertex_unnamed_120;
				precise float vertex_unnamed_411 = (-0.0f) - vertex_unnamed_121;
				precise float vertex_unnamed_412 = (-0.0f) - vertex_unnamed_122;
				precise float vertex_unnamed_418 = vertex_unnamed_410 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_419 = vertex_unnamed_411 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_420 = vertex_unnamed_412 + vertex_uniform_buffer_1[4u].z;
				vertex_output_6.x = vertex_unnamed_120;
				vertex_output_6.y = vertex_unnamed_121;
				vertex_output_6.z = vertex_unnamed_122;
				float vertex_unnamed_427 = rsqrt(dot(float3(vertex_unnamed_418, vertex_unnamed_419, vertex_unnamed_420), float3(vertex_unnamed_418, vertex_unnamed_419, vertex_unnamed_420)));
				precise float vertex_unnamed_428 = vertex_unnamed_427 * vertex_unnamed_418;
				precise float vertex_unnamed_429 = vertex_unnamed_427 * vertex_unnamed_419;
				precise float vertex_unnamed_430 = vertex_unnamed_427 * vertex_unnamed_420;
				vertex_output_2.y = mad(abs(dot(float3(vertex_unnamed_408, vertex_unnamed_409, vertex_unnamed_407), float3(vertex_unnamed_428, vertex_unnamed_429, vertex_unnamed_430))), mad(vertex_unnamed_277, vertex_unnamed_291, vertex_unnamed_299), vertex_unnamed_298);
				precise float vertex_unnamed_448 = (-0.0f) - vertex_uniform_buffer_0[24u].y;
				precise float vertex_unnamed_452 = vertex_unnamed_448 + vertex_uniform_buffer_0[24u].z;
				precise float vertex_unnamed_465 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_452, vertex_uniform_buffer_0[24u].y), 0.25f, vertex_uniform_buffer_0[6u].x) * vertex_uniform_buffer_0[24u].w;
				precise float vertex_unnamed_466 = vertex_unnamed_465 * 0.5f;
				vertex_output_2.x = vertex_unnamed_466;
				vertex_output_3.z = vertex_unnamed_408;
				precise float vertex_unnamed_477 = vertex_input_1.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_478 = vertex_input_1.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_479 = vertex_input_1.y * vertex_uniform_buffer_2[1u].x;
				float vertex_unnamed_497 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_1.x, vertex_unnamed_477));
				float vertex_unnamed_498 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_1.x, vertex_unnamed_478));
				float vertex_unnamed_499 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_1.x, vertex_unnamed_479));
				float vertex_unnamed_503 = rsqrt(dot(float3(vertex_unnamed_497, vertex_unnamed_498, vertex_unnamed_499), float3(vertex_unnamed_497, vertex_unnamed_498, vertex_unnamed_499)));
				precise float vertex_unnamed_504 = vertex_unnamed_503 * vertex_unnamed_497;
				precise float vertex_unnamed_505 = vertex_unnamed_503 * vertex_unnamed_498;
				precise float vertex_unnamed_506 = vertex_unnamed_503 * vertex_unnamed_499;
				precise float vertex_unnamed_507 = vertex_unnamed_407 * vertex_unnamed_504;
				precise float vertex_unnamed_508 = vertex_unnamed_408 * vertex_unnamed_505;
				precise float vertex_unnamed_509 = vertex_unnamed_409 * vertex_unnamed_506;
				precise float vertex_unnamed_510 = (-0.0f) - vertex_unnamed_507;
				precise float vertex_unnamed_511 = (-0.0f) - vertex_unnamed_508;
				precise float vertex_unnamed_512 = (-0.0f) - vertex_unnamed_509;
				precise float vertex_unnamed_522 = vertex_input_1.w * vertex_uniform_buffer_2[9u].w;
				precise float vertex_unnamed_523 = vertex_unnamed_522 * mad(vertex_unnamed_409, vertex_unnamed_505, vertex_unnamed_510);
				precise float vertex_unnamed_524 = vertex_unnamed_522 * mad(vertex_unnamed_407, vertex_unnamed_506, vertex_unnamed_511);
				precise float vertex_unnamed_525 = vertex_unnamed_522 * mad(vertex_unnamed_408, vertex_unnamed_504, vertex_unnamed_512);
				vertex_output_3.y = vertex_unnamed_523;
				vertex_output_3.x = vertex_unnamed_506;
				vertex_output_4.z = vertex_unnamed_409;
				vertex_output_5.z = vertex_unnamed_407;
				vertex_output_4.x = vertex_unnamed_504;
				vertex_output_5.x = vertex_unnamed_505;
				vertex_output_4.y = vertex_unnamed_524;
				vertex_output_5.y = vertex_unnamed_525;
				vertex_output_7.x = vertex_input_7.x;
				vertex_output_7.y = vertex_input_7.y;
				vertex_output_7.z = vertex_input_7.z;
				vertex_output_7.w = vertex_input_7.w;
				precise float vertex_unnamed_552 = vertex_unnamed_419 * vertex_uniform_buffer_0[14u].x;
				precise float vertex_unnamed_553 = vertex_unnamed_419 * vertex_uniform_buffer_0[14u].y;
				precise float vertex_unnamed_554 = vertex_unnamed_419 * vertex_uniform_buffer_0[14u].z;
				vertex_output_8.x = mad(vertex_uniform_buffer_0[15u].x, vertex_unnamed_420, mad(vertex_uniform_buffer_0[13u].x, vertex_unnamed_418, vertex_unnamed_552));
				vertex_output_8.y = mad(vertex_uniform_buffer_0[15u].y, vertex_unnamed_420, mad(vertex_uniform_buffer_0[13u].y, vertex_unnamed_418, vertex_unnamed_553));
				vertex_output_8.z = mad(vertex_uniform_buffer_0[15u].z, vertex_unnamed_420, mad(vertex_uniform_buffer_0[13u].z, vertex_unnamed_418, vertex_unnamed_554));
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

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

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
			float4 _SpecColor;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;
			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_OcclusionMaskSelector;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[32];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			Texture2D<float4> _BumpMap;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_BumpMap;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_input_7;
			static float3 fragment_input_8;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float2 fragment_input_2 : TEXCOORD6; // TEXCOORD_6
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float3 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
				float3 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
				float3 fragment_input_6 : TEXCOORD5; // TEXCOORD_5
				float4 fragment_input_7 : COLOR; // COLOR
				float3 fragment_input_8 : TEXCOORD7; // TEXCOORD_7
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_75 = (-0.0f) - fragment_input_6.x;
				precise float fragment_unnamed_80 = (-0.0f) - fragment_input_6.y;
				precise float fragment_unnamed_84 = (-0.0f) - fragment_input_6.z;
				precise float fragment_unnamed_92 = fragment_unnamed_75 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_93 = fragment_unnamed_80 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_94 = fragment_unnamed_84 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_99 = rsqrt(dot(float3(fragment_unnamed_92, fragment_unnamed_93, fragment_unnamed_94), float3(fragment_unnamed_92, fragment_unnamed_93, fragment_unnamed_94)));
				precise float fragment_unnamed_105 = 1.0f / fragment_uniform_buffer_0[29u].z;
				precise float fragment_unnamed_107 = 1.0f / fragment_uniform_buffer_0[29u].w;
				float fragment_unnamed_108 = asfloat(0u);
				precise float fragment_unnamed_109 = (-0.0f) - fragment_unnamed_105;
				precise float fragment_unnamed_110 = (-0.0f) - fragment_unnamed_108;
				precise float fragment_unnamed_111 = (-0.0f) - fragment_unnamed_107;
				precise float fragment_unnamed_116 = fragment_unnamed_109 + fragment_input_1.x;
				precise float fragment_unnamed_117 = fragment_unnamed_110 + fragment_input_1.y;
				precise float fragment_unnamed_118 = fragment_unnamed_110 + fragment_input_1.x;
				precise float fragment_unnamed_119 = fragment_unnamed_111 + fragment_input_1.y;
				precise float fragment_unnamed_130 = fragment_unnamed_105 + fragment_input_1.x;
				precise float fragment_unnamed_131 = fragment_unnamed_108 + fragment_input_1.y;
				precise float fragment_unnamed_132 = fragment_unnamed_108 + fragment_input_1.x;
				precise float fragment_unnamed_133 = fragment_unnamed_107 + fragment_input_1.y;
				precise float fragment_unnamed_150 = (-0.0f) - _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
				precise float fragment_unnamed_151 = fragment_unnamed_150 + 0.5f;
				precise float fragment_unnamed_155 = (-0.0f) - fragment_input_2.x;
				precise float fragment_unnamed_156 = fragment_unnamed_151 + fragment_unnamed_155;
				float fragment_unnamed_159 = mad(fragment_unnamed_156, fragment_input_2.y, 0.5f);
				precise float fragment_unnamed_168 = fragment_uniform_buffer_0[8u].x * fragment_uniform_buffer_0[24u].w;
				precise float fragment_unnamed_171 = fragment_unnamed_168 * fragment_input_2.y;
				precise float fragment_unnamed_179 = fragment_uniform_buffer_0[6u].y * fragment_uniform_buffer_0[24u].w;
				precise float fragment_unnamed_182 = fragment_unnamed_179 * fragment_input_2.y;
				precise float fragment_unnamed_198 = fragment_input_7.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_199 = fragment_input_7.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_200 = fragment_input_7.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_201 = fragment_input_7.w * fragment_uniform_buffer_0[5u].w;
				precise float fragment_unnamed_207 = fragment_input_7.w * fragment_uniform_buffer_0[7u].w;
				float4 fragment_unnamed_222 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[4u].x, fragment_uniform_buffer_1[0u].y, fragment_input_1.z), mad(fragment_uniform_buffer_0[4u].y, fragment_uniform_buffer_1[0u].y, fragment_input_1.w)));
				precise float fragment_unnamed_228 = fragment_unnamed_198 * fragment_unnamed_222.x;
				precise float fragment_unnamed_229 = fragment_unnamed_199 * fragment_unnamed_222.y;
				precise float fragment_unnamed_230 = fragment_unnamed_200 * fragment_unnamed_222.z;
				precise float fragment_unnamed_231 = fragment_unnamed_201 * fragment_unnamed_222.w;
				float4 fragment_unnamed_246 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[6u].z, fragment_uniform_buffer_1[0u].y, fragment_input_2.x), mad(fragment_uniform_buffer_0[6u].w, fragment_uniform_buffer_1[0u].y, fragment_input_2.y)));
				precise float fragment_unnamed_257 = fragment_unnamed_246.x * fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_258 = fragment_unnamed_246.y * fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_259 = fragment_unnamed_246.z * fragment_uniform_buffer_0[7u].z;
				precise float fragment_unnamed_260 = fragment_unnamed_207 * fragment_unnamed_246.w;
				precise float fragment_unnamed_261 = (-0.0f) - fragment_unnamed_171;
				precise float fragment_unnamed_267 = mad(fragment_unnamed_182, 0.5f, mad(fragment_unnamed_261, 0.5f, fragment_unnamed_159)) / mad(fragment_unnamed_179, fragment_input_2.y, 1.0f);
				precise float fragment_unnamed_269 = (-0.0f) - clamp(fragment_unnamed_267, 0.0f, 1.0f);
				precise float fragment_unnamed_270 = fragment_unnamed_269 + 1.0f;
				float fragment_unnamed_272 = clamp(mad(fragment_unnamed_171, 0.5f, fragment_unnamed_159), 0.0f, 1.0f);
				precise float fragment_unnamed_275 = sqrt(min(fragment_unnamed_171, 1.0f)) * fragment_unnamed_272;
				precise float fragment_unnamed_276 = fragment_unnamed_231 * fragment_unnamed_228;
				precise float fragment_unnamed_277 = fragment_unnamed_231 * fragment_unnamed_229;
				precise float fragment_unnamed_278 = fragment_unnamed_231 * fragment_unnamed_230;
				precise float fragment_unnamed_279 = fragment_unnamed_257 * fragment_unnamed_260;
				precise float fragment_unnamed_280 = fragment_unnamed_258 * fragment_unnamed_260;
				precise float fragment_unnamed_281 = fragment_unnamed_259 * fragment_unnamed_260;
				precise float fragment_unnamed_282 = (-0.0f) - fragment_unnamed_276;
				precise float fragment_unnamed_283 = (-0.0f) - fragment_unnamed_277;
				precise float fragment_unnamed_284 = (-0.0f) - fragment_unnamed_278;
				precise float fragment_unnamed_285 = (-0.0f) - fragment_unnamed_231;
				precise float fragment_unnamed_286 = fragment_unnamed_282 + fragment_unnamed_279;
				precise float fragment_unnamed_287 = fragment_unnamed_283 + fragment_unnamed_280;
				precise float fragment_unnamed_288 = fragment_unnamed_284 + fragment_unnamed_281;
				precise float fragment_unnamed_289 = fragment_unnamed_285 + fragment_unnamed_260;
				precise float fragment_unnamed_294 = fragment_unnamed_270 * mad(fragment_unnamed_275, fragment_unnamed_286, fragment_unnamed_276);
				precise float fragment_unnamed_295 = fragment_unnamed_270 * mad(fragment_unnamed_275, fragment_unnamed_287, fragment_unnamed_277);
				precise float fragment_unnamed_296 = fragment_unnamed_270 * mad(fragment_unnamed_275, fragment_unnamed_288, fragment_unnamed_278);
				precise float fragment_unnamed_297 = fragment_unnamed_270 * mad(fragment_unnamed_275, fragment_unnamed_289, fragment_unnamed_231);
				float fragment_unnamed_298 = max(fragment_unnamed_297, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_300 = fragment_unnamed_294 / fragment_unnamed_298;
				precise float fragment_unnamed_301 = fragment_unnamed_295 / fragment_unnamed_298;
				precise float fragment_unnamed_302 = fragment_unnamed_296 / fragment_unnamed_298;
				precise float fragment_unnamed_306 = fragment_uniform_buffer_0[24u].x * 0.5f;
				precise float fragment_unnamed_307 = (-0.0f) - fragment_unnamed_306;
				float fragment_unnamed_311 = frac(abs(fragment_unnamed_306));
				precise float fragment_unnamed_312 = (-0.0f) - fragment_unnamed_311;
				bool fragment_unnamed_314 = ((fragment_unnamed_306 >= fragment_unnamed_307) ? fragment_unnamed_311 : fragment_unnamed_312) >= 0.5f;
				precise float fragment_unnamed_320 = fragment_input_2.x + fragment_uniform_buffer_0[8u].z;
				precise float fragment_unnamed_321 = fragment_unnamed_320 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_116, fragment_unnamed_117)).w;
				precise float fragment_unnamed_322 = fragment_unnamed_320 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_130, fragment_unnamed_131)).w;
				precise float fragment_unnamed_323 = fragment_unnamed_320 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_118, fragment_unnamed_119)).w;
				precise float fragment_unnamed_324 = fragment_unnamed_320 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_132, fragment_unnamed_133)).w;
				precise float fragment_unnamed_331 = fragment_uniform_buffer_0[8u].w + fragment_uniform_buffer_0[8u].x;
				float fragment_unnamed_332 = max(fragment_unnamed_331, 0.00999999977648258209228515625f);
				precise float fragment_unnamed_334 = fragment_unnamed_321 + (-0.5f);
				precise float fragment_unnamed_336 = fragment_unnamed_322 + (-0.5f);
				precise float fragment_unnamed_337 = fragment_unnamed_323 + (-0.5f);
				precise float fragment_unnamed_338 = fragment_unnamed_324 + (-0.5f);
				precise float fragment_unnamed_339 = fragment_unnamed_334 / fragment_unnamed_332;
				precise float fragment_unnamed_340 = fragment_unnamed_336 / fragment_unnamed_332;
				precise float fragment_unnamed_341 = fragment_unnamed_337 / fragment_unnamed_332;
				precise float fragment_unnamed_342 = fragment_unnamed_338 / fragment_unnamed_332;
				precise float fragment_unnamed_343 = fragment_unnamed_339 + 0.5f;
				precise float fragment_unnamed_344 = fragment_unnamed_340 + 0.5f;
				precise float fragment_unnamed_345 = fragment_unnamed_341 + 0.5f;
				precise float fragment_unnamed_346 = fragment_unnamed_342 + 0.5f;
				float fragment_unnamed_347 = clamp(fragment_unnamed_343, 0.0f, 1.0f);
				float fragment_unnamed_348 = clamp(fragment_unnamed_344, 0.0f, 1.0f);
				float fragment_unnamed_349 = clamp(fragment_unnamed_345, 0.0f, 1.0f);
				float fragment_unnamed_350 = clamp(fragment_unnamed_346, 0.0f, 1.0f);
				precise float fragment_unnamed_358 = (-0.0f) - abs(mad(fragment_unnamed_347, 2.0f, -1.0f));
				precise float fragment_unnamed_360 = (-0.0f) - abs(mad(fragment_unnamed_348, 2.0f, -1.0f));
				precise float fragment_unnamed_362 = (-0.0f) - abs(mad(fragment_unnamed_349, 2.0f, -1.0f));
				precise float fragment_unnamed_364 = (-0.0f) - abs(mad(fragment_unnamed_350, 2.0f, -1.0f));
				precise float fragment_unnamed_365 = fragment_unnamed_358 + 1.0f;
				precise float fragment_unnamed_366 = fragment_unnamed_360 + 1.0f;
				precise float fragment_unnamed_367 = fragment_unnamed_362 + 1.0f;
				precise float fragment_unnamed_368 = fragment_unnamed_364 + 1.0f;
				float fragment_unnamed_378 = asfloat(fragment_unnamed_314 ? asuint(fragment_unnamed_365) : asuint(fragment_unnamed_347));
				float fragment_unnamed_380 = asfloat(fragment_unnamed_314 ? asuint(fragment_unnamed_366) : asuint(fragment_unnamed_348));
				float fragment_unnamed_382 = asfloat(fragment_unnamed_314 ? asuint(fragment_unnamed_367) : asuint(fragment_unnamed_349));
				float fragment_unnamed_384 = asfloat(fragment_unnamed_314 ? asuint(fragment_unnamed_368) : asuint(fragment_unnamed_350));
				precise float fragment_unnamed_385 = fragment_unnamed_378 * 1.57079601287841796875f;
				precise float fragment_unnamed_387 = fragment_unnamed_380 * 1.57079601287841796875f;
				precise float fragment_unnamed_388 = fragment_unnamed_382 * 1.57079601287841796875f;
				precise float fragment_unnamed_389 = fragment_unnamed_384 * 1.57079601287841796875f;
				precise float fragment_unnamed_394 = (-0.0f) - fragment_unnamed_378;
				precise float fragment_unnamed_395 = (-0.0f) - fragment_unnamed_380;
				precise float fragment_unnamed_396 = (-0.0f) - fragment_unnamed_382;
				precise float fragment_unnamed_397 = (-0.0f) - fragment_unnamed_384;
				precise float fragment_unnamed_398 = fragment_unnamed_394 + sin(fragment_unnamed_385);
				precise float fragment_unnamed_399 = fragment_unnamed_395 + sin(fragment_unnamed_387);
				precise float fragment_unnamed_400 = fragment_unnamed_396 + sin(fragment_unnamed_388);
				precise float fragment_unnamed_401 = fragment_unnamed_397 + sin(fragment_unnamed_389);
				precise float fragment_unnamed_413 = (-0.0f) - fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_414 = fragment_unnamed_413 + 1.0f;
				precise float fragment_unnamed_422 = fragment_unnamed_332 * fragment_uniform_buffer_0[8u].y;
				precise float fragment_unnamed_427 = fragment_unnamed_422 * fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_428 = fragment_unnamed_427 * (-2.0f);
				precise float fragment_unnamed_430 = min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_398, fragment_unnamed_378), fragment_unnamed_414) * fragment_unnamed_428;
				precise float fragment_unnamed_431 = min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_400, fragment_unnamed_382), fragment_unnamed_414) * fragment_unnamed_428;
				precise float fragment_unnamed_432 = (-0.0f) - fragment_unnamed_431;
				precise float fragment_unnamed_433 = (-0.0f) - fragment_unnamed_430;
				float fragment_unnamed_434 = mad(min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_401, fragment_unnamed_384), fragment_unnamed_414), fragment_unnamed_428, fragment_unnamed_432);
				float fragment_unnamed_435 = mad(min(mad(fragment_uniform_buffer_0[9u].y, fragment_unnamed_399, fragment_unnamed_380), fragment_unnamed_414), fragment_unnamed_428, fragment_unnamed_433);
				float fragment_unnamed_436 = asfloat(3212836864u);
				float fragment_unnamed_438 = asfloat(1065353216u);
				float fragment_unnamed_443 = rsqrt(dot(float2(fragment_unnamed_435, fragment_unnamed_438), float2(fragment_unnamed_435, fragment_unnamed_438)));
				precise float fragment_unnamed_444 = fragment_unnamed_443 * 1.0f;
				precise float fragment_unnamed_445 = fragment_unnamed_443 * 0.0f;
				precise float fragment_unnamed_446 = fragment_unnamed_443 * fragment_unnamed_435;
				float fragment_unnamed_450 = rsqrt(dot(float2(fragment_unnamed_436, fragment_unnamed_434), float2(fragment_unnamed_436, fragment_unnamed_434)));
				precise float fragment_unnamed_452 = fragment_unnamed_450 * fragment_unnamed_436;
				precise float fragment_unnamed_453 = fragment_unnamed_450 * fragment_unnamed_434;
				precise float fragment_unnamed_454 = fragment_unnamed_450 * asfloat(0u);
				precise float fragment_unnamed_455 = fragment_unnamed_452 * fragment_unnamed_446;
				precise float fragment_unnamed_456 = fragment_unnamed_453 * fragment_unnamed_444;
				precise float fragment_unnamed_457 = fragment_unnamed_454 * fragment_unnamed_445;
				precise float fragment_unnamed_458 = (-0.0f) - fragment_unnamed_455;
				precise float fragment_unnamed_459 = (-0.0f) - fragment_unnamed_456;
				precise float fragment_unnamed_460 = (-0.0f) - fragment_unnamed_457;
				float4 fragment_unnamed_469 = _BumpMap.Sample(sampler_BumpMap, float2(fragment_input_1.z, fragment_input_1.w));
				precise float fragment_unnamed_474 = fragment_unnamed_469.w * fragment_unnamed_469.x;
				float fragment_unnamed_475 = mad(fragment_unnamed_474, 2.0f, -1.0f);
				float fragment_unnamed_476 = mad(fragment_unnamed_469.y, 2.0f, -1.0f);
				precise float fragment_unnamed_481 = (-0.0f) - min(dot(float2(fragment_unnamed_475, fragment_unnamed_476), float2(fragment_unnamed_475, fragment_unnamed_476)), 1.0f);
				precise float fragment_unnamed_482 = fragment_unnamed_481 + 1.0f;
				precise float fragment_unnamed_487 = (-0.0f) - fragment_uniform_buffer_0[9u].w;
				precise float fragment_unnamed_491 = fragment_unnamed_487 + fragment_uniform_buffer_0[9u].z;
				float fragment_unnamed_495 = mad(fragment_unnamed_272, fragment_unnamed_491, fragment_uniform_buffer_0[9u].w);
				precise float fragment_unnamed_502 = (-0.0f) - mad(fragment_unnamed_297, mad(fragment_unnamed_475, fragment_unnamed_495, -0.0f), 0.0f);
				precise float fragment_unnamed_503 = (-0.0f) - mad(fragment_unnamed_297, mad(fragment_unnamed_476, fragment_unnamed_495, -0.0f), 0.0f);
				precise float fragment_unnamed_504 = (-0.0f) - mad(fragment_unnamed_297, mad(sqrt(fragment_unnamed_482), fragment_unnamed_495, -1.0f), 1.0f);
				precise float fragment_unnamed_505 = mad(fragment_unnamed_445, fragment_unnamed_453, fragment_unnamed_458) + fragment_unnamed_502;
				precise float fragment_unnamed_506 = mad(fragment_unnamed_446, fragment_unnamed_454, fragment_unnamed_459) + fragment_unnamed_503;
				precise float fragment_unnamed_507 = mad(fragment_unnamed_444, fragment_unnamed_452, fragment_unnamed_460) + fragment_unnamed_504;
				float fragment_unnamed_511 = rsqrt(dot(float3(fragment_unnamed_505, fragment_unnamed_506, fragment_unnamed_507), float3(fragment_unnamed_505, fragment_unnamed_506, fragment_unnamed_507)));
				precise float fragment_unnamed_512 = fragment_unnamed_511 * fragment_unnamed_505;
				precise float fragment_unnamed_513 = fragment_unnamed_511 * fragment_unnamed_506;
				precise float fragment_unnamed_514 = fragment_unnamed_511 * fragment_unnamed_507;
				precise float fragment_unnamed_519 = (-0.0f) - fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_523 = fragment_unnamed_519 + fragment_uniform_buffer_0[31u].z;
				float fragment_unnamed_622;
				float fragment_unnamed_623;
				float fragment_unnamed_624;
				float fragment_unnamed_625;
				if (fragment_uniform_buffer_3[0u].x == 1.0f)
				{
					bool fragment_unnamed_535 = fragment_uniform_buffer_3[0u].y == 1.0f;
					precise float fragment_unnamed_543 = fragment_input_6.y * fragment_uniform_buffer_3[2u].x;
					precise float fragment_unnamed_544 = fragment_input_6.y * fragment_uniform_buffer_3[2u].y;
					precise float fragment_unnamed_545 = fragment_input_6.y * fragment_uniform_buffer_3[2u].z;
					precise float fragment_unnamed_571 = mad(fragment_uniform_buffer_3[3u].x, fragment_input_6.z, mad(fragment_uniform_buffer_3[1u].x, fragment_input_6.x, fragment_unnamed_543)) + fragment_uniform_buffer_3[4u].x;
					precise float fragment_unnamed_572 = mad(fragment_uniform_buffer_3[3u].y, fragment_input_6.z, mad(fragment_uniform_buffer_3[1u].y, fragment_input_6.x, fragment_unnamed_544)) + fragment_uniform_buffer_3[4u].y;
					precise float fragment_unnamed_573 = mad(fragment_uniform_buffer_3[3u].z, fragment_input_6.z, mad(fragment_uniform_buffer_3[1u].z, fragment_input_6.x, fragment_unnamed_545)) + fragment_uniform_buffer_3[4u].z;
					precise float fragment_unnamed_586 = (-0.0f) - fragment_uniform_buffer_3[6u].x;
					precise float fragment_unnamed_588 = (-0.0f) - fragment_uniform_buffer_3[6u].y;
					precise float fragment_unnamed_590 = (-0.0f) - fragment_uniform_buffer_3[6u].z;
					precise float fragment_unnamed_591 = (fragment_unnamed_535 ? fragment_unnamed_571 : fragment_input_6.x) + fragment_unnamed_586;
					precise float fragment_unnamed_592 = (fragment_unnamed_535 ? fragment_unnamed_572 : fragment_input_6.y) + fragment_unnamed_588;
					precise float fragment_unnamed_593 = (fragment_unnamed_535 ? fragment_unnamed_573 : fragment_input_6.z) + fragment_unnamed_590;
					precise float fragment_unnamed_599 = fragment_unnamed_591 * fragment_uniform_buffer_3[5u].x;
					precise float fragment_unnamed_600 = fragment_unnamed_592 * fragment_uniform_buffer_3[5u].y;
					precise float fragment_unnamed_601 = fragment_unnamed_593 * fragment_uniform_buffer_3[5u].z;
					float4 fragment_unnamed_612 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_599, 0.25f, 0.75f), mad(fragment_uniform_buffer_3[0u].z, 0.5f, 0.75f)), fragment_unnamed_600, fragment_unnamed_601));
					fragment_unnamed_622 = fragment_unnamed_612.y;
					fragment_unnamed_623 = fragment_unnamed_612.z;
					fragment_unnamed_624 = fragment_unnamed_612.w;
					fragment_unnamed_625 = fragment_unnamed_612.x;
				}
				else
				{
					fragment_unnamed_622 = asfloat(1065353216u);
					fragment_unnamed_623 = asfloat(1065353216u);
					fragment_unnamed_624 = asfloat(1065353216u);
					fragment_unnamed_625 = asfloat(1065353216u);
				}
				float fragment_unnamed_636 = clamp(dot(float4(fragment_unnamed_625, fragment_unnamed_622, fragment_unnamed_623, fragment_unnamed_624), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f);
				precise float fragment_unnamed_643 = (-0.0f) - fragment_unnamed_512;
				precise float fragment_unnamed_644 = (-0.0f) - fragment_unnamed_513;
				precise float fragment_unnamed_645 = (-0.0f) - fragment_unnamed_514;
				float fragment_unnamed_646 = dot(float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z), float3(fragment_unnamed_643, fragment_unnamed_644, fragment_unnamed_645));
				precise float fragment_unnamed_655 = (-0.0f) - fragment_unnamed_512;
				precise float fragment_unnamed_656 = (-0.0f) - fragment_unnamed_513;
				precise float fragment_unnamed_657 = (-0.0f) - fragment_unnamed_514;
				float fragment_unnamed_658 = dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_unnamed_655, fragment_unnamed_656, fragment_unnamed_657));
				precise float fragment_unnamed_667 = (-0.0f) - fragment_unnamed_512;
				precise float fragment_unnamed_668 = (-0.0f) - fragment_unnamed_513;
				precise float fragment_unnamed_669 = (-0.0f) - fragment_unnamed_514;
				float fragment_unnamed_670 = dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_unnamed_667, fragment_unnamed_668, fragment_unnamed_669));
				float fragment_unnamed_676 = rsqrt(dot(float3(fragment_unnamed_646, fragment_unnamed_658, fragment_unnamed_670), float3(fragment_unnamed_646, fragment_unnamed_658, fragment_unnamed_670)));
				precise float fragment_unnamed_677 = fragment_unnamed_676 * fragment_unnamed_646;
				precise float fragment_unnamed_678 = fragment_unnamed_676 * fragment_unnamed_658;
				precise float fragment_unnamed_679 = fragment_unnamed_676 * fragment_unnamed_670;
				precise float fragment_unnamed_685 = fragment_unnamed_636 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_686 = fragment_unnamed_636 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_687 = fragment_unnamed_636 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_693 = mad(fragment_unnamed_92, fragment_unnamed_99, fragment_uniform_buffer_2[0u].x);
				float fragment_unnamed_694 = mad(fragment_unnamed_93, fragment_unnamed_99, fragment_uniform_buffer_2[0u].y);
				float fragment_unnamed_695 = mad(fragment_unnamed_94, fragment_unnamed_99, fragment_uniform_buffer_2[0u].z);
				float fragment_unnamed_699 = rsqrt(dot(float3(fragment_unnamed_693, fragment_unnamed_694, fragment_unnamed_695), float3(fragment_unnamed_693, fragment_unnamed_694, fragment_unnamed_695)));
				precise float fragment_unnamed_700 = fragment_unnamed_699 * fragment_unnamed_693;
				precise float fragment_unnamed_701 = fragment_unnamed_699 * fragment_unnamed_694;
				precise float fragment_unnamed_702 = fragment_unnamed_699 * fragment_unnamed_695;
				float fragment_unnamed_715 = max(dot(float3(fragment_unnamed_677, fragment_unnamed_678, fragment_unnamed_679), float3(fragment_uniform_buffer_2[0u].xyz)), 0.0f);
				precise float fragment_unnamed_716 = mad(fragment_unnamed_272, fragment_unnamed_523, fragment_uniform_buffer_0[31u].y) * 128.0f;
				precise float fragment_unnamed_719 = log2(max(dot(float3(fragment_unnamed_677, fragment_unnamed_678, fragment_unnamed_679), float3(fragment_unnamed_700, fragment_unnamed_701, fragment_unnamed_702)), 0.0f)) * fragment_unnamed_716;
				float fragment_unnamed_720 = exp2(fragment_unnamed_719);
				precise float fragment_unnamed_721 = fragment_unnamed_685 * fragment_unnamed_300;
				precise float fragment_unnamed_722 = fragment_unnamed_686 * fragment_unnamed_301;
				precise float fragment_unnamed_723 = fragment_unnamed_687 * fragment_unnamed_302;
				precise float fragment_unnamed_729 = fragment_unnamed_685 * fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_730 = fragment_unnamed_686 * fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_731 = fragment_unnamed_687 * fragment_uniform_buffer_0[3u].z;
				precise float fragment_unnamed_732 = fragment_unnamed_720 * fragment_unnamed_729;
				precise float fragment_unnamed_733 = fragment_unnamed_720 * fragment_unnamed_730;
				precise float fragment_unnamed_734 = fragment_unnamed_720 * fragment_unnamed_731;
				fragment_output_0.x = mad(fragment_unnamed_721, fragment_unnamed_715, fragment_unnamed_732);
				fragment_output_0.y = mad(fragment_unnamed_722, fragment_unnamed_715, fragment_unnamed_733);
				fragment_output_0.z = mad(fragment_unnamed_723, fragment_unnamed_715, fragment_unnamed_734);
				fragment_output_0.w = fragment_unnamed_297;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[3] = float4(_SpecColor[0], _SpecColor[1], _SpecColor[2], _SpecColor[3]);

				fragment_uniform_buffer_0[4] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _FaceUVSpeedY, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[5] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], _OutlineSoftness, fragment_uniform_buffer_0[6][2], fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], fragment_uniform_buffer_0[6][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[6][3]);

				fragment_uniform_buffer_0[6] = float4(fragment_uniform_buffer_0[6][0], fragment_uniform_buffer_0[6][1], fragment_uniform_buffer_0[6][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[7] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[8] = float4(_OutlineWidth, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _Bevel, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], fragment_uniform_buffer_0[8][1], _BevelOffset, fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], _BevelWidth);

				fragment_uniform_buffer_0[9] = float4(_BevelClamp, fragment_uniform_buffer_0[9][1], fragment_uniform_buffer_0[9][2], fragment_uniform_buffer_0[9][3]);

				fragment_uniform_buffer_0[9] = float4(fragment_uniform_buffer_0[9][0], _BevelRoundness, fragment_uniform_buffer_0[9][2], fragment_uniform_buffer_0[9][3]);

				fragment_uniform_buffer_0[9] = float4(fragment_uniform_buffer_0[9][0], fragment_uniform_buffer_0[9][1], _BumpOutline, fragment_uniform_buffer_0[9][3]);

				fragment_uniform_buffer_0[9] = float4(fragment_uniform_buffer_0[9][0], fragment_uniform_buffer_0[9][1], fragment_uniform_buffer_0[9][2], _BumpFace);

				fragment_uniform_buffer_0[24] = float4(_ShaderFlags, fragment_uniform_buffer_0[24][1], fragment_uniform_buffer_0[24][2], fragment_uniform_buffer_0[24][3]);

				fragment_uniform_buffer_0[24] = float4(fragment_uniform_buffer_0[24][0], fragment_uniform_buffer_0[24][1], fragment_uniform_buffer_0[24][2], _ScaleRatioA);

				fragment_uniform_buffer_0[29] = float4(fragment_uniform_buffer_0[29][0], fragment_uniform_buffer_0[29][1], _TextureWidth, fragment_uniform_buffer_0[29][3]);

				fragment_uniform_buffer_0[29] = float4(fragment_uniform_buffer_0[29][0], fragment_uniform_buffer_0[29][1], fragment_uniform_buffer_0[29][2], _TextureHeight);

				fragment_uniform_buffer_0[30] = float4(_GradientScale, fragment_uniform_buffer_0[30][1], fragment_uniform_buffer_0[30][2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[31] = float4(fragment_uniform_buffer_0[31][0], _FaceShininess, fragment_uniform_buffer_0[31][2], fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_0[31] = float4(fragment_uniform_buffer_0[31][0], fragment_uniform_buffer_0[31][1], _OutlineShininess, fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

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

			#endif // defined(DIRECTIONAL) && !defined(POINT) && !defined(SPOT) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE)


			#if defined(SPOT) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToLight;
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
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[39];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[10];
			static float4 vertex_uniform_buffer_3[21];
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
			static float3 vertex_output_3;
			static float3 vertex_output_4;
			static float3 vertex_output_5;
			static float3 vertex_output_6;
			static float4 vertex_output_7;
			static float3 vertex_output_8;
			static float4 vertex_output_9;

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
				float2 vertex_output_2 : TEXCOORD6; // TEXCOORD_6
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float3 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float3 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float3 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_7 : COLOR; // COLOR
				float3 vertex_output_8 : TEXCOORD7; // TEXCOORD_7
				float4 vertex_output_9 : TEXCOORD8; // TEXCOORD_8
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_67 = vertex_input_0.x + vertex_uniform_buffer_0[29u].z;
				precise float vertex_unnamed_68 = vertex_input_0.y + vertex_uniform_buffer_0[29u].w;
				precise float vertex_unnamed_75 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_76 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_77 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_78 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_99 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_67, vertex_unnamed_75));
				float vertex_unnamed_100 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_67, vertex_unnamed_76));
				float vertex_unnamed_101 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_67, vertex_unnamed_77));
				float vertex_unnamed_102 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_67, vertex_unnamed_78));
				precise float vertex_unnamed_110 = vertex_unnamed_99 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_111 = vertex_unnamed_100 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_112 = vertex_unnamed_101 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_113 = vertex_unnamed_102 + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_121 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_122 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_123 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_124 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_110, vertex_unnamed_121)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_110, vertex_unnamed_122)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_110, vertex_unnamed_123)));
				gl_Position.w = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_110, vertex_unnamed_124)));
				precise float vertex_unnamed_165 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_167 = floor(vertex_unnamed_165);
				precise float vertex_unnamed_168 = (-0.0f) - vertex_unnamed_167;
				precise float vertex_unnamed_174 = vertex_unnamed_167 * 0.001953125f;
				precise float vertex_unnamed_176 = mad(vertex_unnamed_168, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_1.z = mad(vertex_unnamed_174, vertex_uniform_buffer_0[37u].x, vertex_uniform_buffer_0[37u].z);
				vertex_output_1.w = mad(vertex_unnamed_176, vertex_uniform_buffer_0[37u].y, vertex_uniform_buffer_0[37u].w);
				vertex_output_2.x = mad(vertex_unnamed_174, vertex_uniform_buffer_0[38u].x, vertex_uniform_buffer_0[38u].z);
				vertex_output_2.y = mad(vertex_unnamed_176, vertex_uniform_buffer_0[38u].y, vertex_uniform_buffer_0[38u].w);
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[36u].x, vertex_uniform_buffer_0[36u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[36u].y, vertex_uniform_buffer_0[36u].w);
				precise float vertex_unnamed_223 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_235 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_110, vertex_unnamed_223)));
				precise float vertex_unnamed_244 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_245 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_261 = mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_244) * vertex_uniform_buffer_0[34u].y;
				precise float vertex_unnamed_262 = mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_245) * vertex_uniform_buffer_0[34u].z;
				precise float vertex_unnamed_263 = vertex_unnamed_235 / vertex_unnamed_261;
				precise float vertex_unnamed_264 = vertex_unnamed_235 / vertex_unnamed_262;
				float vertex_unnamed_268 = rsqrt(dot(float2(vertex_unnamed_263, vertex_unnamed_264), float2(vertex_unnamed_263, vertex_unnamed_264)));
				precise float vertex_unnamed_275 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[34u].x;
				precise float vertex_unnamed_280 = vertex_uniform_buffer_0[35u].x + 1.0f;
				precise float vertex_unnamed_282 = vertex_unnamed_280 * vertex_unnamed_275;
				precise float vertex_unnamed_283 = vertex_unnamed_268 * vertex_unnamed_282;
				precise float vertex_unnamed_287 = (-0.0f) - vertex_uniform_buffer_0[34u].w;
				precise float vertex_unnamed_288 = vertex_unnamed_287 + 1.0f;
				precise float vertex_unnamed_289 = vertex_unnamed_288 * vertex_unnamed_283;
				precise float vertex_unnamed_290 = (-0.0f) - vertex_unnamed_289;
				precise float vertex_unnamed_301 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].x;
				precise float vertex_unnamed_302 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].y;
				precise float vertex_unnamed_303 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].z;
				precise float vertex_unnamed_331 = mad(vertex_uniform_buffer_2[6u].x, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].x, vertex_uniform_buffer_1[4u].x, vertex_unnamed_301)) + vertex_uniform_buffer_2[7u].x;
				precise float vertex_unnamed_332 = mad(vertex_uniform_buffer_2[6u].y, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].y, vertex_uniform_buffer_1[4u].x, vertex_unnamed_302)) + vertex_uniform_buffer_2[7u].y;
				precise float vertex_unnamed_333 = mad(vertex_uniform_buffer_2[6u].z, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].z, vertex_uniform_buffer_1[4u].x, vertex_unnamed_303)) + vertex_uniform_buffer_2[7u].z;
				precise float vertex_unnamed_336 = (-0.0f) - vertex_unnamed_67;
				precise float vertex_unnamed_337 = (-0.0f) - vertex_unnamed_68;
				precise float vertex_unnamed_338 = (-0.0f) - vertex_input_0.z;
				precise float vertex_unnamed_339 = vertex_unnamed_336 + vertex_unnamed_331;
				precise float vertex_unnamed_340 = vertex_unnamed_337 + vertex_unnamed_332;
				precise float vertex_unnamed_341 = vertex_unnamed_338 + vertex_unnamed_333;
				float vertex_unnamed_348 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_unnamed_339, vertex_unnamed_340, vertex_unnamed_341));
				float vertex_unnamed_360 = float(int((-((0.0f < vertex_unnamed_348) ? 4294967295u : 0u)) + ((vertex_unnamed_348 < 0.0f) ? 4294967295u : 0u)));
				precise float vertex_unnamed_367 = vertex_unnamed_360 * vertex_input_2.x;
				precise float vertex_unnamed_368 = vertex_unnamed_360 * vertex_input_2.y;
				precise float vertex_unnamed_369 = vertex_unnamed_360 * vertex_input_2.z;
				float vertex_unnamed_375 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_383 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_391 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_397 = rsqrt(dot(float3(vertex_unnamed_391, vertex_unnamed_375, vertex_unnamed_383), float3(vertex_unnamed_391, vertex_unnamed_375, vertex_unnamed_383)));
				precise float vertex_unnamed_398 = vertex_unnamed_397 * vertex_unnamed_391;
				precise float vertex_unnamed_399 = vertex_unnamed_397 * vertex_unnamed_375;
				precise float vertex_unnamed_400 = vertex_unnamed_397 * vertex_unnamed_383;
				float vertex_unnamed_408 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_99);
				float vertex_unnamed_409 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_100);
				float vertex_unnamed_410 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_101);
				float vertex_unnamed_419 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_99);
				float vertex_unnamed_420 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_100);
				float vertex_unnamed_421 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_101);
				float vertex_unnamed_422 = mad(vertex_uniform_buffer_2[3u].w, vertex_input_0.w, vertex_unnamed_102);
				precise float vertex_unnamed_423 = (-0.0f) - vertex_unnamed_408;
				precise float vertex_unnamed_424 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_425 = (-0.0f) - vertex_unnamed_410;
				precise float vertex_unnamed_431 = vertex_unnamed_423 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_432 = vertex_unnamed_424 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_433 = vertex_unnamed_425 + vertex_uniform_buffer_1[4u].z;
				vertex_output_6.x = vertex_unnamed_408;
				vertex_output_6.y = vertex_unnamed_409;
				vertex_output_6.z = vertex_unnamed_410;
				float vertex_unnamed_440 = rsqrt(dot(float3(vertex_unnamed_431, vertex_unnamed_432, vertex_unnamed_433), float3(vertex_unnamed_431, vertex_unnamed_432, vertex_unnamed_433)));
				precise float vertex_unnamed_441 = vertex_unnamed_440 * vertex_unnamed_431;
				precise float vertex_unnamed_442 = vertex_unnamed_440 * vertex_unnamed_432;
				precise float vertex_unnamed_443 = vertex_unnamed_440 * vertex_unnamed_433;
				vertex_output_2.y = mad(abs(dot(float3(vertex_unnamed_399, vertex_unnamed_400, vertex_unnamed_398), float3(vertex_unnamed_441, vertex_unnamed_442, vertex_unnamed_443))), mad(vertex_unnamed_268, vertex_unnamed_282, vertex_unnamed_290), vertex_unnamed_289);
				precise float vertex_unnamed_461 = (-0.0f) - vertex_uniform_buffer_0[28u].y;
				precise float vertex_unnamed_465 = vertex_unnamed_461 + vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_478 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_465, vertex_uniform_buffer_0[28u].y), 0.25f, vertex_uniform_buffer_0[10u].x) * vertex_uniform_buffer_0[28u].w;
				precise float vertex_unnamed_479 = vertex_unnamed_478 * 0.5f;
				vertex_output_2.x = vertex_unnamed_479;
				vertex_output_3.z = vertex_unnamed_399;
				precise float vertex_unnamed_490 = vertex_input_1.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_491 = vertex_input_1.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_492 = vertex_input_1.y * vertex_uniform_buffer_2[1u].x;
				float vertex_unnamed_510 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_1.x, vertex_unnamed_490));
				float vertex_unnamed_511 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_1.x, vertex_unnamed_491));
				float vertex_unnamed_512 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_1.x, vertex_unnamed_492));
				float vertex_unnamed_516 = rsqrt(dot(float3(vertex_unnamed_510, vertex_unnamed_511, vertex_unnamed_512), float3(vertex_unnamed_510, vertex_unnamed_511, vertex_unnamed_512)));
				precise float vertex_unnamed_517 = vertex_unnamed_516 * vertex_unnamed_510;
				precise float vertex_unnamed_518 = vertex_unnamed_516 * vertex_unnamed_511;
				precise float vertex_unnamed_519 = vertex_unnamed_516 * vertex_unnamed_512;
				precise float vertex_unnamed_520 = vertex_unnamed_398 * vertex_unnamed_517;
				precise float vertex_unnamed_521 = vertex_unnamed_399 * vertex_unnamed_518;
				precise float vertex_unnamed_522 = vertex_unnamed_400 * vertex_unnamed_519;
				precise float vertex_unnamed_523 = (-0.0f) - vertex_unnamed_520;
				precise float vertex_unnamed_524 = (-0.0f) - vertex_unnamed_521;
				precise float vertex_unnamed_525 = (-0.0f) - vertex_unnamed_522;
				precise float vertex_unnamed_535 = vertex_input_1.w * vertex_uniform_buffer_2[9u].w;
				precise float vertex_unnamed_536 = vertex_unnamed_535 * mad(vertex_unnamed_400, vertex_unnamed_518, vertex_unnamed_523);
				precise float vertex_unnamed_537 = vertex_unnamed_535 * mad(vertex_unnamed_398, vertex_unnamed_519, vertex_unnamed_524);
				precise float vertex_unnamed_538 = vertex_unnamed_535 * mad(vertex_unnamed_399, vertex_unnamed_517, vertex_unnamed_525);
				vertex_output_3.y = vertex_unnamed_536;
				vertex_output_3.x = vertex_unnamed_519;
				vertex_output_4.z = vertex_unnamed_400;
				vertex_output_5.z = vertex_unnamed_398;
				vertex_output_4.x = vertex_unnamed_517;
				vertex_output_5.x = vertex_unnamed_518;
				vertex_output_4.y = vertex_unnamed_537;
				vertex_output_5.y = vertex_unnamed_538;
				vertex_output_7.x = vertex_input_7.x;
				vertex_output_7.y = vertex_input_7.y;
				vertex_output_7.z = vertex_input_7.z;
				vertex_output_7.w = vertex_input_7.w;
				precise float vertex_unnamed_564 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].x;
				precise float vertex_unnamed_565 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].y;
				precise float vertex_unnamed_566 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].z;
				vertex_output_8.x = mad(vertex_uniform_buffer_0[19u].x, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].x, vertex_unnamed_431, vertex_unnamed_564));
				vertex_output_8.y = mad(vertex_uniform_buffer_0[19u].y, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].y, vertex_unnamed_431, vertex_unnamed_565));
				vertex_output_8.z = mad(vertex_uniform_buffer_0[19u].z, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].z, vertex_unnamed_431, vertex_unnamed_566));
				precise float vertex_unnamed_592 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_593 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].y;
				precise float vertex_unnamed_594 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].z;
				precise float vertex_unnamed_595 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].w;
				vertex_output_9.x = mad(vertex_uniform_buffer_0[7u].x, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].x, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].x, vertex_unnamed_419, vertex_unnamed_592)));
				vertex_output_9.y = mad(vertex_uniform_buffer_0[7u].y, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].y, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].y, vertex_unnamed_419, vertex_unnamed_593)));
				vertex_output_9.z = mad(vertex_uniform_buffer_0[7u].z, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].z, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].z, vertex_unnamed_419, vertex_unnamed_594)));
				vertex_output_9.w = mad(vertex_uniform_buffer_0[7u].w, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].w, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].w, vertex_unnamed_419, vertex_unnamed_595)));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				vertex_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				vertex_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				vertex_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				vertex_uniform_buffer_0[10] = float4(_FaceDilate, vertex_uniform_buffer_0[10][1], vertex_uniform_buffer_0[10][2], vertex_uniform_buffer_0[10][3]);

				vertex_uniform_buffer_0[17] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				vertex_uniform_buffer_0[18] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				vertex_uniform_buffer_0[19] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				vertex_uniform_buffer_0[20] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], _WeightNormal, vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], _WeightBold, vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], _ScaleRatioA);

				vertex_uniform_buffer_0[29] = float4(vertex_uniform_buffer_0[29][0], vertex_uniform_buffer_0[29][1], _VertexOffsetX, vertex_uniform_buffer_0[29][3]);

				vertex_uniform_buffer_0[29] = float4(vertex_uniform_buffer_0[29][0], vertex_uniform_buffer_0[29][1], vertex_uniform_buffer_0[29][2], _VertexOffsetY);

				vertex_uniform_buffer_0[34] = float4(_GradientScale, vertex_uniform_buffer_0[34][1], vertex_uniform_buffer_0[34][2], vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], _ScaleX, vertex_uniform_buffer_0[34][2], vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], vertex_uniform_buffer_0[34][1], _ScaleY, vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], vertex_uniform_buffer_0[34][1], vertex_uniform_buffer_0[34][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[35] = float4(_Sharpness, vertex_uniform_buffer_0[35][1], vertex_uniform_buffer_0[35][2], vertex_uniform_buffer_0[35][3]);

				vertex_uniform_buffer_0[36] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_0[37] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[38] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

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

				vertex_uniform_buffer_2[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

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
				stage_output.vertex_output_9 = vertex_output_9;
				return stage_output;
			}


			float4 _LightColor0;
			float4 _SpecColor;
			float4x4 unity_WorldToLight;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;
			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_OcclusionMaskSelector;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[36];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			Texture2D<float4> _BumpMap;
			Texture2D<float4> _LightTexture0;
			Texture2D<float4> _LightTextureB0;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_LightTexture0;
			SamplerState sampler_LightTextureB0;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_BumpMap;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_input_7;
			static float3 fragment_input_8;
			static float4 fragment_input_9;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float2 fragment_input_2 : TEXCOORD6; // TEXCOORD_6
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float3 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
				float3 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
				float3 fragment_input_6 : TEXCOORD5; // TEXCOORD_5
				float4 fragment_input_7 : COLOR; // COLOR
				float3 fragment_input_8 : TEXCOORD7; // TEXCOORD_7
				float4 fragment_input_9 : TEXCOORD8; // TEXCOORD_8
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_84 = (-0.0f) - fragment_input_6.x;
				precise float fragment_unnamed_89 = (-0.0f) - fragment_input_6.y;
				precise float fragment_unnamed_93 = (-0.0f) - fragment_input_6.z;
				precise float fragment_unnamed_100 = fragment_unnamed_84 + fragment_uniform_buffer_2[0u].x;
				precise float fragment_unnamed_101 = fragment_unnamed_89 + fragment_uniform_buffer_2[0u].y;
				precise float fragment_unnamed_102 = fragment_unnamed_93 + fragment_uniform_buffer_2[0u].z;
				float fragment_unnamed_107 = rsqrt(dot(float3(fragment_unnamed_100, fragment_unnamed_101, fragment_unnamed_102), float3(fragment_unnamed_100, fragment_unnamed_101, fragment_unnamed_102)));
				precise float fragment_unnamed_108 = fragment_unnamed_107 * fragment_unnamed_100;
				precise float fragment_unnamed_109 = fragment_unnamed_107 * fragment_unnamed_101;
				precise float fragment_unnamed_110 = fragment_unnamed_107 * fragment_unnamed_102;
				precise float fragment_unnamed_113 = (-0.0f) - fragment_input_6.x;
				precise float fragment_unnamed_116 = (-0.0f) - fragment_input_6.y;
				precise float fragment_unnamed_119 = (-0.0f) - fragment_input_6.z;
				precise float fragment_unnamed_126 = fragment_unnamed_113 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_127 = fragment_unnamed_116 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_128 = fragment_unnamed_119 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_132 = rsqrt(dot(float3(fragment_unnamed_126, fragment_unnamed_127, fragment_unnamed_128), float3(fragment_unnamed_126, fragment_unnamed_127, fragment_unnamed_128)));
				precise float fragment_unnamed_138 = 1.0f / fragment_uniform_buffer_0[33u].z;
				precise float fragment_unnamed_140 = 1.0f / fragment_uniform_buffer_0[33u].w;
				float fragment_unnamed_141 = asfloat(0u);
				precise float fragment_unnamed_142 = (-0.0f) - fragment_unnamed_138;
				precise float fragment_unnamed_143 = (-0.0f) - fragment_unnamed_141;
				precise float fragment_unnamed_144 = (-0.0f) - fragment_unnamed_140;
				precise float fragment_unnamed_149 = fragment_unnamed_142 + fragment_input_1.x;
				precise float fragment_unnamed_150 = fragment_unnamed_143 + fragment_input_1.y;
				precise float fragment_unnamed_151 = fragment_unnamed_143 + fragment_input_1.x;
				precise float fragment_unnamed_152 = fragment_unnamed_144 + fragment_input_1.y;
				precise float fragment_unnamed_163 = fragment_unnamed_138 + fragment_input_1.x;
				precise float fragment_unnamed_164 = fragment_unnamed_141 + fragment_input_1.y;
				precise float fragment_unnamed_165 = fragment_unnamed_141 + fragment_input_1.x;
				precise float fragment_unnamed_166 = fragment_unnamed_140 + fragment_input_1.y;
				precise float fragment_unnamed_183 = (-0.0f) - _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
				precise float fragment_unnamed_184 = fragment_unnamed_183 + 0.5f;
				precise float fragment_unnamed_188 = (-0.0f) - fragment_input_2.x;
				precise float fragment_unnamed_189 = fragment_unnamed_184 + fragment_unnamed_188;
				float fragment_unnamed_192 = mad(fragment_unnamed_189, fragment_input_2.y, 0.5f);
				precise float fragment_unnamed_201 = fragment_uniform_buffer_0[12u].x * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_209 = fragment_uniform_buffer_0[10u].y * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_212 = fragment_unnamed_201 * fragment_input_2.y;
				precise float fragment_unnamed_213 = fragment_unnamed_209 * fragment_input_2.y;
				precise float fragment_unnamed_230 = fragment_input_7.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_231 = fragment_input_7.y * fragment_uniform_buffer_0[9u].y;
				precise float fragment_unnamed_232 = fragment_input_7.z * fragment_uniform_buffer_0[9u].z;
				precise float fragment_unnamed_233 = fragment_input_7.w * fragment_uniform_buffer_0[9u].w;
				precise float fragment_unnamed_240 = fragment_input_7.w * fragment_uniform_buffer_0[11u].w;
				float4 fragment_unnamed_256 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[8u].x, fragment_uniform_buffer_1[0u].y, fragment_input_1.z), mad(fragment_uniform_buffer_0[8u].y, fragment_uniform_buffer_1[0u].y, fragment_input_1.w)));
				precise float fragment_unnamed_262 = fragment_unnamed_230 * fragment_unnamed_256.x;
				precise float fragment_unnamed_263 = fragment_unnamed_231 * fragment_unnamed_256.y;
				precise float fragment_unnamed_264 = fragment_unnamed_232 * fragment_unnamed_256.z;
				precise float fragment_unnamed_265 = fragment_unnamed_233 * fragment_unnamed_256.w;
				float4 fragment_unnamed_280 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[10u].z, fragment_uniform_buffer_1[0u].y, fragment_input_2.x), mad(fragment_uniform_buffer_0[10u].w, fragment_uniform_buffer_1[0u].y, fragment_input_2.y)));
				precise float fragment_unnamed_291 = fragment_unnamed_280.x * fragment_uniform_buffer_0[11u].x;
				precise float fragment_unnamed_292 = fragment_unnamed_280.y * fragment_uniform_buffer_0[11u].y;
				precise float fragment_unnamed_293 = fragment_unnamed_280.z * fragment_uniform_buffer_0[11u].z;
				precise float fragment_unnamed_294 = fragment_unnamed_240 * fragment_unnamed_280.w;
				precise float fragment_unnamed_295 = (-0.0f) - fragment_unnamed_212;
				precise float fragment_unnamed_301 = mad(fragment_unnamed_213, 0.5f, mad(fragment_unnamed_295, 0.5f, fragment_unnamed_192)) / mad(fragment_unnamed_209, fragment_input_2.y, 1.0f);
				precise float fragment_unnamed_303 = (-0.0f) - clamp(fragment_unnamed_301, 0.0f, 1.0f);
				precise float fragment_unnamed_304 = fragment_unnamed_303 + 1.0f;
				float fragment_unnamed_306 = clamp(mad(fragment_unnamed_212, 0.5f, fragment_unnamed_192), 0.0f, 1.0f);
				precise float fragment_unnamed_309 = fragment_unnamed_306 * sqrt(min(fragment_unnamed_212, 1.0f));
				precise float fragment_unnamed_310 = fragment_unnamed_265 * fragment_unnamed_262;
				precise float fragment_unnamed_311 = fragment_unnamed_265 * fragment_unnamed_263;
				precise float fragment_unnamed_312 = fragment_unnamed_265 * fragment_unnamed_264;
				precise float fragment_unnamed_313 = fragment_unnamed_291 * fragment_unnamed_294;
				precise float fragment_unnamed_314 = fragment_unnamed_292 * fragment_unnamed_294;
				precise float fragment_unnamed_315 = fragment_unnamed_293 * fragment_unnamed_294;
				precise float fragment_unnamed_316 = (-0.0f) - fragment_unnamed_310;
				precise float fragment_unnamed_317 = (-0.0f) - fragment_unnamed_311;
				precise float fragment_unnamed_318 = (-0.0f) - fragment_unnamed_312;
				precise float fragment_unnamed_319 = (-0.0f) - fragment_unnamed_265;
				precise float fragment_unnamed_320 = fragment_unnamed_316 + fragment_unnamed_313;
				precise float fragment_unnamed_321 = fragment_unnamed_317 + fragment_unnamed_314;
				precise float fragment_unnamed_322 = fragment_unnamed_318 + fragment_unnamed_315;
				precise float fragment_unnamed_323 = fragment_unnamed_319 + fragment_unnamed_294;
				precise float fragment_unnamed_328 = fragment_unnamed_304 * mad(fragment_unnamed_309, fragment_unnamed_320, fragment_unnamed_310);
				precise float fragment_unnamed_329 = fragment_unnamed_304 * mad(fragment_unnamed_309, fragment_unnamed_321, fragment_unnamed_311);
				precise float fragment_unnamed_330 = fragment_unnamed_304 * mad(fragment_unnamed_309, fragment_unnamed_322, fragment_unnamed_312);
				precise float fragment_unnamed_331 = fragment_unnamed_304 * mad(fragment_unnamed_309, fragment_unnamed_323, fragment_unnamed_265);
				float fragment_unnamed_332 = max(fragment_unnamed_331, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_334 = fragment_unnamed_328 / fragment_unnamed_332;
				precise float fragment_unnamed_335 = fragment_unnamed_329 / fragment_unnamed_332;
				precise float fragment_unnamed_336 = fragment_unnamed_330 / fragment_unnamed_332;
				precise float fragment_unnamed_340 = fragment_uniform_buffer_0[28u].x * 0.5f;
				precise float fragment_unnamed_341 = (-0.0f) - fragment_unnamed_340;
				float fragment_unnamed_345 = frac(abs(fragment_unnamed_340));
				precise float fragment_unnamed_346 = (-0.0f) - fragment_unnamed_345;
				bool fragment_unnamed_348 = ((fragment_unnamed_340 >= fragment_unnamed_341) ? fragment_unnamed_345 : fragment_unnamed_346) >= 0.5f;
				precise float fragment_unnamed_354 = fragment_input_2.x + fragment_uniform_buffer_0[12u].z;
				precise float fragment_unnamed_355 = fragment_unnamed_354 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_149, fragment_unnamed_150)).w;
				precise float fragment_unnamed_356 = fragment_unnamed_354 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_163, fragment_unnamed_164)).w;
				precise float fragment_unnamed_357 = fragment_unnamed_354 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_151, fragment_unnamed_152)).w;
				precise float fragment_unnamed_358 = fragment_unnamed_354 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_165, fragment_unnamed_166)).w;
				precise float fragment_unnamed_365 = fragment_uniform_buffer_0[12u].w + fragment_uniform_buffer_0[12u].x;
				float fragment_unnamed_366 = max(fragment_unnamed_365, 0.00999999977648258209228515625f);
				precise float fragment_unnamed_368 = fragment_unnamed_355 + (-0.5f);
				precise float fragment_unnamed_370 = fragment_unnamed_356 + (-0.5f);
				precise float fragment_unnamed_371 = fragment_unnamed_357 + (-0.5f);
				precise float fragment_unnamed_372 = fragment_unnamed_358 + (-0.5f);
				precise float fragment_unnamed_373 = fragment_unnamed_368 / fragment_unnamed_366;
				precise float fragment_unnamed_374 = fragment_unnamed_370 / fragment_unnamed_366;
				precise float fragment_unnamed_375 = fragment_unnamed_371 / fragment_unnamed_366;
				precise float fragment_unnamed_376 = fragment_unnamed_372 / fragment_unnamed_366;
				precise float fragment_unnamed_377 = fragment_unnamed_373 + 0.5f;
				precise float fragment_unnamed_378 = fragment_unnamed_374 + 0.5f;
				precise float fragment_unnamed_379 = fragment_unnamed_375 + 0.5f;
				precise float fragment_unnamed_380 = fragment_unnamed_376 + 0.5f;
				float fragment_unnamed_381 = clamp(fragment_unnamed_377, 0.0f, 1.0f);
				float fragment_unnamed_382 = clamp(fragment_unnamed_378, 0.0f, 1.0f);
				float fragment_unnamed_383 = clamp(fragment_unnamed_379, 0.0f, 1.0f);
				float fragment_unnamed_384 = clamp(fragment_unnamed_380, 0.0f, 1.0f);
				precise float fragment_unnamed_392 = (-0.0f) - abs(mad(fragment_unnamed_381, 2.0f, -1.0f));
				precise float fragment_unnamed_394 = (-0.0f) - abs(mad(fragment_unnamed_382, 2.0f, -1.0f));
				precise float fragment_unnamed_396 = (-0.0f) - abs(mad(fragment_unnamed_383, 2.0f, -1.0f));
				precise float fragment_unnamed_398 = (-0.0f) - abs(mad(fragment_unnamed_384, 2.0f, -1.0f));
				precise float fragment_unnamed_399 = fragment_unnamed_392 + 1.0f;
				precise float fragment_unnamed_400 = fragment_unnamed_394 + 1.0f;
				precise float fragment_unnamed_401 = fragment_unnamed_396 + 1.0f;
				precise float fragment_unnamed_402 = fragment_unnamed_398 + 1.0f;
				float fragment_unnamed_412 = asfloat(fragment_unnamed_348 ? asuint(fragment_unnamed_399) : asuint(fragment_unnamed_381));
				float fragment_unnamed_414 = asfloat(fragment_unnamed_348 ? asuint(fragment_unnamed_400) : asuint(fragment_unnamed_382));
				float fragment_unnamed_416 = asfloat(fragment_unnamed_348 ? asuint(fragment_unnamed_401) : asuint(fragment_unnamed_383));
				float fragment_unnamed_418 = asfloat(fragment_unnamed_348 ? asuint(fragment_unnamed_402) : asuint(fragment_unnamed_384));
				precise float fragment_unnamed_419 = fragment_unnamed_412 * 1.57079601287841796875f;
				precise float fragment_unnamed_421 = fragment_unnamed_414 * 1.57079601287841796875f;
				precise float fragment_unnamed_422 = fragment_unnamed_416 * 1.57079601287841796875f;
				precise float fragment_unnamed_423 = fragment_unnamed_418 * 1.57079601287841796875f;
				precise float fragment_unnamed_428 = (-0.0f) - fragment_unnamed_412;
				precise float fragment_unnamed_429 = (-0.0f) - fragment_unnamed_414;
				precise float fragment_unnamed_430 = (-0.0f) - fragment_unnamed_416;
				precise float fragment_unnamed_431 = (-0.0f) - fragment_unnamed_418;
				precise float fragment_unnamed_432 = fragment_unnamed_428 + sin(fragment_unnamed_419);
				precise float fragment_unnamed_433 = fragment_unnamed_429 + sin(fragment_unnamed_421);
				precise float fragment_unnamed_434 = fragment_unnamed_430 + sin(fragment_unnamed_422);
				precise float fragment_unnamed_435 = fragment_unnamed_431 + sin(fragment_unnamed_423);
				precise float fragment_unnamed_447 = (-0.0f) - fragment_uniform_buffer_0[13u].x;
				precise float fragment_unnamed_448 = fragment_unnamed_447 + 1.0f;
				precise float fragment_unnamed_456 = fragment_unnamed_366 * fragment_uniform_buffer_0[12u].y;
				precise float fragment_unnamed_461 = fragment_unnamed_456 * fragment_uniform_buffer_0[34u].x;
				precise float fragment_unnamed_462 = fragment_unnamed_461 * (-2.0f);
				precise float fragment_unnamed_464 = min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_432, fragment_unnamed_412), fragment_unnamed_448) * fragment_unnamed_462;
				precise float fragment_unnamed_465 = min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_434, fragment_unnamed_416), fragment_unnamed_448) * fragment_unnamed_462;
				precise float fragment_unnamed_466 = (-0.0f) - fragment_unnamed_465;
				precise float fragment_unnamed_467 = (-0.0f) - fragment_unnamed_464;
				float fragment_unnamed_468 = mad(min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_435, fragment_unnamed_418), fragment_unnamed_448), fragment_unnamed_462, fragment_unnamed_466);
				float fragment_unnamed_469 = mad(min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_433, fragment_unnamed_414), fragment_unnamed_448), fragment_unnamed_462, fragment_unnamed_467);
				float fragment_unnamed_470 = asfloat(3212836864u);
				float fragment_unnamed_472 = asfloat(1065353216u);
				float fragment_unnamed_477 = rsqrt(dot(float2(fragment_unnamed_469, fragment_unnamed_472), float2(fragment_unnamed_469, fragment_unnamed_472)));
				precise float fragment_unnamed_478 = fragment_unnamed_477 * 1.0f;
				precise float fragment_unnamed_479 = fragment_unnamed_477 * 0.0f;
				precise float fragment_unnamed_480 = fragment_unnamed_477 * fragment_unnamed_469;
				float fragment_unnamed_484 = rsqrt(dot(float2(fragment_unnamed_470, fragment_unnamed_468), float2(fragment_unnamed_470, fragment_unnamed_468)));
				precise float fragment_unnamed_486 = fragment_unnamed_484 * fragment_unnamed_470;
				precise float fragment_unnamed_487 = fragment_unnamed_484 * fragment_unnamed_468;
				precise float fragment_unnamed_488 = fragment_unnamed_484 * asfloat(0u);
				precise float fragment_unnamed_489 = fragment_unnamed_486 * fragment_unnamed_480;
				precise float fragment_unnamed_490 = fragment_unnamed_487 * fragment_unnamed_478;
				precise float fragment_unnamed_491 = fragment_unnamed_488 * fragment_unnamed_479;
				precise float fragment_unnamed_492 = (-0.0f) - fragment_unnamed_489;
				precise float fragment_unnamed_493 = (-0.0f) - fragment_unnamed_490;
				precise float fragment_unnamed_494 = (-0.0f) - fragment_unnamed_491;
				float4 fragment_unnamed_503 = _BumpMap.Sample(sampler_BumpMap, float2(fragment_input_1.z, fragment_input_1.w));
				precise float fragment_unnamed_508 = fragment_unnamed_503.w * fragment_unnamed_503.x;
				float fragment_unnamed_509 = mad(fragment_unnamed_508, 2.0f, -1.0f);
				float fragment_unnamed_510 = mad(fragment_unnamed_503.y, 2.0f, -1.0f);
				precise float fragment_unnamed_515 = (-0.0f) - min(dot(float2(fragment_unnamed_509, fragment_unnamed_510), float2(fragment_unnamed_509, fragment_unnamed_510)), 1.0f);
				precise float fragment_unnamed_516 = fragment_unnamed_515 + 1.0f;
				precise float fragment_unnamed_521 = (-0.0f) - fragment_uniform_buffer_0[13u].w;
				precise float fragment_unnamed_525 = fragment_unnamed_521 + fragment_uniform_buffer_0[13u].z;
				float fragment_unnamed_529 = mad(fragment_unnamed_306, fragment_unnamed_525, fragment_uniform_buffer_0[13u].w);
				precise float fragment_unnamed_536 = (-0.0f) - mad(fragment_unnamed_331, mad(fragment_unnamed_509, fragment_unnamed_529, -0.0f), 0.0f);
				precise float fragment_unnamed_537 = (-0.0f) - mad(fragment_unnamed_331, mad(fragment_unnamed_510, fragment_unnamed_529, -0.0f), 0.0f);
				precise float fragment_unnamed_538 = (-0.0f) - mad(fragment_unnamed_331, mad(sqrt(fragment_unnamed_516), fragment_unnamed_529, -1.0f), 1.0f);
				precise float fragment_unnamed_539 = mad(fragment_unnamed_479, fragment_unnamed_487, fragment_unnamed_492) + fragment_unnamed_536;
				precise float fragment_unnamed_540 = mad(fragment_unnamed_480, fragment_unnamed_488, fragment_unnamed_493) + fragment_unnamed_537;
				precise float fragment_unnamed_541 = mad(fragment_unnamed_478, fragment_unnamed_486, fragment_unnamed_494) + fragment_unnamed_538;
				float fragment_unnamed_545 = rsqrt(dot(float3(fragment_unnamed_539, fragment_unnamed_540, fragment_unnamed_541), float3(fragment_unnamed_539, fragment_unnamed_540, fragment_unnamed_541)));
				precise float fragment_unnamed_546 = fragment_unnamed_545 * fragment_unnamed_539;
				precise float fragment_unnamed_547 = fragment_unnamed_545 * fragment_unnamed_540;
				precise float fragment_unnamed_548 = fragment_unnamed_545 * fragment_unnamed_541;
				precise float fragment_unnamed_553 = (-0.0f) - fragment_uniform_buffer_0[35u].y;
				precise float fragment_unnamed_557 = fragment_unnamed_553 + fragment_uniform_buffer_0[35u].z;
				precise float fragment_unnamed_570 = fragment_input_6.y * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_571 = fragment_input_6.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_572 = fragment_input_6.y * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_573 = fragment_input_6.y * fragment_uniform_buffer_0[5u].w;
				precise float fragment_unnamed_605 = mad(fragment_uniform_buffer_0[6u].x, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].x, fragment_input_6.x, fragment_unnamed_570)) + fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_606 = mad(fragment_uniform_buffer_0[6u].y, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].y, fragment_input_6.x, fragment_unnamed_571)) + fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_607 = mad(fragment_uniform_buffer_0[6u].z, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].z, fragment_input_6.x, fragment_unnamed_572)) + fragment_uniform_buffer_0[7u].z;
				precise float fragment_unnamed_608 = mad(fragment_uniform_buffer_0[6u].w, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].w, fragment_input_6.x, fragment_unnamed_573)) + fragment_uniform_buffer_0[7u].w;
				float fragment_unnamed_703;
				float fragment_unnamed_704;
				float fragment_unnamed_705;
				float fragment_unnamed_706;
				if (fragment_uniform_buffer_3[0u].x == 1.0f)
				{
					bool fragment_unnamed_616 = fragment_uniform_buffer_3[0u].y == 1.0f;
					precise float fragment_unnamed_624 = fragment_input_6.y * fragment_uniform_buffer_3[2u].x;
					precise float fragment_unnamed_625 = fragment_input_6.y * fragment_uniform_buffer_3[2u].y;
					precise float fragment_unnamed_626 = fragment_input_6.y * fragment_uniform_buffer_3[2u].z;
					precise float fragment_unnamed_652 = mad(fragment_uniform_buffer_3[3u].x, fragment_input_6.z, mad(fragment_uniform_buffer_3[1u].x, fragment_input_6.x, fragment_unnamed_624)) + fragment_uniform_buffer_3[4u].x;
					precise float fragment_unnamed_653 = mad(fragment_uniform_buffer_3[3u].y, fragment_input_6.z, mad(fragment_uniform_buffer_3[1u].y, fragment_input_6.x, fragment_unnamed_625)) + fragment_uniform_buffer_3[4u].y;
					precise float fragment_unnamed_654 = mad(fragment_uniform_buffer_3[3u].z, fragment_input_6.z, mad(fragment_uniform_buffer_3[1u].z, fragment_input_6.x, fragment_unnamed_626)) + fragment_uniform_buffer_3[4u].z;
					precise float fragment_unnamed_667 = (-0.0f) - fragment_uniform_buffer_3[6u].x;
					precise float fragment_unnamed_669 = (-0.0f) - fragment_uniform_buffer_3[6u].y;
					precise float fragment_unnamed_671 = (-0.0f) - fragment_uniform_buffer_3[6u].z;
					precise float fragment_unnamed_672 = (fragment_unnamed_616 ? fragment_unnamed_652 : fragment_input_6.x) + fragment_unnamed_667;
					precise float fragment_unnamed_673 = (fragment_unnamed_616 ? fragment_unnamed_653 : fragment_input_6.y) + fragment_unnamed_669;
					precise float fragment_unnamed_674 = (fragment_unnamed_616 ? fragment_unnamed_654 : fragment_input_6.z) + fragment_unnamed_671;
					precise float fragment_unnamed_680 = fragment_unnamed_672 * fragment_uniform_buffer_3[5u].x;
					precise float fragment_unnamed_681 = fragment_unnamed_673 * fragment_uniform_buffer_3[5u].y;
					precise float fragment_unnamed_682 = fragment_unnamed_674 * fragment_uniform_buffer_3[5u].z;
					float4 fragment_unnamed_693 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_680, 0.25f, 0.75f), mad(fragment_uniform_buffer_3[0u].z, 0.5f, 0.75f)), fragment_unnamed_681, fragment_unnamed_682));
					fragment_unnamed_703 = fragment_unnamed_693.x;
					fragment_unnamed_704 = fragment_unnamed_693.y;
					fragment_unnamed_705 = fragment_unnamed_693.z;
					fragment_unnamed_706 = fragment_unnamed_693.w;
				}
				else
				{
					fragment_unnamed_703 = asfloat(1065353216u);
					fragment_unnamed_704 = asfloat(1065353216u);
					fragment_unnamed_705 = asfloat(1065353216u);
					fragment_unnamed_706 = asfloat(1065353216u);
				}
				precise float fragment_unnamed_723 = fragment_unnamed_605 / fragment_unnamed_608;
				precise float fragment_unnamed_724 = fragment_unnamed_606 / fragment_unnamed_608;
				precise float fragment_unnamed_725 = fragment_unnamed_723 + 0.5f;
				precise float fragment_unnamed_726 = fragment_unnamed_724 + 0.5f;
				precise float fragment_unnamed_731 = asfloat(((0.0f < fragment_unnamed_607) ? 4294967295u : 0u) & 1065353216u) * _LightTexture0.Sample(sampler_LightTexture0, float2(fragment_unnamed_725, fragment_unnamed_726)).w;
				precise float fragment_unnamed_739 = fragment_unnamed_731 * _LightTextureB0.Sample(sampler_LightTextureB0, dot(float3(fragment_unnamed_605, fragment_unnamed_606, fragment_unnamed_607), float3(fragment_unnamed_605, fragment_unnamed_606, fragment_unnamed_607)).xx).x;
				precise float fragment_unnamed_740 = clamp(dot(float4(fragment_unnamed_703, fragment_unnamed_704, fragment_unnamed_705, fragment_unnamed_706), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f) * fragment_unnamed_739;
				precise float fragment_unnamed_747 = (-0.0f) - fragment_unnamed_546;
				precise float fragment_unnamed_748 = (-0.0f) - fragment_unnamed_547;
				precise float fragment_unnamed_749 = (-0.0f) - fragment_unnamed_548;
				float fragment_unnamed_750 = dot(float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z), float3(fragment_unnamed_747, fragment_unnamed_748, fragment_unnamed_749));
				precise float fragment_unnamed_759 = (-0.0f) - fragment_unnamed_546;
				precise float fragment_unnamed_760 = (-0.0f) - fragment_unnamed_547;
				precise float fragment_unnamed_761 = (-0.0f) - fragment_unnamed_548;
				float fragment_unnamed_762 = dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_unnamed_759, fragment_unnamed_760, fragment_unnamed_761));
				precise float fragment_unnamed_771 = (-0.0f) - fragment_unnamed_546;
				precise float fragment_unnamed_772 = (-0.0f) - fragment_unnamed_547;
				precise float fragment_unnamed_773 = (-0.0f) - fragment_unnamed_548;
				float fragment_unnamed_774 = dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_unnamed_771, fragment_unnamed_772, fragment_unnamed_773));
				float fragment_unnamed_780 = rsqrt(dot(float3(fragment_unnamed_750, fragment_unnamed_762, fragment_unnamed_774), float3(fragment_unnamed_750, fragment_unnamed_762, fragment_unnamed_774)));
				precise float fragment_unnamed_781 = fragment_unnamed_780 * fragment_unnamed_750;
				precise float fragment_unnamed_782 = fragment_unnamed_780 * fragment_unnamed_762;
				precise float fragment_unnamed_783 = fragment_unnamed_780 * fragment_unnamed_774;
				precise float fragment_unnamed_789 = fragment_unnamed_740 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_790 = fragment_unnamed_740 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_791 = fragment_unnamed_740 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_792 = mad(fragment_unnamed_126, fragment_unnamed_132, fragment_unnamed_108);
				float fragment_unnamed_793 = mad(fragment_unnamed_127, fragment_unnamed_132, fragment_unnamed_109);
				float fragment_unnamed_794 = mad(fragment_unnamed_128, fragment_unnamed_132, fragment_unnamed_110);
				float fragment_unnamed_798 = rsqrt(dot(float3(fragment_unnamed_792, fragment_unnamed_793, fragment_unnamed_794), float3(fragment_unnamed_792, fragment_unnamed_793, fragment_unnamed_794)));
				precise float fragment_unnamed_799 = fragment_unnamed_798 * fragment_unnamed_792;
				precise float fragment_unnamed_800 = fragment_unnamed_798 * fragment_unnamed_793;
				precise float fragment_unnamed_801 = fragment_unnamed_798 * fragment_unnamed_794;
				float fragment_unnamed_808 = max(dot(float3(fragment_unnamed_781, fragment_unnamed_782, fragment_unnamed_783), float3(fragment_unnamed_108, fragment_unnamed_109, fragment_unnamed_110)), 0.0f);
				precise float fragment_unnamed_810 = mad(fragment_unnamed_306, fragment_unnamed_557, fragment_uniform_buffer_0[35u].y) * 128.0f;
				precise float fragment_unnamed_813 = log2(max(dot(float3(fragment_unnamed_781, fragment_unnamed_782, fragment_unnamed_783), float3(fragment_unnamed_799, fragment_unnamed_800, fragment_unnamed_801)), 0.0f)) * fragment_unnamed_810;
				float fragment_unnamed_814 = exp2(fragment_unnamed_813);
				precise float fragment_unnamed_815 = fragment_unnamed_334 * fragment_unnamed_789;
				precise float fragment_unnamed_816 = fragment_unnamed_335 * fragment_unnamed_790;
				precise float fragment_unnamed_817 = fragment_unnamed_336 * fragment_unnamed_791;
				precise float fragment_unnamed_823 = fragment_unnamed_789 * fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_824 = fragment_unnamed_790 * fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_825 = fragment_unnamed_791 * fragment_uniform_buffer_0[3u].z;
				precise float fragment_unnamed_826 = fragment_unnamed_814 * fragment_unnamed_823;
				precise float fragment_unnamed_827 = fragment_unnamed_814 * fragment_unnamed_824;
				precise float fragment_unnamed_828 = fragment_unnamed_814 * fragment_unnamed_825;
				fragment_output_0.x = mad(fragment_unnamed_815, fragment_unnamed_808, fragment_unnamed_826);
				fragment_output_0.y = mad(fragment_unnamed_816, fragment_unnamed_808, fragment_unnamed_827);
				fragment_output_0.z = mad(fragment_unnamed_817, fragment_unnamed_808, fragment_unnamed_828);
				fragment_output_0.w = fragment_unnamed_331;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[3] = float4(_SpecColor[0], _SpecColor[1], _SpecColor[2], _SpecColor[3]);

				fragment_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				fragment_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				fragment_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				fragment_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_uniform_buffer_0[8] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _FaceUVSpeedY, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[9] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], _OutlineSoftness, fragment_uniform_buffer_0[10][2], fragment_uniform_buffer_0[10][3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], fragment_uniform_buffer_0[10][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[10][3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], fragment_uniform_buffer_0[10][1], fragment_uniform_buffer_0[10][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[11] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[12] = float4(_OutlineWidth, fragment_uniform_buffer_0[12][1], fragment_uniform_buffer_0[12][2], fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], _Bevel, fragment_uniform_buffer_0[12][2], fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], fragment_uniform_buffer_0[12][1], _BevelOffset, fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], fragment_uniform_buffer_0[12][1], fragment_uniform_buffer_0[12][2], _BevelWidth);

				fragment_uniform_buffer_0[13] = float4(_BevelClamp, fragment_uniform_buffer_0[13][1], fragment_uniform_buffer_0[13][2], fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], _BevelRoundness, fragment_uniform_buffer_0[13][2], fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], fragment_uniform_buffer_0[13][1], _BumpOutline, fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], fragment_uniform_buffer_0[13][1], fragment_uniform_buffer_0[13][2], _BumpFace);

				fragment_uniform_buffer_0[28] = float4(_ShaderFlags, fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], fragment_uniform_buffer_0[28][3]);

				fragment_uniform_buffer_0[28] = float4(fragment_uniform_buffer_0[28][0], fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], _ScaleRatioA);

				fragment_uniform_buffer_0[33] = float4(fragment_uniform_buffer_0[33][0], fragment_uniform_buffer_0[33][1], _TextureWidth, fragment_uniform_buffer_0[33][3]);

				fragment_uniform_buffer_0[33] = float4(fragment_uniform_buffer_0[33][0], fragment_uniform_buffer_0[33][1], fragment_uniform_buffer_0[33][2], _TextureHeight);

				fragment_uniform_buffer_0[34] = float4(_GradientScale, fragment_uniform_buffer_0[34][1], fragment_uniform_buffer_0[34][2], fragment_uniform_buffer_0[34][3]);

				fragment_uniform_buffer_0[35] = float4(fragment_uniform_buffer_0[35][0], _FaceShininess, fragment_uniform_buffer_0[35][2], fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_0[35] = float4(fragment_uniform_buffer_0[35][0], fragment_uniform_buffer_0[35][1], _OutlineShininess, fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

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
				fragment_input_9 = stage_input.fragment_input_9;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(SPOT) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE)


			#if defined(POINT_COOKIE) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(DIRECTIONAL_COOKIE)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToLight;
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
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[39];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[10];
			static float4 vertex_uniform_buffer_3[21];
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
			static float3 vertex_output_3;
			static float3 vertex_output_4;
			static float3 vertex_output_5;
			static float3 vertex_output_6;
			static float4 vertex_output_7;
			static float3 vertex_output_8;
			static float3 vertex_output_9;

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
				float2 vertex_output_2 : TEXCOORD6; // TEXCOORD_6
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float3 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float3 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float3 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_7 : COLOR; // COLOR
				float3 vertex_output_8 : TEXCOORD7; // TEXCOORD_7
				float3 vertex_output_9 : TEXCOORD8; // TEXCOORD_8
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_67 = vertex_input_0.x + vertex_uniform_buffer_0[29u].z;
				precise float vertex_unnamed_68 = vertex_input_0.y + vertex_uniform_buffer_0[29u].w;
				precise float vertex_unnamed_75 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_76 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_77 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_78 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_99 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_67, vertex_unnamed_75));
				float vertex_unnamed_100 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_67, vertex_unnamed_76));
				float vertex_unnamed_101 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_67, vertex_unnamed_77));
				float vertex_unnamed_102 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_67, vertex_unnamed_78));
				precise float vertex_unnamed_110 = vertex_unnamed_99 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_111 = vertex_unnamed_100 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_112 = vertex_unnamed_101 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_113 = vertex_unnamed_102 + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_121 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_122 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_123 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_124 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_110, vertex_unnamed_121)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_110, vertex_unnamed_122)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_110, vertex_unnamed_123)));
				gl_Position.w = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_110, vertex_unnamed_124)));
				precise float vertex_unnamed_165 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_167 = floor(vertex_unnamed_165);
				precise float vertex_unnamed_168 = (-0.0f) - vertex_unnamed_167;
				precise float vertex_unnamed_174 = vertex_unnamed_167 * 0.001953125f;
				precise float vertex_unnamed_176 = mad(vertex_unnamed_168, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_1.z = mad(vertex_unnamed_174, vertex_uniform_buffer_0[37u].x, vertex_uniform_buffer_0[37u].z);
				vertex_output_1.w = mad(vertex_unnamed_176, vertex_uniform_buffer_0[37u].y, vertex_uniform_buffer_0[37u].w);
				vertex_output_2.x = mad(vertex_unnamed_174, vertex_uniform_buffer_0[38u].x, vertex_uniform_buffer_0[38u].z);
				vertex_output_2.y = mad(vertex_unnamed_176, vertex_uniform_buffer_0[38u].y, vertex_uniform_buffer_0[38u].w);
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[36u].x, vertex_uniform_buffer_0[36u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[36u].y, vertex_uniform_buffer_0[36u].w);
				precise float vertex_unnamed_223 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_235 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_110, vertex_unnamed_223)));
				precise float vertex_unnamed_244 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_245 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_261 = mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_244) * vertex_uniform_buffer_0[34u].y;
				precise float vertex_unnamed_262 = mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_245) * vertex_uniform_buffer_0[34u].z;
				precise float vertex_unnamed_263 = vertex_unnamed_235 / vertex_unnamed_261;
				precise float vertex_unnamed_264 = vertex_unnamed_235 / vertex_unnamed_262;
				float vertex_unnamed_268 = rsqrt(dot(float2(vertex_unnamed_263, vertex_unnamed_264), float2(vertex_unnamed_263, vertex_unnamed_264)));
				precise float vertex_unnamed_275 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[34u].x;
				precise float vertex_unnamed_280 = vertex_uniform_buffer_0[35u].x + 1.0f;
				precise float vertex_unnamed_282 = vertex_unnamed_280 * vertex_unnamed_275;
				precise float vertex_unnamed_283 = vertex_unnamed_268 * vertex_unnamed_282;
				precise float vertex_unnamed_287 = (-0.0f) - vertex_uniform_buffer_0[34u].w;
				precise float vertex_unnamed_288 = vertex_unnamed_287 + 1.0f;
				precise float vertex_unnamed_289 = vertex_unnamed_288 * vertex_unnamed_283;
				precise float vertex_unnamed_290 = (-0.0f) - vertex_unnamed_289;
				precise float vertex_unnamed_301 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].x;
				precise float vertex_unnamed_302 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].y;
				precise float vertex_unnamed_303 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].z;
				precise float vertex_unnamed_331 = mad(vertex_uniform_buffer_2[6u].x, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].x, vertex_uniform_buffer_1[4u].x, vertex_unnamed_301)) + vertex_uniform_buffer_2[7u].x;
				precise float vertex_unnamed_332 = mad(vertex_uniform_buffer_2[6u].y, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].y, vertex_uniform_buffer_1[4u].x, vertex_unnamed_302)) + vertex_uniform_buffer_2[7u].y;
				precise float vertex_unnamed_333 = mad(vertex_uniform_buffer_2[6u].z, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].z, vertex_uniform_buffer_1[4u].x, vertex_unnamed_303)) + vertex_uniform_buffer_2[7u].z;
				precise float vertex_unnamed_336 = (-0.0f) - vertex_unnamed_67;
				precise float vertex_unnamed_337 = (-0.0f) - vertex_unnamed_68;
				precise float vertex_unnamed_338 = (-0.0f) - vertex_input_0.z;
				precise float vertex_unnamed_339 = vertex_unnamed_336 + vertex_unnamed_331;
				precise float vertex_unnamed_340 = vertex_unnamed_337 + vertex_unnamed_332;
				precise float vertex_unnamed_341 = vertex_unnamed_338 + vertex_unnamed_333;
				float vertex_unnamed_348 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_unnamed_339, vertex_unnamed_340, vertex_unnamed_341));
				float vertex_unnamed_360 = float(int((-((0.0f < vertex_unnamed_348) ? 4294967295u : 0u)) + ((vertex_unnamed_348 < 0.0f) ? 4294967295u : 0u)));
				precise float vertex_unnamed_367 = vertex_unnamed_360 * vertex_input_2.x;
				precise float vertex_unnamed_368 = vertex_unnamed_360 * vertex_input_2.y;
				precise float vertex_unnamed_369 = vertex_unnamed_360 * vertex_input_2.z;
				float vertex_unnamed_375 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_383 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_391 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_397 = rsqrt(dot(float3(vertex_unnamed_391, vertex_unnamed_375, vertex_unnamed_383), float3(vertex_unnamed_391, vertex_unnamed_375, vertex_unnamed_383)));
				precise float vertex_unnamed_398 = vertex_unnamed_397 * vertex_unnamed_391;
				precise float vertex_unnamed_399 = vertex_unnamed_397 * vertex_unnamed_375;
				precise float vertex_unnamed_400 = vertex_unnamed_397 * vertex_unnamed_383;
				float vertex_unnamed_408 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_99);
				float vertex_unnamed_409 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_100);
				float vertex_unnamed_410 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_101);
				float vertex_unnamed_419 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_99);
				float vertex_unnamed_420 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_100);
				float vertex_unnamed_421 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_101);
				float vertex_unnamed_422 = mad(vertex_uniform_buffer_2[3u].w, vertex_input_0.w, vertex_unnamed_102);
				precise float vertex_unnamed_423 = (-0.0f) - vertex_unnamed_408;
				precise float vertex_unnamed_424 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_425 = (-0.0f) - vertex_unnamed_410;
				precise float vertex_unnamed_431 = vertex_unnamed_423 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_432 = vertex_unnamed_424 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_433 = vertex_unnamed_425 + vertex_uniform_buffer_1[4u].z;
				vertex_output_6.x = vertex_unnamed_408;
				vertex_output_6.y = vertex_unnamed_409;
				vertex_output_6.z = vertex_unnamed_410;
				float vertex_unnamed_440 = rsqrt(dot(float3(vertex_unnamed_431, vertex_unnamed_432, vertex_unnamed_433), float3(vertex_unnamed_431, vertex_unnamed_432, vertex_unnamed_433)));
				precise float vertex_unnamed_441 = vertex_unnamed_440 * vertex_unnamed_431;
				precise float vertex_unnamed_442 = vertex_unnamed_440 * vertex_unnamed_432;
				precise float vertex_unnamed_443 = vertex_unnamed_440 * vertex_unnamed_433;
				vertex_output_2.y = mad(abs(dot(float3(vertex_unnamed_399, vertex_unnamed_400, vertex_unnamed_398), float3(vertex_unnamed_441, vertex_unnamed_442, vertex_unnamed_443))), mad(vertex_unnamed_268, vertex_unnamed_282, vertex_unnamed_290), vertex_unnamed_289);
				precise float vertex_unnamed_461 = (-0.0f) - vertex_uniform_buffer_0[28u].y;
				precise float vertex_unnamed_465 = vertex_unnamed_461 + vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_478 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_465, vertex_uniform_buffer_0[28u].y), 0.25f, vertex_uniform_buffer_0[10u].x) * vertex_uniform_buffer_0[28u].w;
				precise float vertex_unnamed_479 = vertex_unnamed_478 * 0.5f;
				vertex_output_2.x = vertex_unnamed_479;
				vertex_output_3.z = vertex_unnamed_399;
				precise float vertex_unnamed_490 = vertex_input_1.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_491 = vertex_input_1.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_492 = vertex_input_1.y * vertex_uniform_buffer_2[1u].x;
				float vertex_unnamed_510 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_1.x, vertex_unnamed_490));
				float vertex_unnamed_511 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_1.x, vertex_unnamed_491));
				float vertex_unnamed_512 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_1.x, vertex_unnamed_492));
				float vertex_unnamed_516 = rsqrt(dot(float3(vertex_unnamed_510, vertex_unnamed_511, vertex_unnamed_512), float3(vertex_unnamed_510, vertex_unnamed_511, vertex_unnamed_512)));
				precise float vertex_unnamed_517 = vertex_unnamed_516 * vertex_unnamed_510;
				precise float vertex_unnamed_518 = vertex_unnamed_516 * vertex_unnamed_511;
				precise float vertex_unnamed_519 = vertex_unnamed_516 * vertex_unnamed_512;
				precise float vertex_unnamed_520 = vertex_unnamed_398 * vertex_unnamed_517;
				precise float vertex_unnamed_521 = vertex_unnamed_399 * vertex_unnamed_518;
				precise float vertex_unnamed_522 = vertex_unnamed_400 * vertex_unnamed_519;
				precise float vertex_unnamed_523 = (-0.0f) - vertex_unnamed_520;
				precise float vertex_unnamed_524 = (-0.0f) - vertex_unnamed_521;
				precise float vertex_unnamed_525 = (-0.0f) - vertex_unnamed_522;
				precise float vertex_unnamed_535 = vertex_input_1.w * vertex_uniform_buffer_2[9u].w;
				precise float vertex_unnamed_536 = vertex_unnamed_535 * mad(vertex_unnamed_400, vertex_unnamed_518, vertex_unnamed_523);
				precise float vertex_unnamed_537 = vertex_unnamed_535 * mad(vertex_unnamed_398, vertex_unnamed_519, vertex_unnamed_524);
				precise float vertex_unnamed_538 = vertex_unnamed_535 * mad(vertex_unnamed_399, vertex_unnamed_517, vertex_unnamed_525);
				vertex_output_3.y = vertex_unnamed_536;
				vertex_output_3.x = vertex_unnamed_519;
				vertex_output_4.z = vertex_unnamed_400;
				vertex_output_5.z = vertex_unnamed_398;
				vertex_output_4.x = vertex_unnamed_517;
				vertex_output_5.x = vertex_unnamed_518;
				vertex_output_4.y = vertex_unnamed_537;
				vertex_output_5.y = vertex_unnamed_538;
				vertex_output_7.x = vertex_input_7.x;
				vertex_output_7.y = vertex_input_7.y;
				vertex_output_7.z = vertex_input_7.z;
				vertex_output_7.w = vertex_input_7.w;
				precise float vertex_unnamed_564 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].x;
				precise float vertex_unnamed_565 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].y;
				precise float vertex_unnamed_566 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].z;
				vertex_output_8.x = mad(vertex_uniform_buffer_0[19u].x, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].x, vertex_unnamed_431, vertex_unnamed_564));
				vertex_output_8.y = mad(vertex_uniform_buffer_0[19u].y, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].y, vertex_unnamed_431, vertex_unnamed_565));
				vertex_output_8.z = mad(vertex_uniform_buffer_0[19u].z, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].z, vertex_unnamed_431, vertex_unnamed_566));
				precise float vertex_unnamed_591 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_592 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].y;
				precise float vertex_unnamed_593 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].z;
				vertex_output_9.x = mad(vertex_uniform_buffer_0[7u].x, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].x, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].x, vertex_unnamed_419, vertex_unnamed_591)));
				vertex_output_9.y = mad(vertex_uniform_buffer_0[7u].y, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].y, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].y, vertex_unnamed_419, vertex_unnamed_592)));
				vertex_output_9.z = mad(vertex_uniform_buffer_0[7u].z, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].z, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].z, vertex_unnamed_419, vertex_unnamed_593)));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				vertex_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				vertex_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				vertex_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				vertex_uniform_buffer_0[10] = float4(_FaceDilate, vertex_uniform_buffer_0[10][1], vertex_uniform_buffer_0[10][2], vertex_uniform_buffer_0[10][3]);

				vertex_uniform_buffer_0[17] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				vertex_uniform_buffer_0[18] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				vertex_uniform_buffer_0[19] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				vertex_uniform_buffer_0[20] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], _WeightNormal, vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], _WeightBold, vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], _ScaleRatioA);

				vertex_uniform_buffer_0[29] = float4(vertex_uniform_buffer_0[29][0], vertex_uniform_buffer_0[29][1], _VertexOffsetX, vertex_uniform_buffer_0[29][3]);

				vertex_uniform_buffer_0[29] = float4(vertex_uniform_buffer_0[29][0], vertex_uniform_buffer_0[29][1], vertex_uniform_buffer_0[29][2], _VertexOffsetY);

				vertex_uniform_buffer_0[34] = float4(_GradientScale, vertex_uniform_buffer_0[34][1], vertex_uniform_buffer_0[34][2], vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], _ScaleX, vertex_uniform_buffer_0[34][2], vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], vertex_uniform_buffer_0[34][1], _ScaleY, vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], vertex_uniform_buffer_0[34][1], vertex_uniform_buffer_0[34][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[35] = float4(_Sharpness, vertex_uniform_buffer_0[35][1], vertex_uniform_buffer_0[35][2], vertex_uniform_buffer_0[35][3]);

				vertex_uniform_buffer_0[36] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_0[37] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[38] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

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

				vertex_uniform_buffer_2[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

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
				stage_output.vertex_output_9 = vertex_output_9;
				return stage_output;
			}


			float4 _LightColor0;
			float4 _SpecColor;
			float4x4 unity_WorldToLight;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;
			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_OcclusionMaskSelector;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[36];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			Texture2D<float4> _BumpMap;
			Texture2D<float4> _LightTextureB0;
			TextureCube<float4> _LightTexture0;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_LightTexture0;
			SamplerState sampler_LightTextureB0;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_BumpMap;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_input_7;
			static float3 fragment_input_8;
			static float3 fragment_input_9;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float2 fragment_input_2 : TEXCOORD6; // TEXCOORD_6
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float3 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
				float3 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
				float3 fragment_input_6 : TEXCOORD5; // TEXCOORD_5
				float4 fragment_input_7 : COLOR; // COLOR
				float3 fragment_input_8 : TEXCOORD7; // TEXCOORD_7
				float3 fragment_input_9 : TEXCOORD8; // TEXCOORD_8
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_86 = (-0.0f) - fragment_input_6.x;
				precise float fragment_unnamed_91 = (-0.0f) - fragment_input_6.y;
				precise float fragment_unnamed_95 = (-0.0f) - fragment_input_6.z;
				precise float fragment_unnamed_102 = fragment_unnamed_86 + fragment_uniform_buffer_2[0u].x;
				precise float fragment_unnamed_103 = fragment_unnamed_91 + fragment_uniform_buffer_2[0u].y;
				precise float fragment_unnamed_104 = fragment_unnamed_95 + fragment_uniform_buffer_2[0u].z;
				float fragment_unnamed_109 = rsqrt(dot(float3(fragment_unnamed_102, fragment_unnamed_103, fragment_unnamed_104), float3(fragment_unnamed_102, fragment_unnamed_103, fragment_unnamed_104)));
				precise float fragment_unnamed_110 = fragment_unnamed_109 * fragment_unnamed_102;
				precise float fragment_unnamed_111 = fragment_unnamed_109 * fragment_unnamed_103;
				precise float fragment_unnamed_112 = fragment_unnamed_109 * fragment_unnamed_104;
				precise float fragment_unnamed_115 = (-0.0f) - fragment_input_6.x;
				precise float fragment_unnamed_118 = (-0.0f) - fragment_input_6.y;
				precise float fragment_unnamed_121 = (-0.0f) - fragment_input_6.z;
				precise float fragment_unnamed_128 = fragment_unnamed_115 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_129 = fragment_unnamed_118 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_130 = fragment_unnamed_121 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_134 = rsqrt(dot(float3(fragment_unnamed_128, fragment_unnamed_129, fragment_unnamed_130), float3(fragment_unnamed_128, fragment_unnamed_129, fragment_unnamed_130)));
				precise float fragment_unnamed_140 = 1.0f / fragment_uniform_buffer_0[33u].z;
				precise float fragment_unnamed_142 = 1.0f / fragment_uniform_buffer_0[33u].w;
				float fragment_unnamed_143 = asfloat(0u);
				precise float fragment_unnamed_144 = (-0.0f) - fragment_unnamed_140;
				precise float fragment_unnamed_145 = (-0.0f) - fragment_unnamed_143;
				precise float fragment_unnamed_146 = (-0.0f) - fragment_unnamed_142;
				precise float fragment_unnamed_151 = fragment_unnamed_144 + fragment_input_1.x;
				precise float fragment_unnamed_152 = fragment_unnamed_145 + fragment_input_1.y;
				precise float fragment_unnamed_153 = fragment_unnamed_145 + fragment_input_1.x;
				precise float fragment_unnamed_154 = fragment_unnamed_146 + fragment_input_1.y;
				precise float fragment_unnamed_165 = fragment_unnamed_140 + fragment_input_1.x;
				precise float fragment_unnamed_166 = fragment_unnamed_143 + fragment_input_1.y;
				precise float fragment_unnamed_167 = fragment_unnamed_143 + fragment_input_1.x;
				precise float fragment_unnamed_168 = fragment_unnamed_142 + fragment_input_1.y;
				precise float fragment_unnamed_185 = (-0.0f) - _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
				precise float fragment_unnamed_186 = fragment_unnamed_185 + 0.5f;
				precise float fragment_unnamed_190 = (-0.0f) - fragment_input_2.x;
				precise float fragment_unnamed_191 = fragment_unnamed_186 + fragment_unnamed_190;
				float fragment_unnamed_194 = mad(fragment_unnamed_191, fragment_input_2.y, 0.5f);
				precise float fragment_unnamed_203 = fragment_uniform_buffer_0[12u].x * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_211 = fragment_uniform_buffer_0[10u].y * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_214 = fragment_unnamed_203 * fragment_input_2.y;
				precise float fragment_unnamed_215 = fragment_unnamed_211 * fragment_input_2.y;
				precise float fragment_unnamed_232 = fragment_input_7.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_233 = fragment_input_7.y * fragment_uniform_buffer_0[9u].y;
				precise float fragment_unnamed_234 = fragment_input_7.z * fragment_uniform_buffer_0[9u].z;
				precise float fragment_unnamed_235 = fragment_input_7.w * fragment_uniform_buffer_0[9u].w;
				precise float fragment_unnamed_242 = fragment_input_7.w * fragment_uniform_buffer_0[11u].w;
				float4 fragment_unnamed_258 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[8u].x, fragment_uniform_buffer_1[0u].y, fragment_input_1.z), mad(fragment_uniform_buffer_0[8u].y, fragment_uniform_buffer_1[0u].y, fragment_input_1.w)));
				precise float fragment_unnamed_264 = fragment_unnamed_232 * fragment_unnamed_258.x;
				precise float fragment_unnamed_265 = fragment_unnamed_233 * fragment_unnamed_258.y;
				precise float fragment_unnamed_266 = fragment_unnamed_234 * fragment_unnamed_258.z;
				precise float fragment_unnamed_267 = fragment_unnamed_235 * fragment_unnamed_258.w;
				float4 fragment_unnamed_282 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[10u].z, fragment_uniform_buffer_1[0u].y, fragment_input_2.x), mad(fragment_uniform_buffer_0[10u].w, fragment_uniform_buffer_1[0u].y, fragment_input_2.y)));
				precise float fragment_unnamed_293 = fragment_unnamed_282.x * fragment_uniform_buffer_0[11u].x;
				precise float fragment_unnamed_294 = fragment_unnamed_282.y * fragment_uniform_buffer_0[11u].y;
				precise float fragment_unnamed_295 = fragment_unnamed_282.z * fragment_uniform_buffer_0[11u].z;
				precise float fragment_unnamed_296 = fragment_unnamed_242 * fragment_unnamed_282.w;
				precise float fragment_unnamed_297 = (-0.0f) - fragment_unnamed_214;
				precise float fragment_unnamed_303 = mad(fragment_unnamed_215, 0.5f, mad(fragment_unnamed_297, 0.5f, fragment_unnamed_194)) / mad(fragment_unnamed_211, fragment_input_2.y, 1.0f);
				precise float fragment_unnamed_305 = (-0.0f) - clamp(fragment_unnamed_303, 0.0f, 1.0f);
				precise float fragment_unnamed_306 = fragment_unnamed_305 + 1.0f;
				float fragment_unnamed_308 = clamp(mad(fragment_unnamed_214, 0.5f, fragment_unnamed_194), 0.0f, 1.0f);
				precise float fragment_unnamed_311 = fragment_unnamed_308 * sqrt(min(fragment_unnamed_214, 1.0f));
				precise float fragment_unnamed_312 = fragment_unnamed_267 * fragment_unnamed_264;
				precise float fragment_unnamed_313 = fragment_unnamed_267 * fragment_unnamed_265;
				precise float fragment_unnamed_314 = fragment_unnamed_267 * fragment_unnamed_266;
				precise float fragment_unnamed_315 = fragment_unnamed_293 * fragment_unnamed_296;
				precise float fragment_unnamed_316 = fragment_unnamed_294 * fragment_unnamed_296;
				precise float fragment_unnamed_317 = fragment_unnamed_295 * fragment_unnamed_296;
				precise float fragment_unnamed_318 = (-0.0f) - fragment_unnamed_312;
				precise float fragment_unnamed_319 = (-0.0f) - fragment_unnamed_313;
				precise float fragment_unnamed_320 = (-0.0f) - fragment_unnamed_314;
				precise float fragment_unnamed_321 = (-0.0f) - fragment_unnamed_267;
				precise float fragment_unnamed_322 = fragment_unnamed_318 + fragment_unnamed_315;
				precise float fragment_unnamed_323 = fragment_unnamed_319 + fragment_unnamed_316;
				precise float fragment_unnamed_324 = fragment_unnamed_320 + fragment_unnamed_317;
				precise float fragment_unnamed_325 = fragment_unnamed_321 + fragment_unnamed_296;
				precise float fragment_unnamed_330 = fragment_unnamed_306 * mad(fragment_unnamed_311, fragment_unnamed_322, fragment_unnamed_312);
				precise float fragment_unnamed_331 = fragment_unnamed_306 * mad(fragment_unnamed_311, fragment_unnamed_323, fragment_unnamed_313);
				precise float fragment_unnamed_332 = fragment_unnamed_306 * mad(fragment_unnamed_311, fragment_unnamed_324, fragment_unnamed_314);
				precise float fragment_unnamed_333 = fragment_unnamed_306 * mad(fragment_unnamed_311, fragment_unnamed_325, fragment_unnamed_267);
				float fragment_unnamed_334 = max(fragment_unnamed_333, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_336 = fragment_unnamed_330 / fragment_unnamed_334;
				precise float fragment_unnamed_337 = fragment_unnamed_331 / fragment_unnamed_334;
				precise float fragment_unnamed_338 = fragment_unnamed_332 / fragment_unnamed_334;
				precise float fragment_unnamed_342 = fragment_uniform_buffer_0[28u].x * 0.5f;
				precise float fragment_unnamed_343 = (-0.0f) - fragment_unnamed_342;
				float fragment_unnamed_347 = frac(abs(fragment_unnamed_342));
				precise float fragment_unnamed_348 = (-0.0f) - fragment_unnamed_347;
				bool fragment_unnamed_350 = ((fragment_unnamed_342 >= fragment_unnamed_343) ? fragment_unnamed_347 : fragment_unnamed_348) >= 0.5f;
				precise float fragment_unnamed_356 = fragment_input_2.x + fragment_uniform_buffer_0[12u].z;
				precise float fragment_unnamed_357 = fragment_unnamed_356 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_151, fragment_unnamed_152)).w;
				precise float fragment_unnamed_358 = fragment_unnamed_356 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_165, fragment_unnamed_166)).w;
				precise float fragment_unnamed_359 = fragment_unnamed_356 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_153, fragment_unnamed_154)).w;
				precise float fragment_unnamed_360 = fragment_unnamed_356 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_167, fragment_unnamed_168)).w;
				precise float fragment_unnamed_367 = fragment_uniform_buffer_0[12u].w + fragment_uniform_buffer_0[12u].x;
				float fragment_unnamed_368 = max(fragment_unnamed_367, 0.00999999977648258209228515625f);
				precise float fragment_unnamed_370 = fragment_unnamed_357 + (-0.5f);
				precise float fragment_unnamed_372 = fragment_unnamed_358 + (-0.5f);
				precise float fragment_unnamed_373 = fragment_unnamed_359 + (-0.5f);
				precise float fragment_unnamed_374 = fragment_unnamed_360 + (-0.5f);
				precise float fragment_unnamed_375 = fragment_unnamed_370 / fragment_unnamed_368;
				precise float fragment_unnamed_376 = fragment_unnamed_372 / fragment_unnamed_368;
				precise float fragment_unnamed_377 = fragment_unnamed_373 / fragment_unnamed_368;
				precise float fragment_unnamed_378 = fragment_unnamed_374 / fragment_unnamed_368;
				precise float fragment_unnamed_379 = fragment_unnamed_375 + 0.5f;
				precise float fragment_unnamed_380 = fragment_unnamed_376 + 0.5f;
				precise float fragment_unnamed_381 = fragment_unnamed_377 + 0.5f;
				precise float fragment_unnamed_382 = fragment_unnamed_378 + 0.5f;
				float fragment_unnamed_383 = clamp(fragment_unnamed_379, 0.0f, 1.0f);
				float fragment_unnamed_384 = clamp(fragment_unnamed_380, 0.0f, 1.0f);
				float fragment_unnamed_385 = clamp(fragment_unnamed_381, 0.0f, 1.0f);
				float fragment_unnamed_386 = clamp(fragment_unnamed_382, 0.0f, 1.0f);
				precise float fragment_unnamed_394 = (-0.0f) - abs(mad(fragment_unnamed_383, 2.0f, -1.0f));
				precise float fragment_unnamed_396 = (-0.0f) - abs(mad(fragment_unnamed_384, 2.0f, -1.0f));
				precise float fragment_unnamed_398 = (-0.0f) - abs(mad(fragment_unnamed_385, 2.0f, -1.0f));
				precise float fragment_unnamed_400 = (-0.0f) - abs(mad(fragment_unnamed_386, 2.0f, -1.0f));
				precise float fragment_unnamed_401 = fragment_unnamed_394 + 1.0f;
				precise float fragment_unnamed_402 = fragment_unnamed_396 + 1.0f;
				precise float fragment_unnamed_403 = fragment_unnamed_398 + 1.0f;
				precise float fragment_unnamed_404 = fragment_unnamed_400 + 1.0f;
				float fragment_unnamed_414 = asfloat(fragment_unnamed_350 ? asuint(fragment_unnamed_401) : asuint(fragment_unnamed_383));
				float fragment_unnamed_416 = asfloat(fragment_unnamed_350 ? asuint(fragment_unnamed_402) : asuint(fragment_unnamed_384));
				float fragment_unnamed_418 = asfloat(fragment_unnamed_350 ? asuint(fragment_unnamed_403) : asuint(fragment_unnamed_385));
				float fragment_unnamed_420 = asfloat(fragment_unnamed_350 ? asuint(fragment_unnamed_404) : asuint(fragment_unnamed_386));
				precise float fragment_unnamed_421 = fragment_unnamed_414 * 1.57079601287841796875f;
				precise float fragment_unnamed_423 = fragment_unnamed_416 * 1.57079601287841796875f;
				precise float fragment_unnamed_424 = fragment_unnamed_418 * 1.57079601287841796875f;
				precise float fragment_unnamed_425 = fragment_unnamed_420 * 1.57079601287841796875f;
				precise float fragment_unnamed_430 = (-0.0f) - fragment_unnamed_414;
				precise float fragment_unnamed_431 = (-0.0f) - fragment_unnamed_416;
				precise float fragment_unnamed_432 = (-0.0f) - fragment_unnamed_418;
				precise float fragment_unnamed_433 = (-0.0f) - fragment_unnamed_420;
				precise float fragment_unnamed_434 = fragment_unnamed_430 + sin(fragment_unnamed_421);
				precise float fragment_unnamed_435 = fragment_unnamed_431 + sin(fragment_unnamed_423);
				precise float fragment_unnamed_436 = fragment_unnamed_432 + sin(fragment_unnamed_424);
				precise float fragment_unnamed_437 = fragment_unnamed_433 + sin(fragment_unnamed_425);
				precise float fragment_unnamed_449 = (-0.0f) - fragment_uniform_buffer_0[13u].x;
				precise float fragment_unnamed_450 = fragment_unnamed_449 + 1.0f;
				precise float fragment_unnamed_458 = fragment_unnamed_368 * fragment_uniform_buffer_0[12u].y;
				precise float fragment_unnamed_463 = fragment_unnamed_458 * fragment_uniform_buffer_0[34u].x;
				precise float fragment_unnamed_464 = fragment_unnamed_463 * (-2.0f);
				precise float fragment_unnamed_466 = min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_434, fragment_unnamed_414), fragment_unnamed_450) * fragment_unnamed_464;
				precise float fragment_unnamed_467 = min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_436, fragment_unnamed_418), fragment_unnamed_450) * fragment_unnamed_464;
				precise float fragment_unnamed_468 = (-0.0f) - fragment_unnamed_467;
				precise float fragment_unnamed_469 = (-0.0f) - fragment_unnamed_466;
				float fragment_unnamed_470 = mad(min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_437, fragment_unnamed_420), fragment_unnamed_450), fragment_unnamed_464, fragment_unnamed_468);
				float fragment_unnamed_471 = mad(min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_435, fragment_unnamed_416), fragment_unnamed_450), fragment_unnamed_464, fragment_unnamed_469);
				float fragment_unnamed_472 = asfloat(3212836864u);
				float fragment_unnamed_474 = asfloat(1065353216u);
				float fragment_unnamed_479 = rsqrt(dot(float2(fragment_unnamed_471, fragment_unnamed_474), float2(fragment_unnamed_471, fragment_unnamed_474)));
				precise float fragment_unnamed_480 = fragment_unnamed_479 * 1.0f;
				precise float fragment_unnamed_481 = fragment_unnamed_479 * 0.0f;
				precise float fragment_unnamed_482 = fragment_unnamed_479 * fragment_unnamed_471;
				float fragment_unnamed_486 = rsqrt(dot(float2(fragment_unnamed_472, fragment_unnamed_470), float2(fragment_unnamed_472, fragment_unnamed_470)));
				precise float fragment_unnamed_488 = fragment_unnamed_486 * fragment_unnamed_472;
				precise float fragment_unnamed_489 = fragment_unnamed_486 * fragment_unnamed_470;
				precise float fragment_unnamed_490 = fragment_unnamed_486 * asfloat(0u);
				precise float fragment_unnamed_491 = fragment_unnamed_488 * fragment_unnamed_482;
				precise float fragment_unnamed_492 = fragment_unnamed_489 * fragment_unnamed_480;
				precise float fragment_unnamed_493 = fragment_unnamed_490 * fragment_unnamed_481;
				precise float fragment_unnamed_494 = (-0.0f) - fragment_unnamed_491;
				precise float fragment_unnamed_495 = (-0.0f) - fragment_unnamed_492;
				precise float fragment_unnamed_496 = (-0.0f) - fragment_unnamed_493;
				float4 fragment_unnamed_505 = _BumpMap.Sample(sampler_BumpMap, float2(fragment_input_1.z, fragment_input_1.w));
				precise float fragment_unnamed_510 = fragment_unnamed_505.w * fragment_unnamed_505.x;
				float fragment_unnamed_511 = mad(fragment_unnamed_510, 2.0f, -1.0f);
				float fragment_unnamed_512 = mad(fragment_unnamed_505.y, 2.0f, -1.0f);
				precise float fragment_unnamed_517 = (-0.0f) - min(dot(float2(fragment_unnamed_511, fragment_unnamed_512), float2(fragment_unnamed_511, fragment_unnamed_512)), 1.0f);
				precise float fragment_unnamed_518 = fragment_unnamed_517 + 1.0f;
				precise float fragment_unnamed_523 = (-0.0f) - fragment_uniform_buffer_0[13u].w;
				precise float fragment_unnamed_527 = fragment_unnamed_523 + fragment_uniform_buffer_0[13u].z;
				float fragment_unnamed_531 = mad(fragment_unnamed_308, fragment_unnamed_527, fragment_uniform_buffer_0[13u].w);
				precise float fragment_unnamed_538 = (-0.0f) - mad(fragment_unnamed_333, mad(fragment_unnamed_511, fragment_unnamed_531, -0.0f), 0.0f);
				precise float fragment_unnamed_539 = (-0.0f) - mad(fragment_unnamed_333, mad(fragment_unnamed_512, fragment_unnamed_531, -0.0f), 0.0f);
				precise float fragment_unnamed_540 = (-0.0f) - mad(fragment_unnamed_333, mad(sqrt(fragment_unnamed_518), fragment_unnamed_531, -1.0f), 1.0f);
				precise float fragment_unnamed_541 = mad(fragment_unnamed_481, fragment_unnamed_489, fragment_unnamed_494) + fragment_unnamed_538;
				precise float fragment_unnamed_542 = mad(fragment_unnamed_482, fragment_unnamed_490, fragment_unnamed_495) + fragment_unnamed_539;
				precise float fragment_unnamed_543 = mad(fragment_unnamed_480, fragment_unnamed_488, fragment_unnamed_496) + fragment_unnamed_540;
				float fragment_unnamed_547 = rsqrt(dot(float3(fragment_unnamed_541, fragment_unnamed_542, fragment_unnamed_543), float3(fragment_unnamed_541, fragment_unnamed_542, fragment_unnamed_543)));
				precise float fragment_unnamed_548 = fragment_unnamed_547 * fragment_unnamed_541;
				precise float fragment_unnamed_549 = fragment_unnamed_547 * fragment_unnamed_542;
				precise float fragment_unnamed_550 = fragment_unnamed_547 * fragment_unnamed_543;
				precise float fragment_unnamed_555 = (-0.0f) - fragment_uniform_buffer_0[35u].y;
				precise float fragment_unnamed_559 = fragment_unnamed_555 + fragment_uniform_buffer_0[35u].z;
				precise float fragment_unnamed_571 = fragment_input_6.y * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_572 = fragment_input_6.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_573 = fragment_input_6.y * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_600 = mad(fragment_uniform_buffer_0[6u].x, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].x, fragment_input_6.x, fragment_unnamed_571)) + fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_601 = mad(fragment_uniform_buffer_0[6u].y, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].y, fragment_input_6.x, fragment_unnamed_572)) + fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_602 = mad(fragment_uniform_buffer_0[6u].z, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].z, fragment_input_6.x, fragment_unnamed_573)) + fragment_uniform_buffer_0[7u].z;
				float fragment_unnamed_697;
				float fragment_unnamed_698;
				float fragment_unnamed_699;
				float fragment_unnamed_700;
				if (fragment_uniform_buffer_3[0u].x == 1.0f)
				{
					bool fragment_unnamed_610 = fragment_uniform_buffer_3[0u].y == 1.0f;
					precise float fragment_unnamed_618 = fragment_input_6.y * fragment_uniform_buffer_3[2u].x;
					precise float fragment_unnamed_619 = fragment_input_6.y * fragment_uniform_buffer_3[2u].y;
					precise float fragment_unnamed_620 = fragment_input_6.y * fragment_uniform_buffer_3[2u].z;
					precise float fragment_unnamed_646 = mad(fragment_uniform_buffer_3[3u].x, fragment_input_6.z, mad(fragment_uniform_buffer_3[1u].x, fragment_input_6.x, fragment_unnamed_618)) + fragment_uniform_buffer_3[4u].x;
					precise float fragment_unnamed_647 = mad(fragment_uniform_buffer_3[3u].y, fragment_input_6.z, mad(fragment_uniform_buffer_3[1u].y, fragment_input_6.x, fragment_unnamed_619)) + fragment_uniform_buffer_3[4u].y;
					precise float fragment_unnamed_648 = mad(fragment_uniform_buffer_3[3u].z, fragment_input_6.z, mad(fragment_uniform_buffer_3[1u].z, fragment_input_6.x, fragment_unnamed_620)) + fragment_uniform_buffer_3[4u].z;
					precise float fragment_unnamed_661 = (-0.0f) - fragment_uniform_buffer_3[6u].x;
					precise float fragment_unnamed_663 = (-0.0f) - fragment_uniform_buffer_3[6u].y;
					precise float fragment_unnamed_665 = (-0.0f) - fragment_uniform_buffer_3[6u].z;
					precise float fragment_unnamed_666 = (fragment_unnamed_610 ? fragment_unnamed_646 : fragment_input_6.x) + fragment_unnamed_661;
					precise float fragment_unnamed_667 = (fragment_unnamed_610 ? fragment_unnamed_647 : fragment_input_6.y) + fragment_unnamed_663;
					precise float fragment_unnamed_668 = (fragment_unnamed_610 ? fragment_unnamed_648 : fragment_input_6.z) + fragment_unnamed_665;
					precise float fragment_unnamed_674 = fragment_unnamed_666 * fragment_uniform_buffer_3[5u].x;
					precise float fragment_unnamed_675 = fragment_unnamed_667 * fragment_uniform_buffer_3[5u].y;
					precise float fragment_unnamed_676 = fragment_unnamed_668 * fragment_uniform_buffer_3[5u].z;
					float4 fragment_unnamed_687 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_674, 0.25f, 0.75f), mad(fragment_uniform_buffer_3[0u].z, 0.5f, 0.75f)), fragment_unnamed_675, fragment_unnamed_676));
					fragment_unnamed_697 = fragment_unnamed_687.x;
					fragment_unnamed_698 = fragment_unnamed_687.y;
					fragment_unnamed_699 = fragment_unnamed_687.z;
					fragment_unnamed_700 = fragment_unnamed_687.w;
				}
				else
				{
					fragment_unnamed_697 = asfloat(1065353216u);
					fragment_unnamed_698 = asfloat(1065353216u);
					fragment_unnamed_699 = asfloat(1065353216u);
					fragment_unnamed_700 = asfloat(1065353216u);
				}
				precise float fragment_unnamed_724 = _LightTexture0.Sample(sampler_LightTexture0, float3(fragment_unnamed_600, fragment_unnamed_601, fragment_unnamed_602)).w * _LightTextureB0.Sample(sampler_LightTextureB0, dot(float3(fragment_unnamed_600, fragment_unnamed_601, fragment_unnamed_602), float3(fragment_unnamed_600, fragment_unnamed_601, fragment_unnamed_602)).xx).x;
				precise float fragment_unnamed_725 = clamp(dot(float4(fragment_unnamed_697, fragment_unnamed_698, fragment_unnamed_699, fragment_unnamed_700), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f) * fragment_unnamed_724;
				precise float fragment_unnamed_732 = (-0.0f) - fragment_unnamed_548;
				precise float fragment_unnamed_733 = (-0.0f) - fragment_unnamed_549;
				precise float fragment_unnamed_734 = (-0.0f) - fragment_unnamed_550;
				float fragment_unnamed_735 = dot(float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z), float3(fragment_unnamed_732, fragment_unnamed_733, fragment_unnamed_734));
				precise float fragment_unnamed_744 = (-0.0f) - fragment_unnamed_548;
				precise float fragment_unnamed_745 = (-0.0f) - fragment_unnamed_549;
				precise float fragment_unnamed_746 = (-0.0f) - fragment_unnamed_550;
				float fragment_unnamed_747 = dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_unnamed_744, fragment_unnamed_745, fragment_unnamed_746));
				precise float fragment_unnamed_756 = (-0.0f) - fragment_unnamed_548;
				precise float fragment_unnamed_757 = (-0.0f) - fragment_unnamed_549;
				precise float fragment_unnamed_758 = (-0.0f) - fragment_unnamed_550;
				float fragment_unnamed_759 = dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_unnamed_756, fragment_unnamed_757, fragment_unnamed_758));
				float fragment_unnamed_765 = rsqrt(dot(float3(fragment_unnamed_735, fragment_unnamed_747, fragment_unnamed_759), float3(fragment_unnamed_735, fragment_unnamed_747, fragment_unnamed_759)));
				precise float fragment_unnamed_766 = fragment_unnamed_765 * fragment_unnamed_735;
				precise float fragment_unnamed_767 = fragment_unnamed_765 * fragment_unnamed_747;
				precise float fragment_unnamed_768 = fragment_unnamed_765 * fragment_unnamed_759;
				precise float fragment_unnamed_774 = fragment_unnamed_725 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_775 = fragment_unnamed_725 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_776 = fragment_unnamed_725 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_777 = mad(fragment_unnamed_128, fragment_unnamed_134, fragment_unnamed_110);
				float fragment_unnamed_778 = mad(fragment_unnamed_129, fragment_unnamed_134, fragment_unnamed_111);
				float fragment_unnamed_779 = mad(fragment_unnamed_130, fragment_unnamed_134, fragment_unnamed_112);
				float fragment_unnamed_783 = rsqrt(dot(float3(fragment_unnamed_777, fragment_unnamed_778, fragment_unnamed_779), float3(fragment_unnamed_777, fragment_unnamed_778, fragment_unnamed_779)));
				precise float fragment_unnamed_784 = fragment_unnamed_783 * fragment_unnamed_777;
				precise float fragment_unnamed_785 = fragment_unnamed_783 * fragment_unnamed_778;
				precise float fragment_unnamed_786 = fragment_unnamed_783 * fragment_unnamed_779;
				float fragment_unnamed_793 = max(dot(float3(fragment_unnamed_766, fragment_unnamed_767, fragment_unnamed_768), float3(fragment_unnamed_110, fragment_unnamed_111, fragment_unnamed_112)), 0.0f);
				precise float fragment_unnamed_795 = mad(fragment_unnamed_308, fragment_unnamed_559, fragment_uniform_buffer_0[35u].y) * 128.0f;
				precise float fragment_unnamed_798 = log2(max(dot(float3(fragment_unnamed_766, fragment_unnamed_767, fragment_unnamed_768), float3(fragment_unnamed_784, fragment_unnamed_785, fragment_unnamed_786)), 0.0f)) * fragment_unnamed_795;
				float fragment_unnamed_799 = exp2(fragment_unnamed_798);
				precise float fragment_unnamed_800 = fragment_unnamed_336 * fragment_unnamed_774;
				precise float fragment_unnamed_801 = fragment_unnamed_337 * fragment_unnamed_775;
				precise float fragment_unnamed_802 = fragment_unnamed_338 * fragment_unnamed_776;
				precise float fragment_unnamed_808 = fragment_unnamed_774 * fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_809 = fragment_unnamed_775 * fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_810 = fragment_unnamed_776 * fragment_uniform_buffer_0[3u].z;
				precise float fragment_unnamed_811 = fragment_unnamed_799 * fragment_unnamed_808;
				precise float fragment_unnamed_812 = fragment_unnamed_799 * fragment_unnamed_809;
				precise float fragment_unnamed_813 = fragment_unnamed_799 * fragment_unnamed_810;
				fragment_output_0.x = mad(fragment_unnamed_800, fragment_unnamed_793, fragment_unnamed_811);
				fragment_output_0.y = mad(fragment_unnamed_801, fragment_unnamed_793, fragment_unnamed_812);
				fragment_output_0.z = mad(fragment_unnamed_802, fragment_unnamed_793, fragment_unnamed_813);
				fragment_output_0.w = fragment_unnamed_333;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[3] = float4(_SpecColor[0], _SpecColor[1], _SpecColor[2], _SpecColor[3]);

				fragment_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				fragment_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				fragment_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				fragment_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_uniform_buffer_0[8] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _FaceUVSpeedY, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[9] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], _OutlineSoftness, fragment_uniform_buffer_0[10][2], fragment_uniform_buffer_0[10][3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], fragment_uniform_buffer_0[10][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[10][3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], fragment_uniform_buffer_0[10][1], fragment_uniform_buffer_0[10][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[11] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[12] = float4(_OutlineWidth, fragment_uniform_buffer_0[12][1], fragment_uniform_buffer_0[12][2], fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], _Bevel, fragment_uniform_buffer_0[12][2], fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], fragment_uniform_buffer_0[12][1], _BevelOffset, fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], fragment_uniform_buffer_0[12][1], fragment_uniform_buffer_0[12][2], _BevelWidth);

				fragment_uniform_buffer_0[13] = float4(_BevelClamp, fragment_uniform_buffer_0[13][1], fragment_uniform_buffer_0[13][2], fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], _BevelRoundness, fragment_uniform_buffer_0[13][2], fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], fragment_uniform_buffer_0[13][1], _BumpOutline, fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], fragment_uniform_buffer_0[13][1], fragment_uniform_buffer_0[13][2], _BumpFace);

				fragment_uniform_buffer_0[28] = float4(_ShaderFlags, fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], fragment_uniform_buffer_0[28][3]);

				fragment_uniform_buffer_0[28] = float4(fragment_uniform_buffer_0[28][0], fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], _ScaleRatioA);

				fragment_uniform_buffer_0[33] = float4(fragment_uniform_buffer_0[33][0], fragment_uniform_buffer_0[33][1], _TextureWidth, fragment_uniform_buffer_0[33][3]);

				fragment_uniform_buffer_0[33] = float4(fragment_uniform_buffer_0[33][0], fragment_uniform_buffer_0[33][1], fragment_uniform_buffer_0[33][2], _TextureHeight);

				fragment_uniform_buffer_0[34] = float4(_GradientScale, fragment_uniform_buffer_0[34][1], fragment_uniform_buffer_0[34][2], fragment_uniform_buffer_0[34][3]);

				fragment_uniform_buffer_0[35] = float4(fragment_uniform_buffer_0[35][0], _FaceShininess, fragment_uniform_buffer_0[35][2], fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_0[35] = float4(fragment_uniform_buffer_0[35][0], fragment_uniform_buffer_0[35][1], _OutlineShininess, fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

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
				fragment_input_9 = stage_input.fragment_input_9;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(POINT_COOKIE) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(DIRECTIONAL_COOKIE)


			#if defined(DIRECTIONAL_COOKIE) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(POINT_COOKIE)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToLight;
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
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float4x4 glstate_matrix_projection;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[39];
			static float4 vertex_uniform_buffer_1[7];
			static float4 vertex_uniform_buffer_2[10];
			static float4 vertex_uniform_buffer_3[21];
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
			static float3 vertex_output_3;
			static float3 vertex_output_4;
			static float3 vertex_output_5;
			static float3 vertex_output_6;
			static float4 vertex_output_7;
			static float3 vertex_output_8;
			static float2 vertex_output_9;

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
				float2 vertex_output_2 : TEXCOORD6; // TEXCOORD_6
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float3 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float3 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float3 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_7 : COLOR; // COLOR
				float3 vertex_output_8 : TEXCOORD7; // TEXCOORD_7
				float2 vertex_output_9 : TEXCOORD8; // TEXCOORD_8
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_67 = vertex_input_0.x + vertex_uniform_buffer_0[29u].z;
				precise float vertex_unnamed_68 = vertex_input_0.y + vertex_uniform_buffer_0[29u].w;
				precise float vertex_unnamed_75 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_76 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_77 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_78 = vertex_unnamed_68 * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_99 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_unnamed_67, vertex_unnamed_75));
				float vertex_unnamed_100 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_unnamed_67, vertex_unnamed_76));
				float vertex_unnamed_101 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_unnamed_67, vertex_unnamed_77));
				float vertex_unnamed_102 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_unnamed_67, vertex_unnamed_78));
				precise float vertex_unnamed_110 = vertex_unnamed_99 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_111 = vertex_unnamed_100 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_112 = vertex_unnamed_101 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_113 = vertex_unnamed_102 + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_121 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_122 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_123 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_124 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_110, vertex_unnamed_121)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_110, vertex_unnamed_122)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_110, vertex_unnamed_123)));
				gl_Position.w = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_110, vertex_unnamed_124)));
				precise float vertex_unnamed_165 = vertex_input_4.x * 0.000244140625f;
				float vertex_unnamed_167 = floor(vertex_unnamed_165);
				precise float vertex_unnamed_168 = (-0.0f) - vertex_unnamed_167;
				precise float vertex_unnamed_174 = vertex_unnamed_167 * 0.001953125f;
				precise float vertex_unnamed_176 = mad(vertex_unnamed_168, 4096.0f, vertex_input_4.x) * 0.001953125f;
				vertex_output_1.z = mad(vertex_unnamed_174, vertex_uniform_buffer_0[37u].x, vertex_uniform_buffer_0[37u].z);
				vertex_output_1.w = mad(vertex_unnamed_176, vertex_uniform_buffer_0[37u].y, vertex_uniform_buffer_0[37u].w);
				vertex_output_2.x = mad(vertex_unnamed_174, vertex_uniform_buffer_0[38u].x, vertex_uniform_buffer_0[38u].z);
				vertex_output_2.y = mad(vertex_unnamed_176, vertex_uniform_buffer_0[38u].y, vertex_uniform_buffer_0[38u].w);
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[36u].x, vertex_uniform_buffer_0[36u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[36u].y, vertex_uniform_buffer_0[36u].w);
				precise float vertex_unnamed_223 = vertex_unnamed_111 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_235 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_113, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_112, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_110, vertex_unnamed_223)));
				precise float vertex_unnamed_244 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].x;
				precise float vertex_unnamed_245 = vertex_uniform_buffer_1[6u].y * vertex_uniform_buffer_3[6u].y;
				precise float vertex_unnamed_261 = mad(vertex_uniform_buffer_3[5u].x, vertex_uniform_buffer_1[6u].x, vertex_unnamed_244) * vertex_uniform_buffer_0[34u].y;
				precise float vertex_unnamed_262 = mad(vertex_uniform_buffer_3[5u].y, vertex_uniform_buffer_1[6u].x, vertex_unnamed_245) * vertex_uniform_buffer_0[34u].z;
				precise float vertex_unnamed_263 = vertex_unnamed_235 / vertex_unnamed_261;
				precise float vertex_unnamed_264 = vertex_unnamed_235 / vertex_unnamed_262;
				float vertex_unnamed_268 = rsqrt(dot(float2(vertex_unnamed_263, vertex_unnamed_264), float2(vertex_unnamed_263, vertex_unnamed_264)));
				precise float vertex_unnamed_275 = abs(vertex_input_4.y) * vertex_uniform_buffer_0[34u].x;
				precise float vertex_unnamed_280 = vertex_uniform_buffer_0[35u].x + 1.0f;
				precise float vertex_unnamed_282 = vertex_unnamed_280 * vertex_unnamed_275;
				precise float vertex_unnamed_283 = vertex_unnamed_268 * vertex_unnamed_282;
				precise float vertex_unnamed_287 = (-0.0f) - vertex_uniform_buffer_0[34u].w;
				precise float vertex_unnamed_288 = vertex_unnamed_287 + 1.0f;
				precise float vertex_unnamed_289 = vertex_unnamed_288 * vertex_unnamed_283;
				precise float vertex_unnamed_290 = (-0.0f) - vertex_unnamed_289;
				precise float vertex_unnamed_301 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].x;
				precise float vertex_unnamed_302 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].y;
				precise float vertex_unnamed_303 = vertex_uniform_buffer_1[4u].y * vertex_uniform_buffer_2[5u].z;
				precise float vertex_unnamed_331 = mad(vertex_uniform_buffer_2[6u].x, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].x, vertex_uniform_buffer_1[4u].x, vertex_unnamed_301)) + vertex_uniform_buffer_2[7u].x;
				precise float vertex_unnamed_332 = mad(vertex_uniform_buffer_2[6u].y, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].y, vertex_uniform_buffer_1[4u].x, vertex_unnamed_302)) + vertex_uniform_buffer_2[7u].y;
				precise float vertex_unnamed_333 = mad(vertex_uniform_buffer_2[6u].z, vertex_uniform_buffer_1[4u].z, mad(vertex_uniform_buffer_2[4u].z, vertex_uniform_buffer_1[4u].x, vertex_unnamed_303)) + vertex_uniform_buffer_2[7u].z;
				precise float vertex_unnamed_336 = (-0.0f) - vertex_unnamed_67;
				precise float vertex_unnamed_337 = (-0.0f) - vertex_unnamed_68;
				precise float vertex_unnamed_338 = (-0.0f) - vertex_input_0.z;
				precise float vertex_unnamed_339 = vertex_unnamed_336 + vertex_unnamed_331;
				precise float vertex_unnamed_340 = vertex_unnamed_337 + vertex_unnamed_332;
				precise float vertex_unnamed_341 = vertex_unnamed_338 + vertex_unnamed_333;
				float vertex_unnamed_348 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_unnamed_339, vertex_unnamed_340, vertex_unnamed_341));
				float vertex_unnamed_360 = float(int((-((0.0f < vertex_unnamed_348) ? 4294967295u : 0u)) + ((vertex_unnamed_348 < 0.0f) ? 4294967295u : 0u)));
				precise float vertex_unnamed_367 = vertex_unnamed_360 * vertex_input_2.x;
				precise float vertex_unnamed_368 = vertex_unnamed_360 * vertex_input_2.y;
				precise float vertex_unnamed_369 = vertex_unnamed_360 * vertex_input_2.z;
				float vertex_unnamed_375 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_383 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_391 = dot(float3(vertex_unnamed_367, vertex_unnamed_368, vertex_unnamed_369), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_397 = rsqrt(dot(float3(vertex_unnamed_391, vertex_unnamed_375, vertex_unnamed_383), float3(vertex_unnamed_391, vertex_unnamed_375, vertex_unnamed_383)));
				precise float vertex_unnamed_398 = vertex_unnamed_397 * vertex_unnamed_391;
				precise float vertex_unnamed_399 = vertex_unnamed_397 * vertex_unnamed_375;
				precise float vertex_unnamed_400 = vertex_unnamed_397 * vertex_unnamed_383;
				float vertex_unnamed_408 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_99);
				float vertex_unnamed_409 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_100);
				float vertex_unnamed_410 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_101);
				float vertex_unnamed_419 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_99);
				float vertex_unnamed_420 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_100);
				float vertex_unnamed_421 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_101);
				float vertex_unnamed_422 = mad(vertex_uniform_buffer_2[3u].w, vertex_input_0.w, vertex_unnamed_102);
				precise float vertex_unnamed_423 = (-0.0f) - vertex_unnamed_408;
				precise float vertex_unnamed_424 = (-0.0f) - vertex_unnamed_409;
				precise float vertex_unnamed_425 = (-0.0f) - vertex_unnamed_410;
				precise float vertex_unnamed_431 = vertex_unnamed_423 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_432 = vertex_unnamed_424 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_433 = vertex_unnamed_425 + vertex_uniform_buffer_1[4u].z;
				vertex_output_6.x = vertex_unnamed_408;
				vertex_output_6.y = vertex_unnamed_409;
				vertex_output_6.z = vertex_unnamed_410;
				float vertex_unnamed_440 = rsqrt(dot(float3(vertex_unnamed_431, vertex_unnamed_432, vertex_unnamed_433), float3(vertex_unnamed_431, vertex_unnamed_432, vertex_unnamed_433)));
				precise float vertex_unnamed_441 = vertex_unnamed_440 * vertex_unnamed_431;
				precise float vertex_unnamed_442 = vertex_unnamed_440 * vertex_unnamed_432;
				precise float vertex_unnamed_443 = vertex_unnamed_440 * vertex_unnamed_433;
				vertex_output_2.y = mad(abs(dot(float3(vertex_unnamed_399, vertex_unnamed_400, vertex_unnamed_398), float3(vertex_unnamed_441, vertex_unnamed_442, vertex_unnamed_443))), mad(vertex_unnamed_268, vertex_unnamed_282, vertex_unnamed_290), vertex_unnamed_289);
				precise float vertex_unnamed_461 = (-0.0f) - vertex_uniform_buffer_0[28u].y;
				precise float vertex_unnamed_465 = vertex_unnamed_461 + vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_478 = mad(mad(asfloat(((0.0f >= vertex_input_4.y) ? 4294967295u : 0u) & 1065353216u), vertex_unnamed_465, vertex_uniform_buffer_0[28u].y), 0.25f, vertex_uniform_buffer_0[10u].x) * vertex_uniform_buffer_0[28u].w;
				precise float vertex_unnamed_479 = vertex_unnamed_478 * 0.5f;
				vertex_output_2.x = vertex_unnamed_479;
				vertex_output_3.z = vertex_unnamed_399;
				precise float vertex_unnamed_490 = vertex_input_1.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_491 = vertex_input_1.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_492 = vertex_input_1.y * vertex_uniform_buffer_2[1u].x;
				float vertex_unnamed_510 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_1.x, vertex_unnamed_490));
				float vertex_unnamed_511 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_1.x, vertex_unnamed_491));
				float vertex_unnamed_512 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_1.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_1.x, vertex_unnamed_492));
				float vertex_unnamed_516 = rsqrt(dot(float3(vertex_unnamed_510, vertex_unnamed_511, vertex_unnamed_512), float3(vertex_unnamed_510, vertex_unnamed_511, vertex_unnamed_512)));
				precise float vertex_unnamed_517 = vertex_unnamed_516 * vertex_unnamed_510;
				precise float vertex_unnamed_518 = vertex_unnamed_516 * vertex_unnamed_511;
				precise float vertex_unnamed_519 = vertex_unnamed_516 * vertex_unnamed_512;
				precise float vertex_unnamed_520 = vertex_unnamed_398 * vertex_unnamed_517;
				precise float vertex_unnamed_521 = vertex_unnamed_399 * vertex_unnamed_518;
				precise float vertex_unnamed_522 = vertex_unnamed_400 * vertex_unnamed_519;
				precise float vertex_unnamed_523 = (-0.0f) - vertex_unnamed_520;
				precise float vertex_unnamed_524 = (-0.0f) - vertex_unnamed_521;
				precise float vertex_unnamed_525 = (-0.0f) - vertex_unnamed_522;
				precise float vertex_unnamed_535 = vertex_input_1.w * vertex_uniform_buffer_2[9u].w;
				precise float vertex_unnamed_536 = vertex_unnamed_535 * mad(vertex_unnamed_400, vertex_unnamed_518, vertex_unnamed_523);
				precise float vertex_unnamed_537 = vertex_unnamed_535 * mad(vertex_unnamed_398, vertex_unnamed_519, vertex_unnamed_524);
				precise float vertex_unnamed_538 = vertex_unnamed_535 * mad(vertex_unnamed_399, vertex_unnamed_517, vertex_unnamed_525);
				vertex_output_3.y = vertex_unnamed_536;
				vertex_output_3.x = vertex_unnamed_519;
				vertex_output_4.z = vertex_unnamed_400;
				vertex_output_5.z = vertex_unnamed_398;
				vertex_output_4.x = vertex_unnamed_517;
				vertex_output_5.x = vertex_unnamed_518;
				vertex_output_4.y = vertex_unnamed_537;
				vertex_output_5.y = vertex_unnamed_538;
				vertex_output_7.x = vertex_input_7.x;
				vertex_output_7.y = vertex_input_7.y;
				vertex_output_7.z = vertex_input_7.z;
				vertex_output_7.w = vertex_input_7.w;
				precise float vertex_unnamed_564 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].x;
				precise float vertex_unnamed_565 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].y;
				precise float vertex_unnamed_566 = vertex_unnamed_432 * vertex_uniform_buffer_0[18u].z;
				vertex_output_8.x = mad(vertex_uniform_buffer_0[19u].x, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].x, vertex_unnamed_431, vertex_unnamed_564));
				vertex_output_8.y = mad(vertex_uniform_buffer_0[19u].y, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].y, vertex_unnamed_431, vertex_unnamed_565));
				vertex_output_8.z = mad(vertex_uniform_buffer_0[19u].z, vertex_unnamed_433, mad(vertex_uniform_buffer_0[17u].z, vertex_unnamed_431, vertex_unnamed_566));
				precise float vertex_unnamed_590 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_591 = vertex_unnamed_420 * vertex_uniform_buffer_0[5u].y;
				vertex_output_9.x = mad(vertex_uniform_buffer_0[7u].x, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].x, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].x, vertex_unnamed_419, vertex_unnamed_590)));
				vertex_output_9.y = mad(vertex_uniform_buffer_0[7u].y, vertex_unnamed_422, mad(vertex_uniform_buffer_0[6u].y, vertex_unnamed_421, mad(vertex_uniform_buffer_0[4u].y, vertex_unnamed_419, vertex_unnamed_591)));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				vertex_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				vertex_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				vertex_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				vertex_uniform_buffer_0[10] = float4(_FaceDilate, vertex_uniform_buffer_0[10][1], vertex_uniform_buffer_0[10][2], vertex_uniform_buffer_0[10][3]);

				vertex_uniform_buffer_0[17] = float4(_EnvMatrix[0][0], _EnvMatrix[1][0], _EnvMatrix[2][0], _EnvMatrix[3][0]);
				vertex_uniform_buffer_0[18] = float4(_EnvMatrix[0][1], _EnvMatrix[1][1], _EnvMatrix[2][1], _EnvMatrix[3][1]);
				vertex_uniform_buffer_0[19] = float4(_EnvMatrix[0][2], _EnvMatrix[1][2], _EnvMatrix[2][2], _EnvMatrix[3][2]);
				vertex_uniform_buffer_0[20] = float4(_EnvMatrix[0][3], _EnvMatrix[1][3], _EnvMatrix[2][3], _EnvMatrix[3][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], _WeightNormal, vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], _WeightBold, vertex_uniform_buffer_0[28][3]);

				vertex_uniform_buffer_0[28] = float4(vertex_uniform_buffer_0[28][0], vertex_uniform_buffer_0[28][1], vertex_uniform_buffer_0[28][2], _ScaleRatioA);

				vertex_uniform_buffer_0[29] = float4(vertex_uniform_buffer_0[29][0], vertex_uniform_buffer_0[29][1], _VertexOffsetX, vertex_uniform_buffer_0[29][3]);

				vertex_uniform_buffer_0[29] = float4(vertex_uniform_buffer_0[29][0], vertex_uniform_buffer_0[29][1], vertex_uniform_buffer_0[29][2], _VertexOffsetY);

				vertex_uniform_buffer_0[34] = float4(_GradientScale, vertex_uniform_buffer_0[34][1], vertex_uniform_buffer_0[34][2], vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], _ScaleX, vertex_uniform_buffer_0[34][2], vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], vertex_uniform_buffer_0[34][1], _ScaleY, vertex_uniform_buffer_0[34][3]);

				vertex_uniform_buffer_0[34] = float4(vertex_uniform_buffer_0[34][0], vertex_uniform_buffer_0[34][1], vertex_uniform_buffer_0[34][2], _PerspectiveFilter);

				vertex_uniform_buffer_0[35] = float4(_Sharpness, vertex_uniform_buffer_0[35][1], vertex_uniform_buffer_0[35][2], vertex_uniform_buffer_0[35][3]);

				vertex_uniform_buffer_0[36] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_0[37] = float4(_FaceTex_ST[0], _FaceTex_ST[1], _FaceTex_ST[2], _FaceTex_ST[3]);

				vertex_uniform_buffer_0[38] = float4(_OutlineTex_ST[0], _OutlineTex_ST[1], _OutlineTex_ST[2], _OutlineTex_ST[3]);

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

				vertex_uniform_buffer_2[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

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
				stage_output.vertex_output_9 = vertex_output_9;
				return stage_output;
			}


			float4 _LightColor0;
			float4 _SpecColor;
			float4x4 unity_WorldToLight;
			float _FaceUVSpeedX;
			float _FaceUVSpeedY;
			float4 _FaceColor;
			float _OutlineSoftness;
			float _OutlineUVSpeedX;
			float _OutlineUVSpeedY;
			float4 _OutlineColor;
			float _OutlineWidth;
			float _Bevel;
			float _BevelOffset;
			float _BevelWidth;
			float _BevelClamp;
			float _BevelRoundness;
			float _BumpOutline;
			float _BumpFace;
			float _ShaderFlags;
			float _ScaleRatioA;
			float _TextureWidth;
			float _TextureHeight;
			float _GradientScale;
			float _FaceShininess;
			float _OutlineShininess;
			float4 _Time;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_OcclusionMaskSelector;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[36];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _FaceTex;
			Texture2D<float4> _OutlineTex;
			Texture2D<float4> _BumpMap;
			Texture2D<float4> _LightTexture0;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_LightTexture0;
			SamplerState sampler_FaceTex;
			SamplerState sampler_OutlineTex;
			SamplerState sampler_BumpMap;
			SamplerState sampler_MainTex;

			static float4 fragment_input_1;
			static float2 fragment_input_2;
			static float2 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_input_7;
			static float3 fragment_input_8;
			static float2 fragment_input_9;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float2 fragment_input_2 : TEXCOORD6; // TEXCOORD_6
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float3 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
				float3 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
				float3 fragment_input_6 : TEXCOORD5; // TEXCOORD_5
				float4 fragment_input_7 : COLOR; // COLOR
				float3 fragment_input_8 : TEXCOORD7; // TEXCOORD_7
				float2 fragment_input_9 : TEXCOORD8; // TEXCOORD_8
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_80 = (-0.0f) - fragment_input_6.x;
				precise float fragment_unnamed_85 = (-0.0f) - fragment_input_6.y;
				precise float fragment_unnamed_89 = (-0.0f) - fragment_input_6.z;
				precise float fragment_unnamed_97 = fragment_unnamed_80 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_98 = fragment_unnamed_85 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_99 = fragment_unnamed_89 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_104 = rsqrt(dot(float3(fragment_unnamed_97, fragment_unnamed_98, fragment_unnamed_99), float3(fragment_unnamed_97, fragment_unnamed_98, fragment_unnamed_99)));
				precise float fragment_unnamed_110 = 1.0f / fragment_uniform_buffer_0[33u].z;
				precise float fragment_unnamed_112 = 1.0f / fragment_uniform_buffer_0[33u].w;
				float fragment_unnamed_113 = asfloat(0u);
				precise float fragment_unnamed_114 = (-0.0f) - fragment_unnamed_110;
				precise float fragment_unnamed_115 = (-0.0f) - fragment_unnamed_113;
				precise float fragment_unnamed_116 = (-0.0f) - fragment_unnamed_112;
				precise float fragment_unnamed_121 = fragment_unnamed_114 + fragment_input_1.x;
				precise float fragment_unnamed_122 = fragment_unnamed_115 + fragment_input_1.y;
				precise float fragment_unnamed_123 = fragment_unnamed_115 + fragment_input_1.x;
				precise float fragment_unnamed_124 = fragment_unnamed_116 + fragment_input_1.y;
				precise float fragment_unnamed_135 = fragment_unnamed_110 + fragment_input_1.x;
				precise float fragment_unnamed_136 = fragment_unnamed_113 + fragment_input_1.y;
				precise float fragment_unnamed_137 = fragment_unnamed_113 + fragment_input_1.x;
				precise float fragment_unnamed_138 = fragment_unnamed_112 + fragment_input_1.y;
				precise float fragment_unnamed_155 = (-0.0f) - _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
				precise float fragment_unnamed_156 = fragment_unnamed_155 + 0.5f;
				precise float fragment_unnamed_160 = (-0.0f) - fragment_input_2.x;
				precise float fragment_unnamed_161 = fragment_unnamed_156 + fragment_unnamed_160;
				float fragment_unnamed_164 = mad(fragment_unnamed_161, fragment_input_2.y, 0.5f);
				precise float fragment_unnamed_173 = fragment_uniform_buffer_0[12u].x * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_176 = fragment_unnamed_173 * fragment_input_2.y;
				precise float fragment_unnamed_184 = fragment_uniform_buffer_0[10u].y * fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_187 = fragment_unnamed_184 * fragment_input_2.y;
				precise float fragment_unnamed_204 = fragment_input_7.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_205 = fragment_input_7.y * fragment_uniform_buffer_0[9u].y;
				precise float fragment_unnamed_206 = fragment_input_7.z * fragment_uniform_buffer_0[9u].z;
				precise float fragment_unnamed_207 = fragment_input_7.w * fragment_uniform_buffer_0[9u].w;
				precise float fragment_unnamed_214 = fragment_input_7.w * fragment_uniform_buffer_0[11u].w;
				float4 fragment_unnamed_230 = _FaceTex.Sample(sampler_FaceTex, float2(mad(fragment_uniform_buffer_0[8u].x, fragment_uniform_buffer_1[0u].y, fragment_input_1.z), mad(fragment_uniform_buffer_0[8u].y, fragment_uniform_buffer_1[0u].y, fragment_input_1.w)));
				precise float fragment_unnamed_236 = fragment_unnamed_204 * fragment_unnamed_230.x;
				precise float fragment_unnamed_237 = fragment_unnamed_205 * fragment_unnamed_230.y;
				precise float fragment_unnamed_238 = fragment_unnamed_206 * fragment_unnamed_230.z;
				precise float fragment_unnamed_239 = fragment_unnamed_207 * fragment_unnamed_230.w;
				float4 fragment_unnamed_254 = _OutlineTex.Sample(sampler_OutlineTex, float2(mad(fragment_uniform_buffer_0[10u].z, fragment_uniform_buffer_1[0u].y, fragment_input_2.x), mad(fragment_uniform_buffer_0[10u].w, fragment_uniform_buffer_1[0u].y, fragment_input_2.y)));
				precise float fragment_unnamed_265 = fragment_unnamed_254.x * fragment_uniform_buffer_0[11u].x;
				precise float fragment_unnamed_266 = fragment_unnamed_254.y * fragment_uniform_buffer_0[11u].y;
				precise float fragment_unnamed_267 = fragment_unnamed_254.z * fragment_uniform_buffer_0[11u].z;
				precise float fragment_unnamed_268 = fragment_unnamed_214 * fragment_unnamed_254.w;
				precise float fragment_unnamed_269 = (-0.0f) - fragment_unnamed_176;
				precise float fragment_unnamed_275 = mad(fragment_unnamed_187, 0.5f, mad(fragment_unnamed_269, 0.5f, fragment_unnamed_164)) / mad(fragment_unnamed_184, fragment_input_2.y, 1.0f);
				precise float fragment_unnamed_277 = (-0.0f) - clamp(fragment_unnamed_275, 0.0f, 1.0f);
				precise float fragment_unnamed_278 = fragment_unnamed_277 + 1.0f;
				float fragment_unnamed_280 = clamp(mad(fragment_unnamed_176, 0.5f, fragment_unnamed_164), 0.0f, 1.0f);
				precise float fragment_unnamed_283 = sqrt(min(fragment_unnamed_176, 1.0f)) * fragment_unnamed_280;
				precise float fragment_unnamed_284 = fragment_unnamed_239 * fragment_unnamed_236;
				precise float fragment_unnamed_285 = fragment_unnamed_239 * fragment_unnamed_237;
				precise float fragment_unnamed_286 = fragment_unnamed_239 * fragment_unnamed_238;
				precise float fragment_unnamed_287 = fragment_unnamed_265 * fragment_unnamed_268;
				precise float fragment_unnamed_288 = fragment_unnamed_266 * fragment_unnamed_268;
				precise float fragment_unnamed_289 = fragment_unnamed_267 * fragment_unnamed_268;
				precise float fragment_unnamed_290 = (-0.0f) - fragment_unnamed_284;
				precise float fragment_unnamed_291 = (-0.0f) - fragment_unnamed_285;
				precise float fragment_unnamed_292 = (-0.0f) - fragment_unnamed_286;
				precise float fragment_unnamed_293 = (-0.0f) - fragment_unnamed_239;
				precise float fragment_unnamed_294 = fragment_unnamed_290 + fragment_unnamed_287;
				precise float fragment_unnamed_295 = fragment_unnamed_291 + fragment_unnamed_288;
				precise float fragment_unnamed_296 = fragment_unnamed_292 + fragment_unnamed_289;
				precise float fragment_unnamed_297 = fragment_unnamed_293 + fragment_unnamed_268;
				precise float fragment_unnamed_302 = fragment_unnamed_278 * mad(fragment_unnamed_283, fragment_unnamed_294, fragment_unnamed_284);
				precise float fragment_unnamed_303 = fragment_unnamed_278 * mad(fragment_unnamed_283, fragment_unnamed_295, fragment_unnamed_285);
				precise float fragment_unnamed_304 = fragment_unnamed_278 * mad(fragment_unnamed_283, fragment_unnamed_296, fragment_unnamed_286);
				precise float fragment_unnamed_305 = fragment_unnamed_278 * mad(fragment_unnamed_283, fragment_unnamed_297, fragment_unnamed_239);
				float fragment_unnamed_306 = max(fragment_unnamed_305, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_308 = fragment_unnamed_302 / fragment_unnamed_306;
				precise float fragment_unnamed_309 = fragment_unnamed_303 / fragment_unnamed_306;
				precise float fragment_unnamed_310 = fragment_unnamed_304 / fragment_unnamed_306;
				precise float fragment_unnamed_314 = fragment_uniform_buffer_0[28u].x * 0.5f;
				precise float fragment_unnamed_315 = (-0.0f) - fragment_unnamed_314;
				float fragment_unnamed_319 = frac(abs(fragment_unnamed_314));
				precise float fragment_unnamed_320 = (-0.0f) - fragment_unnamed_319;
				bool fragment_unnamed_322 = ((fragment_unnamed_314 >= fragment_unnamed_315) ? fragment_unnamed_319 : fragment_unnamed_320) >= 0.5f;
				precise float fragment_unnamed_328 = fragment_input_2.x + fragment_uniform_buffer_0[12u].z;
				precise float fragment_unnamed_329 = fragment_unnamed_328 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_121, fragment_unnamed_122)).w;
				precise float fragment_unnamed_330 = fragment_unnamed_328 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_135, fragment_unnamed_136)).w;
				precise float fragment_unnamed_331 = fragment_unnamed_328 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_123, fragment_unnamed_124)).w;
				precise float fragment_unnamed_332 = fragment_unnamed_328 + _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_137, fragment_unnamed_138)).w;
				precise float fragment_unnamed_339 = fragment_uniform_buffer_0[12u].w + fragment_uniform_buffer_0[12u].x;
				float fragment_unnamed_340 = max(fragment_unnamed_339, 0.00999999977648258209228515625f);
				precise float fragment_unnamed_342 = fragment_unnamed_329 + (-0.5f);
				precise float fragment_unnamed_344 = fragment_unnamed_330 + (-0.5f);
				precise float fragment_unnamed_345 = fragment_unnamed_331 + (-0.5f);
				precise float fragment_unnamed_346 = fragment_unnamed_332 + (-0.5f);
				precise float fragment_unnamed_347 = fragment_unnamed_342 / fragment_unnamed_340;
				precise float fragment_unnamed_348 = fragment_unnamed_344 / fragment_unnamed_340;
				precise float fragment_unnamed_349 = fragment_unnamed_345 / fragment_unnamed_340;
				precise float fragment_unnamed_350 = fragment_unnamed_346 / fragment_unnamed_340;
				precise float fragment_unnamed_351 = fragment_unnamed_347 + 0.5f;
				precise float fragment_unnamed_352 = fragment_unnamed_348 + 0.5f;
				precise float fragment_unnamed_353 = fragment_unnamed_349 + 0.5f;
				precise float fragment_unnamed_354 = fragment_unnamed_350 + 0.5f;
				float fragment_unnamed_355 = clamp(fragment_unnamed_351, 0.0f, 1.0f);
				float fragment_unnamed_356 = clamp(fragment_unnamed_352, 0.0f, 1.0f);
				float fragment_unnamed_357 = clamp(fragment_unnamed_353, 0.0f, 1.0f);
				float fragment_unnamed_358 = clamp(fragment_unnamed_354, 0.0f, 1.0f);
				precise float fragment_unnamed_366 = (-0.0f) - abs(mad(fragment_unnamed_355, 2.0f, -1.0f));
				precise float fragment_unnamed_368 = (-0.0f) - abs(mad(fragment_unnamed_356, 2.0f, -1.0f));
				precise float fragment_unnamed_370 = (-0.0f) - abs(mad(fragment_unnamed_357, 2.0f, -1.0f));
				precise float fragment_unnamed_372 = (-0.0f) - abs(mad(fragment_unnamed_358, 2.0f, -1.0f));
				precise float fragment_unnamed_373 = fragment_unnamed_366 + 1.0f;
				precise float fragment_unnamed_374 = fragment_unnamed_368 + 1.0f;
				precise float fragment_unnamed_375 = fragment_unnamed_370 + 1.0f;
				precise float fragment_unnamed_376 = fragment_unnamed_372 + 1.0f;
				float fragment_unnamed_386 = asfloat(fragment_unnamed_322 ? asuint(fragment_unnamed_373) : asuint(fragment_unnamed_355));
				float fragment_unnamed_388 = asfloat(fragment_unnamed_322 ? asuint(fragment_unnamed_374) : asuint(fragment_unnamed_356));
				float fragment_unnamed_390 = asfloat(fragment_unnamed_322 ? asuint(fragment_unnamed_375) : asuint(fragment_unnamed_357));
				float fragment_unnamed_392 = asfloat(fragment_unnamed_322 ? asuint(fragment_unnamed_376) : asuint(fragment_unnamed_358));
				precise float fragment_unnamed_393 = fragment_unnamed_386 * 1.57079601287841796875f;
				precise float fragment_unnamed_395 = fragment_unnamed_388 * 1.57079601287841796875f;
				precise float fragment_unnamed_396 = fragment_unnamed_390 * 1.57079601287841796875f;
				precise float fragment_unnamed_397 = fragment_unnamed_392 * 1.57079601287841796875f;
				precise float fragment_unnamed_402 = (-0.0f) - fragment_unnamed_386;
				precise float fragment_unnamed_403 = (-0.0f) - fragment_unnamed_388;
				precise float fragment_unnamed_404 = (-0.0f) - fragment_unnamed_390;
				precise float fragment_unnamed_405 = (-0.0f) - fragment_unnamed_392;
				precise float fragment_unnamed_406 = fragment_unnamed_402 + sin(fragment_unnamed_393);
				precise float fragment_unnamed_407 = fragment_unnamed_403 + sin(fragment_unnamed_395);
				precise float fragment_unnamed_408 = fragment_unnamed_404 + sin(fragment_unnamed_396);
				precise float fragment_unnamed_409 = fragment_unnamed_405 + sin(fragment_unnamed_397);
				precise float fragment_unnamed_421 = (-0.0f) - fragment_uniform_buffer_0[13u].x;
				precise float fragment_unnamed_422 = fragment_unnamed_421 + 1.0f;
				precise float fragment_unnamed_430 = fragment_unnamed_340 * fragment_uniform_buffer_0[12u].y;
				precise float fragment_unnamed_435 = fragment_unnamed_430 * fragment_uniform_buffer_0[34u].x;
				precise float fragment_unnamed_436 = fragment_unnamed_435 * (-2.0f);
				precise float fragment_unnamed_438 = min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_406, fragment_unnamed_386), fragment_unnamed_422) * fragment_unnamed_436;
				precise float fragment_unnamed_439 = min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_408, fragment_unnamed_390), fragment_unnamed_422) * fragment_unnamed_436;
				precise float fragment_unnamed_440 = (-0.0f) - fragment_unnamed_439;
				precise float fragment_unnamed_441 = (-0.0f) - fragment_unnamed_438;
				float fragment_unnamed_442 = mad(min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_409, fragment_unnamed_392), fragment_unnamed_422), fragment_unnamed_436, fragment_unnamed_440);
				float fragment_unnamed_443 = mad(min(mad(fragment_uniform_buffer_0[13u].y, fragment_unnamed_407, fragment_unnamed_388), fragment_unnamed_422), fragment_unnamed_436, fragment_unnamed_441);
				float fragment_unnamed_444 = asfloat(3212836864u);
				float fragment_unnamed_446 = asfloat(1065353216u);
				float fragment_unnamed_451 = rsqrt(dot(float2(fragment_unnamed_443, fragment_unnamed_446), float2(fragment_unnamed_443, fragment_unnamed_446)));
				precise float fragment_unnamed_452 = fragment_unnamed_451 * 1.0f;
				precise float fragment_unnamed_453 = fragment_unnamed_451 * 0.0f;
				precise float fragment_unnamed_454 = fragment_unnamed_451 * fragment_unnamed_443;
				float fragment_unnamed_458 = rsqrt(dot(float2(fragment_unnamed_444, fragment_unnamed_442), float2(fragment_unnamed_444, fragment_unnamed_442)));
				precise float fragment_unnamed_460 = fragment_unnamed_458 * fragment_unnamed_444;
				precise float fragment_unnamed_461 = fragment_unnamed_458 * fragment_unnamed_442;
				precise float fragment_unnamed_462 = fragment_unnamed_458 * asfloat(0u);
				precise float fragment_unnamed_463 = fragment_unnamed_460 * fragment_unnamed_454;
				precise float fragment_unnamed_464 = fragment_unnamed_461 * fragment_unnamed_452;
				precise float fragment_unnamed_465 = fragment_unnamed_462 * fragment_unnamed_453;
				precise float fragment_unnamed_466 = (-0.0f) - fragment_unnamed_463;
				precise float fragment_unnamed_467 = (-0.0f) - fragment_unnamed_464;
				precise float fragment_unnamed_468 = (-0.0f) - fragment_unnamed_465;
				float4 fragment_unnamed_477 = _BumpMap.Sample(sampler_BumpMap, float2(fragment_input_1.z, fragment_input_1.w));
				precise float fragment_unnamed_482 = fragment_unnamed_477.w * fragment_unnamed_477.x;
				float fragment_unnamed_483 = mad(fragment_unnamed_482, 2.0f, -1.0f);
				float fragment_unnamed_484 = mad(fragment_unnamed_477.y, 2.0f, -1.0f);
				precise float fragment_unnamed_489 = (-0.0f) - min(dot(float2(fragment_unnamed_483, fragment_unnamed_484), float2(fragment_unnamed_483, fragment_unnamed_484)), 1.0f);
				precise float fragment_unnamed_490 = fragment_unnamed_489 + 1.0f;
				precise float fragment_unnamed_495 = (-0.0f) - fragment_uniform_buffer_0[13u].w;
				precise float fragment_unnamed_499 = fragment_unnamed_495 + fragment_uniform_buffer_0[13u].z;
				float fragment_unnamed_503 = mad(fragment_unnamed_280, fragment_unnamed_499, fragment_uniform_buffer_0[13u].w);
				precise float fragment_unnamed_510 = (-0.0f) - mad(fragment_unnamed_305, mad(fragment_unnamed_483, fragment_unnamed_503, -0.0f), 0.0f);
				precise float fragment_unnamed_511 = (-0.0f) - mad(fragment_unnamed_305, mad(fragment_unnamed_484, fragment_unnamed_503, -0.0f), 0.0f);
				precise float fragment_unnamed_512 = (-0.0f) - mad(fragment_unnamed_305, mad(sqrt(fragment_unnamed_490), fragment_unnamed_503, -1.0f), 1.0f);
				precise float fragment_unnamed_513 = mad(fragment_unnamed_453, fragment_unnamed_461, fragment_unnamed_466) + fragment_unnamed_510;
				precise float fragment_unnamed_514 = mad(fragment_unnamed_454, fragment_unnamed_462, fragment_unnamed_467) + fragment_unnamed_511;
				precise float fragment_unnamed_515 = mad(fragment_unnamed_452, fragment_unnamed_460, fragment_unnamed_468) + fragment_unnamed_512;
				float fragment_unnamed_519 = rsqrt(dot(float3(fragment_unnamed_513, fragment_unnamed_514, fragment_unnamed_515), float3(fragment_unnamed_513, fragment_unnamed_514, fragment_unnamed_515)));
				precise float fragment_unnamed_520 = fragment_unnamed_519 * fragment_unnamed_513;
				precise float fragment_unnamed_521 = fragment_unnamed_519 * fragment_unnamed_514;
				precise float fragment_unnamed_522 = fragment_unnamed_519 * fragment_unnamed_515;
				precise float fragment_unnamed_527 = (-0.0f) - fragment_uniform_buffer_0[35u].y;
				precise float fragment_unnamed_531 = fragment_unnamed_527 + fragment_uniform_buffer_0[35u].z;
				precise float fragment_unnamed_542 = fragment_input_6.y * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_543 = fragment_input_6.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_565 = mad(fragment_uniform_buffer_0[6u].x, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].x, fragment_input_6.x, fragment_unnamed_542)) + fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_566 = mad(fragment_uniform_buffer_0[6u].y, fragment_input_6.z, mad(fragment_uniform_buffer_0[4u].y, fragment_input_6.x, fragment_unnamed_543)) + fragment_uniform_buffer_0[7u].y;
				float fragment_unnamed_661;
				float fragment_unnamed_662;
				float fragment_unnamed_663;
				float fragment_unnamed_664;
				if (fragment_uniform_buffer_3[0u].x == 1.0f)
				{
					bool fragment_unnamed_574 = fragment_uniform_buffer_3[0u].y == 1.0f;
					precise float fragment_unnamed_582 = fragment_input_6.y * fragment_uniform_buffer_3[2u].x;
					precise float fragment_unnamed_583 = fragment_input_6.y * fragment_uniform_buffer_3[2u].y;
					precise float fragment_unnamed_584 = fragment_input_6.y * fragment_uniform_buffer_3[2u].z;
					precise float fragment_unnamed_610 = mad(fragment_uniform_buffer_3[3u].x, fragment_input_6.z, mad(fragment_uniform_buffer_3[1u].x, fragment_input_6.x, fragment_unnamed_582)) + fragment_uniform_buffer_3[4u].x;
					precise float fragment_unnamed_611 = mad(fragment_uniform_buffer_3[3u].y, fragment_input_6.z, mad(fragment_uniform_buffer_3[1u].y, fragment_input_6.x, fragment_unnamed_583)) + fragment_uniform_buffer_3[4u].y;
					precise float fragment_unnamed_612 = mad(fragment_uniform_buffer_3[3u].z, fragment_input_6.z, mad(fragment_uniform_buffer_3[1u].z, fragment_input_6.x, fragment_unnamed_584)) + fragment_uniform_buffer_3[4u].z;
					precise float fragment_unnamed_625 = (-0.0f) - fragment_uniform_buffer_3[6u].x;
					precise float fragment_unnamed_627 = (-0.0f) - fragment_uniform_buffer_3[6u].y;
					precise float fragment_unnamed_629 = (-0.0f) - fragment_uniform_buffer_3[6u].z;
					precise float fragment_unnamed_630 = (fragment_unnamed_574 ? fragment_unnamed_610 : fragment_input_6.x) + fragment_unnamed_625;
					precise float fragment_unnamed_631 = (fragment_unnamed_574 ? fragment_unnamed_611 : fragment_input_6.y) + fragment_unnamed_627;
					precise float fragment_unnamed_632 = (fragment_unnamed_574 ? fragment_unnamed_612 : fragment_input_6.z) + fragment_unnamed_629;
					precise float fragment_unnamed_638 = fragment_unnamed_630 * fragment_uniform_buffer_3[5u].x;
					precise float fragment_unnamed_639 = fragment_unnamed_631 * fragment_uniform_buffer_3[5u].y;
					precise float fragment_unnamed_640 = fragment_unnamed_632 * fragment_uniform_buffer_3[5u].z;
					float4 fragment_unnamed_651 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_uniform_buffer_3[0u].z, 0.5f, 0.75f), mad(fragment_unnamed_638, 0.25f, 0.75f)), fragment_unnamed_639, fragment_unnamed_640));
					fragment_unnamed_661 = fragment_unnamed_651.x;
					fragment_unnamed_662 = fragment_unnamed_651.y;
					fragment_unnamed_663 = fragment_unnamed_651.z;
					fragment_unnamed_664 = fragment_unnamed_651.w;
				}
				else
				{
					fragment_unnamed_661 = asfloat(1065353216u);
					fragment_unnamed_662 = asfloat(1065353216u);
					fragment_unnamed_663 = asfloat(1065353216u);
					fragment_unnamed_664 = asfloat(1065353216u);
				}
				precise float fragment_unnamed_680 = clamp(dot(float4(fragment_unnamed_661, fragment_unnamed_662, fragment_unnamed_663, fragment_unnamed_664), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f) * _LightTexture0.Sample(sampler_LightTexture0, float2(fragment_unnamed_565, fragment_unnamed_566)).w;
				precise float fragment_unnamed_687 = (-0.0f) - fragment_unnamed_520;
				precise float fragment_unnamed_688 = (-0.0f) - fragment_unnamed_521;
				precise float fragment_unnamed_689 = (-0.0f) - fragment_unnamed_522;
				float fragment_unnamed_690 = dot(float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z), float3(fragment_unnamed_687, fragment_unnamed_688, fragment_unnamed_689));
				precise float fragment_unnamed_699 = (-0.0f) - fragment_unnamed_520;
				precise float fragment_unnamed_700 = (-0.0f) - fragment_unnamed_521;
				precise float fragment_unnamed_701 = (-0.0f) - fragment_unnamed_522;
				float fragment_unnamed_702 = dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_unnamed_699, fragment_unnamed_700, fragment_unnamed_701));
				precise float fragment_unnamed_711 = (-0.0f) - fragment_unnamed_520;
				precise float fragment_unnamed_712 = (-0.0f) - fragment_unnamed_521;
				precise float fragment_unnamed_713 = (-0.0f) - fragment_unnamed_522;
				float fragment_unnamed_714 = dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_unnamed_711, fragment_unnamed_712, fragment_unnamed_713));
				float fragment_unnamed_720 = rsqrt(dot(float3(fragment_unnamed_690, fragment_unnamed_702, fragment_unnamed_714), float3(fragment_unnamed_690, fragment_unnamed_702, fragment_unnamed_714)));
				precise float fragment_unnamed_721 = fragment_unnamed_720 * fragment_unnamed_690;
				precise float fragment_unnamed_722 = fragment_unnamed_720 * fragment_unnamed_702;
				precise float fragment_unnamed_723 = fragment_unnamed_720 * fragment_unnamed_714;
				precise float fragment_unnamed_729 = fragment_unnamed_680 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_730 = fragment_unnamed_680 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_731 = fragment_unnamed_680 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_737 = mad(fragment_unnamed_97, fragment_unnamed_104, fragment_uniform_buffer_2[0u].x);
				float fragment_unnamed_738 = mad(fragment_unnamed_98, fragment_unnamed_104, fragment_uniform_buffer_2[0u].y);
				float fragment_unnamed_739 = mad(fragment_unnamed_99, fragment_unnamed_104, fragment_uniform_buffer_2[0u].z);
				float fragment_unnamed_743 = rsqrt(dot(float3(fragment_unnamed_737, fragment_unnamed_738, fragment_unnamed_739), float3(fragment_unnamed_737, fragment_unnamed_738, fragment_unnamed_739)));
				precise float fragment_unnamed_744 = fragment_unnamed_743 * fragment_unnamed_737;
				precise float fragment_unnamed_745 = fragment_unnamed_743 * fragment_unnamed_738;
				precise float fragment_unnamed_746 = fragment_unnamed_743 * fragment_unnamed_739;
				float fragment_unnamed_759 = max(dot(float3(fragment_unnamed_721, fragment_unnamed_722, fragment_unnamed_723), float3(fragment_uniform_buffer_2[0u].xyz)), 0.0f);
				precise float fragment_unnamed_760 = mad(fragment_unnamed_280, fragment_unnamed_531, fragment_uniform_buffer_0[35u].y) * 128.0f;
				precise float fragment_unnamed_763 = log2(max(dot(float3(fragment_unnamed_721, fragment_unnamed_722, fragment_unnamed_723), float3(fragment_unnamed_744, fragment_unnamed_745, fragment_unnamed_746)), 0.0f)) * fragment_unnamed_760;
				float fragment_unnamed_764 = exp2(fragment_unnamed_763);
				precise float fragment_unnamed_765 = fragment_unnamed_729 * fragment_unnamed_308;
				precise float fragment_unnamed_766 = fragment_unnamed_730 * fragment_unnamed_309;
				precise float fragment_unnamed_767 = fragment_unnamed_731 * fragment_unnamed_310;
				precise float fragment_unnamed_773 = fragment_unnamed_729 * fragment_uniform_buffer_0[3u].x;
				precise float fragment_unnamed_774 = fragment_unnamed_730 * fragment_uniform_buffer_0[3u].y;
				precise float fragment_unnamed_775 = fragment_unnamed_731 * fragment_uniform_buffer_0[3u].z;
				precise float fragment_unnamed_776 = fragment_unnamed_764 * fragment_unnamed_773;
				precise float fragment_unnamed_777 = fragment_unnamed_764 * fragment_unnamed_774;
				precise float fragment_unnamed_778 = fragment_unnamed_764 * fragment_unnamed_775;
				fragment_output_0.x = mad(fragment_unnamed_765, fragment_unnamed_759, fragment_unnamed_776);
				fragment_output_0.y = mad(fragment_unnamed_766, fragment_unnamed_759, fragment_unnamed_777);
				fragment_output_0.z = mad(fragment_unnamed_767, fragment_unnamed_759, fragment_unnamed_778);
				fragment_output_0.w = fragment_unnamed_305;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[3] = float4(_SpecColor[0], _SpecColor[1], _SpecColor[2], _SpecColor[3]);

				fragment_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				fragment_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				fragment_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				fragment_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_uniform_buffer_0[8] = float4(_FaceUVSpeedX, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _FaceUVSpeedY, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[9] = float4(_FaceColor[0], _FaceColor[1], _FaceColor[2], _FaceColor[3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], _OutlineSoftness, fragment_uniform_buffer_0[10][2], fragment_uniform_buffer_0[10][3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], fragment_uniform_buffer_0[10][1], _OutlineUVSpeedX, fragment_uniform_buffer_0[10][3]);

				fragment_uniform_buffer_0[10] = float4(fragment_uniform_buffer_0[10][0], fragment_uniform_buffer_0[10][1], fragment_uniform_buffer_0[10][2], _OutlineUVSpeedY);

				fragment_uniform_buffer_0[11] = float4(_OutlineColor[0], _OutlineColor[1], _OutlineColor[2], _OutlineColor[3]);

				fragment_uniform_buffer_0[12] = float4(_OutlineWidth, fragment_uniform_buffer_0[12][1], fragment_uniform_buffer_0[12][2], fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], _Bevel, fragment_uniform_buffer_0[12][2], fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], fragment_uniform_buffer_0[12][1], _BevelOffset, fragment_uniform_buffer_0[12][3]);

				fragment_uniform_buffer_0[12] = float4(fragment_uniform_buffer_0[12][0], fragment_uniform_buffer_0[12][1], fragment_uniform_buffer_0[12][2], _BevelWidth);

				fragment_uniform_buffer_0[13] = float4(_BevelClamp, fragment_uniform_buffer_0[13][1], fragment_uniform_buffer_0[13][2], fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], _BevelRoundness, fragment_uniform_buffer_0[13][2], fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], fragment_uniform_buffer_0[13][1], _BumpOutline, fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], fragment_uniform_buffer_0[13][1], fragment_uniform_buffer_0[13][2], _BumpFace);

				fragment_uniform_buffer_0[28] = float4(_ShaderFlags, fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], fragment_uniform_buffer_0[28][3]);

				fragment_uniform_buffer_0[28] = float4(fragment_uniform_buffer_0[28][0], fragment_uniform_buffer_0[28][1], fragment_uniform_buffer_0[28][2], _ScaleRatioA);

				fragment_uniform_buffer_0[33] = float4(fragment_uniform_buffer_0[33][0], fragment_uniform_buffer_0[33][1], _TextureWidth, fragment_uniform_buffer_0[33][3]);

				fragment_uniform_buffer_0[33] = float4(fragment_uniform_buffer_0[33][0], fragment_uniform_buffer_0[33][1], fragment_uniform_buffer_0[33][2], _TextureHeight);

				fragment_uniform_buffer_0[34] = float4(_GradientScale, fragment_uniform_buffer_0[34][1], fragment_uniform_buffer_0[34][2], fragment_uniform_buffer_0[34][3]);

				fragment_uniform_buffer_0[35] = float4(fragment_uniform_buffer_0[35][0], _FaceShininess, fragment_uniform_buffer_0[35][2], fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_0[35] = float4(fragment_uniform_buffer_0[35][0], fragment_uniform_buffer_0[35][1], _OutlineShininess, fragment_uniform_buffer_0[35][3]);

				fragment_uniform_buffer_1[0] = float4(_Time[0], _Time[1], _Time[2], _Time[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

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
				fragment_input_9 = stage_input.fragment_input_9;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(DIRECTIONAL_COOKIE) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(POINT_COOKIE)


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
			GpuProgramID 184110

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
