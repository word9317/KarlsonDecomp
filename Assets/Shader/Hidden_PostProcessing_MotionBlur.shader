Shader "Hidden/PostProcessing/MotionBlur"
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
			GpuProgramID 2508

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
			float4 _CameraMotionVectorsTexture_TexelSize;
			float _VelocityScale;
			float _RcpMaxBlurRadius;

			static float4 fragment_uniform_buffer_0[33];
			Texture2D<float4> _CameraDepthTexture;
			Texture2D<float4> _CameraMotionVectorsTexture;
			SamplerState sampler_CameraDepthTexture;
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
				precise float fragment_unnamed_39 = fragment_uniform_buffer_0[31u].x * 0.5f;
				precise float fragment_unnamed_46 = fragment_unnamed_39 * fragment_uniform_buffer_0[29u].z;
				precise float fragment_unnamed_47 = fragment_unnamed_39 * fragment_uniform_buffer_0[29u].w;
				float4 fragment_unnamed_57 = _CameraMotionVectorsTexture.Sample(sampler_CameraMotionVectorsTexture, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_61 = fragment_unnamed_46 * fragment_unnamed_57.x;
				precise float fragment_unnamed_62 = fragment_unnamed_47 * fragment_unnamed_57.y;
				precise float fragment_unnamed_72 = sqrt(dot(float2(fragment_unnamed_61, fragment_unnamed_62), float2(fragment_unnamed_61, fragment_unnamed_62))) * fragment_uniform_buffer_0[32u].y;
				float fragment_unnamed_73 = max(fragment_unnamed_72, 1.0f);
				precise float fragment_unnamed_75 = fragment_unnamed_61 / fragment_unnamed_73;
				precise float fragment_unnamed_76 = fragment_unnamed_62 / fragment_unnamed_73;
				precise float fragment_unnamed_82 = mad(fragment_unnamed_75, fragment_uniform_buffer_0[32u].y, 1.0f) * 0.5f;
				precise float fragment_unnamed_83 = mad(fragment_unnamed_76, fragment_uniform_buffer_0[32u].y, 1.0f) * 0.5f;
				fragment_output_0.x = fragment_unnamed_82;
				fragment_output_0.y = fragment_unnamed_83;
				precise float fragment_unnamed_91 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_93 = fragment_unnamed_91 + 1.0f;
				precise float fragment_unnamed_106 = _CameraDepthTexture.Sample(sampler_CameraDepthTexture, float2(fragment_input_1.x, fragment_input_1.y)).x * fragment_uniform_buffer_0[21u].x;
				precise float fragment_unnamed_114 = (-0.0f) - fragment_uniform_buffer_0[20u].w;
				precise float fragment_unnamed_116 = mad(fragment_unnamed_114, fragment_unnamed_106, 1.0f) / mad(fragment_unnamed_93, fragment_unnamed_106, fragment_uniform_buffer_0[21u].y);
				fragment_output_0.z = fragment_unnamed_116;
				fragment_output_0.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[20] = float4(unity_OrthoParams[0], unity_OrthoParams[1], unity_OrthoParams[2], unity_OrthoParams[3]);

				fragment_uniform_buffer_0[21] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_uniform_buffer_0[29] = float4(_CameraMotionVectorsTexture_TexelSize[0], _CameraMotionVectorsTexture_TexelSize[1], _CameraMotionVectorsTexture_TexelSize[2], _CameraMotionVectorsTexture_TexelSize[3]);

				fragment_uniform_buffer_0[31] = float4(_VelocityScale, fragment_uniform_buffer_0[31][1], fragment_uniform_buffer_0[31][2], fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_0[32] = float4(fragment_uniform_buffer_0[32][0], _RcpMaxBlurRadius, fragment_uniform_buffer_0[32][2], fragment_uniform_buffer_0[32][3]);

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
			GpuProgramID 70181

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


			float4 _MainTex_TexelSize;
			float _MaxBlurRadius;

			static float4 fragment_uniform_buffer_0[33];
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
				float4 fragment_unnamed_52 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, -0.5f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, -0.5f, fragment_input_1.y)));
				float4 fragment_unnamed_56 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, 0.5f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, -0.5f, fragment_input_1.y)));
				precise float fragment_unnamed_70 = mad(fragment_unnamed_56.x, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_71 = mad(fragment_unnamed_56.y, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_72 = mad(fragment_unnamed_52.x, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_73 = mad(fragment_unnamed_52.y, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
				bool fragment_unnamed_81 = dot(float2(fragment_unnamed_72, fragment_unnamed_73), float2(fragment_unnamed_72, fragment_unnamed_73)) < dot(float2(fragment_unnamed_70, fragment_unnamed_71), float2(fragment_unnamed_70, fragment_unnamed_71));
				uint fragment_unnamed_86 = fragment_unnamed_81 ? asuint(fragment_unnamed_70) : asuint(fragment_unnamed_72);
				float fragment_unnamed_87 = asfloat(fragment_unnamed_86);
				uint fragment_unnamed_88 = fragment_unnamed_81 ? asuint(fragment_unnamed_71) : asuint(fragment_unnamed_73);
				float fragment_unnamed_89 = asfloat(fragment_unnamed_88);
				float4 fragment_unnamed_105 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, -0.5f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y)));
				float4 fragment_unnamed_109 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, 0.5f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y)));
				precise float fragment_unnamed_120 = mad(fragment_unnamed_109.x, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_121 = mad(fragment_unnamed_109.y, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_122 = mad(fragment_unnamed_105.x, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
				precise float fragment_unnamed_123 = mad(fragment_unnamed_105.y, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
				bool fragment_unnamed_127 = dot(float2(fragment_unnamed_87, fragment_unnamed_89), float2(fragment_unnamed_87, fragment_unnamed_89)) < dot(float2(fragment_unnamed_122, fragment_unnamed_123), float2(fragment_unnamed_122, fragment_unnamed_123));
				float fragment_unnamed_131 = asfloat(fragment_unnamed_127 ? asuint(fragment_unnamed_122) : fragment_unnamed_86);
				float fragment_unnamed_133 = asfloat(fragment_unnamed_127 ? asuint(fragment_unnamed_123) : fragment_unnamed_88);
				bool fragment_unnamed_140 = dot(float2(fragment_unnamed_131, fragment_unnamed_133), float2(fragment_unnamed_131, fragment_unnamed_133)) < dot(float2(fragment_unnamed_120, fragment_unnamed_121), float2(fragment_unnamed_120, fragment_unnamed_121));
				fragment_output_0.x = fragment_unnamed_140 ? fragment_unnamed_120 : fragment_unnamed_131;
				fragment_output_0.y = fragment_unnamed_140 ? fragment_unnamed_121 : fragment_unnamed_133;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[32] = float4(_MaxBlurRadius, fragment_uniform_buffer_0[32][1], fragment_uniform_buffer_0[32][2], fragment_uniform_buffer_0[32][3]);

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
			GpuProgramID 160524

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


			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[29];
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
				float4 fragment_unnamed_52 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, -0.5f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, -0.5f, fragment_input_1.y)));
				float fragment_unnamed_54 = fragment_unnamed_52.x;
				float4 fragment_unnamed_56 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, 0.5f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, -0.5f, fragment_input_1.y)));
				float fragment_unnamed_58 = fragment_unnamed_56.x;
				bool fragment_unnamed_67 = dot(float2(fragment_unnamed_54, fragment_unnamed_52.y), float2(fragment_unnamed_54, fragment_unnamed_52.y)) < dot(float2(fragment_unnamed_58, fragment_unnamed_56.y), float2(fragment_unnamed_58, fragment_unnamed_56.y));
				uint fragment_unnamed_72 = fragment_unnamed_67 ? asuint(fragment_unnamed_58) : asuint(fragment_unnamed_54);
				float fragment_unnamed_73 = asfloat(fragment_unnamed_72);
				uint fragment_unnamed_74 = fragment_unnamed_67 ? asuint(fragment_unnamed_56.y) : asuint(fragment_unnamed_52.y);
				float fragment_unnamed_75 = asfloat(fragment_unnamed_74);
				float4 fragment_unnamed_91 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, -0.5f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y)));
				float fragment_unnamed_93 = fragment_unnamed_91.x;
				float4 fragment_unnamed_95 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, 0.5f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y)));
				float fragment_unnamed_97 = fragment_unnamed_95.x;
				bool fragment_unnamed_102 = dot(float2(fragment_unnamed_73, fragment_unnamed_75), float2(fragment_unnamed_73, fragment_unnamed_75)) < dot(float2(fragment_unnamed_93, fragment_unnamed_91.y), float2(fragment_unnamed_93, fragment_unnamed_91.y));
				float fragment_unnamed_106 = asfloat(fragment_unnamed_102 ? asuint(fragment_unnamed_93) : fragment_unnamed_72);
				float fragment_unnamed_108 = asfloat(fragment_unnamed_102 ? asuint(fragment_unnamed_91.y) : fragment_unnamed_74);
				bool fragment_unnamed_115 = dot(float2(fragment_unnamed_106, fragment_unnamed_108), float2(fragment_unnamed_106, fragment_unnamed_108)) < dot(float2(fragment_unnamed_97, fragment_unnamed_95.y), float2(fragment_unnamed_97, fragment_unnamed_95.y));
				fragment_output_0.x = fragment_unnamed_115 ? fragment_unnamed_97 : fragment_unnamed_106;
				fragment_output_0.y = fragment_unnamed_115 ? fragment_unnamed_95.y : fragment_unnamed_108;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

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
			GpuProgramID 229487

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


			float4 _MainTex_TexelSize;
			int _TileMaxLoop;
			float2 _TileMaxOffs;

			static float4 fragment_uniform_buffer_0[32];
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
				float fragment_unnamed_48 = mad(fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[31u].z, fragment_input_1.x);
				float fragment_unnamed_49 = mad(fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[31u].w, fragment_input_1.y);
				float fragment_unnamed_50 = asfloat(0u);
				float fragment_unnamed_51 = asfloat(0u);
				uint4 fragment_unnamed_55 = asuint(fragment_uniform_buffer_0[28u]);
				float fragment_unnamed_57 = asfloat(fragment_unnamed_55.x);
				float fragment_unnamed_59 = asfloat(fragment_unnamed_55.y);
				uint fragment_unnamed_62;
				uint fragment_unnamed_64;
				fragment_unnamed_62 = 0u;
				fragment_unnamed_64 = 0u;
				uint fragment_unnamed_63;
				uint fragment_unnamed_65;
				for (uint fragment_unnamed_60 = 0u; !(int(fragment_unnamed_60) >= int(asuint(fragment_uniform_buffer_0[31u]).y)); fragment_unnamed_60++, fragment_unnamed_62 = fragment_unnamed_63, fragment_unnamed_64 = fragment_unnamed_65)
				{
					float fragment_unnamed_82 = float(int(fragment_unnamed_60));
					float fragment_unnamed_83 = mad(fragment_unnamed_57, fragment_unnamed_82, fragment_unnamed_48);
					float fragment_unnamed_84 = mad(fragment_unnamed_50, fragment_unnamed_82, fragment_unnamed_49);
					fragment_unnamed_63 = fragment_unnamed_62;
					fragment_unnamed_65 = fragment_unnamed_64;
					float fragment_unnamed_94;
					float4 fragment_unnamed_99;
					float fragment_unnamed_101;
					float fragment_unnamed_104;
					float fragment_unnamed_106;
					bool fragment_unnamed_113;
					for (uint fragment_unnamed_86 = 0u; !(int(fragment_unnamed_86) >= int(asuint(fragment_uniform_buffer_0[31u]).y)); fragment_unnamed_94 = float(int(fragment_unnamed_86)), fragment_unnamed_99 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_unnamed_51, fragment_unnamed_94, fragment_unnamed_83), mad(fragment_unnamed_59, fragment_unnamed_94, fragment_unnamed_84))), fragment_unnamed_101 = fragment_unnamed_99.x, fragment_unnamed_104 = asfloat(fragment_unnamed_63), fragment_unnamed_106 = asfloat(fragment_unnamed_63), fragment_unnamed_113 = dot(float2(asfloat(fragment_unnamed_65), fragment_unnamed_104), float2(asfloat(fragment_unnamed_65), fragment_unnamed_106)) < dot(float2(fragment_unnamed_101, fragment_unnamed_99.y), float2(fragment_unnamed_101, fragment_unnamed_99.y)), fragment_unnamed_63 = fragment_unnamed_113 ? asuint(fragment_unnamed_99.y) : fragment_unnamed_63, fragment_unnamed_86++, fragment_unnamed_65 = fragment_unnamed_113 ? asuint(fragment_unnamed_101) : fragment_unnamed_65)
					{
					}
				}
				fragment_output_0.x = asfloat(fragment_unnamed_64);
				fragment_output_0.y = asfloat(fragment_unnamed_62);
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[31] = float4(fragment_uniform_buffer_0[31][0], asfloat(_TileMaxLoop), fragment_uniform_buffer_0[31][2], fragment_uniform_buffer_0[31][3]);

				fragment_uniform_buffer_0[31] = float4(fragment_uniform_buffer_0[31][0], fragment_uniform_buffer_0[31][1], _TileMaxOffs[0], _TileMaxOffs[1]);

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
			GpuProgramID 276320

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


			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[29];
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
				float4 fragment_unnamed_51 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].y, 0.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, 1.0f, fragment_input_1.y)));
				float fragment_unnamed_53 = fragment_unnamed_51.x;
				float4 fragment_unnamed_55 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, 1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, 1.0f, fragment_input_1.y)));
				float fragment_unnamed_57 = fragment_unnamed_55.x;
				bool fragment_unnamed_66 = dot(float2(fragment_unnamed_53, fragment_unnamed_51.y), float2(fragment_unnamed_53, fragment_unnamed_51.y)) < dot(float2(fragment_unnamed_57, fragment_unnamed_55.y), float2(fragment_unnamed_57, fragment_unnamed_55.y));
				uint fragment_unnamed_71 = fragment_unnamed_66 ? asuint(fragment_unnamed_57) : asuint(fragment_unnamed_53);
				float fragment_unnamed_72 = asfloat(fragment_unnamed_71);
				uint fragment_unnamed_73 = fragment_unnamed_66 ? asuint(fragment_unnamed_55.y) : asuint(fragment_unnamed_51.y);
				float fragment_unnamed_74 = asfloat(fragment_unnamed_73);
				float4 fragment_unnamed_91 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, -1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, 1.0f, fragment_input_1.y)));
				float fragment_unnamed_93 = fragment_unnamed_91.x;
				float4 fragment_unnamed_95 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_uniform_buffer_0[28u].x, 1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_0[28u].y, 0.0f, fragment_input_1.y)));
				float fragment_unnamed_97 = fragment_unnamed_95.x;
				bool fragment_unnamed_102 = dot(float2(fragment_unnamed_93, fragment_unnamed_91.y), float2(fragment_unnamed_93, fragment_unnamed_91.y)) < dot(float2(fragment_unnamed_72, fragment_unnamed_74), float2(fragment_unnamed_72, fragment_unnamed_74));
				uint fragment_unnamed_105 = fragment_unnamed_102 ? fragment_unnamed_71 : asuint(fragment_unnamed_93);
				float fragment_unnamed_106 = asfloat(fragment_unnamed_105);
				uint fragment_unnamed_107 = fragment_unnamed_102 ? fragment_unnamed_73 : asuint(fragment_unnamed_91.y);
				float fragment_unnamed_108 = asfloat(fragment_unnamed_107);
				float4 fragment_unnamed_119 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				precise float fragment_unnamed_123 = fragment_unnamed_119.x * 1.0099999904632568359375f;
				precise float fragment_unnamed_125 = fragment_unnamed_119.y * 1.0099999904632568359375f;
				bool fragment_unnamed_129 = dot(float2(fragment_unnamed_123, fragment_unnamed_125), float2(fragment_unnamed_123, fragment_unnamed_125)) < dot(float2(fragment_unnamed_97, fragment_unnamed_95.y), float2(fragment_unnamed_97, fragment_unnamed_95.y));
				uint fragment_unnamed_134 = fragment_unnamed_129 ? asuint(fragment_unnamed_97) : asuint(fragment_unnamed_123);
				float fragment_unnamed_135 = asfloat(fragment_unnamed_134);
				uint fragment_unnamed_136 = fragment_unnamed_129 ? asuint(fragment_unnamed_95.y) : asuint(fragment_unnamed_125);
				float fragment_unnamed_137 = asfloat(fragment_unnamed_136);
				precise float fragment_unnamed_144 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_147 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				float4 fragment_unnamed_156 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_unnamed_144, 1.0f, fragment_input_1.x), mad(fragment_unnamed_147, 0.0f, fragment_input_1.y)));
				float fragment_unnamed_158 = fragment_unnamed_156.x;
				float4 fragment_unnamed_160 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_unnamed_144, -1.0f, fragment_input_1.x), mad(fragment_unnamed_147, 1.0f, fragment_input_1.y)));
				float fragment_unnamed_162 = fragment_unnamed_160.x;
				bool fragment_unnamed_167 = dot(float2(fragment_unnamed_158, fragment_unnamed_156.y), float2(fragment_unnamed_158, fragment_unnamed_156.y)) < dot(float2(fragment_unnamed_135, fragment_unnamed_137), float2(fragment_unnamed_135, fragment_unnamed_137));
				uint fragment_unnamed_170 = fragment_unnamed_167 ? fragment_unnamed_134 : asuint(fragment_unnamed_158);
				float fragment_unnamed_171 = asfloat(fragment_unnamed_170);
				uint fragment_unnamed_172 = fragment_unnamed_167 ? fragment_unnamed_136 : asuint(fragment_unnamed_156.y);
				float fragment_unnamed_173 = asfloat(fragment_unnamed_172);
				bool fragment_unnamed_177 = dot(float2(fragment_unnamed_171, fragment_unnamed_173), float2(fragment_unnamed_171, fragment_unnamed_173)) < dot(float2(fragment_unnamed_106, fragment_unnamed_108), float2(fragment_unnamed_106, fragment_unnamed_108));
				uint fragment_unnamed_178 = fragment_unnamed_177 ? fragment_unnamed_105 : fragment_unnamed_170;
				float fragment_unnamed_179 = asfloat(fragment_unnamed_178);
				uint fragment_unnamed_180 = fragment_unnamed_177 ? fragment_unnamed_107 : fragment_unnamed_172;
				float fragment_unnamed_181 = asfloat(fragment_unnamed_180);
				precise float fragment_unnamed_191 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_193 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				float4 fragment_unnamed_202 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_unnamed_193, 0.0f, fragment_input_1.x), mad(fragment_unnamed_193, 1.0f, fragment_input_1.y)));
				float fragment_unnamed_204 = fragment_unnamed_202.x;
				float4 fragment_unnamed_206 = _MainTex.Sample(sampler_MainTex, float2(mad(fragment_unnamed_191, 1.0f, fragment_input_1.x), mad(fragment_unnamed_193, 1.0f, fragment_input_1.y)));
				float fragment_unnamed_208 = fragment_unnamed_206.x;
				bool fragment_unnamed_213 = dot(float2(fragment_unnamed_204, fragment_unnamed_202.y), float2(fragment_unnamed_204, fragment_unnamed_202.y)) < dot(float2(fragment_unnamed_162, fragment_unnamed_160.y), float2(fragment_unnamed_162, fragment_unnamed_160.y));
				uint fragment_unnamed_218 = fragment_unnamed_213 ? asuint(fragment_unnamed_162) : asuint(fragment_unnamed_204);
				float fragment_unnamed_219 = asfloat(fragment_unnamed_218);
				uint fragment_unnamed_220 = fragment_unnamed_213 ? asuint(fragment_unnamed_160.y) : asuint(fragment_unnamed_202.y);
				float fragment_unnamed_221 = asfloat(fragment_unnamed_220);
				bool fragment_unnamed_228 = dot(float2(fragment_unnamed_208, fragment_unnamed_206.y), float2(fragment_unnamed_208, fragment_unnamed_206.y)) < dot(float2(fragment_unnamed_219, fragment_unnamed_221), float2(fragment_unnamed_219, fragment_unnamed_221));
				uint fragment_unnamed_231 = fragment_unnamed_228 ? fragment_unnamed_218 : asuint(fragment_unnamed_208);
				float fragment_unnamed_232 = asfloat(fragment_unnamed_231);
				uint fragment_unnamed_233 = fragment_unnamed_228 ? fragment_unnamed_220 : asuint(fragment_unnamed_206.y);
				float fragment_unnamed_234 = asfloat(fragment_unnamed_233);
				bool fragment_unnamed_238 = dot(float2(fragment_unnamed_232, fragment_unnamed_234), float2(fragment_unnamed_232, fragment_unnamed_234)) < dot(float2(fragment_unnamed_179, fragment_unnamed_181), float2(fragment_unnamed_179, fragment_unnamed_181));
				precise float fragment_unnamed_243 = asfloat(fragment_unnamed_238 ? fragment_unnamed_178 : fragment_unnamed_231) * 0.990099012851715087890625f;
				precise float fragment_unnamed_245 = asfloat(fragment_unnamed_238 ? fragment_unnamed_180 : fragment_unnamed_233) * 0.990099012851715087890625f;
				fragment_output_0.x = fragment_unnamed_243;
				fragment_output_0.y = fragment_unnamed_245;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

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
			GpuProgramID 334382

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


			float4 _ScreenParams;
			float4 _MainTex_TexelSize;
			float2 _VelocityTex_TexelSize;
			float2 _NeighborMaxTex_TexelSize;
			float _MaxBlurRadius;
			float _LoopCount;

			static float4 fragment_uniform_buffer_0[33];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _VelocityTex;
			Texture2D<float4> _NeighborMaxTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_VelocityTex;
			SamplerState sampler_NeighborMaxTex;

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
				float4 fragment_unnamed_47 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_49 = fragment_unnamed_47.x;
				float fragment_unnamed_50 = fragment_unnamed_47.y;
				float fragment_unnamed_51 = fragment_unnamed_47.z;
				float fragment_unnamed_52 = fragment_unnamed_47.w;
				precise float fragment_unnamed_57 = fragment_input_1.x + 2.0f;
				precise float fragment_unnamed_59 = fragment_input_1.y + 0.0f;
				precise float fragment_unnamed_66 = fragment_unnamed_57 * fragment_uniform_buffer_0[22u].x;
				precise float fragment_unnamed_67 = fragment_unnamed_59 * fragment_uniform_buffer_0[22u].y;
				precise float fragment_unnamed_77 = frac(dot(float2(0.067110560834407806396484375f, 0.005837149918079376220703125f), float2(floor(fragment_unnamed_66), floor(fragment_unnamed_67)))) * 52.98291778564453125f;
				precise float fragment_unnamed_80 = frac(fragment_unnamed_77) * 6.283185482025146484375f;
				precise float fragment_unnamed_89 = cos(fragment_unnamed_80) * fragment_uniform_buffer_0[30u].z;
				precise float fragment_unnamed_90 = sin(fragment_unnamed_80) * fragment_uniform_buffer_0[30u].w;
				float4 fragment_unnamed_99 = _NeighborMaxTex.Sample(sampler_NeighborMaxTex, float2(mad(fragment_unnamed_89, 0.25f, fragment_input_1.x), mad(fragment_unnamed_90, 0.25f, fragment_input_1.y)));
				float fragment_unnamed_101 = fragment_unnamed_99.x;
				float fragment_unnamed_102 = fragment_unnamed_99.y;
				float fragment_unnamed_106 = sqrt(dot(float2(fragment_unnamed_101, fragment_unnamed_102), float2(fragment_unnamed_101, fragment_unnamed_102)));
				if (fragment_unnamed_106 < 2.0f)
				{
					fragment_output_0.x = fragment_unnamed_49;
					fragment_output_0.y = fragment_unnamed_50;
					fragment_output_0.z = fragment_unnamed_51;
					fragment_output_0.w = fragment_unnamed_52;
					return;
				}
				else
				{
					float4 fragment_unnamed_121 = _VelocityTex.SampleLevel(sampler_VelocityTex, float2(fragment_input_1.x, fragment_input_1.y), 0.0f);
					float fragment_unnamed_125 = fragment_unnamed_121.z;
					precise float fragment_unnamed_133 = mad(fragment_unnamed_121.x, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
					precise float fragment_unnamed_134 = mad(fragment_unnamed_121.y, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x;
					float fragment_unnamed_138 = sqrt(dot(float2(fragment_unnamed_133, fragment_unnamed_134), float2(fragment_unnamed_133, fragment_unnamed_134)));
					float fragment_unnamed_139 = max(fragment_unnamed_138, 0.5f);
					precise float fragment_unnamed_143 = 1.0f / fragment_unnamed_125;
					precise float fragment_unnamed_144 = fragment_unnamed_139 + fragment_unnamed_139;
					bool fragment_unnamed_145 = fragment_unnamed_106 < fragment_unnamed_144;
					precise float fragment_unnamed_146 = fragment_unnamed_106 / fragment_unnamed_139;
					precise float fragment_unnamed_147 = fragment_unnamed_133 * fragment_unnamed_146;
					precise float fragment_unnamed_148 = fragment_unnamed_134 * fragment_unnamed_146;
					uint fragment_unnamed_153 = fragment_unnamed_145 ? asuint(fragment_unnamed_147) : asuint(fragment_unnamed_101);
					uint fragment_unnamed_154 = fragment_unnamed_145 ? asuint(fragment_unnamed_148) : asuint(fragment_unnamed_102);
					precise float fragment_unnamed_155 = fragment_unnamed_106 * 0.5f;
					float fragment_unnamed_160 = floor(min(fragment_unnamed_155, fragment_uniform_buffer_0[32u].z));
					precise float fragment_unnamed_161 = 1.0f / fragment_unnamed_160;
					precise float fragment_unnamed_170 = fragment_input_1.x * fragment_uniform_buffer_0[22u].x;
					precise float fragment_unnamed_171 = fragment_input_1.y * fragment_uniform_buffer_0[22u].y;
					precise float fragment_unnamed_178 = frac(dot(float2(0.067110560834407806396484375f, 0.005837149918079376220703125f), float2(floor(fragment_unnamed_170), floor(fragment_unnamed_171)))) * 52.98291778564453125f;
					precise float fragment_unnamed_179 = fragment_unnamed_161 * 0.25f;
					precise float fragment_unnamed_181 = frac(fragment_unnamed_178) + (-0.5f);
					precise float fragment_unnamed_183 = (-0.0f) - fragment_unnamed_161;
					float fragment_unnamed_185 = mad(fragment_unnamed_183, 0.5f, 1.0f);
					float fragment_unnamed_186 = asfloat(1065353216u);
					float fragment_unnamed_192 = asfloat(0u);
					float fragment_unnamed_193;
					float fragment_unnamed_199;
					float fragment_unnamed_201;
					float fragment_unnamed_203;
					float fragment_unnamed_205;
					fragment_unnamed_193 = asfloat(0u);
					fragment_unnamed_199 = max(fragment_unnamed_138, 1.0f);
					fragment_unnamed_201 = asfloat(0u);
					fragment_unnamed_203 = asfloat(0u);
					fragment_unnamed_205 = asfloat(0u);
					precise float fragment_unnamed_198;
					precise float fragment_unnamed_225;
					precise float fragment_unnamed_226;
					bool fragment_unnamed_229;
					bool fragment_unnamed_231;
					precise float fragment_unnamed_238;
					float fragment_unnamed_240;
					precise float fragment_unnamed_241;
					precise float fragment_unnamed_242;
					float4 fragment_unnamed_265;
					float4 fragment_unnamed_271;
					precise float fragment_unnamed_281;
					precise float fragment_unnamed_282;
					precise float fragment_unnamed_283;
					precise float fragment_unnamed_284;
					precise float fragment_unnamed_285;
					precise float fragment_unnamed_286;
					precise float fragment_unnamed_293;
					precise float fragment_unnamed_294;
					float fragment_unnamed_295;
					precise float fragment_unnamed_296;
					precise float fragment_unnamed_300;
					precise float fragment_unnamed_301;
					precise float fragment_unnamed_302;
					precise float fragment_unnamed_303;
					precise float fragment_unnamed_304;
					precise float fragment_unnamed_305;
					for (float fragment_unnamed_195 = fragment_unnamed_185, fragment_unnamed_197 = fragment_unnamed_192; !(fragment_unnamed_179 >= fragment_unnamed_195); fragment_unnamed_225 = fragment_unnamed_197 * 0.25f, fragment_unnamed_226 = fragment_unnamed_197 * 0.5f, fragment_unnamed_229 = 0.499000012874603271484375f < frac(fragment_unnamed_225), fragment_unnamed_231 = 0.499000012874603271484375f < frac(fragment_unnamed_226), fragment_unnamed_238 = (-0.0f) - fragment_unnamed_195, fragment_unnamed_240 = mad(fragment_unnamed_181, fragment_unnamed_161, fragment_unnamed_231 ? fragment_unnamed_238 : fragment_unnamed_195), fragment_unnamed_241 = fragment_unnamed_240 * asfloat(fragment_unnamed_229 ? fragment_unnamed_153 : asuint(fragment_unnamed_101)), fragment_unnamed_242 = fragment_unnamed_240 * asfloat(fragment_unnamed_229 ? fragment_unnamed_154 : asuint(fragment_unnamed_102)), fragment_unnamed_265 = _MainTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_241, fragment_uniform_buffer_0[28u].x, fragment_input_1.x), mad(fragment_unnamed_242, fragment_uniform_buffer_0[28u].y, fragment_input_1.y)), 0.0f), fragment_unnamed_271 = _VelocityTex.SampleLevel(sampler_VelocityTex, float2(mad(fragment_unnamed_241, fragment_uniform_buffer_0[30u].x, fragment_input_1.x), mad(fragment_unnamed_242, fragment_uniform_buffer_0[30u].y, fragment_input_1.y)), 0.0f), fragment_unnamed_281 = mad(fragment_unnamed_271.x, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x, fragment_unnamed_282 = mad(fragment_unnamed_271.y, 2.0f, -1.0f) * fragment_uniform_buffer_0[32u].x, fragment_unnamed_283 = (-0.0f) - fragment_unnamed_271.z, fragment_unnamed_284 = fragment_unnamed_125 + fragment_unnamed_283, fragment_unnamed_285 = fragment_unnamed_143 * fragment_unnamed_284, fragment_unnamed_286 = fragment_unnamed_285 * 20.0f, fragment_unnamed_293 = (-0.0f) - fragment_unnamed_199, fragment_unnamed_294 = fragment_unnamed_293 + sqrt(dot(float2(fragment_unnamed_281, fragment_unnamed_282), float2(fragment_unnamed_281, fragment_unnamed_282))), fragment_unnamed_295 = mad(clamp(fragment_unnamed_286, 0.0f, 1.0f), fragment_unnamed_294, fragment_unnamed_199), fragment_unnamed_296 = (-0.0f) - fragment_unnamed_106, fragment_unnamed_300 = clamp(mad(fragment_unnamed_296, abs(fragment_unnamed_240), fragment_unnamed_295), 0.0f, 1.0f) / fragment_unnamed_295, fragment_unnamed_301 = (-0.0f) - fragment_unnamed_195, fragment_unnamed_302 = fragment_unnamed_301 + 1.2000000476837158203125f, fragment_unnamed_303 = fragment_unnamed_302 * fragment_unnamed_300, fragment_unnamed_304 = (-0.0f) - fragment_unnamed_161, fragment_unnamed_305 = fragment_unnamed_304 + fragment_unnamed_195, fragment_unnamed_198 = fragment_unnamed_197 + 1.0f, fragment_unnamed_193 = mad(fragment_unnamed_186, fragment_unnamed_303, fragment_unnamed_193), fragment_unnamed_195 = asfloat(fragment_unnamed_231 ? asuint(fragment_unnamed_305) : asuint(fragment_unnamed_195)), fragment_unnamed_197 = fragment_unnamed_198, fragment_unnamed_199 = max(fragment_unnamed_199, fragment_unnamed_295), fragment_unnamed_201 = mad(fragment_unnamed_265.z, fragment_unnamed_303, fragment_unnamed_201), fragment_unnamed_203 = mad(fragment_unnamed_265.y, fragment_unnamed_303, fragment_unnamed_203), fragment_unnamed_205 = mad(fragment_unnamed_265.x, fragment_unnamed_303, fragment_unnamed_205))
					{
					}
					precise float fragment_unnamed_211 = 1.2000000476837158203125f / dot(fragment_unnamed_199.xx, fragment_unnamed_160.xx);
					float fragment_unnamed_217 = mad(asfloat(1065353216u), fragment_unnamed_211, fragment_unnamed_193);
					precise float fragment_unnamed_218 = mad(fragment_unnamed_49, fragment_unnamed_211, fragment_unnamed_205) / fragment_unnamed_217;
					precise float fragment_unnamed_219 = mad(fragment_unnamed_50, fragment_unnamed_211, fragment_unnamed_203) / fragment_unnamed_217;
					precise float fragment_unnamed_220 = mad(fragment_unnamed_51, fragment_unnamed_211, fragment_unnamed_201) / fragment_unnamed_217;
					fragment_output_0.x = fragment_unnamed_218;
					fragment_output_0.y = fragment_unnamed_219;
					fragment_output_0.z = fragment_unnamed_220;
					fragment_output_0.w = fragment_unnamed_52;
					return;
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[22] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[30] = float4(_VelocityTex_TexelSize[0], _VelocityTex_TexelSize[1], fragment_uniform_buffer_0[30][2], fragment_uniform_buffer_0[30][3]);

				fragment_uniform_buffer_0[30] = float4(fragment_uniform_buffer_0[30][0], fragment_uniform_buffer_0[30][1], _NeighborMaxTex_TexelSize[0], _NeighborMaxTex_TexelSize[1]);

				fragment_uniform_buffer_0[32] = float4(_MaxBlurRadius, fragment_uniform_buffer_0[32][1], fragment_uniform_buffer_0[32][2], fragment_uniform_buffer_0[32][3]);

				fragment_uniform_buffer_0[32] = float4(fragment_uniform_buffer_0[32][0], fragment_uniform_buffer_0[32][1], _LoopCount, fragment_uniform_buffer_0[32][3]);

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
