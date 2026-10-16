Shader "ProBuilder/Standard Vertex Color"
{
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0, 1)) = 0.5
		_Metallic ("Metallic", Range(0, 1)) = 0
	}
	SubShader
	{
		LOD 200
		Tags { "RenderType" = "Opaque" }
		Pass
		{
			Name "FORWARD"
			LOD 200
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 49067

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#pragma shader_feature DIRECTIONAL
			#pragma multi_compile _ LIGHTPROBE_SH
			#pragma multi_compile _ SHADOWS_SCREEN
			#pragma multi_compile _ VERTEXLIGHT_ON


			#if defined(DIRECTIONAL) && !defined(LIGHTPROBE_SH) && !defined(SHADOWS_SCREEN) && !defined(VERTEXLIGHT_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _MainTex_ST;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float4 vertex_output_5 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_6 : TEXCOORD6; // TEXCOORD_6
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_56 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_59 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				float vertex_unnamed_82 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_56));
				float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_57));
				float vertex_unnamed_84 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_58));
				precise float vertex_unnamed_93 = vertex_unnamed_82 + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_94 = vertex_unnamed_83 + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_95 = vertex_unnamed_84 + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_96 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_59)) + vertex_uniform_buffer_1[3u].w;
				vertex_output_3.x = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_82);
				vertex_output_3.y = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_83);
				vertex_output_3.z = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_84);
				precise float vertex_unnamed_118 = vertex_unnamed_94 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_119 = vertex_unnamed_94 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_120 = vertex_unnamed_94 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_121 = vertex_unnamed_94 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_96, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_95, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_93, vertex_unnamed_118)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_96, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_95, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_93, vertex_unnamed_119)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_96, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_95, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_93, vertex_unnamed_120)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_96, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_95, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_93, vertex_unnamed_121)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[6u].x, vertex_uniform_buffer_0[6u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[6u].y, vertex_uniform_buffer_0[6u].w);
				float vertex_unnamed_188 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_203 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_217 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_223 = rsqrt(dot(float3(vertex_unnamed_188, vertex_unnamed_203, vertex_unnamed_217), float3(vertex_unnamed_188, vertex_unnamed_203, vertex_unnamed_217)));
				precise float vertex_unnamed_224 = vertex_unnamed_223 * vertex_unnamed_188;
				precise float vertex_unnamed_225 = vertex_unnamed_223 * vertex_unnamed_203;
				precise float vertex_unnamed_226 = vertex_unnamed_223 * vertex_unnamed_217;
				vertex_output_2.x = vertex_unnamed_224;
				vertex_output_2.y = vertex_unnamed_225;
				vertex_output_2.z = vertex_unnamed_226;
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				vertex_output_5.x = 0.0f;
				vertex_output_5.y = 0.0f;
				vertex_output_5.z = 0.0f;
				vertex_output_5.w = 0.0f;
				vertex_output_6.x = 0.0f;
				vertex_output_6.y = 0.0f;
				vertex_output_6.z = 0.0f;
				vertex_output_6.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_2[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_2[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_2[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}


			float4 _LightColor0;
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_OcclusionMaskSelector;
			float4 unity_SpecCube0_BoxMax;
			float4 unity_SpecCube0_BoxMin;
			float4 unity_SpecCube0_ProbePosition;
			float4 unity_SpecCube0_HDR;
			float4 unity_SpecCube1_BoxMax;
			float4 unity_SpecCube1_BoxMin;
			float4 unity_SpecCube1_ProbePosition;
			float4 unity_SpecCube1_HDR;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[6];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[8];
			static float4 fragment_uniform_buffer_4[7];
			Texture2D<float4> _MainTex;
			TextureCube<float4> unity_SpecCube0;
			TextureCube<float4> unity_SpecCube1;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_SpecCube0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float4 fragment_input_5 : TEXCOORD5; // TEXCOORD_5
				float4 fragment_input_6 : TEXCOORD6; // TEXCOORD_6
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_73 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_78 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_82 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_90 = fragment_unnamed_73 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_91 = fragment_unnamed_78 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_92 = fragment_unnamed_82 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_97 = rsqrt(dot(float3(fragment_unnamed_90, fragment_unnamed_91, fragment_unnamed_92), float3(fragment_unnamed_90, fragment_unnamed_91, fragment_unnamed_92)));
				precise float fragment_unnamed_98 = fragment_unnamed_97 * fragment_unnamed_90;
				precise float fragment_unnamed_99 = fragment_unnamed_97 * fragment_unnamed_91;
				precise float fragment_unnamed_100 = fragment_unnamed_97 * fragment_unnamed_92;
				float4 fragment_unnamed_108 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_118 = fragment_unnamed_108.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_119 = fragment_unnamed_108.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_120 = fragment_unnamed_108.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_127 = fragment_unnamed_118 * fragment_input_4.x;
				precise float fragment_unnamed_128 = fragment_unnamed_119 * fragment_input_4.y;
				precise float fragment_unnamed_129 = fragment_unnamed_120 * fragment_input_4.z;
				float fragment_unnamed_229;
				float fragment_unnamed_230;
				float fragment_unnamed_231;
				float fragment_unnamed_232;
				if (fragment_uniform_buffer_4[0u].x == 1.0f)
				{
					bool fragment_unnamed_139 = fragment_uniform_buffer_4[0u].y == 1.0f;
					precise float fragment_unnamed_147 = fragment_input_3.y * fragment_uniform_buffer_4[2u].x;
					precise float fragment_unnamed_148 = fragment_input_3.y * fragment_uniform_buffer_4[2u].y;
					precise float fragment_unnamed_149 = fragment_input_3.y * fragment_uniform_buffer_4[2u].z;
					precise float fragment_unnamed_176 = mad(fragment_uniform_buffer_4[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_4[1u].x, fragment_input_3.x, fragment_unnamed_147)) + fragment_uniform_buffer_4[4u].x;
					precise float fragment_unnamed_177 = mad(fragment_uniform_buffer_4[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_4[1u].y, fragment_input_3.x, fragment_unnamed_148)) + fragment_uniform_buffer_4[4u].y;
					precise float fragment_unnamed_178 = mad(fragment_uniform_buffer_4[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_4[1u].z, fragment_input_3.x, fragment_unnamed_149)) + fragment_uniform_buffer_4[4u].z;
					precise float fragment_unnamed_191 = (-0.0f) - fragment_uniform_buffer_4[6u].x;
					precise float fragment_unnamed_193 = (-0.0f) - fragment_uniform_buffer_4[6u].y;
					precise float fragment_unnamed_195 = (-0.0f) - fragment_uniform_buffer_4[6u].z;
					precise float fragment_unnamed_196 = (fragment_unnamed_139 ? fragment_unnamed_176 : fragment_input_3.x) + fragment_unnamed_191;
					precise float fragment_unnamed_197 = (fragment_unnamed_139 ? fragment_unnamed_177 : fragment_input_3.y) + fragment_unnamed_193;
					precise float fragment_unnamed_198 = (fragment_unnamed_139 ? fragment_unnamed_178 : fragment_input_3.z) + fragment_unnamed_195;
					precise float fragment_unnamed_204 = fragment_unnamed_196 * fragment_uniform_buffer_4[5u].x;
					precise float fragment_unnamed_205 = fragment_unnamed_197 * fragment_uniform_buffer_4[5u].y;
					precise float fragment_unnamed_206 = fragment_unnamed_198 * fragment_uniform_buffer_4[5u].z;
					float4 fragment_unnamed_218 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_204, 0.25f, 0.75f), mad(fragment_uniform_buffer_4[0u].z, 0.5f, 0.75f)), fragment_unnamed_205, fragment_unnamed_206));
					fragment_unnamed_229 = fragment_unnamed_218.x;
					fragment_unnamed_230 = fragment_unnamed_218.y;
					fragment_unnamed_231 = fragment_unnamed_218.z;
					fragment_unnamed_232 = fragment_unnamed_218.w;
				}
				else
				{
					fragment_unnamed_229 = asfloat(1065353216u);
					fragment_unnamed_230 = asfloat(1065353216u);
					fragment_unnamed_231 = asfloat(1065353216u);
					fragment_unnamed_232 = asfloat(1065353216u);
				}
				float fragment_unnamed_243 = clamp(dot(float4(fragment_unnamed_229, fragment_unnamed_230, fragment_unnamed_231, fragment_unnamed_232), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f);
				precise float fragment_unnamed_247 = (-0.0f) - fragment_uniform_buffer_0[4u].x;
				precise float fragment_unnamed_248 = fragment_unnamed_247 + 1.0f;
				precise float fragment_unnamed_249 = (-0.0f) - fragment_unnamed_98;
				precise float fragment_unnamed_250 = (-0.0f) - fragment_unnamed_99;
				precise float fragment_unnamed_251 = (-0.0f) - fragment_unnamed_100;
				float fragment_unnamed_258 = dot(float3(fragment_unnamed_249, fragment_unnamed_250, fragment_unnamed_251), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z));
				precise float fragment_unnamed_261 = fragment_unnamed_258 + fragment_unnamed_258;
				precise float fragment_unnamed_268 = (-0.0f) - fragment_unnamed_261;
				precise float fragment_unnamed_269 = (-0.0f) - fragment_unnamed_98;
				precise float fragment_unnamed_270 = (-0.0f) - fragment_unnamed_99;
				precise float fragment_unnamed_271 = (-0.0f) - fragment_unnamed_100;
				float fragment_unnamed_272 = mad(fragment_input_2.x, fragment_unnamed_268, fragment_unnamed_269);
				float fragment_unnamed_273 = mad(fragment_input_2.y, fragment_unnamed_268, fragment_unnamed_270);
				float fragment_unnamed_274 = mad(fragment_input_2.z, fragment_unnamed_268, fragment_unnamed_271);
				precise float fragment_unnamed_280 = fragment_unnamed_243 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_281 = fragment_unnamed_243 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_282 = fragment_unnamed_243 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_371;
				float fragment_unnamed_372;
				float fragment_unnamed_373;
				if (0.0f < fragment_uniform_buffer_3[2u].w)
				{
					float fragment_unnamed_290 = rsqrt(dot(float3(fragment_unnamed_272, fragment_unnamed_273, fragment_unnamed_274), float3(fragment_unnamed_272, fragment_unnamed_273, fragment_unnamed_274)));
					precise float fragment_unnamed_291 = fragment_unnamed_290 * fragment_unnamed_272;
					precise float fragment_unnamed_292 = fragment_unnamed_290 * fragment_unnamed_273;
					precise float fragment_unnamed_293 = fragment_unnamed_290 * fragment_unnamed_274;
					precise float fragment_unnamed_296 = (-0.0f) - fragment_input_3.x;
					precise float fragment_unnamed_299 = (-0.0f) - fragment_input_3.y;
					precise float fragment_unnamed_302 = (-0.0f) - fragment_input_3.z;
					precise float fragment_unnamed_308 = fragment_unnamed_296 + fragment_uniform_buffer_3[0u].x;
					precise float fragment_unnamed_309 = fragment_unnamed_299 + fragment_uniform_buffer_3[0u].y;
					precise float fragment_unnamed_310 = fragment_unnamed_302 + fragment_uniform_buffer_3[0u].z;
					precise float fragment_unnamed_311 = fragment_unnamed_308 / fragment_unnamed_291;
					precise float fragment_unnamed_312 = fragment_unnamed_309 / fragment_unnamed_292;
					precise float fragment_unnamed_313 = fragment_unnamed_310 / fragment_unnamed_293;
					precise float fragment_unnamed_316 = (-0.0f) - fragment_input_3.x;
					precise float fragment_unnamed_319 = (-0.0f) - fragment_input_3.y;
					precise float fragment_unnamed_322 = (-0.0f) - fragment_input_3.z;
					precise float fragment_unnamed_328 = fragment_unnamed_316 + fragment_uniform_buffer_3[1u].x;
					precise float fragment_unnamed_329 = fragment_unnamed_319 + fragment_uniform_buffer_3[1u].y;
					precise float fragment_unnamed_330 = fragment_unnamed_322 + fragment_uniform_buffer_3[1u].z;
					precise float fragment_unnamed_331 = fragment_unnamed_328 / fragment_unnamed_291;
					precise float fragment_unnamed_332 = fragment_unnamed_329 / fragment_unnamed_292;
					precise float fragment_unnamed_333 = fragment_unnamed_330 / fragment_unnamed_293;
					float fragment_unnamed_350 = min(asfloat((0.0f < fragment_unnamed_293) ? asuint(fragment_unnamed_313) : asuint(fragment_unnamed_333)), min(asfloat((0.0f < fragment_unnamed_292) ? asuint(fragment_unnamed_312) : asuint(fragment_unnamed_332)), asfloat((0.0f < fragment_unnamed_291) ? asuint(fragment_unnamed_311) : asuint(fragment_unnamed_331))));
					precise float fragment_unnamed_360 = (-0.0f) - fragment_uniform_buffer_3[2u].x;
					precise float fragment_unnamed_362 = (-0.0f) - fragment_uniform_buffer_3[2u].y;
					precise float fragment_unnamed_364 = (-0.0f) - fragment_uniform_buffer_3[2u].z;
					precise float fragment_unnamed_365 = fragment_input_3.x + fragment_unnamed_360;
					precise float fragment_unnamed_366 = fragment_input_3.y + fragment_unnamed_362;
					precise float fragment_unnamed_367 = fragment_input_3.z + fragment_unnamed_364;
					fragment_unnamed_371 = mad(fragment_unnamed_291, fragment_unnamed_350, fragment_unnamed_365);
					fragment_unnamed_372 = mad(fragment_unnamed_292, fragment_unnamed_350, fragment_unnamed_366);
					fragment_unnamed_373 = mad(fragment_unnamed_293, fragment_unnamed_350, fragment_unnamed_367);
				}
				else
				{
					fragment_unnamed_371 = fragment_unnamed_272;
					fragment_unnamed_372 = fragment_unnamed_273;
					fragment_unnamed_373 = fragment_unnamed_274;
				}
				precise float fragment_unnamed_374 = (-0.0f) - fragment_unnamed_248;
				precise float fragment_unnamed_378 = mad(fragment_unnamed_374, 0.699999988079071044921875f, 1.7000000476837158203125f) * fragment_unnamed_248;
				precise float fragment_unnamed_379 = fragment_unnamed_378 * 6.0f;
				float4 fragment_unnamed_383 = unity_SpecCube0.SampleLevel(samplerunity_SpecCube0, float3(fragment_unnamed_371, fragment_unnamed_372, fragment_unnamed_373), fragment_unnamed_379);
				float fragment_unnamed_385 = fragment_unnamed_383.x;
				float fragment_unnamed_386 = fragment_unnamed_383.y;
				float fragment_unnamed_387 = fragment_unnamed_383.z;
				precise float fragment_unnamed_389 = fragment_unnamed_383.w + (-1.0f);
				precise float fragment_unnamed_398 = mad(fragment_uniform_buffer_3[3u].w, fragment_unnamed_389, 1.0f) * fragment_uniform_buffer_3[3u].x;
				precise float fragment_unnamed_399 = fragment_unnamed_385 * fragment_unnamed_398;
				precise float fragment_unnamed_400 = fragment_unnamed_386 * fragment_unnamed_398;
				precise float fragment_unnamed_401 = fragment_unnamed_387 * fragment_unnamed_398;
				float fragment_unnamed_411;
				float fragment_unnamed_413;
				float fragment_unnamed_415;
				if (fragment_uniform_buffer_3[1u].w < 0.999989986419677734375f)
				{
					float fragment_unnamed_711;
					float fragment_unnamed_712;
					float fragment_unnamed_713;
					if (0.0f < fragment_uniform_buffer_3[6u].w)
					{
						float fragment_unnamed_630 = rsqrt(dot(float3(fragment_unnamed_272, fragment_unnamed_273, fragment_unnamed_274), float3(fragment_unnamed_272, fragment_unnamed_273, fragment_unnamed_274)));
						precise float fragment_unnamed_631 = fragment_unnamed_630 * fragment_unnamed_272;
						precise float fragment_unnamed_632 = fragment_unnamed_630 * fragment_unnamed_273;
						precise float fragment_unnamed_633 = fragment_unnamed_630 * fragment_unnamed_274;
						precise float fragment_unnamed_636 = (-0.0f) - fragment_input_3.x;
						precise float fragment_unnamed_639 = (-0.0f) - fragment_input_3.y;
						precise float fragment_unnamed_642 = (-0.0f) - fragment_input_3.z;
						precise float fragment_unnamed_648 = fragment_unnamed_636 + fragment_uniform_buffer_3[4u].x;
						precise float fragment_unnamed_649 = fragment_unnamed_639 + fragment_uniform_buffer_3[4u].y;
						precise float fragment_unnamed_650 = fragment_unnamed_642 + fragment_uniform_buffer_3[4u].z;
						precise float fragment_unnamed_651 = fragment_unnamed_648 / fragment_unnamed_631;
						precise float fragment_unnamed_652 = fragment_unnamed_649 / fragment_unnamed_632;
						precise float fragment_unnamed_653 = fragment_unnamed_650 / fragment_unnamed_633;
						precise float fragment_unnamed_656 = (-0.0f) - fragment_input_3.x;
						precise float fragment_unnamed_659 = (-0.0f) - fragment_input_3.y;
						precise float fragment_unnamed_662 = (-0.0f) - fragment_input_3.z;
						precise float fragment_unnamed_668 = fragment_unnamed_656 + fragment_uniform_buffer_3[5u].x;
						precise float fragment_unnamed_669 = fragment_unnamed_659 + fragment_uniform_buffer_3[5u].y;
						precise float fragment_unnamed_670 = fragment_unnamed_662 + fragment_uniform_buffer_3[5u].z;
						precise float fragment_unnamed_671 = fragment_unnamed_668 / fragment_unnamed_631;
						precise float fragment_unnamed_672 = fragment_unnamed_669 / fragment_unnamed_632;
						precise float fragment_unnamed_673 = fragment_unnamed_670 / fragment_unnamed_633;
						float fragment_unnamed_690 = min(asfloat((0.0f < fragment_unnamed_633) ? asuint(fragment_unnamed_653) : asuint(fragment_unnamed_673)), min(asfloat((0.0f < fragment_unnamed_632) ? asuint(fragment_unnamed_652) : asuint(fragment_unnamed_672)), asfloat((0.0f < fragment_unnamed_631) ? asuint(fragment_unnamed_651) : asuint(fragment_unnamed_671))));
						precise float fragment_unnamed_700 = (-0.0f) - fragment_uniform_buffer_3[6u].x;
						precise float fragment_unnamed_702 = (-0.0f) - fragment_uniform_buffer_3[6u].y;
						precise float fragment_unnamed_704 = (-0.0f) - fragment_uniform_buffer_3[6u].z;
						precise float fragment_unnamed_705 = fragment_input_3.x + fragment_unnamed_700;
						precise float fragment_unnamed_706 = fragment_input_3.y + fragment_unnamed_702;
						precise float fragment_unnamed_707 = fragment_input_3.z + fragment_unnamed_704;
						fragment_unnamed_711 = mad(fragment_unnamed_631, fragment_unnamed_690, fragment_unnamed_705);
						fragment_unnamed_712 = mad(fragment_unnamed_632, fragment_unnamed_690, fragment_unnamed_706);
						fragment_unnamed_713 = mad(fragment_unnamed_633, fragment_unnamed_690, fragment_unnamed_707);
					}
					else
					{
						fragment_unnamed_711 = fragment_unnamed_272;
						fragment_unnamed_712 = fragment_unnamed_273;
						fragment_unnamed_713 = fragment_unnamed_274;
					}
					float4 fragment_unnamed_715 = unity_SpecCube1.SampleLevel(samplerunity_SpecCube0, float3(fragment_unnamed_711, fragment_unnamed_712, fragment_unnamed_713), fragment_unnamed_379);
					precise float fragment_unnamed_721 = fragment_unnamed_715.w + (-1.0f);
					precise float fragment_unnamed_729 = mad(fragment_uniform_buffer_3[7u].w, fragment_unnamed_721, 1.0f) * fragment_uniform_buffer_3[7u].x;
					precise float fragment_unnamed_730 = fragment_unnamed_715.x * fragment_unnamed_729;
					precise float fragment_unnamed_731 = fragment_unnamed_715.y * fragment_unnamed_729;
					precise float fragment_unnamed_732 = fragment_unnamed_715.z * fragment_unnamed_729;
					precise float fragment_unnamed_733 = (-0.0f) - fragment_unnamed_730;
					precise float fragment_unnamed_734 = (-0.0f) - fragment_unnamed_731;
					precise float fragment_unnamed_735 = (-0.0f) - fragment_unnamed_732;
					fragment_unnamed_411 = mad(fragment_uniform_buffer_3[1u].w, mad(fragment_unnamed_398, fragment_unnamed_385, fragment_unnamed_733), fragment_unnamed_730);
					fragment_unnamed_413 = mad(fragment_uniform_buffer_3[1u].w, mad(fragment_unnamed_398, fragment_unnamed_386, fragment_unnamed_734), fragment_unnamed_731);
					fragment_unnamed_415 = mad(fragment_uniform_buffer_3[1u].w, mad(fragment_unnamed_398, fragment_unnamed_387, fragment_unnamed_735), fragment_unnamed_732);
				}
				else
				{
					fragment_unnamed_411 = fragment_unnamed_399;
					fragment_unnamed_413 = fragment_unnamed_400;
					fragment_unnamed_415 = fragment_unnamed_401;
				}
				float fragment_unnamed_432 = rsqrt(dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z)));
				precise float fragment_unnamed_439 = fragment_unnamed_432 * fragment_input_2.x;
				precise float fragment_unnamed_440 = fragment_unnamed_432 * fragment_input_2.y;
				precise float fragment_unnamed_441 = fragment_unnamed_432 * fragment_input_2.z;
				float fragment_unnamed_455 = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_118, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_457 = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_119, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_458 = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_120, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_462 = (-0.0f) - fragment_uniform_buffer_0[4u].y;
				float fragment_unnamed_463 = mad(fragment_unnamed_462, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_465 = fragment_unnamed_463 * fragment_unnamed_127;
				precise float fragment_unnamed_466 = fragment_unnamed_463 * fragment_unnamed_128;
				precise float fragment_unnamed_467 = fragment_unnamed_463 * fragment_unnamed_129;
				float fragment_unnamed_473 = mad(fragment_unnamed_90, fragment_unnamed_97, fragment_uniform_buffer_2[0u].x);
				float fragment_unnamed_474 = mad(fragment_unnamed_91, fragment_unnamed_97, fragment_uniform_buffer_2[0u].y);
				float fragment_unnamed_475 = mad(fragment_unnamed_92, fragment_unnamed_97, fragment_uniform_buffer_2[0u].z);
				float fragment_unnamed_481 = rsqrt(max(dot(float3(fragment_unnamed_473, fragment_unnamed_474, fragment_unnamed_475), float3(fragment_unnamed_473, fragment_unnamed_474, fragment_unnamed_475)), 0.001000000047497451305389404296875f));
				precise float fragment_unnamed_482 = fragment_unnamed_481 * fragment_unnamed_473;
				precise float fragment_unnamed_483 = fragment_unnamed_481 * fragment_unnamed_474;
				precise float fragment_unnamed_484 = fragment_unnamed_481 * fragment_unnamed_475;
				float fragment_unnamed_485 = dot(float3(fragment_unnamed_439, fragment_unnamed_440, fragment_unnamed_441), float3(fragment_unnamed_98, fragment_unnamed_99, fragment_unnamed_100));
				float fragment_unnamed_496 = clamp(dot(float3(fragment_unnamed_439, fragment_unnamed_440, fragment_unnamed_441), float3(fragment_uniform_buffer_2[0u].xyz)), 0.0f, 1.0f);
				float fragment_unnamed_500 = clamp(dot(float3(fragment_unnamed_439, fragment_unnamed_440, fragment_unnamed_441), float3(fragment_unnamed_482, fragment_unnamed_483, fragment_unnamed_484)), 0.0f, 1.0f);
				float fragment_unnamed_509 = clamp(dot(float3(fragment_uniform_buffer_2[0u].xyz), float3(fragment_unnamed_482, fragment_unnamed_483, fragment_unnamed_484)), 0.0f, 1.0f);
				precise float fragment_unnamed_510 = fragment_unnamed_509 * fragment_unnamed_509;
				precise float fragment_unnamed_514 = dot(fragment_unnamed_510.xx, fragment_unnamed_248.xx) + (-0.5f);
				precise float fragment_unnamed_516 = (-0.0f) - fragment_unnamed_496;
				precise float fragment_unnamed_517 = fragment_unnamed_516 + 1.0f;
				precise float fragment_unnamed_518 = fragment_unnamed_517 * fragment_unnamed_517;
				precise float fragment_unnamed_519 = fragment_unnamed_518 * fragment_unnamed_518;
				precise float fragment_unnamed_520 = fragment_unnamed_517 * fragment_unnamed_519;
				precise float fragment_unnamed_523 = (-0.0f) - abs(fragment_unnamed_485);
				precise float fragment_unnamed_524 = fragment_unnamed_523 + 1.0f;
				precise float fragment_unnamed_525 = fragment_unnamed_524 * fragment_unnamed_524;
				precise float fragment_unnamed_526 = fragment_unnamed_525 * fragment_unnamed_525;
				precise float fragment_unnamed_527 = fragment_unnamed_524 * fragment_unnamed_526;
				precise float fragment_unnamed_529 = mad(fragment_unnamed_514, fragment_unnamed_527, 1.0f) * mad(fragment_unnamed_514, fragment_unnamed_520, 1.0f);
				precise float fragment_unnamed_530 = fragment_unnamed_248 * fragment_unnamed_248;
				float fragment_unnamed_531 = max(fragment_unnamed_530, 0.00200000009499490261077880859375f);
				precise float fragment_unnamed_533 = (-0.0f) - fragment_unnamed_531;
				precise float fragment_unnamed_534 = fragment_unnamed_533 + 1.0f;
				precise float fragment_unnamed_539 = abs(fragment_unnamed_485) * mad(fragment_unnamed_496, fragment_unnamed_534, fragment_unnamed_531);
				precise float fragment_unnamed_541 = mad(fragment_unnamed_496, mad(abs(fragment_unnamed_485), fragment_unnamed_534, fragment_unnamed_531), fragment_unnamed_539) + 9.9999997473787516355514526367188e-06f;
				precise float fragment_unnamed_543 = 0.5f / fragment_unnamed_541;
				precise float fragment_unnamed_544 = fragment_unnamed_531 * fragment_unnamed_531;
				precise float fragment_unnamed_545 = (-0.0f) - fragment_unnamed_500;
				float fragment_unnamed_547 = mad(mad(fragment_unnamed_500, fragment_unnamed_544, fragment_unnamed_545), fragment_unnamed_500, 1.0f);
				precise float fragment_unnamed_548 = fragment_unnamed_544 * 0.3183098733425140380859375f;
				precise float fragment_unnamed_552 = fragment_unnamed_548 / mad(fragment_unnamed_547, fragment_unnamed_547, 1.0000000116860974230803549289703e-07f);
				precise float fragment_unnamed_553 = fragment_unnamed_543 * fragment_unnamed_552;
				precise float fragment_unnamed_554 = fragment_unnamed_531 * 0.2800000011920928955078125f;
				precise float fragment_unnamed_556 = fragment_unnamed_553 * 3.1415927410125732421875f;
				precise float fragment_unnamed_561 = fragment_unnamed_496 * fragment_unnamed_529;
				precise float fragment_unnamed_562 = fragment_unnamed_496 * sqrt(max(fragment_unnamed_556, 9.9999997473787516355514526367188e-05f));
				precise float fragment_unnamed_563 = (-0.0f) - fragment_unnamed_554;
				float fragment_unnamed_564 = mad(fragment_unnamed_563, fragment_unnamed_248, 1.0f);
				precise float fragment_unnamed_573 = fragment_unnamed_562 * asfloat(((dot(float3(fragment_unnamed_455, fragment_unnamed_457, fragment_unnamed_458), float3(fragment_unnamed_455, fragment_unnamed_457, fragment_unnamed_458)) != 0.0f) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_574 = (-0.0f) - fragment_unnamed_463;
				precise float fragment_unnamed_578 = fragment_unnamed_574 + fragment_uniform_buffer_0[4u].x;
				precise float fragment_unnamed_579 = fragment_unnamed_578 + 1.0f;
				float fragment_unnamed_580 = clamp(fragment_unnamed_579, 0.0f, 1.0f);
				precise float fragment_unnamed_581 = fragment_unnamed_561 * fragment_unnamed_280;
				precise float fragment_unnamed_582 = fragment_unnamed_561 * fragment_unnamed_281;
				precise float fragment_unnamed_583 = fragment_unnamed_561 * fragment_unnamed_282;
				precise float fragment_unnamed_584 = fragment_unnamed_280 * fragment_unnamed_573;
				precise float fragment_unnamed_585 = fragment_unnamed_281 * fragment_unnamed_573;
				precise float fragment_unnamed_586 = fragment_unnamed_282 * fragment_unnamed_573;
				precise float fragment_unnamed_587 = (-0.0f) - fragment_unnamed_509;
				precise float fragment_unnamed_588 = fragment_unnamed_587 + 1.0f;
				precise float fragment_unnamed_589 = fragment_unnamed_588 * fragment_unnamed_588;
				precise float fragment_unnamed_590 = fragment_unnamed_589 * fragment_unnamed_589;
				precise float fragment_unnamed_591 = fragment_unnamed_588 * fragment_unnamed_590;
				precise float fragment_unnamed_592 = (-0.0f) - fragment_unnamed_455;
				precise float fragment_unnamed_593 = (-0.0f) - fragment_unnamed_457;
				precise float fragment_unnamed_594 = (-0.0f) - fragment_unnamed_458;
				precise float fragment_unnamed_595 = fragment_unnamed_592 + 1.0f;
				precise float fragment_unnamed_596 = fragment_unnamed_593 + 1.0f;
				precise float fragment_unnamed_597 = fragment_unnamed_594 + 1.0f;
				precise float fragment_unnamed_601 = mad(fragment_unnamed_595, fragment_unnamed_591, fragment_unnamed_455) * fragment_unnamed_584;
				precise float fragment_unnamed_602 = mad(fragment_unnamed_596, fragment_unnamed_591, fragment_unnamed_457) * fragment_unnamed_585;
				precise float fragment_unnamed_603 = mad(fragment_unnamed_597, fragment_unnamed_591, fragment_unnamed_458) * fragment_unnamed_586;
				precise float fragment_unnamed_607 = fragment_unnamed_411 * fragment_unnamed_564;
				precise float fragment_unnamed_608 = fragment_unnamed_413 * fragment_unnamed_564;
				precise float fragment_unnamed_609 = fragment_unnamed_415 * fragment_unnamed_564;
				precise float fragment_unnamed_610 = (-0.0f) - fragment_unnamed_455;
				precise float fragment_unnamed_611 = (-0.0f) - fragment_unnamed_457;
				precise float fragment_unnamed_612 = (-0.0f) - fragment_unnamed_458;
				precise float fragment_unnamed_613 = fragment_unnamed_610 + fragment_unnamed_580;
				precise float fragment_unnamed_614 = fragment_unnamed_611 + fragment_unnamed_580;
				precise float fragment_unnamed_615 = fragment_unnamed_612 + fragment_unnamed_580;
				fragment_output_0.x = mad(fragment_unnamed_607, mad(fragment_unnamed_527, fragment_unnamed_613, fragment_unnamed_455), mad(fragment_unnamed_465, fragment_unnamed_581, fragment_unnamed_601));
				fragment_output_0.y = mad(fragment_unnamed_608, mad(fragment_unnamed_527, fragment_unnamed_614, fragment_unnamed_457), mad(fragment_unnamed_466, fragment_unnamed_582, fragment_unnamed_602));
				fragment_output_0.z = mad(fragment_unnamed_609, mad(fragment_unnamed_527, fragment_unnamed_615, fragment_unnamed_458), mad(fragment_unnamed_467, fragment_unnamed_583, fragment_unnamed_603));
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[4] = float4(_Glossiness, fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _Metallic, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[5] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_uniform_buffer_2[46] = float4(unity_OcclusionMaskSelector[0], unity_OcclusionMaskSelector[1], unity_OcclusionMaskSelector[2], unity_OcclusionMaskSelector[3]);

				fragment_uniform_buffer_3[0] = float4(unity_SpecCube0_BoxMax[0], unity_SpecCube0_BoxMax[1], unity_SpecCube0_BoxMax[2], unity_SpecCube0_BoxMax[3]);

				fragment_uniform_buffer_3[1] = float4(unity_SpecCube0_BoxMin[0], unity_SpecCube0_BoxMin[1], unity_SpecCube0_BoxMin[2], unity_SpecCube0_BoxMin[3]);

				fragment_uniform_buffer_3[2] = float4(unity_SpecCube0_ProbePosition[0], unity_SpecCube0_ProbePosition[1], unity_SpecCube0_ProbePosition[2], unity_SpecCube0_ProbePosition[3]);

				fragment_uniform_buffer_3[3] = float4(unity_SpecCube0_HDR[0], unity_SpecCube0_HDR[1], unity_SpecCube0_HDR[2], unity_SpecCube0_HDR[3]);

				fragment_uniform_buffer_3[4] = float4(unity_SpecCube1_BoxMax[0], unity_SpecCube1_BoxMax[1], unity_SpecCube1_BoxMax[2], unity_SpecCube1_BoxMax[3]);

				fragment_uniform_buffer_3[5] = float4(unity_SpecCube1_BoxMin[0], unity_SpecCube1_BoxMin[1], unity_SpecCube1_BoxMin[2], unity_SpecCube1_BoxMin[3]);

				fragment_uniform_buffer_3[6] = float4(unity_SpecCube1_ProbePosition[0], unity_SpecCube1_ProbePosition[1], unity_SpecCube1_ProbePosition[2], unity_SpecCube1_ProbePosition[3]);

				fragment_uniform_buffer_3[7] = float4(unity_SpecCube1_HDR[0], unity_SpecCube1_HDR[1], unity_SpecCube1_HDR[2], unity_SpecCube1_HDR[3]);

				fragment_uniform_buffer_4[0] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_4[1] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_4[2] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_4[3] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_4[4] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_4[5] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], fragment_uniform_buffer_4[5][3]);

				fragment_uniform_buffer_4[6] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], fragment_uniform_buffer_4[6][3]);

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

			#endif // defined(DIRECTIONAL) && !defined(LIGHTPROBE_SH) && !defined(SHADOWS_SCREEN) && !defined(VERTEXLIGHT_ON)


			#if defined(DIRECTIONAL) && defined(LIGHTPROBE_SH) && !defined(SHADOWS_SCREEN) && !defined(VERTEXLIGHT_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _MainTex_ST;
			float4 unity_SHBr;
			float4 unity_SHBg;
			float4 unity_SHBb;
			float4 unity_SHC;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
			static float4 vertex_uniform_buffer_1[46];
			static float4 vertex_uniform_buffer_2[8];
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
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static float4 vertex_output_6;
			static float4 vertex_output_7;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float3 vertex_output_5 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_7 : TEXCOORD6; // TEXCOORD_6
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_62 = vertex_input_0.y * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_63 = vertex_input_0.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_64 = vertex_input_0.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_65 = vertex_input_0.y * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_88 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_0.x, vertex_unnamed_62));
				float vertex_unnamed_89 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_0.x, vertex_unnamed_63));
				float vertex_unnamed_90 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_0.x, vertex_unnamed_64));
				precise float vertex_unnamed_99 = vertex_unnamed_88 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_100 = vertex_unnamed_89 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_101 = vertex_unnamed_90 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_102 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_input_0.x, vertex_unnamed_65)) + vertex_uniform_buffer_2[3u].w;
				vertex_output_3.x = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_88);
				vertex_output_3.y = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_89);
				vertex_output_3.z = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_90);
				precise float vertex_unnamed_124 = vertex_unnamed_100 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_125 = vertex_unnamed_100 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_126 = vertex_unnamed_100 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_127 = vertex_unnamed_100 * vertex_uniform_buffer_3[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_102, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_101, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_99, vertex_unnamed_124)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_102, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_101, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_99, vertex_unnamed_125)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_102, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_101, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_99, vertex_unnamed_126)));
				gl_Position.w = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_102, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_101, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_99, vertex_unnamed_127)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[6u].x, vertex_uniform_buffer_0[6u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[6u].y, vertex_uniform_buffer_0[6u].w);
				float vertex_unnamed_194 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_209 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_223 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_229 = rsqrt(dot(float3(vertex_unnamed_194, vertex_unnamed_209, vertex_unnamed_223), float3(vertex_unnamed_194, vertex_unnamed_209, vertex_unnamed_223)));
				precise float vertex_unnamed_230 = vertex_unnamed_229 * vertex_unnamed_194;
				precise float vertex_unnamed_231 = vertex_unnamed_229 * vertex_unnamed_209;
				precise float vertex_unnamed_232 = vertex_unnamed_229 * vertex_unnamed_223;
				vertex_output_2.x = vertex_unnamed_230;
				vertex_output_2.y = vertex_unnamed_231;
				vertex_output_2.z = vertex_unnamed_232;
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				precise float vertex_unnamed_248 = vertex_unnamed_231 * vertex_unnamed_231;
				precise float vertex_unnamed_249 = (-0.0f) - vertex_unnamed_248;
				float vertex_unnamed_251 = mad(vertex_unnamed_230, vertex_unnamed_230, vertex_unnamed_249);
				precise float vertex_unnamed_252 = vertex_unnamed_231 * vertex_unnamed_230;
				precise float vertex_unnamed_253 = vertex_unnamed_232 * vertex_unnamed_231;
				precise float vertex_unnamed_254 = vertex_unnamed_232 * vertex_unnamed_232;
				precise float vertex_unnamed_255 = vertex_unnamed_230 * vertex_unnamed_232;
				vertex_output_5.x = mad(vertex_uniform_buffer_1[45u].x, vertex_unnamed_251, dot(float4(vertex_uniform_buffer_1[42u]), float4(vertex_unnamed_252, vertex_unnamed_253, vertex_unnamed_254, vertex_unnamed_255)));
				vertex_output_5.y = mad(vertex_uniform_buffer_1[45u].y, vertex_unnamed_251, dot(float4(vertex_uniform_buffer_1[43u]), float4(vertex_unnamed_252, vertex_unnamed_253, vertex_unnamed_254, vertex_unnamed_255)));
				vertex_output_5.z = mad(vertex_uniform_buffer_1[45u].z, vertex_unnamed_251, dot(float4(vertex_uniform_buffer_1[44u]), float4(vertex_unnamed_252, vertex_unnamed_253, vertex_unnamed_254, vertex_unnamed_255)));
				vertex_output_6.x = 0.0f;
				vertex_output_6.y = 0.0f;
				vertex_output_6.z = 0.0f;
				vertex_output_6.w = 0.0f;
				vertex_output_7.x = 0.0f;
				vertex_output_7.y = 0.0f;
				vertex_output_7.z = 0.0f;
				vertex_output_7.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[42] = float4(unity_SHBr[0], unity_SHBr[1], unity_SHBr[2], unity_SHBr[3]);

				vertex_uniform_buffer_1[43] = float4(unity_SHBg[0], unity_SHBg[1], unity_SHBg[2], unity_SHBg[3]);

				vertex_uniform_buffer_1[44] = float4(unity_SHBb[0], unity_SHBb[1], unity_SHBb[2], unity_SHBb[3]);

				vertex_uniform_buffer_1[45] = float4(unity_SHC[0], unity_SHC[1], unity_SHC[2], unity_SHC[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				return stage_output;
			}


			float4 _LightColor0;
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_SHAr;
			float4 unity_SHAg;
			float4 unity_SHAb;
			float4 unity_OcclusionMaskSelector;
			float4 unity_SpecCube0_BoxMax;
			float4 unity_SpecCube0_BoxMin;
			float4 unity_SpecCube0_ProbePosition;
			float4 unity_SpecCube0_HDR;
			float4 unity_SpecCube1_BoxMax;
			float4 unity_SpecCube1_BoxMin;
			float4 unity_SpecCube1_ProbePosition;
			float4 unity_SpecCube1_HDR;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[6];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[8];
			static float4 fragment_uniform_buffer_4[7];
			Texture2D<float4> _MainTex;
			TextureCube<float4> unity_SpecCube0;
			TextureCube<float4> unity_SpecCube1;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_SpecCube0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_input_7;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float3 fragment_input_5 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_6 : TEXCOORD5; // TEXCOORD_5
				float4 fragment_input_7 : TEXCOORD6; // TEXCOORD_6
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_74 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_79 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_83 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_91 = fragment_unnamed_74 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_92 = fragment_unnamed_79 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_93 = fragment_unnamed_83 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_98 = rsqrt(dot(float3(fragment_unnamed_91, fragment_unnamed_92, fragment_unnamed_93), float3(fragment_unnamed_91, fragment_unnamed_92, fragment_unnamed_93)));
				precise float fragment_unnamed_99 = fragment_unnamed_98 * fragment_unnamed_91;
				precise float fragment_unnamed_100 = fragment_unnamed_98 * fragment_unnamed_92;
				precise float fragment_unnamed_101 = fragment_unnamed_98 * fragment_unnamed_93;
				float4 fragment_unnamed_109 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_119 = fragment_unnamed_109.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_120 = fragment_unnamed_109.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_121 = fragment_unnamed_109.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_128 = fragment_unnamed_119 * fragment_input_4.x;
				precise float fragment_unnamed_129 = fragment_unnamed_120 * fragment_input_4.y;
				precise float fragment_unnamed_130 = fragment_unnamed_121 * fragment_input_4.z;
				bool fragment_unnamed_135 = fragment_uniform_buffer_4[0u].x == 1.0f;
				float fragment_unnamed_230;
				float fragment_unnamed_231;
				float fragment_unnamed_232;
				float fragment_unnamed_233;
				if (fragment_unnamed_135)
				{
					bool fragment_unnamed_140 = fragment_uniform_buffer_4[0u].y == 1.0f;
					precise float fragment_unnamed_148 = fragment_input_3.y * fragment_uniform_buffer_4[2u].x;
					precise float fragment_unnamed_149 = fragment_input_3.y * fragment_uniform_buffer_4[2u].y;
					precise float fragment_unnamed_150 = fragment_input_3.y * fragment_uniform_buffer_4[2u].z;
					precise float fragment_unnamed_177 = mad(fragment_uniform_buffer_4[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_4[1u].x, fragment_input_3.x, fragment_unnamed_148)) + fragment_uniform_buffer_4[4u].x;
					precise float fragment_unnamed_178 = mad(fragment_uniform_buffer_4[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_4[1u].y, fragment_input_3.x, fragment_unnamed_149)) + fragment_uniform_buffer_4[4u].y;
					precise float fragment_unnamed_179 = mad(fragment_uniform_buffer_4[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_4[1u].z, fragment_input_3.x, fragment_unnamed_150)) + fragment_uniform_buffer_4[4u].z;
					precise float fragment_unnamed_192 = (-0.0f) - fragment_uniform_buffer_4[6u].x;
					precise float fragment_unnamed_194 = (-0.0f) - fragment_uniform_buffer_4[6u].y;
					precise float fragment_unnamed_196 = (-0.0f) - fragment_uniform_buffer_4[6u].z;
					precise float fragment_unnamed_197 = (fragment_unnamed_140 ? fragment_unnamed_177 : fragment_input_3.x) + fragment_unnamed_192;
					precise float fragment_unnamed_198 = (fragment_unnamed_140 ? fragment_unnamed_178 : fragment_input_3.y) + fragment_unnamed_194;
					precise float fragment_unnamed_199 = (fragment_unnamed_140 ? fragment_unnamed_179 : fragment_input_3.z) + fragment_unnamed_196;
					precise float fragment_unnamed_205 = fragment_unnamed_197 * fragment_uniform_buffer_4[5u].x;
					precise float fragment_unnamed_206 = fragment_unnamed_198 * fragment_uniform_buffer_4[5u].y;
					precise float fragment_unnamed_207 = fragment_unnamed_199 * fragment_uniform_buffer_4[5u].z;
					float4 fragment_unnamed_219 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_205, 0.25f, 0.75f), mad(fragment_uniform_buffer_4[0u].z, 0.5f, 0.75f)), fragment_unnamed_206, fragment_unnamed_207));
					fragment_unnamed_230 = fragment_unnamed_219.x;
					fragment_unnamed_231 = fragment_unnamed_219.y;
					fragment_unnamed_232 = fragment_unnamed_219.z;
					fragment_unnamed_233 = fragment_unnamed_219.w;
				}
				else
				{
					fragment_unnamed_230 = asfloat(1065353216u);
					fragment_unnamed_231 = asfloat(1065353216u);
					fragment_unnamed_232 = asfloat(1065353216u);
					fragment_unnamed_233 = asfloat(1065353216u);
				}
				float fragment_unnamed_244 = clamp(dot(float4(fragment_unnamed_230, fragment_unnamed_231, fragment_unnamed_232, fragment_unnamed_233), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f);
				precise float fragment_unnamed_248 = (-0.0f) - fragment_uniform_buffer_0[4u].x;
				precise float fragment_unnamed_249 = fragment_unnamed_248 + 1.0f;
				precise float fragment_unnamed_250 = (-0.0f) - fragment_unnamed_99;
				precise float fragment_unnamed_251 = (-0.0f) - fragment_unnamed_100;
				precise float fragment_unnamed_252 = (-0.0f) - fragment_unnamed_101;
				float fragment_unnamed_259 = dot(float3(fragment_unnamed_250, fragment_unnamed_251, fragment_unnamed_252), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z));
				precise float fragment_unnamed_262 = fragment_unnamed_259 + fragment_unnamed_259;
				precise float fragment_unnamed_269 = (-0.0f) - fragment_unnamed_262;
				precise float fragment_unnamed_270 = (-0.0f) - fragment_unnamed_99;
				precise float fragment_unnamed_271 = (-0.0f) - fragment_unnamed_100;
				precise float fragment_unnamed_272 = (-0.0f) - fragment_unnamed_101;
				float fragment_unnamed_273 = mad(fragment_input_2.x, fragment_unnamed_269, fragment_unnamed_270);
				float fragment_unnamed_274 = mad(fragment_input_2.y, fragment_unnamed_269, fragment_unnamed_271);
				float fragment_unnamed_275 = mad(fragment_input_2.z, fragment_unnamed_269, fragment_unnamed_272);
				precise float fragment_unnamed_281 = fragment_unnamed_244 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_282 = fragment_unnamed_244 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_283 = fragment_unnamed_244 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_444;
				float fragment_unnamed_445;
				float fragment_unnamed_446;
				if (fragment_unnamed_135)
				{
					bool fragment_unnamed_287 = fragment_uniform_buffer_4[0u].y == 1.0f;
					precise float fragment_unnamed_295 = fragment_input_3.y * fragment_uniform_buffer_4[2u].x;
					precise float fragment_unnamed_296 = fragment_input_3.y * fragment_uniform_buffer_4[2u].y;
					precise float fragment_unnamed_297 = fragment_input_3.y * fragment_uniform_buffer_4[2u].z;
					precise float fragment_unnamed_323 = mad(fragment_uniform_buffer_4[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_4[1u].x, fragment_input_3.x, fragment_unnamed_295)) + fragment_uniform_buffer_4[4u].x;
					precise float fragment_unnamed_324 = mad(fragment_uniform_buffer_4[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_4[1u].y, fragment_input_3.x, fragment_unnamed_296)) + fragment_uniform_buffer_4[4u].y;
					precise float fragment_unnamed_325 = mad(fragment_uniform_buffer_4[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_4[1u].z, fragment_input_3.x, fragment_unnamed_297)) + fragment_uniform_buffer_4[4u].z;
					precise float fragment_unnamed_338 = (-0.0f) - fragment_uniform_buffer_4[6u].x;
					precise float fragment_unnamed_340 = (-0.0f) - fragment_uniform_buffer_4[6u].y;
					precise float fragment_unnamed_342 = (-0.0f) - fragment_uniform_buffer_4[6u].z;
					precise float fragment_unnamed_343 = (fragment_unnamed_287 ? fragment_unnamed_323 : fragment_input_3.x) + fragment_unnamed_338;
					precise float fragment_unnamed_344 = (fragment_unnamed_287 ? fragment_unnamed_324 : fragment_input_3.y) + fragment_unnamed_340;
					precise float fragment_unnamed_345 = (fragment_unnamed_287 ? fragment_unnamed_325 : fragment_input_3.z) + fragment_unnamed_342;
					precise float fragment_unnamed_351 = fragment_unnamed_343 * fragment_uniform_buffer_4[5u].x;
					precise float fragment_unnamed_352 = fragment_unnamed_344 * fragment_uniform_buffer_4[5u].y;
					precise float fragment_unnamed_353 = fragment_unnamed_345 * fragment_uniform_buffer_4[5u].z;
					precise float fragment_unnamed_354 = fragment_unnamed_351 * 0.25f;
					precise float fragment_unnamed_358 = fragment_uniform_buffer_4[0u].z * 0.5f;
					precise float fragment_unnamed_362 = (-0.0f) - fragment_uniform_buffer_4[0u].z;
					float fragment_unnamed_365 = min(mad(fragment_unnamed_362, 0.5f, 0.25f), max(fragment_unnamed_354, fragment_unnamed_358));
					precise float fragment_unnamed_373 = fragment_unnamed_365 + 0.25f;
					precise float fragment_unnamed_374 = fragment_unnamed_352 + 0.0f;
					precise float fragment_unnamed_375 = fragment_unnamed_353 + 0.0f;
					precise float fragment_unnamed_382 = fragment_unnamed_365 + 0.5f;
					precise float fragment_unnamed_383 = fragment_unnamed_352 + 0.0f;
					precise float fragment_unnamed_384 = fragment_unnamed_353 + 0.0f;
					float fragment_unnamed_397 = asfloat(1065353216u);
					fragment_unnamed_444 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_365, fragment_unnamed_352, fragment_unnamed_353))), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_397));
					fragment_unnamed_445 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_373, fragment_unnamed_374, fragment_unnamed_375))), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_397));
					fragment_unnamed_446 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_382, fragment_unnamed_383, fragment_unnamed_384))), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_397));
				}
				else
				{
					float fragment_unnamed_413 = asfloat(1065353216u);
					fragment_unnamed_444 = dot(float4(fragment_uniform_buffer_2[39u]), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_413));
					fragment_unnamed_445 = dot(float4(fragment_uniform_buffer_2[40u]), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_413));
					fragment_unnamed_446 = dot(float4(fragment_uniform_buffer_2[41u]), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_413));
				}
				precise float fragment_unnamed_453 = fragment_unnamed_444 + fragment_input_5.x;
				precise float fragment_unnamed_454 = fragment_unnamed_445 + fragment_input_5.y;
				precise float fragment_unnamed_455 = fragment_unnamed_446 + fragment_input_5.z;
				precise float fragment_unnamed_462 = log2(max(fragment_unnamed_453, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_464 = log2(max(fragment_unnamed_454, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_465 = log2(max(fragment_unnamed_455, 0.0f)) * 0.4166666567325592041015625f;
				float fragment_unnamed_565;
				float fragment_unnamed_566;
				float fragment_unnamed_567;
				if (0.0f < fragment_uniform_buffer_3[2u].w)
				{
					float fragment_unnamed_484 = rsqrt(dot(float3(fragment_unnamed_273, fragment_unnamed_274, fragment_unnamed_275), float3(fragment_unnamed_273, fragment_unnamed_274, fragment_unnamed_275)));
					precise float fragment_unnamed_485 = fragment_unnamed_484 * fragment_unnamed_273;
					precise float fragment_unnamed_486 = fragment_unnamed_484 * fragment_unnamed_274;
					precise float fragment_unnamed_487 = fragment_unnamed_484 * fragment_unnamed_275;
					precise float fragment_unnamed_490 = (-0.0f) - fragment_input_3.x;
					precise float fragment_unnamed_493 = (-0.0f) - fragment_input_3.y;
					precise float fragment_unnamed_496 = (-0.0f) - fragment_input_3.z;
					precise float fragment_unnamed_502 = fragment_unnamed_490 + fragment_uniform_buffer_3[0u].x;
					precise float fragment_unnamed_503 = fragment_unnamed_493 + fragment_uniform_buffer_3[0u].y;
					precise float fragment_unnamed_504 = fragment_unnamed_496 + fragment_uniform_buffer_3[0u].z;
					precise float fragment_unnamed_505 = fragment_unnamed_502 / fragment_unnamed_485;
					precise float fragment_unnamed_506 = fragment_unnamed_503 / fragment_unnamed_486;
					precise float fragment_unnamed_507 = fragment_unnamed_504 / fragment_unnamed_487;
					precise float fragment_unnamed_510 = (-0.0f) - fragment_input_3.x;
					precise float fragment_unnamed_513 = (-0.0f) - fragment_input_3.y;
					precise float fragment_unnamed_516 = (-0.0f) - fragment_input_3.z;
					precise float fragment_unnamed_522 = fragment_unnamed_510 + fragment_uniform_buffer_3[1u].x;
					precise float fragment_unnamed_523 = fragment_unnamed_513 + fragment_uniform_buffer_3[1u].y;
					precise float fragment_unnamed_524 = fragment_unnamed_516 + fragment_uniform_buffer_3[1u].z;
					precise float fragment_unnamed_525 = fragment_unnamed_522 / fragment_unnamed_485;
					precise float fragment_unnamed_526 = fragment_unnamed_523 / fragment_unnamed_486;
					precise float fragment_unnamed_527 = fragment_unnamed_524 / fragment_unnamed_487;
					float fragment_unnamed_544 = min(asfloat((0.0f < fragment_unnamed_487) ? asuint(fragment_unnamed_507) : asuint(fragment_unnamed_527)), min(asfloat((0.0f < fragment_unnamed_486) ? asuint(fragment_unnamed_506) : asuint(fragment_unnamed_526)), asfloat((0.0f < fragment_unnamed_485) ? asuint(fragment_unnamed_505) : asuint(fragment_unnamed_525))));
					precise float fragment_unnamed_554 = (-0.0f) - fragment_uniform_buffer_3[2u].x;
					precise float fragment_unnamed_556 = (-0.0f) - fragment_uniform_buffer_3[2u].y;
					precise float fragment_unnamed_558 = (-0.0f) - fragment_uniform_buffer_3[2u].z;
					precise float fragment_unnamed_559 = fragment_input_3.x + fragment_unnamed_554;
					precise float fragment_unnamed_560 = fragment_input_3.y + fragment_unnamed_556;
					precise float fragment_unnamed_561 = fragment_input_3.z + fragment_unnamed_558;
					fragment_unnamed_565 = mad(fragment_unnamed_485, fragment_unnamed_544, fragment_unnamed_559);
					fragment_unnamed_566 = mad(fragment_unnamed_486, fragment_unnamed_544, fragment_unnamed_560);
					fragment_unnamed_567 = mad(fragment_unnamed_487, fragment_unnamed_544, fragment_unnamed_561);
				}
				else
				{
					fragment_unnamed_565 = fragment_unnamed_273;
					fragment_unnamed_566 = fragment_unnamed_274;
					fragment_unnamed_567 = fragment_unnamed_275;
				}
				precise float fragment_unnamed_568 = (-0.0f) - fragment_unnamed_249;
				precise float fragment_unnamed_572 = mad(fragment_unnamed_568, 0.699999988079071044921875f, 1.7000000476837158203125f) * fragment_unnamed_249;
				precise float fragment_unnamed_573 = fragment_unnamed_572 * 6.0f;
				float4 fragment_unnamed_577 = unity_SpecCube0.SampleLevel(samplerunity_SpecCube0, float3(fragment_unnamed_565, fragment_unnamed_566, fragment_unnamed_567), fragment_unnamed_573);
				float fragment_unnamed_579 = fragment_unnamed_577.x;
				float fragment_unnamed_580 = fragment_unnamed_577.y;
				float fragment_unnamed_581 = fragment_unnamed_577.z;
				precise float fragment_unnamed_583 = fragment_unnamed_577.w + (-1.0f);
				precise float fragment_unnamed_592 = mad(fragment_uniform_buffer_3[3u].w, fragment_unnamed_583, 1.0f) * fragment_uniform_buffer_3[3u].x;
				precise float fragment_unnamed_593 = fragment_unnamed_579 * fragment_unnamed_592;
				precise float fragment_unnamed_594 = fragment_unnamed_580 * fragment_unnamed_592;
				precise float fragment_unnamed_595 = fragment_unnamed_581 * fragment_unnamed_592;
				float fragment_unnamed_605;
				float fragment_unnamed_607;
				float fragment_unnamed_609;
				if (fragment_uniform_buffer_3[1u].w < 0.999989986419677734375f)
				{
					float fragment_unnamed_905;
					float fragment_unnamed_906;
					float fragment_unnamed_907;
					if (0.0f < fragment_uniform_buffer_3[6u].w)
					{
						float fragment_unnamed_824 = rsqrt(dot(float3(fragment_unnamed_273, fragment_unnamed_274, fragment_unnamed_275), float3(fragment_unnamed_273, fragment_unnamed_274, fragment_unnamed_275)));
						precise float fragment_unnamed_825 = fragment_unnamed_824 * fragment_unnamed_273;
						precise float fragment_unnamed_826 = fragment_unnamed_824 * fragment_unnamed_274;
						precise float fragment_unnamed_827 = fragment_unnamed_824 * fragment_unnamed_275;
						precise float fragment_unnamed_830 = (-0.0f) - fragment_input_3.x;
						precise float fragment_unnamed_833 = (-0.0f) - fragment_input_3.y;
						precise float fragment_unnamed_836 = (-0.0f) - fragment_input_3.z;
						precise float fragment_unnamed_842 = fragment_unnamed_830 + fragment_uniform_buffer_3[4u].x;
						precise float fragment_unnamed_843 = fragment_unnamed_833 + fragment_uniform_buffer_3[4u].y;
						precise float fragment_unnamed_844 = fragment_unnamed_836 + fragment_uniform_buffer_3[4u].z;
						precise float fragment_unnamed_845 = fragment_unnamed_842 / fragment_unnamed_825;
						precise float fragment_unnamed_846 = fragment_unnamed_843 / fragment_unnamed_826;
						precise float fragment_unnamed_847 = fragment_unnamed_844 / fragment_unnamed_827;
						precise float fragment_unnamed_850 = (-0.0f) - fragment_input_3.x;
						precise float fragment_unnamed_853 = (-0.0f) - fragment_input_3.y;
						precise float fragment_unnamed_856 = (-0.0f) - fragment_input_3.z;
						precise float fragment_unnamed_862 = fragment_unnamed_850 + fragment_uniform_buffer_3[5u].x;
						precise float fragment_unnamed_863 = fragment_unnamed_853 + fragment_uniform_buffer_3[5u].y;
						precise float fragment_unnamed_864 = fragment_unnamed_856 + fragment_uniform_buffer_3[5u].z;
						precise float fragment_unnamed_865 = fragment_unnamed_862 / fragment_unnamed_825;
						precise float fragment_unnamed_866 = fragment_unnamed_863 / fragment_unnamed_826;
						precise float fragment_unnamed_867 = fragment_unnamed_864 / fragment_unnamed_827;
						float fragment_unnamed_884 = min(asfloat((0.0f < fragment_unnamed_827) ? asuint(fragment_unnamed_847) : asuint(fragment_unnamed_867)), min(asfloat((0.0f < fragment_unnamed_826) ? asuint(fragment_unnamed_846) : asuint(fragment_unnamed_866)), asfloat((0.0f < fragment_unnamed_825) ? asuint(fragment_unnamed_845) : asuint(fragment_unnamed_865))));
						precise float fragment_unnamed_894 = (-0.0f) - fragment_uniform_buffer_3[6u].x;
						precise float fragment_unnamed_896 = (-0.0f) - fragment_uniform_buffer_3[6u].y;
						precise float fragment_unnamed_898 = (-0.0f) - fragment_uniform_buffer_3[6u].z;
						precise float fragment_unnamed_899 = fragment_input_3.x + fragment_unnamed_894;
						precise float fragment_unnamed_900 = fragment_input_3.y + fragment_unnamed_896;
						precise float fragment_unnamed_901 = fragment_input_3.z + fragment_unnamed_898;
						fragment_unnamed_905 = mad(fragment_unnamed_825, fragment_unnamed_884, fragment_unnamed_899);
						fragment_unnamed_906 = mad(fragment_unnamed_826, fragment_unnamed_884, fragment_unnamed_900);
						fragment_unnamed_907 = mad(fragment_unnamed_827, fragment_unnamed_884, fragment_unnamed_901);
					}
					else
					{
						fragment_unnamed_905 = fragment_unnamed_273;
						fragment_unnamed_906 = fragment_unnamed_274;
						fragment_unnamed_907 = fragment_unnamed_275;
					}
					float4 fragment_unnamed_909 = unity_SpecCube1.SampleLevel(samplerunity_SpecCube0, float3(fragment_unnamed_905, fragment_unnamed_906, fragment_unnamed_907), fragment_unnamed_573);
					precise float fragment_unnamed_915 = fragment_unnamed_909.w + (-1.0f);
					precise float fragment_unnamed_923 = mad(fragment_uniform_buffer_3[7u].w, fragment_unnamed_915, 1.0f) * fragment_uniform_buffer_3[7u].x;
					precise float fragment_unnamed_924 = fragment_unnamed_909.x * fragment_unnamed_923;
					precise float fragment_unnamed_925 = fragment_unnamed_909.y * fragment_unnamed_923;
					precise float fragment_unnamed_926 = fragment_unnamed_909.z * fragment_unnamed_923;
					precise float fragment_unnamed_927 = (-0.0f) - fragment_unnamed_924;
					precise float fragment_unnamed_928 = (-0.0f) - fragment_unnamed_925;
					precise float fragment_unnamed_929 = (-0.0f) - fragment_unnamed_926;
					fragment_unnamed_605 = mad(fragment_uniform_buffer_3[1u].w, mad(fragment_unnamed_592, fragment_unnamed_579, fragment_unnamed_927), fragment_unnamed_924);
					fragment_unnamed_607 = mad(fragment_uniform_buffer_3[1u].w, mad(fragment_unnamed_592, fragment_unnamed_580, fragment_unnamed_928), fragment_unnamed_925);
					fragment_unnamed_609 = mad(fragment_uniform_buffer_3[1u].w, mad(fragment_unnamed_592, fragment_unnamed_581, fragment_unnamed_929), fragment_unnamed_926);
				}
				else
				{
					fragment_unnamed_605 = fragment_unnamed_593;
					fragment_unnamed_607 = fragment_unnamed_594;
					fragment_unnamed_609 = fragment_unnamed_595;
				}
				float fragment_unnamed_626 = rsqrt(dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z)));
				precise float fragment_unnamed_633 = fragment_unnamed_626 * fragment_input_2.x;
				precise float fragment_unnamed_634 = fragment_unnamed_626 * fragment_input_2.y;
				precise float fragment_unnamed_635 = fragment_unnamed_626 * fragment_input_2.z;
				float fragment_unnamed_649 = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_119, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_651 = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_120, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_652 = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_121, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_656 = (-0.0f) - fragment_uniform_buffer_0[4u].y;
				float fragment_unnamed_657 = mad(fragment_unnamed_656, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_659 = fragment_unnamed_657 * fragment_unnamed_128;
				precise float fragment_unnamed_660 = fragment_unnamed_657 * fragment_unnamed_129;
				precise float fragment_unnamed_661 = fragment_unnamed_657 * fragment_unnamed_130;
				float fragment_unnamed_667 = mad(fragment_unnamed_91, fragment_unnamed_98, fragment_uniform_buffer_2[0u].x);
				float fragment_unnamed_668 = mad(fragment_unnamed_92, fragment_unnamed_98, fragment_uniform_buffer_2[0u].y);
				float fragment_unnamed_669 = mad(fragment_unnamed_93, fragment_unnamed_98, fragment_uniform_buffer_2[0u].z);
				float fragment_unnamed_675 = rsqrt(max(dot(float3(fragment_unnamed_667, fragment_unnamed_668, fragment_unnamed_669), float3(fragment_unnamed_667, fragment_unnamed_668, fragment_unnamed_669)), 0.001000000047497451305389404296875f));
				precise float fragment_unnamed_676 = fragment_unnamed_675 * fragment_unnamed_667;
				precise float fragment_unnamed_677 = fragment_unnamed_675 * fragment_unnamed_668;
				precise float fragment_unnamed_678 = fragment_unnamed_675 * fragment_unnamed_669;
				float fragment_unnamed_679 = dot(float3(fragment_unnamed_633, fragment_unnamed_634, fragment_unnamed_635), float3(fragment_unnamed_99, fragment_unnamed_100, fragment_unnamed_101));
				float fragment_unnamed_690 = clamp(dot(float3(fragment_unnamed_633, fragment_unnamed_634, fragment_unnamed_635), float3(fragment_uniform_buffer_2[0u].xyz)), 0.0f, 1.0f);
				float fragment_unnamed_694 = clamp(dot(float3(fragment_unnamed_633, fragment_unnamed_634, fragment_unnamed_635), float3(fragment_unnamed_676, fragment_unnamed_677, fragment_unnamed_678)), 0.0f, 1.0f);
				float fragment_unnamed_703 = clamp(dot(float3(fragment_uniform_buffer_2[0u].xyz), float3(fragment_unnamed_676, fragment_unnamed_677, fragment_unnamed_678)), 0.0f, 1.0f);
				precise float fragment_unnamed_704 = fragment_unnamed_703 * fragment_unnamed_703;
				precise float fragment_unnamed_708 = dot(fragment_unnamed_704.xx, fragment_unnamed_249.xx) + (-0.5f);
				precise float fragment_unnamed_710 = (-0.0f) - fragment_unnamed_690;
				precise float fragment_unnamed_711 = fragment_unnamed_710 + 1.0f;
				precise float fragment_unnamed_712 = fragment_unnamed_711 * fragment_unnamed_711;
				precise float fragment_unnamed_713 = fragment_unnamed_712 * fragment_unnamed_712;
				precise float fragment_unnamed_714 = fragment_unnamed_711 * fragment_unnamed_713;
				precise float fragment_unnamed_717 = (-0.0f) - abs(fragment_unnamed_679);
				precise float fragment_unnamed_718 = fragment_unnamed_717 + 1.0f;
				precise float fragment_unnamed_719 = fragment_unnamed_718 * fragment_unnamed_718;
				precise float fragment_unnamed_720 = fragment_unnamed_719 * fragment_unnamed_719;
				precise float fragment_unnamed_721 = fragment_unnamed_718 * fragment_unnamed_720;
				precise float fragment_unnamed_723 = mad(fragment_unnamed_708, fragment_unnamed_721, 1.0f) * mad(fragment_unnamed_708, fragment_unnamed_714, 1.0f);
				precise float fragment_unnamed_724 = fragment_unnamed_249 * fragment_unnamed_249;
				float fragment_unnamed_725 = max(fragment_unnamed_724, 0.00200000009499490261077880859375f);
				precise float fragment_unnamed_727 = (-0.0f) - fragment_unnamed_725;
				precise float fragment_unnamed_728 = fragment_unnamed_727 + 1.0f;
				precise float fragment_unnamed_733 = abs(fragment_unnamed_679) * mad(fragment_unnamed_690, fragment_unnamed_728, fragment_unnamed_725);
				precise float fragment_unnamed_735 = mad(fragment_unnamed_690, mad(abs(fragment_unnamed_679), fragment_unnamed_728, fragment_unnamed_725), fragment_unnamed_733) + 9.9999997473787516355514526367188e-06f;
				precise float fragment_unnamed_737 = 0.5f / fragment_unnamed_735;
				precise float fragment_unnamed_738 = fragment_unnamed_725 * fragment_unnamed_725;
				precise float fragment_unnamed_739 = (-0.0f) - fragment_unnamed_694;
				float fragment_unnamed_741 = mad(mad(fragment_unnamed_694, fragment_unnamed_738, fragment_unnamed_739), fragment_unnamed_694, 1.0f);
				precise float fragment_unnamed_742 = fragment_unnamed_738 * 0.3183098733425140380859375f;
				precise float fragment_unnamed_746 = fragment_unnamed_742 / mad(fragment_unnamed_741, fragment_unnamed_741, 1.0000000116860974230803549289703e-07f);
				precise float fragment_unnamed_747 = fragment_unnamed_737 * fragment_unnamed_746;
				precise float fragment_unnamed_748 = fragment_unnamed_725 * 0.2800000011920928955078125f;
				precise float fragment_unnamed_750 = fragment_unnamed_747 * 3.1415927410125732421875f;
				precise float fragment_unnamed_755 = fragment_unnamed_690 * fragment_unnamed_723;
				precise float fragment_unnamed_756 = fragment_unnamed_690 * sqrt(max(fragment_unnamed_750, 9.9999997473787516355514526367188e-05f));
				precise float fragment_unnamed_757 = (-0.0f) - fragment_unnamed_748;
				float fragment_unnamed_758 = mad(fragment_unnamed_757, fragment_unnamed_249, 1.0f);
				precise float fragment_unnamed_767 = fragment_unnamed_756 * asfloat(((dot(float3(fragment_unnamed_649, fragment_unnamed_651, fragment_unnamed_652), float3(fragment_unnamed_649, fragment_unnamed_651, fragment_unnamed_652)) != 0.0f) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_768 = (-0.0f) - fragment_unnamed_657;
				precise float fragment_unnamed_772 = fragment_unnamed_768 + fragment_uniform_buffer_0[4u].x;
				precise float fragment_unnamed_773 = fragment_unnamed_772 + 1.0f;
				float fragment_unnamed_774 = clamp(fragment_unnamed_773, 0.0f, 1.0f);
				precise float fragment_unnamed_778 = fragment_unnamed_281 * fragment_unnamed_767;
				precise float fragment_unnamed_779 = fragment_unnamed_282 * fragment_unnamed_767;
				precise float fragment_unnamed_780 = fragment_unnamed_283 * fragment_unnamed_767;
				precise float fragment_unnamed_781 = (-0.0f) - fragment_unnamed_703;
				precise float fragment_unnamed_782 = fragment_unnamed_781 + 1.0f;
				precise float fragment_unnamed_783 = fragment_unnamed_782 * fragment_unnamed_782;
				precise float fragment_unnamed_784 = fragment_unnamed_783 * fragment_unnamed_783;
				precise float fragment_unnamed_785 = fragment_unnamed_782 * fragment_unnamed_784;
				precise float fragment_unnamed_786 = (-0.0f) - fragment_unnamed_649;
				precise float fragment_unnamed_787 = (-0.0f) - fragment_unnamed_651;
				precise float fragment_unnamed_788 = (-0.0f) - fragment_unnamed_652;
				precise float fragment_unnamed_789 = fragment_unnamed_786 + 1.0f;
				precise float fragment_unnamed_790 = fragment_unnamed_787 + 1.0f;
				precise float fragment_unnamed_791 = fragment_unnamed_788 + 1.0f;
				precise float fragment_unnamed_795 = mad(fragment_unnamed_789, fragment_unnamed_785, fragment_unnamed_649) * fragment_unnamed_778;
				precise float fragment_unnamed_796 = mad(fragment_unnamed_790, fragment_unnamed_785, fragment_unnamed_651) * fragment_unnamed_779;
				precise float fragment_unnamed_797 = mad(fragment_unnamed_791, fragment_unnamed_785, fragment_unnamed_652) * fragment_unnamed_780;
				precise float fragment_unnamed_801 = fragment_unnamed_605 * fragment_unnamed_758;
				precise float fragment_unnamed_802 = fragment_unnamed_607 * fragment_unnamed_758;
				precise float fragment_unnamed_803 = fragment_unnamed_609 * fragment_unnamed_758;
				precise float fragment_unnamed_804 = (-0.0f) - fragment_unnamed_649;
				precise float fragment_unnamed_805 = (-0.0f) - fragment_unnamed_651;
				precise float fragment_unnamed_806 = (-0.0f) - fragment_unnamed_652;
				precise float fragment_unnamed_807 = fragment_unnamed_804 + fragment_unnamed_774;
				precise float fragment_unnamed_808 = fragment_unnamed_805 + fragment_unnamed_774;
				precise float fragment_unnamed_809 = fragment_unnamed_806 + fragment_unnamed_774;
				fragment_output_0.x = mad(fragment_unnamed_801, mad(fragment_unnamed_721, fragment_unnamed_807, fragment_unnamed_649), mad(fragment_unnamed_659, mad(fragment_unnamed_281, fragment_unnamed_755, max(mad(exp2(fragment_unnamed_462), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f)), fragment_unnamed_795));
				fragment_output_0.y = mad(fragment_unnamed_802, mad(fragment_unnamed_721, fragment_unnamed_808, fragment_unnamed_651), mad(fragment_unnamed_660, mad(fragment_unnamed_282, fragment_unnamed_755, max(mad(exp2(fragment_unnamed_464), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f)), fragment_unnamed_796));
				fragment_output_0.z = mad(fragment_unnamed_803, mad(fragment_unnamed_721, fragment_unnamed_809, fragment_unnamed_652), mad(fragment_unnamed_661, mad(fragment_unnamed_283, fragment_unnamed_755, max(mad(exp2(fragment_unnamed_465), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f)), fragment_unnamed_797));
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[4] = float4(_Glossiness, fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _Metallic, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[5] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_uniform_buffer_2[39] = float4(unity_SHAr[0], unity_SHAr[1], unity_SHAr[2], unity_SHAr[3]);

				fragment_uniform_buffer_2[40] = float4(unity_SHAg[0], unity_SHAg[1], unity_SHAg[2], unity_SHAg[3]);

				fragment_uniform_buffer_2[41] = float4(unity_SHAb[0], unity_SHAb[1], unity_SHAb[2], unity_SHAb[3]);

				fragment_uniform_buffer_2[46] = float4(unity_OcclusionMaskSelector[0], unity_OcclusionMaskSelector[1], unity_OcclusionMaskSelector[2], unity_OcclusionMaskSelector[3]);

				fragment_uniform_buffer_3[0] = float4(unity_SpecCube0_BoxMax[0], unity_SpecCube0_BoxMax[1], unity_SpecCube0_BoxMax[2], unity_SpecCube0_BoxMax[3]);

				fragment_uniform_buffer_3[1] = float4(unity_SpecCube0_BoxMin[0], unity_SpecCube0_BoxMin[1], unity_SpecCube0_BoxMin[2], unity_SpecCube0_BoxMin[3]);

				fragment_uniform_buffer_3[2] = float4(unity_SpecCube0_ProbePosition[0], unity_SpecCube0_ProbePosition[1], unity_SpecCube0_ProbePosition[2], unity_SpecCube0_ProbePosition[3]);

				fragment_uniform_buffer_3[3] = float4(unity_SpecCube0_HDR[0], unity_SpecCube0_HDR[1], unity_SpecCube0_HDR[2], unity_SpecCube0_HDR[3]);

				fragment_uniform_buffer_3[4] = float4(unity_SpecCube1_BoxMax[0], unity_SpecCube1_BoxMax[1], unity_SpecCube1_BoxMax[2], unity_SpecCube1_BoxMax[3]);

				fragment_uniform_buffer_3[5] = float4(unity_SpecCube1_BoxMin[0], unity_SpecCube1_BoxMin[1], unity_SpecCube1_BoxMin[2], unity_SpecCube1_BoxMin[3]);

				fragment_uniform_buffer_3[6] = float4(unity_SpecCube1_ProbePosition[0], unity_SpecCube1_ProbePosition[1], unity_SpecCube1_ProbePosition[2], unity_SpecCube1_ProbePosition[3]);

				fragment_uniform_buffer_3[7] = float4(unity_SpecCube1_HDR[0], unity_SpecCube1_HDR[1], unity_SpecCube1_HDR[2], unity_SpecCube1_HDR[3]);

				fragment_uniform_buffer_4[0] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_4[1] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_4[2] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_4[3] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_4[4] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_4[5] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], fragment_uniform_buffer_4[5][3]);

				fragment_uniform_buffer_4[6] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], fragment_uniform_buffer_4[6][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(DIRECTIONAL) && defined(LIGHTPROBE_SH) && !defined(SHADOWS_SCREEN) && !defined(VERTEXLIGHT_ON)


			#if defined(DIRECTIONAL) && defined(SHADOWS_SCREEN) && !defined(LIGHTPROBE_SH) && !defined(VERTEXLIGHT_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _MainTex_ST;
			float4 _ProjectionParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
			static float4 vertex_uniform_buffer_1[6];
			static float4 vertex_uniform_buffer_2[8];
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
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float4 vertex_output_5 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_6 : TEXCOORD6; // TEXCOORD_6
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_61 = vertex_input_0.y * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_62 = vertex_input_0.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_63 = vertex_input_0.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_64 = vertex_input_0.y * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_87 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_0.x, vertex_unnamed_61));
				float vertex_unnamed_88 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_0.x, vertex_unnamed_62));
				float vertex_unnamed_89 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_0.x, vertex_unnamed_63));
				precise float vertex_unnamed_98 = vertex_unnamed_87 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_99 = vertex_unnamed_88 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_100 = vertex_unnamed_89 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_101 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_input_0.x, vertex_unnamed_64)) + vertex_uniform_buffer_2[3u].w;
				vertex_output_3.x = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_87);
				vertex_output_3.y = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_88);
				vertex_output_3.z = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_89);
				precise float vertex_unnamed_123 = vertex_unnamed_99 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_124 = vertex_unnamed_99 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_125 = vertex_unnamed_99 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_126 = vertex_unnamed_99 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_156 = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_101, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_100, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_98, vertex_unnamed_123)));
				float vertex_unnamed_157 = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_101, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_100, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_98, vertex_unnamed_124)));
				float vertex_unnamed_158 = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_101, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_100, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_98, vertex_unnamed_125)));
				float vertex_unnamed_159 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_101, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_100, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_98, vertex_unnamed_126)));
				gl_Position.x = vertex_unnamed_156;
				gl_Position.y = vertex_unnamed_157;
				gl_Position.z = vertex_unnamed_158;
				gl_Position.w = vertex_unnamed_159;
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[6u].x, vertex_uniform_buffer_0[6u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[6u].y, vertex_uniform_buffer_0[6u].w);
				float vertex_unnamed_192 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_207 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_221 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_227 = rsqrt(dot(float3(vertex_unnamed_192, vertex_unnamed_207, vertex_unnamed_221), float3(vertex_unnamed_192, vertex_unnamed_207, vertex_unnamed_221)));
				precise float vertex_unnamed_228 = vertex_unnamed_227 * vertex_unnamed_192;
				precise float vertex_unnamed_229 = vertex_unnamed_227 * vertex_unnamed_207;
				precise float vertex_unnamed_230 = vertex_unnamed_227 * vertex_unnamed_221;
				vertex_output_2.x = vertex_unnamed_228;
				vertex_output_2.y = vertex_unnamed_229;
				vertex_output_2.z = vertex_unnamed_230;
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				precise float vertex_unnamed_249 = vertex_unnamed_157 * vertex_uniform_buffer_1[5u].x;
				precise float vertex_unnamed_250 = vertex_unnamed_156 * 0.5f;
				precise float vertex_unnamed_252 = vertex_unnamed_159 * 0.5f;
				precise float vertex_unnamed_253 = vertex_unnamed_249 * 0.5f;
				vertex_output_5.z = vertex_unnamed_158;
				vertex_output_5.w = vertex_unnamed_159;
				precise float vertex_unnamed_256 = vertex_unnamed_252 + vertex_unnamed_250;
				precise float vertex_unnamed_257 = vertex_unnamed_252 + vertex_unnamed_253;
				vertex_output_5.x = vertex_unnamed_256;
				vertex_output_5.y = vertex_unnamed_257;
				vertex_output_6.x = 0.0f;
				vertex_output_6.y = 0.0f;
				vertex_output_6.z = 0.0f;
				vertex_output_6.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[5] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}


			float4 _LightColor0;
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_OcclusionMaskSelector;
			float4 _LightShadowData;
			float4 unity_ShadowFadeCenterAndType;
			float4x4 unity_MatrixV;
			float4 unity_SpecCube0_BoxMax;
			float4 unity_SpecCube0_BoxMin;
			float4 unity_SpecCube0_ProbePosition;
			float4 unity_SpecCube0_HDR;
			float4 unity_SpecCube1_BoxMax;
			float4 unity_SpecCube1_BoxMin;
			float4 unity_SpecCube1_ProbePosition;
			float4 unity_SpecCube1_HDR;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[6];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[26];
			static float4 fragment_uniform_buffer_4[13];
			static float4 fragment_uniform_buffer_5[8];
			static float4 fragment_uniform_buffer_6[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _ShadowMapTexture;
			TextureCube<float4> unity_SpecCube0;
			TextureCube<float4> unity_SpecCube1;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_SpecCube0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_ShadowMapTexture;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float4 fragment_input_5 : TEXCOORD5; // TEXCOORD_5
				float4 fragment_input_6 : TEXCOORD6; // TEXCOORD_6
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_87 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_92 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_96 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_104 = fragment_unnamed_87 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_105 = fragment_unnamed_92 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_106 = fragment_unnamed_96 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_111 = rsqrt(dot(float3(fragment_unnamed_104, fragment_unnamed_105, fragment_unnamed_106), float3(fragment_unnamed_104, fragment_unnamed_105, fragment_unnamed_106)));
				precise float fragment_unnamed_112 = fragment_unnamed_111 * fragment_unnamed_104;
				precise float fragment_unnamed_113 = fragment_unnamed_111 * fragment_unnamed_105;
				precise float fragment_unnamed_114 = fragment_unnamed_111 * fragment_unnamed_106;
				float4 fragment_unnamed_122 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_132 = fragment_unnamed_122.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_133 = fragment_unnamed_122.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_134 = fragment_unnamed_122.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_141 = fragment_unnamed_132 * fragment_input_4.x;
				precise float fragment_unnamed_142 = fragment_unnamed_133 * fragment_input_4.y;
				precise float fragment_unnamed_143 = fragment_unnamed_134 * fragment_input_4.z;
				float fragment_unnamed_163 = dot(float3(fragment_unnamed_104, fragment_unnamed_105, fragment_unnamed_106), float3(asfloat(asuint(fragment_uniform_buffer_4[9u]).z), asfloat(asuint(fragment_uniform_buffer_4[10u]).z), asfloat(asuint(fragment_uniform_buffer_4[11u]).z)));
				precise float fragment_unnamed_176 = (-0.0f) - fragment_uniform_buffer_3[25u].x;
				precise float fragment_unnamed_178 = (-0.0f) - fragment_uniform_buffer_3[25u].y;
				precise float fragment_unnamed_180 = (-0.0f) - fragment_uniform_buffer_3[25u].z;
				precise float fragment_unnamed_181 = fragment_input_3.x + fragment_unnamed_176;
				precise float fragment_unnamed_182 = fragment_input_3.y + fragment_unnamed_178;
				precise float fragment_unnamed_183 = fragment_input_3.z + fragment_unnamed_180;
				precise float fragment_unnamed_188 = (-0.0f) - fragment_unnamed_163;
				precise float fragment_unnamed_189 = fragment_unnamed_188 + sqrt(dot(float3(fragment_unnamed_181, fragment_unnamed_182, fragment_unnamed_183), float3(fragment_unnamed_181, fragment_unnamed_182, fragment_unnamed_183)));
				float fragment_unnamed_302;
				float fragment_unnamed_303;
				float fragment_unnamed_304;
				float fragment_unnamed_305;
				if (fragment_uniform_buffer_6[0u].x == 1.0f)
				{
					bool fragment_unnamed_212 = fragment_uniform_buffer_6[0u].y == 1.0f;
					precise float fragment_unnamed_220 = fragment_input_3.y * fragment_uniform_buffer_6[2u].x;
					precise float fragment_unnamed_221 = fragment_input_3.y * fragment_uniform_buffer_6[2u].y;
					precise float fragment_unnamed_222 = fragment_input_3.y * fragment_uniform_buffer_6[2u].z;
					precise float fragment_unnamed_249 = mad(fragment_uniform_buffer_6[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_6[1u].x, fragment_input_3.x, fragment_unnamed_220)) + fragment_uniform_buffer_6[4u].x;
					precise float fragment_unnamed_250 = mad(fragment_uniform_buffer_6[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_6[1u].y, fragment_input_3.x, fragment_unnamed_221)) + fragment_uniform_buffer_6[4u].y;
					precise float fragment_unnamed_251 = mad(fragment_uniform_buffer_6[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_6[1u].z, fragment_input_3.x, fragment_unnamed_222)) + fragment_uniform_buffer_6[4u].z;
					precise float fragment_unnamed_264 = (-0.0f) - fragment_uniform_buffer_6[6u].x;
					precise float fragment_unnamed_266 = (-0.0f) - fragment_uniform_buffer_6[6u].y;
					precise float fragment_unnamed_268 = (-0.0f) - fragment_uniform_buffer_6[6u].z;
					precise float fragment_unnamed_269 = (fragment_unnamed_212 ? fragment_unnamed_249 : fragment_input_3.x) + fragment_unnamed_264;
					precise float fragment_unnamed_270 = (fragment_unnamed_212 ? fragment_unnamed_250 : fragment_input_3.y) + fragment_unnamed_266;
					precise float fragment_unnamed_271 = (fragment_unnamed_212 ? fragment_unnamed_251 : fragment_input_3.z) + fragment_unnamed_268;
					precise float fragment_unnamed_277 = fragment_unnamed_269 * fragment_uniform_buffer_6[5u].x;
					precise float fragment_unnamed_278 = fragment_unnamed_270 * fragment_uniform_buffer_6[5u].y;
					precise float fragment_unnamed_279 = fragment_unnamed_271 * fragment_uniform_buffer_6[5u].z;
					float4 fragment_unnamed_291 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_277, 0.25f, 0.75f), mad(fragment_uniform_buffer_6[0u].z, 0.5f, 0.75f)), fragment_unnamed_278, fragment_unnamed_279));
					fragment_unnamed_302 = fragment_unnamed_291.x;
					fragment_unnamed_303 = fragment_unnamed_291.y;
					fragment_unnamed_304 = fragment_unnamed_291.z;
					fragment_unnamed_305 = fragment_unnamed_291.w;
				}
				else
				{
					fragment_unnamed_302 = asfloat(1065353216u);
					fragment_unnamed_303 = asfloat(1065353216u);
					fragment_unnamed_304 = asfloat(1065353216u);
					fragment_unnamed_305 = asfloat(1065353216u);
				}
				precise float fragment_unnamed_323 = fragment_input_5.x / fragment_input_5.w;
				precise float fragment_unnamed_324 = fragment_input_5.y / fragment_input_5.w;
				float4 fragment_unnamed_326 = _ShadowMapTexture.Sample(sampler_ShadowMapTexture, float2(fragment_unnamed_323, fragment_unnamed_324));
				float fragment_unnamed_328 = fragment_unnamed_326.x;
				precise float fragment_unnamed_329 = (-0.0f) - fragment_unnamed_328;
				precise float fragment_unnamed_330 = clamp(dot(float4(fragment_unnamed_302, fragment_unnamed_303, fragment_unnamed_304, fragment_unnamed_305), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f) + fragment_unnamed_329;
				float fragment_unnamed_331 = mad(clamp(mad(mad(fragment_uniform_buffer_3[25u].w, fragment_unnamed_189, fragment_unnamed_163), fragment_uniform_buffer_3[24u].z, fragment_uniform_buffer_3[24u].w), 0.0f, 1.0f), fragment_unnamed_330, fragment_unnamed_328);
				precise float fragment_unnamed_335 = (-0.0f) - fragment_uniform_buffer_0[4u].x;
				precise float fragment_unnamed_336 = fragment_unnamed_335 + 1.0f;
				precise float fragment_unnamed_337 = (-0.0f) - fragment_unnamed_112;
				precise float fragment_unnamed_338 = (-0.0f) - fragment_unnamed_113;
				precise float fragment_unnamed_339 = (-0.0f) - fragment_unnamed_114;
				float fragment_unnamed_346 = dot(float3(fragment_unnamed_337, fragment_unnamed_338, fragment_unnamed_339), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z));
				precise float fragment_unnamed_349 = fragment_unnamed_346 + fragment_unnamed_346;
				precise float fragment_unnamed_356 = (-0.0f) - fragment_unnamed_349;
				precise float fragment_unnamed_357 = (-0.0f) - fragment_unnamed_112;
				precise float fragment_unnamed_358 = (-0.0f) - fragment_unnamed_113;
				precise float fragment_unnamed_359 = (-0.0f) - fragment_unnamed_114;
				float fragment_unnamed_360 = mad(fragment_input_2.x, fragment_unnamed_356, fragment_unnamed_357);
				float fragment_unnamed_361 = mad(fragment_input_2.y, fragment_unnamed_356, fragment_unnamed_358);
				float fragment_unnamed_362 = mad(fragment_input_2.z, fragment_unnamed_356, fragment_unnamed_359);
				precise float fragment_unnamed_368 = fragment_unnamed_331 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_369 = fragment_unnamed_331 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_370 = fragment_unnamed_331 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_459;
				float fragment_unnamed_460;
				float fragment_unnamed_461;
				if (0.0f < fragment_uniform_buffer_5[2u].w)
				{
					float fragment_unnamed_378 = rsqrt(dot(float3(fragment_unnamed_360, fragment_unnamed_361, fragment_unnamed_362), float3(fragment_unnamed_360, fragment_unnamed_361, fragment_unnamed_362)));
					precise float fragment_unnamed_379 = fragment_unnamed_378 * fragment_unnamed_360;
					precise float fragment_unnamed_380 = fragment_unnamed_378 * fragment_unnamed_361;
					precise float fragment_unnamed_381 = fragment_unnamed_378 * fragment_unnamed_362;
					precise float fragment_unnamed_384 = (-0.0f) - fragment_input_3.x;
					precise float fragment_unnamed_387 = (-0.0f) - fragment_input_3.y;
					precise float fragment_unnamed_390 = (-0.0f) - fragment_input_3.z;
					precise float fragment_unnamed_396 = fragment_unnamed_384 + fragment_uniform_buffer_5[0u].x;
					precise float fragment_unnamed_397 = fragment_unnamed_387 + fragment_uniform_buffer_5[0u].y;
					precise float fragment_unnamed_398 = fragment_unnamed_390 + fragment_uniform_buffer_5[0u].z;
					precise float fragment_unnamed_399 = fragment_unnamed_396 / fragment_unnamed_379;
					precise float fragment_unnamed_400 = fragment_unnamed_397 / fragment_unnamed_380;
					precise float fragment_unnamed_401 = fragment_unnamed_398 / fragment_unnamed_381;
					precise float fragment_unnamed_404 = (-0.0f) - fragment_input_3.x;
					precise float fragment_unnamed_407 = (-0.0f) - fragment_input_3.y;
					precise float fragment_unnamed_410 = (-0.0f) - fragment_input_3.z;
					precise float fragment_unnamed_416 = fragment_unnamed_404 + fragment_uniform_buffer_5[1u].x;
					precise float fragment_unnamed_417 = fragment_unnamed_407 + fragment_uniform_buffer_5[1u].y;
					precise float fragment_unnamed_418 = fragment_unnamed_410 + fragment_uniform_buffer_5[1u].z;
					precise float fragment_unnamed_419 = fragment_unnamed_416 / fragment_unnamed_379;
					precise float fragment_unnamed_420 = fragment_unnamed_417 / fragment_unnamed_380;
					precise float fragment_unnamed_421 = fragment_unnamed_418 / fragment_unnamed_381;
					float fragment_unnamed_438 = min(asfloat((0.0f < fragment_unnamed_381) ? asuint(fragment_unnamed_401) : asuint(fragment_unnamed_421)), min(asfloat((0.0f < fragment_unnamed_380) ? asuint(fragment_unnamed_400) : asuint(fragment_unnamed_420)), asfloat((0.0f < fragment_unnamed_379) ? asuint(fragment_unnamed_399) : asuint(fragment_unnamed_419))));
					precise float fragment_unnamed_448 = (-0.0f) - fragment_uniform_buffer_5[2u].x;
					precise float fragment_unnamed_450 = (-0.0f) - fragment_uniform_buffer_5[2u].y;
					precise float fragment_unnamed_452 = (-0.0f) - fragment_uniform_buffer_5[2u].z;
					precise float fragment_unnamed_453 = fragment_input_3.x + fragment_unnamed_448;
					precise float fragment_unnamed_454 = fragment_input_3.y + fragment_unnamed_450;
					precise float fragment_unnamed_455 = fragment_input_3.z + fragment_unnamed_452;
					fragment_unnamed_459 = mad(fragment_unnamed_379, fragment_unnamed_438, fragment_unnamed_453);
					fragment_unnamed_460 = mad(fragment_unnamed_380, fragment_unnamed_438, fragment_unnamed_454);
					fragment_unnamed_461 = mad(fragment_unnamed_381, fragment_unnamed_438, fragment_unnamed_455);
				}
				else
				{
					fragment_unnamed_459 = fragment_unnamed_360;
					fragment_unnamed_460 = fragment_unnamed_361;
					fragment_unnamed_461 = fragment_unnamed_362;
				}
				precise float fragment_unnamed_462 = (-0.0f) - fragment_unnamed_336;
				precise float fragment_unnamed_466 = mad(fragment_unnamed_462, 0.699999988079071044921875f, 1.7000000476837158203125f) * fragment_unnamed_336;
				precise float fragment_unnamed_467 = fragment_unnamed_466 * 6.0f;
				float4 fragment_unnamed_471 = unity_SpecCube0.SampleLevel(samplerunity_SpecCube0, float3(fragment_unnamed_459, fragment_unnamed_460, fragment_unnamed_461), fragment_unnamed_467);
				float fragment_unnamed_473 = fragment_unnamed_471.x;
				float fragment_unnamed_474 = fragment_unnamed_471.y;
				float fragment_unnamed_475 = fragment_unnamed_471.z;
				precise float fragment_unnamed_477 = fragment_unnamed_471.w + (-1.0f);
				precise float fragment_unnamed_486 = mad(fragment_uniform_buffer_5[3u].w, fragment_unnamed_477, 1.0f) * fragment_uniform_buffer_5[3u].x;
				precise float fragment_unnamed_487 = fragment_unnamed_473 * fragment_unnamed_486;
				precise float fragment_unnamed_488 = fragment_unnamed_474 * fragment_unnamed_486;
				precise float fragment_unnamed_489 = fragment_unnamed_475 * fragment_unnamed_486;
				float fragment_unnamed_499;
				float fragment_unnamed_501;
				float fragment_unnamed_503;
				if (fragment_uniform_buffer_5[1u].w < 0.999989986419677734375f)
				{
					float fragment_unnamed_799;
					float fragment_unnamed_800;
					float fragment_unnamed_801;
					if (0.0f < fragment_uniform_buffer_5[6u].w)
					{
						float fragment_unnamed_718 = rsqrt(dot(float3(fragment_unnamed_360, fragment_unnamed_361, fragment_unnamed_362), float3(fragment_unnamed_360, fragment_unnamed_361, fragment_unnamed_362)));
						precise float fragment_unnamed_719 = fragment_unnamed_718 * fragment_unnamed_360;
						precise float fragment_unnamed_720 = fragment_unnamed_718 * fragment_unnamed_361;
						precise float fragment_unnamed_721 = fragment_unnamed_718 * fragment_unnamed_362;
						precise float fragment_unnamed_724 = (-0.0f) - fragment_input_3.x;
						precise float fragment_unnamed_727 = (-0.0f) - fragment_input_3.y;
						precise float fragment_unnamed_730 = (-0.0f) - fragment_input_3.z;
						precise float fragment_unnamed_736 = fragment_unnamed_724 + fragment_uniform_buffer_5[4u].x;
						precise float fragment_unnamed_737 = fragment_unnamed_727 + fragment_uniform_buffer_5[4u].y;
						precise float fragment_unnamed_738 = fragment_unnamed_730 + fragment_uniform_buffer_5[4u].z;
						precise float fragment_unnamed_739 = fragment_unnamed_736 / fragment_unnamed_719;
						precise float fragment_unnamed_740 = fragment_unnamed_737 / fragment_unnamed_720;
						precise float fragment_unnamed_741 = fragment_unnamed_738 / fragment_unnamed_721;
						precise float fragment_unnamed_744 = (-0.0f) - fragment_input_3.x;
						precise float fragment_unnamed_747 = (-0.0f) - fragment_input_3.y;
						precise float fragment_unnamed_750 = (-0.0f) - fragment_input_3.z;
						precise float fragment_unnamed_756 = fragment_unnamed_744 + fragment_uniform_buffer_5[5u].x;
						precise float fragment_unnamed_757 = fragment_unnamed_747 + fragment_uniform_buffer_5[5u].y;
						precise float fragment_unnamed_758 = fragment_unnamed_750 + fragment_uniform_buffer_5[5u].z;
						precise float fragment_unnamed_759 = fragment_unnamed_756 / fragment_unnamed_719;
						precise float fragment_unnamed_760 = fragment_unnamed_757 / fragment_unnamed_720;
						precise float fragment_unnamed_761 = fragment_unnamed_758 / fragment_unnamed_721;
						float fragment_unnamed_778 = min(asfloat((0.0f < fragment_unnamed_721) ? asuint(fragment_unnamed_741) : asuint(fragment_unnamed_761)), min(asfloat((0.0f < fragment_unnamed_720) ? asuint(fragment_unnamed_740) : asuint(fragment_unnamed_760)), asfloat((0.0f < fragment_unnamed_719) ? asuint(fragment_unnamed_739) : asuint(fragment_unnamed_759))));
						precise float fragment_unnamed_788 = (-0.0f) - fragment_uniform_buffer_5[6u].x;
						precise float fragment_unnamed_790 = (-0.0f) - fragment_uniform_buffer_5[6u].y;
						precise float fragment_unnamed_792 = (-0.0f) - fragment_uniform_buffer_5[6u].z;
						precise float fragment_unnamed_793 = fragment_input_3.x + fragment_unnamed_788;
						precise float fragment_unnamed_794 = fragment_input_3.y + fragment_unnamed_790;
						precise float fragment_unnamed_795 = fragment_input_3.z + fragment_unnamed_792;
						fragment_unnamed_799 = mad(fragment_unnamed_719, fragment_unnamed_778, fragment_unnamed_793);
						fragment_unnamed_800 = mad(fragment_unnamed_720, fragment_unnamed_778, fragment_unnamed_794);
						fragment_unnamed_801 = mad(fragment_unnamed_721, fragment_unnamed_778, fragment_unnamed_795);
					}
					else
					{
						fragment_unnamed_799 = fragment_unnamed_360;
						fragment_unnamed_800 = fragment_unnamed_361;
						fragment_unnamed_801 = fragment_unnamed_362;
					}
					float4 fragment_unnamed_803 = unity_SpecCube1.SampleLevel(samplerunity_SpecCube0, float3(fragment_unnamed_799, fragment_unnamed_800, fragment_unnamed_801), fragment_unnamed_467);
					precise float fragment_unnamed_809 = fragment_unnamed_803.w + (-1.0f);
					precise float fragment_unnamed_817 = mad(fragment_uniform_buffer_5[7u].w, fragment_unnamed_809, 1.0f) * fragment_uniform_buffer_5[7u].x;
					precise float fragment_unnamed_818 = fragment_unnamed_803.x * fragment_unnamed_817;
					precise float fragment_unnamed_819 = fragment_unnamed_803.y * fragment_unnamed_817;
					precise float fragment_unnamed_820 = fragment_unnamed_803.z * fragment_unnamed_817;
					precise float fragment_unnamed_821 = (-0.0f) - fragment_unnamed_818;
					precise float fragment_unnamed_822 = (-0.0f) - fragment_unnamed_819;
					precise float fragment_unnamed_823 = (-0.0f) - fragment_unnamed_820;
					fragment_unnamed_499 = mad(fragment_uniform_buffer_5[1u].w, mad(fragment_unnamed_486, fragment_unnamed_473, fragment_unnamed_821), fragment_unnamed_818);
					fragment_unnamed_501 = mad(fragment_uniform_buffer_5[1u].w, mad(fragment_unnamed_486, fragment_unnamed_474, fragment_unnamed_822), fragment_unnamed_819);
					fragment_unnamed_503 = mad(fragment_uniform_buffer_5[1u].w, mad(fragment_unnamed_486, fragment_unnamed_475, fragment_unnamed_823), fragment_unnamed_820);
				}
				else
				{
					fragment_unnamed_499 = fragment_unnamed_487;
					fragment_unnamed_501 = fragment_unnamed_488;
					fragment_unnamed_503 = fragment_unnamed_489;
				}
				float fragment_unnamed_520 = rsqrt(dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z)));
				precise float fragment_unnamed_527 = fragment_unnamed_520 * fragment_input_2.x;
				precise float fragment_unnamed_528 = fragment_unnamed_520 * fragment_input_2.y;
				precise float fragment_unnamed_529 = fragment_unnamed_520 * fragment_input_2.z;
				float fragment_unnamed_543 = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_132, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_545 = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_133, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_546 = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_134, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_550 = (-0.0f) - fragment_uniform_buffer_0[4u].y;
				float fragment_unnamed_551 = mad(fragment_unnamed_550, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_553 = fragment_unnamed_551 * fragment_unnamed_141;
				precise float fragment_unnamed_554 = fragment_unnamed_551 * fragment_unnamed_142;
				precise float fragment_unnamed_555 = fragment_unnamed_551 * fragment_unnamed_143;
				float fragment_unnamed_561 = mad(fragment_unnamed_104, fragment_unnamed_111, fragment_uniform_buffer_2[0u].x);
				float fragment_unnamed_562 = mad(fragment_unnamed_105, fragment_unnamed_111, fragment_uniform_buffer_2[0u].y);
				float fragment_unnamed_563 = mad(fragment_unnamed_106, fragment_unnamed_111, fragment_uniform_buffer_2[0u].z);
				float fragment_unnamed_569 = rsqrt(max(dot(float3(fragment_unnamed_561, fragment_unnamed_562, fragment_unnamed_563), float3(fragment_unnamed_561, fragment_unnamed_562, fragment_unnamed_563)), 0.001000000047497451305389404296875f));
				precise float fragment_unnamed_570 = fragment_unnamed_569 * fragment_unnamed_561;
				precise float fragment_unnamed_571 = fragment_unnamed_569 * fragment_unnamed_562;
				precise float fragment_unnamed_572 = fragment_unnamed_569 * fragment_unnamed_563;
				float fragment_unnamed_573 = dot(float3(fragment_unnamed_527, fragment_unnamed_528, fragment_unnamed_529), float3(fragment_unnamed_112, fragment_unnamed_113, fragment_unnamed_114));
				float fragment_unnamed_584 = clamp(dot(float3(fragment_unnamed_527, fragment_unnamed_528, fragment_unnamed_529), float3(fragment_uniform_buffer_2[0u].xyz)), 0.0f, 1.0f);
				float fragment_unnamed_588 = clamp(dot(float3(fragment_unnamed_527, fragment_unnamed_528, fragment_unnamed_529), float3(fragment_unnamed_570, fragment_unnamed_571, fragment_unnamed_572)), 0.0f, 1.0f);
				float fragment_unnamed_597 = clamp(dot(float3(fragment_uniform_buffer_2[0u].xyz), float3(fragment_unnamed_570, fragment_unnamed_571, fragment_unnamed_572)), 0.0f, 1.0f);
				precise float fragment_unnamed_598 = fragment_unnamed_597 * fragment_unnamed_597;
				precise float fragment_unnamed_602 = dot(fragment_unnamed_598.xx, fragment_unnamed_336.xx) + (-0.5f);
				precise float fragment_unnamed_604 = (-0.0f) - fragment_unnamed_584;
				precise float fragment_unnamed_605 = fragment_unnamed_604 + 1.0f;
				precise float fragment_unnamed_606 = fragment_unnamed_605 * fragment_unnamed_605;
				precise float fragment_unnamed_607 = fragment_unnamed_606 * fragment_unnamed_606;
				precise float fragment_unnamed_608 = fragment_unnamed_605 * fragment_unnamed_607;
				precise float fragment_unnamed_611 = (-0.0f) - abs(fragment_unnamed_573);
				precise float fragment_unnamed_612 = fragment_unnamed_611 + 1.0f;
				precise float fragment_unnamed_613 = fragment_unnamed_612 * fragment_unnamed_612;
				precise float fragment_unnamed_614 = fragment_unnamed_613 * fragment_unnamed_613;
				precise float fragment_unnamed_615 = fragment_unnamed_612 * fragment_unnamed_614;
				precise float fragment_unnamed_617 = mad(fragment_unnamed_602, fragment_unnamed_615, 1.0f) * mad(fragment_unnamed_602, fragment_unnamed_608, 1.0f);
				precise float fragment_unnamed_618 = fragment_unnamed_336 * fragment_unnamed_336;
				float fragment_unnamed_619 = max(fragment_unnamed_618, 0.00200000009499490261077880859375f);
				precise float fragment_unnamed_621 = (-0.0f) - fragment_unnamed_619;
				precise float fragment_unnamed_622 = fragment_unnamed_621 + 1.0f;
				precise float fragment_unnamed_627 = abs(fragment_unnamed_573) * mad(fragment_unnamed_584, fragment_unnamed_622, fragment_unnamed_619);
				precise float fragment_unnamed_629 = mad(fragment_unnamed_584, mad(abs(fragment_unnamed_573), fragment_unnamed_622, fragment_unnamed_619), fragment_unnamed_627) + 9.9999997473787516355514526367188e-06f;
				precise float fragment_unnamed_631 = 0.5f / fragment_unnamed_629;
				precise float fragment_unnamed_632 = fragment_unnamed_619 * fragment_unnamed_619;
				precise float fragment_unnamed_633 = (-0.0f) - fragment_unnamed_588;
				float fragment_unnamed_635 = mad(mad(fragment_unnamed_588, fragment_unnamed_632, fragment_unnamed_633), fragment_unnamed_588, 1.0f);
				precise float fragment_unnamed_636 = fragment_unnamed_632 * 0.3183098733425140380859375f;
				precise float fragment_unnamed_640 = fragment_unnamed_636 / mad(fragment_unnamed_635, fragment_unnamed_635, 1.0000000116860974230803549289703e-07f);
				precise float fragment_unnamed_641 = fragment_unnamed_631 * fragment_unnamed_640;
				precise float fragment_unnamed_642 = fragment_unnamed_619 * 0.2800000011920928955078125f;
				precise float fragment_unnamed_644 = fragment_unnamed_641 * 3.1415927410125732421875f;
				precise float fragment_unnamed_649 = fragment_unnamed_584 * fragment_unnamed_617;
				precise float fragment_unnamed_650 = fragment_unnamed_584 * sqrt(max(fragment_unnamed_644, 9.9999997473787516355514526367188e-05f));
				precise float fragment_unnamed_651 = (-0.0f) - fragment_unnamed_642;
				float fragment_unnamed_652 = mad(fragment_unnamed_651, fragment_unnamed_336, 1.0f);
				precise float fragment_unnamed_661 = fragment_unnamed_650 * asfloat(((dot(float3(fragment_unnamed_543, fragment_unnamed_545, fragment_unnamed_546), float3(fragment_unnamed_543, fragment_unnamed_545, fragment_unnamed_546)) != 0.0f) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_662 = (-0.0f) - fragment_unnamed_551;
				precise float fragment_unnamed_666 = fragment_unnamed_662 + fragment_uniform_buffer_0[4u].x;
				precise float fragment_unnamed_667 = fragment_unnamed_666 + 1.0f;
				float fragment_unnamed_668 = clamp(fragment_unnamed_667, 0.0f, 1.0f);
				precise float fragment_unnamed_669 = fragment_unnamed_649 * fragment_unnamed_368;
				precise float fragment_unnamed_670 = fragment_unnamed_649 * fragment_unnamed_369;
				precise float fragment_unnamed_671 = fragment_unnamed_649 * fragment_unnamed_370;
				precise float fragment_unnamed_672 = fragment_unnamed_368 * fragment_unnamed_661;
				precise float fragment_unnamed_673 = fragment_unnamed_369 * fragment_unnamed_661;
				precise float fragment_unnamed_674 = fragment_unnamed_370 * fragment_unnamed_661;
				precise float fragment_unnamed_675 = (-0.0f) - fragment_unnamed_597;
				precise float fragment_unnamed_676 = fragment_unnamed_675 + 1.0f;
				precise float fragment_unnamed_677 = fragment_unnamed_676 * fragment_unnamed_676;
				precise float fragment_unnamed_678 = fragment_unnamed_677 * fragment_unnamed_677;
				precise float fragment_unnamed_679 = fragment_unnamed_676 * fragment_unnamed_678;
				precise float fragment_unnamed_680 = (-0.0f) - fragment_unnamed_543;
				precise float fragment_unnamed_681 = (-0.0f) - fragment_unnamed_545;
				precise float fragment_unnamed_682 = (-0.0f) - fragment_unnamed_546;
				precise float fragment_unnamed_683 = fragment_unnamed_680 + 1.0f;
				precise float fragment_unnamed_684 = fragment_unnamed_681 + 1.0f;
				precise float fragment_unnamed_685 = fragment_unnamed_682 + 1.0f;
				precise float fragment_unnamed_689 = mad(fragment_unnamed_683, fragment_unnamed_679, fragment_unnamed_543) * fragment_unnamed_672;
				precise float fragment_unnamed_690 = mad(fragment_unnamed_684, fragment_unnamed_679, fragment_unnamed_545) * fragment_unnamed_673;
				precise float fragment_unnamed_691 = mad(fragment_unnamed_685, fragment_unnamed_679, fragment_unnamed_546) * fragment_unnamed_674;
				precise float fragment_unnamed_695 = fragment_unnamed_499 * fragment_unnamed_652;
				precise float fragment_unnamed_696 = fragment_unnamed_501 * fragment_unnamed_652;
				precise float fragment_unnamed_697 = fragment_unnamed_503 * fragment_unnamed_652;
				precise float fragment_unnamed_698 = (-0.0f) - fragment_unnamed_543;
				precise float fragment_unnamed_699 = (-0.0f) - fragment_unnamed_545;
				precise float fragment_unnamed_700 = (-0.0f) - fragment_unnamed_546;
				precise float fragment_unnamed_701 = fragment_unnamed_698 + fragment_unnamed_668;
				precise float fragment_unnamed_702 = fragment_unnamed_699 + fragment_unnamed_668;
				precise float fragment_unnamed_703 = fragment_unnamed_700 + fragment_unnamed_668;
				fragment_output_0.x = mad(fragment_unnamed_695, mad(fragment_unnamed_615, fragment_unnamed_701, fragment_unnamed_543), mad(fragment_unnamed_553, fragment_unnamed_669, fragment_unnamed_689));
				fragment_output_0.y = mad(fragment_unnamed_696, mad(fragment_unnamed_615, fragment_unnamed_702, fragment_unnamed_545), mad(fragment_unnamed_554, fragment_unnamed_670, fragment_unnamed_690));
				fragment_output_0.z = mad(fragment_unnamed_697, mad(fragment_unnamed_615, fragment_unnamed_703, fragment_unnamed_546), mad(fragment_unnamed_555, fragment_unnamed_671, fragment_unnamed_691));
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[4] = float4(_Glossiness, fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _Metallic, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[5] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_uniform_buffer_2[46] = float4(unity_OcclusionMaskSelector[0], unity_OcclusionMaskSelector[1], unity_OcclusionMaskSelector[2], unity_OcclusionMaskSelector[3]);

				fragment_uniform_buffer_3[24] = float4(_LightShadowData[0], _LightShadowData[1], _LightShadowData[2], _LightShadowData[3]);

				fragment_uniform_buffer_3[25] = float4(unity_ShadowFadeCenterAndType[0], unity_ShadowFadeCenterAndType[1], unity_ShadowFadeCenterAndType[2], unity_ShadowFadeCenterAndType[3]);

				fragment_uniform_buffer_4[9] = float4(unity_MatrixV[0][0], unity_MatrixV[1][0], unity_MatrixV[2][0], unity_MatrixV[3][0]);
				fragment_uniform_buffer_4[10] = float4(unity_MatrixV[0][1], unity_MatrixV[1][1], unity_MatrixV[2][1], unity_MatrixV[3][1]);
				fragment_uniform_buffer_4[11] = float4(unity_MatrixV[0][2], unity_MatrixV[1][2], unity_MatrixV[2][2], unity_MatrixV[3][2]);
				fragment_uniform_buffer_4[12] = float4(unity_MatrixV[0][3], unity_MatrixV[1][3], unity_MatrixV[2][3], unity_MatrixV[3][3]);

				fragment_uniform_buffer_5[0] = float4(unity_SpecCube0_BoxMax[0], unity_SpecCube0_BoxMax[1], unity_SpecCube0_BoxMax[2], unity_SpecCube0_BoxMax[3]);

				fragment_uniform_buffer_5[1] = float4(unity_SpecCube0_BoxMin[0], unity_SpecCube0_BoxMin[1], unity_SpecCube0_BoxMin[2], unity_SpecCube0_BoxMin[3]);

				fragment_uniform_buffer_5[2] = float4(unity_SpecCube0_ProbePosition[0], unity_SpecCube0_ProbePosition[1], unity_SpecCube0_ProbePosition[2], unity_SpecCube0_ProbePosition[3]);

				fragment_uniform_buffer_5[3] = float4(unity_SpecCube0_HDR[0], unity_SpecCube0_HDR[1], unity_SpecCube0_HDR[2], unity_SpecCube0_HDR[3]);

				fragment_uniform_buffer_5[4] = float4(unity_SpecCube1_BoxMax[0], unity_SpecCube1_BoxMax[1], unity_SpecCube1_BoxMax[2], unity_SpecCube1_BoxMax[3]);

				fragment_uniform_buffer_5[5] = float4(unity_SpecCube1_BoxMin[0], unity_SpecCube1_BoxMin[1], unity_SpecCube1_BoxMin[2], unity_SpecCube1_BoxMin[3]);

				fragment_uniform_buffer_5[6] = float4(unity_SpecCube1_ProbePosition[0], unity_SpecCube1_ProbePosition[1], unity_SpecCube1_ProbePosition[2], unity_SpecCube1_ProbePosition[3]);

				fragment_uniform_buffer_5[7] = float4(unity_SpecCube1_HDR[0], unity_SpecCube1_HDR[1], unity_SpecCube1_HDR[2], unity_SpecCube1_HDR[3]);

				fragment_uniform_buffer_6[0] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_6[1] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_6[2] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_6[3] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_6[4] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_6[5] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], fragment_uniform_buffer_6[5][3]);

				fragment_uniform_buffer_6[6] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], fragment_uniform_buffer_6[6][3]);

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

			#endif // defined(DIRECTIONAL) && defined(SHADOWS_SCREEN) && !defined(LIGHTPROBE_SH) && !defined(VERTEXLIGHT_ON)


			#if defined(DIRECTIONAL) && defined(LIGHTPROBE_SH) && defined(SHADOWS_SCREEN) && !defined(VERTEXLIGHT_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _MainTex_ST;
			float4 _ProjectionParams;
			float4 unity_SHBr;
			float4 unity_SHBg;
			float4 unity_SHBb;
			float4 unity_SHC;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
			static float4 vertex_uniform_buffer_1[6];
			static float4 vertex_uniform_buffer_2[46];
			static float4 vertex_uniform_buffer_3[8];
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
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static float4 vertex_output_6;
			static float4 vertex_output_7;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float3 vertex_output_5 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_7 : TEXCOORD6; // TEXCOORD_6
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_67 = vertex_input_0.y * vertex_uniform_buffer_3[1u].x;
				precise float vertex_unnamed_68 = vertex_input_0.y * vertex_uniform_buffer_3[1u].y;
				precise float vertex_unnamed_69 = vertex_input_0.y * vertex_uniform_buffer_3[1u].z;
				precise float vertex_unnamed_70 = vertex_input_0.y * vertex_uniform_buffer_3[1u].w;
				float vertex_unnamed_93 = mad(vertex_uniform_buffer_3[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].x, vertex_input_0.x, vertex_unnamed_67));
				float vertex_unnamed_94 = mad(vertex_uniform_buffer_3[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].y, vertex_input_0.x, vertex_unnamed_68));
				float vertex_unnamed_95 = mad(vertex_uniform_buffer_3[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].z, vertex_input_0.x, vertex_unnamed_69));
				precise float vertex_unnamed_104 = vertex_unnamed_93 + vertex_uniform_buffer_3[3u].x;
				precise float vertex_unnamed_105 = vertex_unnamed_94 + vertex_uniform_buffer_3[3u].y;
				precise float vertex_unnamed_106 = vertex_unnamed_95 + vertex_uniform_buffer_3[3u].z;
				precise float vertex_unnamed_107 = mad(vertex_uniform_buffer_3[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].w, vertex_input_0.x, vertex_unnamed_70)) + vertex_uniform_buffer_3[3u].w;
				vertex_output_3.x = mad(vertex_uniform_buffer_3[3u].x, vertex_input_0.w, vertex_unnamed_93);
				vertex_output_3.y = mad(vertex_uniform_buffer_3[3u].y, vertex_input_0.w, vertex_unnamed_94);
				vertex_output_3.z = mad(vertex_uniform_buffer_3[3u].z, vertex_input_0.w, vertex_unnamed_95);
				precise float vertex_unnamed_129 = vertex_unnamed_105 * vertex_uniform_buffer_4[18u].x;
				precise float vertex_unnamed_130 = vertex_unnamed_105 * vertex_uniform_buffer_4[18u].y;
				precise float vertex_unnamed_131 = vertex_unnamed_105 * vertex_uniform_buffer_4[18u].z;
				precise float vertex_unnamed_132 = vertex_unnamed_105 * vertex_uniform_buffer_4[18u].w;
				float vertex_unnamed_162 = mad(vertex_uniform_buffer_4[20u].x, vertex_unnamed_107, mad(vertex_uniform_buffer_4[19u].x, vertex_unnamed_106, mad(vertex_uniform_buffer_4[17u].x, vertex_unnamed_104, vertex_unnamed_129)));
				float vertex_unnamed_163 = mad(vertex_uniform_buffer_4[20u].y, vertex_unnamed_107, mad(vertex_uniform_buffer_4[19u].y, vertex_unnamed_106, mad(vertex_uniform_buffer_4[17u].y, vertex_unnamed_104, vertex_unnamed_130)));
				float vertex_unnamed_164 = mad(vertex_uniform_buffer_4[20u].z, vertex_unnamed_107, mad(vertex_uniform_buffer_4[19u].z, vertex_unnamed_106, mad(vertex_uniform_buffer_4[17u].z, vertex_unnamed_104, vertex_unnamed_131)));
				float vertex_unnamed_165 = mad(vertex_uniform_buffer_4[20u].w, vertex_unnamed_107, mad(vertex_uniform_buffer_4[19u].w, vertex_unnamed_106, mad(vertex_uniform_buffer_4[17u].w, vertex_unnamed_104, vertex_unnamed_132)));
				gl_Position.x = vertex_unnamed_162;
				gl_Position.y = vertex_unnamed_163;
				gl_Position.z = vertex_unnamed_164;
				gl_Position.w = vertex_unnamed_165;
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[6u].x, vertex_uniform_buffer_0[6u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[6u].y, vertex_uniform_buffer_0[6u].w);
				float vertex_unnamed_198 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_3[4u].xyz));
				float vertex_unnamed_213 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_3[5u].xyz));
				float vertex_unnamed_227 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_3[6u].xyz));
				float vertex_unnamed_233 = rsqrt(dot(float3(vertex_unnamed_198, vertex_unnamed_213, vertex_unnamed_227), float3(vertex_unnamed_198, vertex_unnamed_213, vertex_unnamed_227)));
				precise float vertex_unnamed_234 = vertex_unnamed_233 * vertex_unnamed_198;
				precise float vertex_unnamed_235 = vertex_unnamed_233 * vertex_unnamed_213;
				precise float vertex_unnamed_236 = vertex_unnamed_233 * vertex_unnamed_227;
				vertex_output_2.x = vertex_unnamed_234;
				vertex_output_2.y = vertex_unnamed_235;
				vertex_output_2.z = vertex_unnamed_236;
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				precise float vertex_unnamed_252 = vertex_unnamed_235 * vertex_unnamed_235;
				precise float vertex_unnamed_253 = (-0.0f) - vertex_unnamed_252;
				float vertex_unnamed_255 = mad(vertex_unnamed_234, vertex_unnamed_234, vertex_unnamed_253);
				precise float vertex_unnamed_256 = vertex_unnamed_235 * vertex_unnamed_234;
				precise float vertex_unnamed_257 = vertex_unnamed_236 * vertex_unnamed_235;
				precise float vertex_unnamed_258 = vertex_unnamed_236 * vertex_unnamed_236;
				precise float vertex_unnamed_259 = vertex_unnamed_234 * vertex_unnamed_236;
				vertex_output_5.x = mad(vertex_uniform_buffer_2[45u].x, vertex_unnamed_255, dot(float4(vertex_uniform_buffer_2[42u]), float4(vertex_unnamed_256, vertex_unnamed_257, vertex_unnamed_258, vertex_unnamed_259)));
				vertex_output_5.y = mad(vertex_uniform_buffer_2[45u].y, vertex_unnamed_255, dot(float4(vertex_uniform_buffer_2[43u]), float4(vertex_unnamed_256, vertex_unnamed_257, vertex_unnamed_258, vertex_unnamed_259)));
				vertex_output_5.z = mad(vertex_uniform_buffer_2[45u].z, vertex_unnamed_255, dot(float4(vertex_uniform_buffer_2[44u]), float4(vertex_unnamed_256, vertex_unnamed_257, vertex_unnamed_258, vertex_unnamed_259)));
				precise float vertex_unnamed_305 = vertex_unnamed_163 * vertex_uniform_buffer_1[5u].x;
				precise float vertex_unnamed_306 = vertex_unnamed_162 * 0.5f;
				precise float vertex_unnamed_308 = vertex_unnamed_165 * 0.5f;
				precise float vertex_unnamed_309 = vertex_unnamed_305 * 0.5f;
				vertex_output_6.z = vertex_unnamed_164;
				vertex_output_6.w = vertex_unnamed_165;
				precise float vertex_unnamed_312 = vertex_unnamed_308 + vertex_unnamed_306;
				precise float vertex_unnamed_313 = vertex_unnamed_308 + vertex_unnamed_309;
				vertex_output_6.x = vertex_unnamed_312;
				vertex_output_6.y = vertex_unnamed_313;
				vertex_output_7.x = 0.0f;
				vertex_output_7.y = 0.0f;
				vertex_output_7.z = 0.0f;
				vertex_output_7.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[5] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				return stage_output;
			}


			float4 _LightColor0;
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_SHAr;
			float4 unity_SHAg;
			float4 unity_SHAb;
			float4 unity_OcclusionMaskSelector;
			float4 _LightShadowData;
			float4 unity_ShadowFadeCenterAndType;
			float4x4 unity_MatrixV;
			float4 unity_SpecCube0_BoxMax;
			float4 unity_SpecCube0_BoxMin;
			float4 unity_SpecCube0_ProbePosition;
			float4 unity_SpecCube0_HDR;
			float4 unity_SpecCube1_BoxMax;
			float4 unity_SpecCube1_BoxMin;
			float4 unity_SpecCube1_ProbePosition;
			float4 unity_SpecCube1_HDR;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[6];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[26];
			static float4 fragment_uniform_buffer_4[13];
			static float4 fragment_uniform_buffer_5[8];
			static float4 fragment_uniform_buffer_6[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _ShadowMapTexture;
			TextureCube<float4> unity_SpecCube0;
			TextureCube<float4> unity_SpecCube1;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_SpecCube0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_ShadowMapTexture;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_input_7;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float3 fragment_input_5 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_6 : TEXCOORD5; // TEXCOORD_5
				float4 fragment_input_7 : TEXCOORD6; // TEXCOORD_6
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_88 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_93 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_97 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_105 = fragment_unnamed_88 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_106 = fragment_unnamed_93 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_107 = fragment_unnamed_97 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_112 = rsqrt(dot(float3(fragment_unnamed_105, fragment_unnamed_106, fragment_unnamed_107), float3(fragment_unnamed_105, fragment_unnamed_106, fragment_unnamed_107)));
				precise float fragment_unnamed_113 = fragment_unnamed_112 * fragment_unnamed_105;
				precise float fragment_unnamed_114 = fragment_unnamed_112 * fragment_unnamed_106;
				precise float fragment_unnamed_115 = fragment_unnamed_112 * fragment_unnamed_107;
				float4 fragment_unnamed_123 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_133 = fragment_unnamed_123.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_134 = fragment_unnamed_123.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_135 = fragment_unnamed_123.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_142 = fragment_unnamed_133 * fragment_input_4.x;
				precise float fragment_unnamed_143 = fragment_unnamed_134 * fragment_input_4.y;
				precise float fragment_unnamed_144 = fragment_unnamed_135 * fragment_input_4.z;
				float fragment_unnamed_164 = dot(float3(fragment_unnamed_105, fragment_unnamed_106, fragment_unnamed_107), float3(asfloat(asuint(fragment_uniform_buffer_4[9u]).z), asfloat(asuint(fragment_uniform_buffer_4[10u]).z), asfloat(asuint(fragment_uniform_buffer_4[11u]).z)));
				precise float fragment_unnamed_177 = (-0.0f) - fragment_uniform_buffer_3[25u].x;
				precise float fragment_unnamed_179 = (-0.0f) - fragment_uniform_buffer_3[25u].y;
				precise float fragment_unnamed_181 = (-0.0f) - fragment_uniform_buffer_3[25u].z;
				precise float fragment_unnamed_182 = fragment_input_3.x + fragment_unnamed_177;
				precise float fragment_unnamed_183 = fragment_input_3.y + fragment_unnamed_179;
				precise float fragment_unnamed_184 = fragment_input_3.z + fragment_unnamed_181;
				precise float fragment_unnamed_189 = (-0.0f) - fragment_unnamed_164;
				precise float fragment_unnamed_190 = fragment_unnamed_189 + sqrt(dot(float3(fragment_unnamed_182, fragment_unnamed_183, fragment_unnamed_184), float3(fragment_unnamed_182, fragment_unnamed_183, fragment_unnamed_184)));
				bool fragment_unnamed_209 = fragment_uniform_buffer_6[0u].x == 1.0f;
				float fragment_unnamed_303;
				float fragment_unnamed_304;
				float fragment_unnamed_305;
				float fragment_unnamed_306;
				if (fragment_unnamed_209)
				{
					bool fragment_unnamed_213 = fragment_uniform_buffer_6[0u].y == 1.0f;
					precise float fragment_unnamed_221 = fragment_input_3.y * fragment_uniform_buffer_6[2u].x;
					precise float fragment_unnamed_222 = fragment_input_3.y * fragment_uniform_buffer_6[2u].y;
					precise float fragment_unnamed_223 = fragment_input_3.y * fragment_uniform_buffer_6[2u].z;
					precise float fragment_unnamed_250 = mad(fragment_uniform_buffer_6[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_6[1u].x, fragment_input_3.x, fragment_unnamed_221)) + fragment_uniform_buffer_6[4u].x;
					precise float fragment_unnamed_251 = mad(fragment_uniform_buffer_6[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_6[1u].y, fragment_input_3.x, fragment_unnamed_222)) + fragment_uniform_buffer_6[4u].y;
					precise float fragment_unnamed_252 = mad(fragment_uniform_buffer_6[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_6[1u].z, fragment_input_3.x, fragment_unnamed_223)) + fragment_uniform_buffer_6[4u].z;
					precise float fragment_unnamed_265 = (-0.0f) - fragment_uniform_buffer_6[6u].x;
					precise float fragment_unnamed_267 = (-0.0f) - fragment_uniform_buffer_6[6u].y;
					precise float fragment_unnamed_269 = (-0.0f) - fragment_uniform_buffer_6[6u].z;
					precise float fragment_unnamed_270 = (fragment_unnamed_213 ? fragment_unnamed_250 : fragment_input_3.x) + fragment_unnamed_265;
					precise float fragment_unnamed_271 = (fragment_unnamed_213 ? fragment_unnamed_251 : fragment_input_3.y) + fragment_unnamed_267;
					precise float fragment_unnamed_272 = (fragment_unnamed_213 ? fragment_unnamed_252 : fragment_input_3.z) + fragment_unnamed_269;
					precise float fragment_unnamed_278 = fragment_unnamed_270 * fragment_uniform_buffer_6[5u].x;
					precise float fragment_unnamed_279 = fragment_unnamed_271 * fragment_uniform_buffer_6[5u].y;
					precise float fragment_unnamed_280 = fragment_unnamed_272 * fragment_uniform_buffer_6[5u].z;
					float4 fragment_unnamed_292 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_278, 0.25f, 0.75f), mad(fragment_uniform_buffer_6[0u].z, 0.5f, 0.75f)), fragment_unnamed_279, fragment_unnamed_280));
					fragment_unnamed_303 = fragment_unnamed_292.x;
					fragment_unnamed_304 = fragment_unnamed_292.y;
					fragment_unnamed_305 = fragment_unnamed_292.z;
					fragment_unnamed_306 = fragment_unnamed_292.w;
				}
				else
				{
					fragment_unnamed_303 = asfloat(1065353216u);
					fragment_unnamed_304 = asfloat(1065353216u);
					fragment_unnamed_305 = asfloat(1065353216u);
					fragment_unnamed_306 = asfloat(1065353216u);
				}
				precise float fragment_unnamed_324 = fragment_input_6.x / fragment_input_6.w;
				precise float fragment_unnamed_325 = fragment_input_6.y / fragment_input_6.w;
				float4 fragment_unnamed_327 = _ShadowMapTexture.Sample(sampler_ShadowMapTexture, float2(fragment_unnamed_324, fragment_unnamed_325));
				float fragment_unnamed_329 = fragment_unnamed_327.x;
				precise float fragment_unnamed_330 = (-0.0f) - fragment_unnamed_329;
				precise float fragment_unnamed_331 = clamp(dot(float4(fragment_unnamed_303, fragment_unnamed_304, fragment_unnamed_305, fragment_unnamed_306), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f) + fragment_unnamed_330;
				float fragment_unnamed_332 = mad(clamp(mad(mad(fragment_uniform_buffer_3[25u].w, fragment_unnamed_190, fragment_unnamed_164), fragment_uniform_buffer_3[24u].z, fragment_uniform_buffer_3[24u].w), 0.0f, 1.0f), fragment_unnamed_331, fragment_unnamed_329);
				precise float fragment_unnamed_336 = (-0.0f) - fragment_uniform_buffer_0[4u].x;
				precise float fragment_unnamed_337 = fragment_unnamed_336 + 1.0f;
				precise float fragment_unnamed_338 = (-0.0f) - fragment_unnamed_113;
				precise float fragment_unnamed_339 = (-0.0f) - fragment_unnamed_114;
				precise float fragment_unnamed_340 = (-0.0f) - fragment_unnamed_115;
				float fragment_unnamed_347 = dot(float3(fragment_unnamed_338, fragment_unnamed_339, fragment_unnamed_340), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z));
				precise float fragment_unnamed_350 = fragment_unnamed_347 + fragment_unnamed_347;
				precise float fragment_unnamed_357 = (-0.0f) - fragment_unnamed_350;
				precise float fragment_unnamed_358 = (-0.0f) - fragment_unnamed_113;
				precise float fragment_unnamed_359 = (-0.0f) - fragment_unnamed_114;
				precise float fragment_unnamed_360 = (-0.0f) - fragment_unnamed_115;
				float fragment_unnamed_361 = mad(fragment_input_2.x, fragment_unnamed_357, fragment_unnamed_358);
				float fragment_unnamed_362 = mad(fragment_input_2.y, fragment_unnamed_357, fragment_unnamed_359);
				float fragment_unnamed_363 = mad(fragment_input_2.z, fragment_unnamed_357, fragment_unnamed_360);
				precise float fragment_unnamed_369 = fragment_unnamed_332 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_370 = fragment_unnamed_332 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_371 = fragment_unnamed_332 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_532;
				float fragment_unnamed_533;
				float fragment_unnamed_534;
				if (fragment_unnamed_209)
				{
					bool fragment_unnamed_375 = fragment_uniform_buffer_6[0u].y == 1.0f;
					precise float fragment_unnamed_383 = fragment_input_3.y * fragment_uniform_buffer_6[2u].x;
					precise float fragment_unnamed_384 = fragment_input_3.y * fragment_uniform_buffer_6[2u].y;
					precise float fragment_unnamed_385 = fragment_input_3.y * fragment_uniform_buffer_6[2u].z;
					precise float fragment_unnamed_411 = mad(fragment_uniform_buffer_6[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_6[1u].x, fragment_input_3.x, fragment_unnamed_383)) + fragment_uniform_buffer_6[4u].x;
					precise float fragment_unnamed_412 = mad(fragment_uniform_buffer_6[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_6[1u].y, fragment_input_3.x, fragment_unnamed_384)) + fragment_uniform_buffer_6[4u].y;
					precise float fragment_unnamed_413 = mad(fragment_uniform_buffer_6[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_6[1u].z, fragment_input_3.x, fragment_unnamed_385)) + fragment_uniform_buffer_6[4u].z;
					precise float fragment_unnamed_426 = (-0.0f) - fragment_uniform_buffer_6[6u].x;
					precise float fragment_unnamed_428 = (-0.0f) - fragment_uniform_buffer_6[6u].y;
					precise float fragment_unnamed_430 = (-0.0f) - fragment_uniform_buffer_6[6u].z;
					precise float fragment_unnamed_431 = (fragment_unnamed_375 ? fragment_unnamed_411 : fragment_input_3.x) + fragment_unnamed_426;
					precise float fragment_unnamed_432 = (fragment_unnamed_375 ? fragment_unnamed_412 : fragment_input_3.y) + fragment_unnamed_428;
					precise float fragment_unnamed_433 = (fragment_unnamed_375 ? fragment_unnamed_413 : fragment_input_3.z) + fragment_unnamed_430;
					precise float fragment_unnamed_439 = fragment_unnamed_431 * fragment_uniform_buffer_6[5u].x;
					precise float fragment_unnamed_440 = fragment_unnamed_432 * fragment_uniform_buffer_6[5u].y;
					precise float fragment_unnamed_441 = fragment_unnamed_433 * fragment_uniform_buffer_6[5u].z;
					precise float fragment_unnamed_442 = fragment_unnamed_439 * 0.25f;
					precise float fragment_unnamed_446 = fragment_uniform_buffer_6[0u].z * 0.5f;
					precise float fragment_unnamed_450 = (-0.0f) - fragment_uniform_buffer_6[0u].z;
					float fragment_unnamed_453 = min(mad(fragment_unnamed_450, 0.5f, 0.25f), max(fragment_unnamed_442, fragment_unnamed_446));
					precise float fragment_unnamed_461 = fragment_unnamed_453 + 0.25f;
					precise float fragment_unnamed_462 = fragment_unnamed_440 + 0.0f;
					precise float fragment_unnamed_463 = fragment_unnamed_441 + 0.0f;
					precise float fragment_unnamed_470 = fragment_unnamed_453 + 0.5f;
					precise float fragment_unnamed_471 = fragment_unnamed_440 + 0.0f;
					precise float fragment_unnamed_472 = fragment_unnamed_441 + 0.0f;
					float fragment_unnamed_485 = asfloat(1065353216u);
					fragment_unnamed_532 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_453, fragment_unnamed_440, fragment_unnamed_441))), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_485));
					fragment_unnamed_533 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_461, fragment_unnamed_462, fragment_unnamed_463))), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_485));
					fragment_unnamed_534 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_470, fragment_unnamed_471, fragment_unnamed_472))), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_485));
				}
				else
				{
					float fragment_unnamed_501 = asfloat(1065353216u);
					fragment_unnamed_532 = dot(float4(fragment_uniform_buffer_2[39u]), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_501));
					fragment_unnamed_533 = dot(float4(fragment_uniform_buffer_2[40u]), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_501));
					fragment_unnamed_534 = dot(float4(fragment_uniform_buffer_2[41u]), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_501));
				}
				precise float fragment_unnamed_541 = fragment_unnamed_532 + fragment_input_5.x;
				precise float fragment_unnamed_542 = fragment_unnamed_533 + fragment_input_5.y;
				precise float fragment_unnamed_543 = fragment_unnamed_534 + fragment_input_5.z;
				precise float fragment_unnamed_550 = log2(max(fragment_unnamed_541, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_552 = log2(max(fragment_unnamed_542, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_553 = log2(max(fragment_unnamed_543, 0.0f)) * 0.4166666567325592041015625f;
				float fragment_unnamed_653;
				float fragment_unnamed_654;
				float fragment_unnamed_655;
				if (0.0f < fragment_uniform_buffer_5[2u].w)
				{
					float fragment_unnamed_572 = rsqrt(dot(float3(fragment_unnamed_361, fragment_unnamed_362, fragment_unnamed_363), float3(fragment_unnamed_361, fragment_unnamed_362, fragment_unnamed_363)));
					precise float fragment_unnamed_573 = fragment_unnamed_572 * fragment_unnamed_361;
					precise float fragment_unnamed_574 = fragment_unnamed_572 * fragment_unnamed_362;
					precise float fragment_unnamed_575 = fragment_unnamed_572 * fragment_unnamed_363;
					precise float fragment_unnamed_578 = (-0.0f) - fragment_input_3.x;
					precise float fragment_unnamed_581 = (-0.0f) - fragment_input_3.y;
					precise float fragment_unnamed_584 = (-0.0f) - fragment_input_3.z;
					precise float fragment_unnamed_590 = fragment_unnamed_578 + fragment_uniform_buffer_5[0u].x;
					precise float fragment_unnamed_591 = fragment_unnamed_581 + fragment_uniform_buffer_5[0u].y;
					precise float fragment_unnamed_592 = fragment_unnamed_584 + fragment_uniform_buffer_5[0u].z;
					precise float fragment_unnamed_593 = fragment_unnamed_590 / fragment_unnamed_573;
					precise float fragment_unnamed_594 = fragment_unnamed_591 / fragment_unnamed_574;
					precise float fragment_unnamed_595 = fragment_unnamed_592 / fragment_unnamed_575;
					precise float fragment_unnamed_598 = (-0.0f) - fragment_input_3.x;
					precise float fragment_unnamed_601 = (-0.0f) - fragment_input_3.y;
					precise float fragment_unnamed_604 = (-0.0f) - fragment_input_3.z;
					precise float fragment_unnamed_610 = fragment_unnamed_598 + fragment_uniform_buffer_5[1u].x;
					precise float fragment_unnamed_611 = fragment_unnamed_601 + fragment_uniform_buffer_5[1u].y;
					precise float fragment_unnamed_612 = fragment_unnamed_604 + fragment_uniform_buffer_5[1u].z;
					precise float fragment_unnamed_613 = fragment_unnamed_610 / fragment_unnamed_573;
					precise float fragment_unnamed_614 = fragment_unnamed_611 / fragment_unnamed_574;
					precise float fragment_unnamed_615 = fragment_unnamed_612 / fragment_unnamed_575;
					float fragment_unnamed_632 = min(asfloat((0.0f < fragment_unnamed_575) ? asuint(fragment_unnamed_595) : asuint(fragment_unnamed_615)), min(asfloat((0.0f < fragment_unnamed_574) ? asuint(fragment_unnamed_594) : asuint(fragment_unnamed_614)), asfloat((0.0f < fragment_unnamed_573) ? asuint(fragment_unnamed_593) : asuint(fragment_unnamed_613))));
					precise float fragment_unnamed_642 = (-0.0f) - fragment_uniform_buffer_5[2u].x;
					precise float fragment_unnamed_644 = (-0.0f) - fragment_uniform_buffer_5[2u].y;
					precise float fragment_unnamed_646 = (-0.0f) - fragment_uniform_buffer_5[2u].z;
					precise float fragment_unnamed_647 = fragment_input_3.x + fragment_unnamed_642;
					precise float fragment_unnamed_648 = fragment_input_3.y + fragment_unnamed_644;
					precise float fragment_unnamed_649 = fragment_input_3.z + fragment_unnamed_646;
					fragment_unnamed_653 = mad(fragment_unnamed_573, fragment_unnamed_632, fragment_unnamed_647);
					fragment_unnamed_654 = mad(fragment_unnamed_574, fragment_unnamed_632, fragment_unnamed_648);
					fragment_unnamed_655 = mad(fragment_unnamed_575, fragment_unnamed_632, fragment_unnamed_649);
				}
				else
				{
					fragment_unnamed_653 = fragment_unnamed_361;
					fragment_unnamed_654 = fragment_unnamed_362;
					fragment_unnamed_655 = fragment_unnamed_363;
				}
				precise float fragment_unnamed_656 = (-0.0f) - fragment_unnamed_337;
				precise float fragment_unnamed_660 = mad(fragment_unnamed_656, 0.699999988079071044921875f, 1.7000000476837158203125f) * fragment_unnamed_337;
				precise float fragment_unnamed_661 = fragment_unnamed_660 * 6.0f;
				float4 fragment_unnamed_665 = unity_SpecCube0.SampleLevel(samplerunity_SpecCube0, float3(fragment_unnamed_653, fragment_unnamed_654, fragment_unnamed_655), fragment_unnamed_661);
				float fragment_unnamed_667 = fragment_unnamed_665.x;
				float fragment_unnamed_668 = fragment_unnamed_665.y;
				float fragment_unnamed_669 = fragment_unnamed_665.z;
				precise float fragment_unnamed_671 = fragment_unnamed_665.w + (-1.0f);
				precise float fragment_unnamed_680 = mad(fragment_uniform_buffer_5[3u].w, fragment_unnamed_671, 1.0f) * fragment_uniform_buffer_5[3u].x;
				precise float fragment_unnamed_681 = fragment_unnamed_667 * fragment_unnamed_680;
				precise float fragment_unnamed_682 = fragment_unnamed_668 * fragment_unnamed_680;
				precise float fragment_unnamed_683 = fragment_unnamed_669 * fragment_unnamed_680;
				float fragment_unnamed_693;
				float fragment_unnamed_695;
				float fragment_unnamed_697;
				if (fragment_uniform_buffer_5[1u].w < 0.999989986419677734375f)
				{
					float fragment_unnamed_993;
					float fragment_unnamed_994;
					float fragment_unnamed_995;
					if (0.0f < fragment_uniform_buffer_5[6u].w)
					{
						float fragment_unnamed_912 = rsqrt(dot(float3(fragment_unnamed_361, fragment_unnamed_362, fragment_unnamed_363), float3(fragment_unnamed_361, fragment_unnamed_362, fragment_unnamed_363)));
						precise float fragment_unnamed_913 = fragment_unnamed_912 * fragment_unnamed_361;
						precise float fragment_unnamed_914 = fragment_unnamed_912 * fragment_unnamed_362;
						precise float fragment_unnamed_915 = fragment_unnamed_912 * fragment_unnamed_363;
						precise float fragment_unnamed_918 = (-0.0f) - fragment_input_3.x;
						precise float fragment_unnamed_921 = (-0.0f) - fragment_input_3.y;
						precise float fragment_unnamed_924 = (-0.0f) - fragment_input_3.z;
						precise float fragment_unnamed_930 = fragment_unnamed_918 + fragment_uniform_buffer_5[4u].x;
						precise float fragment_unnamed_931 = fragment_unnamed_921 + fragment_uniform_buffer_5[4u].y;
						precise float fragment_unnamed_932 = fragment_unnamed_924 + fragment_uniform_buffer_5[4u].z;
						precise float fragment_unnamed_933 = fragment_unnamed_930 / fragment_unnamed_913;
						precise float fragment_unnamed_934 = fragment_unnamed_931 / fragment_unnamed_914;
						precise float fragment_unnamed_935 = fragment_unnamed_932 / fragment_unnamed_915;
						precise float fragment_unnamed_938 = (-0.0f) - fragment_input_3.x;
						precise float fragment_unnamed_941 = (-0.0f) - fragment_input_3.y;
						precise float fragment_unnamed_944 = (-0.0f) - fragment_input_3.z;
						precise float fragment_unnamed_950 = fragment_unnamed_938 + fragment_uniform_buffer_5[5u].x;
						precise float fragment_unnamed_951 = fragment_unnamed_941 + fragment_uniform_buffer_5[5u].y;
						precise float fragment_unnamed_952 = fragment_unnamed_944 + fragment_uniform_buffer_5[5u].z;
						precise float fragment_unnamed_953 = fragment_unnamed_950 / fragment_unnamed_913;
						precise float fragment_unnamed_954 = fragment_unnamed_951 / fragment_unnamed_914;
						precise float fragment_unnamed_955 = fragment_unnamed_952 / fragment_unnamed_915;
						float fragment_unnamed_972 = min(asfloat((0.0f < fragment_unnamed_915) ? asuint(fragment_unnamed_935) : asuint(fragment_unnamed_955)), min(asfloat((0.0f < fragment_unnamed_914) ? asuint(fragment_unnamed_934) : asuint(fragment_unnamed_954)), asfloat((0.0f < fragment_unnamed_913) ? asuint(fragment_unnamed_933) : asuint(fragment_unnamed_953))));
						precise float fragment_unnamed_982 = (-0.0f) - fragment_uniform_buffer_5[6u].x;
						precise float fragment_unnamed_984 = (-0.0f) - fragment_uniform_buffer_5[6u].y;
						precise float fragment_unnamed_986 = (-0.0f) - fragment_uniform_buffer_5[6u].z;
						precise float fragment_unnamed_987 = fragment_input_3.x + fragment_unnamed_982;
						precise float fragment_unnamed_988 = fragment_input_3.y + fragment_unnamed_984;
						precise float fragment_unnamed_989 = fragment_input_3.z + fragment_unnamed_986;
						fragment_unnamed_993 = mad(fragment_unnamed_913, fragment_unnamed_972, fragment_unnamed_987);
						fragment_unnamed_994 = mad(fragment_unnamed_914, fragment_unnamed_972, fragment_unnamed_988);
						fragment_unnamed_995 = mad(fragment_unnamed_915, fragment_unnamed_972, fragment_unnamed_989);
					}
					else
					{
						fragment_unnamed_993 = fragment_unnamed_361;
						fragment_unnamed_994 = fragment_unnamed_362;
						fragment_unnamed_995 = fragment_unnamed_363;
					}
					float4 fragment_unnamed_997 = unity_SpecCube1.SampleLevel(samplerunity_SpecCube0, float3(fragment_unnamed_993, fragment_unnamed_994, fragment_unnamed_995), fragment_unnamed_661);
					precise float fragment_unnamed_1003 = fragment_unnamed_997.w + (-1.0f);
					precise float fragment_unnamed_1011 = mad(fragment_uniform_buffer_5[7u].w, fragment_unnamed_1003, 1.0f) * fragment_uniform_buffer_5[7u].x;
					precise float fragment_unnamed_1012 = fragment_unnamed_997.x * fragment_unnamed_1011;
					precise float fragment_unnamed_1013 = fragment_unnamed_997.y * fragment_unnamed_1011;
					precise float fragment_unnamed_1014 = fragment_unnamed_997.z * fragment_unnamed_1011;
					precise float fragment_unnamed_1015 = (-0.0f) - fragment_unnamed_1012;
					precise float fragment_unnamed_1016 = (-0.0f) - fragment_unnamed_1013;
					precise float fragment_unnamed_1017 = (-0.0f) - fragment_unnamed_1014;
					fragment_unnamed_693 = mad(fragment_uniform_buffer_5[1u].w, mad(fragment_unnamed_680, fragment_unnamed_667, fragment_unnamed_1015), fragment_unnamed_1012);
					fragment_unnamed_695 = mad(fragment_uniform_buffer_5[1u].w, mad(fragment_unnamed_680, fragment_unnamed_668, fragment_unnamed_1016), fragment_unnamed_1013);
					fragment_unnamed_697 = mad(fragment_uniform_buffer_5[1u].w, mad(fragment_unnamed_680, fragment_unnamed_669, fragment_unnamed_1017), fragment_unnamed_1014);
				}
				else
				{
					fragment_unnamed_693 = fragment_unnamed_681;
					fragment_unnamed_695 = fragment_unnamed_682;
					fragment_unnamed_697 = fragment_unnamed_683;
				}
				float fragment_unnamed_714 = rsqrt(dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z)));
				precise float fragment_unnamed_721 = fragment_unnamed_714 * fragment_input_2.x;
				precise float fragment_unnamed_722 = fragment_unnamed_714 * fragment_input_2.y;
				precise float fragment_unnamed_723 = fragment_unnamed_714 * fragment_input_2.z;
				float fragment_unnamed_737 = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_133, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_739 = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_134, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_740 = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_135, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_744 = (-0.0f) - fragment_uniform_buffer_0[4u].y;
				float fragment_unnamed_745 = mad(fragment_unnamed_744, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_747 = fragment_unnamed_745 * fragment_unnamed_142;
				precise float fragment_unnamed_748 = fragment_unnamed_745 * fragment_unnamed_143;
				precise float fragment_unnamed_749 = fragment_unnamed_745 * fragment_unnamed_144;
				float fragment_unnamed_755 = mad(fragment_unnamed_105, fragment_unnamed_112, fragment_uniform_buffer_2[0u].x);
				float fragment_unnamed_756 = mad(fragment_unnamed_106, fragment_unnamed_112, fragment_uniform_buffer_2[0u].y);
				float fragment_unnamed_757 = mad(fragment_unnamed_107, fragment_unnamed_112, fragment_uniform_buffer_2[0u].z);
				float fragment_unnamed_763 = rsqrt(max(dot(float3(fragment_unnamed_755, fragment_unnamed_756, fragment_unnamed_757), float3(fragment_unnamed_755, fragment_unnamed_756, fragment_unnamed_757)), 0.001000000047497451305389404296875f));
				precise float fragment_unnamed_764 = fragment_unnamed_763 * fragment_unnamed_755;
				precise float fragment_unnamed_765 = fragment_unnamed_763 * fragment_unnamed_756;
				precise float fragment_unnamed_766 = fragment_unnamed_763 * fragment_unnamed_757;
				float fragment_unnamed_767 = dot(float3(fragment_unnamed_721, fragment_unnamed_722, fragment_unnamed_723), float3(fragment_unnamed_113, fragment_unnamed_114, fragment_unnamed_115));
				float fragment_unnamed_778 = clamp(dot(float3(fragment_unnamed_721, fragment_unnamed_722, fragment_unnamed_723), float3(fragment_uniform_buffer_2[0u].xyz)), 0.0f, 1.0f);
				float fragment_unnamed_782 = clamp(dot(float3(fragment_unnamed_721, fragment_unnamed_722, fragment_unnamed_723), float3(fragment_unnamed_764, fragment_unnamed_765, fragment_unnamed_766)), 0.0f, 1.0f);
				float fragment_unnamed_791 = clamp(dot(float3(fragment_uniform_buffer_2[0u].xyz), float3(fragment_unnamed_764, fragment_unnamed_765, fragment_unnamed_766)), 0.0f, 1.0f);
				precise float fragment_unnamed_792 = fragment_unnamed_791 * fragment_unnamed_791;
				precise float fragment_unnamed_796 = dot(fragment_unnamed_792.xx, fragment_unnamed_337.xx) + (-0.5f);
				precise float fragment_unnamed_798 = (-0.0f) - fragment_unnamed_778;
				precise float fragment_unnamed_799 = fragment_unnamed_798 + 1.0f;
				precise float fragment_unnamed_800 = fragment_unnamed_799 * fragment_unnamed_799;
				precise float fragment_unnamed_801 = fragment_unnamed_800 * fragment_unnamed_800;
				precise float fragment_unnamed_802 = fragment_unnamed_799 * fragment_unnamed_801;
				precise float fragment_unnamed_805 = (-0.0f) - abs(fragment_unnamed_767);
				precise float fragment_unnamed_806 = fragment_unnamed_805 + 1.0f;
				precise float fragment_unnamed_807 = fragment_unnamed_806 * fragment_unnamed_806;
				precise float fragment_unnamed_808 = fragment_unnamed_807 * fragment_unnamed_807;
				precise float fragment_unnamed_809 = fragment_unnamed_806 * fragment_unnamed_808;
				precise float fragment_unnamed_811 = mad(fragment_unnamed_796, fragment_unnamed_809, 1.0f) * mad(fragment_unnamed_796, fragment_unnamed_802, 1.0f);
				precise float fragment_unnamed_812 = fragment_unnamed_337 * fragment_unnamed_337;
				float fragment_unnamed_813 = max(fragment_unnamed_812, 0.00200000009499490261077880859375f);
				precise float fragment_unnamed_815 = (-0.0f) - fragment_unnamed_813;
				precise float fragment_unnamed_816 = fragment_unnamed_815 + 1.0f;
				precise float fragment_unnamed_821 = abs(fragment_unnamed_767) * mad(fragment_unnamed_778, fragment_unnamed_816, fragment_unnamed_813);
				precise float fragment_unnamed_823 = mad(fragment_unnamed_778, mad(abs(fragment_unnamed_767), fragment_unnamed_816, fragment_unnamed_813), fragment_unnamed_821) + 9.9999997473787516355514526367188e-06f;
				precise float fragment_unnamed_825 = 0.5f / fragment_unnamed_823;
				precise float fragment_unnamed_826 = fragment_unnamed_813 * fragment_unnamed_813;
				precise float fragment_unnamed_827 = (-0.0f) - fragment_unnamed_782;
				float fragment_unnamed_829 = mad(mad(fragment_unnamed_782, fragment_unnamed_826, fragment_unnamed_827), fragment_unnamed_782, 1.0f);
				precise float fragment_unnamed_830 = fragment_unnamed_826 * 0.3183098733425140380859375f;
				precise float fragment_unnamed_834 = fragment_unnamed_830 / mad(fragment_unnamed_829, fragment_unnamed_829, 1.0000000116860974230803549289703e-07f);
				precise float fragment_unnamed_835 = fragment_unnamed_825 * fragment_unnamed_834;
				precise float fragment_unnamed_836 = fragment_unnamed_813 * 0.2800000011920928955078125f;
				precise float fragment_unnamed_838 = fragment_unnamed_835 * 3.1415927410125732421875f;
				precise float fragment_unnamed_843 = fragment_unnamed_778 * fragment_unnamed_811;
				precise float fragment_unnamed_844 = fragment_unnamed_778 * sqrt(max(fragment_unnamed_838, 9.9999997473787516355514526367188e-05f));
				precise float fragment_unnamed_845 = (-0.0f) - fragment_unnamed_836;
				float fragment_unnamed_846 = mad(fragment_unnamed_845, fragment_unnamed_337, 1.0f);
				precise float fragment_unnamed_855 = fragment_unnamed_844 * asfloat(((dot(float3(fragment_unnamed_737, fragment_unnamed_739, fragment_unnamed_740), float3(fragment_unnamed_737, fragment_unnamed_739, fragment_unnamed_740)) != 0.0f) ? 4294967295u : 0u) & 1065353216u);
				precise float fragment_unnamed_856 = (-0.0f) - fragment_unnamed_745;
				precise float fragment_unnamed_857 = fragment_unnamed_856 + 1.0f;
				precise float fragment_unnamed_861 = fragment_unnamed_857 + fragment_uniform_buffer_0[4u].x;
				float fragment_unnamed_862 = clamp(fragment_unnamed_861, 0.0f, 1.0f);
				precise float fragment_unnamed_866 = fragment_unnamed_369 * fragment_unnamed_855;
				precise float fragment_unnamed_867 = fragment_unnamed_370 * fragment_unnamed_855;
				precise float fragment_unnamed_868 = fragment_unnamed_371 * fragment_unnamed_855;
				precise float fragment_unnamed_869 = (-0.0f) - fragment_unnamed_791;
				precise float fragment_unnamed_870 = fragment_unnamed_869 + 1.0f;
				precise float fragment_unnamed_871 = fragment_unnamed_870 * fragment_unnamed_870;
				precise float fragment_unnamed_872 = fragment_unnamed_871 * fragment_unnamed_871;
				precise float fragment_unnamed_873 = fragment_unnamed_870 * fragment_unnamed_872;
				precise float fragment_unnamed_874 = (-0.0f) - fragment_unnamed_737;
				precise float fragment_unnamed_875 = (-0.0f) - fragment_unnamed_739;
				precise float fragment_unnamed_876 = (-0.0f) - fragment_unnamed_740;
				precise float fragment_unnamed_877 = fragment_unnamed_874 + 1.0f;
				precise float fragment_unnamed_878 = fragment_unnamed_875 + 1.0f;
				precise float fragment_unnamed_879 = fragment_unnamed_876 + 1.0f;
				precise float fragment_unnamed_883 = mad(fragment_unnamed_877, fragment_unnamed_873, fragment_unnamed_737) * fragment_unnamed_866;
				precise float fragment_unnamed_884 = mad(fragment_unnamed_878, fragment_unnamed_873, fragment_unnamed_739) * fragment_unnamed_867;
				precise float fragment_unnamed_885 = mad(fragment_unnamed_879, fragment_unnamed_873, fragment_unnamed_740) * fragment_unnamed_868;
				precise float fragment_unnamed_889 = fragment_unnamed_693 * fragment_unnamed_846;
				precise float fragment_unnamed_890 = fragment_unnamed_695 * fragment_unnamed_846;
				precise float fragment_unnamed_891 = fragment_unnamed_697 * fragment_unnamed_846;
				precise float fragment_unnamed_892 = (-0.0f) - fragment_unnamed_737;
				precise float fragment_unnamed_893 = (-0.0f) - fragment_unnamed_739;
				precise float fragment_unnamed_894 = (-0.0f) - fragment_unnamed_740;
				precise float fragment_unnamed_895 = fragment_unnamed_892 + fragment_unnamed_862;
				precise float fragment_unnamed_896 = fragment_unnamed_893 + fragment_unnamed_862;
				precise float fragment_unnamed_897 = fragment_unnamed_894 + fragment_unnamed_862;
				fragment_output_0.x = mad(fragment_unnamed_889, mad(fragment_unnamed_809, fragment_unnamed_895, fragment_unnamed_737), mad(fragment_unnamed_747, mad(fragment_unnamed_369, fragment_unnamed_843, max(mad(exp2(fragment_unnamed_550), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f)), fragment_unnamed_883));
				fragment_output_0.y = mad(fragment_unnamed_890, mad(fragment_unnamed_809, fragment_unnamed_896, fragment_unnamed_739), mad(fragment_unnamed_748, mad(fragment_unnamed_370, fragment_unnamed_843, max(mad(exp2(fragment_unnamed_552), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f)), fragment_unnamed_884));
				fragment_output_0.z = mad(fragment_unnamed_891, mad(fragment_unnamed_809, fragment_unnamed_897, fragment_unnamed_740), mad(fragment_unnamed_749, mad(fragment_unnamed_371, fragment_unnamed_843, max(mad(exp2(fragment_unnamed_553), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f)), fragment_unnamed_885));
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[4] = float4(_Glossiness, fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _Metallic, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[5] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_uniform_buffer_2[39] = float4(unity_SHAr[0], unity_SHAr[1], unity_SHAr[2], unity_SHAr[3]);

				fragment_uniform_buffer_2[40] = float4(unity_SHAg[0], unity_SHAg[1], unity_SHAg[2], unity_SHAg[3]);

				fragment_uniform_buffer_2[41] = float4(unity_SHAb[0], unity_SHAb[1], unity_SHAb[2], unity_SHAb[3]);

				fragment_uniform_buffer_2[46] = float4(unity_OcclusionMaskSelector[0], unity_OcclusionMaskSelector[1], unity_OcclusionMaskSelector[2], unity_OcclusionMaskSelector[3]);

				fragment_uniform_buffer_3[24] = float4(_LightShadowData[0], _LightShadowData[1], _LightShadowData[2], _LightShadowData[3]);

				fragment_uniform_buffer_3[25] = float4(unity_ShadowFadeCenterAndType[0], unity_ShadowFadeCenterAndType[1], unity_ShadowFadeCenterAndType[2], unity_ShadowFadeCenterAndType[3]);

				fragment_uniform_buffer_4[9] = float4(unity_MatrixV[0][0], unity_MatrixV[1][0], unity_MatrixV[2][0], unity_MatrixV[3][0]);
				fragment_uniform_buffer_4[10] = float4(unity_MatrixV[0][1], unity_MatrixV[1][1], unity_MatrixV[2][1], unity_MatrixV[3][1]);
				fragment_uniform_buffer_4[11] = float4(unity_MatrixV[0][2], unity_MatrixV[1][2], unity_MatrixV[2][2], unity_MatrixV[3][2]);
				fragment_uniform_buffer_4[12] = float4(unity_MatrixV[0][3], unity_MatrixV[1][3], unity_MatrixV[2][3], unity_MatrixV[3][3]);

				fragment_uniform_buffer_5[0] = float4(unity_SpecCube0_BoxMax[0], unity_SpecCube0_BoxMax[1], unity_SpecCube0_BoxMax[2], unity_SpecCube0_BoxMax[3]);

				fragment_uniform_buffer_5[1] = float4(unity_SpecCube0_BoxMin[0], unity_SpecCube0_BoxMin[1], unity_SpecCube0_BoxMin[2], unity_SpecCube0_BoxMin[3]);

				fragment_uniform_buffer_5[2] = float4(unity_SpecCube0_ProbePosition[0], unity_SpecCube0_ProbePosition[1], unity_SpecCube0_ProbePosition[2], unity_SpecCube0_ProbePosition[3]);

				fragment_uniform_buffer_5[3] = float4(unity_SpecCube0_HDR[0], unity_SpecCube0_HDR[1], unity_SpecCube0_HDR[2], unity_SpecCube0_HDR[3]);

				fragment_uniform_buffer_5[4] = float4(unity_SpecCube1_BoxMax[0], unity_SpecCube1_BoxMax[1], unity_SpecCube1_BoxMax[2], unity_SpecCube1_BoxMax[3]);

				fragment_uniform_buffer_5[5] = float4(unity_SpecCube1_BoxMin[0], unity_SpecCube1_BoxMin[1], unity_SpecCube1_BoxMin[2], unity_SpecCube1_BoxMin[3]);

				fragment_uniform_buffer_5[6] = float4(unity_SpecCube1_ProbePosition[0], unity_SpecCube1_ProbePosition[1], unity_SpecCube1_ProbePosition[2], unity_SpecCube1_ProbePosition[3]);

				fragment_uniform_buffer_5[7] = float4(unity_SpecCube1_HDR[0], unity_SpecCube1_HDR[1], unity_SpecCube1_HDR[2], unity_SpecCube1_HDR[3]);

				fragment_uniform_buffer_6[0] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_6[1] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_6[2] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_6[3] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_6[4] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_6[5] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], fragment_uniform_buffer_6[5][3]);

				fragment_uniform_buffer_6[6] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], fragment_uniform_buffer_6[6][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(DIRECTIONAL) && defined(LIGHTPROBE_SH) && defined(SHADOWS_SCREEN) && !defined(VERTEXLIGHT_ON)


			#if defined(DIRECTIONAL) && defined(VERTEXLIGHT_ON) && !defined(LIGHTPROBE_SH) && !defined(SHADOWS_SCREEN)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _MainTex_ST;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float4 vertex_output_5 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_6 : TEXCOORD6; // TEXCOORD_6
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_56 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_59 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				float vertex_unnamed_82 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_56));
				float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_57));
				float vertex_unnamed_84 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_58));
				precise float vertex_unnamed_93 = vertex_unnamed_82 + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_94 = vertex_unnamed_83 + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_95 = vertex_unnamed_84 + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_96 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_59)) + vertex_uniform_buffer_1[3u].w;
				vertex_output_3.x = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_82);
				vertex_output_3.y = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_83);
				vertex_output_3.z = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_84);
				precise float vertex_unnamed_118 = vertex_unnamed_94 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_119 = vertex_unnamed_94 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_120 = vertex_unnamed_94 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_121 = vertex_unnamed_94 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_96, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_95, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_93, vertex_unnamed_118)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_96, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_95, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_93, vertex_unnamed_119)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_96, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_95, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_93, vertex_unnamed_120)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_96, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_95, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_93, vertex_unnamed_121)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[6u].x, vertex_uniform_buffer_0[6u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[6u].y, vertex_uniform_buffer_0[6u].w);
				float vertex_unnamed_188 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_203 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_217 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_223 = rsqrt(dot(float3(vertex_unnamed_188, vertex_unnamed_203, vertex_unnamed_217), float3(vertex_unnamed_188, vertex_unnamed_203, vertex_unnamed_217)));
				precise float vertex_unnamed_224 = vertex_unnamed_223 * vertex_unnamed_188;
				precise float vertex_unnamed_225 = vertex_unnamed_223 * vertex_unnamed_203;
				precise float vertex_unnamed_226 = vertex_unnamed_223 * vertex_unnamed_217;
				vertex_output_2.x = vertex_unnamed_224;
				vertex_output_2.y = vertex_unnamed_225;
				vertex_output_2.z = vertex_unnamed_226;
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				vertex_output_5.x = 0.0f;
				vertex_output_5.y = 0.0f;
				vertex_output_5.z = 0.0f;
				vertex_output_5.w = 0.0f;
				vertex_output_6.x = 0.0f;
				vertex_output_6.y = 0.0f;
				vertex_output_6.z = 0.0f;
				vertex_output_6.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_2[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_2[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_2[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}

			#endif // defined(DIRECTIONAL) && defined(VERTEXLIGHT_ON) && !defined(LIGHTPROBE_SH) && !defined(SHADOWS_SCREEN)


			#if defined(DIRECTIONAL) && defined(LIGHTPROBE_SH) && defined(VERTEXLIGHT_ON) && !defined(SHADOWS_SCREEN)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _MainTex_ST;
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
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
			static float4 vertex_uniform_buffer_1[46];
			static float4 vertex_uniform_buffer_2[8];
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
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static float4 vertex_output_6;
			static float4 vertex_output_7;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float3 vertex_output_5 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_7 : TEXCOORD6; // TEXCOORD_6
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_62 = vertex_input_0.y * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_63 = vertex_input_0.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_64 = vertex_input_0.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_65 = vertex_input_0.y * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_88 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_0.x, vertex_unnamed_62));
				float vertex_unnamed_89 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_0.x, vertex_unnamed_63));
				float vertex_unnamed_90 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_0.x, vertex_unnamed_64));
				precise float vertex_unnamed_99 = vertex_unnamed_88 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_100 = vertex_unnamed_89 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_101 = vertex_unnamed_90 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_102 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_input_0.x, vertex_unnamed_65)) + vertex_uniform_buffer_2[3u].w;
				float vertex_unnamed_110 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_88);
				float vertex_unnamed_111 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_89);
				float vertex_unnamed_112 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_90);
				precise float vertex_unnamed_120 = vertex_unnamed_100 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_121 = vertex_unnamed_100 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_122 = vertex_unnamed_100 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_123 = vertex_unnamed_100 * vertex_uniform_buffer_3[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_102, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_101, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_99, vertex_unnamed_120)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_102, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_101, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_99, vertex_unnamed_121)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_102, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_101, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_99, vertex_unnamed_122)));
				gl_Position.w = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_102, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_101, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_99, vertex_unnamed_123)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[6u].x, vertex_uniform_buffer_0[6u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[6u].y, vertex_uniform_buffer_0[6u].w);
				float vertex_unnamed_191 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_206 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_220 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_226 = rsqrt(dot(float3(vertex_unnamed_191, vertex_unnamed_206, vertex_unnamed_220), float3(vertex_unnamed_191, vertex_unnamed_206, vertex_unnamed_220)));
				precise float vertex_unnamed_227 = vertex_unnamed_226 * vertex_unnamed_191;
				precise float vertex_unnamed_228 = vertex_unnamed_226 * vertex_unnamed_206;
				precise float vertex_unnamed_229 = vertex_unnamed_226 * vertex_unnamed_220;
				vertex_output_2.x = vertex_unnamed_227;
				vertex_output_2.y = vertex_unnamed_228;
				vertex_output_2.z = vertex_unnamed_229;
				vertex_output_3.x = vertex_unnamed_110;
				vertex_output_3.y = vertex_unnamed_111;
				vertex_output_3.z = vertex_unnamed_112;
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				precise float vertex_unnamed_248 = (-0.0f) - vertex_unnamed_110;
				precise float vertex_unnamed_256 = vertex_unnamed_248 + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_257 = vertex_unnamed_248 + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_258 = vertex_unnamed_248 + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_259 = vertex_unnamed_248 + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_260 = (-0.0f) - vertex_unnamed_111;
				precise float vertex_unnamed_267 = vertex_unnamed_260 + vertex_uniform_buffer_1[4u].x;
				precise float vertex_unnamed_268 = vertex_unnamed_260 + vertex_uniform_buffer_1[4u].y;
				precise float vertex_unnamed_269 = vertex_unnamed_260 + vertex_uniform_buffer_1[4u].z;
				precise float vertex_unnamed_270 = vertex_unnamed_260 + vertex_uniform_buffer_1[4u].w;
				precise float vertex_unnamed_271 = (-0.0f) - vertex_unnamed_112;
				precise float vertex_unnamed_278 = vertex_unnamed_271 + vertex_uniform_buffer_1[5u].x;
				precise float vertex_unnamed_279 = vertex_unnamed_271 + vertex_uniform_buffer_1[5u].y;
				precise float vertex_unnamed_280 = vertex_unnamed_271 + vertex_uniform_buffer_1[5u].z;
				precise float vertex_unnamed_281 = vertex_unnamed_271 + vertex_uniform_buffer_1[5u].w;
				precise float vertex_unnamed_282 = vertex_unnamed_228 * vertex_unnamed_267;
				precise float vertex_unnamed_283 = vertex_unnamed_228 * vertex_unnamed_268;
				precise float vertex_unnamed_284 = vertex_unnamed_228 * vertex_unnamed_269;
				precise float vertex_unnamed_285 = vertex_unnamed_228 * vertex_unnamed_270;
				precise float vertex_unnamed_286 = vertex_unnamed_267 * vertex_unnamed_267;
				precise float vertex_unnamed_287 = vertex_unnamed_268 * vertex_unnamed_268;
				precise float vertex_unnamed_288 = vertex_unnamed_269 * vertex_unnamed_269;
				precise float vertex_unnamed_289 = vertex_unnamed_270 * vertex_unnamed_270;
				float vertex_unnamed_306 = max(mad(vertex_unnamed_278, vertex_unnamed_278, mad(vertex_unnamed_256, vertex_unnamed_256, vertex_unnamed_286)), 9.9999999747524270787835121154785e-07f);
				float vertex_unnamed_308 = max(mad(vertex_unnamed_279, vertex_unnamed_279, mad(vertex_unnamed_257, vertex_unnamed_257, vertex_unnamed_287)), 9.9999999747524270787835121154785e-07f);
				float vertex_unnamed_309 = max(mad(vertex_unnamed_280, vertex_unnamed_280, mad(vertex_unnamed_258, vertex_unnamed_258, vertex_unnamed_288)), 9.9999999747524270787835121154785e-07f);
				float vertex_unnamed_310 = max(mad(vertex_unnamed_281, vertex_unnamed_281, mad(vertex_unnamed_259, vertex_unnamed_259, vertex_unnamed_289)), 9.9999999747524270787835121154785e-07f);
				precise float vertex_unnamed_326 = 1.0f / mad(vertex_unnamed_306, vertex_uniform_buffer_1[6u].x, 1.0f);
				precise float vertex_unnamed_327 = 1.0f / mad(vertex_unnamed_308, vertex_uniform_buffer_1[6u].y, 1.0f);
				precise float vertex_unnamed_328 = 1.0f / mad(vertex_unnamed_309, vertex_uniform_buffer_1[6u].z, 1.0f);
				precise float vertex_unnamed_329 = 1.0f / mad(vertex_unnamed_310, vertex_uniform_buffer_1[6u].w, 1.0f);
				precise float vertex_unnamed_330 = mad(vertex_unnamed_278, vertex_unnamed_229, mad(vertex_unnamed_256, vertex_unnamed_227, vertex_unnamed_282)) * rsqrt(vertex_unnamed_306);
				precise float vertex_unnamed_331 = mad(vertex_unnamed_279, vertex_unnamed_229, mad(vertex_unnamed_257, vertex_unnamed_227, vertex_unnamed_283)) * rsqrt(vertex_unnamed_308);
				precise float vertex_unnamed_332 = mad(vertex_unnamed_280, vertex_unnamed_229, mad(vertex_unnamed_258, vertex_unnamed_227, vertex_unnamed_284)) * rsqrt(vertex_unnamed_309);
				precise float vertex_unnamed_333 = mad(vertex_unnamed_281, vertex_unnamed_229, mad(vertex_unnamed_259, vertex_unnamed_227, vertex_unnamed_285)) * rsqrt(vertex_unnamed_310);
				precise float vertex_unnamed_339 = vertex_unnamed_326 * max(vertex_unnamed_330, 0.0f);
				precise float vertex_unnamed_340 = vertex_unnamed_327 * max(vertex_unnamed_331, 0.0f);
				precise float vertex_unnamed_341 = vertex_unnamed_328 * max(vertex_unnamed_332, 0.0f);
				precise float vertex_unnamed_342 = vertex_unnamed_329 * max(vertex_unnamed_333, 0.0f);
				precise float vertex_unnamed_349 = vertex_unnamed_340 * vertex_uniform_buffer_1[8u].x;
				precise float vertex_unnamed_350 = vertex_unnamed_340 * vertex_uniform_buffer_1[8u].y;
				precise float vertex_unnamed_351 = vertex_unnamed_340 * vertex_uniform_buffer_1[8u].z;
				float vertex_unnamed_375 = mad(vertex_uniform_buffer_1[10u].x, vertex_unnamed_342, mad(vertex_uniform_buffer_1[9u].x, vertex_unnamed_341, mad(vertex_uniform_buffer_1[7u].x, vertex_unnamed_339, vertex_unnamed_349)));
				float vertex_unnamed_376 = mad(vertex_uniform_buffer_1[10u].y, vertex_unnamed_342, mad(vertex_uniform_buffer_1[9u].y, vertex_unnamed_341, mad(vertex_uniform_buffer_1[7u].y, vertex_unnamed_339, vertex_unnamed_350)));
				float vertex_unnamed_377 = mad(vertex_uniform_buffer_1[10u].z, vertex_unnamed_342, mad(vertex_uniform_buffer_1[9u].z, vertex_unnamed_341, mad(vertex_uniform_buffer_1[7u].z, vertex_unnamed_339, vertex_unnamed_351)));
				precise float vertex_unnamed_387 = vertex_unnamed_228 * vertex_unnamed_228;
				precise float vertex_unnamed_388 = (-0.0f) - vertex_unnamed_387;
				float vertex_unnamed_389 = mad(vertex_unnamed_227, vertex_unnamed_227, vertex_unnamed_388);
				precise float vertex_unnamed_390 = vertex_unnamed_228 * vertex_unnamed_227;
				precise float vertex_unnamed_391 = vertex_unnamed_229 * vertex_unnamed_228;
				precise float vertex_unnamed_392 = vertex_unnamed_229 * vertex_unnamed_229;
				precise float vertex_unnamed_393 = vertex_unnamed_227 * vertex_unnamed_229;
				vertex_output_5.x = mad(vertex_unnamed_375, mad(vertex_unnamed_375, mad(vertex_unnamed_375, 0.305306017398834228515625f, 0.6821711063385009765625f), 0.01252287812530994415283203125f), mad(vertex_uniform_buffer_1[45u].x, vertex_unnamed_389, dot(float4(vertex_uniform_buffer_1[42u]), float4(vertex_unnamed_390, vertex_unnamed_391, vertex_unnamed_392, vertex_unnamed_393))));
				vertex_output_5.y = mad(vertex_unnamed_376, mad(vertex_unnamed_376, mad(vertex_unnamed_376, 0.305306017398834228515625f, 0.6821711063385009765625f), 0.01252287812530994415283203125f), mad(vertex_uniform_buffer_1[45u].y, vertex_unnamed_389, dot(float4(vertex_uniform_buffer_1[43u]), float4(vertex_unnamed_390, vertex_unnamed_391, vertex_unnamed_392, vertex_unnamed_393))));
				vertex_output_5.z = mad(vertex_unnamed_377, mad(vertex_unnamed_377, mad(vertex_unnamed_377, 0.305306017398834228515625f, 0.6821711063385009765625f), 0.01252287812530994415283203125f), mad(vertex_uniform_buffer_1[45u].z, vertex_unnamed_389, dot(float4(vertex_uniform_buffer_1[44u]), float4(vertex_unnamed_390, vertex_unnamed_391, vertex_unnamed_392, vertex_unnamed_393))));
				vertex_output_6.x = 0.0f;
				vertex_output_6.y = 0.0f;
				vertex_output_6.z = 0.0f;
				vertex_output_6.w = 0.0f;
				vertex_output_7.x = 0.0f;
				vertex_output_7.y = 0.0f;
				vertex_output_7.z = 0.0f;
				vertex_output_7.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[3] = float4(unity_4LightPosX0[0], unity_4LightPosX0[1], unity_4LightPosX0[2], unity_4LightPosX0[3]);

				vertex_uniform_buffer_1[4] = float4(unity_4LightPosY0[0], unity_4LightPosY0[1], unity_4LightPosY0[2], unity_4LightPosY0[3]);

				vertex_uniform_buffer_1[5] = float4(unity_4LightPosZ0[0], unity_4LightPosZ0[1], unity_4LightPosZ0[2], unity_4LightPosZ0[3]);

				vertex_uniform_buffer_1[6] = float4(unity_4LightAtten0[0], unity_4LightAtten0[1], unity_4LightAtten0[2], unity_4LightAtten0[3]);

				vertex_uniform_buffer_1[7] = float4(unity_LightColor[0][0], unity_LightColor[0][1], unity_LightColor[0][2], unity_LightColor[0][3]);
				vertex_uniform_buffer_1[8] = float4(unity_LightColor[1][0], unity_LightColor[1][1], unity_LightColor[1][2], unity_LightColor[1][3]);
				vertex_uniform_buffer_1[9] = float4(unity_LightColor[2][0], unity_LightColor[2][1], unity_LightColor[2][2], unity_LightColor[2][3]);
				vertex_uniform_buffer_1[10] = float4(unity_LightColor[3][0], unity_LightColor[3][1], unity_LightColor[3][2], unity_LightColor[3][3]);
				vertex_uniform_buffer_1[11] = float4(unity_LightColor[4][0], unity_LightColor[4][1], unity_LightColor[4][2], unity_LightColor[4][3]);
				vertex_uniform_buffer_1[12] = float4(unity_LightColor[5][0], unity_LightColor[5][1], unity_LightColor[5][2], unity_LightColor[5][3]);
				vertex_uniform_buffer_1[13] = float4(unity_LightColor[6][0], unity_LightColor[6][1], unity_LightColor[6][2], unity_LightColor[6][3]);
				vertex_uniform_buffer_1[14] = float4(unity_LightColor[7][0], unity_LightColor[7][1], unity_LightColor[7][2], unity_LightColor[7][3]);

				vertex_uniform_buffer_1[42] = float4(unity_SHBr[0], unity_SHBr[1], unity_SHBr[2], unity_SHBr[3]);

				vertex_uniform_buffer_1[43] = float4(unity_SHBg[0], unity_SHBg[1], unity_SHBg[2], unity_SHBg[3]);

				vertex_uniform_buffer_1[44] = float4(unity_SHBb[0], unity_SHBb[1], unity_SHBb[2], unity_SHBb[3]);

				vertex_uniform_buffer_1[45] = float4(unity_SHC[0], unity_SHC[1], unity_SHC[2], unity_SHC[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				return stage_output;
			}

			#endif // defined(DIRECTIONAL) && defined(LIGHTPROBE_SH) && defined(VERTEXLIGHT_ON) && !defined(SHADOWS_SCREEN)


			#if defined(DIRECTIONAL) && defined(SHADOWS_SCREEN) && defined(VERTEXLIGHT_ON) && !defined(LIGHTPROBE_SH)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _MainTex_ST;
			float4 _ProjectionParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
			static float4 vertex_uniform_buffer_1[6];
			static float4 vertex_uniform_buffer_2[8];
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
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float4 vertex_output_5 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_6 : TEXCOORD6; // TEXCOORD_6
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_61 = vertex_input_0.y * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_62 = vertex_input_0.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_63 = vertex_input_0.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_64 = vertex_input_0.y * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_87 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_0.x, vertex_unnamed_61));
				float vertex_unnamed_88 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_0.x, vertex_unnamed_62));
				float vertex_unnamed_89 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_0.x, vertex_unnamed_63));
				precise float vertex_unnamed_98 = vertex_unnamed_87 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_99 = vertex_unnamed_88 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_100 = vertex_unnamed_89 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_101 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_input_0.x, vertex_unnamed_64)) + vertex_uniform_buffer_2[3u].w;
				vertex_output_3.x = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_87);
				vertex_output_3.y = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_88);
				vertex_output_3.z = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_89);
				precise float vertex_unnamed_123 = vertex_unnamed_99 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_124 = vertex_unnamed_99 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_125 = vertex_unnamed_99 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_126 = vertex_unnamed_99 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_156 = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_101, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_100, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_98, vertex_unnamed_123)));
				float vertex_unnamed_157 = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_101, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_100, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_98, vertex_unnamed_124)));
				float vertex_unnamed_158 = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_101, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_100, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_98, vertex_unnamed_125)));
				float vertex_unnamed_159 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_101, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_100, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_98, vertex_unnamed_126)));
				gl_Position.x = vertex_unnamed_156;
				gl_Position.y = vertex_unnamed_157;
				gl_Position.z = vertex_unnamed_158;
				gl_Position.w = vertex_unnamed_159;
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[6u].x, vertex_uniform_buffer_0[6u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[6u].y, vertex_uniform_buffer_0[6u].w);
				float vertex_unnamed_192 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_207 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_221 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_227 = rsqrt(dot(float3(vertex_unnamed_192, vertex_unnamed_207, vertex_unnamed_221), float3(vertex_unnamed_192, vertex_unnamed_207, vertex_unnamed_221)));
				precise float vertex_unnamed_228 = vertex_unnamed_227 * vertex_unnamed_192;
				precise float vertex_unnamed_229 = vertex_unnamed_227 * vertex_unnamed_207;
				precise float vertex_unnamed_230 = vertex_unnamed_227 * vertex_unnamed_221;
				vertex_output_2.x = vertex_unnamed_228;
				vertex_output_2.y = vertex_unnamed_229;
				vertex_output_2.z = vertex_unnamed_230;
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				precise float vertex_unnamed_249 = vertex_unnamed_157 * vertex_uniform_buffer_1[5u].x;
				precise float vertex_unnamed_250 = vertex_unnamed_156 * 0.5f;
				precise float vertex_unnamed_252 = vertex_unnamed_159 * 0.5f;
				precise float vertex_unnamed_253 = vertex_unnamed_249 * 0.5f;
				vertex_output_5.z = vertex_unnamed_158;
				vertex_output_5.w = vertex_unnamed_159;
				precise float vertex_unnamed_256 = vertex_unnamed_252 + vertex_unnamed_250;
				precise float vertex_unnamed_257 = vertex_unnamed_252 + vertex_unnamed_253;
				vertex_output_5.x = vertex_unnamed_256;
				vertex_output_5.y = vertex_unnamed_257;
				vertex_output_6.x = 0.0f;
				vertex_output_6.y = 0.0f;
				vertex_output_6.z = 0.0f;
				vertex_output_6.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[5] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}

			#endif // defined(DIRECTIONAL) && defined(SHADOWS_SCREEN) && defined(VERTEXLIGHT_ON) && !defined(LIGHTPROBE_SH)


			#if defined(DIRECTIONAL) && defined(LIGHTPROBE_SH) && defined(SHADOWS_SCREEN) && defined(VERTEXLIGHT_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _MainTex_ST;
			float4 _ProjectionParams;
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
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
			static float4 vertex_uniform_buffer_1[6];
			static float4 vertex_uniform_buffer_2[46];
			static float4 vertex_uniform_buffer_3[8];
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
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static float4 vertex_output_6;
			static float4 vertex_output_7;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float3 vertex_output_5 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 vertex_output_7 : TEXCOORD6; // TEXCOORD_6
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_67 = vertex_input_0.y * vertex_uniform_buffer_3[1u].x;
				precise float vertex_unnamed_68 = vertex_input_0.y * vertex_uniform_buffer_3[1u].y;
				precise float vertex_unnamed_69 = vertex_input_0.y * vertex_uniform_buffer_3[1u].z;
				precise float vertex_unnamed_70 = vertex_input_0.y * vertex_uniform_buffer_3[1u].w;
				float vertex_unnamed_93 = mad(vertex_uniform_buffer_3[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].x, vertex_input_0.x, vertex_unnamed_67));
				float vertex_unnamed_94 = mad(vertex_uniform_buffer_3[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].y, vertex_input_0.x, vertex_unnamed_68));
				float vertex_unnamed_95 = mad(vertex_uniform_buffer_3[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].z, vertex_input_0.x, vertex_unnamed_69));
				precise float vertex_unnamed_104 = vertex_unnamed_93 + vertex_uniform_buffer_3[3u].x;
				precise float vertex_unnamed_105 = vertex_unnamed_94 + vertex_uniform_buffer_3[3u].y;
				precise float vertex_unnamed_106 = vertex_unnamed_95 + vertex_uniform_buffer_3[3u].z;
				precise float vertex_unnamed_107 = mad(vertex_uniform_buffer_3[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_3[0u].w, vertex_input_0.x, vertex_unnamed_70)) + vertex_uniform_buffer_3[3u].w;
				float vertex_unnamed_115 = mad(vertex_uniform_buffer_3[3u].x, vertex_input_0.w, vertex_unnamed_93);
				float vertex_unnamed_116 = mad(vertex_uniform_buffer_3[3u].y, vertex_input_0.w, vertex_unnamed_94);
				float vertex_unnamed_117 = mad(vertex_uniform_buffer_3[3u].z, vertex_input_0.w, vertex_unnamed_95);
				precise float vertex_unnamed_125 = vertex_unnamed_105 * vertex_uniform_buffer_4[18u].x;
				precise float vertex_unnamed_126 = vertex_unnamed_105 * vertex_uniform_buffer_4[18u].y;
				precise float vertex_unnamed_127 = vertex_unnamed_105 * vertex_uniform_buffer_4[18u].z;
				precise float vertex_unnamed_128 = vertex_unnamed_105 * vertex_uniform_buffer_4[18u].w;
				float vertex_unnamed_158 = mad(vertex_uniform_buffer_4[20u].x, vertex_unnamed_107, mad(vertex_uniform_buffer_4[19u].x, vertex_unnamed_106, mad(vertex_uniform_buffer_4[17u].x, vertex_unnamed_104, vertex_unnamed_125)));
				float vertex_unnamed_159 = mad(vertex_uniform_buffer_4[20u].y, vertex_unnamed_107, mad(vertex_uniform_buffer_4[19u].y, vertex_unnamed_106, mad(vertex_uniform_buffer_4[17u].y, vertex_unnamed_104, vertex_unnamed_126)));
				float vertex_unnamed_160 = mad(vertex_uniform_buffer_4[20u].z, vertex_unnamed_107, mad(vertex_uniform_buffer_4[19u].z, vertex_unnamed_106, mad(vertex_uniform_buffer_4[17u].z, vertex_unnamed_104, vertex_unnamed_127)));
				float vertex_unnamed_161 = mad(vertex_uniform_buffer_4[20u].w, vertex_unnamed_107, mad(vertex_uniform_buffer_4[19u].w, vertex_unnamed_106, mad(vertex_uniform_buffer_4[17u].w, vertex_unnamed_104, vertex_unnamed_128)));
				gl_Position.x = vertex_unnamed_158;
				gl_Position.y = vertex_unnamed_159;
				gl_Position.z = vertex_unnamed_160;
				gl_Position.w = vertex_unnamed_161;
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[6u].x, vertex_uniform_buffer_0[6u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[6u].y, vertex_uniform_buffer_0[6u].w);
				float vertex_unnamed_195 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_3[4u].xyz));
				float vertex_unnamed_210 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_3[5u].xyz));
				float vertex_unnamed_224 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_3[6u].xyz));
				float vertex_unnamed_230 = rsqrt(dot(float3(vertex_unnamed_195, vertex_unnamed_210, vertex_unnamed_224), float3(vertex_unnamed_195, vertex_unnamed_210, vertex_unnamed_224)));
				precise float vertex_unnamed_231 = vertex_unnamed_230 * vertex_unnamed_195;
				precise float vertex_unnamed_232 = vertex_unnamed_230 * vertex_unnamed_210;
				precise float vertex_unnamed_233 = vertex_unnamed_230 * vertex_unnamed_224;
				vertex_output_2.x = vertex_unnamed_231;
				vertex_output_2.y = vertex_unnamed_232;
				vertex_output_2.z = vertex_unnamed_233;
				vertex_output_3.x = vertex_unnamed_115;
				vertex_output_3.y = vertex_unnamed_116;
				vertex_output_3.z = vertex_unnamed_117;
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				precise float vertex_unnamed_252 = (-0.0f) - vertex_unnamed_115;
				precise float vertex_unnamed_260 = vertex_unnamed_252 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_261 = vertex_unnamed_252 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_262 = vertex_unnamed_252 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_263 = vertex_unnamed_252 + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_264 = (-0.0f) - vertex_unnamed_116;
				precise float vertex_unnamed_271 = vertex_unnamed_264 + vertex_uniform_buffer_2[4u].x;
				precise float vertex_unnamed_272 = vertex_unnamed_264 + vertex_uniform_buffer_2[4u].y;
				precise float vertex_unnamed_273 = vertex_unnamed_264 + vertex_uniform_buffer_2[4u].z;
				precise float vertex_unnamed_274 = vertex_unnamed_264 + vertex_uniform_buffer_2[4u].w;
				precise float vertex_unnamed_275 = (-0.0f) - vertex_unnamed_117;
				precise float vertex_unnamed_282 = vertex_unnamed_275 + vertex_uniform_buffer_2[5u].x;
				precise float vertex_unnamed_283 = vertex_unnamed_275 + vertex_uniform_buffer_2[5u].y;
				precise float vertex_unnamed_284 = vertex_unnamed_275 + vertex_uniform_buffer_2[5u].z;
				precise float vertex_unnamed_285 = vertex_unnamed_275 + vertex_uniform_buffer_2[5u].w;
				precise float vertex_unnamed_286 = vertex_unnamed_232 * vertex_unnamed_271;
				precise float vertex_unnamed_287 = vertex_unnamed_232 * vertex_unnamed_272;
				precise float vertex_unnamed_288 = vertex_unnamed_232 * vertex_unnamed_273;
				precise float vertex_unnamed_289 = vertex_unnamed_232 * vertex_unnamed_274;
				precise float vertex_unnamed_290 = vertex_unnamed_271 * vertex_unnamed_271;
				precise float vertex_unnamed_291 = vertex_unnamed_272 * vertex_unnamed_272;
				precise float vertex_unnamed_292 = vertex_unnamed_273 * vertex_unnamed_273;
				precise float vertex_unnamed_293 = vertex_unnamed_274 * vertex_unnamed_274;
				float vertex_unnamed_310 = max(mad(vertex_unnamed_282, vertex_unnamed_282, mad(vertex_unnamed_260, vertex_unnamed_260, vertex_unnamed_290)), 9.9999999747524270787835121154785e-07f);
				float vertex_unnamed_312 = max(mad(vertex_unnamed_283, vertex_unnamed_283, mad(vertex_unnamed_261, vertex_unnamed_261, vertex_unnamed_291)), 9.9999999747524270787835121154785e-07f);
				float vertex_unnamed_313 = max(mad(vertex_unnamed_284, vertex_unnamed_284, mad(vertex_unnamed_262, vertex_unnamed_262, vertex_unnamed_292)), 9.9999999747524270787835121154785e-07f);
				float vertex_unnamed_314 = max(mad(vertex_unnamed_285, vertex_unnamed_285, mad(vertex_unnamed_263, vertex_unnamed_263, vertex_unnamed_293)), 9.9999999747524270787835121154785e-07f);
				precise float vertex_unnamed_330 = 1.0f / mad(vertex_unnamed_310, vertex_uniform_buffer_2[6u].x, 1.0f);
				precise float vertex_unnamed_331 = 1.0f / mad(vertex_unnamed_312, vertex_uniform_buffer_2[6u].y, 1.0f);
				precise float vertex_unnamed_332 = 1.0f / mad(vertex_unnamed_313, vertex_uniform_buffer_2[6u].z, 1.0f);
				precise float vertex_unnamed_333 = 1.0f / mad(vertex_unnamed_314, vertex_uniform_buffer_2[6u].w, 1.0f);
				precise float vertex_unnamed_334 = mad(vertex_unnamed_282, vertex_unnamed_233, mad(vertex_unnamed_260, vertex_unnamed_231, vertex_unnamed_286)) * rsqrt(vertex_unnamed_310);
				precise float vertex_unnamed_335 = mad(vertex_unnamed_283, vertex_unnamed_233, mad(vertex_unnamed_261, vertex_unnamed_231, vertex_unnamed_287)) * rsqrt(vertex_unnamed_312);
				precise float vertex_unnamed_336 = mad(vertex_unnamed_284, vertex_unnamed_233, mad(vertex_unnamed_262, vertex_unnamed_231, vertex_unnamed_288)) * rsqrt(vertex_unnamed_313);
				precise float vertex_unnamed_337 = mad(vertex_unnamed_285, vertex_unnamed_233, mad(vertex_unnamed_263, vertex_unnamed_231, vertex_unnamed_289)) * rsqrt(vertex_unnamed_314);
				precise float vertex_unnamed_343 = vertex_unnamed_330 * max(vertex_unnamed_334, 0.0f);
				precise float vertex_unnamed_344 = vertex_unnamed_331 * max(vertex_unnamed_335, 0.0f);
				precise float vertex_unnamed_345 = vertex_unnamed_332 * max(vertex_unnamed_336, 0.0f);
				precise float vertex_unnamed_346 = vertex_unnamed_333 * max(vertex_unnamed_337, 0.0f);
				precise float vertex_unnamed_353 = vertex_unnamed_344 * vertex_uniform_buffer_2[8u].x;
				precise float vertex_unnamed_354 = vertex_unnamed_344 * vertex_uniform_buffer_2[8u].y;
				precise float vertex_unnamed_355 = vertex_unnamed_344 * vertex_uniform_buffer_2[8u].z;
				float vertex_unnamed_379 = mad(vertex_uniform_buffer_2[10u].x, vertex_unnamed_346, mad(vertex_uniform_buffer_2[9u].x, vertex_unnamed_345, mad(vertex_uniform_buffer_2[7u].x, vertex_unnamed_343, vertex_unnamed_353)));
				float vertex_unnamed_380 = mad(vertex_uniform_buffer_2[10u].y, vertex_unnamed_346, mad(vertex_uniform_buffer_2[9u].y, vertex_unnamed_345, mad(vertex_uniform_buffer_2[7u].y, vertex_unnamed_343, vertex_unnamed_354)));
				float vertex_unnamed_381 = mad(vertex_uniform_buffer_2[10u].z, vertex_unnamed_346, mad(vertex_uniform_buffer_2[9u].z, vertex_unnamed_345, mad(vertex_uniform_buffer_2[7u].z, vertex_unnamed_343, vertex_unnamed_355)));
				precise float vertex_unnamed_391 = vertex_unnamed_232 * vertex_unnamed_232;
				precise float vertex_unnamed_392 = (-0.0f) - vertex_unnamed_391;
				float vertex_unnamed_393 = mad(vertex_unnamed_231, vertex_unnamed_231, vertex_unnamed_392);
				precise float vertex_unnamed_394 = vertex_unnamed_232 * vertex_unnamed_231;
				precise float vertex_unnamed_395 = vertex_unnamed_233 * vertex_unnamed_232;
				precise float vertex_unnamed_396 = vertex_unnamed_233 * vertex_unnamed_233;
				precise float vertex_unnamed_397 = vertex_unnamed_231 * vertex_unnamed_233;
				vertex_output_5.x = mad(vertex_unnamed_379, mad(vertex_unnamed_379, mad(vertex_unnamed_379, 0.305306017398834228515625f, 0.6821711063385009765625f), 0.01252287812530994415283203125f), mad(vertex_uniform_buffer_2[45u].x, vertex_unnamed_393, dot(float4(vertex_uniform_buffer_2[42u]), float4(vertex_unnamed_394, vertex_unnamed_395, vertex_unnamed_396, vertex_unnamed_397))));
				vertex_output_5.y = mad(vertex_unnamed_380, mad(vertex_unnamed_380, mad(vertex_unnamed_380, 0.305306017398834228515625f, 0.6821711063385009765625f), 0.01252287812530994415283203125f), mad(vertex_uniform_buffer_2[45u].y, vertex_unnamed_393, dot(float4(vertex_uniform_buffer_2[43u]), float4(vertex_unnamed_394, vertex_unnamed_395, vertex_unnamed_396, vertex_unnamed_397))));
				vertex_output_5.z = mad(vertex_unnamed_381, mad(vertex_unnamed_381, mad(vertex_unnamed_381, 0.305306017398834228515625f, 0.6821711063385009765625f), 0.01252287812530994415283203125f), mad(vertex_uniform_buffer_2[45u].z, vertex_unnamed_393, dot(float4(vertex_uniform_buffer_2[44u]), float4(vertex_unnamed_394, vertex_unnamed_395, vertex_unnamed_396, vertex_unnamed_397))));
				precise float vertex_unnamed_446 = vertex_unnamed_159 * vertex_uniform_buffer_1[5u].x;
				precise float vertex_unnamed_447 = vertex_unnamed_446 * 0.5f;
				precise float vertex_unnamed_449 = vertex_unnamed_158 * 0.5f;
				precise float vertex_unnamed_450 = vertex_unnamed_161 * 0.5f;
				vertex_output_6.z = vertex_unnamed_160;
				vertex_output_6.w = vertex_unnamed_161;
				precise float vertex_unnamed_453 = vertex_unnamed_450 + vertex_unnamed_449;
				precise float vertex_unnamed_454 = vertex_unnamed_450 + vertex_unnamed_447;
				vertex_output_6.x = vertex_unnamed_453;
				vertex_output_6.y = vertex_unnamed_454;
				vertex_output_7.x = 0.0f;
				vertex_output_7.y = 0.0f;
				vertex_output_7.z = 0.0f;
				vertex_output_7.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[5] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				return stage_output;
			}

			#endif // defined(DIRECTIONAL) && defined(LIGHTPROBE_SH) && defined(SHADOWS_SCREEN) && defined(VERTEXLIGHT_ON)


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
			LOD 200
			Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			Blend One One
			ZWrite Off
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 95750

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#pragma shader_feature DIRECTIONAL
			#pragma shader_feature DIRECTIONAL_COOKIE
			#pragma shader_feature POINT
			#pragma shader_feature POINT_COOKIE
			#pragma shader_feature SHADOWS_CUBE
			#pragma shader_feature SHADOWS_DEPTH
			#pragma shader_feature SHADOWS_SCREEN
			#pragma shader_feature SHADOWS_SOFT
			#pragma shader_feature SPOT


			#if defined(POINT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_SCREEN) && !defined(SHADOWS_CUBE)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToLight;
			float4 _MainTex_ST;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[11];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static float4 vertex_output_6;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float3 vertex_output_5 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_6 : TEXCOORD4; // TEXCOORD_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_59 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_60 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_57));
				float vertex_unnamed_84 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_58));
				float vertex_unnamed_85 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_59));
				float vertex_unnamed_86 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_60));
				precise float vertex_unnamed_94 = vertex_unnamed_83 + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_95 = vertex_unnamed_84 + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_96 = vertex_unnamed_85 + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_97 = vertex_unnamed_86 + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_105 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_106 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_107 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_108 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_94, vertex_unnamed_105)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_94, vertex_unnamed_106)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_94, vertex_unnamed_107)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_94, vertex_unnamed_108)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[10u].x, vertex_uniform_buffer_0[10u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[10u].y, vertex_uniform_buffer_0[10u].w);
				float vertex_unnamed_176 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_191 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_206 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_212 = rsqrt(dot(float3(vertex_unnamed_176, vertex_unnamed_191, vertex_unnamed_206), float3(vertex_unnamed_176, vertex_unnamed_191, vertex_unnamed_206)));
				precise float vertex_unnamed_213 = vertex_unnamed_212 * vertex_unnamed_176;
				precise float vertex_unnamed_214 = vertex_unnamed_212 * vertex_unnamed_191;
				precise float vertex_unnamed_215 = vertex_unnamed_212 * vertex_unnamed_206;
				vertex_output_2.x = vertex_unnamed_213;
				vertex_output_2.y = vertex_unnamed_214;
				vertex_output_2.z = vertex_unnamed_215;
				vertex_output_3.x = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				vertex_output_3.y = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				vertex_output_3.z = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				float vertex_unnamed_240 = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				float vertex_unnamed_241 = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				float vertex_unnamed_242 = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				float vertex_unnamed_243 = mad(vertex_uniform_buffer_1[3u].w, vertex_input_0.w, vertex_unnamed_86);
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				precise float vertex_unnamed_261 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_262 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].y;
				precise float vertex_unnamed_263 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].z;
				vertex_output_5.x = mad(vertex_uniform_buffer_0[7u].x, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].x, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].x, vertex_unnamed_240, vertex_unnamed_261)));
				vertex_output_5.y = mad(vertex_uniform_buffer_0[7u].y, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].y, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].y, vertex_unnamed_240, vertex_unnamed_262)));
				vertex_output_5.z = mad(vertex_uniform_buffer_0[7u].z, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].z, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].z, vertex_unnamed_240, vertex_unnamed_263)));
				vertex_output_6.x = 0.0f;
				vertex_output_6.y = 0.0f;
				vertex_output_6.z = 0.0f;
				vertex_output_6.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				vertex_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				vertex_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				vertex_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				vertex_uniform_buffer_0[10] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_2[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_2[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_2[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}


			float4 _LightColor0;
			float4x4 unity_WorldToLight;
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_OcclusionMaskSelector;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[10];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _LightTexture0;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_LightTexture0;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float3 fragment_input_5 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_6 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_64 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_69 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_73 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_80 = fragment_unnamed_64 + fragment_uniform_buffer_2[0u].x;
				precise float fragment_unnamed_81 = fragment_unnamed_69 + fragment_uniform_buffer_2[0u].y;
				precise float fragment_unnamed_82 = fragment_unnamed_73 + fragment_uniform_buffer_2[0u].z;
				float fragment_unnamed_87 = rsqrt(dot(float3(fragment_unnamed_80, fragment_unnamed_81, fragment_unnamed_82), float3(fragment_unnamed_80, fragment_unnamed_81, fragment_unnamed_82)));
				precise float fragment_unnamed_88 = fragment_unnamed_87 * fragment_unnamed_80;
				precise float fragment_unnamed_89 = fragment_unnamed_87 * fragment_unnamed_81;
				precise float fragment_unnamed_90 = fragment_unnamed_87 * fragment_unnamed_82;
				precise float fragment_unnamed_93 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_96 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_99 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_106 = fragment_unnamed_93 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_107 = fragment_unnamed_96 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_108 = fragment_unnamed_99 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_112 = rsqrt(dot(float3(fragment_unnamed_106, fragment_unnamed_107, fragment_unnamed_108), float3(fragment_unnamed_106, fragment_unnamed_107, fragment_unnamed_108)));
				precise float fragment_unnamed_113 = fragment_unnamed_112 * fragment_unnamed_106;
				precise float fragment_unnamed_114 = fragment_unnamed_112 * fragment_unnamed_107;
				precise float fragment_unnamed_115 = fragment_unnamed_112 * fragment_unnamed_108;
				float4 fragment_unnamed_123 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_134 = fragment_unnamed_123.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_135 = fragment_unnamed_123.y * fragment_uniform_buffer_0[9u].y;
				precise float fragment_unnamed_136 = fragment_unnamed_123.z * fragment_uniform_buffer_0[9u].z;
				precise float fragment_unnamed_143 = fragment_unnamed_134 * fragment_input_4.x;
				precise float fragment_unnamed_144 = fragment_unnamed_135 * fragment_input_4.y;
				precise float fragment_unnamed_145 = fragment_unnamed_136 * fragment_input_4.z;
				precise float fragment_unnamed_153 = fragment_input_3.y * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_154 = fragment_input_3.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_155 = fragment_input_3.y * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_182 = mad(fragment_uniform_buffer_0[6u].x, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].x, fragment_input_3.x, fragment_unnamed_153)) + fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_183 = mad(fragment_uniform_buffer_0[6u].y, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].y, fragment_input_3.x, fragment_unnamed_154)) + fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_184 = mad(fragment_uniform_buffer_0[6u].z, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].z, fragment_input_3.x, fragment_unnamed_155)) + fragment_uniform_buffer_0[7u].z;
				float fragment_unnamed_284;
				float fragment_unnamed_285;
				float fragment_unnamed_286;
				float fragment_unnamed_287;
				if (fragment_uniform_buffer_3[0u].x == 1.0f)
				{
					bool fragment_unnamed_194 = fragment_uniform_buffer_3[0u].y == 1.0f;
					precise float fragment_unnamed_202 = fragment_input_3.y * fragment_uniform_buffer_3[2u].x;
					precise float fragment_unnamed_203 = fragment_input_3.y * fragment_uniform_buffer_3[2u].y;
					precise float fragment_unnamed_204 = fragment_input_3.y * fragment_uniform_buffer_3[2u].z;
					precise float fragment_unnamed_231 = mad(fragment_uniform_buffer_3[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_3[1u].x, fragment_input_3.x, fragment_unnamed_202)) + fragment_uniform_buffer_3[4u].x;
					precise float fragment_unnamed_232 = mad(fragment_uniform_buffer_3[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_3[1u].y, fragment_input_3.x, fragment_unnamed_203)) + fragment_uniform_buffer_3[4u].y;
					precise float fragment_unnamed_233 = mad(fragment_uniform_buffer_3[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_3[1u].z, fragment_input_3.x, fragment_unnamed_204)) + fragment_uniform_buffer_3[4u].z;
					precise float fragment_unnamed_246 = (-0.0f) - fragment_uniform_buffer_3[6u].x;
					precise float fragment_unnamed_248 = (-0.0f) - fragment_uniform_buffer_3[6u].y;
					precise float fragment_unnamed_250 = (-0.0f) - fragment_uniform_buffer_3[6u].z;
					precise float fragment_unnamed_251 = (fragment_unnamed_194 ? fragment_unnamed_231 : fragment_input_3.x) + fragment_unnamed_246;
					precise float fragment_unnamed_252 = (fragment_unnamed_194 ? fragment_unnamed_232 : fragment_input_3.y) + fragment_unnamed_248;
					precise float fragment_unnamed_253 = (fragment_unnamed_194 ? fragment_unnamed_233 : fragment_input_3.z) + fragment_unnamed_250;
					precise float fragment_unnamed_259 = fragment_unnamed_251 * fragment_uniform_buffer_3[5u].x;
					precise float fragment_unnamed_260 = fragment_unnamed_252 * fragment_uniform_buffer_3[5u].y;
					precise float fragment_unnamed_261 = fragment_unnamed_253 * fragment_uniform_buffer_3[5u].z;
					float4 fragment_unnamed_273 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_259, 0.25f, 0.75f), mad(fragment_uniform_buffer_3[0u].z, 0.5f, 0.75f)), fragment_unnamed_260, fragment_unnamed_261));
					fragment_unnamed_284 = fragment_unnamed_273.x;
					fragment_unnamed_285 = fragment_unnamed_273.y;
					fragment_unnamed_286 = fragment_unnamed_273.z;
					fragment_unnamed_287 = fragment_unnamed_273.w;
				}
				else
				{
					fragment_unnamed_284 = asfloat(1065353216u);
					fragment_unnamed_285 = asfloat(1065353216u);
					fragment_unnamed_286 = asfloat(1065353216u);
					fragment_unnamed_287 = asfloat(1065353216u);
				}
				precise float fragment_unnamed_306 = clamp(dot(float4(fragment_unnamed_284, fragment_unnamed_285, fragment_unnamed_286, fragment_unnamed_287), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f) * _LightTexture0.Sample(sampler_LightTexture0, dot(float3(fragment_unnamed_182, fragment_unnamed_183, fragment_unnamed_184), float3(fragment_unnamed_182, fragment_unnamed_183, fragment_unnamed_184)).xx).x;
				precise float fragment_unnamed_312 = fragment_unnamed_306 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_313 = fragment_unnamed_306 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_314 = fragment_unnamed_306 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_330 = rsqrt(dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z)));
				precise float fragment_unnamed_337 = fragment_unnamed_330 * fragment_input_2.x;
				precise float fragment_unnamed_338 = fragment_unnamed_330 * fragment_input_2.y;
				precise float fragment_unnamed_339 = fragment_unnamed_330 * fragment_input_2.z;
				float fragment_unnamed_354 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_134, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_356 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_135, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_357 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_136, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_361 = (-0.0f) - fragment_uniform_buffer_0[8u].y;
				float fragment_unnamed_362 = mad(fragment_unnamed_361, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_364 = fragment_unnamed_362 * fragment_unnamed_143;
				precise float fragment_unnamed_365 = fragment_unnamed_362 * fragment_unnamed_144;
				precise float fragment_unnamed_366 = fragment_unnamed_362 * fragment_unnamed_145;
				precise float fragment_unnamed_370 = (-0.0f) - fragment_uniform_buffer_0[8u].x;
				precise float fragment_unnamed_371 = fragment_unnamed_370 + 1.0f;
				float fragment_unnamed_372 = mad(fragment_unnamed_80, fragment_unnamed_87, fragment_unnamed_113);
				float fragment_unnamed_373 = mad(fragment_unnamed_81, fragment_unnamed_87, fragment_unnamed_114);
				float fragment_unnamed_374 = mad(fragment_unnamed_82, fragment_unnamed_87, fragment_unnamed_115);
				float fragment_unnamed_380 = rsqrt(max(dot(float3(fragment_unnamed_372, fragment_unnamed_373, fragment_unnamed_374), float3(fragment_unnamed_372, fragment_unnamed_373, fragment_unnamed_374)), 0.001000000047497451305389404296875f));
				precise float fragment_unnamed_381 = fragment_unnamed_380 * fragment_unnamed_372;
				precise float fragment_unnamed_382 = fragment_unnamed_380 * fragment_unnamed_373;
				precise float fragment_unnamed_383 = fragment_unnamed_380 * fragment_unnamed_374;
				float fragment_unnamed_384 = dot(float3(fragment_unnamed_337, fragment_unnamed_338, fragment_unnamed_339), float3(fragment_unnamed_113, fragment_unnamed_114, fragment_unnamed_115));
				float fragment_unnamed_390 = clamp(dot(float3(fragment_unnamed_337, fragment_unnamed_338, fragment_unnamed_339), float3(fragment_unnamed_88, fragment_unnamed_89, fragment_unnamed_90)), 0.0f, 1.0f);
				float fragment_unnamed_394 = clamp(dot(float3(fragment_unnamed_337, fragment_unnamed_338, fragment_unnamed_339), float3(fragment_unnamed_381, fragment_unnamed_382, fragment_unnamed_383)), 0.0f, 1.0f);
				float fragment_unnamed_398 = clamp(dot(float3(fragment_unnamed_88, fragment_unnamed_89, fragment_unnamed_90), float3(fragment_unnamed_381, fragment_unnamed_382, fragment_unnamed_383)), 0.0f, 1.0f);
				precise float fragment_unnamed_399 = fragment_unnamed_398 * fragment_unnamed_398;
				precise float fragment_unnamed_403 = dot(fragment_unnamed_399.xx, fragment_unnamed_371.xx) + (-0.5f);
				precise float fragment_unnamed_405 = (-0.0f) - fragment_unnamed_390;
				precise float fragment_unnamed_406 = fragment_unnamed_405 + 1.0f;
				precise float fragment_unnamed_407 = fragment_unnamed_406 * fragment_unnamed_406;
				precise float fragment_unnamed_408 = fragment_unnamed_407 * fragment_unnamed_407;
				precise float fragment_unnamed_409 = fragment_unnamed_406 * fragment_unnamed_408;
				precise float fragment_unnamed_412 = (-0.0f) - abs(fragment_unnamed_384);
				precise float fragment_unnamed_413 = fragment_unnamed_412 + 1.0f;
				precise float fragment_unnamed_414 = fragment_unnamed_413 * fragment_unnamed_413;
				precise float fragment_unnamed_415 = fragment_unnamed_414 * fragment_unnamed_414;
				precise float fragment_unnamed_416 = fragment_unnamed_413 * fragment_unnamed_415;
				precise float fragment_unnamed_418 = mad(fragment_unnamed_403, fragment_unnamed_416, 1.0f) * mad(fragment_unnamed_403, fragment_unnamed_409, 1.0f);
				precise float fragment_unnamed_419 = fragment_unnamed_371 * fragment_unnamed_371;
				float fragment_unnamed_420 = max(fragment_unnamed_419, 0.00200000009499490261077880859375f);
				precise float fragment_unnamed_422 = (-0.0f) - fragment_unnamed_420;
				precise float fragment_unnamed_423 = fragment_unnamed_422 + 1.0f;
				precise float fragment_unnamed_428 = abs(fragment_unnamed_384) * mad(fragment_unnamed_390, fragment_unnamed_423, fragment_unnamed_420);
				precise float fragment_unnamed_430 = mad(fragment_unnamed_390, mad(abs(fragment_unnamed_384), fragment_unnamed_423, fragment_unnamed_420), fragment_unnamed_428) + 9.9999997473787516355514526367188e-06f;
				precise float fragment_unnamed_432 = 0.5f / fragment_unnamed_430;
				precise float fragment_unnamed_433 = fragment_unnamed_420 * fragment_unnamed_420;
				precise float fragment_unnamed_434 = (-0.0f) - fragment_unnamed_394;
				float fragment_unnamed_436 = mad(mad(fragment_unnamed_394, fragment_unnamed_433, fragment_unnamed_434), fragment_unnamed_394, 1.0f);
				precise float fragment_unnamed_437 = fragment_unnamed_433 * 0.3183098733425140380859375f;
				precise float fragment_unnamed_441 = fragment_unnamed_437 / mad(fragment_unnamed_436, fragment_unnamed_436, 1.0000000116860974230803549289703e-07f);
				precise float fragment_unnamed_442 = fragment_unnamed_441 * fragment_unnamed_432;
				precise float fragment_unnamed_443 = fragment_unnamed_442 * 3.1415927410125732421875f;
				precise float fragment_unnamed_448 = fragment_unnamed_390 * fragment_unnamed_418;
				precise float fragment_unnamed_449 = fragment_unnamed_390 * sqrt(max(fragment_unnamed_443, 9.9999997473787516355514526367188e-05f));
				precise float fragment_unnamed_458 = asfloat(((dot(float3(fragment_unnamed_354, fragment_unnamed_356, fragment_unnamed_357), float3(fragment_unnamed_354, fragment_unnamed_356, fragment_unnamed_357)) != 0.0f) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_449;
				precise float fragment_unnamed_459 = fragment_unnamed_448 * fragment_unnamed_312;
				precise float fragment_unnamed_460 = fragment_unnamed_448 * fragment_unnamed_313;
				precise float fragment_unnamed_461 = fragment_unnamed_448 * fragment_unnamed_314;
				precise float fragment_unnamed_462 = fragment_unnamed_312 * fragment_unnamed_458;
				precise float fragment_unnamed_463 = fragment_unnamed_313 * fragment_unnamed_458;
				precise float fragment_unnamed_464 = fragment_unnamed_314 * fragment_unnamed_458;
				precise float fragment_unnamed_465 = (-0.0f) - fragment_unnamed_398;
				precise float fragment_unnamed_466 = fragment_unnamed_465 + 1.0f;
				precise float fragment_unnamed_467 = fragment_unnamed_466 * fragment_unnamed_466;
				precise float fragment_unnamed_468 = fragment_unnamed_467 * fragment_unnamed_467;
				precise float fragment_unnamed_469 = fragment_unnamed_466 * fragment_unnamed_468;
				precise float fragment_unnamed_470 = (-0.0f) - fragment_unnamed_354;
				precise float fragment_unnamed_471 = (-0.0f) - fragment_unnamed_356;
				precise float fragment_unnamed_472 = (-0.0f) - fragment_unnamed_357;
				precise float fragment_unnamed_473 = fragment_unnamed_470 + 1.0f;
				precise float fragment_unnamed_474 = fragment_unnamed_471 + 1.0f;
				precise float fragment_unnamed_475 = fragment_unnamed_472 + 1.0f;
				precise float fragment_unnamed_479 = fragment_unnamed_462 * mad(fragment_unnamed_473, fragment_unnamed_469, fragment_unnamed_354);
				precise float fragment_unnamed_480 = fragment_unnamed_463 * mad(fragment_unnamed_474, fragment_unnamed_469, fragment_unnamed_356);
				precise float fragment_unnamed_481 = fragment_unnamed_464 * mad(fragment_unnamed_475, fragment_unnamed_469, fragment_unnamed_357);
				fragment_output_0.x = mad(fragment_unnamed_364, fragment_unnamed_459, fragment_unnamed_479);
				fragment_output_0.y = mad(fragment_unnamed_365, fragment_unnamed_460, fragment_unnamed_480);
				fragment_output_0.z = mad(fragment_unnamed_366, fragment_unnamed_461, fragment_unnamed_481);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				fragment_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				fragment_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				fragment_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_uniform_buffer_0[8] = float4(_Glossiness, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _Metallic, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[9] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

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
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(POINT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_SCREEN) && !defined(SHADOWS_CUBE)


			#if defined(DIRECTIONAL) && !defined(POINT) && !defined(SPOT) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_SCREEN) && !defined(SHADOWS_CUBE)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _MainTex_ST;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float4 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_55 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_56 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				float vertex_unnamed_81 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_55));
				float vertex_unnamed_82 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_56));
				float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_57));
				precise float vertex_unnamed_92 = vertex_unnamed_81 + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_93 = vertex_unnamed_82 + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_94 = vertex_unnamed_83 + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_95 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_58)) + vertex_uniform_buffer_1[3u].w;
				vertex_output_3.x = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_81);
				vertex_output_3.y = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_82);
				vertex_output_3.z = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_83);
				precise float vertex_unnamed_117 = vertex_unnamed_93 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_118 = vertex_unnamed_93 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_119 = vertex_unnamed_93 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_120 = vertex_unnamed_93 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_95, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_92, vertex_unnamed_117)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_95, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_92, vertex_unnamed_118)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_95, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_92, vertex_unnamed_119)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_95, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_92, vertex_unnamed_120)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[6u].x, vertex_uniform_buffer_0[6u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[6u].y, vertex_uniform_buffer_0[6u].w);
				float vertex_unnamed_187 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_202 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_216 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_222 = rsqrt(dot(float3(vertex_unnamed_187, vertex_unnamed_202, vertex_unnamed_216), float3(vertex_unnamed_187, vertex_unnamed_202, vertex_unnamed_216)));
				precise float vertex_unnamed_223 = vertex_unnamed_222 * vertex_unnamed_187;
				precise float vertex_unnamed_224 = vertex_unnamed_222 * vertex_unnamed_202;
				precise float vertex_unnamed_225 = vertex_unnamed_222 * vertex_unnamed_216;
				vertex_output_2.x = vertex_unnamed_223;
				vertex_output_2.y = vertex_unnamed_224;
				vertex_output_2.z = vertex_unnamed_225;
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				vertex_output_5.x = 0.0f;
				vertex_output_5.y = 0.0f;
				vertex_output_5.z = 0.0f;
				vertex_output_5.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_2[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_2[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_2[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				return stage_output;
			}


			float4 _LightColor0;
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_OcclusionMaskSelector;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[6];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[7];
			Texture2D<float4> _MainTex;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float4 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_59 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_64 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_68 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_76 = fragment_unnamed_59 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_77 = fragment_unnamed_64 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_78 = fragment_unnamed_68 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_83 = rsqrt(dot(float3(fragment_unnamed_76, fragment_unnamed_77, fragment_unnamed_78), float3(fragment_unnamed_76, fragment_unnamed_77, fragment_unnamed_78)));
				precise float fragment_unnamed_84 = fragment_unnamed_83 * fragment_unnamed_76;
				precise float fragment_unnamed_85 = fragment_unnamed_83 * fragment_unnamed_77;
				precise float fragment_unnamed_86 = fragment_unnamed_83 * fragment_unnamed_78;
				float4 fragment_unnamed_94 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_104 = fragment_unnamed_94.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_105 = fragment_unnamed_94.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_106 = fragment_unnamed_94.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_113 = fragment_unnamed_104 * fragment_input_4.x;
				precise float fragment_unnamed_114 = fragment_unnamed_105 * fragment_input_4.y;
				precise float fragment_unnamed_115 = fragment_unnamed_106 * fragment_input_4.z;
				float fragment_unnamed_215;
				float fragment_unnamed_216;
				float fragment_unnamed_217;
				float fragment_unnamed_218;
				if (fragment_uniform_buffer_3[0u].x == 1.0f)
				{
					bool fragment_unnamed_125 = fragment_uniform_buffer_3[0u].y == 1.0f;
					precise float fragment_unnamed_133 = fragment_input_3.y * fragment_uniform_buffer_3[2u].x;
					precise float fragment_unnamed_134 = fragment_input_3.y * fragment_uniform_buffer_3[2u].y;
					precise float fragment_unnamed_135 = fragment_input_3.y * fragment_uniform_buffer_3[2u].z;
					precise float fragment_unnamed_162 = mad(fragment_uniform_buffer_3[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_3[1u].x, fragment_input_3.x, fragment_unnamed_133)) + fragment_uniform_buffer_3[4u].x;
					precise float fragment_unnamed_163 = mad(fragment_uniform_buffer_3[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_3[1u].y, fragment_input_3.x, fragment_unnamed_134)) + fragment_uniform_buffer_3[4u].y;
					precise float fragment_unnamed_164 = mad(fragment_uniform_buffer_3[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_3[1u].z, fragment_input_3.x, fragment_unnamed_135)) + fragment_uniform_buffer_3[4u].z;
					precise float fragment_unnamed_177 = (-0.0f) - fragment_uniform_buffer_3[6u].x;
					precise float fragment_unnamed_179 = (-0.0f) - fragment_uniform_buffer_3[6u].y;
					precise float fragment_unnamed_181 = (-0.0f) - fragment_uniform_buffer_3[6u].z;
					precise float fragment_unnamed_182 = (fragment_unnamed_125 ? fragment_unnamed_162 : fragment_input_3.x) + fragment_unnamed_177;
					precise float fragment_unnamed_183 = (fragment_unnamed_125 ? fragment_unnamed_163 : fragment_input_3.y) + fragment_unnamed_179;
					precise float fragment_unnamed_184 = (fragment_unnamed_125 ? fragment_unnamed_164 : fragment_input_3.z) + fragment_unnamed_181;
					precise float fragment_unnamed_190 = fragment_unnamed_182 * fragment_uniform_buffer_3[5u].x;
					precise float fragment_unnamed_191 = fragment_unnamed_183 * fragment_uniform_buffer_3[5u].y;
					precise float fragment_unnamed_192 = fragment_unnamed_184 * fragment_uniform_buffer_3[5u].z;
					float4 fragment_unnamed_204 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_190, 0.25f, 0.75f), mad(fragment_uniform_buffer_3[0u].z, 0.5f, 0.75f)), fragment_unnamed_191, fragment_unnamed_192));
					fragment_unnamed_215 = fragment_unnamed_204.x;
					fragment_unnamed_216 = fragment_unnamed_204.y;
					fragment_unnamed_217 = fragment_unnamed_204.z;
					fragment_unnamed_218 = fragment_unnamed_204.w;
				}
				else
				{
					fragment_unnamed_215 = asfloat(1065353216u);
					fragment_unnamed_216 = asfloat(1065353216u);
					fragment_unnamed_217 = asfloat(1065353216u);
					fragment_unnamed_218 = asfloat(1065353216u);
				}
				float fragment_unnamed_229 = clamp(dot(float4(fragment_unnamed_215, fragment_unnamed_216, fragment_unnamed_217, fragment_unnamed_218), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f);
				precise float fragment_unnamed_235 = fragment_unnamed_229 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_236 = fragment_unnamed_229 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_237 = fragment_unnamed_229 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_253 = rsqrt(dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z)));
				precise float fragment_unnamed_260 = fragment_unnamed_253 * fragment_input_2.x;
				precise float fragment_unnamed_261 = fragment_unnamed_253 * fragment_input_2.y;
				precise float fragment_unnamed_262 = fragment_unnamed_253 * fragment_input_2.z;
				float fragment_unnamed_276 = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_104, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_278 = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_105, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_279 = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_106, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_283 = (-0.0f) - fragment_uniform_buffer_0[4u].y;
				float fragment_unnamed_284 = mad(fragment_unnamed_283, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_286 = fragment_unnamed_284 * fragment_unnamed_113;
				precise float fragment_unnamed_287 = fragment_unnamed_284 * fragment_unnamed_114;
				precise float fragment_unnamed_288 = fragment_unnamed_284 * fragment_unnamed_115;
				precise float fragment_unnamed_292 = (-0.0f) - fragment_uniform_buffer_0[4u].x;
				precise float fragment_unnamed_293 = fragment_unnamed_292 + 1.0f;
				float fragment_unnamed_299 = mad(fragment_unnamed_76, fragment_unnamed_83, fragment_uniform_buffer_2[0u].x);
				float fragment_unnamed_300 = mad(fragment_unnamed_77, fragment_unnamed_83, fragment_uniform_buffer_2[0u].y);
				float fragment_unnamed_301 = mad(fragment_unnamed_78, fragment_unnamed_83, fragment_uniform_buffer_2[0u].z);
				float fragment_unnamed_307 = rsqrt(max(dot(float3(fragment_unnamed_299, fragment_unnamed_300, fragment_unnamed_301), float3(fragment_unnamed_299, fragment_unnamed_300, fragment_unnamed_301)), 0.001000000047497451305389404296875f));
				precise float fragment_unnamed_308 = fragment_unnamed_307 * fragment_unnamed_299;
				precise float fragment_unnamed_309 = fragment_unnamed_307 * fragment_unnamed_300;
				precise float fragment_unnamed_310 = fragment_unnamed_307 * fragment_unnamed_301;
				float fragment_unnamed_311 = dot(float3(fragment_unnamed_260, fragment_unnamed_261, fragment_unnamed_262), float3(fragment_unnamed_84, fragment_unnamed_85, fragment_unnamed_86));
				float fragment_unnamed_322 = clamp(dot(float3(fragment_unnamed_260, fragment_unnamed_261, fragment_unnamed_262), float3(fragment_uniform_buffer_2[0u].xyz)), 0.0f, 1.0f);
				float fragment_unnamed_326 = clamp(dot(float3(fragment_unnamed_260, fragment_unnamed_261, fragment_unnamed_262), float3(fragment_unnamed_308, fragment_unnamed_309, fragment_unnamed_310)), 0.0f, 1.0f);
				float fragment_unnamed_335 = clamp(dot(float3(fragment_uniform_buffer_2[0u].xyz), float3(fragment_unnamed_308, fragment_unnamed_309, fragment_unnamed_310)), 0.0f, 1.0f);
				precise float fragment_unnamed_336 = fragment_unnamed_335 * fragment_unnamed_335;
				precise float fragment_unnamed_340 = dot(fragment_unnamed_336.xx, fragment_unnamed_293.xx) + (-0.5f);
				precise float fragment_unnamed_342 = (-0.0f) - fragment_unnamed_322;
				precise float fragment_unnamed_343 = fragment_unnamed_342 + 1.0f;
				precise float fragment_unnamed_344 = fragment_unnamed_343 * fragment_unnamed_343;
				precise float fragment_unnamed_345 = fragment_unnamed_344 * fragment_unnamed_344;
				precise float fragment_unnamed_346 = fragment_unnamed_343 * fragment_unnamed_345;
				precise float fragment_unnamed_349 = (-0.0f) - abs(fragment_unnamed_311);
				precise float fragment_unnamed_350 = fragment_unnamed_349 + 1.0f;
				precise float fragment_unnamed_351 = fragment_unnamed_350 * fragment_unnamed_350;
				precise float fragment_unnamed_352 = fragment_unnamed_351 * fragment_unnamed_351;
				precise float fragment_unnamed_353 = fragment_unnamed_350 * fragment_unnamed_352;
				precise float fragment_unnamed_355 = mad(fragment_unnamed_340, fragment_unnamed_353, 1.0f) * mad(fragment_unnamed_340, fragment_unnamed_346, 1.0f);
				precise float fragment_unnamed_356 = fragment_unnamed_293 * fragment_unnamed_293;
				float fragment_unnamed_357 = max(fragment_unnamed_356, 0.00200000009499490261077880859375f);
				precise float fragment_unnamed_359 = (-0.0f) - fragment_unnamed_357;
				precise float fragment_unnamed_360 = fragment_unnamed_359 + 1.0f;
				precise float fragment_unnamed_365 = abs(fragment_unnamed_311) * mad(fragment_unnamed_322, fragment_unnamed_360, fragment_unnamed_357);
				precise float fragment_unnamed_367 = mad(fragment_unnamed_322, mad(abs(fragment_unnamed_311), fragment_unnamed_360, fragment_unnamed_357), fragment_unnamed_365) + 9.9999997473787516355514526367188e-06f;
				precise float fragment_unnamed_369 = 0.5f / fragment_unnamed_367;
				precise float fragment_unnamed_370 = fragment_unnamed_357 * fragment_unnamed_357;
				precise float fragment_unnamed_371 = (-0.0f) - fragment_unnamed_326;
				float fragment_unnamed_373 = mad(mad(fragment_unnamed_326, fragment_unnamed_370, fragment_unnamed_371), fragment_unnamed_326, 1.0f);
				precise float fragment_unnamed_374 = fragment_unnamed_370 * 0.3183098733425140380859375f;
				precise float fragment_unnamed_378 = fragment_unnamed_374 / mad(fragment_unnamed_373, fragment_unnamed_373, 1.0000000116860974230803549289703e-07f);
				precise float fragment_unnamed_379 = fragment_unnamed_378 * fragment_unnamed_369;
				precise float fragment_unnamed_380 = fragment_unnamed_379 * 3.1415927410125732421875f;
				precise float fragment_unnamed_385 = fragment_unnamed_322 * fragment_unnamed_355;
				precise float fragment_unnamed_386 = fragment_unnamed_322 * sqrt(max(fragment_unnamed_380, 9.9999997473787516355514526367188e-05f));
				precise float fragment_unnamed_395 = asfloat(((dot(float3(fragment_unnamed_276, fragment_unnamed_278, fragment_unnamed_279), float3(fragment_unnamed_276, fragment_unnamed_278, fragment_unnamed_279)) != 0.0f) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_386;
				precise float fragment_unnamed_396 = fragment_unnamed_385 * fragment_unnamed_235;
				precise float fragment_unnamed_397 = fragment_unnamed_385 * fragment_unnamed_236;
				precise float fragment_unnamed_398 = fragment_unnamed_385 * fragment_unnamed_237;
				precise float fragment_unnamed_399 = fragment_unnamed_235 * fragment_unnamed_395;
				precise float fragment_unnamed_400 = fragment_unnamed_236 * fragment_unnamed_395;
				precise float fragment_unnamed_401 = fragment_unnamed_237 * fragment_unnamed_395;
				precise float fragment_unnamed_402 = (-0.0f) - fragment_unnamed_335;
				precise float fragment_unnamed_403 = fragment_unnamed_402 + 1.0f;
				precise float fragment_unnamed_404 = fragment_unnamed_403 * fragment_unnamed_403;
				precise float fragment_unnamed_405 = fragment_unnamed_404 * fragment_unnamed_404;
				precise float fragment_unnamed_406 = fragment_unnamed_403 * fragment_unnamed_405;
				precise float fragment_unnamed_407 = (-0.0f) - fragment_unnamed_276;
				precise float fragment_unnamed_408 = (-0.0f) - fragment_unnamed_278;
				precise float fragment_unnamed_409 = (-0.0f) - fragment_unnamed_279;
				precise float fragment_unnamed_410 = fragment_unnamed_407 + 1.0f;
				precise float fragment_unnamed_411 = fragment_unnamed_408 + 1.0f;
				precise float fragment_unnamed_412 = fragment_unnamed_409 + 1.0f;
				precise float fragment_unnamed_416 = fragment_unnamed_399 * mad(fragment_unnamed_410, fragment_unnamed_406, fragment_unnamed_276);
				precise float fragment_unnamed_417 = fragment_unnamed_400 * mad(fragment_unnamed_411, fragment_unnamed_406, fragment_unnamed_278);
				precise float fragment_unnamed_418 = fragment_unnamed_401 * mad(fragment_unnamed_412, fragment_unnamed_406, fragment_unnamed_279);
				fragment_output_0.x = mad(fragment_unnamed_286, fragment_unnamed_396, fragment_unnamed_416);
				fragment_output_0.y = mad(fragment_unnamed_287, fragment_unnamed_397, fragment_unnamed_417);
				fragment_output_0.z = mad(fragment_unnamed_288, fragment_unnamed_398, fragment_unnamed_418);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[4] = float4(_Glossiness, fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _Metallic, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[5] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

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
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(DIRECTIONAL) && !defined(POINT) && !defined(SPOT) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_SCREEN) && !defined(SHADOWS_CUBE)


			#if defined(SPOT) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_SCREEN) && !defined(SHADOWS_CUBE)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToLight;
			float4 _MainTex_ST;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[11];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float4 vertex_output_5 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_6 : TEXCOORD4; // TEXCOORD_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_59 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_60 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_57));
				float vertex_unnamed_84 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_58));
				float vertex_unnamed_85 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_59));
				float vertex_unnamed_86 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_60));
				precise float vertex_unnamed_94 = vertex_unnamed_83 + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_95 = vertex_unnamed_84 + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_96 = vertex_unnamed_85 + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_97 = vertex_unnamed_86 + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_105 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_106 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_107 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_108 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_94, vertex_unnamed_105)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_94, vertex_unnamed_106)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_94, vertex_unnamed_107)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_94, vertex_unnamed_108)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[10u].x, vertex_uniform_buffer_0[10u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[10u].y, vertex_uniform_buffer_0[10u].w);
				float vertex_unnamed_176 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_191 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_206 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_212 = rsqrt(dot(float3(vertex_unnamed_176, vertex_unnamed_191, vertex_unnamed_206), float3(vertex_unnamed_176, vertex_unnamed_191, vertex_unnamed_206)));
				precise float vertex_unnamed_213 = vertex_unnamed_212 * vertex_unnamed_176;
				precise float vertex_unnamed_214 = vertex_unnamed_212 * vertex_unnamed_191;
				precise float vertex_unnamed_215 = vertex_unnamed_212 * vertex_unnamed_206;
				vertex_output_2.x = vertex_unnamed_213;
				vertex_output_2.y = vertex_unnamed_214;
				vertex_output_2.z = vertex_unnamed_215;
				vertex_output_3.x = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				vertex_output_3.y = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				vertex_output_3.z = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				float vertex_unnamed_240 = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				float vertex_unnamed_241 = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				float vertex_unnamed_242 = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				float vertex_unnamed_243 = mad(vertex_uniform_buffer_1[3u].w, vertex_input_0.w, vertex_unnamed_86);
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				precise float vertex_unnamed_262 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_263 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].y;
				precise float vertex_unnamed_264 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].z;
				precise float vertex_unnamed_265 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].w;
				vertex_output_5.x = mad(vertex_uniform_buffer_0[7u].x, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].x, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].x, vertex_unnamed_240, vertex_unnamed_262)));
				vertex_output_5.y = mad(vertex_uniform_buffer_0[7u].y, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].y, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].y, vertex_unnamed_240, vertex_unnamed_263)));
				vertex_output_5.z = mad(vertex_uniform_buffer_0[7u].z, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].z, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].z, vertex_unnamed_240, vertex_unnamed_264)));
				vertex_output_5.w = mad(vertex_uniform_buffer_0[7u].w, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].w, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].w, vertex_unnamed_240, vertex_unnamed_265)));
				vertex_output_6.x = 0.0f;
				vertex_output_6.y = 0.0f;
				vertex_output_6.z = 0.0f;
				vertex_output_6.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				vertex_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				vertex_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				vertex_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				vertex_uniform_buffer_0[10] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_2[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_2[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_2[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}


			float4 _LightColor0;
			float4x4 unity_WorldToLight;
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_OcclusionMaskSelector;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[10];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _LightTexture0;
			Texture2D<float4> _LightTextureB0;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_LightTexture0;
			SamplerState sampler_LightTextureB0;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float4 fragment_input_5 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_6 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_68 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_73 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_77 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_84 = fragment_unnamed_68 + fragment_uniform_buffer_2[0u].x;
				precise float fragment_unnamed_85 = fragment_unnamed_73 + fragment_uniform_buffer_2[0u].y;
				precise float fragment_unnamed_86 = fragment_unnamed_77 + fragment_uniform_buffer_2[0u].z;
				float fragment_unnamed_91 = rsqrt(dot(float3(fragment_unnamed_84, fragment_unnamed_85, fragment_unnamed_86), float3(fragment_unnamed_84, fragment_unnamed_85, fragment_unnamed_86)));
				precise float fragment_unnamed_92 = fragment_unnamed_91 * fragment_unnamed_84;
				precise float fragment_unnamed_93 = fragment_unnamed_91 * fragment_unnamed_85;
				precise float fragment_unnamed_94 = fragment_unnamed_91 * fragment_unnamed_86;
				precise float fragment_unnamed_97 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_100 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_103 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_110 = fragment_unnamed_97 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_111 = fragment_unnamed_100 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_112 = fragment_unnamed_103 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_116 = rsqrt(dot(float3(fragment_unnamed_110, fragment_unnamed_111, fragment_unnamed_112), float3(fragment_unnamed_110, fragment_unnamed_111, fragment_unnamed_112)));
				precise float fragment_unnamed_117 = fragment_unnamed_116 * fragment_unnamed_110;
				precise float fragment_unnamed_118 = fragment_unnamed_116 * fragment_unnamed_111;
				precise float fragment_unnamed_119 = fragment_unnamed_116 * fragment_unnamed_112;
				float4 fragment_unnamed_127 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_138 = fragment_unnamed_127.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_139 = fragment_unnamed_127.y * fragment_uniform_buffer_0[9u].y;
				precise float fragment_unnamed_140 = fragment_unnamed_127.z * fragment_uniform_buffer_0[9u].z;
				precise float fragment_unnamed_147 = fragment_unnamed_138 * fragment_input_4.x;
				precise float fragment_unnamed_148 = fragment_unnamed_139 * fragment_input_4.y;
				precise float fragment_unnamed_149 = fragment_unnamed_140 * fragment_input_4.z;
				precise float fragment_unnamed_158 = fragment_input_3.y * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_159 = fragment_input_3.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_160 = fragment_input_3.y * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_161 = fragment_input_3.y * fragment_uniform_buffer_0[5u].w;
				precise float fragment_unnamed_193 = mad(fragment_uniform_buffer_0[6u].x, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].x, fragment_input_3.x, fragment_unnamed_158)) + fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_194 = mad(fragment_uniform_buffer_0[6u].y, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].y, fragment_input_3.x, fragment_unnamed_159)) + fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_195 = mad(fragment_uniform_buffer_0[6u].z, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].z, fragment_input_3.x, fragment_unnamed_160)) + fragment_uniform_buffer_0[7u].z;
				precise float fragment_unnamed_196 = mad(fragment_uniform_buffer_0[6u].w, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].w, fragment_input_3.x, fragment_unnamed_161)) + fragment_uniform_buffer_0[7u].w;
				float fragment_unnamed_296;
				float fragment_unnamed_297;
				float fragment_unnamed_298;
				float fragment_unnamed_299;
				if (fragment_uniform_buffer_3[0u].x == 1.0f)
				{
					bool fragment_unnamed_206 = fragment_uniform_buffer_3[0u].y == 1.0f;
					precise float fragment_unnamed_214 = fragment_input_3.y * fragment_uniform_buffer_3[2u].x;
					precise float fragment_unnamed_215 = fragment_input_3.y * fragment_uniform_buffer_3[2u].y;
					precise float fragment_unnamed_216 = fragment_input_3.y * fragment_uniform_buffer_3[2u].z;
					precise float fragment_unnamed_243 = mad(fragment_uniform_buffer_3[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_3[1u].x, fragment_input_3.x, fragment_unnamed_214)) + fragment_uniform_buffer_3[4u].x;
					precise float fragment_unnamed_244 = mad(fragment_uniform_buffer_3[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_3[1u].y, fragment_input_3.x, fragment_unnamed_215)) + fragment_uniform_buffer_3[4u].y;
					precise float fragment_unnamed_245 = mad(fragment_uniform_buffer_3[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_3[1u].z, fragment_input_3.x, fragment_unnamed_216)) + fragment_uniform_buffer_3[4u].z;
					precise float fragment_unnamed_258 = (-0.0f) - fragment_uniform_buffer_3[6u].x;
					precise float fragment_unnamed_260 = (-0.0f) - fragment_uniform_buffer_3[6u].y;
					precise float fragment_unnamed_262 = (-0.0f) - fragment_uniform_buffer_3[6u].z;
					precise float fragment_unnamed_263 = (fragment_unnamed_206 ? fragment_unnamed_243 : fragment_input_3.x) + fragment_unnamed_258;
					precise float fragment_unnamed_264 = (fragment_unnamed_206 ? fragment_unnamed_244 : fragment_input_3.y) + fragment_unnamed_260;
					precise float fragment_unnamed_265 = (fragment_unnamed_206 ? fragment_unnamed_245 : fragment_input_3.z) + fragment_unnamed_262;
					precise float fragment_unnamed_271 = fragment_unnamed_263 * fragment_uniform_buffer_3[5u].x;
					precise float fragment_unnamed_272 = fragment_unnamed_264 * fragment_uniform_buffer_3[5u].y;
					precise float fragment_unnamed_273 = fragment_unnamed_265 * fragment_uniform_buffer_3[5u].z;
					float4 fragment_unnamed_285 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_271, 0.25f, 0.75f), mad(fragment_uniform_buffer_3[0u].z, 0.5f, 0.75f)), fragment_unnamed_272, fragment_unnamed_273));
					fragment_unnamed_296 = fragment_unnamed_285.x;
					fragment_unnamed_297 = fragment_unnamed_285.y;
					fragment_unnamed_298 = fragment_unnamed_285.z;
					fragment_unnamed_299 = fragment_unnamed_285.w;
				}
				else
				{
					fragment_unnamed_296 = asfloat(1065353216u);
					fragment_unnamed_297 = asfloat(1065353216u);
					fragment_unnamed_298 = asfloat(1065353216u);
					fragment_unnamed_299 = asfloat(1065353216u);
				}
				precise float fragment_unnamed_316 = fragment_unnamed_193 / fragment_unnamed_196;
				precise float fragment_unnamed_317 = fragment_unnamed_194 / fragment_unnamed_196;
				precise float fragment_unnamed_318 = fragment_unnamed_316 + 0.5f;
				precise float fragment_unnamed_319 = fragment_unnamed_317 + 0.5f;
				precise float fragment_unnamed_324 = asfloat(((0.0f < fragment_unnamed_195) ? 4294967295u : 0u) & 1065353216u) * _LightTexture0.Sample(sampler_LightTexture0, float2(fragment_unnamed_318, fragment_unnamed_319)).w;
				precise float fragment_unnamed_332 = fragment_unnamed_324 * _LightTextureB0.Sample(sampler_LightTextureB0, dot(float3(fragment_unnamed_193, fragment_unnamed_194, fragment_unnamed_195), float3(fragment_unnamed_193, fragment_unnamed_194, fragment_unnamed_195)).xx).x;
				precise float fragment_unnamed_333 = clamp(dot(float4(fragment_unnamed_296, fragment_unnamed_297, fragment_unnamed_298, fragment_unnamed_299), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f) * fragment_unnamed_332;
				precise float fragment_unnamed_339 = fragment_unnamed_333 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_340 = fragment_unnamed_333 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_341 = fragment_unnamed_333 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_357 = rsqrt(dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z)));
				precise float fragment_unnamed_364 = fragment_unnamed_357 * fragment_input_2.x;
				precise float fragment_unnamed_365 = fragment_unnamed_357 * fragment_input_2.y;
				precise float fragment_unnamed_366 = fragment_unnamed_357 * fragment_input_2.z;
				float fragment_unnamed_381 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_138, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_383 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_139, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_384 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_140, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_388 = (-0.0f) - fragment_uniform_buffer_0[8u].y;
				float fragment_unnamed_389 = mad(fragment_unnamed_388, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_391 = fragment_unnamed_389 * fragment_unnamed_147;
				precise float fragment_unnamed_392 = fragment_unnamed_389 * fragment_unnamed_148;
				precise float fragment_unnamed_393 = fragment_unnamed_389 * fragment_unnamed_149;
				precise float fragment_unnamed_397 = (-0.0f) - fragment_uniform_buffer_0[8u].x;
				precise float fragment_unnamed_398 = fragment_unnamed_397 + 1.0f;
				float fragment_unnamed_399 = mad(fragment_unnamed_84, fragment_unnamed_91, fragment_unnamed_117);
				float fragment_unnamed_400 = mad(fragment_unnamed_85, fragment_unnamed_91, fragment_unnamed_118);
				float fragment_unnamed_401 = mad(fragment_unnamed_86, fragment_unnamed_91, fragment_unnamed_119);
				float fragment_unnamed_407 = rsqrt(max(dot(float3(fragment_unnamed_399, fragment_unnamed_400, fragment_unnamed_401), float3(fragment_unnamed_399, fragment_unnamed_400, fragment_unnamed_401)), 0.001000000047497451305389404296875f));
				precise float fragment_unnamed_408 = fragment_unnamed_407 * fragment_unnamed_399;
				precise float fragment_unnamed_409 = fragment_unnamed_407 * fragment_unnamed_400;
				precise float fragment_unnamed_410 = fragment_unnamed_407 * fragment_unnamed_401;
				float fragment_unnamed_411 = dot(float3(fragment_unnamed_364, fragment_unnamed_365, fragment_unnamed_366), float3(fragment_unnamed_117, fragment_unnamed_118, fragment_unnamed_119));
				float fragment_unnamed_417 = clamp(dot(float3(fragment_unnamed_364, fragment_unnamed_365, fragment_unnamed_366), float3(fragment_unnamed_92, fragment_unnamed_93, fragment_unnamed_94)), 0.0f, 1.0f);
				float fragment_unnamed_421 = clamp(dot(float3(fragment_unnamed_364, fragment_unnamed_365, fragment_unnamed_366), float3(fragment_unnamed_408, fragment_unnamed_409, fragment_unnamed_410)), 0.0f, 1.0f);
				float fragment_unnamed_425 = clamp(dot(float3(fragment_unnamed_92, fragment_unnamed_93, fragment_unnamed_94), float3(fragment_unnamed_408, fragment_unnamed_409, fragment_unnamed_410)), 0.0f, 1.0f);
				precise float fragment_unnamed_426 = fragment_unnamed_425 * fragment_unnamed_425;
				precise float fragment_unnamed_430 = dot(fragment_unnamed_426.xx, fragment_unnamed_398.xx) + (-0.5f);
				precise float fragment_unnamed_432 = (-0.0f) - fragment_unnamed_417;
				precise float fragment_unnamed_433 = fragment_unnamed_432 + 1.0f;
				precise float fragment_unnamed_434 = fragment_unnamed_433 * fragment_unnamed_433;
				precise float fragment_unnamed_435 = fragment_unnamed_434 * fragment_unnamed_434;
				precise float fragment_unnamed_436 = fragment_unnamed_433 * fragment_unnamed_435;
				precise float fragment_unnamed_439 = (-0.0f) - abs(fragment_unnamed_411);
				precise float fragment_unnamed_440 = fragment_unnamed_439 + 1.0f;
				precise float fragment_unnamed_441 = fragment_unnamed_440 * fragment_unnamed_440;
				precise float fragment_unnamed_442 = fragment_unnamed_441 * fragment_unnamed_441;
				precise float fragment_unnamed_443 = fragment_unnamed_440 * fragment_unnamed_442;
				precise float fragment_unnamed_445 = mad(fragment_unnamed_430, fragment_unnamed_443, 1.0f) * mad(fragment_unnamed_430, fragment_unnamed_436, 1.0f);
				precise float fragment_unnamed_446 = fragment_unnamed_398 * fragment_unnamed_398;
				float fragment_unnamed_447 = max(fragment_unnamed_446, 0.00200000009499490261077880859375f);
				precise float fragment_unnamed_449 = (-0.0f) - fragment_unnamed_447;
				precise float fragment_unnamed_450 = fragment_unnamed_449 + 1.0f;
				precise float fragment_unnamed_455 = abs(fragment_unnamed_411) * mad(fragment_unnamed_417, fragment_unnamed_450, fragment_unnamed_447);
				precise float fragment_unnamed_457 = mad(fragment_unnamed_417, mad(abs(fragment_unnamed_411), fragment_unnamed_450, fragment_unnamed_447), fragment_unnamed_455) + 9.9999997473787516355514526367188e-06f;
				precise float fragment_unnamed_459 = 0.5f / fragment_unnamed_457;
				precise float fragment_unnamed_460 = fragment_unnamed_447 * fragment_unnamed_447;
				precise float fragment_unnamed_461 = (-0.0f) - fragment_unnamed_421;
				float fragment_unnamed_463 = mad(mad(fragment_unnamed_421, fragment_unnamed_460, fragment_unnamed_461), fragment_unnamed_421, 1.0f);
				precise float fragment_unnamed_464 = fragment_unnamed_460 * 0.3183098733425140380859375f;
				precise float fragment_unnamed_468 = fragment_unnamed_464 / mad(fragment_unnamed_463, fragment_unnamed_463, 1.0000000116860974230803549289703e-07f);
				precise float fragment_unnamed_469 = fragment_unnamed_468 * fragment_unnamed_459;
				precise float fragment_unnamed_470 = fragment_unnamed_469 * 3.1415927410125732421875f;
				precise float fragment_unnamed_475 = fragment_unnamed_417 * fragment_unnamed_445;
				precise float fragment_unnamed_476 = fragment_unnamed_417 * sqrt(max(fragment_unnamed_470, 9.9999997473787516355514526367188e-05f));
				precise float fragment_unnamed_484 = asfloat(((dot(float3(fragment_unnamed_381, fragment_unnamed_383, fragment_unnamed_384), float3(fragment_unnamed_381, fragment_unnamed_383, fragment_unnamed_384)) != 0.0f) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_476;
				precise float fragment_unnamed_485 = fragment_unnamed_475 * fragment_unnamed_339;
				precise float fragment_unnamed_486 = fragment_unnamed_475 * fragment_unnamed_340;
				precise float fragment_unnamed_487 = fragment_unnamed_475 * fragment_unnamed_341;
				precise float fragment_unnamed_488 = fragment_unnamed_339 * fragment_unnamed_484;
				precise float fragment_unnamed_489 = fragment_unnamed_340 * fragment_unnamed_484;
				precise float fragment_unnamed_490 = fragment_unnamed_341 * fragment_unnamed_484;
				precise float fragment_unnamed_491 = (-0.0f) - fragment_unnamed_425;
				precise float fragment_unnamed_492 = fragment_unnamed_491 + 1.0f;
				precise float fragment_unnamed_493 = fragment_unnamed_492 * fragment_unnamed_492;
				precise float fragment_unnamed_494 = fragment_unnamed_493 * fragment_unnamed_493;
				precise float fragment_unnamed_495 = fragment_unnamed_492 * fragment_unnamed_494;
				precise float fragment_unnamed_496 = (-0.0f) - fragment_unnamed_381;
				precise float fragment_unnamed_497 = (-0.0f) - fragment_unnamed_383;
				precise float fragment_unnamed_498 = (-0.0f) - fragment_unnamed_384;
				precise float fragment_unnamed_499 = fragment_unnamed_496 + 1.0f;
				precise float fragment_unnamed_500 = fragment_unnamed_497 + 1.0f;
				precise float fragment_unnamed_501 = fragment_unnamed_498 + 1.0f;
				precise float fragment_unnamed_505 = fragment_unnamed_488 * mad(fragment_unnamed_499, fragment_unnamed_495, fragment_unnamed_381);
				precise float fragment_unnamed_506 = fragment_unnamed_489 * mad(fragment_unnamed_500, fragment_unnamed_495, fragment_unnamed_383);
				precise float fragment_unnamed_507 = fragment_unnamed_490 * mad(fragment_unnamed_501, fragment_unnamed_495, fragment_unnamed_384);
				fragment_output_0.x = mad(fragment_unnamed_391, fragment_unnamed_485, fragment_unnamed_505);
				fragment_output_0.y = mad(fragment_unnamed_392, fragment_unnamed_486, fragment_unnamed_506);
				fragment_output_0.z = mad(fragment_unnamed_393, fragment_unnamed_487, fragment_unnamed_507);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				fragment_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				fragment_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				fragment_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_uniform_buffer_0[8] = float4(_Glossiness, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _Metallic, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[9] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

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
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(SPOT) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_SCREEN) && !defined(SHADOWS_CUBE)


			#if defined(POINT_COOKIE) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_SCREEN) && !defined(SHADOWS_CUBE)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToLight;
			float4 _MainTex_ST;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[11];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static float4 vertex_output_6;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float3 vertex_output_5 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_6 : TEXCOORD4; // TEXCOORD_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_59 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_60 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_57));
				float vertex_unnamed_84 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_58));
				float vertex_unnamed_85 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_59));
				float vertex_unnamed_86 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_60));
				precise float vertex_unnamed_94 = vertex_unnamed_83 + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_95 = vertex_unnamed_84 + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_96 = vertex_unnamed_85 + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_97 = vertex_unnamed_86 + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_105 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_106 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_107 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_108 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_94, vertex_unnamed_105)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_94, vertex_unnamed_106)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_94, vertex_unnamed_107)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_94, vertex_unnamed_108)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[10u].x, vertex_uniform_buffer_0[10u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[10u].y, vertex_uniform_buffer_0[10u].w);
				float vertex_unnamed_176 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_191 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_206 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_212 = rsqrt(dot(float3(vertex_unnamed_176, vertex_unnamed_191, vertex_unnamed_206), float3(vertex_unnamed_176, vertex_unnamed_191, vertex_unnamed_206)));
				precise float vertex_unnamed_213 = vertex_unnamed_212 * vertex_unnamed_176;
				precise float vertex_unnamed_214 = vertex_unnamed_212 * vertex_unnamed_191;
				precise float vertex_unnamed_215 = vertex_unnamed_212 * vertex_unnamed_206;
				vertex_output_2.x = vertex_unnamed_213;
				vertex_output_2.y = vertex_unnamed_214;
				vertex_output_2.z = vertex_unnamed_215;
				vertex_output_3.x = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				vertex_output_3.y = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				vertex_output_3.z = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				float vertex_unnamed_240 = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				float vertex_unnamed_241 = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				float vertex_unnamed_242 = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				float vertex_unnamed_243 = mad(vertex_uniform_buffer_1[3u].w, vertex_input_0.w, vertex_unnamed_86);
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				precise float vertex_unnamed_261 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_262 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].y;
				precise float vertex_unnamed_263 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].z;
				vertex_output_5.x = mad(vertex_uniform_buffer_0[7u].x, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].x, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].x, vertex_unnamed_240, vertex_unnamed_261)));
				vertex_output_5.y = mad(vertex_uniform_buffer_0[7u].y, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].y, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].y, vertex_unnamed_240, vertex_unnamed_262)));
				vertex_output_5.z = mad(vertex_uniform_buffer_0[7u].z, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].z, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].z, vertex_unnamed_240, vertex_unnamed_263)));
				vertex_output_6.x = 0.0f;
				vertex_output_6.y = 0.0f;
				vertex_output_6.z = 0.0f;
				vertex_output_6.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				vertex_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				vertex_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				vertex_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				vertex_uniform_buffer_0[10] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_2[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_2[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_2[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}


			float4 _LightColor0;
			float4x4 unity_WorldToLight;
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_OcclusionMaskSelector;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[10];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _LightTextureB0;
			TextureCube<float4> _LightTexture0;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_LightTexture0;
			SamplerState sampler_LightTextureB0;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float3 fragment_input_5 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_6 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_70 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_75 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_79 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_86 = fragment_unnamed_70 + fragment_uniform_buffer_2[0u].x;
				precise float fragment_unnamed_87 = fragment_unnamed_75 + fragment_uniform_buffer_2[0u].y;
				precise float fragment_unnamed_88 = fragment_unnamed_79 + fragment_uniform_buffer_2[0u].z;
				float fragment_unnamed_93 = rsqrt(dot(float3(fragment_unnamed_86, fragment_unnamed_87, fragment_unnamed_88), float3(fragment_unnamed_86, fragment_unnamed_87, fragment_unnamed_88)));
				precise float fragment_unnamed_94 = fragment_unnamed_93 * fragment_unnamed_86;
				precise float fragment_unnamed_95 = fragment_unnamed_93 * fragment_unnamed_87;
				precise float fragment_unnamed_96 = fragment_unnamed_93 * fragment_unnamed_88;
				precise float fragment_unnamed_99 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_102 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_105 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_112 = fragment_unnamed_99 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_113 = fragment_unnamed_102 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_114 = fragment_unnamed_105 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_118 = rsqrt(dot(float3(fragment_unnamed_112, fragment_unnamed_113, fragment_unnamed_114), float3(fragment_unnamed_112, fragment_unnamed_113, fragment_unnamed_114)));
				precise float fragment_unnamed_119 = fragment_unnamed_118 * fragment_unnamed_112;
				precise float fragment_unnamed_120 = fragment_unnamed_118 * fragment_unnamed_113;
				precise float fragment_unnamed_121 = fragment_unnamed_118 * fragment_unnamed_114;
				float4 fragment_unnamed_129 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_140 = fragment_unnamed_129.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_141 = fragment_unnamed_129.y * fragment_uniform_buffer_0[9u].y;
				precise float fragment_unnamed_142 = fragment_unnamed_129.z * fragment_uniform_buffer_0[9u].z;
				precise float fragment_unnamed_149 = fragment_unnamed_140 * fragment_input_4.x;
				precise float fragment_unnamed_150 = fragment_unnamed_141 * fragment_input_4.y;
				precise float fragment_unnamed_151 = fragment_unnamed_142 * fragment_input_4.z;
				precise float fragment_unnamed_159 = fragment_input_3.y * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_160 = fragment_input_3.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_161 = fragment_input_3.y * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_188 = mad(fragment_uniform_buffer_0[6u].x, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].x, fragment_input_3.x, fragment_unnamed_159)) + fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_189 = mad(fragment_uniform_buffer_0[6u].y, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].y, fragment_input_3.x, fragment_unnamed_160)) + fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_190 = mad(fragment_uniform_buffer_0[6u].z, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].z, fragment_input_3.x, fragment_unnamed_161)) + fragment_uniform_buffer_0[7u].z;
				float fragment_unnamed_290;
				float fragment_unnamed_291;
				float fragment_unnamed_292;
				float fragment_unnamed_293;
				if (fragment_uniform_buffer_3[0u].x == 1.0f)
				{
					bool fragment_unnamed_200 = fragment_uniform_buffer_3[0u].y == 1.0f;
					precise float fragment_unnamed_208 = fragment_input_3.y * fragment_uniform_buffer_3[2u].x;
					precise float fragment_unnamed_209 = fragment_input_3.y * fragment_uniform_buffer_3[2u].y;
					precise float fragment_unnamed_210 = fragment_input_3.y * fragment_uniform_buffer_3[2u].z;
					precise float fragment_unnamed_237 = mad(fragment_uniform_buffer_3[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_3[1u].x, fragment_input_3.x, fragment_unnamed_208)) + fragment_uniform_buffer_3[4u].x;
					precise float fragment_unnamed_238 = mad(fragment_uniform_buffer_3[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_3[1u].y, fragment_input_3.x, fragment_unnamed_209)) + fragment_uniform_buffer_3[4u].y;
					precise float fragment_unnamed_239 = mad(fragment_uniform_buffer_3[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_3[1u].z, fragment_input_3.x, fragment_unnamed_210)) + fragment_uniform_buffer_3[4u].z;
					precise float fragment_unnamed_252 = (-0.0f) - fragment_uniform_buffer_3[6u].x;
					precise float fragment_unnamed_254 = (-0.0f) - fragment_uniform_buffer_3[6u].y;
					precise float fragment_unnamed_256 = (-0.0f) - fragment_uniform_buffer_3[6u].z;
					precise float fragment_unnamed_257 = (fragment_unnamed_200 ? fragment_unnamed_237 : fragment_input_3.x) + fragment_unnamed_252;
					precise float fragment_unnamed_258 = (fragment_unnamed_200 ? fragment_unnamed_238 : fragment_input_3.y) + fragment_unnamed_254;
					precise float fragment_unnamed_259 = (fragment_unnamed_200 ? fragment_unnamed_239 : fragment_input_3.z) + fragment_unnamed_256;
					precise float fragment_unnamed_265 = fragment_unnamed_257 * fragment_uniform_buffer_3[5u].x;
					precise float fragment_unnamed_266 = fragment_unnamed_258 * fragment_uniform_buffer_3[5u].y;
					precise float fragment_unnamed_267 = fragment_unnamed_259 * fragment_uniform_buffer_3[5u].z;
					float4 fragment_unnamed_279 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_265, 0.25f, 0.75f), mad(fragment_uniform_buffer_3[0u].z, 0.5f, 0.75f)), fragment_unnamed_266, fragment_unnamed_267));
					fragment_unnamed_290 = fragment_unnamed_279.x;
					fragment_unnamed_291 = fragment_unnamed_279.y;
					fragment_unnamed_292 = fragment_unnamed_279.z;
					fragment_unnamed_293 = fragment_unnamed_279.w;
				}
				else
				{
					fragment_unnamed_290 = asfloat(1065353216u);
					fragment_unnamed_291 = asfloat(1065353216u);
					fragment_unnamed_292 = asfloat(1065353216u);
					fragment_unnamed_293 = asfloat(1065353216u);
				}
				precise float fragment_unnamed_317 = _LightTexture0.Sample(sampler_LightTexture0, float3(fragment_unnamed_188, fragment_unnamed_189, fragment_unnamed_190)).w * _LightTextureB0.Sample(sampler_LightTextureB0, dot(float3(fragment_unnamed_188, fragment_unnamed_189, fragment_unnamed_190), float3(fragment_unnamed_188, fragment_unnamed_189, fragment_unnamed_190)).xx).x;
				precise float fragment_unnamed_318 = clamp(dot(float4(fragment_unnamed_290, fragment_unnamed_291, fragment_unnamed_292, fragment_unnamed_293), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f) * fragment_unnamed_317;
				precise float fragment_unnamed_324 = fragment_unnamed_318 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_325 = fragment_unnamed_318 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_326 = fragment_unnamed_318 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_342 = rsqrt(dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z)));
				precise float fragment_unnamed_349 = fragment_unnamed_342 * fragment_input_2.x;
				precise float fragment_unnamed_350 = fragment_unnamed_342 * fragment_input_2.y;
				precise float fragment_unnamed_351 = fragment_unnamed_342 * fragment_input_2.z;
				float fragment_unnamed_366 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_140, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_368 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_141, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_369 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_142, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_373 = (-0.0f) - fragment_uniform_buffer_0[8u].y;
				float fragment_unnamed_374 = mad(fragment_unnamed_373, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_376 = fragment_unnamed_374 * fragment_unnamed_149;
				precise float fragment_unnamed_377 = fragment_unnamed_374 * fragment_unnamed_150;
				precise float fragment_unnamed_378 = fragment_unnamed_374 * fragment_unnamed_151;
				precise float fragment_unnamed_382 = (-0.0f) - fragment_uniform_buffer_0[8u].x;
				precise float fragment_unnamed_383 = fragment_unnamed_382 + 1.0f;
				float fragment_unnamed_384 = mad(fragment_unnamed_86, fragment_unnamed_93, fragment_unnamed_119);
				float fragment_unnamed_385 = mad(fragment_unnamed_87, fragment_unnamed_93, fragment_unnamed_120);
				float fragment_unnamed_386 = mad(fragment_unnamed_88, fragment_unnamed_93, fragment_unnamed_121);
				float fragment_unnamed_392 = rsqrt(max(dot(float3(fragment_unnamed_384, fragment_unnamed_385, fragment_unnamed_386), float3(fragment_unnamed_384, fragment_unnamed_385, fragment_unnamed_386)), 0.001000000047497451305389404296875f));
				precise float fragment_unnamed_393 = fragment_unnamed_392 * fragment_unnamed_384;
				precise float fragment_unnamed_394 = fragment_unnamed_392 * fragment_unnamed_385;
				precise float fragment_unnamed_395 = fragment_unnamed_392 * fragment_unnamed_386;
				float fragment_unnamed_396 = dot(float3(fragment_unnamed_349, fragment_unnamed_350, fragment_unnamed_351), float3(fragment_unnamed_119, fragment_unnamed_120, fragment_unnamed_121));
				float fragment_unnamed_402 = clamp(dot(float3(fragment_unnamed_349, fragment_unnamed_350, fragment_unnamed_351), float3(fragment_unnamed_94, fragment_unnamed_95, fragment_unnamed_96)), 0.0f, 1.0f);
				float fragment_unnamed_406 = clamp(dot(float3(fragment_unnamed_349, fragment_unnamed_350, fragment_unnamed_351), float3(fragment_unnamed_393, fragment_unnamed_394, fragment_unnamed_395)), 0.0f, 1.0f);
				float fragment_unnamed_410 = clamp(dot(float3(fragment_unnamed_94, fragment_unnamed_95, fragment_unnamed_96), float3(fragment_unnamed_393, fragment_unnamed_394, fragment_unnamed_395)), 0.0f, 1.0f);
				precise float fragment_unnamed_411 = fragment_unnamed_410 * fragment_unnamed_410;
				precise float fragment_unnamed_415 = dot(fragment_unnamed_411.xx, fragment_unnamed_383.xx) + (-0.5f);
				precise float fragment_unnamed_417 = (-0.0f) - fragment_unnamed_402;
				precise float fragment_unnamed_418 = fragment_unnamed_417 + 1.0f;
				precise float fragment_unnamed_419 = fragment_unnamed_418 * fragment_unnamed_418;
				precise float fragment_unnamed_420 = fragment_unnamed_419 * fragment_unnamed_419;
				precise float fragment_unnamed_421 = fragment_unnamed_418 * fragment_unnamed_420;
				precise float fragment_unnamed_424 = (-0.0f) - abs(fragment_unnamed_396);
				precise float fragment_unnamed_425 = fragment_unnamed_424 + 1.0f;
				precise float fragment_unnamed_426 = fragment_unnamed_425 * fragment_unnamed_425;
				precise float fragment_unnamed_427 = fragment_unnamed_426 * fragment_unnamed_426;
				precise float fragment_unnamed_428 = fragment_unnamed_425 * fragment_unnamed_427;
				precise float fragment_unnamed_430 = mad(fragment_unnamed_415, fragment_unnamed_428, 1.0f) * mad(fragment_unnamed_415, fragment_unnamed_421, 1.0f);
				precise float fragment_unnamed_431 = fragment_unnamed_383 * fragment_unnamed_383;
				float fragment_unnamed_432 = max(fragment_unnamed_431, 0.00200000009499490261077880859375f);
				precise float fragment_unnamed_434 = (-0.0f) - fragment_unnamed_432;
				precise float fragment_unnamed_435 = fragment_unnamed_434 + 1.0f;
				precise float fragment_unnamed_440 = abs(fragment_unnamed_396) * mad(fragment_unnamed_402, fragment_unnamed_435, fragment_unnamed_432);
				precise float fragment_unnamed_442 = mad(fragment_unnamed_402, mad(abs(fragment_unnamed_396), fragment_unnamed_435, fragment_unnamed_432), fragment_unnamed_440) + 9.9999997473787516355514526367188e-06f;
				precise float fragment_unnamed_444 = 0.5f / fragment_unnamed_442;
				precise float fragment_unnamed_445 = fragment_unnamed_432 * fragment_unnamed_432;
				precise float fragment_unnamed_446 = (-0.0f) - fragment_unnamed_406;
				float fragment_unnamed_448 = mad(mad(fragment_unnamed_406, fragment_unnamed_445, fragment_unnamed_446), fragment_unnamed_406, 1.0f);
				precise float fragment_unnamed_449 = fragment_unnamed_445 * 0.3183098733425140380859375f;
				precise float fragment_unnamed_453 = fragment_unnamed_449 / mad(fragment_unnamed_448, fragment_unnamed_448, 1.0000000116860974230803549289703e-07f);
				precise float fragment_unnamed_454 = fragment_unnamed_453 * fragment_unnamed_444;
				precise float fragment_unnamed_455 = fragment_unnamed_454 * 3.1415927410125732421875f;
				precise float fragment_unnamed_460 = fragment_unnamed_402 * fragment_unnamed_430;
				precise float fragment_unnamed_461 = fragment_unnamed_402 * sqrt(max(fragment_unnamed_455, 9.9999997473787516355514526367188e-05f));
				precise float fragment_unnamed_470 = asfloat(((dot(float3(fragment_unnamed_366, fragment_unnamed_368, fragment_unnamed_369), float3(fragment_unnamed_366, fragment_unnamed_368, fragment_unnamed_369)) != 0.0f) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_461;
				precise float fragment_unnamed_471 = fragment_unnamed_460 * fragment_unnamed_324;
				precise float fragment_unnamed_472 = fragment_unnamed_460 * fragment_unnamed_325;
				precise float fragment_unnamed_473 = fragment_unnamed_460 * fragment_unnamed_326;
				precise float fragment_unnamed_474 = fragment_unnamed_324 * fragment_unnamed_470;
				precise float fragment_unnamed_475 = fragment_unnamed_325 * fragment_unnamed_470;
				precise float fragment_unnamed_476 = fragment_unnamed_326 * fragment_unnamed_470;
				precise float fragment_unnamed_477 = (-0.0f) - fragment_unnamed_410;
				precise float fragment_unnamed_478 = fragment_unnamed_477 + 1.0f;
				precise float fragment_unnamed_479 = fragment_unnamed_478 * fragment_unnamed_478;
				precise float fragment_unnamed_480 = fragment_unnamed_479 * fragment_unnamed_479;
				precise float fragment_unnamed_481 = fragment_unnamed_478 * fragment_unnamed_480;
				precise float fragment_unnamed_482 = (-0.0f) - fragment_unnamed_366;
				precise float fragment_unnamed_483 = (-0.0f) - fragment_unnamed_368;
				precise float fragment_unnamed_484 = (-0.0f) - fragment_unnamed_369;
				precise float fragment_unnamed_485 = fragment_unnamed_482 + 1.0f;
				precise float fragment_unnamed_486 = fragment_unnamed_483 + 1.0f;
				precise float fragment_unnamed_487 = fragment_unnamed_484 + 1.0f;
				precise float fragment_unnamed_491 = fragment_unnamed_474 * mad(fragment_unnamed_485, fragment_unnamed_481, fragment_unnamed_366);
				precise float fragment_unnamed_492 = fragment_unnamed_475 * mad(fragment_unnamed_486, fragment_unnamed_481, fragment_unnamed_368);
				precise float fragment_unnamed_493 = fragment_unnamed_476 * mad(fragment_unnamed_487, fragment_unnamed_481, fragment_unnamed_369);
				fragment_output_0.x = mad(fragment_unnamed_376, fragment_unnamed_471, fragment_unnamed_491);
				fragment_output_0.y = mad(fragment_unnamed_377, fragment_unnamed_472, fragment_unnamed_492);
				fragment_output_0.z = mad(fragment_unnamed_378, fragment_unnamed_473, fragment_unnamed_493);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				fragment_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				fragment_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				fragment_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_uniform_buffer_0[8] = float4(_Glossiness, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _Metallic, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[9] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

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
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(POINT_COOKIE) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_SCREEN) && !defined(SHADOWS_CUBE)


			#if defined(DIRECTIONAL_COOKIE) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(POINT_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_SCREEN) && !defined(SHADOWS_CUBE)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToLight;
			float4 _MainTex_ST;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[11];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float2 vertex_output_1;
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD3; // TEXCOORD_3
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float4 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_59 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_60 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_57));
				float vertex_unnamed_84 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_58));
				float vertex_unnamed_85 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_59));
				float vertex_unnamed_86 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_60));
				precise float vertex_unnamed_94 = vertex_unnamed_83 + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_95 = vertex_unnamed_84 + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_96 = vertex_unnamed_85 + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_97 = vertex_unnamed_86 + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_105 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_106 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_107 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_108 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_94, vertex_unnamed_105)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_94, vertex_unnamed_106)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_94, vertex_unnamed_107)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_94, vertex_unnamed_108)));
				float vertex_unnamed_155 = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				float vertex_unnamed_156 = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				float vertex_unnamed_157 = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				float vertex_unnamed_158 = mad(vertex_uniform_buffer_1[3u].w, vertex_input_0.w, vertex_unnamed_86);
				vertex_output_3.x = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				vertex_output_3.y = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				vertex_output_3.z = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				precise float vertex_unnamed_177 = vertex_unnamed_156 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_178 = vertex_unnamed_156 * vertex_uniform_buffer_0[5u].y;
				vertex_output_1.x = mad(vertex_uniform_buffer_0[7u].x, vertex_unnamed_158, mad(vertex_uniform_buffer_0[6u].x, vertex_unnamed_157, mad(vertex_uniform_buffer_0[4u].x, vertex_unnamed_155, vertex_unnamed_177)));
				vertex_output_1.y = mad(vertex_uniform_buffer_0[7u].y, vertex_unnamed_158, mad(vertex_uniform_buffer_0[6u].y, vertex_unnamed_157, mad(vertex_uniform_buffer_0[4u].y, vertex_unnamed_155, vertex_unnamed_178)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[10u].x, vertex_uniform_buffer_0[10u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[10u].y, vertex_uniform_buffer_0[10u].w);
				float vertex_unnamed_229 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_243 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_257 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_263 = rsqrt(dot(float3(vertex_unnamed_229, vertex_unnamed_243, vertex_unnamed_257), float3(vertex_unnamed_229, vertex_unnamed_243, vertex_unnamed_257)));
				precise float vertex_unnamed_264 = vertex_unnamed_263 * vertex_unnamed_229;
				precise float vertex_unnamed_265 = vertex_unnamed_263 * vertex_unnamed_243;
				precise float vertex_unnamed_266 = vertex_unnamed_263 * vertex_unnamed_257;
				vertex_output_2.x = vertex_unnamed_264;
				vertex_output_2.y = vertex_unnamed_265;
				vertex_output_2.z = vertex_unnamed_266;
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				vertex_output_5.x = 0.0f;
				vertex_output_5.y = 0.0f;
				vertex_output_5.z = 0.0f;
				vertex_output_5.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				vertex_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				vertex_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				vertex_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				vertex_uniform_buffer_0[10] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_2[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_2[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_2[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

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
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				return stage_output;
			}


			float4 _LightColor0;
			float4x4 unity_WorldToLight;
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_OcclusionMaskSelector;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[10];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _LightTexture0;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_LightTexture0;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD3; // TEXCOORD_3
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float4 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_64 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_69 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_73 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_81 = fragment_unnamed_64 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_82 = fragment_unnamed_69 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_83 = fragment_unnamed_73 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_88 = rsqrt(dot(float3(fragment_unnamed_81, fragment_unnamed_82, fragment_unnamed_83), float3(fragment_unnamed_81, fragment_unnamed_82, fragment_unnamed_83)));
				precise float fragment_unnamed_89 = fragment_unnamed_88 * fragment_unnamed_81;
				precise float fragment_unnamed_90 = fragment_unnamed_88 * fragment_unnamed_82;
				precise float fragment_unnamed_91 = fragment_unnamed_88 * fragment_unnamed_83;
				float4 fragment_unnamed_99 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_110 = fragment_unnamed_99.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_111 = fragment_unnamed_99.y * fragment_uniform_buffer_0[9u].y;
				precise float fragment_unnamed_112 = fragment_unnamed_99.z * fragment_uniform_buffer_0[9u].z;
				precise float fragment_unnamed_119 = fragment_unnamed_110 * fragment_input_4.x;
				precise float fragment_unnamed_120 = fragment_unnamed_111 * fragment_input_4.y;
				precise float fragment_unnamed_121 = fragment_unnamed_112 * fragment_input_4.z;
				precise float fragment_unnamed_128 = fragment_input_3.y * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_129 = fragment_input_3.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_151 = mad(fragment_uniform_buffer_0[6u].x, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].x, fragment_input_3.x, fragment_unnamed_128)) + fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_152 = mad(fragment_uniform_buffer_0[6u].y, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].y, fragment_input_3.x, fragment_unnamed_129)) + fragment_uniform_buffer_0[7u].y;
				float fragment_unnamed_252;
				float fragment_unnamed_253;
				float fragment_unnamed_254;
				float fragment_unnamed_255;
				if (fragment_uniform_buffer_3[0u].x == 1.0f)
				{
					bool fragment_unnamed_162 = fragment_uniform_buffer_3[0u].y == 1.0f;
					precise float fragment_unnamed_170 = fragment_input_3.y * fragment_uniform_buffer_3[2u].x;
					precise float fragment_unnamed_171 = fragment_input_3.y * fragment_uniform_buffer_3[2u].y;
					precise float fragment_unnamed_172 = fragment_input_3.y * fragment_uniform_buffer_3[2u].z;
					precise float fragment_unnamed_199 = mad(fragment_uniform_buffer_3[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_3[1u].x, fragment_input_3.x, fragment_unnamed_170)) + fragment_uniform_buffer_3[4u].x;
					precise float fragment_unnamed_200 = mad(fragment_uniform_buffer_3[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_3[1u].y, fragment_input_3.x, fragment_unnamed_171)) + fragment_uniform_buffer_3[4u].y;
					precise float fragment_unnamed_201 = mad(fragment_uniform_buffer_3[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_3[1u].z, fragment_input_3.x, fragment_unnamed_172)) + fragment_uniform_buffer_3[4u].z;
					precise float fragment_unnamed_214 = (-0.0f) - fragment_uniform_buffer_3[6u].x;
					precise float fragment_unnamed_216 = (-0.0f) - fragment_uniform_buffer_3[6u].y;
					precise float fragment_unnamed_218 = (-0.0f) - fragment_uniform_buffer_3[6u].z;
					precise float fragment_unnamed_219 = (fragment_unnamed_162 ? fragment_unnamed_199 : fragment_input_3.x) + fragment_unnamed_214;
					precise float fragment_unnamed_220 = (fragment_unnamed_162 ? fragment_unnamed_200 : fragment_input_3.y) + fragment_unnamed_216;
					precise float fragment_unnamed_221 = (fragment_unnamed_162 ? fragment_unnamed_201 : fragment_input_3.z) + fragment_unnamed_218;
					precise float fragment_unnamed_227 = fragment_unnamed_219 * fragment_uniform_buffer_3[5u].x;
					precise float fragment_unnamed_228 = fragment_unnamed_220 * fragment_uniform_buffer_3[5u].y;
					precise float fragment_unnamed_229 = fragment_unnamed_221 * fragment_uniform_buffer_3[5u].z;
					float4 fragment_unnamed_241 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_227, 0.25f, 0.75f), mad(fragment_uniform_buffer_3[0u].z, 0.5f, 0.75f)), fragment_unnamed_228, fragment_unnamed_229));
					fragment_unnamed_252 = fragment_unnamed_241.x;
					fragment_unnamed_253 = fragment_unnamed_241.y;
					fragment_unnamed_254 = fragment_unnamed_241.z;
					fragment_unnamed_255 = fragment_unnamed_241.w;
				}
				else
				{
					fragment_unnamed_252 = asfloat(1065353216u);
					fragment_unnamed_253 = asfloat(1065353216u);
					fragment_unnamed_254 = asfloat(1065353216u);
					fragment_unnamed_255 = asfloat(1065353216u);
				}
				precise float fragment_unnamed_271 = clamp(dot(float4(fragment_unnamed_252, fragment_unnamed_253, fragment_unnamed_254, fragment_unnamed_255), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f) * _LightTexture0.Sample(sampler_LightTexture0, float2(fragment_unnamed_151, fragment_unnamed_152)).w;
				precise float fragment_unnamed_277 = fragment_unnamed_271 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_278 = fragment_unnamed_271 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_279 = fragment_unnamed_271 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_295 = rsqrt(dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z)));
				precise float fragment_unnamed_302 = fragment_unnamed_295 * fragment_input_2.x;
				precise float fragment_unnamed_303 = fragment_unnamed_295 * fragment_input_2.y;
				precise float fragment_unnamed_304 = fragment_unnamed_295 * fragment_input_2.z;
				float fragment_unnamed_319 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_110, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_321 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_111, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_322 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_112, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_326 = (-0.0f) - fragment_uniform_buffer_0[8u].y;
				float fragment_unnamed_327 = mad(fragment_unnamed_326, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_329 = fragment_unnamed_327 * fragment_unnamed_119;
				precise float fragment_unnamed_330 = fragment_unnamed_327 * fragment_unnamed_120;
				precise float fragment_unnamed_331 = fragment_unnamed_327 * fragment_unnamed_121;
				precise float fragment_unnamed_335 = (-0.0f) - fragment_uniform_buffer_0[8u].x;
				precise float fragment_unnamed_336 = fragment_unnamed_335 + 1.0f;
				float fragment_unnamed_342 = mad(fragment_unnamed_81, fragment_unnamed_88, fragment_uniform_buffer_2[0u].x);
				float fragment_unnamed_343 = mad(fragment_unnamed_82, fragment_unnamed_88, fragment_uniform_buffer_2[0u].y);
				float fragment_unnamed_344 = mad(fragment_unnamed_83, fragment_unnamed_88, fragment_uniform_buffer_2[0u].z);
				float fragment_unnamed_350 = rsqrt(max(dot(float3(fragment_unnamed_342, fragment_unnamed_343, fragment_unnamed_344), float3(fragment_unnamed_342, fragment_unnamed_343, fragment_unnamed_344)), 0.001000000047497451305389404296875f));
				precise float fragment_unnamed_351 = fragment_unnamed_350 * fragment_unnamed_342;
				precise float fragment_unnamed_352 = fragment_unnamed_350 * fragment_unnamed_343;
				precise float fragment_unnamed_353 = fragment_unnamed_350 * fragment_unnamed_344;
				float fragment_unnamed_354 = dot(float3(fragment_unnamed_302, fragment_unnamed_303, fragment_unnamed_304), float3(fragment_unnamed_89, fragment_unnamed_90, fragment_unnamed_91));
				float fragment_unnamed_365 = clamp(dot(float3(fragment_unnamed_302, fragment_unnamed_303, fragment_unnamed_304), float3(fragment_uniform_buffer_2[0u].xyz)), 0.0f, 1.0f);
				float fragment_unnamed_369 = clamp(dot(float3(fragment_unnamed_302, fragment_unnamed_303, fragment_unnamed_304), float3(fragment_unnamed_351, fragment_unnamed_352, fragment_unnamed_353)), 0.0f, 1.0f);
				float fragment_unnamed_378 = clamp(dot(float3(fragment_uniform_buffer_2[0u].xyz), float3(fragment_unnamed_351, fragment_unnamed_352, fragment_unnamed_353)), 0.0f, 1.0f);
				precise float fragment_unnamed_379 = fragment_unnamed_378 * fragment_unnamed_378;
				precise float fragment_unnamed_383 = dot(fragment_unnamed_379.xx, fragment_unnamed_336.xx) + (-0.5f);
				precise float fragment_unnamed_385 = (-0.0f) - fragment_unnamed_365;
				precise float fragment_unnamed_386 = fragment_unnamed_385 + 1.0f;
				precise float fragment_unnamed_387 = fragment_unnamed_386 * fragment_unnamed_386;
				precise float fragment_unnamed_388 = fragment_unnamed_387 * fragment_unnamed_387;
				precise float fragment_unnamed_389 = fragment_unnamed_386 * fragment_unnamed_388;
				precise float fragment_unnamed_392 = (-0.0f) - abs(fragment_unnamed_354);
				precise float fragment_unnamed_393 = fragment_unnamed_392 + 1.0f;
				precise float fragment_unnamed_394 = fragment_unnamed_393 * fragment_unnamed_393;
				precise float fragment_unnamed_395 = fragment_unnamed_394 * fragment_unnamed_394;
				precise float fragment_unnamed_396 = fragment_unnamed_393 * fragment_unnamed_395;
				precise float fragment_unnamed_398 = mad(fragment_unnamed_383, fragment_unnamed_396, 1.0f) * mad(fragment_unnamed_383, fragment_unnamed_389, 1.0f);
				precise float fragment_unnamed_399 = fragment_unnamed_336 * fragment_unnamed_336;
				float fragment_unnamed_400 = max(fragment_unnamed_399, 0.00200000009499490261077880859375f);
				precise float fragment_unnamed_402 = (-0.0f) - fragment_unnamed_400;
				precise float fragment_unnamed_403 = fragment_unnamed_402 + 1.0f;
				precise float fragment_unnamed_408 = abs(fragment_unnamed_354) * mad(fragment_unnamed_365, fragment_unnamed_403, fragment_unnamed_400);
				precise float fragment_unnamed_410 = mad(fragment_unnamed_365, mad(abs(fragment_unnamed_354), fragment_unnamed_403, fragment_unnamed_400), fragment_unnamed_408) + 9.9999997473787516355514526367188e-06f;
				precise float fragment_unnamed_412 = 0.5f / fragment_unnamed_410;
				precise float fragment_unnamed_413 = fragment_unnamed_400 * fragment_unnamed_400;
				precise float fragment_unnamed_414 = (-0.0f) - fragment_unnamed_369;
				float fragment_unnamed_416 = mad(mad(fragment_unnamed_369, fragment_unnamed_413, fragment_unnamed_414), fragment_unnamed_369, 1.0f);
				precise float fragment_unnamed_417 = fragment_unnamed_413 * 0.3183098733425140380859375f;
				precise float fragment_unnamed_421 = fragment_unnamed_417 / mad(fragment_unnamed_416, fragment_unnamed_416, 1.0000000116860974230803549289703e-07f);
				precise float fragment_unnamed_422 = fragment_unnamed_421 * fragment_unnamed_412;
				precise float fragment_unnamed_423 = fragment_unnamed_422 * 3.1415927410125732421875f;
				precise float fragment_unnamed_428 = fragment_unnamed_365 * fragment_unnamed_398;
				precise float fragment_unnamed_429 = fragment_unnamed_365 * sqrt(max(fragment_unnamed_423, 9.9999997473787516355514526367188e-05f));
				precise float fragment_unnamed_438 = asfloat(((dot(float3(fragment_unnamed_319, fragment_unnamed_321, fragment_unnamed_322), float3(fragment_unnamed_319, fragment_unnamed_321, fragment_unnamed_322)) != 0.0f) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_429;
				precise float fragment_unnamed_439 = fragment_unnamed_428 * fragment_unnamed_277;
				precise float fragment_unnamed_440 = fragment_unnamed_428 * fragment_unnamed_278;
				precise float fragment_unnamed_441 = fragment_unnamed_428 * fragment_unnamed_279;
				precise float fragment_unnamed_442 = fragment_unnamed_277 * fragment_unnamed_438;
				precise float fragment_unnamed_443 = fragment_unnamed_278 * fragment_unnamed_438;
				precise float fragment_unnamed_444 = fragment_unnamed_279 * fragment_unnamed_438;
				precise float fragment_unnamed_445 = (-0.0f) - fragment_unnamed_378;
				precise float fragment_unnamed_446 = fragment_unnamed_445 + 1.0f;
				precise float fragment_unnamed_447 = fragment_unnamed_446 * fragment_unnamed_446;
				precise float fragment_unnamed_448 = fragment_unnamed_447 * fragment_unnamed_447;
				precise float fragment_unnamed_449 = fragment_unnamed_446 * fragment_unnamed_448;
				precise float fragment_unnamed_450 = (-0.0f) - fragment_unnamed_319;
				precise float fragment_unnamed_451 = (-0.0f) - fragment_unnamed_321;
				precise float fragment_unnamed_452 = (-0.0f) - fragment_unnamed_322;
				precise float fragment_unnamed_453 = fragment_unnamed_450 + 1.0f;
				precise float fragment_unnamed_454 = fragment_unnamed_451 + 1.0f;
				precise float fragment_unnamed_455 = fragment_unnamed_452 + 1.0f;
				precise float fragment_unnamed_459 = fragment_unnamed_442 * mad(fragment_unnamed_453, fragment_unnamed_449, fragment_unnamed_319);
				precise float fragment_unnamed_460 = fragment_unnamed_443 * mad(fragment_unnamed_454, fragment_unnamed_449, fragment_unnamed_321);
				precise float fragment_unnamed_461 = fragment_unnamed_444 * mad(fragment_unnamed_455, fragment_unnamed_449, fragment_unnamed_322);
				fragment_output_0.x = mad(fragment_unnamed_329, fragment_unnamed_439, fragment_unnamed_459);
				fragment_output_0.y = mad(fragment_unnamed_330, fragment_unnamed_440, fragment_unnamed_460);
				fragment_output_0.z = mad(fragment_unnamed_331, fragment_unnamed_441, fragment_unnamed_461);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				fragment_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				fragment_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				fragment_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_uniform_buffer_0[8] = float4(_Glossiness, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _Metallic, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[9] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

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
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(DIRECTIONAL_COOKIE) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(POINT_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_SCREEN) && !defined(SHADOWS_CUBE)


			#if defined(SHADOWS_DEPTH) && defined(SPOT) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_SCREEN) && !defined(SHADOWS_CUBE)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToLight;
			float4 _MainTex_ST;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[11];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float4 vertex_output_5 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_6 : TEXCOORD4; // TEXCOORD_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_59 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_60 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_57));
				float vertex_unnamed_84 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_58));
				float vertex_unnamed_85 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_59));
				float vertex_unnamed_86 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_60));
				precise float vertex_unnamed_94 = vertex_unnamed_83 + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_95 = vertex_unnamed_84 + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_96 = vertex_unnamed_85 + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_97 = vertex_unnamed_86 + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_105 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_106 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_107 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_108 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_94, vertex_unnamed_105)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_94, vertex_unnamed_106)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_94, vertex_unnamed_107)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_94, vertex_unnamed_108)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[10u].x, vertex_uniform_buffer_0[10u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[10u].y, vertex_uniform_buffer_0[10u].w);
				float vertex_unnamed_176 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_191 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_206 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_212 = rsqrt(dot(float3(vertex_unnamed_176, vertex_unnamed_191, vertex_unnamed_206), float3(vertex_unnamed_176, vertex_unnamed_191, vertex_unnamed_206)));
				precise float vertex_unnamed_213 = vertex_unnamed_212 * vertex_unnamed_176;
				precise float vertex_unnamed_214 = vertex_unnamed_212 * vertex_unnamed_191;
				precise float vertex_unnamed_215 = vertex_unnamed_212 * vertex_unnamed_206;
				vertex_output_2.x = vertex_unnamed_213;
				vertex_output_2.y = vertex_unnamed_214;
				vertex_output_2.z = vertex_unnamed_215;
				vertex_output_3.x = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				vertex_output_3.y = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				vertex_output_3.z = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				float vertex_unnamed_240 = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				float vertex_unnamed_241 = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				float vertex_unnamed_242 = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				float vertex_unnamed_243 = mad(vertex_uniform_buffer_1[3u].w, vertex_input_0.w, vertex_unnamed_86);
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				precise float vertex_unnamed_262 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_263 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].y;
				precise float vertex_unnamed_264 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].z;
				precise float vertex_unnamed_265 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].w;
				vertex_output_5.x = mad(vertex_uniform_buffer_0[7u].x, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].x, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].x, vertex_unnamed_240, vertex_unnamed_262)));
				vertex_output_5.y = mad(vertex_uniform_buffer_0[7u].y, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].y, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].y, vertex_unnamed_240, vertex_unnamed_263)));
				vertex_output_5.z = mad(vertex_uniform_buffer_0[7u].z, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].z, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].z, vertex_unnamed_240, vertex_unnamed_264)));
				vertex_output_5.w = mad(vertex_uniform_buffer_0[7u].w, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].w, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].w, vertex_unnamed_240, vertex_unnamed_265)));
				vertex_output_6.x = 0.0f;
				vertex_output_6.y = 0.0f;
				vertex_output_6.z = 0.0f;
				vertex_output_6.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				vertex_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				vertex_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				vertex_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				vertex_uniform_buffer_0[10] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_2[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_2[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_2[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}


			float4 _LightColor0;
			float4x4 unity_WorldToLight;
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_OcclusionMaskSelector;
			float4x4 unity_WorldToShadow[4];
			float4 _LightShadowData;
			float4 unity_ShadowFadeCenterAndType;
			float4x4 unity_MatrixV;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[10];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[26];
			static float4 fragment_uniform_buffer_4[13];
			static float4 fragment_uniform_buffer_5[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _LightTexture0;
			Texture2D<float4> _LightTextureB0;
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ShadowMapTexture;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerComparisonState sampler_ShadowMapTexture;
			SamplerState sampler_LightTexture0;
			SamplerState sampler_LightTextureB0;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float4 fragment_input_5 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_6 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_82 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_87 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_91 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_98 = fragment_unnamed_82 + fragment_uniform_buffer_2[0u].x;
				precise float fragment_unnamed_99 = fragment_unnamed_87 + fragment_uniform_buffer_2[0u].y;
				precise float fragment_unnamed_100 = fragment_unnamed_91 + fragment_uniform_buffer_2[0u].z;
				float fragment_unnamed_105 = rsqrt(dot(float3(fragment_unnamed_98, fragment_unnamed_99, fragment_unnamed_100), float3(fragment_unnamed_98, fragment_unnamed_99, fragment_unnamed_100)));
				precise float fragment_unnamed_106 = fragment_unnamed_105 * fragment_unnamed_98;
				precise float fragment_unnamed_107 = fragment_unnamed_105 * fragment_unnamed_99;
				precise float fragment_unnamed_108 = fragment_unnamed_105 * fragment_unnamed_100;
				precise float fragment_unnamed_111 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_114 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_117 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_124 = fragment_unnamed_111 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_125 = fragment_unnamed_114 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_126 = fragment_unnamed_117 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_130 = rsqrt(dot(float3(fragment_unnamed_124, fragment_unnamed_125, fragment_unnamed_126), float3(fragment_unnamed_124, fragment_unnamed_125, fragment_unnamed_126)));
				precise float fragment_unnamed_131 = fragment_unnamed_130 * fragment_unnamed_124;
				precise float fragment_unnamed_132 = fragment_unnamed_130 * fragment_unnamed_125;
				precise float fragment_unnamed_133 = fragment_unnamed_130 * fragment_unnamed_126;
				float4 fragment_unnamed_141 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_152 = fragment_unnamed_141.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_153 = fragment_unnamed_141.y * fragment_uniform_buffer_0[9u].y;
				precise float fragment_unnamed_154 = fragment_unnamed_141.z * fragment_uniform_buffer_0[9u].z;
				precise float fragment_unnamed_161 = fragment_unnamed_152 * fragment_input_4.x;
				precise float fragment_unnamed_162 = fragment_unnamed_153 * fragment_input_4.y;
				precise float fragment_unnamed_163 = fragment_unnamed_154 * fragment_input_4.z;
				precise float fragment_unnamed_172 = fragment_input_3.y * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_173 = fragment_input_3.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_174 = fragment_input_3.y * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_175 = fragment_input_3.y * fragment_uniform_buffer_0[5u].w;
				precise float fragment_unnamed_207 = mad(fragment_uniform_buffer_0[6u].x, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].x, fragment_input_3.x, fragment_unnamed_172)) + fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_208 = mad(fragment_uniform_buffer_0[6u].y, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].y, fragment_input_3.x, fragment_unnamed_173)) + fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_209 = mad(fragment_uniform_buffer_0[6u].z, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].z, fragment_input_3.x, fragment_unnamed_174)) + fragment_uniform_buffer_0[7u].z;
				precise float fragment_unnamed_210 = mad(fragment_uniform_buffer_0[6u].w, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].w, fragment_input_3.x, fragment_unnamed_175)) + fragment_uniform_buffer_0[7u].w;
				float fragment_unnamed_228 = dot(float3(fragment_unnamed_124, fragment_unnamed_125, fragment_unnamed_126), float3(asfloat(asuint(fragment_uniform_buffer_4[9u]).z), asfloat(asuint(fragment_uniform_buffer_4[10u]).z), asfloat(asuint(fragment_uniform_buffer_4[11u]).z)));
				precise float fragment_unnamed_241 = (-0.0f) - fragment_uniform_buffer_3[25u].x;
				precise float fragment_unnamed_243 = (-0.0f) - fragment_uniform_buffer_3[25u].y;
				precise float fragment_unnamed_245 = (-0.0f) - fragment_uniform_buffer_3[25u].z;
				precise float fragment_unnamed_246 = fragment_input_3.x + fragment_unnamed_241;
				precise float fragment_unnamed_247 = fragment_input_3.y + fragment_unnamed_243;
				precise float fragment_unnamed_248 = fragment_input_3.z + fragment_unnamed_245;
				precise float fragment_unnamed_253 = (-0.0f) - fragment_unnamed_228;
				precise float fragment_unnamed_254 = fragment_unnamed_253 + sqrt(dot(float3(fragment_unnamed_246, fragment_unnamed_247, fragment_unnamed_248), float3(fragment_unnamed_246, fragment_unnamed_247, fragment_unnamed_248)));
				float fragment_unnamed_367;
				float fragment_unnamed_368;
				float fragment_unnamed_369;
				float fragment_unnamed_370;
				if (fragment_uniform_buffer_5[0u].x == 1.0f)
				{
					bool fragment_unnamed_277 = fragment_uniform_buffer_5[0u].y == 1.0f;
					precise float fragment_unnamed_285 = fragment_input_3.y * fragment_uniform_buffer_5[2u].x;
					precise float fragment_unnamed_286 = fragment_input_3.y * fragment_uniform_buffer_5[2u].y;
					precise float fragment_unnamed_287 = fragment_input_3.y * fragment_uniform_buffer_5[2u].z;
					precise float fragment_unnamed_314 = mad(fragment_uniform_buffer_5[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].x, fragment_input_3.x, fragment_unnamed_285)) + fragment_uniform_buffer_5[4u].x;
					precise float fragment_unnamed_315 = mad(fragment_uniform_buffer_5[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].y, fragment_input_3.x, fragment_unnamed_286)) + fragment_uniform_buffer_5[4u].y;
					precise float fragment_unnamed_316 = mad(fragment_uniform_buffer_5[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].z, fragment_input_3.x, fragment_unnamed_287)) + fragment_uniform_buffer_5[4u].z;
					precise float fragment_unnamed_329 = (-0.0f) - fragment_uniform_buffer_5[6u].x;
					precise float fragment_unnamed_331 = (-0.0f) - fragment_uniform_buffer_5[6u].y;
					precise float fragment_unnamed_333 = (-0.0f) - fragment_uniform_buffer_5[6u].z;
					precise float fragment_unnamed_334 = (fragment_unnamed_277 ? fragment_unnamed_314 : fragment_input_3.x) + fragment_unnamed_329;
					precise float fragment_unnamed_335 = (fragment_unnamed_277 ? fragment_unnamed_315 : fragment_input_3.y) + fragment_unnamed_331;
					precise float fragment_unnamed_336 = (fragment_unnamed_277 ? fragment_unnamed_316 : fragment_input_3.z) + fragment_unnamed_333;
					precise float fragment_unnamed_342 = fragment_unnamed_334 * fragment_uniform_buffer_5[5u].x;
					precise float fragment_unnamed_343 = fragment_unnamed_335 * fragment_uniform_buffer_5[5u].y;
					precise float fragment_unnamed_344 = fragment_unnamed_336 * fragment_uniform_buffer_5[5u].z;
					float4 fragment_unnamed_356 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_342, 0.25f, 0.75f), mad(fragment_uniform_buffer_5[0u].z, 0.5f, 0.75f)), fragment_unnamed_343, fragment_unnamed_344));
					fragment_unnamed_367 = fragment_unnamed_356.x;
					fragment_unnamed_368 = fragment_unnamed_356.y;
					fragment_unnamed_369 = fragment_unnamed_356.z;
					fragment_unnamed_370 = fragment_unnamed_356.w;
				}
				else
				{
					fragment_unnamed_367 = asfloat(1065353216u);
					fragment_unnamed_368 = asfloat(1065353216u);
					fragment_unnamed_369 = asfloat(1065353216u);
					fragment_unnamed_370 = asfloat(1065353216u);
				}
				precise float fragment_unnamed_390 = fragment_input_3.y * fragment_uniform_buffer_3[9u].x;
				precise float fragment_unnamed_391 = fragment_input_3.y * fragment_uniform_buffer_3[9u].y;
				precise float fragment_unnamed_392 = fragment_input_3.y * fragment_uniform_buffer_3[9u].z;
				precise float fragment_unnamed_393 = fragment_input_3.y * fragment_uniform_buffer_3[9u].w;
				precise float fragment_unnamed_425 = mad(fragment_uniform_buffer_3[10u].x, fragment_input_3.z, mad(fragment_uniform_buffer_3[8u].x, fragment_input_3.x, fragment_unnamed_390)) + fragment_uniform_buffer_3[11u].x;
				precise float fragment_unnamed_426 = mad(fragment_uniform_buffer_3[10u].y, fragment_input_3.z, mad(fragment_uniform_buffer_3[8u].y, fragment_input_3.x, fragment_unnamed_391)) + fragment_uniform_buffer_3[11u].y;
				precise float fragment_unnamed_427 = mad(fragment_uniform_buffer_3[10u].z, fragment_input_3.z, mad(fragment_uniform_buffer_3[8u].z, fragment_input_3.x, fragment_unnamed_392)) + fragment_uniform_buffer_3[11u].z;
				precise float fragment_unnamed_428 = mad(fragment_uniform_buffer_3[10u].w, fragment_input_3.z, mad(fragment_uniform_buffer_3[8u].w, fragment_input_3.x, fragment_unnamed_393)) + fragment_uniform_buffer_3[11u].w;
				precise float fragment_unnamed_429 = fragment_unnamed_425 / fragment_unnamed_428;
				precise float fragment_unnamed_430 = fragment_unnamed_426 / fragment_unnamed_428;
				precise float fragment_unnamed_431 = fragment_unnamed_427 / fragment_unnamed_428;
				precise float fragment_unnamed_442 = (-0.0f) - fragment_uniform_buffer_3[24u].x;
				precise float fragment_unnamed_443 = fragment_unnamed_442 + 1.0f;
				float fragment_unnamed_447 = mad(_ShadowMapTexture.SampleCmpLevelZero(sampler_ShadowMapTexture, float2(fragment_unnamed_429, fragment_unnamed_430), fragment_unnamed_431).xxxx.x, fragment_unnamed_443, fragment_uniform_buffer_3[24u].x);
				precise float fragment_unnamed_448 = (-0.0f) - fragment_unnamed_447;
				precise float fragment_unnamed_449 = fragment_unnamed_448 + clamp(dot(float4(fragment_unnamed_367, fragment_unnamed_368, fragment_unnamed_369, fragment_unnamed_370), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f);
				precise float fragment_unnamed_456 = fragment_unnamed_207 / fragment_unnamed_210;
				precise float fragment_unnamed_457 = fragment_unnamed_208 / fragment_unnamed_210;
				precise float fragment_unnamed_458 = fragment_unnamed_456 + 0.5f;
				precise float fragment_unnamed_459 = fragment_unnamed_457 + 0.5f;
				precise float fragment_unnamed_464 = asfloat(((0.0f < fragment_unnamed_209) ? 4294967295u : 0u) & 1065353216u) * _LightTexture0.Sample(sampler_LightTexture0, float2(fragment_unnamed_458, fragment_unnamed_459)).w;
				precise float fragment_unnamed_472 = fragment_unnamed_464 * _LightTextureB0.Sample(sampler_LightTextureB0, dot(float3(fragment_unnamed_207, fragment_unnamed_208, fragment_unnamed_209), float3(fragment_unnamed_207, fragment_unnamed_208, fragment_unnamed_209)).xx).x;
				precise float fragment_unnamed_473 = mad(clamp(mad(mad(fragment_uniform_buffer_3[25u].w, fragment_unnamed_254, fragment_unnamed_228), fragment_uniform_buffer_3[24u].z, fragment_uniform_buffer_3[24u].w), 0.0f, 1.0f), fragment_unnamed_449, fragment_unnamed_447) * fragment_unnamed_472;
				precise float fragment_unnamed_479 = fragment_unnamed_473 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_480 = fragment_unnamed_473 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_481 = fragment_unnamed_473 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_497 = rsqrt(dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z)));
				precise float fragment_unnamed_504 = fragment_unnamed_497 * fragment_input_2.x;
				precise float fragment_unnamed_505 = fragment_unnamed_497 * fragment_input_2.y;
				precise float fragment_unnamed_506 = fragment_unnamed_497 * fragment_input_2.z;
				float fragment_unnamed_520 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_152, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_522 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_153, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_523 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_154, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_527 = (-0.0f) - fragment_uniform_buffer_0[8u].y;
				float fragment_unnamed_528 = mad(fragment_unnamed_527, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_530 = fragment_unnamed_528 * fragment_unnamed_161;
				precise float fragment_unnamed_531 = fragment_unnamed_528 * fragment_unnamed_162;
				precise float fragment_unnamed_532 = fragment_unnamed_528 * fragment_unnamed_163;
				precise float fragment_unnamed_536 = (-0.0f) - fragment_uniform_buffer_0[8u].x;
				precise float fragment_unnamed_537 = fragment_unnamed_536 + 1.0f;
				float fragment_unnamed_538 = mad(fragment_unnamed_98, fragment_unnamed_105, fragment_unnamed_131);
				float fragment_unnamed_539 = mad(fragment_unnamed_99, fragment_unnamed_105, fragment_unnamed_132);
				float fragment_unnamed_540 = mad(fragment_unnamed_100, fragment_unnamed_105, fragment_unnamed_133);
				float fragment_unnamed_546 = rsqrt(max(dot(float3(fragment_unnamed_538, fragment_unnamed_539, fragment_unnamed_540), float3(fragment_unnamed_538, fragment_unnamed_539, fragment_unnamed_540)), 0.001000000047497451305389404296875f));
				precise float fragment_unnamed_547 = fragment_unnamed_546 * fragment_unnamed_538;
				precise float fragment_unnamed_548 = fragment_unnamed_546 * fragment_unnamed_539;
				precise float fragment_unnamed_549 = fragment_unnamed_546 * fragment_unnamed_540;
				float fragment_unnamed_550 = dot(float3(fragment_unnamed_504, fragment_unnamed_505, fragment_unnamed_506), float3(fragment_unnamed_131, fragment_unnamed_132, fragment_unnamed_133));
				float fragment_unnamed_556 = clamp(dot(float3(fragment_unnamed_504, fragment_unnamed_505, fragment_unnamed_506), float3(fragment_unnamed_106, fragment_unnamed_107, fragment_unnamed_108)), 0.0f, 1.0f);
				float fragment_unnamed_560 = clamp(dot(float3(fragment_unnamed_504, fragment_unnamed_505, fragment_unnamed_506), float3(fragment_unnamed_547, fragment_unnamed_548, fragment_unnamed_549)), 0.0f, 1.0f);
				float fragment_unnamed_564 = clamp(dot(float3(fragment_unnamed_106, fragment_unnamed_107, fragment_unnamed_108), float3(fragment_unnamed_547, fragment_unnamed_548, fragment_unnamed_549)), 0.0f, 1.0f);
				precise float fragment_unnamed_565 = fragment_unnamed_564 * fragment_unnamed_564;
				precise float fragment_unnamed_569 = dot(fragment_unnamed_565.xx, fragment_unnamed_537.xx) + (-0.5f);
				precise float fragment_unnamed_571 = (-0.0f) - fragment_unnamed_556;
				precise float fragment_unnamed_572 = fragment_unnamed_571 + 1.0f;
				precise float fragment_unnamed_573 = fragment_unnamed_572 * fragment_unnamed_572;
				precise float fragment_unnamed_574 = fragment_unnamed_573 * fragment_unnamed_573;
				precise float fragment_unnamed_575 = fragment_unnamed_572 * fragment_unnamed_574;
				precise float fragment_unnamed_578 = (-0.0f) - abs(fragment_unnamed_550);
				precise float fragment_unnamed_579 = fragment_unnamed_578 + 1.0f;
				precise float fragment_unnamed_580 = fragment_unnamed_579 * fragment_unnamed_579;
				precise float fragment_unnamed_581 = fragment_unnamed_580 * fragment_unnamed_580;
				precise float fragment_unnamed_582 = fragment_unnamed_579 * fragment_unnamed_581;
				precise float fragment_unnamed_584 = mad(fragment_unnamed_569, fragment_unnamed_582, 1.0f) * mad(fragment_unnamed_569, fragment_unnamed_575, 1.0f);
				precise float fragment_unnamed_585 = fragment_unnamed_537 * fragment_unnamed_537;
				float fragment_unnamed_586 = max(fragment_unnamed_585, 0.00200000009499490261077880859375f);
				precise float fragment_unnamed_588 = (-0.0f) - fragment_unnamed_586;
				precise float fragment_unnamed_589 = fragment_unnamed_588 + 1.0f;
				precise float fragment_unnamed_594 = abs(fragment_unnamed_550) * mad(fragment_unnamed_556, fragment_unnamed_589, fragment_unnamed_586);
				precise float fragment_unnamed_596 = mad(fragment_unnamed_556, mad(abs(fragment_unnamed_550), fragment_unnamed_589, fragment_unnamed_586), fragment_unnamed_594) + 9.9999997473787516355514526367188e-06f;
				precise float fragment_unnamed_598 = 0.5f / fragment_unnamed_596;
				precise float fragment_unnamed_599 = fragment_unnamed_586 * fragment_unnamed_586;
				precise float fragment_unnamed_600 = (-0.0f) - fragment_unnamed_560;
				float fragment_unnamed_602 = mad(mad(fragment_unnamed_560, fragment_unnamed_599, fragment_unnamed_600), fragment_unnamed_560, 1.0f);
				precise float fragment_unnamed_603 = fragment_unnamed_599 * 0.3183098733425140380859375f;
				precise float fragment_unnamed_607 = fragment_unnamed_603 / mad(fragment_unnamed_602, fragment_unnamed_602, 1.0000000116860974230803549289703e-07f);
				precise float fragment_unnamed_608 = fragment_unnamed_607 * fragment_unnamed_598;
				precise float fragment_unnamed_609 = fragment_unnamed_608 * 3.1415927410125732421875f;
				precise float fragment_unnamed_614 = fragment_unnamed_556 * fragment_unnamed_584;
				precise float fragment_unnamed_615 = fragment_unnamed_556 * sqrt(max(fragment_unnamed_609, 9.9999997473787516355514526367188e-05f));
				precise float fragment_unnamed_623 = asfloat(((dot(float3(fragment_unnamed_520, fragment_unnamed_522, fragment_unnamed_523), float3(fragment_unnamed_520, fragment_unnamed_522, fragment_unnamed_523)) != 0.0f) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_615;
				precise float fragment_unnamed_624 = fragment_unnamed_614 * fragment_unnamed_479;
				precise float fragment_unnamed_625 = fragment_unnamed_614 * fragment_unnamed_480;
				precise float fragment_unnamed_626 = fragment_unnamed_614 * fragment_unnamed_481;
				precise float fragment_unnamed_627 = fragment_unnamed_479 * fragment_unnamed_623;
				precise float fragment_unnamed_628 = fragment_unnamed_480 * fragment_unnamed_623;
				precise float fragment_unnamed_629 = fragment_unnamed_481 * fragment_unnamed_623;
				precise float fragment_unnamed_630 = (-0.0f) - fragment_unnamed_564;
				precise float fragment_unnamed_631 = fragment_unnamed_630 + 1.0f;
				precise float fragment_unnamed_632 = fragment_unnamed_631 * fragment_unnamed_631;
				precise float fragment_unnamed_633 = fragment_unnamed_632 * fragment_unnamed_632;
				precise float fragment_unnamed_634 = fragment_unnamed_631 * fragment_unnamed_633;
				precise float fragment_unnamed_635 = (-0.0f) - fragment_unnamed_520;
				precise float fragment_unnamed_636 = (-0.0f) - fragment_unnamed_522;
				precise float fragment_unnamed_637 = (-0.0f) - fragment_unnamed_523;
				precise float fragment_unnamed_638 = fragment_unnamed_635 + 1.0f;
				precise float fragment_unnamed_639 = fragment_unnamed_636 + 1.0f;
				precise float fragment_unnamed_640 = fragment_unnamed_637 + 1.0f;
				precise float fragment_unnamed_644 = fragment_unnamed_627 * mad(fragment_unnamed_638, fragment_unnamed_634, fragment_unnamed_520);
				precise float fragment_unnamed_645 = fragment_unnamed_628 * mad(fragment_unnamed_639, fragment_unnamed_634, fragment_unnamed_522);
				precise float fragment_unnamed_646 = fragment_unnamed_629 * mad(fragment_unnamed_640, fragment_unnamed_634, fragment_unnamed_523);
				fragment_output_0.x = mad(fragment_unnamed_530, fragment_unnamed_624, fragment_unnamed_644);
				fragment_output_0.y = mad(fragment_unnamed_531, fragment_unnamed_625, fragment_unnamed_645);
				fragment_output_0.z = mad(fragment_unnamed_532, fragment_unnamed_626, fragment_unnamed_646);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				fragment_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				fragment_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				fragment_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_uniform_buffer_0[8] = float4(_Glossiness, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _Metallic, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[9] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_uniform_buffer_2[46] = float4(unity_OcclusionMaskSelector[0], unity_OcclusionMaskSelector[1], unity_OcclusionMaskSelector[2], unity_OcclusionMaskSelector[3]);

				fragment_uniform_buffer_3[8] = float4(unity_WorldToShadow[0][0][0], unity_WorldToShadow[0][1][0], unity_WorldToShadow[0][2][0], unity_WorldToShadow[0][3][0]);
				fragment_uniform_buffer_3[9] = float4(unity_WorldToShadow[0][0][1], unity_WorldToShadow[0][1][1], unity_WorldToShadow[0][2][1], unity_WorldToShadow[0][3][1]);
				fragment_uniform_buffer_3[10] = float4(unity_WorldToShadow[0][0][2], unity_WorldToShadow[0][1][2], unity_WorldToShadow[0][2][2], unity_WorldToShadow[0][3][2]);
				fragment_uniform_buffer_3[11] = float4(unity_WorldToShadow[0][0][3], unity_WorldToShadow[0][1][3], unity_WorldToShadow[0][2][3], unity_WorldToShadow[0][3][3]);
				fragment_uniform_buffer_3[12] = float4(unity_WorldToShadow[1][0][0], unity_WorldToShadow[1][1][0], unity_WorldToShadow[1][2][0], unity_WorldToShadow[1][3][0]);
				fragment_uniform_buffer_3[13] = float4(unity_WorldToShadow[1][0][1], unity_WorldToShadow[1][1][1], unity_WorldToShadow[1][2][1], unity_WorldToShadow[1][3][1]);
				fragment_uniform_buffer_3[14] = float4(unity_WorldToShadow[1][0][2], unity_WorldToShadow[1][1][2], unity_WorldToShadow[1][2][2], unity_WorldToShadow[1][3][2]);
				fragment_uniform_buffer_3[15] = float4(unity_WorldToShadow[1][0][3], unity_WorldToShadow[1][1][3], unity_WorldToShadow[1][2][3], unity_WorldToShadow[1][3][3]);
				fragment_uniform_buffer_3[16] = float4(unity_WorldToShadow[2][0][0], unity_WorldToShadow[2][1][0], unity_WorldToShadow[2][2][0], unity_WorldToShadow[2][3][0]);
				fragment_uniform_buffer_3[17] = float4(unity_WorldToShadow[2][0][1], unity_WorldToShadow[2][1][1], unity_WorldToShadow[2][2][1], unity_WorldToShadow[2][3][1]);
				fragment_uniform_buffer_3[18] = float4(unity_WorldToShadow[2][0][2], unity_WorldToShadow[2][1][2], unity_WorldToShadow[2][2][2], unity_WorldToShadow[2][3][2]);
				fragment_uniform_buffer_3[19] = float4(unity_WorldToShadow[2][0][3], unity_WorldToShadow[2][1][3], unity_WorldToShadow[2][2][3], unity_WorldToShadow[2][3][3]);
				fragment_uniform_buffer_3[20] = float4(unity_WorldToShadow[3][0][0], unity_WorldToShadow[3][1][0], unity_WorldToShadow[3][2][0], unity_WorldToShadow[3][3][0]);
				fragment_uniform_buffer_3[21] = float4(unity_WorldToShadow[3][0][1], unity_WorldToShadow[3][1][1], unity_WorldToShadow[3][2][1], unity_WorldToShadow[3][3][1]);
				fragment_uniform_buffer_3[22] = float4(unity_WorldToShadow[3][0][2], unity_WorldToShadow[3][1][2], unity_WorldToShadow[3][2][2], unity_WorldToShadow[3][3][2]);
				fragment_uniform_buffer_3[23] = float4(unity_WorldToShadow[3][0][3], unity_WorldToShadow[3][1][3], unity_WorldToShadow[3][2][3], unity_WorldToShadow[3][3][3]);

				fragment_uniform_buffer_3[24] = float4(_LightShadowData[0], _LightShadowData[1], _LightShadowData[2], _LightShadowData[3]);

				fragment_uniform_buffer_3[25] = float4(unity_ShadowFadeCenterAndType[0], unity_ShadowFadeCenterAndType[1], unity_ShadowFadeCenterAndType[2], unity_ShadowFadeCenterAndType[3]);

				fragment_uniform_buffer_4[9] = float4(unity_MatrixV[0][0], unity_MatrixV[1][0], unity_MatrixV[2][0], unity_MatrixV[3][0]);
				fragment_uniform_buffer_4[10] = float4(unity_MatrixV[0][1], unity_MatrixV[1][1], unity_MatrixV[2][1], unity_MatrixV[3][1]);
				fragment_uniform_buffer_4[11] = float4(unity_MatrixV[0][2], unity_MatrixV[1][2], unity_MatrixV[2][2], unity_MatrixV[3][2]);
				fragment_uniform_buffer_4[12] = float4(unity_MatrixV[0][3], unity_MatrixV[1][3], unity_MatrixV[2][3], unity_MatrixV[3][3]);

				fragment_uniform_buffer_5[0] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_5[1] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_5[2] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_5[3] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_5[4] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_5[5] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], fragment_uniform_buffer_5[5][3]);

				fragment_uniform_buffer_5[6] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], fragment_uniform_buffer_5[6][3]);

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

			#endif // defined(SHADOWS_DEPTH) && defined(SPOT) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_SCREEN) && !defined(SHADOWS_CUBE)


			#if defined(SHADOWS_DEPTH) && defined(SHADOWS_SOFT) && defined(SPOT) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_SCREEN) && !defined(SHADOWS_CUBE)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToLight;
			float4 _MainTex_ST;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[16];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float4 vertex_output_5 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_6 : TEXCOORD4; // TEXCOORD_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_59 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_60 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_57));
				float vertex_unnamed_84 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_58));
				float vertex_unnamed_85 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_59));
				float vertex_unnamed_86 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_60));
				precise float vertex_unnamed_94 = vertex_unnamed_83 + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_95 = vertex_unnamed_84 + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_96 = vertex_unnamed_85 + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_97 = vertex_unnamed_86 + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_105 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_106 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_107 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_108 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_94, vertex_unnamed_105)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_94, vertex_unnamed_106)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_94, vertex_unnamed_107)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_94, vertex_unnamed_108)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[15u].x, vertex_uniform_buffer_0[15u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[15u].y, vertex_uniform_buffer_0[15u].w);
				float vertex_unnamed_176 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_191 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_206 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_212 = rsqrt(dot(float3(vertex_unnamed_176, vertex_unnamed_191, vertex_unnamed_206), float3(vertex_unnamed_176, vertex_unnamed_191, vertex_unnamed_206)));
				precise float vertex_unnamed_213 = vertex_unnamed_212 * vertex_unnamed_176;
				precise float vertex_unnamed_214 = vertex_unnamed_212 * vertex_unnamed_191;
				precise float vertex_unnamed_215 = vertex_unnamed_212 * vertex_unnamed_206;
				vertex_output_2.x = vertex_unnamed_213;
				vertex_output_2.y = vertex_unnamed_214;
				vertex_output_2.z = vertex_unnamed_215;
				vertex_output_3.x = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				vertex_output_3.y = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				vertex_output_3.z = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				float vertex_unnamed_240 = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				float vertex_unnamed_241 = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				float vertex_unnamed_242 = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				float vertex_unnamed_243 = mad(vertex_uniform_buffer_1[3u].w, vertex_input_0.w, vertex_unnamed_86);
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				precise float vertex_unnamed_263 = vertex_unnamed_241 * vertex_uniform_buffer_0[10u].x;
				precise float vertex_unnamed_264 = vertex_unnamed_241 * vertex_uniform_buffer_0[10u].y;
				precise float vertex_unnamed_265 = vertex_unnamed_241 * vertex_uniform_buffer_0[10u].z;
				precise float vertex_unnamed_266 = vertex_unnamed_241 * vertex_uniform_buffer_0[10u].w;
				vertex_output_5.x = mad(vertex_uniform_buffer_0[12u].x, vertex_unnamed_243, mad(vertex_uniform_buffer_0[11u].x, vertex_unnamed_242, mad(vertex_uniform_buffer_0[9u].x, vertex_unnamed_240, vertex_unnamed_263)));
				vertex_output_5.y = mad(vertex_uniform_buffer_0[12u].y, vertex_unnamed_243, mad(vertex_uniform_buffer_0[11u].y, vertex_unnamed_242, mad(vertex_uniform_buffer_0[9u].y, vertex_unnamed_240, vertex_unnamed_264)));
				vertex_output_5.z = mad(vertex_uniform_buffer_0[12u].z, vertex_unnamed_243, mad(vertex_uniform_buffer_0[11u].z, vertex_unnamed_242, mad(vertex_uniform_buffer_0[9u].z, vertex_unnamed_240, vertex_unnamed_265)));
				vertex_output_5.w = mad(vertex_uniform_buffer_0[12u].w, vertex_unnamed_243, mad(vertex_uniform_buffer_0[11u].w, vertex_unnamed_242, mad(vertex_uniform_buffer_0[9u].w, vertex_unnamed_240, vertex_unnamed_266)));
				vertex_output_6.x = 0.0f;
				vertex_output_6.y = 0.0f;
				vertex_output_6.z = 0.0f;
				vertex_output_6.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[9] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				vertex_uniform_buffer_0[10] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				vertex_uniform_buffer_0[11] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				vertex_uniform_buffer_0[12] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				vertex_uniform_buffer_0[15] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_2[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_2[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_2[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}


			float4 _LightColor0;
			float4 _ShadowMapTexture_TexelSize;
			float4x4 unity_WorldToLight;
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_OcclusionMaskSelector;
			float4x4 unity_WorldToShadow[4];
			float4 _LightShadowData;
			float4 unity_ShadowFadeCenterAndType;
			float4x4 unity_MatrixV;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[15];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[26];
			static float4 fragment_uniform_buffer_4[13];
			static float4 fragment_uniform_buffer_5[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _LightTexture0;
			Texture2D<float4> _LightTextureB0;
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ShadowMapTexture;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerComparisonState sampler_ShadowMapTexture;
			SamplerState sampler_LightTexture0;
			SamplerState sampler_LightTextureB0;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float4 fragment_input_5 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_6 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_82 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_87 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_91 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_98 = fragment_unnamed_82 + fragment_uniform_buffer_2[0u].x;
				precise float fragment_unnamed_99 = fragment_unnamed_87 + fragment_uniform_buffer_2[0u].y;
				precise float fragment_unnamed_100 = fragment_unnamed_91 + fragment_uniform_buffer_2[0u].z;
				float fragment_unnamed_105 = rsqrt(dot(float3(fragment_unnamed_98, fragment_unnamed_99, fragment_unnamed_100), float3(fragment_unnamed_98, fragment_unnamed_99, fragment_unnamed_100)));
				precise float fragment_unnamed_106 = fragment_unnamed_105 * fragment_unnamed_98;
				precise float fragment_unnamed_107 = fragment_unnamed_105 * fragment_unnamed_99;
				precise float fragment_unnamed_108 = fragment_unnamed_105 * fragment_unnamed_100;
				precise float fragment_unnamed_111 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_114 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_117 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_124 = fragment_unnamed_111 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_125 = fragment_unnamed_114 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_126 = fragment_unnamed_117 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_130 = rsqrt(dot(float3(fragment_unnamed_124, fragment_unnamed_125, fragment_unnamed_126), float3(fragment_unnamed_124, fragment_unnamed_125, fragment_unnamed_126)));
				precise float fragment_unnamed_131 = fragment_unnamed_130 * fragment_unnamed_124;
				precise float fragment_unnamed_132 = fragment_unnamed_130 * fragment_unnamed_125;
				precise float fragment_unnamed_133 = fragment_unnamed_130 * fragment_unnamed_126;
				float4 fragment_unnamed_141 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_152 = fragment_unnamed_141.x * fragment_uniform_buffer_0[14u].x;
				precise float fragment_unnamed_153 = fragment_unnamed_141.y * fragment_uniform_buffer_0[14u].y;
				precise float fragment_unnamed_154 = fragment_unnamed_141.z * fragment_uniform_buffer_0[14u].z;
				precise float fragment_unnamed_161 = fragment_unnamed_152 * fragment_input_4.x;
				precise float fragment_unnamed_162 = fragment_unnamed_153 * fragment_input_4.y;
				precise float fragment_unnamed_163 = fragment_unnamed_154 * fragment_input_4.z;
				precise float fragment_unnamed_173 = fragment_input_3.y * fragment_uniform_buffer_0[10u].x;
				precise float fragment_unnamed_174 = fragment_input_3.y * fragment_uniform_buffer_0[10u].y;
				precise float fragment_unnamed_175 = fragment_input_3.y * fragment_uniform_buffer_0[10u].z;
				precise float fragment_unnamed_176 = fragment_input_3.y * fragment_uniform_buffer_0[10u].w;
				precise float fragment_unnamed_209 = mad(fragment_uniform_buffer_0[11u].x, fragment_input_3.z, mad(fragment_uniform_buffer_0[9u].x, fragment_input_3.x, fragment_unnamed_173)) + fragment_uniform_buffer_0[12u].x;
				precise float fragment_unnamed_210 = mad(fragment_uniform_buffer_0[11u].y, fragment_input_3.z, mad(fragment_uniform_buffer_0[9u].y, fragment_input_3.x, fragment_unnamed_174)) + fragment_uniform_buffer_0[12u].y;
				precise float fragment_unnamed_211 = mad(fragment_uniform_buffer_0[11u].z, fragment_input_3.z, mad(fragment_uniform_buffer_0[9u].z, fragment_input_3.x, fragment_unnamed_175)) + fragment_uniform_buffer_0[12u].z;
				precise float fragment_unnamed_212 = mad(fragment_uniform_buffer_0[11u].w, fragment_input_3.z, mad(fragment_uniform_buffer_0[9u].w, fragment_input_3.x, fragment_unnamed_176)) + fragment_uniform_buffer_0[12u].w;
				float fragment_unnamed_229 = dot(float3(fragment_unnamed_124, fragment_unnamed_125, fragment_unnamed_126), float3(asfloat(asuint(fragment_uniform_buffer_4[9u]).z), asfloat(asuint(fragment_uniform_buffer_4[10u]).z), asfloat(asuint(fragment_uniform_buffer_4[11u]).z)));
				precise float fragment_unnamed_242 = (-0.0f) - fragment_uniform_buffer_3[25u].x;
				precise float fragment_unnamed_244 = (-0.0f) - fragment_uniform_buffer_3[25u].y;
				precise float fragment_unnamed_246 = (-0.0f) - fragment_uniform_buffer_3[25u].z;
				precise float fragment_unnamed_247 = fragment_input_3.x + fragment_unnamed_242;
				precise float fragment_unnamed_248 = fragment_input_3.y + fragment_unnamed_244;
				precise float fragment_unnamed_249 = fragment_input_3.z + fragment_unnamed_246;
				precise float fragment_unnamed_254 = (-0.0f) - fragment_unnamed_229;
				precise float fragment_unnamed_255 = fragment_unnamed_254 + sqrt(dot(float3(fragment_unnamed_247, fragment_unnamed_248, fragment_unnamed_249), float3(fragment_unnamed_247, fragment_unnamed_248, fragment_unnamed_249)));
				float fragment_unnamed_269 = clamp(mad(mad(fragment_uniform_buffer_3[25u].w, fragment_unnamed_255, fragment_unnamed_229), fragment_uniform_buffer_3[24u].z, fragment_uniform_buffer_3[24u].w), 0.0f, 1.0f);
				float fragment_unnamed_369;
				float fragment_unnamed_370;
				float fragment_unnamed_371;
				float fragment_unnamed_372;
				if (fragment_uniform_buffer_5[0u].x == 1.0f)
				{
					bool fragment_unnamed_278 = fragment_uniform_buffer_5[0u].y == 1.0f;
					precise float fragment_unnamed_286 = fragment_input_3.y * fragment_uniform_buffer_5[2u].x;
					precise float fragment_unnamed_287 = fragment_input_3.y * fragment_uniform_buffer_5[2u].y;
					precise float fragment_unnamed_288 = fragment_input_3.y * fragment_uniform_buffer_5[2u].z;
					precise float fragment_unnamed_315 = mad(fragment_uniform_buffer_5[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].x, fragment_input_3.x, fragment_unnamed_286)) + fragment_uniform_buffer_5[4u].x;
					precise float fragment_unnamed_316 = mad(fragment_uniform_buffer_5[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].y, fragment_input_3.x, fragment_unnamed_287)) + fragment_uniform_buffer_5[4u].y;
					precise float fragment_unnamed_317 = mad(fragment_uniform_buffer_5[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].z, fragment_input_3.x, fragment_unnamed_288)) + fragment_uniform_buffer_5[4u].z;
					precise float fragment_unnamed_331 = (-0.0f) - fragment_uniform_buffer_5[6u].x;
					precise float fragment_unnamed_333 = (-0.0f) - fragment_uniform_buffer_5[6u].y;
					precise float fragment_unnamed_335 = (-0.0f) - fragment_uniform_buffer_5[6u].z;
					precise float fragment_unnamed_336 = (fragment_unnamed_278 ? fragment_unnamed_315 : fragment_input_3.x) + fragment_unnamed_331;
					precise float fragment_unnamed_337 = (fragment_unnamed_278 ? fragment_unnamed_316 : fragment_input_3.y) + fragment_unnamed_333;
					precise float fragment_unnamed_338 = (fragment_unnamed_278 ? fragment_unnamed_317 : fragment_input_3.z) + fragment_unnamed_335;
					precise float fragment_unnamed_344 = fragment_unnamed_336 * fragment_uniform_buffer_5[5u].x;
					precise float fragment_unnamed_345 = fragment_unnamed_337 * fragment_uniform_buffer_5[5u].y;
					precise float fragment_unnamed_346 = fragment_unnamed_338 * fragment_uniform_buffer_5[5u].z;
					float4 fragment_unnamed_358 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_344, 0.25f, 0.75f), mad(fragment_uniform_buffer_5[0u].z, 0.5f, 0.75f)), fragment_unnamed_345, fragment_unnamed_346));
					fragment_unnamed_369 = fragment_unnamed_358.w;
					fragment_unnamed_370 = fragment_unnamed_358.z;
					fragment_unnamed_371 = fragment_unnamed_358.y;
					fragment_unnamed_372 = fragment_unnamed_358.x;
				}
				else
				{
					fragment_unnamed_369 = asfloat(1065353216u);
					fragment_unnamed_370 = asfloat(1065353216u);
					fragment_unnamed_371 = asfloat(1065353216u);
					fragment_unnamed_372 = asfloat(1065353216u);
				}
				float fragment_unnamed_568;
				if (fragment_unnamed_269 < 0.9900000095367431640625f)
				{
					precise float fragment_unnamed_394 = fragment_input_3.y * fragment_uniform_buffer_3[9u].x;
					precise float fragment_unnamed_395 = fragment_input_3.y * fragment_uniform_buffer_3[9u].y;
					precise float fragment_unnamed_396 = fragment_input_3.y * fragment_uniform_buffer_3[9u].z;
					precise float fragment_unnamed_397 = fragment_input_3.y * fragment_uniform_buffer_3[9u].w;
					precise float fragment_unnamed_429 = mad(fragment_uniform_buffer_3[10u].x, fragment_input_3.z, mad(fragment_uniform_buffer_3[8u].x, fragment_input_3.x, fragment_unnamed_394)) + fragment_uniform_buffer_3[11u].x;
					precise float fragment_unnamed_430 = mad(fragment_uniform_buffer_3[10u].y, fragment_input_3.z, mad(fragment_uniform_buffer_3[8u].y, fragment_input_3.x, fragment_unnamed_395)) + fragment_uniform_buffer_3[11u].y;
					precise float fragment_unnamed_431 = mad(fragment_uniform_buffer_3[10u].z, fragment_input_3.z, mad(fragment_uniform_buffer_3[8u].z, fragment_input_3.x, fragment_unnamed_396)) + fragment_uniform_buffer_3[11u].z;
					precise float fragment_unnamed_432 = mad(fragment_uniform_buffer_3[10u].w, fragment_input_3.z, mad(fragment_uniform_buffer_3[8u].w, fragment_input_3.x, fragment_unnamed_397)) + fragment_uniform_buffer_3[11u].w;
					precise float fragment_unnamed_433 = fragment_unnamed_429 / fragment_unnamed_432;
					precise float fragment_unnamed_434 = fragment_unnamed_430 / fragment_unnamed_432;
					precise float fragment_unnamed_435 = fragment_unnamed_431 / fragment_unnamed_432;
					float fragment_unnamed_442 = floor(mad(fragment_unnamed_433, fragment_uniform_buffer_0[8u].z, 0.5f));
					float fragment_unnamed_443 = floor(mad(fragment_unnamed_434, fragment_uniform_buffer_0[8u].w, 0.5f));
					precise float fragment_unnamed_448 = (-0.0f) - fragment_unnamed_442;
					precise float fragment_unnamed_449 = (-0.0f) - fragment_unnamed_443;
					float fragment_unnamed_450 = mad(fragment_unnamed_433, fragment_uniform_buffer_0[8u].z, fragment_unnamed_448);
					float fragment_unnamed_451 = mad(fragment_unnamed_434, fragment_uniform_buffer_0[8u].w, fragment_unnamed_449);
					precise float fragment_unnamed_452 = fragment_unnamed_450 + 0.5f;
					precise float fragment_unnamed_453 = fragment_unnamed_450 + 1.0f;
					precise float fragment_unnamed_454 = fragment_unnamed_451 + 0.5f;
					precise float fragment_unnamed_455 = fragment_unnamed_451 + 1.0f;
					precise float fragment_unnamed_456 = fragment_unnamed_452 * fragment_unnamed_452;
					precise float fragment_unnamed_457 = fragment_unnamed_454 * fragment_unnamed_454;
					precise float fragment_unnamed_458 = (-0.0f) - fragment_unnamed_450;
					precise float fragment_unnamed_459 = (-0.0f) - fragment_unnamed_451;
					precise float fragment_unnamed_462 = (-0.0f) - fragment_unnamed_450;
					precise float fragment_unnamed_463 = (-0.0f) - fragment_unnamed_451;
					precise float fragment_unnamed_464 = fragment_unnamed_462 + 1.0f;
					precise float fragment_unnamed_465 = fragment_unnamed_463 + 1.0f;
					float fragment_unnamed_466 = min(fragment_unnamed_450, 0.0f);
					float fragment_unnamed_467 = min(fragment_unnamed_451, 0.0f);
					precise float fragment_unnamed_468 = (-0.0f) - fragment_unnamed_466;
					precise float fragment_unnamed_469 = (-0.0f) - fragment_unnamed_467;
					float fragment_unnamed_472 = max(fragment_unnamed_450, 0.0f);
					float fragment_unnamed_473 = max(fragment_unnamed_451, 0.0f);
					precise float fragment_unnamed_474 = (-0.0f) - fragment_unnamed_472;
					precise float fragment_unnamed_475 = (-0.0f) - fragment_unnamed_473;
					precise float fragment_unnamed_478 = mad(fragment_unnamed_456, 0.5f, fragment_unnamed_458) * 0.44444000720977783203125f;
					precise float fragment_unnamed_480 = mad(fragment_unnamed_468, fragment_unnamed_466, fragment_unnamed_464) * 0.44444000720977783203125f;
					precise float fragment_unnamed_481 = mad(fragment_unnamed_474, fragment_unnamed_472, fragment_unnamed_453) * 0.44444000720977783203125f;
					precise float fragment_unnamed_482 = fragment_unnamed_456 * 0.222220003604888916015625f;
					precise float fragment_unnamed_484 = mad(fragment_unnamed_457, 0.5f, fragment_unnamed_459) * 0.44444000720977783203125f;
					precise float fragment_unnamed_485 = mad(fragment_unnamed_469, fragment_unnamed_467, fragment_unnamed_465) * 0.44444000720977783203125f;
					precise float fragment_unnamed_486 = mad(fragment_unnamed_475, fragment_unnamed_473, fragment_unnamed_455) * 0.44444000720977783203125f;
					precise float fragment_unnamed_487 = fragment_unnamed_457 * 0.222220003604888916015625f;
					precise float fragment_unnamed_488 = fragment_unnamed_480 + fragment_unnamed_478;
					precise float fragment_unnamed_489 = fragment_unnamed_482 + fragment_unnamed_481;
					precise float fragment_unnamed_490 = fragment_unnamed_480 + fragment_unnamed_478;
					precise float fragment_unnamed_491 = fragment_unnamed_482 + fragment_unnamed_481;
					precise float fragment_unnamed_492 = fragment_unnamed_485 + fragment_unnamed_484;
					precise float fragment_unnamed_493 = fragment_unnamed_485 + fragment_unnamed_484;
					precise float fragment_unnamed_494 = fragment_unnamed_487 + fragment_unnamed_486;
					precise float fragment_unnamed_495 = fragment_unnamed_487 + fragment_unnamed_486;
					precise float fragment_unnamed_496 = fragment_unnamed_480 / fragment_unnamed_490;
					precise float fragment_unnamed_497 = fragment_unnamed_482 / fragment_unnamed_491;
					precise float fragment_unnamed_498 = fragment_unnamed_496 + (-1.5f);
					precise float fragment_unnamed_500 = fragment_unnamed_497 + 0.5f;
					precise float fragment_unnamed_501 = fragment_unnamed_485 / fragment_unnamed_493;
					precise float fragment_unnamed_502 = fragment_unnamed_487 / fragment_unnamed_495;
					precise float fragment_unnamed_503 = fragment_unnamed_501 + (-1.5f);
					precise float fragment_unnamed_504 = fragment_unnamed_502 + 0.5f;
					precise float fragment_unnamed_508 = fragment_unnamed_498 * fragment_uniform_buffer_0[8u].x;
					precise float fragment_unnamed_509 = fragment_unnamed_500 * fragment_uniform_buffer_0[8u].x;
					precise float fragment_unnamed_513 = fragment_unnamed_503 * fragment_uniform_buffer_0[8u].y;
					precise float fragment_unnamed_514 = fragment_unnamed_504 * fragment_uniform_buffer_0[8u].y;
					precise float fragment_unnamed_515 = fragment_unnamed_488 * fragment_unnamed_492;
					precise float fragment_unnamed_516 = fragment_unnamed_489 * fragment_unnamed_493;
					precise float fragment_unnamed_517 = fragment_unnamed_490 * fragment_unnamed_494;
					precise float fragment_unnamed_518 = fragment_unnamed_491 * fragment_unnamed_495;
					precise float fragment_unnamed_538 = _ShadowMapTexture.SampleCmpLevelZero(sampler_ShadowMapTexture, float2(mad(fragment_unnamed_442, fragment_uniform_buffer_0[8u].x, fragment_unnamed_509), mad(fragment_unnamed_443, fragment_uniform_buffer_0[8u].y, fragment_unnamed_513)), fragment_unnamed_435).xxxx.x * fragment_unnamed_516;
					precise float fragment_unnamed_561 = (-0.0f) - fragment_uniform_buffer_3[24u].x;
					precise float fragment_unnamed_562 = fragment_unnamed_561 + 1.0f;
					fragment_unnamed_568 = mad(mad(fragment_unnamed_518, _ShadowMapTexture.SampleCmpLevelZero(sampler_ShadowMapTexture, float2(mad(fragment_unnamed_442, fragment_uniform_buffer_0[8u].x, fragment_unnamed_509), mad(fragment_unnamed_443, fragment_uniform_buffer_0[8u].y, fragment_unnamed_514)), fragment_unnamed_435).xxxx.x, mad(fragment_unnamed_517, _ShadowMapTexture.SampleCmpLevelZero(sampler_ShadowMapTexture, float2(mad(fragment_unnamed_442, fragment_uniform_buffer_0[8u].x, fragment_unnamed_508), mad(fragment_unnamed_443, fragment_uniform_buffer_0[8u].y, fragment_unnamed_514)), fragment_unnamed_435).xxxx.x, mad(fragment_unnamed_515, _ShadowMapTexture.SampleCmpLevelZero(sampler_ShadowMapTexture, float2(mad(fragment_unnamed_442, fragment_uniform_buffer_0[8u].x, fragment_unnamed_508), mad(fragment_unnamed_443, fragment_uniform_buffer_0[8u].y, fragment_unnamed_513)), fragment_unnamed_435).xxxx.x, fragment_unnamed_538))), fragment_unnamed_562, fragment_uniform_buffer_3[24u].x);
				}
				else
				{
					fragment_unnamed_568 = asfloat(1065353216u);
				}
				precise float fragment_unnamed_569 = (-0.0f) - fragment_unnamed_568;
				precise float fragment_unnamed_570 = fragment_unnamed_569 + clamp(dot(float4(fragment_unnamed_372, fragment_unnamed_371, fragment_unnamed_370, fragment_unnamed_369), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f);
				precise float fragment_unnamed_577 = fragment_unnamed_209 / fragment_unnamed_212;
				precise float fragment_unnamed_578 = fragment_unnamed_210 / fragment_unnamed_212;
				precise float fragment_unnamed_579 = fragment_unnamed_577 + 0.5f;
				precise float fragment_unnamed_580 = fragment_unnamed_578 + 0.5f;
				precise float fragment_unnamed_585 = asfloat(((0.0f < fragment_unnamed_211) ? 4294967295u : 0u) & 1065353216u) * _LightTexture0.Sample(sampler_LightTexture0, float2(fragment_unnamed_579, fragment_unnamed_580)).w;
				precise float fragment_unnamed_593 = fragment_unnamed_585 * _LightTextureB0.Sample(sampler_LightTextureB0, dot(float3(fragment_unnamed_209, fragment_unnamed_210, fragment_unnamed_211), float3(fragment_unnamed_209, fragment_unnamed_210, fragment_unnamed_211)).xx).x;
				precise float fragment_unnamed_594 = mad(fragment_unnamed_269, fragment_unnamed_570, fragment_unnamed_568) * fragment_unnamed_593;
				precise float fragment_unnamed_600 = fragment_unnamed_594 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_601 = fragment_unnamed_594 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_602 = fragment_unnamed_594 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_618 = rsqrt(dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z)));
				precise float fragment_unnamed_625 = fragment_unnamed_618 * fragment_input_2.x;
				precise float fragment_unnamed_626 = fragment_unnamed_618 * fragment_input_2.y;
				precise float fragment_unnamed_627 = fragment_unnamed_618 * fragment_input_2.z;
				float fragment_unnamed_642 = mad(fragment_uniform_buffer_0[13u].y, mad(fragment_unnamed_152, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_644 = mad(fragment_uniform_buffer_0[13u].y, mad(fragment_unnamed_153, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_645 = mad(fragment_uniform_buffer_0[13u].y, mad(fragment_unnamed_154, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_649 = (-0.0f) - fragment_uniform_buffer_0[13u].y;
				float fragment_unnamed_650 = mad(fragment_unnamed_649, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_652 = fragment_unnamed_650 * fragment_unnamed_161;
				precise float fragment_unnamed_653 = fragment_unnamed_650 * fragment_unnamed_162;
				precise float fragment_unnamed_654 = fragment_unnamed_650 * fragment_unnamed_163;
				precise float fragment_unnamed_658 = (-0.0f) - fragment_uniform_buffer_0[13u].x;
				precise float fragment_unnamed_659 = fragment_unnamed_658 + 1.0f;
				float fragment_unnamed_660 = mad(fragment_unnamed_98, fragment_unnamed_105, fragment_unnamed_131);
				float fragment_unnamed_661 = mad(fragment_unnamed_99, fragment_unnamed_105, fragment_unnamed_132);
				float fragment_unnamed_662 = mad(fragment_unnamed_100, fragment_unnamed_105, fragment_unnamed_133);
				float fragment_unnamed_668 = rsqrt(max(dot(float3(fragment_unnamed_660, fragment_unnamed_661, fragment_unnamed_662), float3(fragment_unnamed_660, fragment_unnamed_661, fragment_unnamed_662)), 0.001000000047497451305389404296875f));
				precise float fragment_unnamed_669 = fragment_unnamed_668 * fragment_unnamed_660;
				precise float fragment_unnamed_670 = fragment_unnamed_668 * fragment_unnamed_661;
				precise float fragment_unnamed_671 = fragment_unnamed_668 * fragment_unnamed_662;
				float fragment_unnamed_672 = dot(float3(fragment_unnamed_625, fragment_unnamed_626, fragment_unnamed_627), float3(fragment_unnamed_131, fragment_unnamed_132, fragment_unnamed_133));
				float fragment_unnamed_678 = clamp(dot(float3(fragment_unnamed_625, fragment_unnamed_626, fragment_unnamed_627), float3(fragment_unnamed_106, fragment_unnamed_107, fragment_unnamed_108)), 0.0f, 1.0f);
				float fragment_unnamed_682 = clamp(dot(float3(fragment_unnamed_625, fragment_unnamed_626, fragment_unnamed_627), float3(fragment_unnamed_669, fragment_unnamed_670, fragment_unnamed_671)), 0.0f, 1.0f);
				float fragment_unnamed_686 = clamp(dot(float3(fragment_unnamed_106, fragment_unnamed_107, fragment_unnamed_108), float3(fragment_unnamed_669, fragment_unnamed_670, fragment_unnamed_671)), 0.0f, 1.0f);
				precise float fragment_unnamed_687 = fragment_unnamed_686 * fragment_unnamed_686;
				precise float fragment_unnamed_691 = dot(fragment_unnamed_687.xx, fragment_unnamed_659.xx) + (-0.5f);
				precise float fragment_unnamed_693 = (-0.0f) - fragment_unnamed_678;
				precise float fragment_unnamed_694 = fragment_unnamed_693 + 1.0f;
				precise float fragment_unnamed_695 = fragment_unnamed_694 * fragment_unnamed_694;
				precise float fragment_unnamed_696 = fragment_unnamed_695 * fragment_unnamed_695;
				precise float fragment_unnamed_697 = fragment_unnamed_694 * fragment_unnamed_696;
				precise float fragment_unnamed_700 = (-0.0f) - abs(fragment_unnamed_672);
				precise float fragment_unnamed_701 = fragment_unnamed_700 + 1.0f;
				precise float fragment_unnamed_702 = fragment_unnamed_701 * fragment_unnamed_701;
				precise float fragment_unnamed_703 = fragment_unnamed_702 * fragment_unnamed_702;
				precise float fragment_unnamed_704 = fragment_unnamed_701 * fragment_unnamed_703;
				precise float fragment_unnamed_706 = mad(fragment_unnamed_691, fragment_unnamed_704, 1.0f) * mad(fragment_unnamed_691, fragment_unnamed_697, 1.0f);
				precise float fragment_unnamed_707 = fragment_unnamed_659 * fragment_unnamed_659;
				float fragment_unnamed_708 = max(fragment_unnamed_707, 0.00200000009499490261077880859375f);
				precise float fragment_unnamed_710 = (-0.0f) - fragment_unnamed_708;
				precise float fragment_unnamed_711 = fragment_unnamed_710 + 1.0f;
				precise float fragment_unnamed_716 = abs(fragment_unnamed_672) * mad(fragment_unnamed_678, fragment_unnamed_711, fragment_unnamed_708);
				precise float fragment_unnamed_718 = mad(fragment_unnamed_678, mad(abs(fragment_unnamed_672), fragment_unnamed_711, fragment_unnamed_708), fragment_unnamed_716) + 9.9999997473787516355514526367188e-06f;
				precise float fragment_unnamed_720 = 0.5f / fragment_unnamed_718;
				precise float fragment_unnamed_721 = fragment_unnamed_708 * fragment_unnamed_708;
				precise float fragment_unnamed_722 = (-0.0f) - fragment_unnamed_682;
				float fragment_unnamed_724 = mad(mad(fragment_unnamed_682, fragment_unnamed_721, fragment_unnamed_722), fragment_unnamed_682, 1.0f);
				precise float fragment_unnamed_725 = fragment_unnamed_721 * 0.3183098733425140380859375f;
				precise float fragment_unnamed_729 = fragment_unnamed_725 / mad(fragment_unnamed_724, fragment_unnamed_724, 1.0000000116860974230803549289703e-07f);
				precise float fragment_unnamed_730 = fragment_unnamed_729 * fragment_unnamed_720;
				precise float fragment_unnamed_731 = fragment_unnamed_730 * 3.1415927410125732421875f;
				precise float fragment_unnamed_736 = fragment_unnamed_678 * fragment_unnamed_706;
				precise float fragment_unnamed_737 = fragment_unnamed_678 * sqrt(max(fragment_unnamed_731, 9.9999997473787516355514526367188e-05f));
				precise float fragment_unnamed_745 = asfloat(((dot(float3(fragment_unnamed_642, fragment_unnamed_644, fragment_unnamed_645), float3(fragment_unnamed_642, fragment_unnamed_644, fragment_unnamed_645)) != 0.0f) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_737;
				precise float fragment_unnamed_746 = fragment_unnamed_736 * fragment_unnamed_600;
				precise float fragment_unnamed_747 = fragment_unnamed_736 * fragment_unnamed_601;
				precise float fragment_unnamed_748 = fragment_unnamed_736 * fragment_unnamed_602;
				precise float fragment_unnamed_749 = fragment_unnamed_600 * fragment_unnamed_745;
				precise float fragment_unnamed_750 = fragment_unnamed_601 * fragment_unnamed_745;
				precise float fragment_unnamed_751 = fragment_unnamed_602 * fragment_unnamed_745;
				precise float fragment_unnamed_752 = (-0.0f) - fragment_unnamed_686;
				precise float fragment_unnamed_753 = fragment_unnamed_752 + 1.0f;
				precise float fragment_unnamed_754 = fragment_unnamed_753 * fragment_unnamed_753;
				precise float fragment_unnamed_755 = fragment_unnamed_754 * fragment_unnamed_754;
				precise float fragment_unnamed_756 = fragment_unnamed_753 * fragment_unnamed_755;
				precise float fragment_unnamed_757 = (-0.0f) - fragment_unnamed_642;
				precise float fragment_unnamed_758 = (-0.0f) - fragment_unnamed_644;
				precise float fragment_unnamed_759 = (-0.0f) - fragment_unnamed_645;
				precise float fragment_unnamed_760 = fragment_unnamed_757 + 1.0f;
				precise float fragment_unnamed_761 = fragment_unnamed_758 + 1.0f;
				precise float fragment_unnamed_762 = fragment_unnamed_759 + 1.0f;
				precise float fragment_unnamed_766 = fragment_unnamed_749 * mad(fragment_unnamed_760, fragment_unnamed_756, fragment_unnamed_642);
				precise float fragment_unnamed_767 = fragment_unnamed_750 * mad(fragment_unnamed_761, fragment_unnamed_756, fragment_unnamed_644);
				precise float fragment_unnamed_768 = fragment_unnamed_751 * mad(fragment_unnamed_762, fragment_unnamed_756, fragment_unnamed_645);
				fragment_output_0.x = mad(fragment_unnamed_652, fragment_unnamed_746, fragment_unnamed_766);
				fragment_output_0.y = mad(fragment_unnamed_653, fragment_unnamed_747, fragment_unnamed_767);
				fragment_output_0.z = mad(fragment_unnamed_654, fragment_unnamed_748, fragment_unnamed_768);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[8] = float4(_ShadowMapTexture_TexelSize[0], _ShadowMapTexture_TexelSize[1], _ShadowMapTexture_TexelSize[2], _ShadowMapTexture_TexelSize[3]);

				fragment_uniform_buffer_0[9] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				fragment_uniform_buffer_0[10] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				fragment_uniform_buffer_0[11] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				fragment_uniform_buffer_0[12] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_uniform_buffer_0[13] = float4(_Glossiness, fragment_uniform_buffer_0[13][1], fragment_uniform_buffer_0[13][2], fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[13] = float4(fragment_uniform_buffer_0[13][0], _Metallic, fragment_uniform_buffer_0[13][2], fragment_uniform_buffer_0[13][3]);

				fragment_uniform_buffer_0[14] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_uniform_buffer_2[46] = float4(unity_OcclusionMaskSelector[0], unity_OcclusionMaskSelector[1], unity_OcclusionMaskSelector[2], unity_OcclusionMaskSelector[3]);

				fragment_uniform_buffer_3[8] = float4(unity_WorldToShadow[0][0][0], unity_WorldToShadow[0][1][0], unity_WorldToShadow[0][2][0], unity_WorldToShadow[0][3][0]);
				fragment_uniform_buffer_3[9] = float4(unity_WorldToShadow[0][0][1], unity_WorldToShadow[0][1][1], unity_WorldToShadow[0][2][1], unity_WorldToShadow[0][3][1]);
				fragment_uniform_buffer_3[10] = float4(unity_WorldToShadow[0][0][2], unity_WorldToShadow[0][1][2], unity_WorldToShadow[0][2][2], unity_WorldToShadow[0][3][2]);
				fragment_uniform_buffer_3[11] = float4(unity_WorldToShadow[0][0][3], unity_WorldToShadow[0][1][3], unity_WorldToShadow[0][2][3], unity_WorldToShadow[0][3][3]);
				fragment_uniform_buffer_3[12] = float4(unity_WorldToShadow[1][0][0], unity_WorldToShadow[1][1][0], unity_WorldToShadow[1][2][0], unity_WorldToShadow[1][3][0]);
				fragment_uniform_buffer_3[13] = float4(unity_WorldToShadow[1][0][1], unity_WorldToShadow[1][1][1], unity_WorldToShadow[1][2][1], unity_WorldToShadow[1][3][1]);
				fragment_uniform_buffer_3[14] = float4(unity_WorldToShadow[1][0][2], unity_WorldToShadow[1][1][2], unity_WorldToShadow[1][2][2], unity_WorldToShadow[1][3][2]);
				fragment_uniform_buffer_3[15] = float4(unity_WorldToShadow[1][0][3], unity_WorldToShadow[1][1][3], unity_WorldToShadow[1][2][3], unity_WorldToShadow[1][3][3]);
				fragment_uniform_buffer_3[16] = float4(unity_WorldToShadow[2][0][0], unity_WorldToShadow[2][1][0], unity_WorldToShadow[2][2][0], unity_WorldToShadow[2][3][0]);
				fragment_uniform_buffer_3[17] = float4(unity_WorldToShadow[2][0][1], unity_WorldToShadow[2][1][1], unity_WorldToShadow[2][2][1], unity_WorldToShadow[2][3][1]);
				fragment_uniform_buffer_3[18] = float4(unity_WorldToShadow[2][0][2], unity_WorldToShadow[2][1][2], unity_WorldToShadow[2][2][2], unity_WorldToShadow[2][3][2]);
				fragment_uniform_buffer_3[19] = float4(unity_WorldToShadow[2][0][3], unity_WorldToShadow[2][1][3], unity_WorldToShadow[2][2][3], unity_WorldToShadow[2][3][3]);
				fragment_uniform_buffer_3[20] = float4(unity_WorldToShadow[3][0][0], unity_WorldToShadow[3][1][0], unity_WorldToShadow[3][2][0], unity_WorldToShadow[3][3][0]);
				fragment_uniform_buffer_3[21] = float4(unity_WorldToShadow[3][0][1], unity_WorldToShadow[3][1][1], unity_WorldToShadow[3][2][1], unity_WorldToShadow[3][3][1]);
				fragment_uniform_buffer_3[22] = float4(unity_WorldToShadow[3][0][2], unity_WorldToShadow[3][1][2], unity_WorldToShadow[3][2][2], unity_WorldToShadow[3][3][2]);
				fragment_uniform_buffer_3[23] = float4(unity_WorldToShadow[3][0][3], unity_WorldToShadow[3][1][3], unity_WorldToShadow[3][2][3], unity_WorldToShadow[3][3][3]);

				fragment_uniform_buffer_3[24] = float4(_LightShadowData[0], _LightShadowData[1], _LightShadowData[2], _LightShadowData[3]);

				fragment_uniform_buffer_3[25] = float4(unity_ShadowFadeCenterAndType[0], unity_ShadowFadeCenterAndType[1], unity_ShadowFadeCenterAndType[2], unity_ShadowFadeCenterAndType[3]);

				fragment_uniform_buffer_4[9] = float4(unity_MatrixV[0][0], unity_MatrixV[1][0], unity_MatrixV[2][0], unity_MatrixV[3][0]);
				fragment_uniform_buffer_4[10] = float4(unity_MatrixV[0][1], unity_MatrixV[1][1], unity_MatrixV[2][1], unity_MatrixV[3][1]);
				fragment_uniform_buffer_4[11] = float4(unity_MatrixV[0][2], unity_MatrixV[1][2], unity_MatrixV[2][2], unity_MatrixV[3][2]);
				fragment_uniform_buffer_4[12] = float4(unity_MatrixV[0][3], unity_MatrixV[1][3], unity_MatrixV[2][3], unity_MatrixV[3][3]);

				fragment_uniform_buffer_5[0] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_5[1] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_5[2] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_5[3] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_5[4] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_5[5] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], fragment_uniform_buffer_5[5][3]);

				fragment_uniform_buffer_5[6] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], fragment_uniform_buffer_5[6][3]);

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

			#endif // defined(SHADOWS_DEPTH) && defined(SHADOWS_SOFT) && defined(SPOT) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_SCREEN) && !defined(SHADOWS_CUBE)


			#if defined(DIRECTIONAL) && defined(SHADOWS_SCREEN) && !defined(POINT) && !defined(SPOT) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_CUBE)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _MainTex_ST;
			float4 _ProjectionParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
			static float4 vertex_uniform_buffer_1[6];
			static float4 vertex_uniform_buffer_2[8];
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
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float4 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_60 = vertex_input_0.y * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_61 = vertex_input_0.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_62 = vertex_input_0.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_63 = vertex_input_0.y * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_86 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_0.x, vertex_unnamed_60));
				float vertex_unnamed_87 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_0.x, vertex_unnamed_61));
				float vertex_unnamed_88 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_0.x, vertex_unnamed_62));
				precise float vertex_unnamed_97 = vertex_unnamed_86 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_98 = vertex_unnamed_87 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_99 = vertex_unnamed_88 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_100 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_input_0.x, vertex_unnamed_63)) + vertex_uniform_buffer_2[3u].w;
				vertex_output_3.x = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_86);
				vertex_output_3.y = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_87);
				vertex_output_3.z = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_88);
				precise float vertex_unnamed_122 = vertex_unnamed_98 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_123 = vertex_unnamed_98 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_124 = vertex_unnamed_98 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_125 = vertex_unnamed_98 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_155 = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_100, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_99, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_97, vertex_unnamed_122)));
				float vertex_unnamed_156 = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_100, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_99, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_97, vertex_unnamed_123)));
				float vertex_unnamed_157 = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_100, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_99, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_97, vertex_unnamed_124)));
				float vertex_unnamed_158 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_100, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_99, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_97, vertex_unnamed_125)));
				gl_Position.x = vertex_unnamed_155;
				gl_Position.y = vertex_unnamed_156;
				gl_Position.z = vertex_unnamed_157;
				gl_Position.w = vertex_unnamed_158;
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[6u].x, vertex_uniform_buffer_0[6u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[6u].y, vertex_uniform_buffer_0[6u].w);
				float vertex_unnamed_191 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_206 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_220 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_226 = rsqrt(dot(float3(vertex_unnamed_191, vertex_unnamed_206, vertex_unnamed_220), float3(vertex_unnamed_191, vertex_unnamed_206, vertex_unnamed_220)));
				precise float vertex_unnamed_227 = vertex_unnamed_226 * vertex_unnamed_191;
				precise float vertex_unnamed_228 = vertex_unnamed_226 * vertex_unnamed_206;
				precise float vertex_unnamed_229 = vertex_unnamed_226 * vertex_unnamed_220;
				vertex_output_2.x = vertex_unnamed_227;
				vertex_output_2.y = vertex_unnamed_228;
				vertex_output_2.z = vertex_unnamed_229;
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				precise float vertex_unnamed_248 = vertex_unnamed_156 * vertex_uniform_buffer_1[5u].x;
				precise float vertex_unnamed_249 = vertex_unnamed_155 * 0.5f;
				precise float vertex_unnamed_251 = vertex_unnamed_158 * 0.5f;
				precise float vertex_unnamed_252 = vertex_unnamed_248 * 0.5f;
				vertex_output_5.z = vertex_unnamed_157;
				vertex_output_5.w = vertex_unnamed_158;
				precise float vertex_unnamed_255 = vertex_unnamed_251 + vertex_unnamed_249;
				precise float vertex_unnamed_256 = vertex_unnamed_251 + vertex_unnamed_252;
				vertex_output_5.x = vertex_unnamed_255;
				vertex_output_5.y = vertex_unnamed_256;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[5] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				return stage_output;
			}


			float4 _LightColor0;
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_OcclusionMaskSelector;
			float4 _LightShadowData;
			float4 unity_ShadowFadeCenterAndType;
			float4x4 unity_MatrixV;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[6];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[26];
			static float4 fragment_uniform_buffer_4[13];
			static float4 fragment_uniform_buffer_5[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _ShadowMapTexture;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_ShadowMapTexture;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float4 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_73 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_78 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_82 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_90 = fragment_unnamed_73 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_91 = fragment_unnamed_78 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_92 = fragment_unnamed_82 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_97 = rsqrt(dot(float3(fragment_unnamed_90, fragment_unnamed_91, fragment_unnamed_92), float3(fragment_unnamed_90, fragment_unnamed_91, fragment_unnamed_92)));
				precise float fragment_unnamed_98 = fragment_unnamed_97 * fragment_unnamed_90;
				precise float fragment_unnamed_99 = fragment_unnamed_97 * fragment_unnamed_91;
				precise float fragment_unnamed_100 = fragment_unnamed_97 * fragment_unnamed_92;
				float4 fragment_unnamed_108 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_118 = fragment_unnamed_108.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_119 = fragment_unnamed_108.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_120 = fragment_unnamed_108.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_127 = fragment_unnamed_118 * fragment_input_4.x;
				precise float fragment_unnamed_128 = fragment_unnamed_119 * fragment_input_4.y;
				precise float fragment_unnamed_129 = fragment_unnamed_120 * fragment_input_4.z;
				float fragment_unnamed_149 = dot(float3(fragment_unnamed_90, fragment_unnamed_91, fragment_unnamed_92), float3(asfloat(asuint(fragment_uniform_buffer_4[9u]).z), asfloat(asuint(fragment_uniform_buffer_4[10u]).z), asfloat(asuint(fragment_uniform_buffer_4[11u]).z)));
				precise float fragment_unnamed_162 = (-0.0f) - fragment_uniform_buffer_3[25u].x;
				precise float fragment_unnamed_164 = (-0.0f) - fragment_uniform_buffer_3[25u].y;
				precise float fragment_unnamed_166 = (-0.0f) - fragment_uniform_buffer_3[25u].z;
				precise float fragment_unnamed_167 = fragment_input_3.x + fragment_unnamed_162;
				precise float fragment_unnamed_168 = fragment_input_3.y + fragment_unnamed_164;
				precise float fragment_unnamed_169 = fragment_input_3.z + fragment_unnamed_166;
				precise float fragment_unnamed_174 = (-0.0f) - fragment_unnamed_149;
				precise float fragment_unnamed_175 = fragment_unnamed_174 + sqrt(dot(float3(fragment_unnamed_167, fragment_unnamed_168, fragment_unnamed_169), float3(fragment_unnamed_167, fragment_unnamed_168, fragment_unnamed_169)));
				float fragment_unnamed_288;
				float fragment_unnamed_289;
				float fragment_unnamed_290;
				float fragment_unnamed_291;
				if (fragment_uniform_buffer_5[0u].x == 1.0f)
				{
					bool fragment_unnamed_198 = fragment_uniform_buffer_5[0u].y == 1.0f;
					precise float fragment_unnamed_206 = fragment_input_3.y * fragment_uniform_buffer_5[2u].x;
					precise float fragment_unnamed_207 = fragment_input_3.y * fragment_uniform_buffer_5[2u].y;
					precise float fragment_unnamed_208 = fragment_input_3.y * fragment_uniform_buffer_5[2u].z;
					precise float fragment_unnamed_235 = mad(fragment_uniform_buffer_5[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].x, fragment_input_3.x, fragment_unnamed_206)) + fragment_uniform_buffer_5[4u].x;
					precise float fragment_unnamed_236 = mad(fragment_uniform_buffer_5[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].y, fragment_input_3.x, fragment_unnamed_207)) + fragment_uniform_buffer_5[4u].y;
					precise float fragment_unnamed_237 = mad(fragment_uniform_buffer_5[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].z, fragment_input_3.x, fragment_unnamed_208)) + fragment_uniform_buffer_5[4u].z;
					precise float fragment_unnamed_250 = (-0.0f) - fragment_uniform_buffer_5[6u].x;
					precise float fragment_unnamed_252 = (-0.0f) - fragment_uniform_buffer_5[6u].y;
					precise float fragment_unnamed_254 = (-0.0f) - fragment_uniform_buffer_5[6u].z;
					precise float fragment_unnamed_255 = (fragment_unnamed_198 ? fragment_unnamed_235 : fragment_input_3.x) + fragment_unnamed_250;
					precise float fragment_unnamed_256 = (fragment_unnamed_198 ? fragment_unnamed_236 : fragment_input_3.y) + fragment_unnamed_252;
					precise float fragment_unnamed_257 = (fragment_unnamed_198 ? fragment_unnamed_237 : fragment_input_3.z) + fragment_unnamed_254;
					precise float fragment_unnamed_263 = fragment_unnamed_255 * fragment_uniform_buffer_5[5u].x;
					precise float fragment_unnamed_264 = fragment_unnamed_256 * fragment_uniform_buffer_5[5u].y;
					precise float fragment_unnamed_265 = fragment_unnamed_257 * fragment_uniform_buffer_5[5u].z;
					float4 fragment_unnamed_277 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_263, 0.25f, 0.75f), mad(fragment_uniform_buffer_5[0u].z, 0.5f, 0.75f)), fragment_unnamed_264, fragment_unnamed_265));
					fragment_unnamed_288 = fragment_unnamed_277.x;
					fragment_unnamed_289 = fragment_unnamed_277.y;
					fragment_unnamed_290 = fragment_unnamed_277.z;
					fragment_unnamed_291 = fragment_unnamed_277.w;
				}
				else
				{
					fragment_unnamed_288 = asfloat(1065353216u);
					fragment_unnamed_289 = asfloat(1065353216u);
					fragment_unnamed_290 = asfloat(1065353216u);
					fragment_unnamed_291 = asfloat(1065353216u);
				}
				precise float fragment_unnamed_309 = fragment_input_5.x / fragment_input_5.w;
				precise float fragment_unnamed_310 = fragment_input_5.y / fragment_input_5.w;
				float4 fragment_unnamed_312 = _ShadowMapTexture.Sample(sampler_ShadowMapTexture, float2(fragment_unnamed_309, fragment_unnamed_310));
				float fragment_unnamed_314 = fragment_unnamed_312.x;
				precise float fragment_unnamed_315 = (-0.0f) - fragment_unnamed_314;
				precise float fragment_unnamed_316 = clamp(dot(float4(fragment_unnamed_288, fragment_unnamed_289, fragment_unnamed_290, fragment_unnamed_291), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f) + fragment_unnamed_315;
				float fragment_unnamed_317 = mad(clamp(mad(mad(fragment_uniform_buffer_3[25u].w, fragment_unnamed_175, fragment_unnamed_149), fragment_uniform_buffer_3[24u].z, fragment_uniform_buffer_3[24u].w), 0.0f, 1.0f), fragment_unnamed_316, fragment_unnamed_314);
				precise float fragment_unnamed_323 = fragment_unnamed_317 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_324 = fragment_unnamed_317 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_325 = fragment_unnamed_317 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_341 = rsqrt(dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z)));
				precise float fragment_unnamed_348 = fragment_unnamed_341 * fragment_input_2.x;
				precise float fragment_unnamed_349 = fragment_unnamed_341 * fragment_input_2.y;
				precise float fragment_unnamed_350 = fragment_unnamed_341 * fragment_input_2.z;
				float fragment_unnamed_364 = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_118, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_366 = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_119, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_367 = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_120, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_371 = (-0.0f) - fragment_uniform_buffer_0[4u].y;
				float fragment_unnamed_372 = mad(fragment_unnamed_371, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_374 = fragment_unnamed_372 * fragment_unnamed_127;
				precise float fragment_unnamed_375 = fragment_unnamed_372 * fragment_unnamed_128;
				precise float fragment_unnamed_376 = fragment_unnamed_372 * fragment_unnamed_129;
				precise float fragment_unnamed_380 = (-0.0f) - fragment_uniform_buffer_0[4u].x;
				precise float fragment_unnamed_381 = fragment_unnamed_380 + 1.0f;
				float fragment_unnamed_387 = mad(fragment_unnamed_90, fragment_unnamed_97, fragment_uniform_buffer_2[0u].x);
				float fragment_unnamed_388 = mad(fragment_unnamed_91, fragment_unnamed_97, fragment_uniform_buffer_2[0u].y);
				float fragment_unnamed_389 = mad(fragment_unnamed_92, fragment_unnamed_97, fragment_uniform_buffer_2[0u].z);
				float fragment_unnamed_395 = rsqrt(max(dot(float3(fragment_unnamed_387, fragment_unnamed_388, fragment_unnamed_389), float3(fragment_unnamed_387, fragment_unnamed_388, fragment_unnamed_389)), 0.001000000047497451305389404296875f));
				precise float fragment_unnamed_396 = fragment_unnamed_395 * fragment_unnamed_387;
				precise float fragment_unnamed_397 = fragment_unnamed_395 * fragment_unnamed_388;
				precise float fragment_unnamed_398 = fragment_unnamed_395 * fragment_unnamed_389;
				float fragment_unnamed_399 = dot(float3(fragment_unnamed_348, fragment_unnamed_349, fragment_unnamed_350), float3(fragment_unnamed_98, fragment_unnamed_99, fragment_unnamed_100));
				float fragment_unnamed_410 = clamp(dot(float3(fragment_unnamed_348, fragment_unnamed_349, fragment_unnamed_350), float3(fragment_uniform_buffer_2[0u].xyz)), 0.0f, 1.0f);
				float fragment_unnamed_414 = clamp(dot(float3(fragment_unnamed_348, fragment_unnamed_349, fragment_unnamed_350), float3(fragment_unnamed_396, fragment_unnamed_397, fragment_unnamed_398)), 0.0f, 1.0f);
				float fragment_unnamed_423 = clamp(dot(float3(fragment_uniform_buffer_2[0u].xyz), float3(fragment_unnamed_396, fragment_unnamed_397, fragment_unnamed_398)), 0.0f, 1.0f);
				precise float fragment_unnamed_424 = fragment_unnamed_423 * fragment_unnamed_423;
				precise float fragment_unnamed_428 = dot(fragment_unnamed_424.xx, fragment_unnamed_381.xx) + (-0.5f);
				precise float fragment_unnamed_430 = (-0.0f) - fragment_unnamed_410;
				precise float fragment_unnamed_431 = fragment_unnamed_430 + 1.0f;
				precise float fragment_unnamed_432 = fragment_unnamed_431 * fragment_unnamed_431;
				precise float fragment_unnamed_433 = fragment_unnamed_432 * fragment_unnamed_432;
				precise float fragment_unnamed_434 = fragment_unnamed_431 * fragment_unnamed_433;
				precise float fragment_unnamed_437 = (-0.0f) - abs(fragment_unnamed_399);
				precise float fragment_unnamed_438 = fragment_unnamed_437 + 1.0f;
				precise float fragment_unnamed_439 = fragment_unnamed_438 * fragment_unnamed_438;
				precise float fragment_unnamed_440 = fragment_unnamed_439 * fragment_unnamed_439;
				precise float fragment_unnamed_441 = fragment_unnamed_438 * fragment_unnamed_440;
				precise float fragment_unnamed_443 = mad(fragment_unnamed_428, fragment_unnamed_441, 1.0f) * mad(fragment_unnamed_428, fragment_unnamed_434, 1.0f);
				precise float fragment_unnamed_444 = fragment_unnamed_381 * fragment_unnamed_381;
				float fragment_unnamed_445 = max(fragment_unnamed_444, 0.00200000009499490261077880859375f);
				precise float fragment_unnamed_447 = (-0.0f) - fragment_unnamed_445;
				precise float fragment_unnamed_448 = fragment_unnamed_447 + 1.0f;
				precise float fragment_unnamed_453 = abs(fragment_unnamed_399) * mad(fragment_unnamed_410, fragment_unnamed_448, fragment_unnamed_445);
				precise float fragment_unnamed_455 = mad(fragment_unnamed_410, mad(abs(fragment_unnamed_399), fragment_unnamed_448, fragment_unnamed_445), fragment_unnamed_453) + 9.9999997473787516355514526367188e-06f;
				precise float fragment_unnamed_457 = 0.5f / fragment_unnamed_455;
				precise float fragment_unnamed_458 = fragment_unnamed_445 * fragment_unnamed_445;
				precise float fragment_unnamed_459 = (-0.0f) - fragment_unnamed_414;
				float fragment_unnamed_461 = mad(mad(fragment_unnamed_414, fragment_unnamed_458, fragment_unnamed_459), fragment_unnamed_414, 1.0f);
				precise float fragment_unnamed_462 = fragment_unnamed_458 * 0.3183098733425140380859375f;
				precise float fragment_unnamed_466 = fragment_unnamed_462 / mad(fragment_unnamed_461, fragment_unnamed_461, 1.0000000116860974230803549289703e-07f);
				precise float fragment_unnamed_467 = fragment_unnamed_466 * fragment_unnamed_457;
				precise float fragment_unnamed_468 = fragment_unnamed_467 * 3.1415927410125732421875f;
				precise float fragment_unnamed_473 = fragment_unnamed_410 * fragment_unnamed_443;
				precise float fragment_unnamed_474 = fragment_unnamed_410 * sqrt(max(fragment_unnamed_468, 9.9999997473787516355514526367188e-05f));
				precise float fragment_unnamed_483 = asfloat(((dot(float3(fragment_unnamed_364, fragment_unnamed_366, fragment_unnamed_367), float3(fragment_unnamed_364, fragment_unnamed_366, fragment_unnamed_367)) != 0.0f) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_474;
				precise float fragment_unnamed_484 = fragment_unnamed_473 * fragment_unnamed_323;
				precise float fragment_unnamed_485 = fragment_unnamed_473 * fragment_unnamed_324;
				precise float fragment_unnamed_486 = fragment_unnamed_473 * fragment_unnamed_325;
				precise float fragment_unnamed_487 = fragment_unnamed_323 * fragment_unnamed_483;
				precise float fragment_unnamed_488 = fragment_unnamed_324 * fragment_unnamed_483;
				precise float fragment_unnamed_489 = fragment_unnamed_325 * fragment_unnamed_483;
				precise float fragment_unnamed_490 = (-0.0f) - fragment_unnamed_423;
				precise float fragment_unnamed_491 = fragment_unnamed_490 + 1.0f;
				precise float fragment_unnamed_492 = fragment_unnamed_491 * fragment_unnamed_491;
				precise float fragment_unnamed_493 = fragment_unnamed_492 * fragment_unnamed_492;
				precise float fragment_unnamed_494 = fragment_unnamed_491 * fragment_unnamed_493;
				precise float fragment_unnamed_495 = (-0.0f) - fragment_unnamed_364;
				precise float fragment_unnamed_496 = (-0.0f) - fragment_unnamed_366;
				precise float fragment_unnamed_497 = (-0.0f) - fragment_unnamed_367;
				precise float fragment_unnamed_498 = fragment_unnamed_495 + 1.0f;
				precise float fragment_unnamed_499 = fragment_unnamed_496 + 1.0f;
				precise float fragment_unnamed_500 = fragment_unnamed_497 + 1.0f;
				precise float fragment_unnamed_504 = fragment_unnamed_487 * mad(fragment_unnamed_498, fragment_unnamed_494, fragment_unnamed_364);
				precise float fragment_unnamed_505 = fragment_unnamed_488 * mad(fragment_unnamed_499, fragment_unnamed_494, fragment_unnamed_366);
				precise float fragment_unnamed_506 = fragment_unnamed_489 * mad(fragment_unnamed_500, fragment_unnamed_494, fragment_unnamed_367);
				fragment_output_0.x = mad(fragment_unnamed_374, fragment_unnamed_484, fragment_unnamed_504);
				fragment_output_0.y = mad(fragment_unnamed_375, fragment_unnamed_485, fragment_unnamed_505);
				fragment_output_0.z = mad(fragment_unnamed_376, fragment_unnamed_486, fragment_unnamed_506);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[4] = float4(_Glossiness, fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _Metallic, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[5] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_uniform_buffer_2[46] = float4(unity_OcclusionMaskSelector[0], unity_OcclusionMaskSelector[1], unity_OcclusionMaskSelector[2], unity_OcclusionMaskSelector[3]);

				fragment_uniform_buffer_3[24] = float4(_LightShadowData[0], _LightShadowData[1], _LightShadowData[2], _LightShadowData[3]);

				fragment_uniform_buffer_3[25] = float4(unity_ShadowFadeCenterAndType[0], unity_ShadowFadeCenterAndType[1], unity_ShadowFadeCenterAndType[2], unity_ShadowFadeCenterAndType[3]);

				fragment_uniform_buffer_4[9] = float4(unity_MatrixV[0][0], unity_MatrixV[1][0], unity_MatrixV[2][0], unity_MatrixV[3][0]);
				fragment_uniform_buffer_4[10] = float4(unity_MatrixV[0][1], unity_MatrixV[1][1], unity_MatrixV[2][1], unity_MatrixV[3][1]);
				fragment_uniform_buffer_4[11] = float4(unity_MatrixV[0][2], unity_MatrixV[1][2], unity_MatrixV[2][2], unity_MatrixV[3][2]);
				fragment_uniform_buffer_4[12] = float4(unity_MatrixV[0][3], unity_MatrixV[1][3], unity_MatrixV[2][3], unity_MatrixV[3][3]);

				fragment_uniform_buffer_5[0] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_5[1] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_5[2] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_5[3] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_5[4] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_5[5] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], fragment_uniform_buffer_5[5][3]);

				fragment_uniform_buffer_5[6] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], fragment_uniform_buffer_5[6][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(DIRECTIONAL) && defined(SHADOWS_SCREEN) && !defined(POINT) && !defined(SPOT) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_CUBE)


			#if defined(DIRECTIONAL_COOKIE) && defined(SHADOWS_SCREEN) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(POINT_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_CUBE)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToLight;
			float4 _MainTex_ST;
			float4 _ProjectionParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[11];
			static float4 vertex_uniform_buffer_1[6];
			static float4 vertex_uniform_buffer_2[8];
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
			static float2 vertex_output_1;
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD3; // TEXCOORD_3
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float4 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_62 = vertex_input_0.y * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_63 = vertex_input_0.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_64 = vertex_input_0.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_65 = vertex_input_0.y * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_88 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_0.x, vertex_unnamed_62));
				float vertex_unnamed_89 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_0.x, vertex_unnamed_63));
				float vertex_unnamed_90 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_0.x, vertex_unnamed_64));
				float vertex_unnamed_91 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_input_0.x, vertex_unnamed_65));
				precise float vertex_unnamed_99 = vertex_unnamed_88 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_100 = vertex_unnamed_89 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_101 = vertex_unnamed_90 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_102 = vertex_unnamed_91 + vertex_uniform_buffer_2[3u].w;
				precise float vertex_unnamed_110 = vertex_unnamed_100 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_111 = vertex_unnamed_100 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_112 = vertex_unnamed_100 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_113 = vertex_unnamed_100 * vertex_uniform_buffer_3[18u].w;
				float vertex_unnamed_143 = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_102, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_101, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_99, vertex_unnamed_110)));
				float vertex_unnamed_144 = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_102, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_101, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_99, vertex_unnamed_111)));
				float vertex_unnamed_145 = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_102, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_101, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_99, vertex_unnamed_112)));
				float vertex_unnamed_146 = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_102, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_101, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_99, vertex_unnamed_113)));
				gl_Position.x = vertex_unnamed_143;
				gl_Position.y = vertex_unnamed_144;
				gl_Position.z = vertex_unnamed_145;
				gl_Position.w = vertex_unnamed_146;
				float vertex_unnamed_160 = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_88);
				float vertex_unnamed_161 = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_89);
				float vertex_unnamed_162 = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_90);
				float vertex_unnamed_163 = mad(vertex_uniform_buffer_2[3u].w, vertex_input_0.w, vertex_unnamed_91);
				vertex_output_3.x = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_88);
				vertex_output_3.y = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_89);
				vertex_output_3.z = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_90);
				precise float vertex_unnamed_182 = vertex_unnamed_161 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_183 = vertex_unnamed_161 * vertex_uniform_buffer_0[5u].y;
				vertex_output_1.x = mad(vertex_uniform_buffer_0[7u].x, vertex_unnamed_163, mad(vertex_uniform_buffer_0[6u].x, vertex_unnamed_162, mad(vertex_uniform_buffer_0[4u].x, vertex_unnamed_160, vertex_unnamed_182)));
				vertex_output_1.y = mad(vertex_uniform_buffer_0[7u].y, vertex_unnamed_163, mad(vertex_uniform_buffer_0[6u].y, vertex_unnamed_162, mad(vertex_uniform_buffer_0[4u].y, vertex_unnamed_160, vertex_unnamed_183)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[10u].x, vertex_uniform_buffer_0[10u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[10u].y, vertex_uniform_buffer_0[10u].w);
				float vertex_unnamed_233 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_247 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_261 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_267 = rsqrt(dot(float3(vertex_unnamed_233, vertex_unnamed_247, vertex_unnamed_261), float3(vertex_unnamed_233, vertex_unnamed_247, vertex_unnamed_261)));
				precise float vertex_unnamed_268 = vertex_unnamed_267 * vertex_unnamed_233;
				precise float vertex_unnamed_269 = vertex_unnamed_267 * vertex_unnamed_247;
				precise float vertex_unnamed_270 = vertex_unnamed_267 * vertex_unnamed_261;
				vertex_output_2.x = vertex_unnamed_268;
				vertex_output_2.y = vertex_unnamed_269;
				vertex_output_2.z = vertex_unnamed_270;
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				precise float vertex_unnamed_289 = vertex_unnamed_144 * vertex_uniform_buffer_1[5u].x;
				precise float vertex_unnamed_290 = vertex_unnamed_289 * 0.5f;
				precise float vertex_unnamed_292 = vertex_unnamed_143 * 0.5f;
				precise float vertex_unnamed_293 = vertex_unnamed_146 * 0.5f;
				vertex_output_5.z = vertex_unnamed_145;
				vertex_output_5.w = vertex_unnamed_146;
				precise float vertex_unnamed_296 = vertex_unnamed_293 + vertex_unnamed_292;
				precise float vertex_unnamed_297 = vertex_unnamed_293 + vertex_unnamed_290;
				vertex_output_5.x = vertex_unnamed_296;
				vertex_output_5.y = vertex_unnamed_297;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				vertex_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				vertex_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				vertex_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				vertex_uniform_buffer_0[10] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[5] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

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
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				return stage_output;
			}


			float4 _LightColor0;
			float4x4 unity_WorldToLight;
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 unity_OcclusionMaskSelector;
			float4 _LightShadowData;
			float4 unity_ShadowFadeCenterAndType;
			float4x4 unity_MatrixV;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[10];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[26];
			static float4 fragment_uniform_buffer_4[13];
			static float4 fragment_uniform_buffer_5[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _ShadowMapTexture;
			Texture2D<float4> _LightTexture0;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_ShadowMapTexture;
			SamplerState sampler_LightTexture0;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD3; // TEXCOORD_3
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float4 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_78 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_83 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_87 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_95 = fragment_unnamed_78 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_96 = fragment_unnamed_83 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_97 = fragment_unnamed_87 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_102 = rsqrt(dot(float3(fragment_unnamed_95, fragment_unnamed_96, fragment_unnamed_97), float3(fragment_unnamed_95, fragment_unnamed_96, fragment_unnamed_97)));
				precise float fragment_unnamed_103 = fragment_unnamed_102 * fragment_unnamed_95;
				precise float fragment_unnamed_104 = fragment_unnamed_102 * fragment_unnamed_96;
				precise float fragment_unnamed_105 = fragment_unnamed_102 * fragment_unnamed_97;
				float4 fragment_unnamed_113 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_124 = fragment_unnamed_113.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_125 = fragment_unnamed_113.y * fragment_uniform_buffer_0[9u].y;
				precise float fragment_unnamed_126 = fragment_unnamed_113.z * fragment_uniform_buffer_0[9u].z;
				precise float fragment_unnamed_133 = fragment_unnamed_124 * fragment_input_4.x;
				precise float fragment_unnamed_134 = fragment_unnamed_125 * fragment_input_4.y;
				precise float fragment_unnamed_135 = fragment_unnamed_126 * fragment_input_4.z;
				precise float fragment_unnamed_142 = fragment_input_3.y * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_143 = fragment_input_3.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_165 = mad(fragment_uniform_buffer_0[6u].x, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].x, fragment_input_3.x, fragment_unnamed_142)) + fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_166 = mad(fragment_uniform_buffer_0[6u].y, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].y, fragment_input_3.x, fragment_unnamed_143)) + fragment_uniform_buffer_0[7u].y;
				float fragment_unnamed_184 = dot(float3(fragment_unnamed_95, fragment_unnamed_96, fragment_unnamed_97), float3(asfloat(asuint(fragment_uniform_buffer_4[9u]).z), asfloat(asuint(fragment_uniform_buffer_4[10u]).z), asfloat(asuint(fragment_uniform_buffer_4[11u]).z)));
				precise float fragment_unnamed_197 = (-0.0f) - fragment_uniform_buffer_3[25u].x;
				precise float fragment_unnamed_199 = (-0.0f) - fragment_uniform_buffer_3[25u].y;
				precise float fragment_unnamed_201 = (-0.0f) - fragment_uniform_buffer_3[25u].z;
				precise float fragment_unnamed_202 = fragment_input_3.x + fragment_unnamed_197;
				precise float fragment_unnamed_203 = fragment_input_3.y + fragment_unnamed_199;
				precise float fragment_unnamed_204 = fragment_input_3.z + fragment_unnamed_201;
				precise float fragment_unnamed_209 = (-0.0f) - fragment_unnamed_184;
				precise float fragment_unnamed_210 = fragment_unnamed_209 + sqrt(dot(float3(fragment_unnamed_202, fragment_unnamed_203, fragment_unnamed_204), float3(fragment_unnamed_202, fragment_unnamed_203, fragment_unnamed_204)));
				float fragment_unnamed_323;
				float fragment_unnamed_324;
				float fragment_unnamed_325;
				float fragment_unnamed_326;
				if (fragment_uniform_buffer_5[0u].x == 1.0f)
				{
					bool fragment_unnamed_233 = fragment_uniform_buffer_5[0u].y == 1.0f;
					precise float fragment_unnamed_241 = fragment_input_3.y * fragment_uniform_buffer_5[2u].x;
					precise float fragment_unnamed_242 = fragment_input_3.y * fragment_uniform_buffer_5[2u].y;
					precise float fragment_unnamed_243 = fragment_input_3.y * fragment_uniform_buffer_5[2u].z;
					precise float fragment_unnamed_270 = mad(fragment_uniform_buffer_5[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].x, fragment_input_3.x, fragment_unnamed_241)) + fragment_uniform_buffer_5[4u].x;
					precise float fragment_unnamed_271 = mad(fragment_uniform_buffer_5[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].y, fragment_input_3.x, fragment_unnamed_242)) + fragment_uniform_buffer_5[4u].y;
					precise float fragment_unnamed_272 = mad(fragment_uniform_buffer_5[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].z, fragment_input_3.x, fragment_unnamed_243)) + fragment_uniform_buffer_5[4u].z;
					precise float fragment_unnamed_285 = (-0.0f) - fragment_uniform_buffer_5[6u].x;
					precise float fragment_unnamed_287 = (-0.0f) - fragment_uniform_buffer_5[6u].y;
					precise float fragment_unnamed_289 = (-0.0f) - fragment_uniform_buffer_5[6u].z;
					precise float fragment_unnamed_290 = (fragment_unnamed_233 ? fragment_unnamed_270 : fragment_input_3.x) + fragment_unnamed_285;
					precise float fragment_unnamed_291 = (fragment_unnamed_233 ? fragment_unnamed_271 : fragment_input_3.y) + fragment_unnamed_287;
					precise float fragment_unnamed_292 = (fragment_unnamed_233 ? fragment_unnamed_272 : fragment_input_3.z) + fragment_unnamed_289;
					precise float fragment_unnamed_298 = fragment_unnamed_290 * fragment_uniform_buffer_5[5u].x;
					precise float fragment_unnamed_299 = fragment_unnamed_291 * fragment_uniform_buffer_5[5u].y;
					precise float fragment_unnamed_300 = fragment_unnamed_292 * fragment_uniform_buffer_5[5u].z;
					float4 fragment_unnamed_312 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_298, 0.25f, 0.75f), mad(fragment_uniform_buffer_5[0u].z, 0.5f, 0.75f)), fragment_unnamed_299, fragment_unnamed_300));
					fragment_unnamed_323 = fragment_unnamed_312.x;
					fragment_unnamed_324 = fragment_unnamed_312.y;
					fragment_unnamed_325 = fragment_unnamed_312.z;
					fragment_unnamed_326 = fragment_unnamed_312.w;
				}
				else
				{
					fragment_unnamed_323 = asfloat(1065353216u);
					fragment_unnamed_324 = asfloat(1065353216u);
					fragment_unnamed_325 = asfloat(1065353216u);
					fragment_unnamed_326 = asfloat(1065353216u);
				}
				precise float fragment_unnamed_344 = fragment_input_5.x / fragment_input_5.w;
				precise float fragment_unnamed_345 = fragment_input_5.y / fragment_input_5.w;
				float4 fragment_unnamed_347 = _ShadowMapTexture.Sample(sampler_ShadowMapTexture, float2(fragment_unnamed_344, fragment_unnamed_345));
				float fragment_unnamed_349 = fragment_unnamed_347.x;
				precise float fragment_unnamed_350 = (-0.0f) - fragment_unnamed_349;
				precise float fragment_unnamed_351 = clamp(dot(float4(fragment_unnamed_323, fragment_unnamed_324, fragment_unnamed_325, fragment_unnamed_326), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f) + fragment_unnamed_350;
				precise float fragment_unnamed_357 = mad(clamp(mad(mad(fragment_uniform_buffer_3[25u].w, fragment_unnamed_210, fragment_unnamed_184), fragment_uniform_buffer_3[24u].z, fragment_uniform_buffer_3[24u].w), 0.0f, 1.0f), fragment_unnamed_351, fragment_unnamed_349) * _LightTexture0.Sample(sampler_LightTexture0, float2(fragment_unnamed_165, fragment_unnamed_166)).w;
				precise float fragment_unnamed_363 = fragment_unnamed_357 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_364 = fragment_unnamed_357 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_365 = fragment_unnamed_357 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_381 = rsqrt(dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z)));
				precise float fragment_unnamed_388 = fragment_unnamed_381 * fragment_input_2.x;
				precise float fragment_unnamed_389 = fragment_unnamed_381 * fragment_input_2.y;
				precise float fragment_unnamed_390 = fragment_unnamed_381 * fragment_input_2.z;
				float fragment_unnamed_405 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_124, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_407 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_125, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_408 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_126, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_412 = (-0.0f) - fragment_uniform_buffer_0[8u].y;
				float fragment_unnamed_413 = mad(fragment_unnamed_412, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_415 = fragment_unnamed_413 * fragment_unnamed_133;
				precise float fragment_unnamed_416 = fragment_unnamed_413 * fragment_unnamed_134;
				precise float fragment_unnamed_417 = fragment_unnamed_413 * fragment_unnamed_135;
				precise float fragment_unnamed_421 = (-0.0f) - fragment_uniform_buffer_0[8u].x;
				precise float fragment_unnamed_422 = fragment_unnamed_421 + 1.0f;
				float fragment_unnamed_428 = mad(fragment_unnamed_95, fragment_unnamed_102, fragment_uniform_buffer_2[0u].x);
				float fragment_unnamed_429 = mad(fragment_unnamed_96, fragment_unnamed_102, fragment_uniform_buffer_2[0u].y);
				float fragment_unnamed_430 = mad(fragment_unnamed_97, fragment_unnamed_102, fragment_uniform_buffer_2[0u].z);
				float fragment_unnamed_436 = rsqrt(max(dot(float3(fragment_unnamed_428, fragment_unnamed_429, fragment_unnamed_430), float3(fragment_unnamed_428, fragment_unnamed_429, fragment_unnamed_430)), 0.001000000047497451305389404296875f));
				precise float fragment_unnamed_437 = fragment_unnamed_436 * fragment_unnamed_428;
				precise float fragment_unnamed_438 = fragment_unnamed_436 * fragment_unnamed_429;
				precise float fragment_unnamed_439 = fragment_unnamed_436 * fragment_unnamed_430;
				float fragment_unnamed_440 = dot(float3(fragment_unnamed_388, fragment_unnamed_389, fragment_unnamed_390), float3(fragment_unnamed_103, fragment_unnamed_104, fragment_unnamed_105));
				float fragment_unnamed_451 = clamp(dot(float3(fragment_unnamed_388, fragment_unnamed_389, fragment_unnamed_390), float3(fragment_uniform_buffer_2[0u].xyz)), 0.0f, 1.0f);
				float fragment_unnamed_455 = clamp(dot(float3(fragment_unnamed_388, fragment_unnamed_389, fragment_unnamed_390), float3(fragment_unnamed_437, fragment_unnamed_438, fragment_unnamed_439)), 0.0f, 1.0f);
				float fragment_unnamed_464 = clamp(dot(float3(fragment_uniform_buffer_2[0u].xyz), float3(fragment_unnamed_437, fragment_unnamed_438, fragment_unnamed_439)), 0.0f, 1.0f);
				precise float fragment_unnamed_465 = fragment_unnamed_464 * fragment_unnamed_464;
				precise float fragment_unnamed_469 = dot(fragment_unnamed_465.xx, fragment_unnamed_422.xx) + (-0.5f);
				precise float fragment_unnamed_471 = (-0.0f) - fragment_unnamed_451;
				precise float fragment_unnamed_472 = fragment_unnamed_471 + 1.0f;
				precise float fragment_unnamed_473 = fragment_unnamed_472 * fragment_unnamed_472;
				precise float fragment_unnamed_474 = fragment_unnamed_473 * fragment_unnamed_473;
				precise float fragment_unnamed_475 = fragment_unnamed_472 * fragment_unnamed_474;
				precise float fragment_unnamed_478 = (-0.0f) - abs(fragment_unnamed_440);
				precise float fragment_unnamed_479 = fragment_unnamed_478 + 1.0f;
				precise float fragment_unnamed_480 = fragment_unnamed_479 * fragment_unnamed_479;
				precise float fragment_unnamed_481 = fragment_unnamed_480 * fragment_unnamed_480;
				precise float fragment_unnamed_482 = fragment_unnamed_479 * fragment_unnamed_481;
				precise float fragment_unnamed_484 = mad(fragment_unnamed_469, fragment_unnamed_482, 1.0f) * mad(fragment_unnamed_469, fragment_unnamed_475, 1.0f);
				precise float fragment_unnamed_485 = fragment_unnamed_422 * fragment_unnamed_422;
				float fragment_unnamed_486 = max(fragment_unnamed_485, 0.00200000009499490261077880859375f);
				precise float fragment_unnamed_488 = (-0.0f) - fragment_unnamed_486;
				precise float fragment_unnamed_489 = fragment_unnamed_488 + 1.0f;
				precise float fragment_unnamed_494 = abs(fragment_unnamed_440) * mad(fragment_unnamed_451, fragment_unnamed_489, fragment_unnamed_486);
				precise float fragment_unnamed_496 = mad(fragment_unnamed_451, mad(abs(fragment_unnamed_440), fragment_unnamed_489, fragment_unnamed_486), fragment_unnamed_494) + 9.9999997473787516355514526367188e-06f;
				precise float fragment_unnamed_498 = 0.5f / fragment_unnamed_496;
				precise float fragment_unnamed_499 = fragment_unnamed_486 * fragment_unnamed_486;
				precise float fragment_unnamed_500 = (-0.0f) - fragment_unnamed_455;
				float fragment_unnamed_502 = mad(mad(fragment_unnamed_455, fragment_unnamed_499, fragment_unnamed_500), fragment_unnamed_455, 1.0f);
				precise float fragment_unnamed_503 = fragment_unnamed_499 * 0.3183098733425140380859375f;
				precise float fragment_unnamed_507 = fragment_unnamed_503 / mad(fragment_unnamed_502, fragment_unnamed_502, 1.0000000116860974230803549289703e-07f);
				precise float fragment_unnamed_508 = fragment_unnamed_507 * fragment_unnamed_498;
				precise float fragment_unnamed_509 = fragment_unnamed_508 * 3.1415927410125732421875f;
				precise float fragment_unnamed_514 = fragment_unnamed_451 * fragment_unnamed_484;
				precise float fragment_unnamed_515 = fragment_unnamed_451 * sqrt(max(fragment_unnamed_509, 9.9999997473787516355514526367188e-05f));
				precise float fragment_unnamed_524 = asfloat(((dot(float3(fragment_unnamed_405, fragment_unnamed_407, fragment_unnamed_408), float3(fragment_unnamed_405, fragment_unnamed_407, fragment_unnamed_408)) != 0.0f) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_515;
				precise float fragment_unnamed_525 = fragment_unnamed_514 * fragment_unnamed_363;
				precise float fragment_unnamed_526 = fragment_unnamed_514 * fragment_unnamed_364;
				precise float fragment_unnamed_527 = fragment_unnamed_514 * fragment_unnamed_365;
				precise float fragment_unnamed_528 = fragment_unnamed_363 * fragment_unnamed_524;
				precise float fragment_unnamed_529 = fragment_unnamed_364 * fragment_unnamed_524;
				precise float fragment_unnamed_530 = fragment_unnamed_365 * fragment_unnamed_524;
				precise float fragment_unnamed_531 = (-0.0f) - fragment_unnamed_464;
				precise float fragment_unnamed_532 = fragment_unnamed_531 + 1.0f;
				precise float fragment_unnamed_533 = fragment_unnamed_532 * fragment_unnamed_532;
				precise float fragment_unnamed_534 = fragment_unnamed_533 * fragment_unnamed_533;
				precise float fragment_unnamed_535 = fragment_unnamed_532 * fragment_unnamed_534;
				precise float fragment_unnamed_536 = (-0.0f) - fragment_unnamed_405;
				precise float fragment_unnamed_537 = (-0.0f) - fragment_unnamed_407;
				precise float fragment_unnamed_538 = (-0.0f) - fragment_unnamed_408;
				precise float fragment_unnamed_539 = fragment_unnamed_536 + 1.0f;
				precise float fragment_unnamed_540 = fragment_unnamed_537 + 1.0f;
				precise float fragment_unnamed_541 = fragment_unnamed_538 + 1.0f;
				precise float fragment_unnamed_545 = fragment_unnamed_528 * mad(fragment_unnamed_539, fragment_unnamed_535, fragment_unnamed_405);
				precise float fragment_unnamed_546 = fragment_unnamed_529 * mad(fragment_unnamed_540, fragment_unnamed_535, fragment_unnamed_407);
				precise float fragment_unnamed_547 = fragment_unnamed_530 * mad(fragment_unnamed_541, fragment_unnamed_535, fragment_unnamed_408);
				fragment_output_0.x = mad(fragment_unnamed_415, fragment_unnamed_525, fragment_unnamed_545);
				fragment_output_0.y = mad(fragment_unnamed_416, fragment_unnamed_526, fragment_unnamed_546);
				fragment_output_0.z = mad(fragment_unnamed_417, fragment_unnamed_527, fragment_unnamed_547);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				fragment_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				fragment_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				fragment_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_uniform_buffer_0[8] = float4(_Glossiness, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _Metallic, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[9] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_uniform_buffer_2[46] = float4(unity_OcclusionMaskSelector[0], unity_OcclusionMaskSelector[1], unity_OcclusionMaskSelector[2], unity_OcclusionMaskSelector[3]);

				fragment_uniform_buffer_3[24] = float4(_LightShadowData[0], _LightShadowData[1], _LightShadowData[2], _LightShadowData[3]);

				fragment_uniform_buffer_3[25] = float4(unity_ShadowFadeCenterAndType[0], unity_ShadowFadeCenterAndType[1], unity_ShadowFadeCenterAndType[2], unity_ShadowFadeCenterAndType[3]);

				fragment_uniform_buffer_4[9] = float4(unity_MatrixV[0][0], unity_MatrixV[1][0], unity_MatrixV[2][0], unity_MatrixV[3][0]);
				fragment_uniform_buffer_4[10] = float4(unity_MatrixV[0][1], unity_MatrixV[1][1], unity_MatrixV[2][1], unity_MatrixV[3][1]);
				fragment_uniform_buffer_4[11] = float4(unity_MatrixV[0][2], unity_MatrixV[1][2], unity_MatrixV[2][2], unity_MatrixV[3][2]);
				fragment_uniform_buffer_4[12] = float4(unity_MatrixV[0][3], unity_MatrixV[1][3], unity_MatrixV[2][3], unity_MatrixV[3][3]);

				fragment_uniform_buffer_5[0] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_5[1] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_5[2] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_5[3] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_5[4] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_5[5] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], fragment_uniform_buffer_5[5][3]);

				fragment_uniform_buffer_5[6] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], fragment_uniform_buffer_5[6][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(DIRECTIONAL_COOKIE) && defined(SHADOWS_SCREEN) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(POINT_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_CUBE)


			#if defined(POINT) && defined(SHADOWS_CUBE) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_SCREEN)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToLight;
			float4 _MainTex_ST;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[11];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static float4 vertex_output_6;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float3 vertex_output_5 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_6 : TEXCOORD4; // TEXCOORD_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_59 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_60 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_57));
				float vertex_unnamed_84 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_58));
				float vertex_unnamed_85 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_59));
				float vertex_unnamed_86 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_60));
				precise float vertex_unnamed_94 = vertex_unnamed_83 + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_95 = vertex_unnamed_84 + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_96 = vertex_unnamed_85 + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_97 = vertex_unnamed_86 + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_105 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_106 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_107 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_108 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_94, vertex_unnamed_105)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_94, vertex_unnamed_106)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_94, vertex_unnamed_107)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_94, vertex_unnamed_108)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[10u].x, vertex_uniform_buffer_0[10u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[10u].y, vertex_uniform_buffer_0[10u].w);
				float vertex_unnamed_176 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_191 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_206 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_212 = rsqrt(dot(float3(vertex_unnamed_176, vertex_unnamed_191, vertex_unnamed_206), float3(vertex_unnamed_176, vertex_unnamed_191, vertex_unnamed_206)));
				precise float vertex_unnamed_213 = vertex_unnamed_212 * vertex_unnamed_176;
				precise float vertex_unnamed_214 = vertex_unnamed_212 * vertex_unnamed_191;
				precise float vertex_unnamed_215 = vertex_unnamed_212 * vertex_unnamed_206;
				vertex_output_2.x = vertex_unnamed_213;
				vertex_output_2.y = vertex_unnamed_214;
				vertex_output_2.z = vertex_unnamed_215;
				vertex_output_3.x = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				vertex_output_3.y = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				vertex_output_3.z = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				float vertex_unnamed_240 = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				float vertex_unnamed_241 = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				float vertex_unnamed_242 = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				float vertex_unnamed_243 = mad(vertex_uniform_buffer_1[3u].w, vertex_input_0.w, vertex_unnamed_86);
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				precise float vertex_unnamed_261 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_262 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].y;
				precise float vertex_unnamed_263 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].z;
				vertex_output_5.x = mad(vertex_uniform_buffer_0[7u].x, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].x, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].x, vertex_unnamed_240, vertex_unnamed_261)));
				vertex_output_5.y = mad(vertex_uniform_buffer_0[7u].y, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].y, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].y, vertex_unnamed_240, vertex_unnamed_262)));
				vertex_output_5.z = mad(vertex_uniform_buffer_0[7u].z, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].z, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].z, vertex_unnamed_240, vertex_unnamed_263)));
				vertex_output_6.x = 0.0f;
				vertex_output_6.y = 0.0f;
				vertex_output_6.z = 0.0f;
				vertex_output_6.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				vertex_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				vertex_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				vertex_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				vertex_uniform_buffer_0[10] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_2[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_2[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_2[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}


			float4 _LightColor0;
			float4x4 unity_WorldToLight;
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 _LightPositionRange;
			float4 _LightProjectionParams;
			float4 unity_OcclusionMaskSelector;
			float4 _LightShadowData;
			float4 unity_ShadowFadeCenterAndType;
			float4x4 unity_MatrixV;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[10];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[26];
			static float4 fragment_uniform_buffer_4[13];
			static float4 fragment_uniform_buffer_5[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _LightTexture0;
			Texture3D<float4> unity_ProbeVolumeSH;
			TextureCube<float4> _ShadowMapTexture;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerComparisonState sampler_ShadowMapTexture;
			SamplerState sampler_LightTexture0;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float3 fragment_input_5 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_6 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_80 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_85 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_89 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_96 = fragment_unnamed_80 + fragment_uniform_buffer_2[0u].x;
				precise float fragment_unnamed_97 = fragment_unnamed_85 + fragment_uniform_buffer_2[0u].y;
				precise float fragment_unnamed_98 = fragment_unnamed_89 + fragment_uniform_buffer_2[0u].z;
				float fragment_unnamed_103 = rsqrt(dot(float3(fragment_unnamed_96, fragment_unnamed_97, fragment_unnamed_98), float3(fragment_unnamed_96, fragment_unnamed_97, fragment_unnamed_98)));
				precise float fragment_unnamed_104 = fragment_unnamed_103 * fragment_unnamed_96;
				precise float fragment_unnamed_105 = fragment_unnamed_103 * fragment_unnamed_97;
				precise float fragment_unnamed_106 = fragment_unnamed_103 * fragment_unnamed_98;
				precise float fragment_unnamed_109 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_112 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_115 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_122 = fragment_unnamed_109 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_123 = fragment_unnamed_112 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_124 = fragment_unnamed_115 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_128 = rsqrt(dot(float3(fragment_unnamed_122, fragment_unnamed_123, fragment_unnamed_124), float3(fragment_unnamed_122, fragment_unnamed_123, fragment_unnamed_124)));
				precise float fragment_unnamed_129 = fragment_unnamed_128 * fragment_unnamed_122;
				precise float fragment_unnamed_130 = fragment_unnamed_128 * fragment_unnamed_123;
				precise float fragment_unnamed_131 = fragment_unnamed_128 * fragment_unnamed_124;
				float4 fragment_unnamed_139 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_150 = fragment_unnamed_139.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_151 = fragment_unnamed_139.y * fragment_uniform_buffer_0[9u].y;
				precise float fragment_unnamed_152 = fragment_unnamed_139.z * fragment_uniform_buffer_0[9u].z;
				precise float fragment_unnamed_159 = fragment_unnamed_150 * fragment_input_4.x;
				precise float fragment_unnamed_160 = fragment_unnamed_151 * fragment_input_4.y;
				precise float fragment_unnamed_161 = fragment_unnamed_152 * fragment_input_4.z;
				precise float fragment_unnamed_169 = fragment_input_3.y * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_170 = fragment_input_3.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_171 = fragment_input_3.y * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_198 = mad(fragment_uniform_buffer_0[6u].x, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].x, fragment_input_3.x, fragment_unnamed_169)) + fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_199 = mad(fragment_uniform_buffer_0[6u].y, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].y, fragment_input_3.x, fragment_unnamed_170)) + fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_200 = mad(fragment_uniform_buffer_0[6u].z, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].z, fragment_input_3.x, fragment_unnamed_171)) + fragment_uniform_buffer_0[7u].z;
				float fragment_unnamed_218 = dot(float3(fragment_unnamed_122, fragment_unnamed_123, fragment_unnamed_124), float3(asfloat(asuint(fragment_uniform_buffer_4[9u]).z), asfloat(asuint(fragment_uniform_buffer_4[10u]).z), asfloat(asuint(fragment_uniform_buffer_4[11u]).z)));
				precise float fragment_unnamed_231 = (-0.0f) - fragment_uniform_buffer_3[25u].x;
				precise float fragment_unnamed_233 = (-0.0f) - fragment_uniform_buffer_3[25u].y;
				precise float fragment_unnamed_235 = (-0.0f) - fragment_uniform_buffer_3[25u].z;
				precise float fragment_unnamed_236 = fragment_input_3.x + fragment_unnamed_231;
				precise float fragment_unnamed_237 = fragment_input_3.y + fragment_unnamed_233;
				precise float fragment_unnamed_238 = fragment_input_3.z + fragment_unnamed_235;
				precise float fragment_unnamed_243 = (-0.0f) - fragment_unnamed_218;
				precise float fragment_unnamed_244 = fragment_unnamed_243 + sqrt(dot(float3(fragment_unnamed_236, fragment_unnamed_237, fragment_unnamed_238), float3(fragment_unnamed_236, fragment_unnamed_237, fragment_unnamed_238)));
				float fragment_unnamed_357;
				float fragment_unnamed_358;
				float fragment_unnamed_359;
				float fragment_unnamed_360;
				if (fragment_uniform_buffer_5[0u].x == 1.0f)
				{
					bool fragment_unnamed_267 = fragment_uniform_buffer_5[0u].y == 1.0f;
					precise float fragment_unnamed_275 = fragment_input_3.y * fragment_uniform_buffer_5[2u].x;
					precise float fragment_unnamed_276 = fragment_input_3.y * fragment_uniform_buffer_5[2u].y;
					precise float fragment_unnamed_277 = fragment_input_3.y * fragment_uniform_buffer_5[2u].z;
					precise float fragment_unnamed_304 = mad(fragment_uniform_buffer_5[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].x, fragment_input_3.x, fragment_unnamed_275)) + fragment_uniform_buffer_5[4u].x;
					precise float fragment_unnamed_305 = mad(fragment_uniform_buffer_5[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].y, fragment_input_3.x, fragment_unnamed_276)) + fragment_uniform_buffer_5[4u].y;
					precise float fragment_unnamed_306 = mad(fragment_uniform_buffer_5[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].z, fragment_input_3.x, fragment_unnamed_277)) + fragment_uniform_buffer_5[4u].z;
					precise float fragment_unnamed_319 = (-0.0f) - fragment_uniform_buffer_5[6u].x;
					precise float fragment_unnamed_321 = (-0.0f) - fragment_uniform_buffer_5[6u].y;
					precise float fragment_unnamed_323 = (-0.0f) - fragment_uniform_buffer_5[6u].z;
					precise float fragment_unnamed_324 = (fragment_unnamed_267 ? fragment_unnamed_304 : fragment_input_3.x) + fragment_unnamed_319;
					precise float fragment_unnamed_325 = (fragment_unnamed_267 ? fragment_unnamed_305 : fragment_input_3.y) + fragment_unnamed_321;
					precise float fragment_unnamed_326 = (fragment_unnamed_267 ? fragment_unnamed_306 : fragment_input_3.z) + fragment_unnamed_323;
					precise float fragment_unnamed_332 = fragment_unnamed_324 * fragment_uniform_buffer_5[5u].x;
					precise float fragment_unnamed_333 = fragment_unnamed_325 * fragment_uniform_buffer_5[5u].y;
					precise float fragment_unnamed_334 = fragment_unnamed_326 * fragment_uniform_buffer_5[5u].z;
					float4 fragment_unnamed_346 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_332, 0.25f, 0.75f), mad(fragment_uniform_buffer_5[0u].z, 0.5f, 0.75f)), fragment_unnamed_333, fragment_unnamed_334));
					fragment_unnamed_357 = fragment_unnamed_346.x;
					fragment_unnamed_358 = fragment_unnamed_346.y;
					fragment_unnamed_359 = fragment_unnamed_346.z;
					fragment_unnamed_360 = fragment_unnamed_346.w;
				}
				else
				{
					fragment_unnamed_357 = asfloat(1065353216u);
					fragment_unnamed_358 = asfloat(1065353216u);
					fragment_unnamed_359 = asfloat(1065353216u);
					fragment_unnamed_360 = asfloat(1065353216u);
				}
				precise float fragment_unnamed_381 = (-0.0f) - fragment_uniform_buffer_2[1u].x;
				precise float fragment_unnamed_383 = (-0.0f) - fragment_uniform_buffer_2[1u].y;
				precise float fragment_unnamed_385 = (-0.0f) - fragment_uniform_buffer_2[1u].z;
				precise float fragment_unnamed_386 = fragment_input_3.x + fragment_unnamed_381;
				precise float fragment_unnamed_387 = fragment_input_3.y + fragment_unnamed_383;
				precise float fragment_unnamed_388 = fragment_input_3.z + fragment_unnamed_385;
				precise float fragment_unnamed_397 = (-0.0f) - fragment_uniform_buffer_2[2u].z;
				precise float fragment_unnamed_398 = max(abs(fragment_unnamed_388), max(abs(fragment_unnamed_387), abs(fragment_unnamed_386))) + fragment_unnamed_397;
				precise float fragment_unnamed_404 = max(fragment_unnamed_398, 9.9999997473787516355514526367188e-06f) * fragment_uniform_buffer_2[2u].w;
				precise float fragment_unnamed_408 = fragment_uniform_buffer_2[2u].y / fragment_unnamed_404;
				precise float fragment_unnamed_412 = (-0.0f) - fragment_uniform_buffer_2[2u].x;
				precise float fragment_unnamed_413 = fragment_unnamed_408 + fragment_unnamed_412;
				precise float fragment_unnamed_414 = (-0.0f) - fragment_unnamed_413;
				precise float fragment_unnamed_415 = fragment_unnamed_414 + 1.0f;
				precise float fragment_unnamed_426 = (-0.0f) - fragment_uniform_buffer_3[24u].x;
				precise float fragment_unnamed_427 = fragment_unnamed_426 + 1.0f;
				float fragment_unnamed_431 = mad(_ShadowMapTexture.SampleCmpLevelZero(sampler_ShadowMapTexture, float3(fragment_unnamed_386, fragment_unnamed_387, fragment_unnamed_388), fragment_unnamed_415).xxxx.x, fragment_unnamed_427, fragment_uniform_buffer_3[24u].x);
				precise float fragment_unnamed_432 = (-0.0f) - fragment_unnamed_431;
				precise float fragment_unnamed_433 = fragment_unnamed_432 + clamp(dot(float4(fragment_unnamed_357, fragment_unnamed_358, fragment_unnamed_359, fragment_unnamed_360), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f);
				precise float fragment_unnamed_442 = mad(clamp(mad(mad(fragment_uniform_buffer_3[25u].w, fragment_unnamed_244, fragment_unnamed_218), fragment_uniform_buffer_3[24u].z, fragment_uniform_buffer_3[24u].w), 0.0f, 1.0f), fragment_unnamed_433, fragment_unnamed_431) * _LightTexture0.Sample(sampler_LightTexture0, dot(float3(fragment_unnamed_198, fragment_unnamed_199, fragment_unnamed_200), float3(fragment_unnamed_198, fragment_unnamed_199, fragment_unnamed_200)).xx).x;
				precise float fragment_unnamed_448 = fragment_unnamed_442 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_449 = fragment_unnamed_442 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_450 = fragment_unnamed_442 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_466 = rsqrt(dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z)));
				precise float fragment_unnamed_473 = fragment_unnamed_466 * fragment_input_2.x;
				precise float fragment_unnamed_474 = fragment_unnamed_466 * fragment_input_2.y;
				precise float fragment_unnamed_475 = fragment_unnamed_466 * fragment_input_2.z;
				float fragment_unnamed_490 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_150, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_492 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_151, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_493 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_152, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_497 = (-0.0f) - fragment_uniform_buffer_0[8u].y;
				float fragment_unnamed_498 = mad(fragment_unnamed_497, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_500 = fragment_unnamed_498 * fragment_unnamed_159;
				precise float fragment_unnamed_501 = fragment_unnamed_498 * fragment_unnamed_160;
				precise float fragment_unnamed_502 = fragment_unnamed_498 * fragment_unnamed_161;
				precise float fragment_unnamed_506 = (-0.0f) - fragment_uniform_buffer_0[8u].x;
				precise float fragment_unnamed_507 = fragment_unnamed_506 + 1.0f;
				float fragment_unnamed_508 = mad(fragment_unnamed_96, fragment_unnamed_103, fragment_unnamed_129);
				float fragment_unnamed_509 = mad(fragment_unnamed_97, fragment_unnamed_103, fragment_unnamed_130);
				float fragment_unnamed_510 = mad(fragment_unnamed_98, fragment_unnamed_103, fragment_unnamed_131);
				float fragment_unnamed_516 = rsqrt(max(dot(float3(fragment_unnamed_508, fragment_unnamed_509, fragment_unnamed_510), float3(fragment_unnamed_508, fragment_unnamed_509, fragment_unnamed_510)), 0.001000000047497451305389404296875f));
				precise float fragment_unnamed_517 = fragment_unnamed_516 * fragment_unnamed_508;
				precise float fragment_unnamed_518 = fragment_unnamed_516 * fragment_unnamed_509;
				precise float fragment_unnamed_519 = fragment_unnamed_516 * fragment_unnamed_510;
				float fragment_unnamed_520 = dot(float3(fragment_unnamed_473, fragment_unnamed_474, fragment_unnamed_475), float3(fragment_unnamed_129, fragment_unnamed_130, fragment_unnamed_131));
				float fragment_unnamed_526 = clamp(dot(float3(fragment_unnamed_473, fragment_unnamed_474, fragment_unnamed_475), float3(fragment_unnamed_104, fragment_unnamed_105, fragment_unnamed_106)), 0.0f, 1.0f);
				float fragment_unnamed_530 = clamp(dot(float3(fragment_unnamed_473, fragment_unnamed_474, fragment_unnamed_475), float3(fragment_unnamed_517, fragment_unnamed_518, fragment_unnamed_519)), 0.0f, 1.0f);
				float fragment_unnamed_534 = clamp(dot(float3(fragment_unnamed_104, fragment_unnamed_105, fragment_unnamed_106), float3(fragment_unnamed_517, fragment_unnamed_518, fragment_unnamed_519)), 0.0f, 1.0f);
				precise float fragment_unnamed_535 = fragment_unnamed_534 * fragment_unnamed_534;
				precise float fragment_unnamed_539 = dot(fragment_unnamed_535.xx, fragment_unnamed_507.xx) + (-0.5f);
				precise float fragment_unnamed_541 = (-0.0f) - fragment_unnamed_526;
				precise float fragment_unnamed_542 = fragment_unnamed_541 + 1.0f;
				precise float fragment_unnamed_543 = fragment_unnamed_542 * fragment_unnamed_542;
				precise float fragment_unnamed_544 = fragment_unnamed_543 * fragment_unnamed_543;
				precise float fragment_unnamed_545 = fragment_unnamed_542 * fragment_unnamed_544;
				precise float fragment_unnamed_548 = (-0.0f) - abs(fragment_unnamed_520);
				precise float fragment_unnamed_549 = fragment_unnamed_548 + 1.0f;
				precise float fragment_unnamed_550 = fragment_unnamed_549 * fragment_unnamed_549;
				precise float fragment_unnamed_551 = fragment_unnamed_550 * fragment_unnamed_550;
				precise float fragment_unnamed_552 = fragment_unnamed_549 * fragment_unnamed_551;
				precise float fragment_unnamed_554 = mad(fragment_unnamed_539, fragment_unnamed_552, 1.0f) * mad(fragment_unnamed_539, fragment_unnamed_545, 1.0f);
				precise float fragment_unnamed_555 = fragment_unnamed_507 * fragment_unnamed_507;
				float fragment_unnamed_556 = max(fragment_unnamed_555, 0.00200000009499490261077880859375f);
				precise float fragment_unnamed_558 = (-0.0f) - fragment_unnamed_556;
				precise float fragment_unnamed_559 = fragment_unnamed_558 + 1.0f;
				precise float fragment_unnamed_564 = abs(fragment_unnamed_520) * mad(fragment_unnamed_526, fragment_unnamed_559, fragment_unnamed_556);
				precise float fragment_unnamed_566 = mad(fragment_unnamed_526, mad(abs(fragment_unnamed_520), fragment_unnamed_559, fragment_unnamed_556), fragment_unnamed_564) + 9.9999997473787516355514526367188e-06f;
				precise float fragment_unnamed_567 = 0.5f / fragment_unnamed_566;
				precise float fragment_unnamed_568 = fragment_unnamed_556 * fragment_unnamed_556;
				precise float fragment_unnamed_569 = (-0.0f) - fragment_unnamed_530;
				float fragment_unnamed_571 = mad(mad(fragment_unnamed_530, fragment_unnamed_568, fragment_unnamed_569), fragment_unnamed_530, 1.0f);
				precise float fragment_unnamed_572 = fragment_unnamed_568 * 0.3183098733425140380859375f;
				precise float fragment_unnamed_576 = fragment_unnamed_572 / mad(fragment_unnamed_571, fragment_unnamed_571, 1.0000000116860974230803549289703e-07f);
				precise float fragment_unnamed_577 = fragment_unnamed_576 * fragment_unnamed_567;
				precise float fragment_unnamed_578 = fragment_unnamed_577 * 3.1415927410125732421875f;
				precise float fragment_unnamed_583 = fragment_unnamed_526 * fragment_unnamed_554;
				precise float fragment_unnamed_584 = fragment_unnamed_526 * sqrt(max(fragment_unnamed_578, 9.9999997473787516355514526367188e-05f));
				precise float fragment_unnamed_593 = asfloat(((dot(float3(fragment_unnamed_490, fragment_unnamed_492, fragment_unnamed_493), float3(fragment_unnamed_490, fragment_unnamed_492, fragment_unnamed_493)) != 0.0f) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_584;
				precise float fragment_unnamed_594 = fragment_unnamed_583 * fragment_unnamed_448;
				precise float fragment_unnamed_595 = fragment_unnamed_583 * fragment_unnamed_449;
				precise float fragment_unnamed_596 = fragment_unnamed_583 * fragment_unnamed_450;
				precise float fragment_unnamed_597 = fragment_unnamed_448 * fragment_unnamed_593;
				precise float fragment_unnamed_598 = fragment_unnamed_449 * fragment_unnamed_593;
				precise float fragment_unnamed_599 = fragment_unnamed_450 * fragment_unnamed_593;
				precise float fragment_unnamed_600 = (-0.0f) - fragment_unnamed_534;
				precise float fragment_unnamed_601 = fragment_unnamed_600 + 1.0f;
				precise float fragment_unnamed_602 = fragment_unnamed_601 * fragment_unnamed_601;
				precise float fragment_unnamed_603 = fragment_unnamed_602 * fragment_unnamed_602;
				precise float fragment_unnamed_604 = fragment_unnamed_601 * fragment_unnamed_603;
				precise float fragment_unnamed_605 = (-0.0f) - fragment_unnamed_490;
				precise float fragment_unnamed_606 = (-0.0f) - fragment_unnamed_492;
				precise float fragment_unnamed_607 = (-0.0f) - fragment_unnamed_493;
				precise float fragment_unnamed_608 = fragment_unnamed_605 + 1.0f;
				precise float fragment_unnamed_609 = fragment_unnamed_606 + 1.0f;
				precise float fragment_unnamed_610 = fragment_unnamed_607 + 1.0f;
				precise float fragment_unnamed_614 = fragment_unnamed_597 * mad(fragment_unnamed_608, fragment_unnamed_604, fragment_unnamed_490);
				precise float fragment_unnamed_615 = fragment_unnamed_598 * mad(fragment_unnamed_609, fragment_unnamed_604, fragment_unnamed_492);
				precise float fragment_unnamed_616 = fragment_unnamed_599 * mad(fragment_unnamed_610, fragment_unnamed_604, fragment_unnamed_493);
				fragment_output_0.x = mad(fragment_unnamed_500, fragment_unnamed_594, fragment_unnamed_614);
				fragment_output_0.y = mad(fragment_unnamed_501, fragment_unnamed_595, fragment_unnamed_615);
				fragment_output_0.z = mad(fragment_unnamed_502, fragment_unnamed_596, fragment_unnamed_616);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				fragment_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				fragment_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				fragment_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_uniform_buffer_0[8] = float4(_Glossiness, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _Metallic, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[9] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_uniform_buffer_2[1] = float4(_LightPositionRange[0], _LightPositionRange[1], _LightPositionRange[2], _LightPositionRange[3]);

				fragment_uniform_buffer_2[2] = float4(_LightProjectionParams[0], _LightProjectionParams[1], _LightProjectionParams[2], _LightProjectionParams[3]);

				fragment_uniform_buffer_2[46] = float4(unity_OcclusionMaskSelector[0], unity_OcclusionMaskSelector[1], unity_OcclusionMaskSelector[2], unity_OcclusionMaskSelector[3]);

				fragment_uniform_buffer_3[24] = float4(_LightShadowData[0], _LightShadowData[1], _LightShadowData[2], _LightShadowData[3]);

				fragment_uniform_buffer_3[25] = float4(unity_ShadowFadeCenterAndType[0], unity_ShadowFadeCenterAndType[1], unity_ShadowFadeCenterAndType[2], unity_ShadowFadeCenterAndType[3]);

				fragment_uniform_buffer_4[9] = float4(unity_MatrixV[0][0], unity_MatrixV[1][0], unity_MatrixV[2][0], unity_MatrixV[3][0]);
				fragment_uniform_buffer_4[10] = float4(unity_MatrixV[0][1], unity_MatrixV[1][1], unity_MatrixV[2][1], unity_MatrixV[3][1]);
				fragment_uniform_buffer_4[11] = float4(unity_MatrixV[0][2], unity_MatrixV[1][2], unity_MatrixV[2][2], unity_MatrixV[3][2]);
				fragment_uniform_buffer_4[12] = float4(unity_MatrixV[0][3], unity_MatrixV[1][3], unity_MatrixV[2][3], unity_MatrixV[3][3]);

				fragment_uniform_buffer_5[0] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_5[1] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_5[2] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_5[3] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_5[4] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_5[5] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], fragment_uniform_buffer_5[5][3]);

				fragment_uniform_buffer_5[6] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], fragment_uniform_buffer_5[6][3]);

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

			#endif // defined(POINT) && defined(SHADOWS_CUBE) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_SCREEN)


			#if defined(POINT) && defined(SHADOWS_CUBE) && defined(SHADOWS_SOFT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SCREEN)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToLight;
			float4 _MainTex_ST;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[11];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static float4 vertex_output_6;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float3 vertex_output_5 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_6 : TEXCOORD4; // TEXCOORD_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_59 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_60 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_57));
				float vertex_unnamed_84 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_58));
				float vertex_unnamed_85 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_59));
				float vertex_unnamed_86 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_60));
				precise float vertex_unnamed_94 = vertex_unnamed_83 + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_95 = vertex_unnamed_84 + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_96 = vertex_unnamed_85 + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_97 = vertex_unnamed_86 + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_105 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_106 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_107 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_108 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_94, vertex_unnamed_105)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_94, vertex_unnamed_106)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_94, vertex_unnamed_107)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_94, vertex_unnamed_108)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[10u].x, vertex_uniform_buffer_0[10u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[10u].y, vertex_uniform_buffer_0[10u].w);
				float vertex_unnamed_176 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_191 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_206 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_212 = rsqrt(dot(float3(vertex_unnamed_176, vertex_unnamed_191, vertex_unnamed_206), float3(vertex_unnamed_176, vertex_unnamed_191, vertex_unnamed_206)));
				precise float vertex_unnamed_213 = vertex_unnamed_212 * vertex_unnamed_176;
				precise float vertex_unnamed_214 = vertex_unnamed_212 * vertex_unnamed_191;
				precise float vertex_unnamed_215 = vertex_unnamed_212 * vertex_unnamed_206;
				vertex_output_2.x = vertex_unnamed_213;
				vertex_output_2.y = vertex_unnamed_214;
				vertex_output_2.z = vertex_unnamed_215;
				vertex_output_3.x = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				vertex_output_3.y = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				vertex_output_3.z = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				float vertex_unnamed_240 = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				float vertex_unnamed_241 = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				float vertex_unnamed_242 = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				float vertex_unnamed_243 = mad(vertex_uniform_buffer_1[3u].w, vertex_input_0.w, vertex_unnamed_86);
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				precise float vertex_unnamed_261 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_262 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].y;
				precise float vertex_unnamed_263 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].z;
				vertex_output_5.x = mad(vertex_uniform_buffer_0[7u].x, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].x, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].x, vertex_unnamed_240, vertex_unnamed_261)));
				vertex_output_5.y = mad(vertex_uniform_buffer_0[7u].y, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].y, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].y, vertex_unnamed_240, vertex_unnamed_262)));
				vertex_output_5.z = mad(vertex_uniform_buffer_0[7u].z, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].z, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].z, vertex_unnamed_240, vertex_unnamed_263)));
				vertex_output_6.x = 0.0f;
				vertex_output_6.y = 0.0f;
				vertex_output_6.z = 0.0f;
				vertex_output_6.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				vertex_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				vertex_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				vertex_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				vertex_uniform_buffer_0[10] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_2[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_2[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_2[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}


			float4 _LightColor0;
			float4x4 unity_WorldToLight;
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 _LightPositionRange;
			float4 _LightProjectionParams;
			float4 unity_OcclusionMaskSelector;
			float4 _LightShadowData;
			float4 unity_ShadowFadeCenterAndType;
			float4x4 unity_MatrixV;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[10];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[26];
			static float4 fragment_uniform_buffer_4[13];
			static float4 fragment_uniform_buffer_5[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _LightTexture0;
			Texture3D<float4> unity_ProbeVolumeSH;
			TextureCube<float4> _ShadowMapTexture;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerComparisonState sampler_ShadowMapTexture;
			SamplerState sampler_LightTexture0;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float3 fragment_input_5 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_6 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_80 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_85 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_89 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_96 = fragment_unnamed_80 + fragment_uniform_buffer_2[0u].x;
				precise float fragment_unnamed_97 = fragment_unnamed_85 + fragment_uniform_buffer_2[0u].y;
				precise float fragment_unnamed_98 = fragment_unnamed_89 + fragment_uniform_buffer_2[0u].z;
				float fragment_unnamed_103 = rsqrt(dot(float3(fragment_unnamed_96, fragment_unnamed_97, fragment_unnamed_98), float3(fragment_unnamed_96, fragment_unnamed_97, fragment_unnamed_98)));
				precise float fragment_unnamed_104 = fragment_unnamed_103 * fragment_unnamed_96;
				precise float fragment_unnamed_105 = fragment_unnamed_103 * fragment_unnamed_97;
				precise float fragment_unnamed_106 = fragment_unnamed_103 * fragment_unnamed_98;
				precise float fragment_unnamed_109 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_112 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_115 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_122 = fragment_unnamed_109 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_123 = fragment_unnamed_112 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_124 = fragment_unnamed_115 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_128 = rsqrt(dot(float3(fragment_unnamed_122, fragment_unnamed_123, fragment_unnamed_124), float3(fragment_unnamed_122, fragment_unnamed_123, fragment_unnamed_124)));
				precise float fragment_unnamed_129 = fragment_unnamed_128 * fragment_unnamed_122;
				precise float fragment_unnamed_130 = fragment_unnamed_128 * fragment_unnamed_123;
				precise float fragment_unnamed_131 = fragment_unnamed_128 * fragment_unnamed_124;
				float4 fragment_unnamed_139 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_150 = fragment_unnamed_139.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_151 = fragment_unnamed_139.y * fragment_uniform_buffer_0[9u].y;
				precise float fragment_unnamed_152 = fragment_unnamed_139.z * fragment_uniform_buffer_0[9u].z;
				precise float fragment_unnamed_159 = fragment_unnamed_150 * fragment_input_4.x;
				precise float fragment_unnamed_160 = fragment_unnamed_151 * fragment_input_4.y;
				precise float fragment_unnamed_161 = fragment_unnamed_152 * fragment_input_4.z;
				precise float fragment_unnamed_169 = fragment_input_3.y * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_170 = fragment_input_3.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_171 = fragment_input_3.y * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_198 = mad(fragment_uniform_buffer_0[6u].x, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].x, fragment_input_3.x, fragment_unnamed_169)) + fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_199 = mad(fragment_uniform_buffer_0[6u].y, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].y, fragment_input_3.x, fragment_unnamed_170)) + fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_200 = mad(fragment_uniform_buffer_0[6u].z, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].z, fragment_input_3.x, fragment_unnamed_171)) + fragment_uniform_buffer_0[7u].z;
				float fragment_unnamed_218 = dot(float3(fragment_unnamed_122, fragment_unnamed_123, fragment_unnamed_124), float3(asfloat(asuint(fragment_uniform_buffer_4[9u]).z), asfloat(asuint(fragment_uniform_buffer_4[10u]).z), asfloat(asuint(fragment_uniform_buffer_4[11u]).z)));
				precise float fragment_unnamed_231 = (-0.0f) - fragment_uniform_buffer_3[25u].x;
				precise float fragment_unnamed_233 = (-0.0f) - fragment_uniform_buffer_3[25u].y;
				precise float fragment_unnamed_235 = (-0.0f) - fragment_uniform_buffer_3[25u].z;
				precise float fragment_unnamed_236 = fragment_input_3.x + fragment_unnamed_231;
				precise float fragment_unnamed_237 = fragment_input_3.y + fragment_unnamed_233;
				precise float fragment_unnamed_238 = fragment_input_3.z + fragment_unnamed_235;
				precise float fragment_unnamed_243 = (-0.0f) - fragment_unnamed_218;
				precise float fragment_unnamed_244 = fragment_unnamed_243 + sqrt(dot(float3(fragment_unnamed_236, fragment_unnamed_237, fragment_unnamed_238), float3(fragment_unnamed_236, fragment_unnamed_237, fragment_unnamed_238)));
				float fragment_unnamed_258 = clamp(mad(mad(fragment_uniform_buffer_3[25u].w, fragment_unnamed_244, fragment_unnamed_218), fragment_uniform_buffer_3[24u].z, fragment_uniform_buffer_3[24u].w), 0.0f, 1.0f);
				float fragment_unnamed_357;
				float fragment_unnamed_358;
				float fragment_unnamed_359;
				float fragment_unnamed_360;
				if (fragment_uniform_buffer_5[0u].x == 1.0f)
				{
					bool fragment_unnamed_267 = fragment_uniform_buffer_5[0u].y == 1.0f;
					precise float fragment_unnamed_275 = fragment_input_3.y * fragment_uniform_buffer_5[2u].x;
					precise float fragment_unnamed_276 = fragment_input_3.y * fragment_uniform_buffer_5[2u].y;
					precise float fragment_unnamed_277 = fragment_input_3.y * fragment_uniform_buffer_5[2u].z;
					precise float fragment_unnamed_304 = mad(fragment_uniform_buffer_5[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].x, fragment_input_3.x, fragment_unnamed_275)) + fragment_uniform_buffer_5[4u].x;
					precise float fragment_unnamed_305 = mad(fragment_uniform_buffer_5[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].y, fragment_input_3.x, fragment_unnamed_276)) + fragment_uniform_buffer_5[4u].y;
					precise float fragment_unnamed_306 = mad(fragment_uniform_buffer_5[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].z, fragment_input_3.x, fragment_unnamed_277)) + fragment_uniform_buffer_5[4u].z;
					precise float fragment_unnamed_319 = (-0.0f) - fragment_uniform_buffer_5[6u].x;
					precise float fragment_unnamed_321 = (-0.0f) - fragment_uniform_buffer_5[6u].y;
					precise float fragment_unnamed_323 = (-0.0f) - fragment_uniform_buffer_5[6u].z;
					precise float fragment_unnamed_324 = (fragment_unnamed_267 ? fragment_unnamed_304 : fragment_input_3.x) + fragment_unnamed_319;
					precise float fragment_unnamed_325 = (fragment_unnamed_267 ? fragment_unnamed_305 : fragment_input_3.y) + fragment_unnamed_321;
					precise float fragment_unnamed_326 = (fragment_unnamed_267 ? fragment_unnamed_306 : fragment_input_3.z) + fragment_unnamed_323;
					precise float fragment_unnamed_332 = fragment_unnamed_324 * fragment_uniform_buffer_5[5u].x;
					precise float fragment_unnamed_333 = fragment_unnamed_325 * fragment_uniform_buffer_5[5u].y;
					precise float fragment_unnamed_334 = fragment_unnamed_326 * fragment_uniform_buffer_5[5u].z;
					float4 fragment_unnamed_346 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_332, 0.25f, 0.75f), mad(fragment_uniform_buffer_5[0u].z, 0.5f, 0.75f)), fragment_unnamed_333, fragment_unnamed_334));
					fragment_unnamed_357 = fragment_unnamed_346.x;
					fragment_unnamed_358 = fragment_unnamed_346.y;
					fragment_unnamed_359 = fragment_unnamed_346.z;
					fragment_unnamed_360 = fragment_unnamed_346.w;
				}
				else
				{
					fragment_unnamed_357 = asfloat(1065353216u);
					fragment_unnamed_358 = asfloat(1065353216u);
					fragment_unnamed_359 = asfloat(1065353216u);
					fragment_unnamed_360 = asfloat(1065353216u);
				}
				float fragment_unnamed_464;
				if (fragment_unnamed_258 < 0.9900000095367431640625f)
				{
					precise float fragment_unnamed_383 = (-0.0f) - fragment_uniform_buffer_2[1u].x;
					precise float fragment_unnamed_385 = (-0.0f) - fragment_uniform_buffer_2[1u].y;
					precise float fragment_unnamed_387 = (-0.0f) - fragment_uniform_buffer_2[1u].z;
					precise float fragment_unnamed_388 = fragment_input_3.x + fragment_unnamed_383;
					precise float fragment_unnamed_389 = fragment_input_3.y + fragment_unnamed_385;
					precise float fragment_unnamed_390 = fragment_input_3.z + fragment_unnamed_387;
					precise float fragment_unnamed_399 = (-0.0f) - fragment_uniform_buffer_2[2u].z;
					precise float fragment_unnamed_400 = max(abs(fragment_unnamed_390), max(abs(fragment_unnamed_389), abs(fragment_unnamed_388))) + fragment_unnamed_399;
					precise float fragment_unnamed_406 = max(fragment_unnamed_400, 9.9999997473787516355514526367188e-06f) * fragment_uniform_buffer_2[2u].w;
					precise float fragment_unnamed_410 = fragment_uniform_buffer_2[2u].y / fragment_unnamed_406;
					precise float fragment_unnamed_414 = (-0.0f) - fragment_uniform_buffer_2[2u].x;
					precise float fragment_unnamed_415 = fragment_unnamed_410 + fragment_unnamed_414;
					precise float fragment_unnamed_416 = (-0.0f) - fragment_unnamed_415;
					precise float fragment_unnamed_417 = fragment_unnamed_416 + 1.0f;
					precise float fragment_unnamed_418 = fragment_unnamed_388 + 0.0078125f;
					precise float fragment_unnamed_420 = fragment_unnamed_389 + 0.0078125f;
					precise float fragment_unnamed_421 = fragment_unnamed_390 + 0.0078125f;
					precise float fragment_unnamed_429 = fragment_unnamed_388 + (-0.0078125f);
					precise float fragment_unnamed_431 = fragment_unnamed_389 + (-0.0078125f);
					precise float fragment_unnamed_432 = fragment_unnamed_390 + 0.0078125f;
					precise float fragment_unnamed_437 = fragment_unnamed_388 + (-0.0078125f);
					precise float fragment_unnamed_438 = fragment_unnamed_389 + 0.0078125f;
					precise float fragment_unnamed_439 = fragment_unnamed_390 + (-0.0078125f);
					precise float fragment_unnamed_444 = fragment_unnamed_388 + 0.0078125f;
					precise float fragment_unnamed_445 = fragment_unnamed_389 + (-0.0078125f);
					precise float fragment_unnamed_446 = fragment_unnamed_390 + (-0.0078125f);
					precise float fragment_unnamed_457 = (-0.0f) - fragment_uniform_buffer_3[24u].x;
					precise float fragment_unnamed_458 = fragment_unnamed_457 + 1.0f;
					fragment_unnamed_464 = mad(dot(float4(_ShadowMapTexture.SampleCmpLevelZero(sampler_ShadowMapTexture, float3(fragment_unnamed_418, fragment_unnamed_420, fragment_unnamed_421), fragment_unnamed_417).xxxx.x, _ShadowMapTexture.SampleCmpLevelZero(sampler_ShadowMapTexture, float3(fragment_unnamed_429, fragment_unnamed_431, fragment_unnamed_432), fragment_unnamed_417).xxxx.x, _ShadowMapTexture.SampleCmpLevelZero(sampler_ShadowMapTexture, float3(fragment_unnamed_437, fragment_unnamed_438, fragment_unnamed_439), fragment_unnamed_417).xxxx.x, _ShadowMapTexture.SampleCmpLevelZero(sampler_ShadowMapTexture, float3(fragment_unnamed_444, fragment_unnamed_445, fragment_unnamed_446), fragment_unnamed_417).xxxx.x), 0.25f.xxxx), fragment_unnamed_458, fragment_uniform_buffer_3[24u].x);
				}
				else
				{
					fragment_unnamed_464 = asfloat(1065353216u);
				}
				precise float fragment_unnamed_465 = (-0.0f) - fragment_unnamed_464;
				precise float fragment_unnamed_466 = fragment_unnamed_465 + clamp(dot(float4(fragment_unnamed_357, fragment_unnamed_358, fragment_unnamed_359, fragment_unnamed_360), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f);
				precise float fragment_unnamed_475 = mad(fragment_unnamed_258, fragment_unnamed_466, fragment_unnamed_464) * _LightTexture0.Sample(sampler_LightTexture0, dot(float3(fragment_unnamed_198, fragment_unnamed_199, fragment_unnamed_200), float3(fragment_unnamed_198, fragment_unnamed_199, fragment_unnamed_200)).xx).x;
				precise float fragment_unnamed_481 = fragment_unnamed_475 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_482 = fragment_unnamed_475 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_483 = fragment_unnamed_475 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_499 = rsqrt(dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z)));
				precise float fragment_unnamed_506 = fragment_unnamed_499 * fragment_input_2.x;
				precise float fragment_unnamed_507 = fragment_unnamed_499 * fragment_input_2.y;
				precise float fragment_unnamed_508 = fragment_unnamed_499 * fragment_input_2.z;
				float fragment_unnamed_523 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_150, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_525 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_151, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_526 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_152, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_530 = (-0.0f) - fragment_uniform_buffer_0[8u].y;
				float fragment_unnamed_531 = mad(fragment_unnamed_530, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_533 = fragment_unnamed_531 * fragment_unnamed_159;
				precise float fragment_unnamed_534 = fragment_unnamed_531 * fragment_unnamed_160;
				precise float fragment_unnamed_535 = fragment_unnamed_531 * fragment_unnamed_161;
				precise float fragment_unnamed_539 = (-0.0f) - fragment_uniform_buffer_0[8u].x;
				precise float fragment_unnamed_540 = fragment_unnamed_539 + 1.0f;
				float fragment_unnamed_541 = mad(fragment_unnamed_96, fragment_unnamed_103, fragment_unnamed_129);
				float fragment_unnamed_542 = mad(fragment_unnamed_97, fragment_unnamed_103, fragment_unnamed_130);
				float fragment_unnamed_543 = mad(fragment_unnamed_98, fragment_unnamed_103, fragment_unnamed_131);
				float fragment_unnamed_549 = rsqrt(max(dot(float3(fragment_unnamed_541, fragment_unnamed_542, fragment_unnamed_543), float3(fragment_unnamed_541, fragment_unnamed_542, fragment_unnamed_543)), 0.001000000047497451305389404296875f));
				precise float fragment_unnamed_550 = fragment_unnamed_549 * fragment_unnamed_541;
				precise float fragment_unnamed_551 = fragment_unnamed_549 * fragment_unnamed_542;
				precise float fragment_unnamed_552 = fragment_unnamed_549 * fragment_unnamed_543;
				float fragment_unnamed_553 = dot(float3(fragment_unnamed_506, fragment_unnamed_507, fragment_unnamed_508), float3(fragment_unnamed_129, fragment_unnamed_130, fragment_unnamed_131));
				float fragment_unnamed_559 = clamp(dot(float3(fragment_unnamed_506, fragment_unnamed_507, fragment_unnamed_508), float3(fragment_unnamed_104, fragment_unnamed_105, fragment_unnamed_106)), 0.0f, 1.0f);
				float fragment_unnamed_563 = clamp(dot(float3(fragment_unnamed_506, fragment_unnamed_507, fragment_unnamed_508), float3(fragment_unnamed_550, fragment_unnamed_551, fragment_unnamed_552)), 0.0f, 1.0f);
				float fragment_unnamed_567 = clamp(dot(float3(fragment_unnamed_104, fragment_unnamed_105, fragment_unnamed_106), float3(fragment_unnamed_550, fragment_unnamed_551, fragment_unnamed_552)), 0.0f, 1.0f);
				precise float fragment_unnamed_568 = fragment_unnamed_567 * fragment_unnamed_567;
				precise float fragment_unnamed_572 = dot(fragment_unnamed_568.xx, fragment_unnamed_540.xx) + (-0.5f);
				precise float fragment_unnamed_574 = (-0.0f) - fragment_unnamed_559;
				precise float fragment_unnamed_575 = fragment_unnamed_574 + 1.0f;
				precise float fragment_unnamed_576 = fragment_unnamed_575 * fragment_unnamed_575;
				precise float fragment_unnamed_577 = fragment_unnamed_576 * fragment_unnamed_576;
				precise float fragment_unnamed_578 = fragment_unnamed_575 * fragment_unnamed_577;
				precise float fragment_unnamed_581 = (-0.0f) - abs(fragment_unnamed_553);
				precise float fragment_unnamed_582 = fragment_unnamed_581 + 1.0f;
				precise float fragment_unnamed_583 = fragment_unnamed_582 * fragment_unnamed_582;
				precise float fragment_unnamed_584 = fragment_unnamed_583 * fragment_unnamed_583;
				precise float fragment_unnamed_585 = fragment_unnamed_582 * fragment_unnamed_584;
				precise float fragment_unnamed_587 = mad(fragment_unnamed_572, fragment_unnamed_585, 1.0f) * mad(fragment_unnamed_572, fragment_unnamed_578, 1.0f);
				precise float fragment_unnamed_588 = fragment_unnamed_540 * fragment_unnamed_540;
				float fragment_unnamed_589 = max(fragment_unnamed_588, 0.00200000009499490261077880859375f);
				precise float fragment_unnamed_591 = (-0.0f) - fragment_unnamed_589;
				precise float fragment_unnamed_592 = fragment_unnamed_591 + 1.0f;
				precise float fragment_unnamed_597 = abs(fragment_unnamed_553) * mad(fragment_unnamed_559, fragment_unnamed_592, fragment_unnamed_589);
				precise float fragment_unnamed_599 = mad(fragment_unnamed_559, mad(abs(fragment_unnamed_553), fragment_unnamed_592, fragment_unnamed_589), fragment_unnamed_597) + 9.9999997473787516355514526367188e-06f;
				precise float fragment_unnamed_600 = 0.5f / fragment_unnamed_599;
				precise float fragment_unnamed_601 = fragment_unnamed_589 * fragment_unnamed_589;
				precise float fragment_unnamed_602 = (-0.0f) - fragment_unnamed_563;
				float fragment_unnamed_604 = mad(mad(fragment_unnamed_563, fragment_unnamed_601, fragment_unnamed_602), fragment_unnamed_563, 1.0f);
				precise float fragment_unnamed_605 = fragment_unnamed_601 * 0.3183098733425140380859375f;
				precise float fragment_unnamed_609 = fragment_unnamed_605 / mad(fragment_unnamed_604, fragment_unnamed_604, 1.0000000116860974230803549289703e-07f);
				precise float fragment_unnamed_610 = fragment_unnamed_609 * fragment_unnamed_600;
				precise float fragment_unnamed_611 = fragment_unnamed_610 * 3.1415927410125732421875f;
				precise float fragment_unnamed_616 = fragment_unnamed_559 * fragment_unnamed_587;
				precise float fragment_unnamed_617 = fragment_unnamed_559 * sqrt(max(fragment_unnamed_611, 9.9999997473787516355514526367188e-05f));
				precise float fragment_unnamed_626 = asfloat(((dot(float3(fragment_unnamed_523, fragment_unnamed_525, fragment_unnamed_526), float3(fragment_unnamed_523, fragment_unnamed_525, fragment_unnamed_526)) != 0.0f) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_617;
				precise float fragment_unnamed_627 = fragment_unnamed_616 * fragment_unnamed_481;
				precise float fragment_unnamed_628 = fragment_unnamed_616 * fragment_unnamed_482;
				precise float fragment_unnamed_629 = fragment_unnamed_616 * fragment_unnamed_483;
				precise float fragment_unnamed_630 = fragment_unnamed_481 * fragment_unnamed_626;
				precise float fragment_unnamed_631 = fragment_unnamed_482 * fragment_unnamed_626;
				precise float fragment_unnamed_632 = fragment_unnamed_483 * fragment_unnamed_626;
				precise float fragment_unnamed_633 = (-0.0f) - fragment_unnamed_567;
				precise float fragment_unnamed_634 = fragment_unnamed_633 + 1.0f;
				precise float fragment_unnamed_635 = fragment_unnamed_634 * fragment_unnamed_634;
				precise float fragment_unnamed_636 = fragment_unnamed_635 * fragment_unnamed_635;
				precise float fragment_unnamed_637 = fragment_unnamed_634 * fragment_unnamed_636;
				precise float fragment_unnamed_638 = (-0.0f) - fragment_unnamed_523;
				precise float fragment_unnamed_639 = (-0.0f) - fragment_unnamed_525;
				precise float fragment_unnamed_640 = (-0.0f) - fragment_unnamed_526;
				precise float fragment_unnamed_641 = fragment_unnamed_638 + 1.0f;
				precise float fragment_unnamed_642 = fragment_unnamed_639 + 1.0f;
				precise float fragment_unnamed_643 = fragment_unnamed_640 + 1.0f;
				precise float fragment_unnamed_647 = fragment_unnamed_630 * mad(fragment_unnamed_641, fragment_unnamed_637, fragment_unnamed_523);
				precise float fragment_unnamed_648 = fragment_unnamed_631 * mad(fragment_unnamed_642, fragment_unnamed_637, fragment_unnamed_525);
				precise float fragment_unnamed_649 = fragment_unnamed_632 * mad(fragment_unnamed_643, fragment_unnamed_637, fragment_unnamed_526);
				fragment_output_0.x = mad(fragment_unnamed_533, fragment_unnamed_627, fragment_unnamed_647);
				fragment_output_0.y = mad(fragment_unnamed_534, fragment_unnamed_628, fragment_unnamed_648);
				fragment_output_0.z = mad(fragment_unnamed_535, fragment_unnamed_629, fragment_unnamed_649);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				fragment_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				fragment_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				fragment_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_uniform_buffer_0[8] = float4(_Glossiness, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _Metallic, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[9] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_uniform_buffer_2[1] = float4(_LightPositionRange[0], _LightPositionRange[1], _LightPositionRange[2], _LightPositionRange[3]);

				fragment_uniform_buffer_2[2] = float4(_LightProjectionParams[0], _LightProjectionParams[1], _LightProjectionParams[2], _LightProjectionParams[3]);

				fragment_uniform_buffer_2[46] = float4(unity_OcclusionMaskSelector[0], unity_OcclusionMaskSelector[1], unity_OcclusionMaskSelector[2], unity_OcclusionMaskSelector[3]);

				fragment_uniform_buffer_3[24] = float4(_LightShadowData[0], _LightShadowData[1], _LightShadowData[2], _LightShadowData[3]);

				fragment_uniform_buffer_3[25] = float4(unity_ShadowFadeCenterAndType[0], unity_ShadowFadeCenterAndType[1], unity_ShadowFadeCenterAndType[2], unity_ShadowFadeCenterAndType[3]);

				fragment_uniform_buffer_4[9] = float4(unity_MatrixV[0][0], unity_MatrixV[1][0], unity_MatrixV[2][0], unity_MatrixV[3][0]);
				fragment_uniform_buffer_4[10] = float4(unity_MatrixV[0][1], unity_MatrixV[1][1], unity_MatrixV[2][1], unity_MatrixV[3][1]);
				fragment_uniform_buffer_4[11] = float4(unity_MatrixV[0][2], unity_MatrixV[1][2], unity_MatrixV[2][2], unity_MatrixV[3][2]);
				fragment_uniform_buffer_4[12] = float4(unity_MatrixV[0][3], unity_MatrixV[1][3], unity_MatrixV[2][3], unity_MatrixV[3][3]);

				fragment_uniform_buffer_5[0] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_5[1] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_5[2] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_5[3] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_5[4] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_5[5] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], fragment_uniform_buffer_5[5][3]);

				fragment_uniform_buffer_5[6] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], fragment_uniform_buffer_5[6][3]);

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

			#endif // defined(POINT) && defined(SHADOWS_CUBE) && defined(SHADOWS_SOFT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(POINT_COOKIE) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SCREEN)


			#if defined(POINT_COOKIE) && defined(SHADOWS_CUBE) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_SCREEN)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToLight;
			float4 _MainTex_ST;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[11];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static float4 vertex_output_6;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float3 vertex_output_5 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_6 : TEXCOORD4; // TEXCOORD_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_59 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_60 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_57));
				float vertex_unnamed_84 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_58));
				float vertex_unnamed_85 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_59));
				float vertex_unnamed_86 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_60));
				precise float vertex_unnamed_94 = vertex_unnamed_83 + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_95 = vertex_unnamed_84 + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_96 = vertex_unnamed_85 + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_97 = vertex_unnamed_86 + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_105 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_106 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_107 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_108 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_94, vertex_unnamed_105)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_94, vertex_unnamed_106)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_94, vertex_unnamed_107)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_94, vertex_unnamed_108)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[10u].x, vertex_uniform_buffer_0[10u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[10u].y, vertex_uniform_buffer_0[10u].w);
				float vertex_unnamed_176 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_191 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_206 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_212 = rsqrt(dot(float3(vertex_unnamed_176, vertex_unnamed_191, vertex_unnamed_206), float3(vertex_unnamed_176, vertex_unnamed_191, vertex_unnamed_206)));
				precise float vertex_unnamed_213 = vertex_unnamed_212 * vertex_unnamed_176;
				precise float vertex_unnamed_214 = vertex_unnamed_212 * vertex_unnamed_191;
				precise float vertex_unnamed_215 = vertex_unnamed_212 * vertex_unnamed_206;
				vertex_output_2.x = vertex_unnamed_213;
				vertex_output_2.y = vertex_unnamed_214;
				vertex_output_2.z = vertex_unnamed_215;
				vertex_output_3.x = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				vertex_output_3.y = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				vertex_output_3.z = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				float vertex_unnamed_240 = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				float vertex_unnamed_241 = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				float vertex_unnamed_242 = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				float vertex_unnamed_243 = mad(vertex_uniform_buffer_1[3u].w, vertex_input_0.w, vertex_unnamed_86);
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				precise float vertex_unnamed_261 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_262 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].y;
				precise float vertex_unnamed_263 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].z;
				vertex_output_5.x = mad(vertex_uniform_buffer_0[7u].x, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].x, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].x, vertex_unnamed_240, vertex_unnamed_261)));
				vertex_output_5.y = mad(vertex_uniform_buffer_0[7u].y, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].y, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].y, vertex_unnamed_240, vertex_unnamed_262)));
				vertex_output_5.z = mad(vertex_uniform_buffer_0[7u].z, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].z, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].z, vertex_unnamed_240, vertex_unnamed_263)));
				vertex_output_6.x = 0.0f;
				vertex_output_6.y = 0.0f;
				vertex_output_6.z = 0.0f;
				vertex_output_6.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				vertex_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				vertex_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				vertex_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				vertex_uniform_buffer_0[10] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_2[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_2[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_2[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}


			float4 _LightColor0;
			float4x4 unity_WorldToLight;
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 _LightPositionRange;
			float4 _LightProjectionParams;
			float4 unity_OcclusionMaskSelector;
			float4 _LightShadowData;
			float4 unity_ShadowFadeCenterAndType;
			float4x4 unity_MatrixV;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[10];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[26];
			static float4 fragment_uniform_buffer_4[13];
			static float4 fragment_uniform_buffer_5[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _LightTextureB0;
			TextureCube<float4> _LightTexture0;
			Texture3D<float4> unity_ProbeVolumeSH;
			TextureCube<float4> _ShadowMapTexture;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerComparisonState sampler_ShadowMapTexture;
			SamplerState sampler_LightTexture0;
			SamplerState sampler_LightTextureB0;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float3 fragment_input_5 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_6 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_84 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_89 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_93 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_100 = fragment_unnamed_84 + fragment_uniform_buffer_2[0u].x;
				precise float fragment_unnamed_101 = fragment_unnamed_89 + fragment_uniform_buffer_2[0u].y;
				precise float fragment_unnamed_102 = fragment_unnamed_93 + fragment_uniform_buffer_2[0u].z;
				float fragment_unnamed_107 = rsqrt(dot(float3(fragment_unnamed_100, fragment_unnamed_101, fragment_unnamed_102), float3(fragment_unnamed_100, fragment_unnamed_101, fragment_unnamed_102)));
				precise float fragment_unnamed_108 = fragment_unnamed_107 * fragment_unnamed_100;
				precise float fragment_unnamed_109 = fragment_unnamed_107 * fragment_unnamed_101;
				precise float fragment_unnamed_110 = fragment_unnamed_107 * fragment_unnamed_102;
				precise float fragment_unnamed_113 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_116 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_119 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_126 = fragment_unnamed_113 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_127 = fragment_unnamed_116 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_128 = fragment_unnamed_119 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_132 = rsqrt(dot(float3(fragment_unnamed_126, fragment_unnamed_127, fragment_unnamed_128), float3(fragment_unnamed_126, fragment_unnamed_127, fragment_unnamed_128)));
				precise float fragment_unnamed_133 = fragment_unnamed_132 * fragment_unnamed_126;
				precise float fragment_unnamed_134 = fragment_unnamed_132 * fragment_unnamed_127;
				precise float fragment_unnamed_135 = fragment_unnamed_132 * fragment_unnamed_128;
				float4 fragment_unnamed_143 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_154 = fragment_unnamed_143.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_155 = fragment_unnamed_143.y * fragment_uniform_buffer_0[9u].y;
				precise float fragment_unnamed_156 = fragment_unnamed_143.z * fragment_uniform_buffer_0[9u].z;
				precise float fragment_unnamed_163 = fragment_unnamed_154 * fragment_input_4.x;
				precise float fragment_unnamed_164 = fragment_unnamed_155 * fragment_input_4.y;
				precise float fragment_unnamed_165 = fragment_unnamed_156 * fragment_input_4.z;
				precise float fragment_unnamed_173 = fragment_input_3.y * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_174 = fragment_input_3.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_175 = fragment_input_3.y * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_202 = mad(fragment_uniform_buffer_0[6u].x, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].x, fragment_input_3.x, fragment_unnamed_173)) + fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_203 = mad(fragment_uniform_buffer_0[6u].y, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].y, fragment_input_3.x, fragment_unnamed_174)) + fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_204 = mad(fragment_uniform_buffer_0[6u].z, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].z, fragment_input_3.x, fragment_unnamed_175)) + fragment_uniform_buffer_0[7u].z;
				float fragment_unnamed_222 = dot(float3(fragment_unnamed_126, fragment_unnamed_127, fragment_unnamed_128), float3(asfloat(asuint(fragment_uniform_buffer_4[9u]).z), asfloat(asuint(fragment_uniform_buffer_4[10u]).z), asfloat(asuint(fragment_uniform_buffer_4[11u]).z)));
				precise float fragment_unnamed_235 = (-0.0f) - fragment_uniform_buffer_3[25u].x;
				precise float fragment_unnamed_237 = (-0.0f) - fragment_uniform_buffer_3[25u].y;
				precise float fragment_unnamed_239 = (-0.0f) - fragment_uniform_buffer_3[25u].z;
				precise float fragment_unnamed_240 = fragment_input_3.x + fragment_unnamed_235;
				precise float fragment_unnamed_241 = fragment_input_3.y + fragment_unnamed_237;
				precise float fragment_unnamed_242 = fragment_input_3.z + fragment_unnamed_239;
				precise float fragment_unnamed_247 = (-0.0f) - fragment_unnamed_222;
				precise float fragment_unnamed_248 = fragment_unnamed_247 + sqrt(dot(float3(fragment_unnamed_240, fragment_unnamed_241, fragment_unnamed_242), float3(fragment_unnamed_240, fragment_unnamed_241, fragment_unnamed_242)));
				float fragment_unnamed_361;
				float fragment_unnamed_362;
				float fragment_unnamed_363;
				float fragment_unnamed_364;
				if (fragment_uniform_buffer_5[0u].x == 1.0f)
				{
					bool fragment_unnamed_271 = fragment_uniform_buffer_5[0u].y == 1.0f;
					precise float fragment_unnamed_279 = fragment_input_3.y * fragment_uniform_buffer_5[2u].x;
					precise float fragment_unnamed_280 = fragment_input_3.y * fragment_uniform_buffer_5[2u].y;
					precise float fragment_unnamed_281 = fragment_input_3.y * fragment_uniform_buffer_5[2u].z;
					precise float fragment_unnamed_308 = mad(fragment_uniform_buffer_5[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].x, fragment_input_3.x, fragment_unnamed_279)) + fragment_uniform_buffer_5[4u].x;
					precise float fragment_unnamed_309 = mad(fragment_uniform_buffer_5[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].y, fragment_input_3.x, fragment_unnamed_280)) + fragment_uniform_buffer_5[4u].y;
					precise float fragment_unnamed_310 = mad(fragment_uniform_buffer_5[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].z, fragment_input_3.x, fragment_unnamed_281)) + fragment_uniform_buffer_5[4u].z;
					precise float fragment_unnamed_323 = (-0.0f) - fragment_uniform_buffer_5[6u].x;
					precise float fragment_unnamed_325 = (-0.0f) - fragment_uniform_buffer_5[6u].y;
					precise float fragment_unnamed_327 = (-0.0f) - fragment_uniform_buffer_5[6u].z;
					precise float fragment_unnamed_328 = (fragment_unnamed_271 ? fragment_unnamed_308 : fragment_input_3.x) + fragment_unnamed_323;
					precise float fragment_unnamed_329 = (fragment_unnamed_271 ? fragment_unnamed_309 : fragment_input_3.y) + fragment_unnamed_325;
					precise float fragment_unnamed_330 = (fragment_unnamed_271 ? fragment_unnamed_310 : fragment_input_3.z) + fragment_unnamed_327;
					precise float fragment_unnamed_336 = fragment_unnamed_328 * fragment_uniform_buffer_5[5u].x;
					precise float fragment_unnamed_337 = fragment_unnamed_329 * fragment_uniform_buffer_5[5u].y;
					precise float fragment_unnamed_338 = fragment_unnamed_330 * fragment_uniform_buffer_5[5u].z;
					float4 fragment_unnamed_350 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_336, 0.25f, 0.75f), mad(fragment_uniform_buffer_5[0u].z, 0.5f, 0.75f)), fragment_unnamed_337, fragment_unnamed_338));
					fragment_unnamed_361 = fragment_unnamed_350.x;
					fragment_unnamed_362 = fragment_unnamed_350.y;
					fragment_unnamed_363 = fragment_unnamed_350.z;
					fragment_unnamed_364 = fragment_unnamed_350.w;
				}
				else
				{
					fragment_unnamed_361 = asfloat(1065353216u);
					fragment_unnamed_362 = asfloat(1065353216u);
					fragment_unnamed_363 = asfloat(1065353216u);
					fragment_unnamed_364 = asfloat(1065353216u);
				}
				precise float fragment_unnamed_385 = (-0.0f) - fragment_uniform_buffer_2[1u].x;
				precise float fragment_unnamed_387 = (-0.0f) - fragment_uniform_buffer_2[1u].y;
				precise float fragment_unnamed_389 = (-0.0f) - fragment_uniform_buffer_2[1u].z;
				precise float fragment_unnamed_390 = fragment_input_3.x + fragment_unnamed_385;
				precise float fragment_unnamed_391 = fragment_input_3.y + fragment_unnamed_387;
				precise float fragment_unnamed_392 = fragment_input_3.z + fragment_unnamed_389;
				precise float fragment_unnamed_401 = (-0.0f) - fragment_uniform_buffer_2[2u].z;
				precise float fragment_unnamed_402 = max(abs(fragment_unnamed_392), max(abs(fragment_unnamed_391), abs(fragment_unnamed_390))) + fragment_unnamed_401;
				precise float fragment_unnamed_408 = max(fragment_unnamed_402, 9.9999997473787516355514526367188e-06f) * fragment_uniform_buffer_2[2u].w;
				precise float fragment_unnamed_412 = fragment_uniform_buffer_2[2u].y / fragment_unnamed_408;
				precise float fragment_unnamed_416 = (-0.0f) - fragment_uniform_buffer_2[2u].x;
				precise float fragment_unnamed_417 = fragment_unnamed_412 + fragment_unnamed_416;
				precise float fragment_unnamed_418 = (-0.0f) - fragment_unnamed_417;
				precise float fragment_unnamed_419 = fragment_unnamed_418 + 1.0f;
				precise float fragment_unnamed_430 = (-0.0f) - fragment_uniform_buffer_3[24u].x;
				precise float fragment_unnamed_431 = fragment_unnamed_430 + 1.0f;
				float fragment_unnamed_435 = mad(_ShadowMapTexture.SampleCmpLevelZero(sampler_ShadowMapTexture, float3(fragment_unnamed_390, fragment_unnamed_391, fragment_unnamed_392), fragment_unnamed_419).xxxx.x, fragment_unnamed_431, fragment_uniform_buffer_3[24u].x);
				precise float fragment_unnamed_436 = (-0.0f) - fragment_unnamed_435;
				precise float fragment_unnamed_437 = fragment_unnamed_436 + clamp(dot(float4(fragment_unnamed_361, fragment_unnamed_362, fragment_unnamed_363, fragment_unnamed_364), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f);
				precise float fragment_unnamed_451 = _LightTextureB0.Sample(sampler_LightTextureB0, dot(float3(fragment_unnamed_202, fragment_unnamed_203, fragment_unnamed_204), float3(fragment_unnamed_202, fragment_unnamed_203, fragment_unnamed_204)).xx).x * _LightTexture0.Sample(sampler_LightTexture0, float3(fragment_unnamed_202, fragment_unnamed_203, fragment_unnamed_204)).w;
				precise float fragment_unnamed_452 = mad(clamp(mad(mad(fragment_uniform_buffer_3[25u].w, fragment_unnamed_248, fragment_unnamed_222), fragment_uniform_buffer_3[24u].z, fragment_uniform_buffer_3[24u].w), 0.0f, 1.0f), fragment_unnamed_437, fragment_unnamed_435) * fragment_unnamed_451;
				precise float fragment_unnamed_458 = fragment_unnamed_452 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_459 = fragment_unnamed_452 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_460 = fragment_unnamed_452 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_476 = rsqrt(dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z)));
				precise float fragment_unnamed_483 = fragment_unnamed_476 * fragment_input_2.x;
				precise float fragment_unnamed_484 = fragment_unnamed_476 * fragment_input_2.y;
				precise float fragment_unnamed_485 = fragment_unnamed_476 * fragment_input_2.z;
				float fragment_unnamed_500 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_154, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_502 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_155, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_503 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_156, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_507 = (-0.0f) - fragment_uniform_buffer_0[8u].y;
				float fragment_unnamed_508 = mad(fragment_unnamed_507, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_510 = fragment_unnamed_508 * fragment_unnamed_163;
				precise float fragment_unnamed_511 = fragment_unnamed_508 * fragment_unnamed_164;
				precise float fragment_unnamed_512 = fragment_unnamed_508 * fragment_unnamed_165;
				precise float fragment_unnamed_516 = (-0.0f) - fragment_uniform_buffer_0[8u].x;
				precise float fragment_unnamed_517 = fragment_unnamed_516 + 1.0f;
				float fragment_unnamed_518 = mad(fragment_unnamed_100, fragment_unnamed_107, fragment_unnamed_133);
				float fragment_unnamed_519 = mad(fragment_unnamed_101, fragment_unnamed_107, fragment_unnamed_134);
				float fragment_unnamed_520 = mad(fragment_unnamed_102, fragment_unnamed_107, fragment_unnamed_135);
				float fragment_unnamed_526 = rsqrt(max(dot(float3(fragment_unnamed_518, fragment_unnamed_519, fragment_unnamed_520), float3(fragment_unnamed_518, fragment_unnamed_519, fragment_unnamed_520)), 0.001000000047497451305389404296875f));
				precise float fragment_unnamed_527 = fragment_unnamed_526 * fragment_unnamed_518;
				precise float fragment_unnamed_528 = fragment_unnamed_526 * fragment_unnamed_519;
				precise float fragment_unnamed_529 = fragment_unnamed_526 * fragment_unnamed_520;
				float fragment_unnamed_530 = dot(float3(fragment_unnamed_483, fragment_unnamed_484, fragment_unnamed_485), float3(fragment_unnamed_133, fragment_unnamed_134, fragment_unnamed_135));
				float fragment_unnamed_536 = clamp(dot(float3(fragment_unnamed_483, fragment_unnamed_484, fragment_unnamed_485), float3(fragment_unnamed_108, fragment_unnamed_109, fragment_unnamed_110)), 0.0f, 1.0f);
				float fragment_unnamed_540 = clamp(dot(float3(fragment_unnamed_483, fragment_unnamed_484, fragment_unnamed_485), float3(fragment_unnamed_527, fragment_unnamed_528, fragment_unnamed_529)), 0.0f, 1.0f);
				float fragment_unnamed_544 = clamp(dot(float3(fragment_unnamed_108, fragment_unnamed_109, fragment_unnamed_110), float3(fragment_unnamed_527, fragment_unnamed_528, fragment_unnamed_529)), 0.0f, 1.0f);
				precise float fragment_unnamed_545 = fragment_unnamed_544 * fragment_unnamed_544;
				precise float fragment_unnamed_549 = dot(fragment_unnamed_545.xx, fragment_unnamed_517.xx) + (-0.5f);
				precise float fragment_unnamed_551 = (-0.0f) - fragment_unnamed_536;
				precise float fragment_unnamed_552 = fragment_unnamed_551 + 1.0f;
				precise float fragment_unnamed_553 = fragment_unnamed_552 * fragment_unnamed_552;
				precise float fragment_unnamed_554 = fragment_unnamed_553 * fragment_unnamed_553;
				precise float fragment_unnamed_555 = fragment_unnamed_552 * fragment_unnamed_554;
				precise float fragment_unnamed_558 = (-0.0f) - abs(fragment_unnamed_530);
				precise float fragment_unnamed_559 = fragment_unnamed_558 + 1.0f;
				precise float fragment_unnamed_560 = fragment_unnamed_559 * fragment_unnamed_559;
				precise float fragment_unnamed_561 = fragment_unnamed_560 * fragment_unnamed_560;
				precise float fragment_unnamed_562 = fragment_unnamed_559 * fragment_unnamed_561;
				precise float fragment_unnamed_564 = mad(fragment_unnamed_549, fragment_unnamed_562, 1.0f) * mad(fragment_unnamed_549, fragment_unnamed_555, 1.0f);
				precise float fragment_unnamed_565 = fragment_unnamed_517 * fragment_unnamed_517;
				float fragment_unnamed_566 = max(fragment_unnamed_565, 0.00200000009499490261077880859375f);
				precise float fragment_unnamed_568 = (-0.0f) - fragment_unnamed_566;
				precise float fragment_unnamed_569 = fragment_unnamed_568 + 1.0f;
				precise float fragment_unnamed_574 = abs(fragment_unnamed_530) * mad(fragment_unnamed_536, fragment_unnamed_569, fragment_unnamed_566);
				precise float fragment_unnamed_576 = mad(fragment_unnamed_536, mad(abs(fragment_unnamed_530), fragment_unnamed_569, fragment_unnamed_566), fragment_unnamed_574) + 9.9999997473787516355514526367188e-06f;
				precise float fragment_unnamed_577 = 0.5f / fragment_unnamed_576;
				precise float fragment_unnamed_578 = fragment_unnamed_566 * fragment_unnamed_566;
				precise float fragment_unnamed_579 = (-0.0f) - fragment_unnamed_540;
				float fragment_unnamed_581 = mad(mad(fragment_unnamed_540, fragment_unnamed_578, fragment_unnamed_579), fragment_unnamed_540, 1.0f);
				precise float fragment_unnamed_582 = fragment_unnamed_578 * 0.3183098733425140380859375f;
				precise float fragment_unnamed_586 = fragment_unnamed_582 / mad(fragment_unnamed_581, fragment_unnamed_581, 1.0000000116860974230803549289703e-07f);
				precise float fragment_unnamed_587 = fragment_unnamed_586 * fragment_unnamed_577;
				precise float fragment_unnamed_588 = fragment_unnamed_587 * 3.1415927410125732421875f;
				precise float fragment_unnamed_593 = fragment_unnamed_536 * fragment_unnamed_564;
				precise float fragment_unnamed_594 = fragment_unnamed_536 * sqrt(max(fragment_unnamed_588, 9.9999997473787516355514526367188e-05f));
				precise float fragment_unnamed_603 = asfloat(((dot(float3(fragment_unnamed_500, fragment_unnamed_502, fragment_unnamed_503), float3(fragment_unnamed_500, fragment_unnamed_502, fragment_unnamed_503)) != 0.0f) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_594;
				precise float fragment_unnamed_604 = fragment_unnamed_593 * fragment_unnamed_458;
				precise float fragment_unnamed_605 = fragment_unnamed_593 * fragment_unnamed_459;
				precise float fragment_unnamed_606 = fragment_unnamed_593 * fragment_unnamed_460;
				precise float fragment_unnamed_607 = fragment_unnamed_458 * fragment_unnamed_603;
				precise float fragment_unnamed_608 = fragment_unnamed_459 * fragment_unnamed_603;
				precise float fragment_unnamed_609 = fragment_unnamed_460 * fragment_unnamed_603;
				precise float fragment_unnamed_610 = (-0.0f) - fragment_unnamed_544;
				precise float fragment_unnamed_611 = fragment_unnamed_610 + 1.0f;
				precise float fragment_unnamed_612 = fragment_unnamed_611 * fragment_unnamed_611;
				precise float fragment_unnamed_613 = fragment_unnamed_612 * fragment_unnamed_612;
				precise float fragment_unnamed_614 = fragment_unnamed_611 * fragment_unnamed_613;
				precise float fragment_unnamed_615 = (-0.0f) - fragment_unnamed_500;
				precise float fragment_unnamed_616 = (-0.0f) - fragment_unnamed_502;
				precise float fragment_unnamed_617 = (-0.0f) - fragment_unnamed_503;
				precise float fragment_unnamed_618 = fragment_unnamed_615 + 1.0f;
				precise float fragment_unnamed_619 = fragment_unnamed_616 + 1.0f;
				precise float fragment_unnamed_620 = fragment_unnamed_617 + 1.0f;
				precise float fragment_unnamed_624 = fragment_unnamed_607 * mad(fragment_unnamed_618, fragment_unnamed_614, fragment_unnamed_500);
				precise float fragment_unnamed_625 = fragment_unnamed_608 * mad(fragment_unnamed_619, fragment_unnamed_614, fragment_unnamed_502);
				precise float fragment_unnamed_626 = fragment_unnamed_609 * mad(fragment_unnamed_620, fragment_unnamed_614, fragment_unnamed_503);
				fragment_output_0.x = mad(fragment_unnamed_510, fragment_unnamed_604, fragment_unnamed_624);
				fragment_output_0.y = mad(fragment_unnamed_511, fragment_unnamed_605, fragment_unnamed_625);
				fragment_output_0.z = mad(fragment_unnamed_512, fragment_unnamed_606, fragment_unnamed_626);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				fragment_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				fragment_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				fragment_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_uniform_buffer_0[8] = float4(_Glossiness, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _Metallic, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[9] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_uniform_buffer_2[1] = float4(_LightPositionRange[0], _LightPositionRange[1], _LightPositionRange[2], _LightPositionRange[3]);

				fragment_uniform_buffer_2[2] = float4(_LightProjectionParams[0], _LightProjectionParams[1], _LightProjectionParams[2], _LightProjectionParams[3]);

				fragment_uniform_buffer_2[46] = float4(unity_OcclusionMaskSelector[0], unity_OcclusionMaskSelector[1], unity_OcclusionMaskSelector[2], unity_OcclusionMaskSelector[3]);

				fragment_uniform_buffer_3[24] = float4(_LightShadowData[0], _LightShadowData[1], _LightShadowData[2], _LightShadowData[3]);

				fragment_uniform_buffer_3[25] = float4(unity_ShadowFadeCenterAndType[0], unity_ShadowFadeCenterAndType[1], unity_ShadowFadeCenterAndType[2], unity_ShadowFadeCenterAndType[3]);

				fragment_uniform_buffer_4[9] = float4(unity_MatrixV[0][0], unity_MatrixV[1][0], unity_MatrixV[2][0], unity_MatrixV[3][0]);
				fragment_uniform_buffer_4[10] = float4(unity_MatrixV[0][1], unity_MatrixV[1][1], unity_MatrixV[2][1], unity_MatrixV[3][1]);
				fragment_uniform_buffer_4[11] = float4(unity_MatrixV[0][2], unity_MatrixV[1][2], unity_MatrixV[2][2], unity_MatrixV[3][2]);
				fragment_uniform_buffer_4[12] = float4(unity_MatrixV[0][3], unity_MatrixV[1][3], unity_MatrixV[2][3], unity_MatrixV[3][3]);

				fragment_uniform_buffer_5[0] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_5[1] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_5[2] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_5[3] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_5[4] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_5[5] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], fragment_uniform_buffer_5[5][3]);

				fragment_uniform_buffer_5[6] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], fragment_uniform_buffer_5[6][3]);

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

			#endif // defined(POINT_COOKIE) && defined(SHADOWS_CUBE) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SOFT) && !defined(SHADOWS_SCREEN)


			#if defined(POINT_COOKIE) && defined(SHADOWS_CUBE) && defined(SHADOWS_SOFT) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SCREEN)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 unity_WorldToLight;
			float4 _MainTex_ST;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[11];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static float4 vertex_output_6;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float3 vertex_output_5 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_6 : TEXCOORD4; // TEXCOORD_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_59 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_60 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_57));
				float vertex_unnamed_84 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_58));
				float vertex_unnamed_85 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_59));
				float vertex_unnamed_86 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_60));
				precise float vertex_unnamed_94 = vertex_unnamed_83 + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_95 = vertex_unnamed_84 + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_96 = vertex_unnamed_85 + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_97 = vertex_unnamed_86 + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_105 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_106 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_107 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_108 = vertex_unnamed_95 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_94, vertex_unnamed_105)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_94, vertex_unnamed_106)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_94, vertex_unnamed_107)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_97, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_96, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_94, vertex_unnamed_108)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[10u].x, vertex_uniform_buffer_0[10u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[10u].y, vertex_uniform_buffer_0[10u].w);
				float vertex_unnamed_176 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_191 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_206 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_212 = rsqrt(dot(float3(vertex_unnamed_176, vertex_unnamed_191, vertex_unnamed_206), float3(vertex_unnamed_176, vertex_unnamed_191, vertex_unnamed_206)));
				precise float vertex_unnamed_213 = vertex_unnamed_212 * vertex_unnamed_176;
				precise float vertex_unnamed_214 = vertex_unnamed_212 * vertex_unnamed_191;
				precise float vertex_unnamed_215 = vertex_unnamed_212 * vertex_unnamed_206;
				vertex_output_2.x = vertex_unnamed_213;
				vertex_output_2.y = vertex_unnamed_214;
				vertex_output_2.z = vertex_unnamed_215;
				vertex_output_3.x = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				vertex_output_3.y = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				vertex_output_3.z = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				float vertex_unnamed_240 = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_83);
				float vertex_unnamed_241 = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_84);
				float vertex_unnamed_242 = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_85);
				float vertex_unnamed_243 = mad(vertex_uniform_buffer_1[3u].w, vertex_input_0.w, vertex_unnamed_86);
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				precise float vertex_unnamed_261 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].x;
				precise float vertex_unnamed_262 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].y;
				precise float vertex_unnamed_263 = vertex_unnamed_241 * vertex_uniform_buffer_0[5u].z;
				vertex_output_5.x = mad(vertex_uniform_buffer_0[7u].x, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].x, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].x, vertex_unnamed_240, vertex_unnamed_261)));
				vertex_output_5.y = mad(vertex_uniform_buffer_0[7u].y, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].y, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].y, vertex_unnamed_240, vertex_unnamed_262)));
				vertex_output_5.z = mad(vertex_uniform_buffer_0[7u].z, vertex_unnamed_243, mad(vertex_uniform_buffer_0[6u].z, vertex_unnamed_242, mad(vertex_uniform_buffer_0[4u].z, vertex_unnamed_240, vertex_unnamed_263)));
				vertex_output_6.x = 0.0f;
				vertex_output_6.y = 0.0f;
				vertex_output_6.z = 0.0f;
				vertex_output_6.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				vertex_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				vertex_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				vertex_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				vertex_uniform_buffer_0[10] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_2[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_2[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_2[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}


			float4 _LightColor0;
			float4x4 unity_WorldToLight;
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float3 _WorldSpaceCameraPos;
			float4 _WorldSpaceLightPos0;
			float4 _LightPositionRange;
			float4 _LightProjectionParams;
			float4 unity_OcclusionMaskSelector;
			float4 _LightShadowData;
			float4 unity_ShadowFadeCenterAndType;
			float4x4 unity_MatrixV;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[10];
			static float4 fragment_uniform_buffer_1[5];
			static float4 fragment_uniform_buffer_2[47];
			static float4 fragment_uniform_buffer_3[26];
			static float4 fragment_uniform_buffer_4[13];
			static float4 fragment_uniform_buffer_5[7];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _LightTextureB0;
			TextureCube<float4> _LightTexture0;
			Texture3D<float4> unity_ProbeVolumeSH;
			TextureCube<float4> _ShadowMapTexture;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerComparisonState sampler_ShadowMapTexture;
			SamplerState sampler_LightTexture0;
			SamplerState sampler_LightTextureB0;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float3 fragment_input_5 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_6 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				precise float fragment_unnamed_84 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_89 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_93 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_100 = fragment_unnamed_84 + fragment_uniform_buffer_2[0u].x;
				precise float fragment_unnamed_101 = fragment_unnamed_89 + fragment_uniform_buffer_2[0u].y;
				precise float fragment_unnamed_102 = fragment_unnamed_93 + fragment_uniform_buffer_2[0u].z;
				float fragment_unnamed_107 = rsqrt(dot(float3(fragment_unnamed_100, fragment_unnamed_101, fragment_unnamed_102), float3(fragment_unnamed_100, fragment_unnamed_101, fragment_unnamed_102)));
				precise float fragment_unnamed_108 = fragment_unnamed_107 * fragment_unnamed_100;
				precise float fragment_unnamed_109 = fragment_unnamed_107 * fragment_unnamed_101;
				precise float fragment_unnamed_110 = fragment_unnamed_107 * fragment_unnamed_102;
				precise float fragment_unnamed_113 = (-0.0f) - fragment_input_3.x;
				precise float fragment_unnamed_116 = (-0.0f) - fragment_input_3.y;
				precise float fragment_unnamed_119 = (-0.0f) - fragment_input_3.z;
				precise float fragment_unnamed_126 = fragment_unnamed_113 + fragment_uniform_buffer_1[4u].x;
				precise float fragment_unnamed_127 = fragment_unnamed_116 + fragment_uniform_buffer_1[4u].y;
				precise float fragment_unnamed_128 = fragment_unnamed_119 + fragment_uniform_buffer_1[4u].z;
				float fragment_unnamed_132 = rsqrt(dot(float3(fragment_unnamed_126, fragment_unnamed_127, fragment_unnamed_128), float3(fragment_unnamed_126, fragment_unnamed_127, fragment_unnamed_128)));
				precise float fragment_unnamed_133 = fragment_unnamed_132 * fragment_unnamed_126;
				precise float fragment_unnamed_134 = fragment_unnamed_132 * fragment_unnamed_127;
				precise float fragment_unnamed_135 = fragment_unnamed_132 * fragment_unnamed_128;
				float4 fragment_unnamed_143 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_154 = fragment_unnamed_143.x * fragment_uniform_buffer_0[9u].x;
				precise float fragment_unnamed_155 = fragment_unnamed_143.y * fragment_uniform_buffer_0[9u].y;
				precise float fragment_unnamed_156 = fragment_unnamed_143.z * fragment_uniform_buffer_0[9u].z;
				precise float fragment_unnamed_163 = fragment_unnamed_154 * fragment_input_4.x;
				precise float fragment_unnamed_164 = fragment_unnamed_155 * fragment_input_4.y;
				precise float fragment_unnamed_165 = fragment_unnamed_156 * fragment_input_4.z;
				precise float fragment_unnamed_173 = fragment_input_3.y * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_174 = fragment_input_3.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_175 = fragment_input_3.y * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_202 = mad(fragment_uniform_buffer_0[6u].x, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].x, fragment_input_3.x, fragment_unnamed_173)) + fragment_uniform_buffer_0[7u].x;
				precise float fragment_unnamed_203 = mad(fragment_uniform_buffer_0[6u].y, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].y, fragment_input_3.x, fragment_unnamed_174)) + fragment_uniform_buffer_0[7u].y;
				precise float fragment_unnamed_204 = mad(fragment_uniform_buffer_0[6u].z, fragment_input_3.z, mad(fragment_uniform_buffer_0[4u].z, fragment_input_3.x, fragment_unnamed_175)) + fragment_uniform_buffer_0[7u].z;
				float fragment_unnamed_222 = dot(float3(fragment_unnamed_126, fragment_unnamed_127, fragment_unnamed_128), float3(asfloat(asuint(fragment_uniform_buffer_4[9u]).z), asfloat(asuint(fragment_uniform_buffer_4[10u]).z), asfloat(asuint(fragment_uniform_buffer_4[11u]).z)));
				precise float fragment_unnamed_235 = (-0.0f) - fragment_uniform_buffer_3[25u].x;
				precise float fragment_unnamed_237 = (-0.0f) - fragment_uniform_buffer_3[25u].y;
				precise float fragment_unnamed_239 = (-0.0f) - fragment_uniform_buffer_3[25u].z;
				precise float fragment_unnamed_240 = fragment_input_3.x + fragment_unnamed_235;
				precise float fragment_unnamed_241 = fragment_input_3.y + fragment_unnamed_237;
				precise float fragment_unnamed_242 = fragment_input_3.z + fragment_unnamed_239;
				precise float fragment_unnamed_247 = (-0.0f) - fragment_unnamed_222;
				precise float fragment_unnamed_248 = fragment_unnamed_247 + sqrt(dot(float3(fragment_unnamed_240, fragment_unnamed_241, fragment_unnamed_242), float3(fragment_unnamed_240, fragment_unnamed_241, fragment_unnamed_242)));
				float fragment_unnamed_262 = clamp(mad(mad(fragment_uniform_buffer_3[25u].w, fragment_unnamed_248, fragment_unnamed_222), fragment_uniform_buffer_3[24u].z, fragment_uniform_buffer_3[24u].w), 0.0f, 1.0f);
				float fragment_unnamed_361;
				float fragment_unnamed_362;
				float fragment_unnamed_363;
				float fragment_unnamed_364;
				if (fragment_uniform_buffer_5[0u].x == 1.0f)
				{
					bool fragment_unnamed_271 = fragment_uniform_buffer_5[0u].y == 1.0f;
					precise float fragment_unnamed_279 = fragment_input_3.y * fragment_uniform_buffer_5[2u].x;
					precise float fragment_unnamed_280 = fragment_input_3.y * fragment_uniform_buffer_5[2u].y;
					precise float fragment_unnamed_281 = fragment_input_3.y * fragment_uniform_buffer_5[2u].z;
					precise float fragment_unnamed_308 = mad(fragment_uniform_buffer_5[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].x, fragment_input_3.x, fragment_unnamed_279)) + fragment_uniform_buffer_5[4u].x;
					precise float fragment_unnamed_309 = mad(fragment_uniform_buffer_5[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].y, fragment_input_3.x, fragment_unnamed_280)) + fragment_uniform_buffer_5[4u].y;
					precise float fragment_unnamed_310 = mad(fragment_uniform_buffer_5[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_5[1u].z, fragment_input_3.x, fragment_unnamed_281)) + fragment_uniform_buffer_5[4u].z;
					precise float fragment_unnamed_323 = (-0.0f) - fragment_uniform_buffer_5[6u].x;
					precise float fragment_unnamed_325 = (-0.0f) - fragment_uniform_buffer_5[6u].y;
					precise float fragment_unnamed_327 = (-0.0f) - fragment_uniform_buffer_5[6u].z;
					precise float fragment_unnamed_328 = (fragment_unnamed_271 ? fragment_unnamed_308 : fragment_input_3.x) + fragment_unnamed_323;
					precise float fragment_unnamed_329 = (fragment_unnamed_271 ? fragment_unnamed_309 : fragment_input_3.y) + fragment_unnamed_325;
					precise float fragment_unnamed_330 = (fragment_unnamed_271 ? fragment_unnamed_310 : fragment_input_3.z) + fragment_unnamed_327;
					precise float fragment_unnamed_336 = fragment_unnamed_328 * fragment_uniform_buffer_5[5u].x;
					precise float fragment_unnamed_337 = fragment_unnamed_329 * fragment_uniform_buffer_5[5u].y;
					precise float fragment_unnamed_338 = fragment_unnamed_330 * fragment_uniform_buffer_5[5u].z;
					float4 fragment_unnamed_350 = unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(max(mad(fragment_unnamed_336, 0.25f, 0.75f), mad(fragment_uniform_buffer_5[0u].z, 0.5f, 0.75f)), fragment_unnamed_337, fragment_unnamed_338));
					fragment_unnamed_361 = fragment_unnamed_350.y;
					fragment_unnamed_362 = fragment_unnamed_350.z;
					fragment_unnamed_363 = fragment_unnamed_350.x;
					fragment_unnamed_364 = fragment_unnamed_350.w;
				}
				else
				{
					fragment_unnamed_361 = asfloat(1065353216u);
					fragment_unnamed_362 = asfloat(1065353216u);
					fragment_unnamed_363 = asfloat(1065353216u);
					fragment_unnamed_364 = asfloat(1065353216u);
				}
				float fragment_unnamed_468;
				if (fragment_unnamed_262 < 0.9900000095367431640625f)
				{
					precise float fragment_unnamed_387 = (-0.0f) - fragment_uniform_buffer_2[1u].x;
					precise float fragment_unnamed_389 = (-0.0f) - fragment_uniform_buffer_2[1u].y;
					precise float fragment_unnamed_391 = (-0.0f) - fragment_uniform_buffer_2[1u].z;
					precise float fragment_unnamed_392 = fragment_input_3.x + fragment_unnamed_387;
					precise float fragment_unnamed_393 = fragment_input_3.y + fragment_unnamed_389;
					precise float fragment_unnamed_394 = fragment_input_3.z + fragment_unnamed_391;
					precise float fragment_unnamed_403 = (-0.0f) - fragment_uniform_buffer_2[2u].z;
					precise float fragment_unnamed_404 = max(abs(fragment_unnamed_394), max(abs(fragment_unnamed_393), abs(fragment_unnamed_392))) + fragment_unnamed_403;
					precise float fragment_unnamed_410 = max(fragment_unnamed_404, 9.9999997473787516355514526367188e-06f) * fragment_uniform_buffer_2[2u].w;
					precise float fragment_unnamed_414 = fragment_uniform_buffer_2[2u].y / fragment_unnamed_410;
					precise float fragment_unnamed_418 = (-0.0f) - fragment_uniform_buffer_2[2u].x;
					precise float fragment_unnamed_419 = fragment_unnamed_414 + fragment_unnamed_418;
					precise float fragment_unnamed_420 = (-0.0f) - fragment_unnamed_419;
					precise float fragment_unnamed_421 = fragment_unnamed_420 + 1.0f;
					precise float fragment_unnamed_422 = fragment_unnamed_392 + 0.0078125f;
					precise float fragment_unnamed_424 = fragment_unnamed_393 + 0.0078125f;
					precise float fragment_unnamed_425 = fragment_unnamed_394 + 0.0078125f;
					precise float fragment_unnamed_433 = fragment_unnamed_392 + (-0.0078125f);
					precise float fragment_unnamed_435 = fragment_unnamed_393 + (-0.0078125f);
					precise float fragment_unnamed_436 = fragment_unnamed_394 + 0.0078125f;
					precise float fragment_unnamed_441 = fragment_unnamed_392 + (-0.0078125f);
					precise float fragment_unnamed_442 = fragment_unnamed_393 + 0.0078125f;
					precise float fragment_unnamed_443 = fragment_unnamed_394 + (-0.0078125f);
					precise float fragment_unnamed_448 = fragment_unnamed_392 + 0.0078125f;
					precise float fragment_unnamed_449 = fragment_unnamed_393 + (-0.0078125f);
					precise float fragment_unnamed_450 = fragment_unnamed_394 + (-0.0078125f);
					precise float fragment_unnamed_461 = (-0.0f) - fragment_uniform_buffer_3[24u].x;
					precise float fragment_unnamed_462 = fragment_unnamed_461 + 1.0f;
					fragment_unnamed_468 = mad(dot(float4(_ShadowMapTexture.SampleCmpLevelZero(sampler_ShadowMapTexture, float3(fragment_unnamed_422, fragment_unnamed_424, fragment_unnamed_425), fragment_unnamed_421).xxxx.x, _ShadowMapTexture.SampleCmpLevelZero(sampler_ShadowMapTexture, float3(fragment_unnamed_433, fragment_unnamed_435, fragment_unnamed_436), fragment_unnamed_421).xxxx.x, _ShadowMapTexture.SampleCmpLevelZero(sampler_ShadowMapTexture, float3(fragment_unnamed_441, fragment_unnamed_442, fragment_unnamed_443), fragment_unnamed_421).xxxx.x, _ShadowMapTexture.SampleCmpLevelZero(sampler_ShadowMapTexture, float3(fragment_unnamed_448, fragment_unnamed_449, fragment_unnamed_450), fragment_unnamed_421).xxxx.x), 0.25f.xxxx), fragment_unnamed_462, fragment_uniform_buffer_3[24u].x);
				}
				else
				{
					fragment_unnamed_468 = asfloat(1065353216u);
				}
				precise float fragment_unnamed_469 = (-0.0f) - fragment_unnamed_468;
				precise float fragment_unnamed_470 = fragment_unnamed_469 + clamp(dot(float4(fragment_unnamed_363, fragment_unnamed_361, fragment_unnamed_362, fragment_unnamed_364), float4(fragment_uniform_buffer_2[46u])), 0.0f, 1.0f);
				precise float fragment_unnamed_484 = _LightTextureB0.Sample(sampler_LightTextureB0, dot(float3(fragment_unnamed_202, fragment_unnamed_203, fragment_unnamed_204), float3(fragment_unnamed_202, fragment_unnamed_203, fragment_unnamed_204)).xx).x * _LightTexture0.Sample(sampler_LightTexture0, float3(fragment_unnamed_202, fragment_unnamed_203, fragment_unnamed_204)).w;
				precise float fragment_unnamed_485 = mad(fragment_unnamed_262, fragment_unnamed_470, fragment_unnamed_468) * fragment_unnamed_484;
				precise float fragment_unnamed_491 = fragment_unnamed_485 * fragment_uniform_buffer_0[2u].x;
				precise float fragment_unnamed_492 = fragment_unnamed_485 * fragment_uniform_buffer_0[2u].y;
				precise float fragment_unnamed_493 = fragment_unnamed_485 * fragment_uniform_buffer_0[2u].z;
				float fragment_unnamed_509 = rsqrt(dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z)));
				precise float fragment_unnamed_516 = fragment_unnamed_509 * fragment_input_2.x;
				precise float fragment_unnamed_517 = fragment_unnamed_509 * fragment_input_2.y;
				precise float fragment_unnamed_518 = fragment_unnamed_509 * fragment_input_2.z;
				float fragment_unnamed_533 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_154, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_535 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_155, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				float fragment_unnamed_536 = mad(fragment_uniform_buffer_0[8u].y, mad(fragment_unnamed_156, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_540 = (-0.0f) - fragment_uniform_buffer_0[8u].y;
				float fragment_unnamed_541 = mad(fragment_unnamed_540, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_543 = fragment_unnamed_541 * fragment_unnamed_163;
				precise float fragment_unnamed_544 = fragment_unnamed_541 * fragment_unnamed_164;
				precise float fragment_unnamed_545 = fragment_unnamed_541 * fragment_unnamed_165;
				precise float fragment_unnamed_549 = (-0.0f) - fragment_uniform_buffer_0[8u].x;
				precise float fragment_unnamed_550 = fragment_unnamed_549 + 1.0f;
				float fragment_unnamed_551 = mad(fragment_unnamed_100, fragment_unnamed_107, fragment_unnamed_133);
				float fragment_unnamed_552 = mad(fragment_unnamed_101, fragment_unnamed_107, fragment_unnamed_134);
				float fragment_unnamed_553 = mad(fragment_unnamed_102, fragment_unnamed_107, fragment_unnamed_135);
				float fragment_unnamed_559 = rsqrt(max(dot(float3(fragment_unnamed_551, fragment_unnamed_552, fragment_unnamed_553), float3(fragment_unnamed_551, fragment_unnamed_552, fragment_unnamed_553)), 0.001000000047497451305389404296875f));
				precise float fragment_unnamed_560 = fragment_unnamed_559 * fragment_unnamed_551;
				precise float fragment_unnamed_561 = fragment_unnamed_559 * fragment_unnamed_552;
				precise float fragment_unnamed_562 = fragment_unnamed_559 * fragment_unnamed_553;
				float fragment_unnamed_563 = dot(float3(fragment_unnamed_516, fragment_unnamed_517, fragment_unnamed_518), float3(fragment_unnamed_133, fragment_unnamed_134, fragment_unnamed_135));
				float fragment_unnamed_569 = clamp(dot(float3(fragment_unnamed_516, fragment_unnamed_517, fragment_unnamed_518), float3(fragment_unnamed_108, fragment_unnamed_109, fragment_unnamed_110)), 0.0f, 1.0f);
				float fragment_unnamed_573 = clamp(dot(float3(fragment_unnamed_516, fragment_unnamed_517, fragment_unnamed_518), float3(fragment_unnamed_560, fragment_unnamed_561, fragment_unnamed_562)), 0.0f, 1.0f);
				float fragment_unnamed_577 = clamp(dot(float3(fragment_unnamed_108, fragment_unnamed_109, fragment_unnamed_110), float3(fragment_unnamed_560, fragment_unnamed_561, fragment_unnamed_562)), 0.0f, 1.0f);
				precise float fragment_unnamed_578 = fragment_unnamed_577 * fragment_unnamed_577;
				precise float fragment_unnamed_582 = dot(fragment_unnamed_578.xx, fragment_unnamed_550.xx) + (-0.5f);
				precise float fragment_unnamed_584 = (-0.0f) - fragment_unnamed_569;
				precise float fragment_unnamed_585 = fragment_unnamed_584 + 1.0f;
				precise float fragment_unnamed_586 = fragment_unnamed_585 * fragment_unnamed_585;
				precise float fragment_unnamed_587 = fragment_unnamed_586 * fragment_unnamed_586;
				precise float fragment_unnamed_588 = fragment_unnamed_585 * fragment_unnamed_587;
				precise float fragment_unnamed_591 = (-0.0f) - abs(fragment_unnamed_563);
				precise float fragment_unnamed_592 = fragment_unnamed_591 + 1.0f;
				precise float fragment_unnamed_593 = fragment_unnamed_592 * fragment_unnamed_592;
				precise float fragment_unnamed_594 = fragment_unnamed_593 * fragment_unnamed_593;
				precise float fragment_unnamed_595 = fragment_unnamed_592 * fragment_unnamed_594;
				precise float fragment_unnamed_597 = mad(fragment_unnamed_582, fragment_unnamed_595, 1.0f) * mad(fragment_unnamed_582, fragment_unnamed_588, 1.0f);
				precise float fragment_unnamed_598 = fragment_unnamed_550 * fragment_unnamed_550;
				float fragment_unnamed_599 = max(fragment_unnamed_598, 0.00200000009499490261077880859375f);
				precise float fragment_unnamed_601 = (-0.0f) - fragment_unnamed_599;
				precise float fragment_unnamed_602 = fragment_unnamed_601 + 1.0f;
				precise float fragment_unnamed_607 = abs(fragment_unnamed_563) * mad(fragment_unnamed_569, fragment_unnamed_602, fragment_unnamed_599);
				precise float fragment_unnamed_609 = mad(fragment_unnamed_569, mad(abs(fragment_unnamed_563), fragment_unnamed_602, fragment_unnamed_599), fragment_unnamed_607) + 9.9999997473787516355514526367188e-06f;
				precise float fragment_unnamed_610 = 0.5f / fragment_unnamed_609;
				precise float fragment_unnamed_611 = fragment_unnamed_599 * fragment_unnamed_599;
				precise float fragment_unnamed_612 = (-0.0f) - fragment_unnamed_573;
				float fragment_unnamed_614 = mad(mad(fragment_unnamed_573, fragment_unnamed_611, fragment_unnamed_612), fragment_unnamed_573, 1.0f);
				precise float fragment_unnamed_615 = fragment_unnamed_611 * 0.3183098733425140380859375f;
				precise float fragment_unnamed_619 = fragment_unnamed_615 / mad(fragment_unnamed_614, fragment_unnamed_614, 1.0000000116860974230803549289703e-07f);
				precise float fragment_unnamed_620 = fragment_unnamed_619 * fragment_unnamed_610;
				precise float fragment_unnamed_621 = fragment_unnamed_620 * 3.1415927410125732421875f;
				precise float fragment_unnamed_626 = fragment_unnamed_569 * fragment_unnamed_597;
				precise float fragment_unnamed_627 = fragment_unnamed_569 * sqrt(max(fragment_unnamed_621, 9.9999997473787516355514526367188e-05f));
				precise float fragment_unnamed_636 = asfloat(((dot(float3(fragment_unnamed_533, fragment_unnamed_535, fragment_unnamed_536), float3(fragment_unnamed_533, fragment_unnamed_535, fragment_unnamed_536)) != 0.0f) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_627;
				precise float fragment_unnamed_637 = fragment_unnamed_626 * fragment_unnamed_491;
				precise float fragment_unnamed_638 = fragment_unnamed_626 * fragment_unnamed_492;
				precise float fragment_unnamed_639 = fragment_unnamed_626 * fragment_unnamed_493;
				precise float fragment_unnamed_640 = fragment_unnamed_491 * fragment_unnamed_636;
				precise float fragment_unnamed_641 = fragment_unnamed_492 * fragment_unnamed_636;
				precise float fragment_unnamed_642 = fragment_unnamed_493 * fragment_unnamed_636;
				precise float fragment_unnamed_643 = (-0.0f) - fragment_unnamed_577;
				precise float fragment_unnamed_644 = fragment_unnamed_643 + 1.0f;
				precise float fragment_unnamed_645 = fragment_unnamed_644 * fragment_unnamed_644;
				precise float fragment_unnamed_646 = fragment_unnamed_645 * fragment_unnamed_645;
				precise float fragment_unnamed_647 = fragment_unnamed_644 * fragment_unnamed_646;
				precise float fragment_unnamed_648 = (-0.0f) - fragment_unnamed_533;
				precise float fragment_unnamed_649 = (-0.0f) - fragment_unnamed_535;
				precise float fragment_unnamed_650 = (-0.0f) - fragment_unnamed_536;
				precise float fragment_unnamed_651 = fragment_unnamed_648 + 1.0f;
				precise float fragment_unnamed_652 = fragment_unnamed_649 + 1.0f;
				precise float fragment_unnamed_653 = fragment_unnamed_650 + 1.0f;
				precise float fragment_unnamed_657 = fragment_unnamed_640 * mad(fragment_unnamed_651, fragment_unnamed_647, fragment_unnamed_533);
				precise float fragment_unnamed_658 = fragment_unnamed_641 * mad(fragment_unnamed_652, fragment_unnamed_647, fragment_unnamed_535);
				precise float fragment_unnamed_659 = fragment_unnamed_642 * mad(fragment_unnamed_653, fragment_unnamed_647, fragment_unnamed_536);
				fragment_output_0.x = mad(fragment_unnamed_543, fragment_unnamed_637, fragment_unnamed_657);
				fragment_output_0.y = mad(fragment_unnamed_544, fragment_unnamed_638, fragment_unnamed_658);
				fragment_output_0.z = mad(fragment_unnamed_545, fragment_unnamed_639, fragment_unnamed_659);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_LightColor0[0], _LightColor0[1], _LightColor0[2], _LightColor0[3]);

				fragment_uniform_buffer_0[4] = float4(unity_WorldToLight[0][0], unity_WorldToLight[1][0], unity_WorldToLight[2][0], unity_WorldToLight[3][0]);
				fragment_uniform_buffer_0[5] = float4(unity_WorldToLight[0][1], unity_WorldToLight[1][1], unity_WorldToLight[2][1], unity_WorldToLight[3][1]);
				fragment_uniform_buffer_0[6] = float4(unity_WorldToLight[0][2], unity_WorldToLight[1][2], unity_WorldToLight[2][2], unity_WorldToLight[3][2]);
				fragment_uniform_buffer_0[7] = float4(unity_WorldToLight[0][3], unity_WorldToLight[1][3], unity_WorldToLight[2][3], unity_WorldToLight[3][3]);

				fragment_uniform_buffer_0[8] = float4(_Glossiness, fragment_uniform_buffer_0[8][1], fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[8] = float4(fragment_uniform_buffer_0[8][0], _Metallic, fragment_uniform_buffer_0[8][2], fragment_uniform_buffer_0[8][3]);

				fragment_uniform_buffer_0[9] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_2[0] = float4(_WorldSpaceLightPos0[0], _WorldSpaceLightPos0[1], _WorldSpaceLightPos0[2], _WorldSpaceLightPos0[3]);

				fragment_uniform_buffer_2[1] = float4(_LightPositionRange[0], _LightPositionRange[1], _LightPositionRange[2], _LightPositionRange[3]);

				fragment_uniform_buffer_2[2] = float4(_LightProjectionParams[0], _LightProjectionParams[1], _LightProjectionParams[2], _LightProjectionParams[3]);

				fragment_uniform_buffer_2[46] = float4(unity_OcclusionMaskSelector[0], unity_OcclusionMaskSelector[1], unity_OcclusionMaskSelector[2], unity_OcclusionMaskSelector[3]);

				fragment_uniform_buffer_3[24] = float4(_LightShadowData[0], _LightShadowData[1], _LightShadowData[2], _LightShadowData[3]);

				fragment_uniform_buffer_3[25] = float4(unity_ShadowFadeCenterAndType[0], unity_ShadowFadeCenterAndType[1], unity_ShadowFadeCenterAndType[2], unity_ShadowFadeCenterAndType[3]);

				fragment_uniform_buffer_4[9] = float4(unity_MatrixV[0][0], unity_MatrixV[1][0], unity_MatrixV[2][0], unity_MatrixV[3][0]);
				fragment_uniform_buffer_4[10] = float4(unity_MatrixV[0][1], unity_MatrixV[1][1], unity_MatrixV[2][1], unity_MatrixV[3][1]);
				fragment_uniform_buffer_4[11] = float4(unity_MatrixV[0][2], unity_MatrixV[1][2], unity_MatrixV[2][2], unity_MatrixV[3][2]);
				fragment_uniform_buffer_4[12] = float4(unity_MatrixV[0][3], unity_MatrixV[1][3], unity_MatrixV[2][3], unity_MatrixV[3][3]);

				fragment_uniform_buffer_5[0] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_5[1] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_5[2] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_5[3] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_5[4] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_5[5] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], fragment_uniform_buffer_5[5][3]);

				fragment_uniform_buffer_5[6] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], fragment_uniform_buffer_5[6][3]);

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

			#endif // defined(POINT_COOKIE) && defined(SHADOWS_CUBE) && defined(SHADOWS_SOFT) && !defined(POINT) && !defined(DIRECTIONAL) && !defined(SPOT) && !defined(DIRECTIONAL_COOKIE) && !defined(SHADOWS_DEPTH) && !defined(SHADOWS_SCREEN)


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
			Name "DEFERRED"
			LOD 200
			Tags { "LIGHTMODE" = "DEFERRED" "RenderType" = "Opaque" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 164733

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#pragma multi_compile _ LIGHTPROBE_SH
			#pragma multi_compile _ UNITY_HDR_ON


			#if !defined(LIGHTPROBE_SH) && !defined(UNITY_HDR_ON)

			float4 _MainTex_ST;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float4 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_55 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_56 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				float vertex_unnamed_81 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_55));
				float vertex_unnamed_82 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_56));
				float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_57));
				precise float vertex_unnamed_92 = vertex_unnamed_81 + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_93 = vertex_unnamed_82 + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_94 = vertex_unnamed_83 + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_95 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_58)) + vertex_uniform_buffer_1[3u].w;
				vertex_output_3.x = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_81);
				vertex_output_3.y = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_82);
				vertex_output_3.z = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_83);
				precise float vertex_unnamed_117 = vertex_unnamed_93 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_118 = vertex_unnamed_93 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_119 = vertex_unnamed_93 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_120 = vertex_unnamed_93 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_95, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_92, vertex_unnamed_117)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_95, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_92, vertex_unnamed_118)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_95, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_92, vertex_unnamed_119)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_95, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_92, vertex_unnamed_120)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[6u].x, vertex_uniform_buffer_0[6u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[6u].y, vertex_uniform_buffer_0[6u].w);
				float vertex_unnamed_187 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_202 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_216 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_222 = rsqrt(dot(float3(vertex_unnamed_187, vertex_unnamed_202, vertex_unnamed_216), float3(vertex_unnamed_187, vertex_unnamed_202, vertex_unnamed_216)));
				precise float vertex_unnamed_223 = vertex_unnamed_222 * vertex_unnamed_187;
				precise float vertex_unnamed_224 = vertex_unnamed_222 * vertex_unnamed_202;
				precise float vertex_unnamed_225 = vertex_unnamed_222 * vertex_unnamed_216;
				vertex_output_2.x = vertex_unnamed_223;
				vertex_output_2.y = vertex_unnamed_224;
				vertex_output_2.z = vertex_unnamed_225;
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				vertex_output_5.x = 0.0f;
				vertex_output_5.y = 0.0f;
				vertex_output_5.z = 0.0f;
				vertex_output_5.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_2[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_2[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_2[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				return stage_output;
			}


			float _Glossiness;
			float _Metallic;
			float4 _Color;

			static float4 fragment_uniform_buffer_0[6];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;
			static float4 fragment_output_3;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float4 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
				float4 fragment_output_3 : SV_Target3;
			};

			void frag_main()
			{
				float4 fragment_unnamed_47 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_59 = fragment_unnamed_47.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_60 = fragment_unnamed_47.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_61 = fragment_unnamed_47.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_69 = fragment_unnamed_59 * fragment_input_4.x;
				precise float fragment_unnamed_70 = fragment_unnamed_60 * fragment_input_4.y;
				precise float fragment_unnamed_71 = fragment_unnamed_61 * fragment_input_4.z;
				fragment_output_1.x = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_59, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				fragment_output_1.y = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_60, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				fragment_output_1.z = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_61, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_98 = (-0.0f) - fragment_uniform_buffer_0[4u].y;
				float fragment_unnamed_100 = mad(fragment_unnamed_98, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_102 = fragment_unnamed_100 * fragment_unnamed_69;
				precise float fragment_unnamed_103 = fragment_unnamed_100 * fragment_unnamed_70;
				precise float fragment_unnamed_104 = fragment_unnamed_100 * fragment_unnamed_71;
				fragment_output_0.x = fragment_unnamed_102;
				fragment_output_0.y = fragment_unnamed_103;
				fragment_output_0.z = fragment_unnamed_104;
				fragment_output_0.w = 1.0f;
				fragment_output_1.w = fragment_uniform_buffer_0[4u].x;
				fragment_output_2.x = mad(fragment_input_2.x, 0.5f, 0.5f);
				fragment_output_2.y = mad(fragment_input_2.y, 0.5f, 0.5f);
				fragment_output_2.z = mad(fragment_input_2.z, 0.5f, 0.5f);
				fragment_output_2.w = 1.0f;
				fragment_output_3.x = 1.0f;
				fragment_output_3.y = 1.0f;
				fragment_output_3.z = 1.0f;
				fragment_output_3.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[4] = float4(_Glossiness, fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _Metallic, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[5] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				stage_output.fragment_output_2 = fragment_output_2;
				stage_output.fragment_output_3 = fragment_output_3;
				return stage_output;
			}

			#endif // !defined(LIGHTPROBE_SH) && !defined(UNITY_HDR_ON)


			#if defined(LIGHTPROBE_SH) && !defined(UNITY_HDR_ON)

			float4 _MainTex_ST;
			float4 unity_SHBr;
			float4 unity_SHBg;
			float4 unity_SHBb;
			float4 unity_SHC;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
			static float4 vertex_uniform_buffer_1[46];
			static float4 vertex_uniform_buffer_2[8];
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
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float3 vertex_output_6;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float4 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float3 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_61 = vertex_input_0.y * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_62 = vertex_input_0.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_63 = vertex_input_0.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_64 = vertex_input_0.y * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_87 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_0.x, vertex_unnamed_61));
				float vertex_unnamed_88 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_0.x, vertex_unnamed_62));
				float vertex_unnamed_89 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_0.x, vertex_unnamed_63));
				precise float vertex_unnamed_98 = vertex_unnamed_87 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_99 = vertex_unnamed_88 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_100 = vertex_unnamed_89 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_101 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_input_0.x, vertex_unnamed_64)) + vertex_uniform_buffer_2[3u].w;
				vertex_output_3.x = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_87);
				vertex_output_3.y = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_88);
				vertex_output_3.z = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_89);
				precise float vertex_unnamed_123 = vertex_unnamed_99 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_124 = vertex_unnamed_99 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_125 = vertex_unnamed_99 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_126 = vertex_unnamed_99 * vertex_uniform_buffer_3[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_101, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_100, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_98, vertex_unnamed_123)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_101, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_100, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_98, vertex_unnamed_124)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_101, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_100, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_98, vertex_unnamed_125)));
				gl_Position.w = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_101, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_100, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_98, vertex_unnamed_126)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[6u].x, vertex_uniform_buffer_0[6u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[6u].y, vertex_uniform_buffer_0[6u].w);
				float vertex_unnamed_193 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_208 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_222 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_228 = rsqrt(dot(float3(vertex_unnamed_193, vertex_unnamed_208, vertex_unnamed_222), float3(vertex_unnamed_193, vertex_unnamed_208, vertex_unnamed_222)));
				precise float vertex_unnamed_229 = vertex_unnamed_228 * vertex_unnamed_193;
				precise float vertex_unnamed_230 = vertex_unnamed_228 * vertex_unnamed_208;
				precise float vertex_unnamed_231 = vertex_unnamed_228 * vertex_unnamed_222;
				vertex_output_2.x = vertex_unnamed_229;
				vertex_output_2.y = vertex_unnamed_230;
				vertex_output_2.z = vertex_unnamed_231;
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				vertex_output_5.x = 0.0f;
				vertex_output_5.y = 0.0f;
				vertex_output_5.z = 0.0f;
				vertex_output_5.w = 0.0f;
				precise float vertex_unnamed_252 = vertex_unnamed_230 * vertex_unnamed_230;
				precise float vertex_unnamed_253 = (-0.0f) - vertex_unnamed_252;
				float vertex_unnamed_255 = mad(vertex_unnamed_229, vertex_unnamed_229, vertex_unnamed_253);
				precise float vertex_unnamed_256 = vertex_unnamed_230 * vertex_unnamed_229;
				precise float vertex_unnamed_257 = vertex_unnamed_231 * vertex_unnamed_230;
				precise float vertex_unnamed_258 = vertex_unnamed_231 * vertex_unnamed_231;
				precise float vertex_unnamed_259 = vertex_unnamed_229 * vertex_unnamed_231;
				vertex_output_6.x = mad(vertex_uniform_buffer_1[45u].x, vertex_unnamed_255, dot(float4(vertex_uniform_buffer_1[42u]), float4(vertex_unnamed_256, vertex_unnamed_257, vertex_unnamed_258, vertex_unnamed_259)));
				vertex_output_6.y = mad(vertex_uniform_buffer_1[45u].y, vertex_unnamed_255, dot(float4(vertex_uniform_buffer_1[43u]), float4(vertex_unnamed_256, vertex_unnamed_257, vertex_unnamed_258, vertex_unnamed_259)));
				vertex_output_6.z = mad(vertex_uniform_buffer_1[45u].z, vertex_unnamed_255, dot(float4(vertex_uniform_buffer_1[44u]), float4(vertex_unnamed_256, vertex_unnamed_257, vertex_unnamed_258, vertex_unnamed_259)));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[42] = float4(unity_SHBr[0], unity_SHBr[1], unity_SHBr[2], unity_SHBr[3]);

				vertex_uniform_buffer_1[43] = float4(unity_SHBg[0], unity_SHBg[1], unity_SHBg[2], unity_SHBg[3]);

				vertex_uniform_buffer_1[44] = float4(unity_SHBb[0], unity_SHBb[1], unity_SHBb[2], unity_SHBb[3]);

				vertex_uniform_buffer_1[45] = float4(unity_SHC[0], unity_SHC[1], unity_SHC[2], unity_SHC[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}


			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float4 unity_SHAr;
			float4 unity_SHAg;
			float4 unity_SHAb;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[6];
			static float4 fragment_uniform_buffer_1[42];
			static float4 fragment_uniform_buffer_2[7];
			Texture2D<float4> _MainTex;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;
			static float4 fragment_output_3;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float4 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
				float3 fragment_input_6 : TEXCOORD5; // TEXCOORD_5
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
				float4 fragment_output_3 : SV_Target3;
			};

			void frag_main()
			{
				float4 fragment_unnamed_64 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_76 = fragment_unnamed_64.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_77 = fragment_unnamed_64.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_78 = fragment_unnamed_64.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_86 = fragment_unnamed_76 * fragment_input_4.x;
				precise float fragment_unnamed_87 = fragment_unnamed_77 * fragment_input_4.y;
				precise float fragment_unnamed_88 = fragment_unnamed_78 * fragment_input_4.z;
				float fragment_unnamed_263;
				float fragment_unnamed_264;
				float fragment_unnamed_265;
				if (fragment_uniform_buffer_2[0u].x == 1.0f)
				{
					bool fragment_unnamed_98 = fragment_uniform_buffer_2[0u].y == 1.0f;
					precise float fragment_unnamed_106 = fragment_input_3.y * fragment_uniform_buffer_2[2u].x;
					precise float fragment_unnamed_107 = fragment_input_3.y * fragment_uniform_buffer_2[2u].y;
					precise float fragment_unnamed_108 = fragment_input_3.y * fragment_uniform_buffer_2[2u].z;
					precise float fragment_unnamed_137 = mad(fragment_uniform_buffer_2[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_2[1u].x, fragment_input_3.x, fragment_unnamed_106)) + fragment_uniform_buffer_2[4u].x;
					precise float fragment_unnamed_138 = mad(fragment_uniform_buffer_2[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_2[1u].y, fragment_input_3.x, fragment_unnamed_107)) + fragment_uniform_buffer_2[4u].y;
					precise float fragment_unnamed_139 = mad(fragment_uniform_buffer_2[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_2[1u].z, fragment_input_3.x, fragment_unnamed_108)) + fragment_uniform_buffer_2[4u].z;
					precise float fragment_unnamed_152 = (-0.0f) - fragment_uniform_buffer_2[6u].x;
					precise float fragment_unnamed_155 = (-0.0f) - fragment_uniform_buffer_2[6u].y;
					precise float fragment_unnamed_157 = (-0.0f) - fragment_uniform_buffer_2[6u].z;
					precise float fragment_unnamed_158 = (fragment_unnamed_98 ? fragment_unnamed_137 : fragment_input_3.x) + fragment_unnamed_152;
					precise float fragment_unnamed_159 = (fragment_unnamed_98 ? fragment_unnamed_138 : fragment_input_3.y) + fragment_unnamed_155;
					precise float fragment_unnamed_160 = (fragment_unnamed_98 ? fragment_unnamed_139 : fragment_input_3.z) + fragment_unnamed_157;
					precise float fragment_unnamed_166 = fragment_unnamed_158 * fragment_uniform_buffer_2[5u].x;
					precise float fragment_unnamed_167 = fragment_unnamed_159 * fragment_uniform_buffer_2[5u].y;
					precise float fragment_unnamed_168 = fragment_unnamed_160 * fragment_uniform_buffer_2[5u].z;
					precise float fragment_unnamed_169 = fragment_unnamed_166 * 0.25f;
					precise float fragment_unnamed_174 = fragment_uniform_buffer_2[0u].z * 0.5f;
					precise float fragment_unnamed_179 = (-0.0f) - fragment_uniform_buffer_2[0u].z;
					float fragment_unnamed_182 = min(mad(fragment_unnamed_179, 0.5f, 0.25f), max(fragment_unnamed_169, fragment_unnamed_174));
					precise float fragment_unnamed_191 = fragment_unnamed_182 + 0.25f;
					precise float fragment_unnamed_192 = fragment_unnamed_167 + 0.0f;
					precise float fragment_unnamed_193 = fragment_unnamed_168 + 0.0f;
					precise float fragment_unnamed_200 = fragment_unnamed_182 + 0.5f;
					precise float fragment_unnamed_201 = fragment_unnamed_167 + 0.0f;
					precise float fragment_unnamed_202 = fragment_unnamed_168 + 0.0f;
					float fragment_unnamed_215 = asfloat(1065353216u);
					fragment_unnamed_263 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_182, fragment_unnamed_167, fragment_unnamed_168))), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_215));
					fragment_unnamed_264 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_191, fragment_unnamed_192, fragment_unnamed_193))), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_215));
					fragment_unnamed_265 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_200, fragment_unnamed_201, fragment_unnamed_202))), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_215));
				}
				else
				{
					float fragment_unnamed_232 = asfloat(1065353216u);
					fragment_unnamed_263 = dot(float4(fragment_uniform_buffer_1[39u]), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_232));
					fragment_unnamed_264 = dot(float4(fragment_uniform_buffer_1[40u]), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_232));
					fragment_unnamed_265 = dot(float4(fragment_uniform_buffer_1[41u]), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_232));
				}
				precise float fragment_unnamed_272 = fragment_unnamed_263 + fragment_input_6.x;
				precise float fragment_unnamed_273 = fragment_unnamed_264 + fragment_input_6.y;
				precise float fragment_unnamed_274 = fragment_unnamed_265 + fragment_input_6.z;
				precise float fragment_unnamed_281 = log2(max(fragment_unnamed_272, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_283 = log2(max(fragment_unnamed_273, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_284 = log2(max(fragment_unnamed_274, 0.0f)) * 0.4166666567325592041015625f;
				fragment_output_1.x = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_76, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				fragment_output_1.y = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_77, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				fragment_output_1.z = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_78, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_320 = (-0.0f) - fragment_uniform_buffer_0[4u].y;
				float fragment_unnamed_321 = mad(fragment_unnamed_320, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_323 = fragment_unnamed_321 * fragment_unnamed_86;
				precise float fragment_unnamed_324 = fragment_unnamed_321 * fragment_unnamed_87;
				precise float fragment_unnamed_325 = fragment_unnamed_321 * fragment_unnamed_88;
				precise float fragment_unnamed_326 = max(mad(exp2(fragment_unnamed_281), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f) * fragment_unnamed_323;
				precise float fragment_unnamed_327 = max(mad(exp2(fragment_unnamed_283), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f) * fragment_unnamed_324;
				precise float fragment_unnamed_328 = max(mad(exp2(fragment_unnamed_284), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f) * fragment_unnamed_325;
				precise float fragment_unnamed_329 = (-0.0f) - fragment_unnamed_326;
				precise float fragment_unnamed_330 = (-0.0f) - fragment_unnamed_327;
				precise float fragment_unnamed_331 = (-0.0f) - fragment_unnamed_328;
				fragment_output_3.x = exp2(fragment_unnamed_329);
				fragment_output_3.y = exp2(fragment_unnamed_330);
				fragment_output_3.z = exp2(fragment_unnamed_331);
				fragment_output_0.x = fragment_unnamed_323;
				fragment_output_0.y = fragment_unnamed_324;
				fragment_output_0.z = fragment_unnamed_325;
				fragment_output_0.w = 1.0f;
				fragment_output_1.w = fragment_uniform_buffer_0[4u].x;
				fragment_output_2.x = mad(fragment_input_2.x, 0.5f, 0.5f);
				fragment_output_2.y = mad(fragment_input_2.y, 0.5f, 0.5f);
				fragment_output_2.z = mad(fragment_input_2.z, 0.5f, 0.5f);
				fragment_output_2.w = 1.0f;
				fragment_output_3.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[4] = float4(_Glossiness, fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _Metallic, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[5] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_uniform_buffer_1[39] = float4(unity_SHAr[0], unity_SHAr[1], unity_SHAr[2], unity_SHAr[3]);

				fragment_uniform_buffer_1[40] = float4(unity_SHAg[0], unity_SHAg[1], unity_SHAg[2], unity_SHAg[3]);

				fragment_uniform_buffer_1[41] = float4(unity_SHAb[0], unity_SHAb[1], unity_SHAb[2], unity_SHAb[3]);

				fragment_uniform_buffer_2[0] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_2[1] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_2[2] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_2[3] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_2[4] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_2[5] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], fragment_uniform_buffer_2[5][3]);

				fragment_uniform_buffer_2[6] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], fragment_uniform_buffer_2[6][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				stage_output.fragment_output_2 = fragment_output_2;
				stage_output.fragment_output_3 = fragment_output_3;
				return stage_output;
			}

			#endif // defined(LIGHTPROBE_SH) && !defined(UNITY_HDR_ON)


			#if defined(UNITY_HDR_ON) && !defined(LIGHTPROBE_SH)

			float4 _MainTex_ST;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float4 vertex_input_1;
			static float3 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_input_7;
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float4 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_55 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_56 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_57 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_58 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				float vertex_unnamed_81 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_55));
				float vertex_unnamed_82 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_56));
				float vertex_unnamed_83 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_57));
				precise float vertex_unnamed_92 = vertex_unnamed_81 + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_93 = vertex_unnamed_82 + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_94 = vertex_unnamed_83 + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_95 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_58)) + vertex_uniform_buffer_1[3u].w;
				vertex_output_3.x = mad(vertex_uniform_buffer_1[3u].x, vertex_input_0.w, vertex_unnamed_81);
				vertex_output_3.y = mad(vertex_uniform_buffer_1[3u].y, vertex_input_0.w, vertex_unnamed_82);
				vertex_output_3.z = mad(vertex_uniform_buffer_1[3u].z, vertex_input_0.w, vertex_unnamed_83);
				precise float vertex_unnamed_117 = vertex_unnamed_93 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_118 = vertex_unnamed_93 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_119 = vertex_unnamed_93 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_120 = vertex_unnamed_93 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_95, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_94, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_92, vertex_unnamed_117)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_95, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_94, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_92, vertex_unnamed_118)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_95, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_94, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_92, vertex_unnamed_119)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_95, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_94, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_92, vertex_unnamed_120)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[6u].x, vertex_uniform_buffer_0[6u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[6u].y, vertex_uniform_buffer_0[6u].w);
				float vertex_unnamed_187 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_202 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_216 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_222 = rsqrt(dot(float3(vertex_unnamed_187, vertex_unnamed_202, vertex_unnamed_216), float3(vertex_unnamed_187, vertex_unnamed_202, vertex_unnamed_216)));
				precise float vertex_unnamed_223 = vertex_unnamed_222 * vertex_unnamed_187;
				precise float vertex_unnamed_224 = vertex_unnamed_222 * vertex_unnamed_202;
				precise float vertex_unnamed_225 = vertex_unnamed_222 * vertex_unnamed_216;
				vertex_output_2.x = vertex_unnamed_223;
				vertex_output_2.y = vertex_unnamed_224;
				vertex_output_2.z = vertex_unnamed_225;
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				vertex_output_5.x = 0.0f;
				vertex_output_5.y = 0.0f;
				vertex_output_5.z = 0.0f;
				vertex_output_5.w = 0.0f;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[17] = float4(unity_MatrixVP[0][0], unity_MatrixVP[1][0], unity_MatrixVP[2][0], unity_MatrixVP[3][0]);
				vertex_uniform_buffer_2[18] = float4(unity_MatrixVP[0][1], unity_MatrixVP[1][1], unity_MatrixVP[2][1], unity_MatrixVP[3][1]);
				vertex_uniform_buffer_2[19] = float4(unity_MatrixVP[0][2], unity_MatrixVP[1][2], unity_MatrixVP[2][2], unity_MatrixVP[3][2]);
				vertex_uniform_buffer_2[20] = float4(unity_MatrixVP[0][3], unity_MatrixVP[1][3], unity_MatrixVP[2][3], unity_MatrixVP[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				return stage_output;
			}


			float _Glossiness;
			float _Metallic;
			float4 _Color;

			static float4 fragment_uniform_buffer_0[6];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;
			static float4 fragment_output_3;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float4 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
				float4 fragment_output_3 : SV_Target3;
			};

			void frag_main()
			{
				float4 fragment_unnamed_47 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_59 = fragment_unnamed_47.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_60 = fragment_unnamed_47.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_61 = fragment_unnamed_47.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_69 = fragment_unnamed_59 * fragment_input_4.x;
				precise float fragment_unnamed_70 = fragment_unnamed_60 * fragment_input_4.y;
				precise float fragment_unnamed_71 = fragment_unnamed_61 * fragment_input_4.z;
				fragment_output_1.x = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_59, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				fragment_output_1.y = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_60, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				fragment_output_1.z = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_61, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_98 = (-0.0f) - fragment_uniform_buffer_0[4u].y;
				float fragment_unnamed_100 = mad(fragment_unnamed_98, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_102 = fragment_unnamed_100 * fragment_unnamed_69;
				precise float fragment_unnamed_103 = fragment_unnamed_100 * fragment_unnamed_70;
				precise float fragment_unnamed_104 = fragment_unnamed_100 * fragment_unnamed_71;
				fragment_output_0.x = fragment_unnamed_102;
				fragment_output_0.y = fragment_unnamed_103;
				fragment_output_0.z = fragment_unnamed_104;
				fragment_output_0.w = 1.0f;
				fragment_output_1.w = fragment_uniform_buffer_0[4u].x;
				fragment_output_2.x = mad(fragment_input_2.x, 0.5f, 0.5f);
				fragment_output_2.y = mad(fragment_input_2.y, 0.5f, 0.5f);
				fragment_output_2.z = mad(fragment_input_2.z, 0.5f, 0.5f);
				fragment_output_2.w = 1.0f;
				fragment_output_3.x = 0.0f;
				fragment_output_3.y = 0.0f;
				fragment_output_3.z = 0.0f;
				fragment_output_3.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[4] = float4(_Glossiness, fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _Metallic, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[5] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				stage_output.fragment_output_2 = fragment_output_2;
				stage_output.fragment_output_3 = fragment_output_3;
				return stage_output;
			}

			#endif // defined(UNITY_HDR_ON) && !defined(LIGHTPROBE_SH)


			#if defined(LIGHTPROBE_SH) && defined(UNITY_HDR_ON)

			float4 _MainTex_ST;
			float4 unity_SHBr;
			float4 unity_SHBg;
			float4 unity_SHBb;
			float4 unity_SHC;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[7];
			static float4 vertex_uniform_buffer_1[46];
			static float4 vertex_uniform_buffer_2[8];
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
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float3 vertex_output_6;

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
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : COLOR; // COLOR
				float4 vertex_output_5 : TEXCOORD4; // TEXCOORD_4
				float3 vertex_output_6 : TEXCOORD5; // TEXCOORD_5
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_61 = vertex_input_0.y * vertex_uniform_buffer_2[1u].x;
				precise float vertex_unnamed_62 = vertex_input_0.y * vertex_uniform_buffer_2[1u].y;
				precise float vertex_unnamed_63 = vertex_input_0.y * vertex_uniform_buffer_2[1u].z;
				precise float vertex_unnamed_64 = vertex_input_0.y * vertex_uniform_buffer_2[1u].w;
				float vertex_unnamed_87 = mad(vertex_uniform_buffer_2[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].x, vertex_input_0.x, vertex_unnamed_61));
				float vertex_unnamed_88 = mad(vertex_uniform_buffer_2[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].y, vertex_input_0.x, vertex_unnamed_62));
				float vertex_unnamed_89 = mad(vertex_uniform_buffer_2[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].z, vertex_input_0.x, vertex_unnamed_63));
				precise float vertex_unnamed_98 = vertex_unnamed_87 + vertex_uniform_buffer_2[3u].x;
				precise float vertex_unnamed_99 = vertex_unnamed_88 + vertex_uniform_buffer_2[3u].y;
				precise float vertex_unnamed_100 = vertex_unnamed_89 + vertex_uniform_buffer_2[3u].z;
				precise float vertex_unnamed_101 = mad(vertex_uniform_buffer_2[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_2[0u].w, vertex_input_0.x, vertex_unnamed_64)) + vertex_uniform_buffer_2[3u].w;
				vertex_output_3.x = mad(vertex_uniform_buffer_2[3u].x, vertex_input_0.w, vertex_unnamed_87);
				vertex_output_3.y = mad(vertex_uniform_buffer_2[3u].y, vertex_input_0.w, vertex_unnamed_88);
				vertex_output_3.z = mad(vertex_uniform_buffer_2[3u].z, vertex_input_0.w, vertex_unnamed_89);
				precise float vertex_unnamed_123 = vertex_unnamed_99 * vertex_uniform_buffer_3[18u].x;
				precise float vertex_unnamed_124 = vertex_unnamed_99 * vertex_uniform_buffer_3[18u].y;
				precise float vertex_unnamed_125 = vertex_unnamed_99 * vertex_uniform_buffer_3[18u].z;
				precise float vertex_unnamed_126 = vertex_unnamed_99 * vertex_uniform_buffer_3[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_3[20u].x, vertex_unnamed_101, mad(vertex_uniform_buffer_3[19u].x, vertex_unnamed_100, mad(vertex_uniform_buffer_3[17u].x, vertex_unnamed_98, vertex_unnamed_123)));
				gl_Position.y = mad(vertex_uniform_buffer_3[20u].y, vertex_unnamed_101, mad(vertex_uniform_buffer_3[19u].y, vertex_unnamed_100, mad(vertex_uniform_buffer_3[17u].y, vertex_unnamed_98, vertex_unnamed_124)));
				gl_Position.z = mad(vertex_uniform_buffer_3[20u].z, vertex_unnamed_101, mad(vertex_uniform_buffer_3[19u].z, vertex_unnamed_100, mad(vertex_uniform_buffer_3[17u].z, vertex_unnamed_98, vertex_unnamed_125)));
				gl_Position.w = mad(vertex_uniform_buffer_3[20u].w, vertex_unnamed_101, mad(vertex_uniform_buffer_3[19u].w, vertex_unnamed_100, mad(vertex_uniform_buffer_3[17u].w, vertex_unnamed_98, vertex_unnamed_126)));
				vertex_output_1.x = mad(vertex_input_3.x, vertex_uniform_buffer_0[6u].x, vertex_uniform_buffer_0[6u].z);
				vertex_output_1.y = mad(vertex_input_3.y, vertex_uniform_buffer_0[6u].y, vertex_uniform_buffer_0[6u].w);
				float vertex_unnamed_193 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[4u].xyz));
				float vertex_unnamed_208 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[5u].xyz));
				float vertex_unnamed_222 = dot(float3(vertex_input_2.x, vertex_input_2.y, vertex_input_2.z), float3(vertex_uniform_buffer_2[6u].xyz));
				float vertex_unnamed_228 = rsqrt(dot(float3(vertex_unnamed_193, vertex_unnamed_208, vertex_unnamed_222), float3(vertex_unnamed_193, vertex_unnamed_208, vertex_unnamed_222)));
				precise float vertex_unnamed_229 = vertex_unnamed_228 * vertex_unnamed_193;
				precise float vertex_unnamed_230 = vertex_unnamed_228 * vertex_unnamed_208;
				precise float vertex_unnamed_231 = vertex_unnamed_228 * vertex_unnamed_222;
				vertex_output_2.x = vertex_unnamed_229;
				vertex_output_2.y = vertex_unnamed_230;
				vertex_output_2.z = vertex_unnamed_231;
				vertex_output_4.x = vertex_input_7.x;
				vertex_output_4.y = vertex_input_7.y;
				vertex_output_4.z = vertex_input_7.z;
				vertex_output_4.w = vertex_input_7.w;
				vertex_output_5.x = 0.0f;
				vertex_output_5.y = 0.0f;
				vertex_output_5.z = 0.0f;
				vertex_output_5.w = 0.0f;
				precise float vertex_unnamed_252 = vertex_unnamed_230 * vertex_unnamed_230;
				precise float vertex_unnamed_253 = (-0.0f) - vertex_unnamed_252;
				float vertex_unnamed_255 = mad(vertex_unnamed_229, vertex_unnamed_229, vertex_unnamed_253);
				precise float vertex_unnamed_256 = vertex_unnamed_230 * vertex_unnamed_229;
				precise float vertex_unnamed_257 = vertex_unnamed_231 * vertex_unnamed_230;
				precise float vertex_unnamed_258 = vertex_unnamed_231 * vertex_unnamed_231;
				precise float vertex_unnamed_259 = vertex_unnamed_229 * vertex_unnamed_231;
				vertex_output_6.x = mad(vertex_uniform_buffer_1[45u].x, vertex_unnamed_255, dot(float4(vertex_uniform_buffer_1[42u]), float4(vertex_unnamed_256, vertex_unnamed_257, vertex_unnamed_258, vertex_unnamed_259)));
				vertex_output_6.y = mad(vertex_uniform_buffer_1[45u].y, vertex_unnamed_255, dot(float4(vertex_uniform_buffer_1[43u]), float4(vertex_unnamed_256, vertex_unnamed_257, vertex_unnamed_258, vertex_unnamed_259)));
				vertex_output_6.z = mad(vertex_uniform_buffer_1[45u].z, vertex_unnamed_255, dot(float4(vertex_uniform_buffer_1[44u]), float4(vertex_unnamed_256, vertex_unnamed_257, vertex_unnamed_258, vertex_unnamed_259)));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[6] = float4(_MainTex_ST[0], _MainTex_ST[1], _MainTex_ST[2], _MainTex_ST[3]);

				vertex_uniform_buffer_1[42] = float4(unity_SHBr[0], unity_SHBr[1], unity_SHBr[2], unity_SHBr[3]);

				vertex_uniform_buffer_1[43] = float4(unity_SHBg[0], unity_SHBg[1], unity_SHBg[2], unity_SHBg[3]);

				vertex_uniform_buffer_1[44] = float4(unity_SHBb[0], unity_SHBb[1], unity_SHBb[2], unity_SHBb[3]);

				vertex_uniform_buffer_1[45] = float4(unity_SHC[0], unity_SHC[1], unity_SHC[2], unity_SHC[3]);

				vertex_uniform_buffer_2[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

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
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}


			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float4 unity_SHAr;
			float4 unity_SHAg;
			float4 unity_SHAb;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float3 unity_ProbeVolumeSizeInv;
			float3 unity_ProbeVolumeMin;

			static float4 fragment_uniform_buffer_0[6];
			static float4 fragment_uniform_buffer_1[42];
			static float4 fragment_uniform_buffer_2[7];
			Texture2D<float4> _MainTex;
			Texture3D<float4> unity_ProbeVolumeSH;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;
			static float4 fragment_output_3;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float3 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : COLOR; // COLOR
				float4 fragment_input_5 : TEXCOORD4; // TEXCOORD_4
				float3 fragment_input_6 : TEXCOORD5; // TEXCOORD_5
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
				float4 fragment_output_3 : SV_Target3;
			};

			void frag_main()
			{
				float4 fragment_unnamed_64 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_76 = fragment_unnamed_64.x * fragment_uniform_buffer_0[5u].x;
				precise float fragment_unnamed_77 = fragment_unnamed_64.y * fragment_uniform_buffer_0[5u].y;
				precise float fragment_unnamed_78 = fragment_unnamed_64.z * fragment_uniform_buffer_0[5u].z;
				precise float fragment_unnamed_86 = fragment_unnamed_76 * fragment_input_4.x;
				precise float fragment_unnamed_87 = fragment_unnamed_77 * fragment_input_4.y;
				precise float fragment_unnamed_88 = fragment_unnamed_78 * fragment_input_4.z;
				float fragment_unnamed_263;
				float fragment_unnamed_264;
				float fragment_unnamed_265;
				if (fragment_uniform_buffer_2[0u].x == 1.0f)
				{
					bool fragment_unnamed_98 = fragment_uniform_buffer_2[0u].y == 1.0f;
					precise float fragment_unnamed_106 = fragment_input_3.y * fragment_uniform_buffer_2[2u].x;
					precise float fragment_unnamed_107 = fragment_input_3.y * fragment_uniform_buffer_2[2u].y;
					precise float fragment_unnamed_108 = fragment_input_3.y * fragment_uniform_buffer_2[2u].z;
					precise float fragment_unnamed_137 = mad(fragment_uniform_buffer_2[3u].x, fragment_input_3.z, mad(fragment_uniform_buffer_2[1u].x, fragment_input_3.x, fragment_unnamed_106)) + fragment_uniform_buffer_2[4u].x;
					precise float fragment_unnamed_138 = mad(fragment_uniform_buffer_2[3u].y, fragment_input_3.z, mad(fragment_uniform_buffer_2[1u].y, fragment_input_3.x, fragment_unnamed_107)) + fragment_uniform_buffer_2[4u].y;
					precise float fragment_unnamed_139 = mad(fragment_uniform_buffer_2[3u].z, fragment_input_3.z, mad(fragment_uniform_buffer_2[1u].z, fragment_input_3.x, fragment_unnamed_108)) + fragment_uniform_buffer_2[4u].z;
					precise float fragment_unnamed_152 = (-0.0f) - fragment_uniform_buffer_2[6u].x;
					precise float fragment_unnamed_155 = (-0.0f) - fragment_uniform_buffer_2[6u].y;
					precise float fragment_unnamed_157 = (-0.0f) - fragment_uniform_buffer_2[6u].z;
					precise float fragment_unnamed_158 = (fragment_unnamed_98 ? fragment_unnamed_137 : fragment_input_3.x) + fragment_unnamed_152;
					precise float fragment_unnamed_159 = (fragment_unnamed_98 ? fragment_unnamed_138 : fragment_input_3.y) + fragment_unnamed_155;
					precise float fragment_unnamed_160 = (fragment_unnamed_98 ? fragment_unnamed_139 : fragment_input_3.z) + fragment_unnamed_157;
					precise float fragment_unnamed_166 = fragment_unnamed_158 * fragment_uniform_buffer_2[5u].x;
					precise float fragment_unnamed_167 = fragment_unnamed_159 * fragment_uniform_buffer_2[5u].y;
					precise float fragment_unnamed_168 = fragment_unnamed_160 * fragment_uniform_buffer_2[5u].z;
					precise float fragment_unnamed_169 = fragment_unnamed_166 * 0.25f;
					precise float fragment_unnamed_174 = fragment_uniform_buffer_2[0u].z * 0.5f;
					precise float fragment_unnamed_179 = (-0.0f) - fragment_uniform_buffer_2[0u].z;
					float fragment_unnamed_182 = min(mad(fragment_unnamed_179, 0.5f, 0.25f), max(fragment_unnamed_169, fragment_unnamed_174));
					precise float fragment_unnamed_191 = fragment_unnamed_182 + 0.25f;
					precise float fragment_unnamed_192 = fragment_unnamed_167 + 0.0f;
					precise float fragment_unnamed_193 = fragment_unnamed_168 + 0.0f;
					precise float fragment_unnamed_200 = fragment_unnamed_182 + 0.5f;
					precise float fragment_unnamed_201 = fragment_unnamed_167 + 0.0f;
					precise float fragment_unnamed_202 = fragment_unnamed_168 + 0.0f;
					float fragment_unnamed_215 = asfloat(1065353216u);
					fragment_unnamed_263 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_191, fragment_unnamed_192, fragment_unnamed_193))), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_215));
					fragment_unnamed_264 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_200, fragment_unnamed_201, fragment_unnamed_202))), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_215));
					fragment_unnamed_265 = dot(float4(unity_ProbeVolumeSH.Sample(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_182, fragment_unnamed_167, fragment_unnamed_168))), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_215));
				}
				else
				{
					float fragment_unnamed_232 = asfloat(1065353216u);
					fragment_unnamed_263 = dot(float4(fragment_uniform_buffer_1[40u]), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_232));
					fragment_unnamed_264 = dot(float4(fragment_uniform_buffer_1[41u]), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_232));
					fragment_unnamed_265 = dot(float4(fragment_uniform_buffer_1[39u]), float4(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z, fragment_unnamed_232));
				}
				precise float fragment_unnamed_272 = fragment_unnamed_265 + fragment_input_6.x;
				precise float fragment_unnamed_273 = fragment_unnamed_263 + fragment_input_6.y;
				precise float fragment_unnamed_274 = fragment_unnamed_264 + fragment_input_6.z;
				precise float fragment_unnamed_281 = log2(max(fragment_unnamed_272, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_283 = log2(max(fragment_unnamed_273, 0.0f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_284 = log2(max(fragment_unnamed_274, 0.0f)) * 0.4166666567325592041015625f;
				fragment_output_1.x = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_76, fragment_input_4.x, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				fragment_output_1.y = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_77, fragment_input_4.y, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				fragment_output_1.z = mad(fragment_uniform_buffer_0[4u].y, mad(fragment_unnamed_78, fragment_input_4.z, -0.2209163010120391845703125f), 0.2209163010120391845703125f);
				precise float fragment_unnamed_320 = (-0.0f) - fragment_uniform_buffer_0[4u].y;
				float fragment_unnamed_321 = mad(fragment_unnamed_320, 0.779083728790283203125f, 0.779083728790283203125f);
				precise float fragment_unnamed_323 = fragment_unnamed_321 * fragment_unnamed_86;
				precise float fragment_unnamed_324 = fragment_unnamed_321 * fragment_unnamed_87;
				precise float fragment_unnamed_325 = fragment_unnamed_321 * fragment_unnamed_88;
				precise float fragment_unnamed_326 = max(mad(exp2(fragment_unnamed_281), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f) * fragment_unnamed_323;
				precise float fragment_unnamed_327 = max(mad(exp2(fragment_unnamed_283), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f) * fragment_unnamed_324;
				precise float fragment_unnamed_328 = max(mad(exp2(fragment_unnamed_284), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f) * fragment_unnamed_325;
				fragment_output_3.x = fragment_unnamed_326;
				fragment_output_3.y = fragment_unnamed_327;
				fragment_output_3.z = fragment_unnamed_328;
				fragment_output_0.x = fragment_unnamed_323;
				fragment_output_0.y = fragment_unnamed_324;
				fragment_output_0.z = fragment_unnamed_325;
				fragment_output_0.w = 1.0f;
				fragment_output_1.w = fragment_uniform_buffer_0[4u].x;
				fragment_output_2.x = mad(fragment_input_2.x, 0.5f, 0.5f);
				fragment_output_2.y = mad(fragment_input_2.y, 0.5f, 0.5f);
				fragment_output_2.z = mad(fragment_input_2.z, 0.5f, 0.5f);
				fragment_output_2.w = 1.0f;
				fragment_output_3.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[4] = float4(_Glossiness, fragment_uniform_buffer_0[4][1], fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[4] = float4(fragment_uniform_buffer_0[4][0], _Metallic, fragment_uniform_buffer_0[4][2], fragment_uniform_buffer_0[4][3]);

				fragment_uniform_buffer_0[5] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_uniform_buffer_1[39] = float4(unity_SHAr[0], unity_SHAr[1], unity_SHAr[2], unity_SHAr[3]);

				fragment_uniform_buffer_1[40] = float4(unity_SHAg[0], unity_SHAg[1], unity_SHAg[2], unity_SHAg[3]);

				fragment_uniform_buffer_1[41] = float4(unity_SHAb[0], unity_SHAb[1], unity_SHAb[2], unity_SHAb[3]);

				fragment_uniform_buffer_2[0] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_2[1] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_2[2] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_2[3] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_2[4] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_2[5] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], fragment_uniform_buffer_2[5][3]);

				fragment_uniform_buffer_2[6] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], fragment_uniform_buffer_2[6][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				stage_output.fragment_output_2 = fragment_output_2;
				stage_output.fragment_output_3 = fragment_output_3;
				return stage_output;
			}

			#endif // defined(LIGHTPROBE_SH) && defined(UNITY_HDR_ON)


			ENDHLSL
		}
	}
	FallBack "Standard"
}
