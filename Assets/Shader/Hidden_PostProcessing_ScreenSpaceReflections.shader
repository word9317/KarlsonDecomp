Shader "Hidden/PostProcessing/ScreenSpaceReflections"
{
	Properties
	{
	}
	SubShader
	{
		Pass
		{
			ZTest Always
			ZWrite Off
			Cull Off
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 56199

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f);
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f);
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f);
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4 _Test_TexelSize;
			float4x4 _ViewMatrix;
			float4x4 _InverseProjectionMatrix;
			float4x4 _ScreenSpaceProjectionMatrix;
			float4 _Params;
			float4 _Params2;
			float3 _WorldSpaceCameraPos;
			float4 _ProjectionParams;
			float4 _ZBufferParams;

			static float4 fragment_uniform_buffer_0[24];
			static float4 fragment_uniform_buffer_1[8];
			Texture2D<float4> _CameraDepthTexture;
			Texture2D<float4> _CameraGBufferTexture2;
			Texture2D<float4> _Noise;
			SamplerState sampler_CameraDepthTexture;
			SamplerState sampler_CameraGBufferTexture2;
			SamplerState sampler_Noise;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_52 = _CameraGBufferTexture2.Sample(sampler_CameraGBufferTexture2, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_54 = fragment_unnamed_52.x;
				if (dot(float4(fragment_unnamed_54, fragment_unnamed_52.yzw), 1.0f.xxxx) == 0.0f)
				{
					fragment_output_0.x = 0.0f;
					fragment_output_0.y = 0.0f;
					fragment_output_0.z = 0.0f;
					fragment_output_0.w = 0.0f;
					return;
				}
				else
				{
					float4 fragment_unnamed_76 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y), 0.0f);
					float fragment_unnamed_78 = fragment_unnamed_76.x;
					float fragment_unnamed_84 = mad(fragment_input_1.x, 2.0f, -1.0f);
					float fragment_unnamed_87 = mad(fragment_input_1.y, 2.0f, -1.0f);
					float fragment_unnamed_132 = mad(fragment_uniform_buffer_0[16u].w, fragment_unnamed_78, mad(fragment_uniform_buffer_0[14u].w, fragment_unnamed_84, fragment_unnamed_87 * fragment_uniform_buffer_0[15u].w)) + fragment_uniform_buffer_0[17u].w;
					float fragment_unnamed_133 = (mad(fragment_uniform_buffer_0[16u].x, fragment_unnamed_78, mad(fragment_uniform_buffer_0[14u].x, fragment_unnamed_84, fragment_unnamed_87 * fragment_uniform_buffer_0[15u].x)) + fragment_uniform_buffer_0[17u].x) / fragment_unnamed_132;
					float fragment_unnamed_134 = (mad(fragment_uniform_buffer_0[16u].y, fragment_unnamed_78, mad(fragment_uniform_buffer_0[14u].y, fragment_unnamed_84, fragment_unnamed_87 * fragment_uniform_buffer_0[15u].y)) + fragment_uniform_buffer_0[17u].y) / fragment_unnamed_132;
					float fragment_unnamed_135 = (mad(fragment_uniform_buffer_0[16u].z, fragment_unnamed_78, mad(fragment_uniform_buffer_0[14u].z, fragment_unnamed_84, fragment_unnamed_87 * fragment_uniform_buffer_0[15u].z)) + fragment_uniform_buffer_0[17u].z) / fragment_unnamed_132;
					if (fragment_unnamed_135 < ((-0.0f) - fragment_uniform_buffer_0[22u].z))
					{
						fragment_output_0.x = 0.0f;
						fragment_output_0.y = 0.0f;
						fragment_output_0.z = 0.0f;
						fragment_output_0.w = 0.0f;
						return;
					}
					else
					{
						float fragment_unnamed_147 = mad(fragment_unnamed_54, 2.0f, -1.0f);
						float fragment_unnamed_148 = mad(fragment_unnamed_52.y, 2.0f, -1.0f);
						float fragment_unnamed_149 = mad(fragment_unnamed_52.z, 2.0f, -1.0f);
						float fragment_unnamed_173 = mad(fragment_uniform_buffer_0[8u].x, fragment_unnamed_149, mad(fragment_uniform_buffer_0[6u].x, fragment_unnamed_147, fragment_unnamed_148 * fragment_uniform_buffer_0[7u].x));
						float fragment_unnamed_174 = mad(fragment_uniform_buffer_0[8u].y, fragment_unnamed_149, mad(fragment_uniform_buffer_0[6u].y, fragment_unnamed_147, fragment_unnamed_148 * fragment_uniform_buffer_0[7u].y));
						float fragment_unnamed_175 = mad(fragment_uniform_buffer_0[8u].z, fragment_unnamed_149, mad(fragment_uniform_buffer_0[6u].z, fragment_unnamed_147, fragment_unnamed_148 * fragment_uniform_buffer_0[7u].z));
						float fragment_unnamed_180 = rsqrt(dot(float3(fragment_unnamed_133, fragment_unnamed_134, fragment_unnamed_135), float3(fragment_unnamed_133, fragment_unnamed_134, fragment_unnamed_135)));
						float fragment_unnamed_181 = fragment_unnamed_180 * fragment_unnamed_133;
						float fragment_unnamed_182 = fragment_unnamed_180 * fragment_unnamed_134;
						float fragment_unnamed_183 = fragment_unnamed_180 * fragment_unnamed_135;
						float fragment_unnamed_184 = dot(float3(fragment_unnamed_181, fragment_unnamed_182, fragment_unnamed_183), float3(fragment_unnamed_173, fragment_unnamed_174, fragment_unnamed_175));
						float fragment_unnamed_188 = (-0.0f) - (fragment_unnamed_184 + fragment_unnamed_184);
						float fragment_unnamed_189 = mad(fragment_unnamed_173, fragment_unnamed_188, fragment_unnamed_181);
						float fragment_unnamed_190 = mad(fragment_unnamed_174, fragment_unnamed_188, fragment_unnamed_182);
						float fragment_unnamed_191 = mad(fragment_unnamed_175, fragment_unnamed_188, fragment_unnamed_183);
						float fragment_unnamed_195 = rsqrt(dot(float3(fragment_unnamed_189, fragment_unnamed_190, fragment_unnamed_191), float3(fragment_unnamed_189, fragment_unnamed_190, fragment_unnamed_191)));
						float fragment_unnamed_198 = fragment_unnamed_195 * fragment_unnamed_191;
						if (0.0f < fragment_unnamed_198)
						{
							fragment_output_0.x = 0.0f;
							fragment_output_0.y = 0.0f;
							fragment_output_0.z = 0.0f;
							fragment_output_0.w = 0.0f;
							return;
						}
						else
						{
							float fragment_unnamed_228 = asfloat((((-0.0f) - fragment_uniform_buffer_1[5u].y) < mad(fragment_unnamed_198, fragment_uniform_buffer_0[22u].z, fragment_unnamed_135)) ? asuint((((-0.0f) - fragment_unnamed_135) + ((-0.0f) - fragment_uniform_buffer_1[5u].y)) / fragment_unnamed_198) : asuint(fragment_uniform_buffer_0[22u]).z);
							float fragment_unnamed_231 = mad(fragment_unnamed_198, fragment_unnamed_228, fragment_unnamed_135);
							float fragment_unnamed_240 = fragment_unnamed_135 * fragment_uniform_buffer_0[20u].w;
							float fragment_unnamed_245 = mad(fragment_uniform_buffer_0[18u].x, fragment_unnamed_133, fragment_unnamed_135 * fragment_uniform_buffer_0[20u].x);
							float fragment_unnamed_250 = mad(fragment_uniform_buffer_0[19u].y, fragment_unnamed_134, fragment_unnamed_135 * fragment_uniform_buffer_0[20u].y);
							float fragment_unnamed_258 = fragment_unnamed_231 * fragment_uniform_buffer_0[20u].w;
							float fragment_unnamed_267 = 1.0f / fragment_unnamed_240;
							float fragment_unnamed_268 = 1.0f / fragment_unnamed_240;
							float fragment_unnamed_270 = 1.0f / fragment_unnamed_258;
							float fragment_unnamed_271 = fragment_unnamed_135 * fragment_unnamed_268;
							float fragment_unnamed_272 = fragment_unnamed_268 * fragment_unnamed_250;
							float fragment_unnamed_273 = fragment_unnamed_267 * fragment_unnamed_245;
							float fragment_unnamed_274 = (1.0f / fragment_unnamed_258) * mad(fragment_uniform_buffer_0[18u].x, mad(fragment_unnamed_195 * fragment_unnamed_189, fragment_unnamed_228, fragment_unnamed_133), fragment_unnamed_231 * fragment_uniform_buffer_0[20u].x);
							float fragment_unnamed_275 = fragment_unnamed_270 * mad(fragment_uniform_buffer_0[19u].y, mad(fragment_unnamed_195 * fragment_unnamed_190, fragment_unnamed_228, fragment_unnamed_134), fragment_unnamed_231 * fragment_uniform_buffer_0[20u].y);
							float fragment_unnamed_278 = mad(fragment_unnamed_245, fragment_unnamed_267, (-0.0f) - fragment_unnamed_274);
							float fragment_unnamed_279 = mad(fragment_unnamed_250, fragment_unnamed_268, (-0.0f) - fragment_unnamed_275);
							float fragment_unnamed_289 = asfloat(((9.9999997473787516355514526367188e-05f >= dot(float2(fragment_unnamed_278, fragment_unnamed_279), float2(fragment_unnamed_278, fragment_unnamed_279))) ? 4294967295u : 0u) & 1065353216u);
							float fragment_unnamed_296 = max(fragment_uniform_buffer_0[5u].y, fragment_uniform_buffer_0[5u].x);
							float fragment_unnamed_301 = mad((-0.0f) - fragment_unnamed_250, fragment_unnamed_268, mad(fragment_unnamed_289, fragment_unnamed_296, fragment_unnamed_275));
							float fragment_unnamed_302 = mad((-0.0f) - fragment_unnamed_245, fragment_unnamed_267, mad(fragment_unnamed_289, fragment_unnamed_296, fragment_unnamed_274));
							bool fragment_unnamed_305 = abs(fragment_unnamed_302) < abs(fragment_unnamed_301);
							float fragment_unnamed_317 = asfloat(fragment_unnamed_305 ? asuint(fragment_unnamed_301) : asuint(fragment_unnamed_302));
							float fragment_unnamed_326 = float(int((-((0.0f < fragment_unnamed_317) ? 4294967295u : 0u)) + ((fragment_unnamed_317 < 0.0f) ? 4294967295u : 0u)));
							float fragment_unnamed_327 = fragment_unnamed_326 / fragment_unnamed_317;
							float fragment_unnamed_330 = fragment_unnamed_327 * mad(fragment_unnamed_231, fragment_unnamed_270, (-0.0f) - fragment_unnamed_271);
							float fragment_unnamed_331 = fragment_unnamed_327 * asfloat(fragment_unnamed_305 ? asuint(fragment_unnamed_302) : asuint(fragment_unnamed_301));
							float fragment_unnamed_334 = fragment_unnamed_327 * (((-0.0f) - fragment_unnamed_268) + fragment_unnamed_270);
							float4 fragment_unnamed_362 = _Noise.SampleLevel(sampler_Noise, float2((fragment_input_1.x * fragment_uniform_buffer_0[23u].y) + fragment_uniform_buffer_1[4u].x, ((fragment_input_1.y * fragment_uniform_buffer_0[23u].y) * fragment_uniform_buffer_0[23u].x) + fragment_uniform_buffer_1[4u].z), 0.0f);
							float fragment_unnamed_364 = fragment_unnamed_362.w;
							float fragment_unnamed_368 = (((-0.0f) - min(fragment_unnamed_135 * (-0.00999999977648258209228515625f), 1.0f)) + 1.0f) * fragment_uniform_buffer_0[23u].z;
							float fragment_unnamed_371 = fragment_unnamed_368 * fragment_unnamed_334;
							float fragment_unnamed_372 = fragment_unnamed_368 * fragment_unnamed_330;
							float fragment_unnamed_377 = mad(fragment_unnamed_371, fragment_unnamed_364, fragment_unnamed_268);
							float fragment_unnamed_378 = mad(fragment_unnamed_372, fragment_unnamed_364, fragment_unnamed_271);
							uint fragment_unnamed_379 = asuint(mad(fragment_unnamed_368 * fragment_unnamed_326, fragment_unnamed_364, asfloat(fragment_unnamed_305 ? asuint(fragment_unnamed_272) : asuint(fragment_unnamed_273))));
							uint fragment_unnamed_380 = asuint(mad(fragment_unnamed_368 * fragment_unnamed_331, fragment_unnamed_364, asfloat(fragment_unnamed_305 ? asuint(fragment_unnamed_273) : asuint(fragment_unnamed_272))));
							float fragment_unnamed_381 = asfloat(0u);
							float fragment_unnamed_382 = asfloat(0u);
							uint fragment_unnamed_386;
							uint fragment_unnamed_388;
							float fragment_unnamed_390;
							float fragment_unnamed_392;
							float fragment_unnamed_394;
							uint fragment_unnamed_401;
							uint fragment_unnamed_403;
							uint fragment_unnamed_405;
							uint fragment_unnamed_407;
							uint fragment_unnamed_409;
							uint fragment_unnamed_410;
							uint fragment_unnamed_411;
							uint fragment_unnamed_412;
							uint fragment_unnamed_413;
							float fragment_unnamed_383 = fragment_unnamed_382;
							uint fragment_unnamed_385 = fragment_unnamed_379;
							uint fragment_unnamed_387 = fragment_unnamed_380;
							float fragment_unnamed_389 = fragment_unnamed_377;
							float fragment_unnamed_391 = fragment_unnamed_378;
							float fragment_unnamed_393 = fragment_unnamed_381;
							for (;;)
							{
								if (float(int(asuint(fragment_unnamed_383))) >= fragment_uniform_buffer_0[23u].w)
								{
									fragment_unnamed_401 = 0u;
									fragment_unnamed_403 = 0u;
									fragment_unnamed_405 = 0u;
									fragment_unnamed_407 = 0u;
									fragment_unnamed_409 = 0u;
									fragment_unnamed_410 = 0u;
									fragment_unnamed_411 = 0u;
									fragment_unnamed_412 = 0u;
									fragment_unnamed_413 = 0u;
									break;
								}
								else
								{
									fragment_unnamed_386 = asuint(mad(fragment_unnamed_326, fragment_unnamed_368, asfloat(fragment_unnamed_385)));
									fragment_unnamed_388 = asuint(mad(fragment_unnamed_331, fragment_unnamed_368, asfloat(fragment_unnamed_387)));
									fragment_unnamed_390 = mad(fragment_unnamed_334, fragment_unnamed_368, fragment_unnamed_389);
									fragment_unnamed_392 = mad(fragment_unnamed_330, fragment_unnamed_368, fragment_unnamed_391);
									float fragment_unnamed_439 = mad(fragment_unnamed_372, 0.5f, fragment_unnamed_392) / mad(fragment_unnamed_371, 0.5f, fragment_unnamed_390);
									fragment_unnamed_394 = asfloat((fragment_unnamed_393 < fragment_unnamed_439) ? asuint(fragment_unnamed_393) : asuint(fragment_unnamed_439));
									float fragment_unnamed_452 = asfloat(fragment_unnamed_305 ? fragment_unnamed_388 : fragment_unnamed_386) * fragment_uniform_buffer_0[5u].x;
									float fragment_unnamed_453 = asfloat(fragment_unnamed_305 ? fragment_unnamed_386 : fragment_unnamed_388) * fragment_uniform_buffer_0[5u].y;
									bool fragment_unnamed_467 = fragment_unnamed_394 < ((-0.0f) - (1.0f / mad(fragment_uniform_buffer_1[7u].z, _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, float2(fragment_unnamed_452, fragment_unnamed_453), 0.0f).x, fragment_uniform_buffer_1[7u].w)));
									uint fragment_unnamed_468 = fragment_unnamed_467 ? 4294967295u : 0u;
									uint fragment_unnamed_404 = fragment_unnamed_468 & 4294967295u;
									uint fragment_unnamed_406 = fragment_unnamed_468 & asuint(fragment_unnamed_452);
									uint fragment_unnamed_408 = fragment_unnamed_468 & asuint(fragment_unnamed_453);
									uint fragment_unnamed_402 = fragment_unnamed_468 & (asuint(fragment_unnamed_383) + 1u);
									if (fragment_unnamed_467)
									{
										fragment_unnamed_401 = fragment_unnamed_402;
										fragment_unnamed_403 = fragment_unnamed_404;
										fragment_unnamed_405 = fragment_unnamed_406;
										fragment_unnamed_407 = fragment_unnamed_408;
										fragment_unnamed_409 = fragment_unnamed_404;
										fragment_unnamed_410 = fragment_unnamed_406;
										fragment_unnamed_411 = fragment_unnamed_408;
										fragment_unnamed_412 = fragment_unnamed_402;
										fragment_unnamed_413 = fragment_unnamed_404;
										break;
									}
									fragment_unnamed_383 = asfloat(asuint(fragment_unnamed_383) + 1u);
									fragment_unnamed_385 = fragment_unnamed_386;
									fragment_unnamed_387 = fragment_unnamed_388;
									fragment_unnamed_389 = fragment_unnamed_390;
									fragment_unnamed_391 = fragment_unnamed_392;
									fragment_unnamed_393 = fragment_unnamed_394;
									continue;
								}
							}
							bool fragment_unnamed_414 = fragment_unnamed_413 != 0u;
							fragment_output_0.z = float(int(fragment_unnamed_414 ? fragment_unnamed_401 : fragment_unnamed_412)) / fragment_uniform_buffer_0[23u].w;
							fragment_output_0.w = asfloat((fragment_unnamed_414 ? fragment_unnamed_403 : fragment_unnamed_409) & 1065353216u);
							fragment_output_0.x = asfloat(fragment_unnamed_414 ? fragment_unnamed_405 : fragment_unnamed_410);
							fragment_output_0.y = asfloat(fragment_unnamed_414 ? fragment_unnamed_407 : fragment_unnamed_411);
							return;
						}
					}
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[5] = float4(_Test_TexelSize[0], _Test_TexelSize[1], _Test_TexelSize[2], _Test_TexelSize[3]);

				fragment_uniform_buffer_0[6] = float4(_ViewMatrix[0][0], _ViewMatrix[1][0], _ViewMatrix[2][0], _ViewMatrix[3][0]);
				fragment_uniform_buffer_0[7] = float4(_ViewMatrix[0][1], _ViewMatrix[1][1], _ViewMatrix[2][1], _ViewMatrix[3][1]);
				fragment_uniform_buffer_0[8] = float4(_ViewMatrix[0][2], _ViewMatrix[1][2], _ViewMatrix[2][2], _ViewMatrix[3][2]);
				fragment_uniform_buffer_0[9] = float4(_ViewMatrix[0][3], _ViewMatrix[1][3], _ViewMatrix[2][3], _ViewMatrix[3][3]);

				fragment_uniform_buffer_0[14] = float4(_InverseProjectionMatrix[0][0], _InverseProjectionMatrix[1][0], _InverseProjectionMatrix[2][0], _InverseProjectionMatrix[3][0]);
				fragment_uniform_buffer_0[15] = float4(_InverseProjectionMatrix[0][1], _InverseProjectionMatrix[1][1], _InverseProjectionMatrix[2][1], _InverseProjectionMatrix[3][1]);
				fragment_uniform_buffer_0[16] = float4(_InverseProjectionMatrix[0][2], _InverseProjectionMatrix[1][2], _InverseProjectionMatrix[2][2], _InverseProjectionMatrix[3][2]);
				fragment_uniform_buffer_0[17] = float4(_InverseProjectionMatrix[0][3], _InverseProjectionMatrix[1][3], _InverseProjectionMatrix[2][3], _InverseProjectionMatrix[3][3]);

				fragment_uniform_buffer_0[18] = float4(_ScreenSpaceProjectionMatrix[0][0], _ScreenSpaceProjectionMatrix[1][0], _ScreenSpaceProjectionMatrix[2][0], _ScreenSpaceProjectionMatrix[3][0]);
				fragment_uniform_buffer_0[19] = float4(_ScreenSpaceProjectionMatrix[0][1], _ScreenSpaceProjectionMatrix[1][1], _ScreenSpaceProjectionMatrix[2][1], _ScreenSpaceProjectionMatrix[3][1]);
				fragment_uniform_buffer_0[20] = float4(_ScreenSpaceProjectionMatrix[0][2], _ScreenSpaceProjectionMatrix[1][2], _ScreenSpaceProjectionMatrix[2][2], _ScreenSpaceProjectionMatrix[3][2]);
				fragment_uniform_buffer_0[21] = float4(_ScreenSpaceProjectionMatrix[0][3], _ScreenSpaceProjectionMatrix[1][3], _ScreenSpaceProjectionMatrix[2][3], _ScreenSpaceProjectionMatrix[3][3]);

				fragment_uniform_buffer_0[22] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

				fragment_uniform_buffer_0[23] = float4(_Params2[0], _Params2[1], _Params2[2], _Params2[3]);

				fragment_uniform_buffer_1[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_1[5] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_1[7] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
		Pass
		{
			ZTest Always
			ZWrite Off
			Cull Off
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 101441

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f);
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f);
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f);
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4 _MainTex_TexelSize;
			float4 _Params;

			static float4 fragment_uniform_buffer_0[23];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _Test;
			SamplerState sampler_MainTex;

			static float4 gl_FragCoord;
			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_40 = _Test.Load(int3(uint2(uint(int(gl_FragCoord.x)), uint(int(gl_FragCoord.y))), 0u));
				float fragment_unnamed_43 = fragment_unnamed_40.x;
				float fragment_unnamed_44 = fragment_unnamed_40.y;
				float fragment_unnamed_46 = fragment_unnamed_40.w;
				if (fragment_unnamed_46 == 0.0f)
				{
					float4 fragment_unnamed_56 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
					fragment_output_0.x = fragment_unnamed_56.x;
					fragment_output_0.y = fragment_unnamed_56.y;
					fragment_output_0.z = fragment_unnamed_56.z;
					fragment_output_0.w = fragment_unnamed_56.w;
					return;
				}
				else
				{
					float4 fragment_unnamed_70 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_43, fragment_unnamed_44), 0.0f);
					float fragment_unnamed_100 = abs(fragment_unnamed_44 + (-0.5f)) * fragment_uniform_buffer_0[22u].x;
					float fragment_unnamed_109 = (fragment_uniform_buffer_0[4u].z * fragment_uniform_buffer_0[4u].y) * (abs(fragment_unnamed_43 + (-0.5f)) * fragment_uniform_buffer_0[22u].x);
					float fragment_unnamed_115 = max(((-0.0f) - dot(float2(fragment_unnamed_109, fragment_unnamed_100), float2(fragment_unnamed_109, fragment_unnamed_100))) + 1.0f, 0.0f);
					float fragment_unnamed_116 = fragment_unnamed_115 * fragment_unnamed_115;
					float fragment_unnamed_119 = ((fragment_unnamed_116 * fragment_unnamed_116) * fragment_unnamed_115) * (fragment_unnamed_46 * (1.0f / rsqrt(clamp(min(((-0.0f) - max(fragment_unnamed_44, fragment_unnamed_43)) + 1.0f, min(fragment_unnamed_44, fragment_unnamed_43)) * 2.1917808055877685546875f, 0.0f, 1.0f))));
					fragment_output_0.x = fragment_unnamed_119 * fragment_unnamed_70.x;
					fragment_output_0.y = fragment_unnamed_119 * fragment_unnamed_70.y;
					fragment_output_0.z = fragment_unnamed_119 * fragment_unnamed_70.z;
					fragment_output_0.w = fragment_unnamed_40.z;
					return;
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[4] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[22] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
		Pass
		{
			ZTest Always
			ZWrite Off
			Cull Off
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 154502

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f);
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f);
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f);
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[5];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _History;
			Texture2D<float4> _CameraMotionVectorsTexture;
			SamplerState sampler_MainTex;
			SamplerState sampler_History;
			SamplerState sampler_CameraMotionVectorsTexture;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_47 = (-0.0f) - fragment_uniform_buffer_0[4u].y;
				float4 fragment_unnamed_61 = _MainTex.SampleLevel(sampler_MainTex, float2(((-0.0f) - fragment_uniform_buffer_0[4u].x) + fragment_input_1.x, fragment_unnamed_47 + fragment_input_1.y), 0.0f);
				float fragment_unnamed_63 = fragment_unnamed_61.x;
				float fragment_unnamed_64 = fragment_unnamed_61.y;
				float fragment_unnamed_65 = fragment_unnamed_61.z;
				float fragment_unnamed_66 = fragment_unnamed_61.w;
				float4 fragment_unnamed_67 = _MainTex.SampleLevel(sampler_MainTex, float2(asfloat(0u) + fragment_input_1.x, fragment_unnamed_47 + fragment_input_1.y), 0.0f);
				float fragment_unnamed_69 = fragment_unnamed_67.x;
				float fragment_unnamed_70 = fragment_unnamed_67.y;
				float fragment_unnamed_71 = fragment_unnamed_67.z;
				float fragment_unnamed_72 = fragment_unnamed_67.w;
				float4 fragment_unnamed_96 = _MainTex.SampleLevel(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[4u].x, 1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[4u].y, -1.0f, fragment_input_1.y)), 0.0f);
				float fragment_unnamed_98 = fragment_unnamed_96.x;
				float fragment_unnamed_99 = fragment_unnamed_96.y;
				float fragment_unnamed_100 = fragment_unnamed_96.z;
				float fragment_unnamed_101 = fragment_unnamed_96.w;
				float4 fragment_unnamed_102 = _MainTex.SampleLevel(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[4u].x, -1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[4u].y, 1.0f, fragment_input_1.y)), 0.0f);
				float fragment_unnamed_104 = fragment_unnamed_102.x;
				float fragment_unnamed_105 = fragment_unnamed_102.y;
				float fragment_unnamed_106 = fragment_unnamed_102.z;
				float fragment_unnamed_107 = fragment_unnamed_102.w;
				float4 fragment_unnamed_128 = _MainTex.SampleLevel(sampler_MainTex, float2(((-0.0f) - fragment_uniform_buffer_0[4u].x) + fragment_input_1.x, asfloat(0u) + fragment_input_1.y), 0.0f);
				float fragment_unnamed_130 = fragment_unnamed_128.x;
				float fragment_unnamed_131 = fragment_unnamed_128.y;
				float fragment_unnamed_132 = fragment_unnamed_128.z;
				float fragment_unnamed_133 = fragment_unnamed_128.w;
				float4 fragment_unnamed_154 = _MainTex.SampleLevel(sampler_MainTex, float2(asfloat(asuint(fragment_uniform_buffer_0[4u]).x) + fragment_input_1.x, asfloat(0u) + fragment_input_1.y), 0.0f);
				float fragment_unnamed_156 = fragment_unnamed_154.x;
				float fragment_unnamed_157 = fragment_unnamed_154.y;
				float fragment_unnamed_158 = fragment_unnamed_154.z;
				float fragment_unnamed_159 = fragment_unnamed_154.w;
				float4 fragment_unnamed_188 = _MainTex.SampleLevel(sampler_MainTex, float2(asfloat(0u) + fragment_input_1.x, asfloat(asuint(fragment_uniform_buffer_0[4u]).y) + fragment_input_1.y), 0.0f);
				float fragment_unnamed_190 = fragment_unnamed_188.x;
				float fragment_unnamed_191 = fragment_unnamed_188.y;
				float fragment_unnamed_192 = fragment_unnamed_188.z;
				float fragment_unnamed_193 = fragment_unnamed_188.w;
				float4 fragment_unnamed_212 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_1.x + fragment_uniform_buffer_0[4u].x, fragment_input_1.y + fragment_uniform_buffer_0[4u].y), 0.0f);
				float fragment_unnamed_214 = fragment_unnamed_212.x;
				float fragment_unnamed_215 = fragment_unnamed_212.y;
				float fragment_unnamed_216 = fragment_unnamed_212.z;
				float fragment_unnamed_217 = fragment_unnamed_212.w;
				float4 fragment_unnamed_230 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y), 0.0f);
				float fragment_unnamed_232 = fragment_unnamed_230.x;
				float fragment_unnamed_233 = fragment_unnamed_230.y;
				float fragment_unnamed_234 = fragment_unnamed_230.z;
				float fragment_unnamed_235 = fragment_unnamed_230.w;
				float4 fragment_unnamed_245 = _CameraMotionVectorsTexture.SampleLevel(sampler_CameraMotionVectorsTexture, float2(fragment_input_1.x, fragment_input_1.y), 0.0f);
				float fragment_unnamed_247 = fragment_unnamed_245.x;
				float4 fragment_unnamed_268 = _History.SampleLevel(sampler_History, float2(((-0.0f) - fragment_unnamed_247) + fragment_input_1.x, ((-0.0f) - fragment_unnamed_245.y) + fragment_input_1.y), 0.0f);
				float fragment_unnamed_285 = min(max(max(max(max(fragment_unnamed_107, max(max(max(max(fragment_unnamed_72, fragment_unnamed_66), fragment_unnamed_101), fragment_unnamed_133), fragment_unnamed_159)), fragment_unnamed_193), fragment_unnamed_217), fragment_unnamed_235), max(min(min(min(min(fragment_unnamed_107, min(min(min(min(fragment_unnamed_72, fragment_unnamed_66), fragment_unnamed_101), fragment_unnamed_133), fragment_unnamed_159)), fragment_unnamed_193), fragment_unnamed_217), fragment_unnamed_235), fragment_unnamed_268.w));
				float fragment_unnamed_293 = clamp((1.0f / (fragment_uniform_buffer_0[4u].z * 0.00150000001303851604461669921875f)) * mad((-0.0f) - fragment_uniform_buffer_0[4u].z, 0.00200000009499490261077880859375f, sqrt(dot(float2(fragment_unnamed_247, fragment_unnamed_245.y), float2(fragment_unnamed_247, fragment_unnamed_245.y)))), 0.0f, 1.0f);
				float fragment_unnamed_300 = min((fragment_unnamed_293 * fragment_unnamed_293) * mad(fragment_unnamed_293, -2.0f, 3.0f), 1.0f) * 0.85000002384185791015625f;
				float fragment_unnamed_315 = min(max(mad(fragment_unnamed_285, -25.0f, 0.949999988079071044921875f), 0.699999988079071044921875f), 0.949999988079071044921875f);
				fragment_output_0.x = mad(fragment_unnamed_315, min(max(max(max(max(fragment_unnamed_104, max(max(max(max(fragment_unnamed_69, fragment_unnamed_63), fragment_unnamed_98), fragment_unnamed_130), fragment_unnamed_156)), fragment_unnamed_190), fragment_unnamed_214), fragment_unnamed_232), max(min(min(min(min(fragment_unnamed_104, min(min(min(min(fragment_unnamed_69, fragment_unnamed_63), fragment_unnamed_98), fragment_unnamed_130), fragment_unnamed_156)), fragment_unnamed_190), fragment_unnamed_214), fragment_unnamed_232), fragment_unnamed_268.x)) + ((-0.0f) - fragment_unnamed_232), fragment_unnamed_232);
				fragment_output_0.y = mad(fragment_unnamed_315, min(max(max(max(max(fragment_unnamed_105, max(max(max(max(fragment_unnamed_70, fragment_unnamed_64), fragment_unnamed_99), fragment_unnamed_131), fragment_unnamed_157)), fragment_unnamed_191), fragment_unnamed_215), fragment_unnamed_233), max(min(min(min(min(fragment_unnamed_105, min(min(min(min(fragment_unnamed_70, fragment_unnamed_64), fragment_unnamed_99), fragment_unnamed_131), fragment_unnamed_157)), fragment_unnamed_191), fragment_unnamed_215), fragment_unnamed_233), fragment_unnamed_268.y)) + ((-0.0f) - fragment_unnamed_233), fragment_unnamed_233);
				fragment_output_0.z = mad(fragment_unnamed_315, min(max(max(max(max(fragment_unnamed_106, max(max(max(max(fragment_unnamed_71, fragment_unnamed_65), fragment_unnamed_100), fragment_unnamed_132), fragment_unnamed_158)), fragment_unnamed_192), fragment_unnamed_216), fragment_unnamed_234), max(min(min(min(min(fragment_unnamed_106, min(min(min(min(fragment_unnamed_71, fragment_unnamed_65), fragment_unnamed_100), fragment_unnamed_132), fragment_unnamed_158)), fragment_unnamed_192), fragment_unnamed_216), fragment_unnamed_234), fragment_unnamed_268.z)) + ((-0.0f) - fragment_unnamed_234), fragment_unnamed_234);
				fragment_output_0.w = mad(fragment_unnamed_315, fragment_unnamed_285 + ((-0.0f) - fragment_unnamed_300), fragment_unnamed_300);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[4] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
		Pass
		{
			ZTest Always
			ZWrite Off
			Cull Off
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 245549

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f);
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f);
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f);
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4x4 _InverseViewMatrix;
			float4x4 _InverseProjectionMatrix;
			float4 _Params;
			float4 _ZBufferParams;

			static float4 fragment_uniform_buffer_0[23];
			static float4 fragment_uniform_buffer_1[8];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _CameraDepthTexture;
			Texture2D<float4> _CameraReflectionsTexture;
			Texture2D<float4> _CameraGBufferTexture0;
			Texture2D<float4> _CameraGBufferTexture1;
			Texture2D<float4> _CameraGBufferTexture2;
			Texture2D<float4> _Resolve;
			SamplerState sampler_MainTex;
			SamplerState sampler_CameraDepthTexture;
			SamplerState sampler_CameraReflectionsTexture;
			SamplerState sampler_Resolve;

			static float4 gl_FragCoord;
			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				if (0.999000012874603271484375f < (1.0f / mad(fragment_uniform_buffer_1[7u].x, _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y), 0.0f).x, fragment_uniform_buffer_1[7u].y)))
				{
					float4 fragment_unnamed_85 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
					fragment_output_0.x = fragment_unnamed_85.x;
					fragment_output_0.y = fragment_unnamed_85.y;
					fragment_output_0.z = fragment_unnamed_85.z;
					fragment_output_0.w = fragment_unnamed_85.w;
					return;
				}
				else
				{
					uint fragment_unnamed_102 = uint(int(gl_FragCoord.x));
					uint fragment_unnamed_103 = uint(int(gl_FragCoord.y));
					float4 fragment_unnamed_104 = _CameraGBufferTexture0.Load(int3(uint2(fragment_unnamed_102, fragment_unnamed_103), 0u));
					float fragment_unnamed_107 = fragment_unnamed_104.w;
					float4 fragment_unnamed_108 = _CameraGBufferTexture1.Load(int3(uint2(fragment_unnamed_102, fragment_unnamed_103), 0u));
					float fragment_unnamed_110 = fragment_unnamed_108.x;
					float fragment_unnamed_111 = fragment_unnamed_108.y;
					float fragment_unnamed_112 = fragment_unnamed_108.z;
					float fragment_unnamed_113 = fragment_unnamed_108.w;
					float4 fragment_unnamed_114 = _CameraGBufferTexture2.Load(int3(uint2(fragment_unnamed_102, fragment_unnamed_103), 0u));
					float fragment_unnamed_124 = mad(fragment_unnamed_114.x, 2.0f, -1.0f);
					float fragment_unnamed_127 = mad(fragment_unnamed_114.y, 2.0f, -1.0f);
					float fragment_unnamed_128 = mad(fragment_unnamed_114.z, 2.0f, -1.0f);
					float4 fragment_unnamed_134 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y), 0.0f);
					float fragment_unnamed_136 = fragment_unnamed_134.x;
					float fragment_unnamed_141 = mad(fragment_input_1.x, 2.0f, -1.0f);
					float fragment_unnamed_142 = mad(fragment_input_1.y, 2.0f, -1.0f);
					float fragment_unnamed_186 = mad(fragment_uniform_buffer_0[16u].w, fragment_unnamed_136, mad(fragment_uniform_buffer_0[14u].w, fragment_unnamed_141, fragment_unnamed_142 * fragment_uniform_buffer_0[15u].w)) + fragment_uniform_buffer_0[17u].w;
					float fragment_unnamed_187 = (mad(fragment_uniform_buffer_0[16u].x, fragment_unnamed_136, mad(fragment_uniform_buffer_0[14u].x, fragment_unnamed_141, fragment_unnamed_142 * fragment_uniform_buffer_0[15u].x)) + fragment_uniform_buffer_0[17u].x) / fragment_unnamed_186;
					float fragment_unnamed_188 = (mad(fragment_uniform_buffer_0[16u].y, fragment_unnamed_136, mad(fragment_uniform_buffer_0[14u].y, fragment_unnamed_141, fragment_unnamed_142 * fragment_uniform_buffer_0[15u].y)) + fragment_uniform_buffer_0[17u].y) / fragment_unnamed_186;
					float fragment_unnamed_189 = (mad(fragment_uniform_buffer_0[16u].z, fragment_unnamed_136, mad(fragment_uniform_buffer_0[14u].z, fragment_unnamed_141, fragment_unnamed_142 * fragment_uniform_buffer_0[15u].z)) + fragment_uniform_buffer_0[17u].z) / fragment_unnamed_186;
					float fragment_unnamed_194 = rsqrt(dot(float3(fragment_unnamed_187, fragment_unnamed_188, fragment_unnamed_189), float3(fragment_unnamed_187, fragment_unnamed_188, fragment_unnamed_189)));
					float fragment_unnamed_195 = fragment_unnamed_187 * fragment_unnamed_194;
					float fragment_unnamed_196 = fragment_unnamed_188 * fragment_unnamed_194;
					float fragment_unnamed_197 = fragment_unnamed_189 * fragment_unnamed_194;
					float fragment_unnamed_222 = mad(fragment_uniform_buffer_0[12u].x, fragment_unnamed_197, mad(fragment_uniform_buffer_0[10u].x, fragment_unnamed_195, fragment_unnamed_196 * fragment_uniform_buffer_0[11u].x));
					float fragment_unnamed_223 = mad(fragment_uniform_buffer_0[12u].y, fragment_unnamed_197, mad(fragment_uniform_buffer_0[10u].y, fragment_unnamed_195, fragment_unnamed_196 * fragment_uniform_buffer_0[11u].y));
					float fragment_unnamed_224 = mad(fragment_uniform_buffer_0[12u].z, fragment_unnamed_197, mad(fragment_uniform_buffer_0[10u].z, fragment_unnamed_195, fragment_unnamed_196 * fragment_uniform_buffer_0[11u].z));
					float fragment_unnamed_226 = ((-0.0f) - fragment_unnamed_113) + 1.0f;
					float fragment_unnamed_227 = fragment_unnamed_226 * fragment_unnamed_226;
					float4 fragment_unnamed_239 = _Resolve.SampleLevel(sampler_Resolve, float2(fragment_input_1.x, fragment_input_1.y), mad(fragment_unnamed_227, fragment_uniform_buffer_0[22u].w + (-1.0f), 1.0f));
					float fragment_unnamed_244 = fragment_unnamed_239.w;
					float fragment_unnamed_248 = dot(float3((-0.0f) - fragment_unnamed_222, (-0.0f) - fragment_unnamed_223, (-0.0f) - fragment_unnamed_224), float3(fragment_unnamed_124, fragment_unnamed_127, fragment_unnamed_128));
					float fragment_unnamed_252 = (-0.0f) - (fragment_unnamed_248 + fragment_unnamed_248);
					float fragment_unnamed_256 = mad(fragment_unnamed_124, fragment_unnamed_252, (-0.0f) - fragment_unnamed_222);
					float fragment_unnamed_257 = mad(fragment_unnamed_127, fragment_unnamed_252, (-0.0f) - fragment_unnamed_223);
					float fragment_unnamed_258 = mad(fragment_unnamed_128, fragment_unnamed_252, (-0.0f) - fragment_unnamed_224);
					float fragment_unnamed_262 = rsqrt(dot(float3(fragment_unnamed_256, fragment_unnamed_257, fragment_unnamed_258), float3(fragment_unnamed_256, fragment_unnamed_257, fragment_unnamed_258)));
					float fragment_unnamed_269 = dot(float3((-0.0f) - fragment_unnamed_222, (-0.0f) - fragment_unnamed_223, (-0.0f) - fragment_unnamed_224), float3(fragment_unnamed_256 * fragment_unnamed_262, fragment_unnamed_257 * fragment_unnamed_262, fragment_unnamed_258 * fragment_unnamed_262));
					float fragment_unnamed_279 = mad((-0.0f) - (max(fragment_unnamed_227, 0.00200000009499490261077880859375f) * 0.2800000011920928955078125f), fragment_unnamed_226, 1.0f);
					float fragment_unnamed_283 = clamp((((-0.0f) - (((-0.0f) - max(fragment_unnamed_112, max(fragment_unnamed_111, fragment_unnamed_110))) + 1.0f)) + fragment_unnamed_113) + 1.0f, 0.0f, 1.0f);
					float fragment_unnamed_289 = ((-0.0f) - abs(fragment_unnamed_248)) + 1.0f;
					float fragment_unnamed_290 = fragment_unnamed_289 * fragment_unnamed_289;
					float fragment_unnamed_292 = fragment_unnamed_289 * (fragment_unnamed_290 * fragment_unnamed_290);
					float4 fragment_unnamed_307 = _CameraReflectionsTexture.Sample(sampler_CameraReflectionsTexture, float2(fragment_input_1.x, fragment_input_1.y));
					float fragment_unnamed_309 = fragment_unnamed_307.x;
					float fragment_unnamed_310 = fragment_unnamed_307.y;
					float fragment_unnamed_311 = fragment_unnamed_307.z;
					float4 fragment_unnamed_317 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
					float fragment_unnamed_332 = fragment_unnamed_244 * fragment_unnamed_244;
					float fragment_unnamed_335 = mad(fragment_unnamed_332, 3.0f, -0.5f);
					float fragment_unnamed_338 = clamp(fragment_unnamed_335 + fragment_unnamed_335, 0.0f, 1.0f);
					float fragment_unnamed_351 = clamp(fragment_unnamed_269 + fragment_unnamed_269, 0.0f, 1.0f) * (((-0.0f) - clamp((((fragment_unnamed_338 * fragment_unnamed_338) * mad(fragment_unnamed_338, -2.0f, 3.0f)) * (fragment_unnamed_332 * 3.0f)) * fragment_uniform_buffer_0[22u].y, 0.0f, 1.0f)) + 1.0f);
					fragment_output_0.x = mad(mad(fragment_unnamed_351, mad(fragment_unnamed_239.x * fragment_unnamed_279, mad(fragment_unnamed_292, ((-0.0f) - fragment_unnamed_110) + fragment_unnamed_283, fragment_unnamed_110), (-0.0f) - fragment_unnamed_309), fragment_unnamed_309), fragment_unnamed_107, max(((-0.0f) - fragment_unnamed_309) + fragment_unnamed_317.x, 0.0f));
					fragment_output_0.y = mad(mad(fragment_unnamed_351, mad(fragment_unnamed_239.y * fragment_unnamed_279, mad(fragment_unnamed_292, ((-0.0f) - fragment_unnamed_111) + fragment_unnamed_283, fragment_unnamed_111), (-0.0f) - fragment_unnamed_310), fragment_unnamed_310), fragment_unnamed_107, max(((-0.0f) - fragment_unnamed_310) + fragment_unnamed_317.y, 0.0f));
					fragment_output_0.z = mad(mad(fragment_unnamed_351, mad(fragment_unnamed_239.z * fragment_unnamed_279, mad(fragment_unnamed_292, ((-0.0f) - fragment_unnamed_112) + fragment_unnamed_283, fragment_unnamed_112), (-0.0f) - fragment_unnamed_311), fragment_unnamed_311), fragment_unnamed_107, max(((-0.0f) - fragment_unnamed_311) + fragment_unnamed_317.z, 0.0f));
					fragment_output_0.w = fragment_unnamed_317.w;
					return;
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[10] = float4(_InverseViewMatrix[0][0], _InverseViewMatrix[1][0], _InverseViewMatrix[2][0], _InverseViewMatrix[3][0]);
				fragment_uniform_buffer_0[11] = float4(_InverseViewMatrix[0][1], _InverseViewMatrix[1][1], _InverseViewMatrix[2][1], _InverseViewMatrix[3][1]);
				fragment_uniform_buffer_0[12] = float4(_InverseViewMatrix[0][2], _InverseViewMatrix[1][2], _InverseViewMatrix[2][2], _InverseViewMatrix[3][2]);
				fragment_uniform_buffer_0[13] = float4(_InverseViewMatrix[0][3], _InverseViewMatrix[1][3], _InverseViewMatrix[2][3], _InverseViewMatrix[3][3]);

				fragment_uniform_buffer_0[14] = float4(_InverseProjectionMatrix[0][0], _InverseProjectionMatrix[1][0], _InverseProjectionMatrix[2][0], _InverseProjectionMatrix[3][0]);
				fragment_uniform_buffer_0[15] = float4(_InverseProjectionMatrix[0][1], _InverseProjectionMatrix[1][1], _InverseProjectionMatrix[2][1], _InverseProjectionMatrix[3][1]);
				fragment_uniform_buffer_0[16] = float4(_InverseProjectionMatrix[0][2], _InverseProjectionMatrix[1][2], _InverseProjectionMatrix[2][2], _InverseProjectionMatrix[3][2]);
				fragment_uniform_buffer_0[17] = float4(_InverseProjectionMatrix[0][3], _InverseProjectionMatrix[1][3], _InverseProjectionMatrix[2][3], _InverseProjectionMatrix[3][3]);

				fragment_uniform_buffer_0[22] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

				fragment_uniform_buffer_1[7] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
	}
}
