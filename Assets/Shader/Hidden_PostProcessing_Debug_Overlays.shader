Shader "Hidden/PostProcessing/Debug/Overlays"
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
			GpuProgramID 30676

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float _RenderViewportScaleFactor;

			static float4 vertex_uniform_buffer_0[27];
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
				precise float vertex_unnamed_42 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_43 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_54 = mad(vertex_unnamed_42, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_55 = mad(vertex_unnamed_43, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_54;
				vertex_output_1.y = vertex_unnamed_55;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4 unity_OrthoParams;
			float4 _ZBufferParams;
			float4 _Params;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _CameraDepthTexture;
			SamplerState sampler_CameraDepthTexture;

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
				precise float fragment_unnamed_35 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_37 = fragment_unnamed_35 + 1.0f;
				float4 fragment_unnamed_48 = _CameraDepthTexture.SampleLevel(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y), 0.0f);
				float fragment_unnamed_50 = fragment_unnamed_48.x;
				precise float fragment_unnamed_55 = fragment_unnamed_50 * fragment_uniform_buffer_0[21u].x;
				precise float fragment_unnamed_64 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_66 = mad(fragment_unnamed_64, fragment_unnamed_55, 1.0f) / mad(fragment_unnamed_37, fragment_unnamed_55, fragment_uniform_buffer_0[21u].y);
				precise float fragment_unnamed_67 = (-0.0f) - fragment_unnamed_50;
				precise float fragment_unnamed_68 = fragment_unnamed_67 + fragment_unnamed_66;
				fragment_output_0.x = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_68, fragment_unnamed_50);
				fragment_output_0.y = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_68, fragment_unnamed_50);
				fragment_output_0.z = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_68, fragment_unnamed_50);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[20] = float4(unity_OrthoParams[0], unity_OrthoParams[1], unity_OrthoParams[2], unity_OrthoParams[3]);

				fragment_uniform_buffer_0[21] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_uniform_buffer_0[29] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

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
			GpuProgramID 80912

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#pragma multi_compile _ SOURCE_GBUFFER


			#if !defined(SOURCE_GBUFFER)

			float _RenderViewportScaleFactor;

			static float4 vertex_uniform_buffer_0[27];
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
				precise float vertex_unnamed_42 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_43 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_54 = mad(vertex_unnamed_42, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_55 = mad(vertex_unnamed_43, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_54;
				vertex_output_1.y = vertex_unnamed_55;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			Texture2D<float4> _CameraDepthNormalsTexture;
			SamplerState sampler_CameraDepthNormalsTexture;

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
				float4 fragment_unnamed_34 = _CameraDepthNormalsTexture.Sample(sampler_CameraDepthNormalsTexture, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_40 = mad(fragment_unnamed_34.x, 3.55539989471435546875f, -1.777699947357177734375f);
				float fragment_unnamed_43 = mad(fragment_unnamed_34.y, 3.55539989471435546875f, -1.777699947357177734375f);
				float fragment_unnamed_44 = mad(fragment_unnamed_34.z, 0.0f, 1.0f);
				precise float fragment_unnamed_50 = 2.0f / dot(float3(fragment_unnamed_40, fragment_unnamed_43, fragment_unnamed_44), float3(fragment_unnamed_40, fragment_unnamed_43, fragment_unnamed_44));
				precise float fragment_unnamed_52 = fragment_unnamed_40 * fragment_unnamed_50;
				precise float fragment_unnamed_53 = fragment_unnamed_43 * fragment_unnamed_50;
				precise float fragment_unnamed_54 = fragment_unnamed_50 + (-1.0f);
				precise float fragment_unnamed_56 = fragment_unnamed_52 * 1.0f;
				precise float fragment_unnamed_57 = fragment_unnamed_53 * 1.0f;
				precise float fragment_unnamed_58 = fragment_unnamed_54 * (-1.0f);
				precise float fragment_unnamed_59 = fragment_unnamed_52 * 12.9200000762939453125f;
				precise float fragment_unnamed_61 = fragment_unnamed_53 * 12.9200000762939453125f;
				precise float fragment_unnamed_62 = fragment_unnamed_54 * (-12.9200000762939453125f);
				precise float fragment_unnamed_79 = log2(max(abs(fragment_unnamed_56), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_81 = log2(max(abs(fragment_unnamed_57), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_82 = log2(max(abs(fragment_unnamed_58), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				fragment_output_0.x = (0.003130800090730190277099609375f >= fragment_unnamed_56) ? fragment_unnamed_59 : mad(exp2(fragment_unnamed_79), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.y = (0.003130800090730190277099609375f >= fragment_unnamed_57) ? fragment_unnamed_61 : mad(exp2(fragment_unnamed_81), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.z = (0.003130800090730190277099609375f >= fragment_unnamed_58) ? fragment_unnamed_62 : mad(exp2(fragment_unnamed_82), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // !defined(SOURCE_GBUFFER)


			#if defined(SOURCE_GBUFFER)

			float _RenderViewportScaleFactor;

			static float4 vertex_uniform_buffer_0[27];
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
				precise float vertex_unnamed_42 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_43 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_54 = mad(vertex_unnamed_42, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_55 = mad(vertex_unnamed_43, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_54;
				vertex_output_1.y = vertex_unnamed_55;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4x4 unity_WorldToCamera;

			static float4 fragment_uniform_buffer_0[16];
			Texture2D<float4> _CameraGBufferTexture2;
			SamplerState sampler_CameraGBufferTexture2;

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
				float4 fragment_unnamed_39 = _CameraGBufferTexture2.Sample(sampler_CameraGBufferTexture2, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_45 = mad(fragment_unnamed_39.x, 2.0f, -1.0f);
				float fragment_unnamed_48 = mad(fragment_unnamed_39.y, 2.0f, -1.0f);
				float fragment_unnamed_49 = mad(fragment_unnamed_39.z, 2.0f, -1.0f);
				precise float fragment_unnamed_57 = fragment_unnamed_48 * fragment_uniform_buffer_0[13u].x;
				precise float fragment_unnamed_58 = fragment_unnamed_48 * fragment_uniform_buffer_0[13u].y;
				precise float fragment_unnamed_59 = fragment_unnamed_48 * fragment_uniform_buffer_0[13u].z;
				float fragment_unnamed_75 = mad(fragment_uniform_buffer_0[14u].x, fragment_unnamed_49, mad(fragment_uniform_buffer_0[12u].x, fragment_unnamed_45, fragment_unnamed_57));
				float fragment_unnamed_76 = mad(fragment_uniform_buffer_0[14u].y, fragment_unnamed_49, mad(fragment_uniform_buffer_0[12u].y, fragment_unnamed_45, fragment_unnamed_58));
				float fragment_unnamed_77 = mad(fragment_uniform_buffer_0[14u].z, fragment_unnamed_49, mad(fragment_uniform_buffer_0[12u].z, fragment_unnamed_45, fragment_unnamed_59));
				precise float fragment_unnamed_88 = log2(max(abs(fragment_unnamed_75), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_90 = log2(max(abs(fragment_unnamed_76), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_91 = log2(max(abs(fragment_unnamed_77), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_100 = fragment_unnamed_75 * 12.9200000762939453125f;
				precise float fragment_unnamed_102 = fragment_unnamed_76 * 12.9200000762939453125f;
				precise float fragment_unnamed_103 = fragment_unnamed_77 * 12.9200000762939453125f;
				fragment_output_0.x = (0.003130800090730190277099609375f >= fragment_unnamed_75) ? fragment_unnamed_100 : mad(exp2(fragment_unnamed_88), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.y = (0.003130800090730190277099609375f >= fragment_unnamed_76) ? fragment_unnamed_102 : mad(exp2(fragment_unnamed_90), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.z = (0.003130800090730190277099609375f >= fragment_unnamed_77) ? fragment_unnamed_103 : mad(exp2(fragment_unnamed_91), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[12] = float4(unity_WorldToCamera[0][0], unity_WorldToCamera[1][0], unity_WorldToCamera[2][0], unity_WorldToCamera[3][0]);
				fragment_uniform_buffer_0[13] = float4(unity_WorldToCamera[0][1], unity_WorldToCamera[1][1], unity_WorldToCamera[2][1], unity_WorldToCamera[3][1]);
				fragment_uniform_buffer_0[14] = float4(unity_WorldToCamera[0][2], unity_WorldToCamera[1][2], unity_WorldToCamera[2][2], unity_WorldToCamera[3][2]);
				fragment_uniform_buffer_0[15] = float4(unity_WorldToCamera[0][3], unity_WorldToCamera[1][3], unity_WorldToCamera[2][3], unity_WorldToCamera[3][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(SOURCE_GBUFFER)


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
			GpuProgramID 190968

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float _RenderViewportScaleFactor;

			static float4 vertex_uniform_buffer_0[27];
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
				precise float vertex_unnamed_42 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_43 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_54 = mad(vertex_unnamed_42, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_55 = mad(vertex_unnamed_43, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_54;
				vertex_output_1.y = vertex_unnamed_55;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _MainTex_TexelSize;
			float4 _Params;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _CameraMotionVectorsTexture;
			SamplerState sampler_MainTex;
			SamplerState sampler_CameraMotionVectorsTexture;

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
				precise float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _CameraMotionVectorsTexture.Sample(sampler_CameraMotionVectorsTexture, float2(fragment_unnamed_50, fragment_unnamed_51));
				float fragment_unnamed_56 = fragment_unnamed_54.x;
				float fragment_unnamed_57 = fragment_unnamed_54.y;
				float fragment_unnamed_58 = abs(fragment_unnamed_57);
				precise float fragment_unnamed_61 = 1.0f / max(fragment_unnamed_58, abs(fragment_unnamed_56));
				precise float fragment_unnamed_69 = fragment_unnamed_61 * min(fragment_unnamed_58, abs(fragment_unnamed_56));
				precise float fragment_unnamed_70 = fragment_unnamed_69 * fragment_unnamed_69;
				float fragment_unnamed_78 = mad(fragment_unnamed_70, mad(fragment_unnamed_70, mad(fragment_unnamed_70, mad(fragment_unnamed_70, 0.02083509974181652069091796875f, -0.08513300120830535888671875f), 0.1801410019397735595703125f), -0.33029949665069580078125f), 0.999866008758544921875f);
				precise float fragment_unnamed_80 = fragment_unnamed_69 * fragment_unnamed_78;
				precise float fragment_unnamed_88 = (-0.0f) - fragment_unnamed_57;
				precise float fragment_unnamed_95 = asfloat(((fragment_unnamed_88 < fragment_unnamed_57) ? 4294967295u : 0u) & 3226013659u) + mad(fragment_unnamed_69, fragment_unnamed_78, asfloat(((fragment_unnamed_58 < abs(fragment_unnamed_56)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_80, -2.0f, 1.57079637050628662109375f))));
				precise float fragment_unnamed_96 = (-0.0f) - fragment_unnamed_57;
				float fragment_unnamed_97 = min(fragment_unnamed_96, fragment_unnamed_56);
				precise float fragment_unnamed_98 = (-0.0f) - fragment_unnamed_97;
				precise float fragment_unnamed_101 = (-0.0f) - fragment_unnamed_57;
				float fragment_unnamed_102 = max(fragment_unnamed_101, fragment_unnamed_56);
				precise float fragment_unnamed_103 = fragment_unnamed_56 * 1.0f;
				precise float fragment_unnamed_104 = fragment_unnamed_57 * (-1.0f);
				precise float fragment_unnamed_111 = fragment_unnamed_103 * fragment_uniform_buffer_0[29u].x;
				precise float fragment_unnamed_112 = fragment_unnamed_104 * fragment_uniform_buffer_0[29u].x;
				precise float fragment_unnamed_113 = fragment_unnamed_103 * fragment_uniform_buffer_0[29u].y;
				precise float fragment_unnamed_114 = fragment_unnamed_104 * fragment_uniform_buffer_0[29u].y;
				precise float fragment_unnamed_115 = (-0.0f) - fragment_unnamed_102;
				precise float fragment_unnamed_120 = (-0.0f) - fragment_unnamed_95;
				float fragment_unnamed_122 = mad(((((fragment_unnamed_102 >= fragment_unnamed_115) ? 4294967295u : 0u) & ((fragment_unnamed_97 < fragment_unnamed_98) ? 4294967295u : 0u)) != 0u) ? fragment_unnamed_120 : fragment_unnamed_95, 0.3183098733425140380859375f, 1.0f);
				float4 fragment_unnamed_145 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_147 = fragment_unnamed_145.x;
				float fragment_unnamed_148 = fragment_unnamed_145.y;
				float fragment_unnamed_149 = fragment_unnamed_145.z;
				precise float fragment_unnamed_150 = (-0.0f) - fragment_unnamed_147;
				precise float fragment_unnamed_151 = (-0.0f) - fragment_unnamed_148;
				precise float fragment_unnamed_152 = (-0.0f) - fragment_unnamed_149;
				precise float fragment_unnamed_153 = clamp(mad(abs(mad(fragment_unnamed_122, 3.0f, -3.0f)), 1.0f, -1.0f), 0.0f, 1.0f) + fragment_unnamed_150;
				precise float fragment_unnamed_154 = clamp(mad(abs(mad(fragment_unnamed_122, 3.0f, -2.0f)), -1.0f, 2.0f), 0.0f, 1.0f) + fragment_unnamed_151;
				precise float fragment_unnamed_155 = clamp(mad(abs(mad(fragment_unnamed_122, 3.0f, -4.0f)), -1.0f, 2.0f), 0.0f, 1.0f) + fragment_unnamed_152;
				precise float fragment_unnamed_159 = fragment_unnamed_113 * 0.25f;
				precise float fragment_unnamed_161 = fragment_unnamed_114 * 0.25f;
				float fragment_unnamed_166 = min(sqrt(dot(float2(fragment_unnamed_159, fragment_unnamed_161), float2(fragment_unnamed_159, fragment_unnamed_161))), 1.0f);
				float fragment_unnamed_168 = clamp(sqrt(dot(float2(fragment_unnamed_111, fragment_unnamed_112), float2(fragment_unnamed_111, fragment_unnamed_112))), 0.0f, 1.0f);
				precise float fragment_unnamed_179 = fragment_uniform_buffer_0[28u].w * fragment_uniform_buffer_0[29u].y;
				precise float fragment_unnamed_183 = fragment_unnamed_179 / fragment_uniform_buffer_0[28u].z;
				precise float fragment_unnamed_195 = fragment_uniform_buffer_0[28u].z / asfloat(asuint(fragment_uniform_buffer_0[29u]).y);
				precise float fragment_unnamed_196 = fragment_uniform_buffer_0[28u].w / floor(fragment_unnamed_183);
				precise float fragment_unnamed_201 = gl_FragCoord.x / fragment_unnamed_195;
				precise float fragment_unnamed_202 = gl_FragCoord.y / fragment_unnamed_196;
				precise float fragment_unnamed_205 = floor(fragment_unnamed_201) + 0.5f;
				precise float fragment_unnamed_207 = floor(fragment_unnamed_202) + 0.5f;
				precise float fragment_unnamed_208 = fragment_unnamed_195 * fragment_unnamed_205;
				precise float fragment_unnamed_209 = fragment_unnamed_196 * fragment_unnamed_207;
				precise float fragment_unnamed_210 = (-0.0f) - fragment_unnamed_205;
				precise float fragment_unnamed_211 = (-0.0f) - fragment_unnamed_207;
				float fragment_unnamed_216 = mad(fragment_unnamed_210, fragment_unnamed_195, gl_FragCoord.x);
				float fragment_unnamed_217 = mad(fragment_unnamed_211, fragment_unnamed_196, gl_FragCoord.y);
				precise float fragment_unnamed_219 = min(fragment_unnamed_196, fragment_unnamed_195) * 0.707106769084930419921875f;
				precise float fragment_unnamed_225 = fragment_unnamed_208 / fragment_uniform_buffer_0[28u].z;
				precise float fragment_unnamed_226 = fragment_unnamed_209 / fragment_uniform_buffer_0[28u].w;
				precise float fragment_unnamed_232 = clamp(fragment_unnamed_225, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_233 = clamp(fragment_unnamed_226, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_234 = _CameraMotionVectorsTexture.Sample(sampler_CameraMotionVectorsTexture, float2(fragment_unnamed_232, fragment_unnamed_233));
				precise float fragment_unnamed_238 = fragment_unnamed_234.x * 1.0f;
				precise float fragment_unnamed_239 = fragment_unnamed_234.y * (-1.0f);
				float fragment_unnamed_240 = dot(float2(fragment_unnamed_238, fragment_unnamed_239), float2(fragment_unnamed_238, fragment_unnamed_239));
				float fragment_unnamed_243 = rsqrt(fragment_unnamed_240);
				precise float fragment_unnamed_246 = fragment_unnamed_238 * fragment_unnamed_243;
				precise float fragment_unnamed_247 = fragment_unnamed_239 * fragment_unnamed_243;
				precise float fragment_unnamed_248 = (-0.0f) - fragment_unnamed_247;
				float fragment_unnamed_249 = dot(float2(fragment_unnamed_246, fragment_unnamed_248), float2(fragment_unnamed_216, fragment_unnamed_217));
				float fragment_unnamed_252 = dot(float2(fragment_unnamed_247, fragment_unnamed_246), float2(fragment_unnamed_216, fragment_unnamed_217));
				precise float fragment_unnamed_255 = fragment_unnamed_166 * fragment_unnamed_219;
				float fragment_unnamed_256 = mad(fragment_unnamed_219, fragment_unnamed_166, -2.0f);
				precise float fragment_unnamed_257 = (-0.0f) - fragment_unnamed_255;
				precise float fragment_unnamed_262 = fragment_unnamed_255 * 0.5f;
				precise float fragment_unnamed_263 = fragment_unnamed_255 * 0.25f;
				precise float fragment_unnamed_264 = fragment_unnamed_255 * (-0.125f);
				float fragment_unnamed_266 = asfloat(0u);
				precise float fragment_unnamed_267 = (-0.0f) - fragment_unnamed_255;
				precise float fragment_unnamed_271 = (-0.0f) - mad(fragment_unnamed_267, 0.25f, fragment_unnamed_262);
				precise float fragment_unnamed_272 = (-0.0f) - mad(fragment_unnamed_267, 0.125f, fragment_unnamed_266);
				precise float fragment_unnamed_273 = fragment_unnamed_271 + fragment_unnamed_262;
				precise float fragment_unnamed_274 = fragment_unnamed_272 + fragment_unnamed_266;
				float fragment_unnamed_278 = sqrt(dot(float2(fragment_unnamed_273, fragment_unnamed_274), float2(fragment_unnamed_273, fragment_unnamed_274)));
				precise float fragment_unnamed_279 = fragment_unnamed_273 / fragment_unnamed_278;
				precise float fragment_unnamed_280 = fragment_unnamed_274 / fragment_unnamed_278;
				precise float fragment_unnamed_281 = (-0.0f) - fragment_unnamed_279;
				precise float fragment_unnamed_285 = (-0.0f) - fragment_unnamed_255;
				precise float fragment_unnamed_289 = fragment_unnamed_249 + 1.0f;
				precise float fragment_unnamed_290 = fragment_unnamed_252 + (-0.0f);
				precise float fragment_unnamed_293 = (-0.0f) - fragment_unnamed_263;
				precise float fragment_unnamed_294 = (-0.0f) - fragment_unnamed_264;
				precise float fragment_unnamed_295 = (-0.0f) - fragment_unnamed_263;
				precise float fragment_unnamed_296 = (-0.0f) - fragment_unnamed_264;
				float fragment_unnamed_300 = sqrt(dot(float2(fragment_unnamed_293, fragment_unnamed_294), float2(fragment_unnamed_295, fragment_unnamed_296)));
				precise float fragment_unnamed_301 = (-0.0f) - fragment_unnamed_263;
				precise float fragment_unnamed_302 = (-0.0f) - fragment_unnamed_264;
				precise float fragment_unnamed_303 = fragment_unnamed_301 / fragment_unnamed_300;
				precise float fragment_unnamed_304 = fragment_unnamed_302 / fragment_unnamed_300;
				precise float fragment_unnamed_305 = (-0.0f) - fragment_unnamed_303;
				precise float fragment_unnamed_310 = (-0.0f) - mad(fragment_unnamed_255, -0.25f, fragment_unnamed_249);
				precise float fragment_unnamed_313 = fragment_unnamed_256 / abs(fragment_unnamed_256);
				precise float fragment_unnamed_314 = fragment_unnamed_313 * fragment_unnamed_289;
				precise float fragment_unnamed_315 = (-0.0f) - fragment_unnamed_313;
				precise float fragment_unnamed_316 = fragment_unnamed_315 * fragment_unnamed_290;
				precise float fragment_unnamed_318 = (-0.0f) - abs(fragment_unnamed_256);
				precise float fragment_unnamed_325 = (-0.0f) - clamp(min(max(mad(fragment_unnamed_318, 0.5f, abs(fragment_unnamed_314)), abs(fragment_unnamed_316)), max(fragment_unnamed_310, max(dot(float2(mad(fragment_unnamed_257, 0.375f, fragment_unnamed_249), mad(fragment_unnamed_257, -0.0625f, fragment_unnamed_252)), float2(fragment_unnamed_280, fragment_unnamed_281)), dot(float2(mad(fragment_unnamed_285, 0.375f, fragment_unnamed_249), mad(fragment_unnamed_285, 0.0625f, fragment_unnamed_252)), float2(fragment_unnamed_304, fragment_unnamed_305))))), 0.0f, 1.0f);
				precise float fragment_unnamed_326 = fragment_unnamed_325 + 1.0f;
				float fragment_unnamed_329 = asfloat(asuint(fragment_unnamed_326) & ((fragment_unnamed_240 != 0.0f) ? 4294967295u : 0u));
				precise float fragment_unnamed_330 = fragment_unnamed_329 + mad(fragment_unnamed_168, fragment_unnamed_153, fragment_unnamed_147);
				precise float fragment_unnamed_331 = fragment_unnamed_329 + mad(fragment_unnamed_168, fragment_unnamed_154, fragment_unnamed_148);
				precise float fragment_unnamed_332 = fragment_unnamed_329 + mad(fragment_unnamed_168, fragment_unnamed_155, fragment_unnamed_149);
				fragment_output_0.x = fragment_unnamed_330;
				fragment_output_0.y = fragment_unnamed_331;
				fragment_output_0.z = fragment_unnamed_332;
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[29] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

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
			GpuProgramID 217722

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float _RenderViewportScaleFactor;

			static float4 vertex_uniform_buffer_0[27];
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
				precise float vertex_unnamed_42 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_43 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_54 = mad(vertex_unnamed_42, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_55 = mad(vertex_unnamed_43, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_54;
				vertex_output_1.y = vertex_unnamed_55;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

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
				float4 fragment_unnamed_34 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_36 = fragment_unnamed_34.x;
				float fragment_unnamed_37 = fragment_unnamed_34.y;
				float fragment_unnamed_38 = fragment_unnamed_34.z;
				float fragment_unnamed_39 = fragment_unnamed_34.w;
				precise float fragment_unnamed_90 = clamp(fragment_unnamed_36, 0.0f, 1.0f) * 0.25f;
				precise float fragment_unnamed_92 = clamp(fragment_unnamed_37, 0.0f, 1.0f) * 0.25f;
				precise float fragment_unnamed_93 = clamp(fragment_unnamed_38, 0.0f, 1.0f) * 0.25f;
				bool fragment_unnamed_94 = (((((((fragment_unnamed_39 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_39) ? 4294967295u : 0u)) | ((fragment_unnamed_39 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u) | (((((((fragment_unnamed_38 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_38) ? 4294967295u : 0u)) | ((fragment_unnamed_38 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u) | (((((((fragment_unnamed_37 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_37) ? 4294967295u : 0u)) | ((fragment_unnamed_37 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u) | ((((((fragment_unnamed_36 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_36) ? 4294967295u : 0u)) | ((fragment_unnamed_36 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u)))) != 0u;
				fragment_output_0.x = fragment_unnamed_94 ? 1.0f : fragment_unnamed_90;
				fragment_output_0.y = fragment_unnamed_94 ? 0.0f : fragment_unnamed_92;
				fragment_output_0.z = fragment_unnamed_94 ? 1.0f : fragment_unnamed_93;
				fragment_output_0.w = fragment_unnamed_94 ? 1.0f : fragment_unnamed_39;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
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
			GpuProgramID 269731

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float _RenderViewportScaleFactor;

			static float4 vertex_uniform_buffer_0[27];
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
				precise float vertex_unnamed_42 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_43 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_54 = mad(vertex_unnamed_42, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_55 = mad(vertex_unnamed_43, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_54;
				vertex_output_1.y = vertex_unnamed_55;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4 _Params;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

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
				float4 fragment_unnamed_39 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_46 = clamp(fragment_unnamed_39.x, 0.0f, 1.0f);
				float fragment_unnamed_47 = clamp(fragment_unnamed_39.y, 0.0f, 1.0f);
				float fragment_unnamed_48 = clamp(fragment_unnamed_39.z, 0.0f, 1.0f);
				precise float fragment_unnamed_49 = fragment_unnamed_46 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_51 = fragment_unnamed_47 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_52 = fragment_unnamed_48 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_53 = fragment_unnamed_49 * 0.947867333889007568359375f;
				precise float fragment_unnamed_55 = fragment_unnamed_51 * 0.947867333889007568359375f;
				precise float fragment_unnamed_56 = fragment_unnamed_52 * 0.947867333889007568359375f;
				precise float fragment_unnamed_60 = log2(fragment_unnamed_53) * 2.400000095367431640625f;
				precise float fragment_unnamed_62 = log2(fragment_unnamed_55) * 2.400000095367431640625f;
				precise float fragment_unnamed_63 = log2(fragment_unnamed_56) * 2.400000095367431640625f;
				precise float fragment_unnamed_67 = fragment_unnamed_46 * 0.077399380505084991455078125f;
				precise float fragment_unnamed_69 = fragment_unnamed_47 * 0.077399380505084991455078125f;
				precise float fragment_unnamed_70 = fragment_unnamed_48 * 0.077399380505084991455078125f;
				float fragment_unnamed_83 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_46) ? asuint(fragment_unnamed_67) : asuint(exp2(fragment_unnamed_60)));
				float fragment_unnamed_85 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_47) ? asuint(fragment_unnamed_69) : asuint(exp2(fragment_unnamed_62)));
				float fragment_unnamed_87 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_48) ? asuint(fragment_unnamed_70) : asuint(exp2(fragment_unnamed_63)));
				precise float fragment_unnamed_88 = fragment_unnamed_85 * (-367.85711669921875f);
				precise float fragment_unnamed_90 = (-0.0f) - fragment_unnamed_88;
				precise float fragment_unnamed_95 = mad(fragment_unnamed_87, 16511.744140625f, mad(fragment_unnamed_83, -367.85711669921875f, fragment_unnamed_90)) * 6.0796734032919630408287048339844e-05f;
				precise float fragment_unnamed_103 = dot(float2(fragment_unnamed_83, fragment_unnamed_85), float2(4833.0380859375f, 11677.1962890625f)) * 6.0796734032919630408287048339844e-05f;
				precise float fragment_unnamed_106 = (-0.0f) - fragment_unnamed_83;
				precise float fragment_unnamed_107 = (-0.0f) - fragment_unnamed_85;
				precise float fragment_unnamed_108 = (-0.0f) - fragment_unnamed_87;
				precise float fragment_unnamed_109 = fragment_unnamed_106 + min(fragment_unnamed_103, 1.0f);
				precise float fragment_unnamed_110 = fragment_unnamed_107 + min(fragment_unnamed_103, 1.0f);
				precise float fragment_unnamed_111 = fragment_unnamed_108 + clamp(fragment_unnamed_95, 0.0f, 1.0f);
				float fragment_unnamed_117 = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_109, fragment_unnamed_83);
				float fragment_unnamed_118 = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_110, fragment_unnamed_85);
				float fragment_unnamed_119 = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_111, fragment_unnamed_87);
				precise float fragment_unnamed_130 = log2(max(abs(fragment_unnamed_117), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_132 = log2(max(abs(fragment_unnamed_118), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_133 = log2(max(abs(fragment_unnamed_119), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_142 = fragment_unnamed_117 * 12.9200000762939453125f;
				precise float fragment_unnamed_144 = fragment_unnamed_118 * 12.9200000762939453125f;
				precise float fragment_unnamed_145 = fragment_unnamed_119 * 12.9200000762939453125f;
				fragment_output_0.x = (0.003130800090730190277099609375f >= fragment_unnamed_117) ? fragment_unnamed_142 : mad(exp2(fragment_unnamed_130), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.y = (0.003130800090730190277099609375f >= fragment_unnamed_118) ? fragment_unnamed_144 : mad(exp2(fragment_unnamed_132), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.z = (0.003130800090730190277099609375f >= fragment_unnamed_119) ? fragment_unnamed_145 : mad(exp2(fragment_unnamed_133), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[29] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

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
			GpuProgramID 340467

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float _RenderViewportScaleFactor;

			static float4 vertex_uniform_buffer_0[27];
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
				precise float vertex_unnamed_42 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_43 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_54 = mad(vertex_unnamed_42, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_55 = mad(vertex_unnamed_43, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_54;
				vertex_output_1.y = vertex_unnamed_55;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4 _Params;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

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
				float4 fragment_unnamed_39 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_46 = clamp(fragment_unnamed_39.x, 0.0f, 1.0f);
				float fragment_unnamed_47 = clamp(fragment_unnamed_39.y, 0.0f, 1.0f);
				float fragment_unnamed_48 = clamp(fragment_unnamed_39.z, 0.0f, 1.0f);
				precise float fragment_unnamed_49 = fragment_unnamed_46 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_51 = fragment_unnamed_47 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_52 = fragment_unnamed_48 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_53 = fragment_unnamed_49 * 0.947867333889007568359375f;
				precise float fragment_unnamed_55 = fragment_unnamed_51 * 0.947867333889007568359375f;
				precise float fragment_unnamed_56 = fragment_unnamed_52 * 0.947867333889007568359375f;
				precise float fragment_unnamed_60 = log2(fragment_unnamed_53) * 2.400000095367431640625f;
				precise float fragment_unnamed_62 = log2(fragment_unnamed_55) * 2.400000095367431640625f;
				precise float fragment_unnamed_63 = log2(fragment_unnamed_56) * 2.400000095367431640625f;
				precise float fragment_unnamed_67 = fragment_unnamed_46 * 0.077399380505084991455078125f;
				precise float fragment_unnamed_69 = fragment_unnamed_47 * 0.077399380505084991455078125f;
				precise float fragment_unnamed_70 = fragment_unnamed_48 * 0.077399380505084991455078125f;
				float fragment_unnamed_83 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_46) ? asuint(fragment_unnamed_67) : asuint(exp2(fragment_unnamed_60)));
				float fragment_unnamed_85 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_47) ? asuint(fragment_unnamed_69) : asuint(exp2(fragment_unnamed_62)));
				float fragment_unnamed_87 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_48) ? asuint(fragment_unnamed_70) : asuint(exp2(fragment_unnamed_63)));
				precise float fragment_unnamed_88 = fragment_unnamed_85 * 66.0126495361328125f;
				precise float fragment_unnamed_90 = (-0.0f) - fragment_unnamed_88;
				precise float fragment_unnamed_95 = mad(fragment_unnamed_87, 16511.744140625f, mad(fragment_unnamed_83, 66.0126495361328125f, fragment_unnamed_90)) * 6.0796734032919630408287048339844e-05f;
				precise float fragment_unnamed_103 = dot(float2(fragment_unnamed_83, fragment_unnamed_85), float2(1855.9146728515625f, 14655.830078125f)) * 6.0796734032919630408287048339844e-05f;
				precise float fragment_unnamed_106 = (-0.0f) - fragment_unnamed_83;
				precise float fragment_unnamed_107 = (-0.0f) - fragment_unnamed_85;
				precise float fragment_unnamed_108 = (-0.0f) - fragment_unnamed_87;
				precise float fragment_unnamed_109 = fragment_unnamed_106 + min(fragment_unnamed_103, 1.0f);
				precise float fragment_unnamed_110 = fragment_unnamed_107 + min(fragment_unnamed_103, 1.0f);
				precise float fragment_unnamed_111 = fragment_unnamed_108 + clamp(fragment_unnamed_95, 0.0f, 1.0f);
				float fragment_unnamed_117 = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_109, fragment_unnamed_83);
				float fragment_unnamed_118 = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_110, fragment_unnamed_85);
				float fragment_unnamed_119 = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_111, fragment_unnamed_87);
				precise float fragment_unnamed_130 = log2(max(abs(fragment_unnamed_117), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_132 = log2(max(abs(fragment_unnamed_118), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_133 = log2(max(abs(fragment_unnamed_119), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_142 = fragment_unnamed_117 * 12.9200000762939453125f;
				precise float fragment_unnamed_144 = fragment_unnamed_118 * 12.9200000762939453125f;
				precise float fragment_unnamed_145 = fragment_unnamed_119 * 12.9200000762939453125f;
				fragment_output_0.x = (0.003130800090730190277099609375f >= fragment_unnamed_117) ? fragment_unnamed_142 : mad(exp2(fragment_unnamed_130), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.y = (0.003130800090730190277099609375f >= fragment_unnamed_118) ? fragment_unnamed_144 : mad(exp2(fragment_unnamed_132), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.z = (0.003130800090730190277099609375f >= fragment_unnamed_119) ? fragment_unnamed_145 : mad(exp2(fragment_unnamed_133), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[29] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

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
			GpuProgramID 400182

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float _RenderViewportScaleFactor;

			static float4 vertex_uniform_buffer_0[27];
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
				precise float vertex_unnamed_42 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_43 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_54 = mad(vertex_unnamed_42, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_55 = mad(vertex_unnamed_43, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_54;
				vertex_output_1.y = vertex_unnamed_55;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4 _Params;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

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
				float4 fragment_unnamed_39 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_46 = clamp(fragment_unnamed_39.x, 0.0f, 1.0f);
				float fragment_unnamed_47 = clamp(fragment_unnamed_39.y, 0.0f, 1.0f);
				float fragment_unnamed_48 = clamp(fragment_unnamed_39.z, 0.0f, 1.0f);
				precise float fragment_unnamed_49 = fragment_unnamed_46 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_51 = fragment_unnamed_47 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_52 = fragment_unnamed_48 + 0.054999999701976776123046875f;
				precise float fragment_unnamed_53 = fragment_unnamed_49 * 0.947867333889007568359375f;
				precise float fragment_unnamed_55 = fragment_unnamed_51 * 0.947867333889007568359375f;
				precise float fragment_unnamed_56 = fragment_unnamed_52 * 0.947867333889007568359375f;
				precise float fragment_unnamed_60 = log2(fragment_unnamed_53) * 2.400000095367431640625f;
				precise float fragment_unnamed_62 = log2(fragment_unnamed_55) * 2.400000095367431640625f;
				precise float fragment_unnamed_63 = log2(fragment_unnamed_56) * 2.400000095367431640625f;
				precise float fragment_unnamed_67 = fragment_unnamed_46 * 0.077399380505084991455078125f;
				precise float fragment_unnamed_69 = fragment_unnamed_47 * 0.077399380505084991455078125f;
				precise float fragment_unnamed_70 = fragment_unnamed_48 * 0.077399380505084991455078125f;
				float fragment_unnamed_83 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_46) ? asuint(fragment_unnamed_67) : asuint(exp2(fragment_unnamed_60)));
				float fragment_unnamed_85 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_47) ? asuint(fragment_unnamed_69) : asuint(exp2(fragment_unnamed_62)));
				float fragment_unnamed_87 = asfloat((0.040449999272823333740234375f >= fragment_unnamed_48) ? asuint(fragment_unnamed_70) : asuint(exp2(fragment_unnamed_63)));
				float fragment_unnamed_88 = dot(float3(fragment_unnamed_83, fragment_unnamed_85, fragment_unnamed_87), float3(2.4325101375579833984375f, 11.468845367431640625f, 1.76049244403839111328125f));
				precise float fragment_unnamed_95 = fragment_unnamed_88 * 0.0077822203747928142547607421875f;
				precise float fragment_unnamed_97 = fragment_unnamed_88 * 5.9847738157259300351142883300781e-05f;
				precise float fragment_unnamed_99 = fragment_unnamed_88 * (-0.00032898582867346704006195068359375f);
				precise float fragment_unnamed_101 = fragment_unnamed_88 * 0.232164323329925537109375f;
				precise float fragment_unnamed_103 = fragment_unnamed_88 * 0.1378665268421173095703125f;
				precise float fragment_unnamed_105 = fragment_unnamed_88 * 0.0093313641846179962158203125f;
				float fragment_unnamed_107 = dot(float3(fragment_unnamed_83, fragment_unnamed_85, fragment_unnamed_87), float3(6.501978397369384765625f, 11.0320301055908203125f, 1.2238409519195556640625f));
				precise float fragment_unnamed_113 = fragment_unnamed_107 * 0.0077822203747928142547607421875f;
				precise float fragment_unnamed_114 = fragment_unnamed_95 / fragment_unnamed_113;
				precise float fragment_unnamed_121 = (-0.0f) - fragment_unnamed_101;
				precise float fragment_unnamed_125 = mad(fragment_unnamed_107, -4.5894175855210050940513610839844e-06f, fragment_unnamed_97) * 98.8431854248046875f;
				precise float fragment_unnamed_127 = mad(fragment_unnamed_107, 0.00019840833556372672319412231445312f, fragment_unnamed_99) * (-58.80513763427734375f);
				float fragment_unnamed_132 = asfloat((fragment_unnamed_114 < 0.834949016571044921875f) ? asuint(fragment_unnamed_125) : asuint(fragment_unnamed_127));
				precise float fragment_unnamed_138 = (-0.0f) - fragment_unnamed_105;
				precise float fragment_unnamed_144 = (-0.0f) - fragment_unnamed_132;
				precise float fragment_unnamed_148 = (-0.0f) - fragment_unnamed_83;
				precise float fragment_unnamed_149 = (-0.0f) - fragment_unnamed_85;
				precise float fragment_unnamed_150 = (-0.0f) - fragment_unnamed_87;
				precise float fragment_unnamed_151 = fragment_unnamed_148 + clamp(mad(fragment_unnamed_132, 1.61047399044036865234375f, mad(fragment_unnamed_107, 0.2399325072765350341796875f, fragment_unnamed_121)), 0.0f, 1.0f);
				precise float fragment_unnamed_152 = fragment_unnamed_149 + clamp(mad(fragment_unnamed_144, 2.532641887664794921875f, mad(fragment_unnamed_107, -0.050440214574337005615234375f, fragment_unnamed_103)), 0.0f, 1.0f);
				precise float fragment_unnamed_153 = fragment_unnamed_150 + clamp(mad(fragment_unnamed_132, 14.273845672607421875f, mad(fragment_unnamed_107, -0.00292370258830487728118896484375f, fragment_unnamed_138)), 0.0f, 1.0f);
				float fragment_unnamed_159 = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_151, fragment_unnamed_83);
				float fragment_unnamed_160 = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_152, fragment_unnamed_85);
				float fragment_unnamed_161 = mad(fragment_uniform_buffer_0[29u].x, fragment_unnamed_153, fragment_unnamed_87);
				precise float fragment_unnamed_172 = log2(max(abs(fragment_unnamed_159), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_174 = log2(max(abs(fragment_unnamed_160), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_175 = log2(max(abs(fragment_unnamed_161), 1.1920928955078125e-07f)) * 0.4166666567325592041015625f;
				precise float fragment_unnamed_184 = fragment_unnamed_159 * 12.9200000762939453125f;
				precise float fragment_unnamed_186 = fragment_unnamed_160 * 12.9200000762939453125f;
				precise float fragment_unnamed_187 = fragment_unnamed_161 * 12.9200000762939453125f;
				fragment_output_0.x = (0.003130800090730190277099609375f >= fragment_unnamed_159) ? fragment_unnamed_184 : mad(exp2(fragment_unnamed_172), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.y = (0.003130800090730190277099609375f >= fragment_unnamed_160) ? fragment_unnamed_186 : mad(exp2(fragment_unnamed_174), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.z = (0.003130800090730190277099609375f >= fragment_unnamed_161) ? fragment_unnamed_187 : mad(exp2(fragment_unnamed_175), 1.05499994754791259765625f, -0.054999999701976776123046875f);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[29] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

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
