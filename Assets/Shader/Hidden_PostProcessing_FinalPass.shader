Shader "Hidden/PostProcessing/FinalPass"
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
			GpuProgramID 58576

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma shader_feature FXAA
			#pragma multi_compile _ FXAA_KEEP_ALPHA
			#pragma shader_feature FXAA_LOW
			#pragma shader_feature STEREO_DOUBLEWIDE_TARGET
			#pragma shader_feature STEREO_INSTANCING_ENABLED


			#if !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
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
				float vertex_unnamed_57 = mad((vertex_input_0.x + 1.0f) * vertex_uniform_buffer_0[27u].x, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_59 = mad((vertex_input_0.y + 1.0f) * vertex_uniform_buffer_0[27u].y, 0.5f, vertex_uniform_buffer_0[27u].w);
				vertex_output_1.x = vertex_unnamed_57 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_57;
				vertex_output_1.y = vertex_unnamed_59;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4 _Dithering_Coords;

			static float4 fragment_uniform_buffer_0[29];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_59 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				float fragment_unnamed_75 = (((-0.0f) - sqrt(((-0.0f) - abs(fragment_unnamed_59)) + 1.0f)) + 1.0f) * mad(clamp(mad(fragment_unnamed_59, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				float4 fragment_unnamed_81 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				fragment_output_0.x = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.x);
				fragment_output_0.y = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.y);
				fragment_output_0.z = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.z);
				fragment_output_0.w = fragment_unnamed_81.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA) && !defined(FXAA_LOW)


			#if defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float _DepthSlice;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
			static float4 gl_Position;
			static uint gl_Layer;
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
				uint gl_Layer : SV_RenderTargetArrayIndex;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				float vertex_unnamed_59 = mad((vertex_input_0.x + 1.0f) * vertex_uniform_buffer_0[27u].x, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_61 = mad((vertex_input_0.y + 1.0f) * vertex_uniform_buffer_0[27u].y, 0.5f, vertex_uniform_buffer_0[27u].w);
				vertex_output_1.x = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = vertex_unnamed_61 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_59;
				vertex_output_1.y = vertex_unnamed_61;
				gl_Layer = int(uint(vertex_uniform_buffer_0[26u].y));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[26] = float4(vertex_uniform_buffer_0[26][0], _DepthSlice, vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.gl_Layer = gl_Layer;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4 _Dithering_Coords;

			static float4 fragment_uniform_buffer_0[29];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_61 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				float fragment_unnamed_77 = (((-0.0f) - sqrt(((-0.0f) - abs(fragment_unnamed_61)) + 1.0f)) + 1.0f) * mad(clamp(mad(fragment_unnamed_61, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				float4 fragment_unnamed_83 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				fragment_output_0.x = mad(fragment_unnamed_77, 0.0039215688593685626983642578125f, fragment_unnamed_83.x);
				fragment_output_0.y = mad(fragment_unnamed_77, 0.0039215688593685626983642578125f, fragment_unnamed_83.y);
				fragment_output_0.z = mad(fragment_unnamed_77, 0.0039215688593685626983642578125f, fragment_unnamed_83.z);
				fragment_output_0.w = fragment_unnamed_83.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA) && !defined(FXAA_LOW)


			#if defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;
			float4 _PosScaleOffset;

			static float4 vertex_uniform_buffer_0[29];
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
				gl_Position.x = mad(vertex_input_0.x, vertex_uniform_buffer_0[28u].x, vertex_uniform_buffer_0[28u].z);
				gl_Position.y = mad(vertex_input_0.y, vertex_uniform_buffer_0[28u].y, vertex_uniform_buffer_0[28u].w);
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				float vertex_unnamed_68 = mad((vertex_input_0.x + 1.0f) * vertex_uniform_buffer_0[27u].x, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_70 = mad((vertex_input_0.y + 1.0f) * vertex_uniform_buffer_0[27u].y, 0.5f, vertex_uniform_buffer_0[27u].w);
				vertex_output_1.x = vertex_unnamed_68 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = vertex_unnamed_70 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_68;
				vertex_output_1.y = vertex_unnamed_70;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_uniform_buffer_0[28] = float4(_PosScaleOffset[0], _PosScaleOffset[1], _PosScaleOffset[2], _PosScaleOffset[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4 _Dithering_Coords;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_59 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[29u].x, fragment_uniform_buffer_0[29u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[29u].y, fragment_uniform_buffer_0[29u].w))).w, 2.0f, -1.0f);
				float fragment_unnamed_75 = (((-0.0f) - sqrt(((-0.0f) - abs(fragment_unnamed_59)) + 1.0f)) + 1.0f) * mad(clamp(mad(fragment_unnamed_59, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				float4 fragment_unnamed_81 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				fragment_output_0.x = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.x);
				fragment_output_0.y = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.y);
				fragment_output_0.z = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.z);
				fragment_output_0.w = fragment_unnamed_81.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[29] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA) && !defined(FXAA_LOW)


			#if defined(FXAA_KEEP_ALPHA) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
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
				float vertex_unnamed_57 = mad((vertex_input_0.x + 1.0f) * vertex_uniform_buffer_0[27u].x, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_59 = mad((vertex_input_0.y + 1.0f) * vertex_uniform_buffer_0[27u].y, 0.5f, vertex_uniform_buffer_0[27u].w);
				vertex_output_1.x = vertex_unnamed_57 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_57;
				vertex_output_1.y = vertex_unnamed_59;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4 _Dithering_Coords;

			static float4 fragment_uniform_buffer_0[29];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_59 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				float fragment_unnamed_75 = (((-0.0f) - sqrt(((-0.0f) - abs(fragment_unnamed_59)) + 1.0f)) + 1.0f) * mad(clamp(mad(fragment_unnamed_59, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				float4 fragment_unnamed_81 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				fragment_output_0.x = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.x);
				fragment_output_0.y = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.y);
				fragment_output_0.z = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.z);
				fragment_output_0.w = fragment_unnamed_81.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA_KEEP_ALPHA) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA) && !defined(FXAA_LOW)


			#if defined(FXAA_KEEP_ALPHA) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float _DepthSlice;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
			static float4 gl_Position;
			static uint gl_Layer;
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
				uint gl_Layer : SV_RenderTargetArrayIndex;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				float vertex_unnamed_59 = mad((vertex_input_0.x + 1.0f) * vertex_uniform_buffer_0[27u].x, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_61 = mad((vertex_input_0.y + 1.0f) * vertex_uniform_buffer_0[27u].y, 0.5f, vertex_uniform_buffer_0[27u].w);
				vertex_output_1.x = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = vertex_unnamed_61 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_59;
				vertex_output_1.y = vertex_unnamed_61;
				gl_Layer = int(uint(vertex_uniform_buffer_0[26u].y));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[26] = float4(vertex_uniform_buffer_0[26][0], _DepthSlice, vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.gl_Layer = gl_Layer;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4 _Dithering_Coords;

			static float4 fragment_uniform_buffer_0[29];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_61 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				float fragment_unnamed_77 = (((-0.0f) - sqrt(((-0.0f) - abs(fragment_unnamed_61)) + 1.0f)) + 1.0f) * mad(clamp(mad(fragment_unnamed_61, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				float4 fragment_unnamed_83 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				fragment_output_0.x = mad(fragment_unnamed_77, 0.0039215688593685626983642578125f, fragment_unnamed_83.x);
				fragment_output_0.y = mad(fragment_unnamed_77, 0.0039215688593685626983642578125f, fragment_unnamed_83.y);
				fragment_output_0.z = mad(fragment_unnamed_77, 0.0039215688593685626983642578125f, fragment_unnamed_83.z);
				fragment_output_0.w = fragment_unnamed_83.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA_KEEP_ALPHA) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA) && !defined(FXAA_LOW)


			#if defined(FXAA_KEEP_ALPHA) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;
			float4 _PosScaleOffset;

			static float4 vertex_uniform_buffer_0[29];
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
				gl_Position.x = mad(vertex_input_0.x, vertex_uniform_buffer_0[28u].x, vertex_uniform_buffer_0[28u].z);
				gl_Position.y = mad(vertex_input_0.y, vertex_uniform_buffer_0[28u].y, vertex_uniform_buffer_0[28u].w);
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				float vertex_unnamed_68 = mad((vertex_input_0.x + 1.0f) * vertex_uniform_buffer_0[27u].x, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_70 = mad((vertex_input_0.y + 1.0f) * vertex_uniform_buffer_0[27u].y, 0.5f, vertex_uniform_buffer_0[27u].w);
				vertex_output_1.x = vertex_unnamed_68 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = vertex_unnamed_70 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_68;
				vertex_output_1.y = vertex_unnamed_70;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_uniform_buffer_0[28] = float4(_PosScaleOffset[0], _PosScaleOffset[1], _PosScaleOffset[2], _PosScaleOffset[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4 _Dithering_Coords;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_59 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[29u].x, fragment_uniform_buffer_0[29u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[29u].y, fragment_uniform_buffer_0[29u].w))).w, 2.0f, -1.0f);
				float fragment_unnamed_75 = (((-0.0f) - sqrt(((-0.0f) - abs(fragment_unnamed_59)) + 1.0f)) + 1.0f) * mad(clamp(mad(fragment_unnamed_59, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				float4 fragment_unnamed_81 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				fragment_output_0.x = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.x);
				fragment_output_0.y = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.y);
				fragment_output_0.z = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.z);
				fragment_output_0.w = fragment_unnamed_81.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[29] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA_KEEP_ALPHA) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA) && !defined(FXAA_LOW)


			#if defined(FXAA) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
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
				float vertex_unnamed_57 = mad((vertex_input_0.x + 1.0f) * vertex_uniform_buffer_0[27u].x, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_59 = mad((vertex_input_0.y + 1.0f) * vertex_uniform_buffer_0[27u].y, 0.5f, vertex_uniform_buffer_0[27u].w);
				vertex_output_1.x = vertex_unnamed_57 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_57;
				vertex_output_1.y = vertex_unnamed_59;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f);
				float fragment_unnamed_59 = fragment_unnamed_54.w;
				float4 fragment_unnamed_63 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, 1));
				float fragment_unnamed_67 = fragment_unnamed_63.w;
				float4 fragment_unnamed_68 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 0));
				float fragment_unnamed_71 = fragment_unnamed_68.w;
				float4 fragment_unnamed_73 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, -1));
				float fragment_unnamed_76 = fragment_unnamed_73.w;
				float4 fragment_unnamed_77 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 0));
				float fragment_unnamed_80 = fragment_unnamed_77.w;
				float fragment_unnamed_87 = max(max(fragment_unnamed_71, max(fragment_unnamed_59, fragment_unnamed_67)), max(fragment_unnamed_80, fragment_unnamed_76));
				float fragment_unnamed_93 = ((-0.0f) - min(min(fragment_unnamed_71, min(fragment_unnamed_59, fragment_unnamed_67)), min(fragment_unnamed_80, fragment_unnamed_76))) + fragment_unnamed_87;
				float fragment_unnamed_288;
				float fragment_unnamed_290;
				float fragment_unnamed_292;
				if (fragment_unnamed_93 >= max(fragment_unnamed_87 * 0.063000001013278961181640625f, 0.031199999153614044189453125f))
				{
					float4 fragment_unnamed_99 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, -1));
					float fragment_unnamed_102 = fragment_unnamed_99.w;
					float4 fragment_unnamed_103 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 1));
					float fragment_unnamed_106 = fragment_unnamed_103.w;
					float4 fragment_unnamed_107 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, -1));
					float fragment_unnamed_110 = fragment_unnamed_107.w;
					float4 fragment_unnamed_111 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 1));
					float fragment_unnamed_114 = fragment_unnamed_111.w;
					float fragment_unnamed_115 = fragment_unnamed_67 + fragment_unnamed_76;
					float fragment_unnamed_116 = fragment_unnamed_71 + fragment_unnamed_80;
					float fragment_unnamed_122 = fragment_unnamed_106 + fragment_unnamed_110;
					float fragment_unnamed_126 = fragment_unnamed_114 + fragment_unnamed_102;
					bool fragment_unnamed_142 = (mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_115)), 2.0f, abs(mad(fragment_unnamed_71, -2.0f, fragment_unnamed_122))) + abs(mad(fragment_unnamed_80, -2.0f, fragment_unnamed_126))) >= (mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_116)), 2.0f, abs(mad(fragment_unnamed_76, -2.0f, fragment_unnamed_102 + fragment_unnamed_110))) + abs(mad(fragment_unnamed_67, -2.0f, fragment_unnamed_106 + fragment_unnamed_114)));
					float fragment_unnamed_149 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_76) : asuint(fragment_unnamed_80));
					float fragment_unnamed_153 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_67) : asuint(fragment_unnamed_71));
					float fragment_unnamed_165 = asfloat(fragment_unnamed_142 ? asuint(fragment_uniform_buffer_0[29u]).y : asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_170 = ((-0.0f) - fragment_unnamed_59) + fragment_unnamed_149;
					float fragment_unnamed_172 = ((-0.0f) - fragment_unnamed_59) + fragment_unnamed_153;
					bool fragment_unnamed_177 = abs(fragment_unnamed_170) >= abs(fragment_unnamed_172);
					float fragment_unnamed_182 = fragment_unnamed_177 ? ((-0.0f) - fragment_unnamed_165) : fragment_unnamed_165;
					float fragment_unnamed_185 = clamp((1.0f / fragment_unnamed_93) * abs(mad(mad(fragment_unnamed_115 + fragment_unnamed_116, 2.0f, fragment_unnamed_122 + fragment_unnamed_126), 0.083333335816860198974609375f, (-0.0f) - fragment_unnamed_59)), 0.0f, 1.0f);
					float fragment_unnamed_191 = asfloat((fragment_unnamed_142 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_197 = asfloat(fragment_unnamed_142 ? 0u : asuint(fragment_uniform_buffer_0[29u]).y);
					float fragment_unnamed_207 = fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_182, 0.5f, fragment_input_1.x);
					float fragment_unnamed_210 = fragment_unnamed_142 ? mad(fragment_unnamed_182, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					float fragment_unnamed_213 = ((-0.0f) - fragment_unnamed_191) + fragment_unnamed_207;
					float fragment_unnamed_214 = ((-0.0f) - fragment_unnamed_197) + fragment_unnamed_210;
					float fragment_unnamed_215 = fragment_unnamed_191 + fragment_unnamed_207;
					float fragment_unnamed_216 = fragment_unnamed_197 + fragment_unnamed_210;
					float fragment_unnamed_243 = asfloat(fragment_unnamed_177 ? asuint(fragment_unnamed_59 + fragment_unnamed_149) : asuint(fragment_unnamed_59 + fragment_unnamed_153));
					float fragment_unnamed_244 = max(abs(fragment_unnamed_172), abs(fragment_unnamed_170)) * 0.25f;
					float fragment_unnamed_248 = (fragment_unnamed_185 * fragment_unnamed_185) * mad(fragment_unnamed_185, -2.0f, 3.0f);
					uint fragment_unnamed_250 = (mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_59) < 0.0f) ? 4294967295u : 0u;
					float fragment_unnamed_252 = mad((-0.0f) - fragment_unnamed_243, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_213, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_214, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w);
					float fragment_unnamed_254 = mad((-0.0f) - fragment_unnamed_243, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_215, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_216, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w);
					bool fragment_unnamed_257 = abs(fragment_unnamed_252) >= fragment_unnamed_244;
					bool fragment_unnamed_258 = abs(fragment_unnamed_254) >= fragment_unnamed_244;
					uint fragment_unnamed_259 = fragment_unnamed_257 ? 4294967295u : 0u;
					uint fragment_unnamed_260 = fragment_unnamed_258 ? 4294967295u : 0u;
					uint fragment_unnamed_266 = fragment_unnamed_257 ? asuint(fragment_unnamed_213) : asuint(mad((-0.0f) - fragment_unnamed_191, 1.5f, fragment_unnamed_213));
					float fragment_unnamed_267 = asfloat(fragment_unnamed_266);
					uint fragment_unnamed_272 = fragment_unnamed_257 ? asuint(fragment_unnamed_214) : asuint(mad((-0.0f) - fragment_unnamed_197, 1.5f, fragment_unnamed_214));
					float fragment_unnamed_273 = asfloat(fragment_unnamed_272);
					uint fragment_unnamed_280 = fragment_unnamed_258 ? asuint(fragment_unnamed_215) : asuint(mad(fragment_unnamed_191, 1.5f, fragment_unnamed_215));
					float fragment_unnamed_281 = asfloat(fragment_unnamed_280);
					uint fragment_unnamed_285 = fragment_unnamed_258 ? asuint(fragment_unnamed_216) : asuint(mad(fragment_unnamed_197, 1.5f, fragment_unnamed_216));
					float fragment_unnamed_286 = asfloat(fragment_unnamed_285);
					float fragment_unnamed_338;
					float fragment_unnamed_340;
					float fragment_unnamed_342;
					float fragment_unnamed_344;
					float fragment_unnamed_346;
					float fragment_unnamed_348;
					if (((~fragment_unnamed_260) | (~fragment_unnamed_259)) != 0u)
					{
						float fragment_unnamed_427;
						if (fragment_unnamed_259 == 0u)
						{
							fragment_unnamed_427 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_267, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_273, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
						}
						else
						{
							fragment_unnamed_427 = fragment_unnamed_252;
						}
						float fragment_unnamed_440;
						if (fragment_unnamed_260 == 0u)
						{
							fragment_unnamed_440 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_281, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_286, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
						}
						else
						{
							fragment_unnamed_440 = fragment_unnamed_254;
						}
						float fragment_unnamed_446 = asfloat(fragment_unnamed_257 ? asuint(fragment_unnamed_427) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_427)));
						float fragment_unnamed_452 = asfloat(fragment_unnamed_258 ? asuint(fragment_unnamed_440) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_440)));
						bool fragment_unnamed_455 = abs(fragment_unnamed_446) >= fragment_unnamed_244;
						bool fragment_unnamed_456 = abs(fragment_unnamed_452) >= fragment_unnamed_244;
						uint fragment_unnamed_457 = fragment_unnamed_455 ? 4294967295u : 0u;
						uint fragment_unnamed_458 = fragment_unnamed_456 ? 4294967295u : 0u;
						uint fragment_unnamed_462 = fragment_unnamed_455 ? fragment_unnamed_266 : asuint(mad((-0.0f) - fragment_unnamed_191, 2.0f, fragment_unnamed_267));
						float fragment_unnamed_463 = asfloat(fragment_unnamed_462);
						uint fragment_unnamed_467 = fragment_unnamed_455 ? fragment_unnamed_272 : asuint(mad((-0.0f) - fragment_unnamed_197, 2.0f, fragment_unnamed_273));
						float fragment_unnamed_468 = asfloat(fragment_unnamed_467);
						uint fragment_unnamed_474 = fragment_unnamed_456 ? fragment_unnamed_280 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_281));
						float fragment_unnamed_475 = asfloat(fragment_unnamed_474);
						uint fragment_unnamed_478 = fragment_unnamed_456 ? fragment_unnamed_285 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_286));
						float fragment_unnamed_479 = asfloat(fragment_unnamed_478);
						float fragment_unnamed_339;
						float fragment_unnamed_341;
						float fragment_unnamed_343;
						float fragment_unnamed_345;
						float fragment_unnamed_347;
						float fragment_unnamed_349;
						if (((~fragment_unnamed_458) | (~fragment_unnamed_457)) != 0u)
						{
							float fragment_unnamed_499;
							if (fragment_unnamed_457 == 0u)
							{
								fragment_unnamed_499 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_463, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_468, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
							}
							else
							{
								fragment_unnamed_499 = fragment_unnamed_446;
							}
							float fragment_unnamed_512;
							if (fragment_unnamed_458 == 0u)
							{
								fragment_unnamed_512 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_475, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_479, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
							}
							else
							{
								fragment_unnamed_512 = fragment_unnamed_452;
							}
							float fragment_unnamed_518 = asfloat(fragment_unnamed_455 ? asuint(fragment_unnamed_499) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_499)));
							float fragment_unnamed_524 = asfloat(fragment_unnamed_456 ? asuint(fragment_unnamed_512) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_512)));
							bool fragment_unnamed_527 = abs(fragment_unnamed_518) >= fragment_unnamed_244;
							bool fragment_unnamed_528 = abs(fragment_unnamed_524) >= fragment_unnamed_244;
							uint fragment_unnamed_529 = fragment_unnamed_527 ? 4294967295u : 0u;
							uint fragment_unnamed_530 = fragment_unnamed_528 ? 4294967295u : 0u;
							uint fragment_unnamed_534 = fragment_unnamed_527 ? fragment_unnamed_462 : asuint(mad((-0.0f) - fragment_unnamed_191, 2.0f, fragment_unnamed_463));
							float fragment_unnamed_535 = asfloat(fragment_unnamed_534);
							uint fragment_unnamed_539 = fragment_unnamed_527 ? fragment_unnamed_467 : asuint(mad((-0.0f) - fragment_unnamed_197, 2.0f, fragment_unnamed_468));
							float fragment_unnamed_540 = asfloat(fragment_unnamed_539);
							uint fragment_unnamed_546 = fragment_unnamed_528 ? fragment_unnamed_474 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_475));
							float fragment_unnamed_547 = asfloat(fragment_unnamed_546);
							uint fragment_unnamed_550 = fragment_unnamed_528 ? fragment_unnamed_478 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_479));
							float fragment_unnamed_551 = asfloat(fragment_unnamed_550);
							float fragment_unnamed_482;
							float fragment_unnamed_483;
							float fragment_unnamed_484;
							float fragment_unnamed_485;
							float fragment_unnamed_486;
							float fragment_unnamed_487;
							if (((~fragment_unnamed_530) | (~fragment_unnamed_529)) != 0u)
							{
								float fragment_unnamed_571;
								if (fragment_unnamed_529 == 0u)
								{
									fragment_unnamed_571 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_535, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_540, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
								}
								else
								{
									fragment_unnamed_571 = fragment_unnamed_518;
								}
								float fragment_unnamed_584;
								if (fragment_unnamed_530 == 0u)
								{
									fragment_unnamed_584 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_547, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_551, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
								}
								else
								{
									fragment_unnamed_584 = fragment_unnamed_524;
								}
								float fragment_unnamed_590 = asfloat(fragment_unnamed_527 ? asuint(fragment_unnamed_571) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_571)));
								float fragment_unnamed_596 = asfloat(fragment_unnamed_528 ? asuint(fragment_unnamed_584) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_584)));
								bool fragment_unnamed_599 = abs(fragment_unnamed_590) >= fragment_unnamed_244;
								bool fragment_unnamed_600 = abs(fragment_unnamed_596) >= fragment_unnamed_244;
								uint fragment_unnamed_601 = fragment_unnamed_599 ? 4294967295u : 0u;
								uint fragment_unnamed_602 = fragment_unnamed_600 ? 4294967295u : 0u;
								uint fragment_unnamed_606 = fragment_unnamed_599 ? fragment_unnamed_534 : asuint(mad((-0.0f) - fragment_unnamed_191, 2.0f, fragment_unnamed_535));
								float fragment_unnamed_607 = asfloat(fragment_unnamed_606);
								uint fragment_unnamed_611 = fragment_unnamed_599 ? fragment_unnamed_539 : asuint(mad((-0.0f) - fragment_unnamed_197, 2.0f, fragment_unnamed_540));
								float fragment_unnamed_612 = asfloat(fragment_unnamed_611);
								uint fragment_unnamed_618 = fragment_unnamed_600 ? fragment_unnamed_546 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_547));
								float fragment_unnamed_619 = asfloat(fragment_unnamed_618);
								uint fragment_unnamed_622 = fragment_unnamed_600 ? fragment_unnamed_550 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_551));
								float fragment_unnamed_623 = asfloat(fragment_unnamed_622);
								float fragment_unnamed_554;
								float fragment_unnamed_555;
								float fragment_unnamed_556;
								float fragment_unnamed_557;
								float fragment_unnamed_558;
								float fragment_unnamed_559;
								if (((~fragment_unnamed_602) | (~fragment_unnamed_601)) != 0u)
								{
									float fragment_unnamed_643;
									if (fragment_unnamed_601 == 0u)
									{
										fragment_unnamed_643 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_607, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_612, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
									}
									else
									{
										fragment_unnamed_643 = fragment_unnamed_590;
									}
									float fragment_unnamed_656;
									if (fragment_unnamed_602 == 0u)
									{
										fragment_unnamed_656 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_619, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_623, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
									}
									else
									{
										fragment_unnamed_656 = fragment_unnamed_596;
									}
									float fragment_unnamed_662 = asfloat(fragment_unnamed_599 ? asuint(fragment_unnamed_643) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_643)));
									float fragment_unnamed_668 = asfloat(fragment_unnamed_600 ? asuint(fragment_unnamed_656) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_656)));
									bool fragment_unnamed_671 = abs(fragment_unnamed_662) >= fragment_unnamed_244;
									bool fragment_unnamed_672 = abs(fragment_unnamed_668) >= fragment_unnamed_244;
									uint fragment_unnamed_673 = fragment_unnamed_671 ? 4294967295u : 0u;
									uint fragment_unnamed_674 = fragment_unnamed_672 ? 4294967295u : 0u;
									uint fragment_unnamed_678 = fragment_unnamed_671 ? fragment_unnamed_606 : asuint(mad((-0.0f) - fragment_unnamed_191, 2.0f, fragment_unnamed_607));
									float fragment_unnamed_679 = asfloat(fragment_unnamed_678);
									uint fragment_unnamed_683 = fragment_unnamed_671 ? fragment_unnamed_611 : asuint(mad((-0.0f) - fragment_unnamed_197, 2.0f, fragment_unnamed_612));
									float fragment_unnamed_684 = asfloat(fragment_unnamed_683);
									uint fragment_unnamed_690 = fragment_unnamed_672 ? fragment_unnamed_618 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_619));
									float fragment_unnamed_691 = asfloat(fragment_unnamed_690);
									uint fragment_unnamed_694 = fragment_unnamed_672 ? fragment_unnamed_622 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_623));
									float fragment_unnamed_695 = asfloat(fragment_unnamed_694);
									float fragment_unnamed_626;
									float fragment_unnamed_627;
									float fragment_unnamed_628;
									float fragment_unnamed_629;
									float fragment_unnamed_630;
									float fragment_unnamed_631;
									if (((~fragment_unnamed_674) | (~fragment_unnamed_673)) != 0u)
									{
										float fragment_unnamed_715;
										if (fragment_unnamed_673 == 0u)
										{
											fragment_unnamed_715 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_679, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_684, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
										}
										else
										{
											fragment_unnamed_715 = fragment_unnamed_662;
										}
										float fragment_unnamed_728;
										if (fragment_unnamed_674 == 0u)
										{
											fragment_unnamed_728 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_691, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_695, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
										}
										else
										{
											fragment_unnamed_728 = fragment_unnamed_668;
										}
										float fragment_unnamed_734 = asfloat(fragment_unnamed_671 ? asuint(fragment_unnamed_715) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_715)));
										float fragment_unnamed_740 = asfloat(fragment_unnamed_672 ? asuint(fragment_unnamed_728) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_728)));
										bool fragment_unnamed_743 = abs(fragment_unnamed_734) >= fragment_unnamed_244;
										bool fragment_unnamed_744 = abs(fragment_unnamed_740) >= fragment_unnamed_244;
										uint fragment_unnamed_745 = fragment_unnamed_743 ? 4294967295u : 0u;
										uint fragment_unnamed_746 = fragment_unnamed_744 ? 4294967295u : 0u;
										uint fragment_unnamed_750 = fragment_unnamed_743 ? fragment_unnamed_678 : asuint(mad((-0.0f) - fragment_unnamed_191, 2.0f, fragment_unnamed_679));
										float fragment_unnamed_751 = asfloat(fragment_unnamed_750);
										uint fragment_unnamed_755 = fragment_unnamed_743 ? fragment_unnamed_683 : asuint(mad((-0.0f) - fragment_unnamed_197, 2.0f, fragment_unnamed_684));
										float fragment_unnamed_756 = asfloat(fragment_unnamed_755);
										uint fragment_unnamed_762 = fragment_unnamed_744 ? fragment_unnamed_690 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_691));
										float fragment_unnamed_763 = asfloat(fragment_unnamed_762);
										uint fragment_unnamed_766 = fragment_unnamed_744 ? fragment_unnamed_694 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_695));
										float fragment_unnamed_767 = asfloat(fragment_unnamed_766);
										float fragment_unnamed_698;
										float fragment_unnamed_699;
										float fragment_unnamed_700;
										float fragment_unnamed_701;
										float fragment_unnamed_702;
										float fragment_unnamed_703;
										if (((~fragment_unnamed_746) | (~fragment_unnamed_745)) != 0u)
										{
											float fragment_unnamed_787;
											if (fragment_unnamed_745 == 0u)
											{
												fragment_unnamed_787 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_751, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_756, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
											}
											else
											{
												fragment_unnamed_787 = fragment_unnamed_734;
											}
											float fragment_unnamed_800;
											if (fragment_unnamed_746 == 0u)
											{
												fragment_unnamed_800 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_763, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_767, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
											}
											else
											{
												fragment_unnamed_800 = fragment_unnamed_740;
											}
											float fragment_unnamed_806 = asfloat(fragment_unnamed_743 ? asuint(fragment_unnamed_787) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_787)));
											float fragment_unnamed_812 = asfloat(fragment_unnamed_744 ? asuint(fragment_unnamed_800) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_800)));
											bool fragment_unnamed_815 = abs(fragment_unnamed_806) >= fragment_unnamed_244;
											bool fragment_unnamed_816 = abs(fragment_unnamed_812) >= fragment_unnamed_244;
											uint fragment_unnamed_817 = fragment_unnamed_815 ? 4294967295u : 0u;
											uint fragment_unnamed_818 = fragment_unnamed_816 ? 4294967295u : 0u;
											uint fragment_unnamed_822 = fragment_unnamed_815 ? fragment_unnamed_750 : asuint(mad((-0.0f) - fragment_unnamed_191, 2.0f, fragment_unnamed_751));
											float fragment_unnamed_823 = asfloat(fragment_unnamed_822);
											uint fragment_unnamed_827 = fragment_unnamed_815 ? fragment_unnamed_755 : asuint(mad((-0.0f) - fragment_unnamed_197, 2.0f, fragment_unnamed_756));
											float fragment_unnamed_828 = asfloat(fragment_unnamed_827);
											uint fragment_unnamed_834 = fragment_unnamed_816 ? fragment_unnamed_762 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_763));
											float fragment_unnamed_835 = asfloat(fragment_unnamed_834);
											uint fragment_unnamed_838 = fragment_unnamed_816 ? fragment_unnamed_766 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_767));
											float fragment_unnamed_839 = asfloat(fragment_unnamed_838);
											float fragment_unnamed_770;
											float fragment_unnamed_771;
											float fragment_unnamed_772;
											float fragment_unnamed_773;
											float fragment_unnamed_774;
											float fragment_unnamed_775;
											if (((~fragment_unnamed_818) | (~fragment_unnamed_817)) != 0u)
											{
												float fragment_unnamed_859;
												if (fragment_unnamed_817 == 0u)
												{
													fragment_unnamed_859 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_823, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_828, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
												}
												else
												{
													fragment_unnamed_859 = fragment_unnamed_806;
												}
												float fragment_unnamed_872;
												if (fragment_unnamed_818 == 0u)
												{
													fragment_unnamed_872 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_835, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_839, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
												}
												else
												{
													fragment_unnamed_872 = fragment_unnamed_812;
												}
												float fragment_unnamed_878 = asfloat(fragment_unnamed_815 ? asuint(fragment_unnamed_859) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_859)));
												float fragment_unnamed_884 = asfloat(fragment_unnamed_816 ? asuint(fragment_unnamed_872) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_872)));
												bool fragment_unnamed_887 = abs(fragment_unnamed_878) >= fragment_unnamed_244;
												bool fragment_unnamed_888 = abs(fragment_unnamed_884) >= fragment_unnamed_244;
												uint fragment_unnamed_889 = fragment_unnamed_887 ? 4294967295u : 0u;
												uint fragment_unnamed_890 = fragment_unnamed_888 ? 4294967295u : 0u;
												uint fragment_unnamed_894 = fragment_unnamed_887 ? fragment_unnamed_822 : asuint(mad((-0.0f) - fragment_unnamed_191, 2.0f, fragment_unnamed_823));
												float fragment_unnamed_895 = asfloat(fragment_unnamed_894);
												uint fragment_unnamed_899 = fragment_unnamed_887 ? fragment_unnamed_827 : asuint(mad((-0.0f) - fragment_unnamed_197, 2.0f, fragment_unnamed_828));
												float fragment_unnamed_900 = asfloat(fragment_unnamed_899);
												uint fragment_unnamed_906 = fragment_unnamed_888 ? fragment_unnamed_834 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_835));
												float fragment_unnamed_907 = asfloat(fragment_unnamed_906);
												uint fragment_unnamed_910 = fragment_unnamed_888 ? fragment_unnamed_838 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_839));
												float fragment_unnamed_911 = asfloat(fragment_unnamed_910);
												float fragment_unnamed_842;
												float fragment_unnamed_843;
												float fragment_unnamed_844;
												float fragment_unnamed_845;
												float fragment_unnamed_846;
												float fragment_unnamed_847;
												if (((~fragment_unnamed_890) | (~fragment_unnamed_889)) != 0u)
												{
													float fragment_unnamed_931;
													if (fragment_unnamed_889 == 0u)
													{
														fragment_unnamed_931 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_895, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_900, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
													}
													else
													{
														fragment_unnamed_931 = fragment_unnamed_878;
													}
													float fragment_unnamed_944;
													if (fragment_unnamed_890 == 0u)
													{
														fragment_unnamed_944 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_907, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_911, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
													}
													else
													{
														fragment_unnamed_944 = fragment_unnamed_884;
													}
													float fragment_unnamed_950 = asfloat(fragment_unnamed_887 ? asuint(fragment_unnamed_931) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_931)));
													float fragment_unnamed_956 = asfloat(fragment_unnamed_888 ? asuint(fragment_unnamed_944) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_944)));
													bool fragment_unnamed_959 = abs(fragment_unnamed_950) >= fragment_unnamed_244;
													bool fragment_unnamed_960 = abs(fragment_unnamed_956) >= fragment_unnamed_244;
													uint fragment_unnamed_961 = fragment_unnamed_959 ? 4294967295u : 0u;
													uint fragment_unnamed_962 = fragment_unnamed_960 ? 4294967295u : 0u;
													uint fragment_unnamed_967 = fragment_unnamed_959 ? fragment_unnamed_894 : asuint(mad((-0.0f) - fragment_unnamed_191, 4.0f, fragment_unnamed_895));
													float fragment_unnamed_968 = asfloat(fragment_unnamed_967);
													uint fragment_unnamed_972 = fragment_unnamed_959 ? fragment_unnamed_899 : asuint(mad((-0.0f) - fragment_unnamed_197, 4.0f, fragment_unnamed_900));
													float fragment_unnamed_973 = asfloat(fragment_unnamed_972);
													uint fragment_unnamed_979 = fragment_unnamed_960 ? fragment_unnamed_906 : asuint(mad(fragment_unnamed_191, 4.0f, fragment_unnamed_907));
													float fragment_unnamed_980 = asfloat(fragment_unnamed_979);
													uint fragment_unnamed_983 = fragment_unnamed_960 ? fragment_unnamed_910 : asuint(mad(fragment_unnamed_197, 4.0f, fragment_unnamed_911));
													float fragment_unnamed_984 = asfloat(fragment_unnamed_983);
													float fragment_unnamed_914;
													float fragment_unnamed_915;
													float fragment_unnamed_916;
													float fragment_unnamed_917;
													float fragment_unnamed_918;
													float fragment_unnamed_919;
													if (((~fragment_unnamed_962) | (~fragment_unnamed_961)) != 0u)
													{
														float fragment_unnamed_1004;
														if (fragment_unnamed_961 == 0u)
														{
															fragment_unnamed_1004 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_968, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_973, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
														}
														else
														{
															fragment_unnamed_1004 = fragment_unnamed_950;
														}
														float fragment_unnamed_1017;
														if (fragment_unnamed_962 == 0u)
														{
															fragment_unnamed_1017 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_980, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_984, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
														}
														else
														{
															fragment_unnamed_1017 = fragment_unnamed_956;
														}
														float fragment_unnamed_987 = asfloat(fragment_unnamed_959 ? asuint(fragment_unnamed_1004) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_1004)));
														float fragment_unnamed_988 = asfloat(fragment_unnamed_960 ? asuint(fragment_unnamed_1017) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_1017)));
														bool fragment_unnamed_1030 = abs(fragment_unnamed_987) >= fragment_unnamed_244;
														bool fragment_unnamed_1031 = abs(fragment_unnamed_988) >= fragment_unnamed_244;
														fragment_unnamed_914 = fragment_unnamed_987;
														fragment_unnamed_915 = fragment_unnamed_988;
														fragment_unnamed_916 = asfloat(fragment_unnamed_1030 ? fragment_unnamed_967 : asuint(mad((-0.0f) - fragment_unnamed_191, 8.0f, fragment_unnamed_968)));
														fragment_unnamed_917 = asfloat(fragment_unnamed_1031 ? fragment_unnamed_979 : asuint(mad(fragment_unnamed_191, 8.0f, fragment_unnamed_980)));
														fragment_unnamed_918 = asfloat(fragment_unnamed_1030 ? fragment_unnamed_972 : asuint(mad((-0.0f) - fragment_unnamed_197, 8.0f, fragment_unnamed_973)));
														fragment_unnamed_919 = asfloat(fragment_unnamed_1031 ? fragment_unnamed_983 : asuint(mad(fragment_unnamed_197, 8.0f, fragment_unnamed_984)));
													}
													else
													{
														fragment_unnamed_914 = fragment_unnamed_950;
														fragment_unnamed_915 = fragment_unnamed_956;
														fragment_unnamed_916 = fragment_unnamed_968;
														fragment_unnamed_917 = fragment_unnamed_980;
														fragment_unnamed_918 = fragment_unnamed_973;
														fragment_unnamed_919 = fragment_unnamed_984;
													}
													fragment_unnamed_842 = fragment_unnamed_914;
													fragment_unnamed_843 = fragment_unnamed_915;
													fragment_unnamed_844 = fragment_unnamed_916;
													fragment_unnamed_845 = fragment_unnamed_917;
													fragment_unnamed_846 = fragment_unnamed_918;
													fragment_unnamed_847 = fragment_unnamed_919;
												}
												else
												{
													fragment_unnamed_842 = fragment_unnamed_878;
													fragment_unnamed_843 = fragment_unnamed_884;
													fragment_unnamed_844 = fragment_unnamed_895;
													fragment_unnamed_845 = fragment_unnamed_907;
													fragment_unnamed_846 = fragment_unnamed_900;
													fragment_unnamed_847 = fragment_unnamed_911;
												}
												fragment_unnamed_770 = fragment_unnamed_842;
												fragment_unnamed_771 = fragment_unnamed_843;
												fragment_unnamed_772 = fragment_unnamed_844;
												fragment_unnamed_773 = fragment_unnamed_845;
												fragment_unnamed_774 = fragment_unnamed_846;
												fragment_unnamed_775 = fragment_unnamed_847;
											}
											else
											{
												fragment_unnamed_770 = fragment_unnamed_806;
												fragment_unnamed_771 = fragment_unnamed_812;
												fragment_unnamed_772 = fragment_unnamed_823;
												fragment_unnamed_773 = fragment_unnamed_835;
												fragment_unnamed_774 = fragment_unnamed_828;
												fragment_unnamed_775 = fragment_unnamed_839;
											}
											fragment_unnamed_698 = fragment_unnamed_770;
											fragment_unnamed_699 = fragment_unnamed_771;
											fragment_unnamed_700 = fragment_unnamed_772;
											fragment_unnamed_701 = fragment_unnamed_773;
											fragment_unnamed_702 = fragment_unnamed_774;
											fragment_unnamed_703 = fragment_unnamed_775;
										}
										else
										{
											fragment_unnamed_698 = fragment_unnamed_734;
											fragment_unnamed_699 = fragment_unnamed_740;
											fragment_unnamed_700 = fragment_unnamed_751;
											fragment_unnamed_701 = fragment_unnamed_763;
											fragment_unnamed_702 = fragment_unnamed_756;
											fragment_unnamed_703 = fragment_unnamed_767;
										}
										fragment_unnamed_626 = fragment_unnamed_698;
										fragment_unnamed_627 = fragment_unnamed_699;
										fragment_unnamed_628 = fragment_unnamed_700;
										fragment_unnamed_629 = fragment_unnamed_701;
										fragment_unnamed_630 = fragment_unnamed_702;
										fragment_unnamed_631 = fragment_unnamed_703;
									}
									else
									{
										fragment_unnamed_626 = fragment_unnamed_662;
										fragment_unnamed_627 = fragment_unnamed_668;
										fragment_unnamed_628 = fragment_unnamed_679;
										fragment_unnamed_629 = fragment_unnamed_691;
										fragment_unnamed_630 = fragment_unnamed_684;
										fragment_unnamed_631 = fragment_unnamed_695;
									}
									fragment_unnamed_554 = fragment_unnamed_626;
									fragment_unnamed_555 = fragment_unnamed_627;
									fragment_unnamed_556 = fragment_unnamed_628;
									fragment_unnamed_557 = fragment_unnamed_629;
									fragment_unnamed_558 = fragment_unnamed_630;
									fragment_unnamed_559 = fragment_unnamed_631;
								}
								else
								{
									fragment_unnamed_554 = fragment_unnamed_590;
									fragment_unnamed_555 = fragment_unnamed_596;
									fragment_unnamed_556 = fragment_unnamed_607;
									fragment_unnamed_557 = fragment_unnamed_619;
									fragment_unnamed_558 = fragment_unnamed_612;
									fragment_unnamed_559 = fragment_unnamed_623;
								}
								fragment_unnamed_482 = fragment_unnamed_554;
								fragment_unnamed_483 = fragment_unnamed_555;
								fragment_unnamed_484 = fragment_unnamed_556;
								fragment_unnamed_485 = fragment_unnamed_557;
								fragment_unnamed_486 = fragment_unnamed_558;
								fragment_unnamed_487 = fragment_unnamed_559;
							}
							else
							{
								fragment_unnamed_482 = fragment_unnamed_518;
								fragment_unnamed_483 = fragment_unnamed_524;
								fragment_unnamed_484 = fragment_unnamed_535;
								fragment_unnamed_485 = fragment_unnamed_547;
								fragment_unnamed_486 = fragment_unnamed_540;
								fragment_unnamed_487 = fragment_unnamed_551;
							}
							fragment_unnamed_339 = fragment_unnamed_482;
							fragment_unnamed_341 = fragment_unnamed_483;
							fragment_unnamed_343 = fragment_unnamed_484;
							fragment_unnamed_345 = fragment_unnamed_485;
							fragment_unnamed_347 = fragment_unnamed_486;
							fragment_unnamed_349 = fragment_unnamed_487;
						}
						else
						{
							fragment_unnamed_339 = fragment_unnamed_446;
							fragment_unnamed_341 = fragment_unnamed_452;
							fragment_unnamed_343 = fragment_unnamed_463;
							fragment_unnamed_345 = fragment_unnamed_475;
							fragment_unnamed_347 = fragment_unnamed_468;
							fragment_unnamed_349 = fragment_unnamed_479;
						}
						fragment_unnamed_338 = fragment_unnamed_339;
						fragment_unnamed_340 = fragment_unnamed_341;
						fragment_unnamed_342 = fragment_unnamed_343;
						fragment_unnamed_344 = fragment_unnamed_345;
						fragment_unnamed_346 = fragment_unnamed_347;
						fragment_unnamed_348 = fragment_unnamed_349;
					}
					else
					{
						fragment_unnamed_338 = fragment_unnamed_252;
						fragment_unnamed_340 = fragment_unnamed_254;
						fragment_unnamed_342 = fragment_unnamed_267;
						fragment_unnamed_344 = fragment_unnamed_281;
						fragment_unnamed_346 = fragment_unnamed_273;
						fragment_unnamed_348 = fragment_unnamed_286;
					}
					float fragment_unnamed_361 = asfloat(fragment_unnamed_142 ? asuint(((-0.0f) - fragment_unnamed_342) + fragment_input_1.x) : asuint(((-0.0f) - fragment_unnamed_346) + fragment_input_1.y));
					float fragment_unnamed_373 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_344 + ((-0.0f) - fragment_input_1.x)) : asuint(fragment_unnamed_348 + ((-0.0f) - fragment_input_1.y)));
					float fragment_unnamed_393 = max(fragment_unnamed_248 * fragment_unnamed_248, asfloat(asuint(mad(min(fragment_unnamed_361, fragment_unnamed_373), (-0.0f) - (1.0f / (fragment_unnamed_361 + fragment_unnamed_373)), 0.5f)) & ((fragment_unnamed_361 < fragment_unnamed_373) ? ((fragment_unnamed_250 != ((fragment_unnamed_338 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_250 != ((fragment_unnamed_340 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					float4 fragment_unnamed_414 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_393, fragment_unnamed_182, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_142 ? mad(fragment_unnamed_393, fragment_unnamed_182, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f);
					fragment_unnamed_288 = fragment_unnamed_414.x;
					fragment_unnamed_290 = fragment_unnamed_414.y;
					fragment_unnamed_292 = fragment_unnamed_414.z;
				}
				else
				{
					fragment_unnamed_288 = fragment_unnamed_54.x;
					fragment_unnamed_290 = fragment_unnamed_54.y;
					fragment_unnamed_292 = fragment_unnamed_54.z;
				}
				float fragment_unnamed_313 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				float fragment_unnamed_325 = (((-0.0f) - sqrt(((-0.0f) - abs(fragment_unnamed_313)) + 1.0f)) + 1.0f) * mad(clamp(mad(fragment_unnamed_313, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_288);
				fragment_output_0.y = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_290);
				fragment_output_0.z = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_292);
				fragment_output_0.w = fragment_unnamed_59;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[29] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA_LOW)


			#if defined(FXAA) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float _DepthSlice;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
			static float4 gl_Position;
			static uint gl_Layer;
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
				uint gl_Layer : SV_RenderTargetArrayIndex;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				float vertex_unnamed_59 = mad((vertex_input_0.x + 1.0f) * vertex_uniform_buffer_0[27u].x, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_61 = mad((vertex_input_0.y + 1.0f) * vertex_uniform_buffer_0[27u].y, 0.5f, vertex_uniform_buffer_0[27u].w);
				vertex_output_1.x = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = vertex_unnamed_61 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_59;
				vertex_output_1.y = vertex_unnamed_61;
				gl_Layer = int(uint(vertex_uniform_buffer_0[26u].y));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[26] = float4(vertex_uniform_buffer_0[26][0], _DepthSlice, vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.gl_Layer = gl_Layer;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_52 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float fragment_unnamed_53 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_56 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f);
				float fragment_unnamed_61 = fragment_unnamed_56.w;
				float4 fragment_unnamed_65 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(0, 1));
				float fragment_unnamed_69 = fragment_unnamed_65.w;
				float4 fragment_unnamed_70 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, 0));
				float fragment_unnamed_73 = fragment_unnamed_70.w;
				float4 fragment_unnamed_75 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(0, -1));
				float fragment_unnamed_78 = fragment_unnamed_75.w;
				float4 fragment_unnamed_79 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, 0));
				float fragment_unnamed_82 = fragment_unnamed_79.w;
				float fragment_unnamed_89 = max(max(fragment_unnamed_73, max(fragment_unnamed_61, fragment_unnamed_69)), max(fragment_unnamed_82, fragment_unnamed_78));
				float fragment_unnamed_95 = ((-0.0f) - min(min(fragment_unnamed_73, min(fragment_unnamed_61, fragment_unnamed_69)), min(fragment_unnamed_82, fragment_unnamed_78))) + fragment_unnamed_89;
				float fragment_unnamed_290;
				float fragment_unnamed_292;
				float fragment_unnamed_294;
				if (fragment_unnamed_95 >= max(fragment_unnamed_89 * 0.063000001013278961181640625f, 0.031199999153614044189453125f))
				{
					float4 fragment_unnamed_101 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, -1));
					float fragment_unnamed_104 = fragment_unnamed_101.w;
					float4 fragment_unnamed_105 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, 1));
					float fragment_unnamed_108 = fragment_unnamed_105.w;
					float4 fragment_unnamed_109 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, -1));
					float fragment_unnamed_112 = fragment_unnamed_109.w;
					float4 fragment_unnamed_113 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, 1));
					float fragment_unnamed_116 = fragment_unnamed_113.w;
					float fragment_unnamed_117 = fragment_unnamed_69 + fragment_unnamed_78;
					float fragment_unnamed_118 = fragment_unnamed_73 + fragment_unnamed_82;
					float fragment_unnamed_124 = fragment_unnamed_108 + fragment_unnamed_112;
					float fragment_unnamed_128 = fragment_unnamed_116 + fragment_unnamed_104;
					bool fragment_unnamed_144 = (mad(abs(mad(fragment_unnamed_61, -2.0f, fragment_unnamed_117)), 2.0f, abs(mad(fragment_unnamed_73, -2.0f, fragment_unnamed_124))) + abs(mad(fragment_unnamed_82, -2.0f, fragment_unnamed_128))) >= (mad(abs(mad(fragment_unnamed_61, -2.0f, fragment_unnamed_118)), 2.0f, abs(mad(fragment_unnamed_78, -2.0f, fragment_unnamed_104 + fragment_unnamed_112))) + abs(mad(fragment_unnamed_69, -2.0f, fragment_unnamed_108 + fragment_unnamed_116)));
					float fragment_unnamed_151 = asfloat(fragment_unnamed_144 ? asuint(fragment_unnamed_78) : asuint(fragment_unnamed_82));
					float fragment_unnamed_155 = asfloat(fragment_unnamed_144 ? asuint(fragment_unnamed_69) : asuint(fragment_unnamed_73));
					float fragment_unnamed_167 = asfloat(fragment_unnamed_144 ? asuint(fragment_uniform_buffer_0[29u]).y : asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_172 = ((-0.0f) - fragment_unnamed_61) + fragment_unnamed_151;
					float fragment_unnamed_174 = ((-0.0f) - fragment_unnamed_61) + fragment_unnamed_155;
					bool fragment_unnamed_179 = abs(fragment_unnamed_172) >= abs(fragment_unnamed_174);
					float fragment_unnamed_184 = fragment_unnamed_179 ? ((-0.0f) - fragment_unnamed_167) : fragment_unnamed_167;
					float fragment_unnamed_187 = clamp((1.0f / fragment_unnamed_95) * abs(mad(mad(fragment_unnamed_117 + fragment_unnamed_118, 2.0f, fragment_unnamed_124 + fragment_unnamed_128), 0.083333335816860198974609375f, (-0.0f) - fragment_unnamed_61)), 0.0f, 1.0f);
					float fragment_unnamed_193 = asfloat((fragment_unnamed_144 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_199 = asfloat(fragment_unnamed_144 ? 0u : asuint(fragment_uniform_buffer_0[29u]).y);
					float fragment_unnamed_209 = fragment_unnamed_144 ? fragment_input_1.x : mad(fragment_unnamed_184, 0.5f, fragment_input_1.x);
					float fragment_unnamed_212 = fragment_unnamed_144 ? mad(fragment_unnamed_184, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					float fragment_unnamed_215 = ((-0.0f) - fragment_unnamed_193) + fragment_unnamed_209;
					float fragment_unnamed_216 = ((-0.0f) - fragment_unnamed_199) + fragment_unnamed_212;
					float fragment_unnamed_217 = fragment_unnamed_193 + fragment_unnamed_209;
					float fragment_unnamed_218 = fragment_unnamed_199 + fragment_unnamed_212;
					float fragment_unnamed_245 = asfloat(fragment_unnamed_179 ? asuint(fragment_unnamed_61 + fragment_unnamed_151) : asuint(fragment_unnamed_61 + fragment_unnamed_155));
					float fragment_unnamed_246 = max(abs(fragment_unnamed_174), abs(fragment_unnamed_172)) * 0.25f;
					float fragment_unnamed_250 = (fragment_unnamed_187 * fragment_unnamed_187) * mad(fragment_unnamed_187, -2.0f, 3.0f);
					uint fragment_unnamed_252 = (mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_61) < 0.0f) ? 4294967295u : 0u;
					float fragment_unnamed_254 = mad((-0.0f) - fragment_unnamed_245, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_215, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_216, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w);
					float fragment_unnamed_256 = mad((-0.0f) - fragment_unnamed_245, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_217, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_218, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w);
					bool fragment_unnamed_259 = abs(fragment_unnamed_254) >= fragment_unnamed_246;
					bool fragment_unnamed_260 = abs(fragment_unnamed_256) >= fragment_unnamed_246;
					uint fragment_unnamed_261 = fragment_unnamed_259 ? 4294967295u : 0u;
					uint fragment_unnamed_262 = fragment_unnamed_260 ? 4294967295u : 0u;
					uint fragment_unnamed_268 = fragment_unnamed_259 ? asuint(fragment_unnamed_215) : asuint(mad((-0.0f) - fragment_unnamed_193, 1.5f, fragment_unnamed_215));
					float fragment_unnamed_269 = asfloat(fragment_unnamed_268);
					uint fragment_unnamed_274 = fragment_unnamed_259 ? asuint(fragment_unnamed_216) : asuint(mad((-0.0f) - fragment_unnamed_199, 1.5f, fragment_unnamed_216));
					float fragment_unnamed_275 = asfloat(fragment_unnamed_274);
					uint fragment_unnamed_282 = fragment_unnamed_260 ? asuint(fragment_unnamed_217) : asuint(mad(fragment_unnamed_193, 1.5f, fragment_unnamed_217));
					float fragment_unnamed_283 = asfloat(fragment_unnamed_282);
					uint fragment_unnamed_287 = fragment_unnamed_260 ? asuint(fragment_unnamed_218) : asuint(mad(fragment_unnamed_199, 1.5f, fragment_unnamed_218));
					float fragment_unnamed_288 = asfloat(fragment_unnamed_287);
					float fragment_unnamed_340;
					float fragment_unnamed_342;
					float fragment_unnamed_344;
					float fragment_unnamed_346;
					float fragment_unnamed_348;
					float fragment_unnamed_350;
					if (((~fragment_unnamed_262) | (~fragment_unnamed_261)) != 0u)
					{
						float fragment_unnamed_429;
						if (fragment_unnamed_261 == 0u)
						{
							fragment_unnamed_429 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_269, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_275, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
						}
						else
						{
							fragment_unnamed_429 = fragment_unnamed_254;
						}
						float fragment_unnamed_442;
						if (fragment_unnamed_262 == 0u)
						{
							fragment_unnamed_442 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_283, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_288, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
						}
						else
						{
							fragment_unnamed_442 = fragment_unnamed_256;
						}
						float fragment_unnamed_448 = asfloat(fragment_unnamed_259 ? asuint(fragment_unnamed_429) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_429)));
						float fragment_unnamed_454 = asfloat(fragment_unnamed_260 ? asuint(fragment_unnamed_442) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_442)));
						bool fragment_unnamed_457 = abs(fragment_unnamed_448) >= fragment_unnamed_246;
						bool fragment_unnamed_458 = abs(fragment_unnamed_454) >= fragment_unnamed_246;
						uint fragment_unnamed_459 = fragment_unnamed_457 ? 4294967295u : 0u;
						uint fragment_unnamed_460 = fragment_unnamed_458 ? 4294967295u : 0u;
						uint fragment_unnamed_464 = fragment_unnamed_457 ? fragment_unnamed_268 : asuint(mad((-0.0f) - fragment_unnamed_193, 2.0f, fragment_unnamed_269));
						float fragment_unnamed_465 = asfloat(fragment_unnamed_464);
						uint fragment_unnamed_469 = fragment_unnamed_457 ? fragment_unnamed_274 : asuint(mad((-0.0f) - fragment_unnamed_199, 2.0f, fragment_unnamed_275));
						float fragment_unnamed_470 = asfloat(fragment_unnamed_469);
						uint fragment_unnamed_476 = fragment_unnamed_458 ? fragment_unnamed_282 : asuint(mad(fragment_unnamed_193, 2.0f, fragment_unnamed_283));
						float fragment_unnamed_477 = asfloat(fragment_unnamed_476);
						uint fragment_unnamed_480 = fragment_unnamed_458 ? fragment_unnamed_287 : asuint(mad(fragment_unnamed_199, 2.0f, fragment_unnamed_288));
						float fragment_unnamed_481 = asfloat(fragment_unnamed_480);
						float fragment_unnamed_341;
						float fragment_unnamed_343;
						float fragment_unnamed_345;
						float fragment_unnamed_347;
						float fragment_unnamed_349;
						float fragment_unnamed_351;
						if (((~fragment_unnamed_460) | (~fragment_unnamed_459)) != 0u)
						{
							float fragment_unnamed_501;
							if (fragment_unnamed_459 == 0u)
							{
								fragment_unnamed_501 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_465, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_470, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
							}
							else
							{
								fragment_unnamed_501 = fragment_unnamed_448;
							}
							float fragment_unnamed_514;
							if (fragment_unnamed_460 == 0u)
							{
								fragment_unnamed_514 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_477, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_481, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
							}
							else
							{
								fragment_unnamed_514 = fragment_unnamed_454;
							}
							float fragment_unnamed_520 = asfloat(fragment_unnamed_457 ? asuint(fragment_unnamed_501) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_501)));
							float fragment_unnamed_526 = asfloat(fragment_unnamed_458 ? asuint(fragment_unnamed_514) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_514)));
							bool fragment_unnamed_529 = abs(fragment_unnamed_520) >= fragment_unnamed_246;
							bool fragment_unnamed_530 = abs(fragment_unnamed_526) >= fragment_unnamed_246;
							uint fragment_unnamed_531 = fragment_unnamed_529 ? 4294967295u : 0u;
							uint fragment_unnamed_532 = fragment_unnamed_530 ? 4294967295u : 0u;
							uint fragment_unnamed_536 = fragment_unnamed_529 ? fragment_unnamed_464 : asuint(mad((-0.0f) - fragment_unnamed_193, 2.0f, fragment_unnamed_465));
							float fragment_unnamed_537 = asfloat(fragment_unnamed_536);
							uint fragment_unnamed_541 = fragment_unnamed_529 ? fragment_unnamed_469 : asuint(mad((-0.0f) - fragment_unnamed_199, 2.0f, fragment_unnamed_470));
							float fragment_unnamed_542 = asfloat(fragment_unnamed_541);
							uint fragment_unnamed_548 = fragment_unnamed_530 ? fragment_unnamed_476 : asuint(mad(fragment_unnamed_193, 2.0f, fragment_unnamed_477));
							float fragment_unnamed_549 = asfloat(fragment_unnamed_548);
							uint fragment_unnamed_552 = fragment_unnamed_530 ? fragment_unnamed_480 : asuint(mad(fragment_unnamed_199, 2.0f, fragment_unnamed_481));
							float fragment_unnamed_553 = asfloat(fragment_unnamed_552);
							float fragment_unnamed_484;
							float fragment_unnamed_485;
							float fragment_unnamed_486;
							float fragment_unnamed_487;
							float fragment_unnamed_488;
							float fragment_unnamed_489;
							if (((~fragment_unnamed_532) | (~fragment_unnamed_531)) != 0u)
							{
								float fragment_unnamed_573;
								if (fragment_unnamed_531 == 0u)
								{
									fragment_unnamed_573 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_537, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_542, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
								}
								else
								{
									fragment_unnamed_573 = fragment_unnamed_520;
								}
								float fragment_unnamed_586;
								if (fragment_unnamed_532 == 0u)
								{
									fragment_unnamed_586 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_549, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_553, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
								}
								else
								{
									fragment_unnamed_586 = fragment_unnamed_526;
								}
								float fragment_unnamed_592 = asfloat(fragment_unnamed_529 ? asuint(fragment_unnamed_573) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_573)));
								float fragment_unnamed_598 = asfloat(fragment_unnamed_530 ? asuint(fragment_unnamed_586) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_586)));
								bool fragment_unnamed_601 = abs(fragment_unnamed_592) >= fragment_unnamed_246;
								bool fragment_unnamed_602 = abs(fragment_unnamed_598) >= fragment_unnamed_246;
								uint fragment_unnamed_603 = fragment_unnamed_601 ? 4294967295u : 0u;
								uint fragment_unnamed_604 = fragment_unnamed_602 ? 4294967295u : 0u;
								uint fragment_unnamed_608 = fragment_unnamed_601 ? fragment_unnamed_536 : asuint(mad((-0.0f) - fragment_unnamed_193, 2.0f, fragment_unnamed_537));
								float fragment_unnamed_609 = asfloat(fragment_unnamed_608);
								uint fragment_unnamed_613 = fragment_unnamed_601 ? fragment_unnamed_541 : asuint(mad((-0.0f) - fragment_unnamed_199, 2.0f, fragment_unnamed_542));
								float fragment_unnamed_614 = asfloat(fragment_unnamed_613);
								uint fragment_unnamed_620 = fragment_unnamed_602 ? fragment_unnamed_548 : asuint(mad(fragment_unnamed_193, 2.0f, fragment_unnamed_549));
								float fragment_unnamed_621 = asfloat(fragment_unnamed_620);
								uint fragment_unnamed_624 = fragment_unnamed_602 ? fragment_unnamed_552 : asuint(mad(fragment_unnamed_199, 2.0f, fragment_unnamed_553));
								float fragment_unnamed_625 = asfloat(fragment_unnamed_624);
								float fragment_unnamed_556;
								float fragment_unnamed_557;
								float fragment_unnamed_558;
								float fragment_unnamed_559;
								float fragment_unnamed_560;
								float fragment_unnamed_561;
								if (((~fragment_unnamed_604) | (~fragment_unnamed_603)) != 0u)
								{
									float fragment_unnamed_645;
									if (fragment_unnamed_603 == 0u)
									{
										fragment_unnamed_645 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_609, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_614, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
									}
									else
									{
										fragment_unnamed_645 = fragment_unnamed_592;
									}
									float fragment_unnamed_658;
									if (fragment_unnamed_604 == 0u)
									{
										fragment_unnamed_658 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_621, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_625, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
									}
									else
									{
										fragment_unnamed_658 = fragment_unnamed_598;
									}
									float fragment_unnamed_664 = asfloat(fragment_unnamed_601 ? asuint(fragment_unnamed_645) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_645)));
									float fragment_unnamed_670 = asfloat(fragment_unnamed_602 ? asuint(fragment_unnamed_658) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_658)));
									bool fragment_unnamed_673 = abs(fragment_unnamed_664) >= fragment_unnamed_246;
									bool fragment_unnamed_674 = abs(fragment_unnamed_670) >= fragment_unnamed_246;
									uint fragment_unnamed_675 = fragment_unnamed_673 ? 4294967295u : 0u;
									uint fragment_unnamed_676 = fragment_unnamed_674 ? 4294967295u : 0u;
									uint fragment_unnamed_680 = fragment_unnamed_673 ? fragment_unnamed_608 : asuint(mad((-0.0f) - fragment_unnamed_193, 2.0f, fragment_unnamed_609));
									float fragment_unnamed_681 = asfloat(fragment_unnamed_680);
									uint fragment_unnamed_685 = fragment_unnamed_673 ? fragment_unnamed_613 : asuint(mad((-0.0f) - fragment_unnamed_199, 2.0f, fragment_unnamed_614));
									float fragment_unnamed_686 = asfloat(fragment_unnamed_685);
									uint fragment_unnamed_692 = fragment_unnamed_674 ? fragment_unnamed_620 : asuint(mad(fragment_unnamed_193, 2.0f, fragment_unnamed_621));
									float fragment_unnamed_693 = asfloat(fragment_unnamed_692);
									uint fragment_unnamed_696 = fragment_unnamed_674 ? fragment_unnamed_624 : asuint(mad(fragment_unnamed_199, 2.0f, fragment_unnamed_625));
									float fragment_unnamed_697 = asfloat(fragment_unnamed_696);
									float fragment_unnamed_628;
									float fragment_unnamed_629;
									float fragment_unnamed_630;
									float fragment_unnamed_631;
									float fragment_unnamed_632;
									float fragment_unnamed_633;
									if (((~fragment_unnamed_676) | (~fragment_unnamed_675)) != 0u)
									{
										float fragment_unnamed_717;
										if (fragment_unnamed_675 == 0u)
										{
											fragment_unnamed_717 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_681, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_686, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
										}
										else
										{
											fragment_unnamed_717 = fragment_unnamed_664;
										}
										float fragment_unnamed_730;
										if (fragment_unnamed_676 == 0u)
										{
											fragment_unnamed_730 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_693, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_697, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
										}
										else
										{
											fragment_unnamed_730 = fragment_unnamed_670;
										}
										float fragment_unnamed_736 = asfloat(fragment_unnamed_673 ? asuint(fragment_unnamed_717) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_717)));
										float fragment_unnamed_742 = asfloat(fragment_unnamed_674 ? asuint(fragment_unnamed_730) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_730)));
										bool fragment_unnamed_745 = abs(fragment_unnamed_736) >= fragment_unnamed_246;
										bool fragment_unnamed_746 = abs(fragment_unnamed_742) >= fragment_unnamed_246;
										uint fragment_unnamed_747 = fragment_unnamed_745 ? 4294967295u : 0u;
										uint fragment_unnamed_748 = fragment_unnamed_746 ? 4294967295u : 0u;
										uint fragment_unnamed_752 = fragment_unnamed_745 ? fragment_unnamed_680 : asuint(mad((-0.0f) - fragment_unnamed_193, 2.0f, fragment_unnamed_681));
										float fragment_unnamed_753 = asfloat(fragment_unnamed_752);
										uint fragment_unnamed_757 = fragment_unnamed_745 ? fragment_unnamed_685 : asuint(mad((-0.0f) - fragment_unnamed_199, 2.0f, fragment_unnamed_686));
										float fragment_unnamed_758 = asfloat(fragment_unnamed_757);
										uint fragment_unnamed_764 = fragment_unnamed_746 ? fragment_unnamed_692 : asuint(mad(fragment_unnamed_193, 2.0f, fragment_unnamed_693));
										float fragment_unnamed_765 = asfloat(fragment_unnamed_764);
										uint fragment_unnamed_768 = fragment_unnamed_746 ? fragment_unnamed_696 : asuint(mad(fragment_unnamed_199, 2.0f, fragment_unnamed_697));
										float fragment_unnamed_769 = asfloat(fragment_unnamed_768);
										float fragment_unnamed_700;
										float fragment_unnamed_701;
										float fragment_unnamed_702;
										float fragment_unnamed_703;
										float fragment_unnamed_704;
										float fragment_unnamed_705;
										if (((~fragment_unnamed_748) | (~fragment_unnamed_747)) != 0u)
										{
											float fragment_unnamed_789;
											if (fragment_unnamed_747 == 0u)
											{
												fragment_unnamed_789 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_753, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_758, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
											}
											else
											{
												fragment_unnamed_789 = fragment_unnamed_736;
											}
											float fragment_unnamed_802;
											if (fragment_unnamed_748 == 0u)
											{
												fragment_unnamed_802 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_765, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_769, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
											}
											else
											{
												fragment_unnamed_802 = fragment_unnamed_742;
											}
											float fragment_unnamed_808 = asfloat(fragment_unnamed_745 ? asuint(fragment_unnamed_789) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_789)));
											float fragment_unnamed_814 = asfloat(fragment_unnamed_746 ? asuint(fragment_unnamed_802) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_802)));
											bool fragment_unnamed_817 = abs(fragment_unnamed_808) >= fragment_unnamed_246;
											bool fragment_unnamed_818 = abs(fragment_unnamed_814) >= fragment_unnamed_246;
											uint fragment_unnamed_819 = fragment_unnamed_817 ? 4294967295u : 0u;
											uint fragment_unnamed_820 = fragment_unnamed_818 ? 4294967295u : 0u;
											uint fragment_unnamed_824 = fragment_unnamed_817 ? fragment_unnamed_752 : asuint(mad((-0.0f) - fragment_unnamed_193, 2.0f, fragment_unnamed_753));
											float fragment_unnamed_825 = asfloat(fragment_unnamed_824);
											uint fragment_unnamed_829 = fragment_unnamed_817 ? fragment_unnamed_757 : asuint(mad((-0.0f) - fragment_unnamed_199, 2.0f, fragment_unnamed_758));
											float fragment_unnamed_830 = asfloat(fragment_unnamed_829);
											uint fragment_unnamed_836 = fragment_unnamed_818 ? fragment_unnamed_764 : asuint(mad(fragment_unnamed_193, 2.0f, fragment_unnamed_765));
											float fragment_unnamed_837 = asfloat(fragment_unnamed_836);
											uint fragment_unnamed_840 = fragment_unnamed_818 ? fragment_unnamed_768 : asuint(mad(fragment_unnamed_199, 2.0f, fragment_unnamed_769));
											float fragment_unnamed_841 = asfloat(fragment_unnamed_840);
											float fragment_unnamed_772;
											float fragment_unnamed_773;
											float fragment_unnamed_774;
											float fragment_unnamed_775;
											float fragment_unnamed_776;
											float fragment_unnamed_777;
											if (((~fragment_unnamed_820) | (~fragment_unnamed_819)) != 0u)
											{
												float fragment_unnamed_861;
												if (fragment_unnamed_819 == 0u)
												{
													fragment_unnamed_861 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_825, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_830, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
												}
												else
												{
													fragment_unnamed_861 = fragment_unnamed_808;
												}
												float fragment_unnamed_874;
												if (fragment_unnamed_820 == 0u)
												{
													fragment_unnamed_874 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_837, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_841, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
												}
												else
												{
													fragment_unnamed_874 = fragment_unnamed_814;
												}
												float fragment_unnamed_880 = asfloat(fragment_unnamed_817 ? asuint(fragment_unnamed_861) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_861)));
												float fragment_unnamed_886 = asfloat(fragment_unnamed_818 ? asuint(fragment_unnamed_874) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_874)));
												bool fragment_unnamed_889 = abs(fragment_unnamed_880) >= fragment_unnamed_246;
												bool fragment_unnamed_890 = abs(fragment_unnamed_886) >= fragment_unnamed_246;
												uint fragment_unnamed_891 = fragment_unnamed_889 ? 4294967295u : 0u;
												uint fragment_unnamed_892 = fragment_unnamed_890 ? 4294967295u : 0u;
												uint fragment_unnamed_896 = fragment_unnamed_889 ? fragment_unnamed_824 : asuint(mad((-0.0f) - fragment_unnamed_193, 2.0f, fragment_unnamed_825));
												float fragment_unnamed_897 = asfloat(fragment_unnamed_896);
												uint fragment_unnamed_901 = fragment_unnamed_889 ? fragment_unnamed_829 : asuint(mad((-0.0f) - fragment_unnamed_199, 2.0f, fragment_unnamed_830));
												float fragment_unnamed_902 = asfloat(fragment_unnamed_901);
												uint fragment_unnamed_908 = fragment_unnamed_890 ? fragment_unnamed_836 : asuint(mad(fragment_unnamed_193, 2.0f, fragment_unnamed_837));
												float fragment_unnamed_909 = asfloat(fragment_unnamed_908);
												uint fragment_unnamed_912 = fragment_unnamed_890 ? fragment_unnamed_840 : asuint(mad(fragment_unnamed_199, 2.0f, fragment_unnamed_841));
												float fragment_unnamed_913 = asfloat(fragment_unnamed_912);
												float fragment_unnamed_844;
												float fragment_unnamed_845;
												float fragment_unnamed_846;
												float fragment_unnamed_847;
												float fragment_unnamed_848;
												float fragment_unnamed_849;
												if (((~fragment_unnamed_892) | (~fragment_unnamed_891)) != 0u)
												{
													float fragment_unnamed_933;
													if (fragment_unnamed_891 == 0u)
													{
														fragment_unnamed_933 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_897, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_902, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
													}
													else
													{
														fragment_unnamed_933 = fragment_unnamed_880;
													}
													float fragment_unnamed_946;
													if (fragment_unnamed_892 == 0u)
													{
														fragment_unnamed_946 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_909, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_913, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
													}
													else
													{
														fragment_unnamed_946 = fragment_unnamed_886;
													}
													float fragment_unnamed_952 = asfloat(fragment_unnamed_889 ? asuint(fragment_unnamed_933) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_933)));
													float fragment_unnamed_958 = asfloat(fragment_unnamed_890 ? asuint(fragment_unnamed_946) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_946)));
													bool fragment_unnamed_961 = abs(fragment_unnamed_952) >= fragment_unnamed_246;
													bool fragment_unnamed_962 = abs(fragment_unnamed_958) >= fragment_unnamed_246;
													uint fragment_unnamed_963 = fragment_unnamed_961 ? 4294967295u : 0u;
													uint fragment_unnamed_964 = fragment_unnamed_962 ? 4294967295u : 0u;
													uint fragment_unnamed_969 = fragment_unnamed_961 ? fragment_unnamed_896 : asuint(mad((-0.0f) - fragment_unnamed_193, 4.0f, fragment_unnamed_897));
													float fragment_unnamed_970 = asfloat(fragment_unnamed_969);
													uint fragment_unnamed_974 = fragment_unnamed_961 ? fragment_unnamed_901 : asuint(mad((-0.0f) - fragment_unnamed_199, 4.0f, fragment_unnamed_902));
													float fragment_unnamed_975 = asfloat(fragment_unnamed_974);
													uint fragment_unnamed_981 = fragment_unnamed_962 ? fragment_unnamed_908 : asuint(mad(fragment_unnamed_193, 4.0f, fragment_unnamed_909));
													float fragment_unnamed_982 = asfloat(fragment_unnamed_981);
													uint fragment_unnamed_985 = fragment_unnamed_962 ? fragment_unnamed_912 : asuint(mad(fragment_unnamed_199, 4.0f, fragment_unnamed_913));
													float fragment_unnamed_986 = asfloat(fragment_unnamed_985);
													float fragment_unnamed_916;
													float fragment_unnamed_917;
													float fragment_unnamed_918;
													float fragment_unnamed_919;
													float fragment_unnamed_920;
													float fragment_unnamed_921;
													if (((~fragment_unnamed_964) | (~fragment_unnamed_963)) != 0u)
													{
														float fragment_unnamed_1006;
														if (fragment_unnamed_963 == 0u)
														{
															fragment_unnamed_1006 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_970, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_975, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
														}
														else
														{
															fragment_unnamed_1006 = fragment_unnamed_952;
														}
														float fragment_unnamed_1019;
														if (fragment_unnamed_964 == 0u)
														{
															fragment_unnamed_1019 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_982, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_986, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
														}
														else
														{
															fragment_unnamed_1019 = fragment_unnamed_958;
														}
														float fragment_unnamed_989 = asfloat(fragment_unnamed_961 ? asuint(fragment_unnamed_1006) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_1006)));
														float fragment_unnamed_990 = asfloat(fragment_unnamed_962 ? asuint(fragment_unnamed_1019) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_1019)));
														bool fragment_unnamed_1032 = abs(fragment_unnamed_989) >= fragment_unnamed_246;
														bool fragment_unnamed_1033 = abs(fragment_unnamed_990) >= fragment_unnamed_246;
														fragment_unnamed_916 = fragment_unnamed_989;
														fragment_unnamed_917 = fragment_unnamed_990;
														fragment_unnamed_918 = asfloat(fragment_unnamed_1032 ? fragment_unnamed_969 : asuint(mad((-0.0f) - fragment_unnamed_193, 8.0f, fragment_unnamed_970)));
														fragment_unnamed_919 = asfloat(fragment_unnamed_1033 ? fragment_unnamed_981 : asuint(mad(fragment_unnamed_193, 8.0f, fragment_unnamed_982)));
														fragment_unnamed_920 = asfloat(fragment_unnamed_1032 ? fragment_unnamed_974 : asuint(mad((-0.0f) - fragment_unnamed_199, 8.0f, fragment_unnamed_975)));
														fragment_unnamed_921 = asfloat(fragment_unnamed_1033 ? fragment_unnamed_985 : asuint(mad(fragment_unnamed_199, 8.0f, fragment_unnamed_986)));
													}
													else
													{
														fragment_unnamed_916 = fragment_unnamed_952;
														fragment_unnamed_917 = fragment_unnamed_958;
														fragment_unnamed_918 = fragment_unnamed_970;
														fragment_unnamed_919 = fragment_unnamed_982;
														fragment_unnamed_920 = fragment_unnamed_975;
														fragment_unnamed_921 = fragment_unnamed_986;
													}
													fragment_unnamed_844 = fragment_unnamed_916;
													fragment_unnamed_845 = fragment_unnamed_917;
													fragment_unnamed_846 = fragment_unnamed_918;
													fragment_unnamed_847 = fragment_unnamed_919;
													fragment_unnamed_848 = fragment_unnamed_920;
													fragment_unnamed_849 = fragment_unnamed_921;
												}
												else
												{
													fragment_unnamed_844 = fragment_unnamed_880;
													fragment_unnamed_845 = fragment_unnamed_886;
													fragment_unnamed_846 = fragment_unnamed_897;
													fragment_unnamed_847 = fragment_unnamed_909;
													fragment_unnamed_848 = fragment_unnamed_902;
													fragment_unnamed_849 = fragment_unnamed_913;
												}
												fragment_unnamed_772 = fragment_unnamed_844;
												fragment_unnamed_773 = fragment_unnamed_845;
												fragment_unnamed_774 = fragment_unnamed_846;
												fragment_unnamed_775 = fragment_unnamed_847;
												fragment_unnamed_776 = fragment_unnamed_848;
												fragment_unnamed_777 = fragment_unnamed_849;
											}
											else
											{
												fragment_unnamed_772 = fragment_unnamed_808;
												fragment_unnamed_773 = fragment_unnamed_814;
												fragment_unnamed_774 = fragment_unnamed_825;
												fragment_unnamed_775 = fragment_unnamed_837;
												fragment_unnamed_776 = fragment_unnamed_830;
												fragment_unnamed_777 = fragment_unnamed_841;
											}
											fragment_unnamed_700 = fragment_unnamed_772;
											fragment_unnamed_701 = fragment_unnamed_773;
											fragment_unnamed_702 = fragment_unnamed_774;
											fragment_unnamed_703 = fragment_unnamed_775;
											fragment_unnamed_704 = fragment_unnamed_776;
											fragment_unnamed_705 = fragment_unnamed_777;
										}
										else
										{
											fragment_unnamed_700 = fragment_unnamed_736;
											fragment_unnamed_701 = fragment_unnamed_742;
											fragment_unnamed_702 = fragment_unnamed_753;
											fragment_unnamed_703 = fragment_unnamed_765;
											fragment_unnamed_704 = fragment_unnamed_758;
											fragment_unnamed_705 = fragment_unnamed_769;
										}
										fragment_unnamed_628 = fragment_unnamed_700;
										fragment_unnamed_629 = fragment_unnamed_701;
										fragment_unnamed_630 = fragment_unnamed_702;
										fragment_unnamed_631 = fragment_unnamed_703;
										fragment_unnamed_632 = fragment_unnamed_704;
										fragment_unnamed_633 = fragment_unnamed_705;
									}
									else
									{
										fragment_unnamed_628 = fragment_unnamed_664;
										fragment_unnamed_629 = fragment_unnamed_670;
										fragment_unnamed_630 = fragment_unnamed_681;
										fragment_unnamed_631 = fragment_unnamed_693;
										fragment_unnamed_632 = fragment_unnamed_686;
										fragment_unnamed_633 = fragment_unnamed_697;
									}
									fragment_unnamed_556 = fragment_unnamed_628;
									fragment_unnamed_557 = fragment_unnamed_629;
									fragment_unnamed_558 = fragment_unnamed_630;
									fragment_unnamed_559 = fragment_unnamed_631;
									fragment_unnamed_560 = fragment_unnamed_632;
									fragment_unnamed_561 = fragment_unnamed_633;
								}
								else
								{
									fragment_unnamed_556 = fragment_unnamed_592;
									fragment_unnamed_557 = fragment_unnamed_598;
									fragment_unnamed_558 = fragment_unnamed_609;
									fragment_unnamed_559 = fragment_unnamed_621;
									fragment_unnamed_560 = fragment_unnamed_614;
									fragment_unnamed_561 = fragment_unnamed_625;
								}
								fragment_unnamed_484 = fragment_unnamed_556;
								fragment_unnamed_485 = fragment_unnamed_557;
								fragment_unnamed_486 = fragment_unnamed_558;
								fragment_unnamed_487 = fragment_unnamed_559;
								fragment_unnamed_488 = fragment_unnamed_560;
								fragment_unnamed_489 = fragment_unnamed_561;
							}
							else
							{
								fragment_unnamed_484 = fragment_unnamed_520;
								fragment_unnamed_485 = fragment_unnamed_526;
								fragment_unnamed_486 = fragment_unnamed_537;
								fragment_unnamed_487 = fragment_unnamed_549;
								fragment_unnamed_488 = fragment_unnamed_542;
								fragment_unnamed_489 = fragment_unnamed_553;
							}
							fragment_unnamed_341 = fragment_unnamed_484;
							fragment_unnamed_343 = fragment_unnamed_485;
							fragment_unnamed_345 = fragment_unnamed_486;
							fragment_unnamed_347 = fragment_unnamed_487;
							fragment_unnamed_349 = fragment_unnamed_488;
							fragment_unnamed_351 = fragment_unnamed_489;
						}
						else
						{
							fragment_unnamed_341 = fragment_unnamed_448;
							fragment_unnamed_343 = fragment_unnamed_454;
							fragment_unnamed_345 = fragment_unnamed_465;
							fragment_unnamed_347 = fragment_unnamed_477;
							fragment_unnamed_349 = fragment_unnamed_470;
							fragment_unnamed_351 = fragment_unnamed_481;
						}
						fragment_unnamed_340 = fragment_unnamed_341;
						fragment_unnamed_342 = fragment_unnamed_343;
						fragment_unnamed_344 = fragment_unnamed_345;
						fragment_unnamed_346 = fragment_unnamed_347;
						fragment_unnamed_348 = fragment_unnamed_349;
						fragment_unnamed_350 = fragment_unnamed_351;
					}
					else
					{
						fragment_unnamed_340 = fragment_unnamed_254;
						fragment_unnamed_342 = fragment_unnamed_256;
						fragment_unnamed_344 = fragment_unnamed_269;
						fragment_unnamed_346 = fragment_unnamed_283;
						fragment_unnamed_348 = fragment_unnamed_275;
						fragment_unnamed_350 = fragment_unnamed_288;
					}
					float fragment_unnamed_363 = asfloat(fragment_unnamed_144 ? asuint(((-0.0f) - fragment_unnamed_344) + fragment_input_1.x) : asuint(((-0.0f) - fragment_unnamed_348) + fragment_input_1.y));
					float fragment_unnamed_375 = asfloat(fragment_unnamed_144 ? asuint(fragment_unnamed_346 + ((-0.0f) - fragment_input_1.x)) : asuint(fragment_unnamed_350 + ((-0.0f) - fragment_input_1.y)));
					float fragment_unnamed_395 = max(fragment_unnamed_250 * fragment_unnamed_250, asfloat(asuint(mad(min(fragment_unnamed_363, fragment_unnamed_375), (-0.0f) - (1.0f / (fragment_unnamed_363 + fragment_unnamed_375)), 0.5f)) & ((fragment_unnamed_363 < fragment_unnamed_375) ? ((fragment_unnamed_252 != ((fragment_unnamed_340 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_252 != ((fragment_unnamed_342 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					float4 fragment_unnamed_416 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_144 ? fragment_input_1.x : mad(fragment_unnamed_395, fragment_unnamed_184, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_144 ? mad(fragment_unnamed_395, fragment_unnamed_184, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f);
					fragment_unnamed_290 = fragment_unnamed_416.x;
					fragment_unnamed_292 = fragment_unnamed_416.y;
					fragment_unnamed_294 = fragment_unnamed_416.z;
				}
				else
				{
					fragment_unnamed_290 = fragment_unnamed_56.x;
					fragment_unnamed_292 = fragment_unnamed_56.y;
					fragment_unnamed_294 = fragment_unnamed_56.z;
				}
				float fragment_unnamed_315 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				float fragment_unnamed_327 = (((-0.0f) - sqrt(((-0.0f) - abs(fragment_unnamed_315)) + 1.0f)) + 1.0f) * mad(clamp(mad(fragment_unnamed_315, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_327, 0.0039215688593685626983642578125f, fragment_unnamed_290);
				fragment_output_0.y = mad(fragment_unnamed_327, 0.0039215688593685626983642578125f, fragment_unnamed_292);
				fragment_output_0.z = mad(fragment_unnamed_327, 0.0039215688593685626983642578125f, fragment_unnamed_294);
				fragment_output_0.w = fragment_unnamed_61;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[29] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA_LOW)


			#if defined(FXAA) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;
			float4 _PosScaleOffset;

			static float4 vertex_uniform_buffer_0[29];
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
				gl_Position.x = mad(vertex_input_0.x, vertex_uniform_buffer_0[28u].x, vertex_uniform_buffer_0[28u].z);
				gl_Position.y = mad(vertex_input_0.y, vertex_uniform_buffer_0[28u].y, vertex_uniform_buffer_0[28u].w);
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				float vertex_unnamed_68 = mad((vertex_input_0.x + 1.0f) * vertex_uniform_buffer_0[27u].x, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_70 = mad((vertex_input_0.y + 1.0f) * vertex_uniform_buffer_0[27u].y, 0.5f, vertex_uniform_buffer_0[27u].w);
				vertex_output_1.x = vertex_unnamed_68 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = vertex_unnamed_70 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_68;
				vertex_output_1.y = vertex_unnamed_70;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_uniform_buffer_0[28] = float4(_PosScaleOffset[0], _PosScaleOffset[1], _PosScaleOffset[2], _PosScaleOffset[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[31];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f);
				float fragment_unnamed_59 = fragment_unnamed_54.w;
				float4 fragment_unnamed_63 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, 1));
				float fragment_unnamed_67 = fragment_unnamed_63.w;
				float4 fragment_unnamed_68 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 0));
				float fragment_unnamed_71 = fragment_unnamed_68.w;
				float4 fragment_unnamed_73 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, -1));
				float fragment_unnamed_76 = fragment_unnamed_73.w;
				float4 fragment_unnamed_77 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 0));
				float fragment_unnamed_80 = fragment_unnamed_77.w;
				float fragment_unnamed_87 = max(max(fragment_unnamed_71, max(fragment_unnamed_59, fragment_unnamed_67)), max(fragment_unnamed_80, fragment_unnamed_76));
				float fragment_unnamed_93 = ((-0.0f) - min(min(fragment_unnamed_71, min(fragment_unnamed_59, fragment_unnamed_67)), min(fragment_unnamed_80, fragment_unnamed_76))) + fragment_unnamed_87;
				float fragment_unnamed_288;
				float fragment_unnamed_290;
				float fragment_unnamed_292;
				if (fragment_unnamed_93 >= max(fragment_unnamed_87 * 0.063000001013278961181640625f, 0.031199999153614044189453125f))
				{
					float4 fragment_unnamed_99 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, -1));
					float fragment_unnamed_102 = fragment_unnamed_99.w;
					float4 fragment_unnamed_103 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 1));
					float fragment_unnamed_106 = fragment_unnamed_103.w;
					float4 fragment_unnamed_107 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, -1));
					float fragment_unnamed_110 = fragment_unnamed_107.w;
					float4 fragment_unnamed_111 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 1));
					float fragment_unnamed_114 = fragment_unnamed_111.w;
					float fragment_unnamed_115 = fragment_unnamed_67 + fragment_unnamed_76;
					float fragment_unnamed_116 = fragment_unnamed_71 + fragment_unnamed_80;
					float fragment_unnamed_122 = fragment_unnamed_106 + fragment_unnamed_110;
					float fragment_unnamed_126 = fragment_unnamed_114 + fragment_unnamed_102;
					bool fragment_unnamed_142 = (mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_115)), 2.0f, abs(mad(fragment_unnamed_71, -2.0f, fragment_unnamed_122))) + abs(mad(fragment_unnamed_80, -2.0f, fragment_unnamed_126))) >= (mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_116)), 2.0f, abs(mad(fragment_unnamed_76, -2.0f, fragment_unnamed_102 + fragment_unnamed_110))) + abs(mad(fragment_unnamed_67, -2.0f, fragment_unnamed_106 + fragment_unnamed_114)));
					float fragment_unnamed_149 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_76) : asuint(fragment_unnamed_80));
					float fragment_unnamed_153 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_67) : asuint(fragment_unnamed_71));
					float fragment_unnamed_165 = asfloat(fragment_unnamed_142 ? asuint(fragment_uniform_buffer_0[30u]).y : asuint(fragment_uniform_buffer_0[30u]).x);
					float fragment_unnamed_170 = ((-0.0f) - fragment_unnamed_59) + fragment_unnamed_149;
					float fragment_unnamed_172 = ((-0.0f) - fragment_unnamed_59) + fragment_unnamed_153;
					bool fragment_unnamed_177 = abs(fragment_unnamed_170) >= abs(fragment_unnamed_172);
					float fragment_unnamed_182 = fragment_unnamed_177 ? ((-0.0f) - fragment_unnamed_165) : fragment_unnamed_165;
					float fragment_unnamed_185 = clamp((1.0f / fragment_unnamed_93) * abs(mad(mad(fragment_unnamed_115 + fragment_unnamed_116, 2.0f, fragment_unnamed_122 + fragment_unnamed_126), 0.083333335816860198974609375f, (-0.0f) - fragment_unnamed_59)), 0.0f, 1.0f);
					float fragment_unnamed_191 = asfloat((fragment_unnamed_142 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[30u]).x);
					float fragment_unnamed_197 = asfloat(fragment_unnamed_142 ? 0u : asuint(fragment_uniform_buffer_0[30u]).y);
					float fragment_unnamed_207 = fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_182, 0.5f, fragment_input_1.x);
					float fragment_unnamed_210 = fragment_unnamed_142 ? mad(fragment_unnamed_182, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					float fragment_unnamed_213 = ((-0.0f) - fragment_unnamed_191) + fragment_unnamed_207;
					float fragment_unnamed_214 = ((-0.0f) - fragment_unnamed_197) + fragment_unnamed_210;
					float fragment_unnamed_215 = fragment_unnamed_191 + fragment_unnamed_207;
					float fragment_unnamed_216 = fragment_unnamed_197 + fragment_unnamed_210;
					float fragment_unnamed_243 = asfloat(fragment_unnamed_177 ? asuint(fragment_unnamed_59 + fragment_unnamed_149) : asuint(fragment_unnamed_59 + fragment_unnamed_153));
					float fragment_unnamed_244 = max(abs(fragment_unnamed_172), abs(fragment_unnamed_170)) * 0.25f;
					float fragment_unnamed_248 = (fragment_unnamed_185 * fragment_unnamed_185) * mad(fragment_unnamed_185, -2.0f, 3.0f);
					uint fragment_unnamed_250 = (mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_59) < 0.0f) ? 4294967295u : 0u;
					float fragment_unnamed_252 = mad((-0.0f) - fragment_unnamed_243, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_213, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_214, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w);
					float fragment_unnamed_254 = mad((-0.0f) - fragment_unnamed_243, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_215, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_216, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w);
					bool fragment_unnamed_257 = abs(fragment_unnamed_252) >= fragment_unnamed_244;
					bool fragment_unnamed_258 = abs(fragment_unnamed_254) >= fragment_unnamed_244;
					uint fragment_unnamed_259 = fragment_unnamed_257 ? 4294967295u : 0u;
					uint fragment_unnamed_260 = fragment_unnamed_258 ? 4294967295u : 0u;
					uint fragment_unnamed_266 = fragment_unnamed_257 ? asuint(fragment_unnamed_213) : asuint(mad((-0.0f) - fragment_unnamed_191, 1.5f, fragment_unnamed_213));
					float fragment_unnamed_267 = asfloat(fragment_unnamed_266);
					uint fragment_unnamed_272 = fragment_unnamed_257 ? asuint(fragment_unnamed_214) : asuint(mad((-0.0f) - fragment_unnamed_197, 1.5f, fragment_unnamed_214));
					float fragment_unnamed_273 = asfloat(fragment_unnamed_272);
					uint fragment_unnamed_280 = fragment_unnamed_258 ? asuint(fragment_unnamed_215) : asuint(mad(fragment_unnamed_191, 1.5f, fragment_unnamed_215));
					float fragment_unnamed_281 = asfloat(fragment_unnamed_280);
					uint fragment_unnamed_285 = fragment_unnamed_258 ? asuint(fragment_unnamed_216) : asuint(mad(fragment_unnamed_197, 1.5f, fragment_unnamed_216));
					float fragment_unnamed_286 = asfloat(fragment_unnamed_285);
					float fragment_unnamed_338;
					float fragment_unnamed_340;
					float fragment_unnamed_342;
					float fragment_unnamed_344;
					float fragment_unnamed_346;
					float fragment_unnamed_348;
					if (((~fragment_unnamed_260) | (~fragment_unnamed_259)) != 0u)
					{
						float fragment_unnamed_427;
						if (fragment_unnamed_259 == 0u)
						{
							fragment_unnamed_427 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_267, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_273, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
						}
						else
						{
							fragment_unnamed_427 = fragment_unnamed_252;
						}
						float fragment_unnamed_440;
						if (fragment_unnamed_260 == 0u)
						{
							fragment_unnamed_440 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_281, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_286, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
						}
						else
						{
							fragment_unnamed_440 = fragment_unnamed_254;
						}
						float fragment_unnamed_446 = asfloat(fragment_unnamed_257 ? asuint(fragment_unnamed_427) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_427)));
						float fragment_unnamed_452 = asfloat(fragment_unnamed_258 ? asuint(fragment_unnamed_440) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_440)));
						bool fragment_unnamed_455 = abs(fragment_unnamed_446) >= fragment_unnamed_244;
						bool fragment_unnamed_456 = abs(fragment_unnamed_452) >= fragment_unnamed_244;
						uint fragment_unnamed_457 = fragment_unnamed_455 ? 4294967295u : 0u;
						uint fragment_unnamed_458 = fragment_unnamed_456 ? 4294967295u : 0u;
						uint fragment_unnamed_462 = fragment_unnamed_455 ? fragment_unnamed_266 : asuint(mad((-0.0f) - fragment_unnamed_191, 2.0f, fragment_unnamed_267));
						float fragment_unnamed_463 = asfloat(fragment_unnamed_462);
						uint fragment_unnamed_467 = fragment_unnamed_455 ? fragment_unnamed_272 : asuint(mad((-0.0f) - fragment_unnamed_197, 2.0f, fragment_unnamed_273));
						float fragment_unnamed_468 = asfloat(fragment_unnamed_467);
						uint fragment_unnamed_474 = fragment_unnamed_456 ? fragment_unnamed_280 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_281));
						float fragment_unnamed_475 = asfloat(fragment_unnamed_474);
						uint fragment_unnamed_478 = fragment_unnamed_456 ? fragment_unnamed_285 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_286));
						float fragment_unnamed_479 = asfloat(fragment_unnamed_478);
						float fragment_unnamed_339;
						float fragment_unnamed_341;
						float fragment_unnamed_343;
						float fragment_unnamed_345;
						float fragment_unnamed_347;
						float fragment_unnamed_349;
						if (((~fragment_unnamed_458) | (~fragment_unnamed_457)) != 0u)
						{
							float fragment_unnamed_499;
							if (fragment_unnamed_457 == 0u)
							{
								fragment_unnamed_499 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_463, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_468, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
							}
							else
							{
								fragment_unnamed_499 = fragment_unnamed_446;
							}
							float fragment_unnamed_512;
							if (fragment_unnamed_458 == 0u)
							{
								fragment_unnamed_512 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_475, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_479, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
							}
							else
							{
								fragment_unnamed_512 = fragment_unnamed_452;
							}
							float fragment_unnamed_518 = asfloat(fragment_unnamed_455 ? asuint(fragment_unnamed_499) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_499)));
							float fragment_unnamed_524 = asfloat(fragment_unnamed_456 ? asuint(fragment_unnamed_512) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_512)));
							bool fragment_unnamed_527 = abs(fragment_unnamed_518) >= fragment_unnamed_244;
							bool fragment_unnamed_528 = abs(fragment_unnamed_524) >= fragment_unnamed_244;
							uint fragment_unnamed_529 = fragment_unnamed_527 ? 4294967295u : 0u;
							uint fragment_unnamed_530 = fragment_unnamed_528 ? 4294967295u : 0u;
							uint fragment_unnamed_534 = fragment_unnamed_527 ? fragment_unnamed_462 : asuint(mad((-0.0f) - fragment_unnamed_191, 2.0f, fragment_unnamed_463));
							float fragment_unnamed_535 = asfloat(fragment_unnamed_534);
							uint fragment_unnamed_539 = fragment_unnamed_527 ? fragment_unnamed_467 : asuint(mad((-0.0f) - fragment_unnamed_197, 2.0f, fragment_unnamed_468));
							float fragment_unnamed_540 = asfloat(fragment_unnamed_539);
							uint fragment_unnamed_546 = fragment_unnamed_528 ? fragment_unnamed_474 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_475));
							float fragment_unnamed_547 = asfloat(fragment_unnamed_546);
							uint fragment_unnamed_550 = fragment_unnamed_528 ? fragment_unnamed_478 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_479));
							float fragment_unnamed_551 = asfloat(fragment_unnamed_550);
							float fragment_unnamed_482;
							float fragment_unnamed_483;
							float fragment_unnamed_484;
							float fragment_unnamed_485;
							float fragment_unnamed_486;
							float fragment_unnamed_487;
							if (((~fragment_unnamed_530) | (~fragment_unnamed_529)) != 0u)
							{
								float fragment_unnamed_571;
								if (fragment_unnamed_529 == 0u)
								{
									fragment_unnamed_571 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_535, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_540, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
								}
								else
								{
									fragment_unnamed_571 = fragment_unnamed_518;
								}
								float fragment_unnamed_584;
								if (fragment_unnamed_530 == 0u)
								{
									fragment_unnamed_584 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_547, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_551, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
								}
								else
								{
									fragment_unnamed_584 = fragment_unnamed_524;
								}
								float fragment_unnamed_590 = asfloat(fragment_unnamed_527 ? asuint(fragment_unnamed_571) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_571)));
								float fragment_unnamed_596 = asfloat(fragment_unnamed_528 ? asuint(fragment_unnamed_584) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_584)));
								bool fragment_unnamed_599 = abs(fragment_unnamed_590) >= fragment_unnamed_244;
								bool fragment_unnamed_600 = abs(fragment_unnamed_596) >= fragment_unnamed_244;
								uint fragment_unnamed_601 = fragment_unnamed_599 ? 4294967295u : 0u;
								uint fragment_unnamed_602 = fragment_unnamed_600 ? 4294967295u : 0u;
								uint fragment_unnamed_606 = fragment_unnamed_599 ? fragment_unnamed_534 : asuint(mad((-0.0f) - fragment_unnamed_191, 2.0f, fragment_unnamed_535));
								float fragment_unnamed_607 = asfloat(fragment_unnamed_606);
								uint fragment_unnamed_611 = fragment_unnamed_599 ? fragment_unnamed_539 : asuint(mad((-0.0f) - fragment_unnamed_197, 2.0f, fragment_unnamed_540));
								float fragment_unnamed_612 = asfloat(fragment_unnamed_611);
								uint fragment_unnamed_618 = fragment_unnamed_600 ? fragment_unnamed_546 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_547));
								float fragment_unnamed_619 = asfloat(fragment_unnamed_618);
								uint fragment_unnamed_622 = fragment_unnamed_600 ? fragment_unnamed_550 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_551));
								float fragment_unnamed_623 = asfloat(fragment_unnamed_622);
								float fragment_unnamed_554;
								float fragment_unnamed_555;
								float fragment_unnamed_556;
								float fragment_unnamed_557;
								float fragment_unnamed_558;
								float fragment_unnamed_559;
								if (((~fragment_unnamed_602) | (~fragment_unnamed_601)) != 0u)
								{
									float fragment_unnamed_643;
									if (fragment_unnamed_601 == 0u)
									{
										fragment_unnamed_643 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_607, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_612, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
									}
									else
									{
										fragment_unnamed_643 = fragment_unnamed_590;
									}
									float fragment_unnamed_656;
									if (fragment_unnamed_602 == 0u)
									{
										fragment_unnamed_656 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_619, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_623, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
									}
									else
									{
										fragment_unnamed_656 = fragment_unnamed_596;
									}
									float fragment_unnamed_662 = asfloat(fragment_unnamed_599 ? asuint(fragment_unnamed_643) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_643)));
									float fragment_unnamed_668 = asfloat(fragment_unnamed_600 ? asuint(fragment_unnamed_656) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_656)));
									bool fragment_unnamed_671 = abs(fragment_unnamed_662) >= fragment_unnamed_244;
									bool fragment_unnamed_672 = abs(fragment_unnamed_668) >= fragment_unnamed_244;
									uint fragment_unnamed_673 = fragment_unnamed_671 ? 4294967295u : 0u;
									uint fragment_unnamed_674 = fragment_unnamed_672 ? 4294967295u : 0u;
									uint fragment_unnamed_678 = fragment_unnamed_671 ? fragment_unnamed_606 : asuint(mad((-0.0f) - fragment_unnamed_191, 2.0f, fragment_unnamed_607));
									float fragment_unnamed_679 = asfloat(fragment_unnamed_678);
									uint fragment_unnamed_683 = fragment_unnamed_671 ? fragment_unnamed_611 : asuint(mad((-0.0f) - fragment_unnamed_197, 2.0f, fragment_unnamed_612));
									float fragment_unnamed_684 = asfloat(fragment_unnamed_683);
									uint fragment_unnamed_690 = fragment_unnamed_672 ? fragment_unnamed_618 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_619));
									float fragment_unnamed_691 = asfloat(fragment_unnamed_690);
									uint fragment_unnamed_694 = fragment_unnamed_672 ? fragment_unnamed_622 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_623));
									float fragment_unnamed_695 = asfloat(fragment_unnamed_694);
									float fragment_unnamed_626;
									float fragment_unnamed_627;
									float fragment_unnamed_628;
									float fragment_unnamed_629;
									float fragment_unnamed_630;
									float fragment_unnamed_631;
									if (((~fragment_unnamed_674) | (~fragment_unnamed_673)) != 0u)
									{
										float fragment_unnamed_715;
										if (fragment_unnamed_673 == 0u)
										{
											fragment_unnamed_715 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_679, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_684, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
										}
										else
										{
											fragment_unnamed_715 = fragment_unnamed_662;
										}
										float fragment_unnamed_728;
										if (fragment_unnamed_674 == 0u)
										{
											fragment_unnamed_728 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_691, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_695, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
										}
										else
										{
											fragment_unnamed_728 = fragment_unnamed_668;
										}
										float fragment_unnamed_734 = asfloat(fragment_unnamed_671 ? asuint(fragment_unnamed_715) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_715)));
										float fragment_unnamed_740 = asfloat(fragment_unnamed_672 ? asuint(fragment_unnamed_728) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_728)));
										bool fragment_unnamed_743 = abs(fragment_unnamed_734) >= fragment_unnamed_244;
										bool fragment_unnamed_744 = abs(fragment_unnamed_740) >= fragment_unnamed_244;
										uint fragment_unnamed_745 = fragment_unnamed_743 ? 4294967295u : 0u;
										uint fragment_unnamed_746 = fragment_unnamed_744 ? 4294967295u : 0u;
										uint fragment_unnamed_750 = fragment_unnamed_743 ? fragment_unnamed_678 : asuint(mad((-0.0f) - fragment_unnamed_191, 2.0f, fragment_unnamed_679));
										float fragment_unnamed_751 = asfloat(fragment_unnamed_750);
										uint fragment_unnamed_755 = fragment_unnamed_743 ? fragment_unnamed_683 : asuint(mad((-0.0f) - fragment_unnamed_197, 2.0f, fragment_unnamed_684));
										float fragment_unnamed_756 = asfloat(fragment_unnamed_755);
										uint fragment_unnamed_762 = fragment_unnamed_744 ? fragment_unnamed_690 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_691));
										float fragment_unnamed_763 = asfloat(fragment_unnamed_762);
										uint fragment_unnamed_766 = fragment_unnamed_744 ? fragment_unnamed_694 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_695));
										float fragment_unnamed_767 = asfloat(fragment_unnamed_766);
										float fragment_unnamed_698;
										float fragment_unnamed_699;
										float fragment_unnamed_700;
										float fragment_unnamed_701;
										float fragment_unnamed_702;
										float fragment_unnamed_703;
										if (((~fragment_unnamed_746) | (~fragment_unnamed_745)) != 0u)
										{
											float fragment_unnamed_787;
											if (fragment_unnamed_745 == 0u)
											{
												fragment_unnamed_787 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_751, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_756, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
											}
											else
											{
												fragment_unnamed_787 = fragment_unnamed_734;
											}
											float fragment_unnamed_800;
											if (fragment_unnamed_746 == 0u)
											{
												fragment_unnamed_800 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_763, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_767, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
											}
											else
											{
												fragment_unnamed_800 = fragment_unnamed_740;
											}
											float fragment_unnamed_806 = asfloat(fragment_unnamed_743 ? asuint(fragment_unnamed_787) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_787)));
											float fragment_unnamed_812 = asfloat(fragment_unnamed_744 ? asuint(fragment_unnamed_800) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_800)));
											bool fragment_unnamed_815 = abs(fragment_unnamed_806) >= fragment_unnamed_244;
											bool fragment_unnamed_816 = abs(fragment_unnamed_812) >= fragment_unnamed_244;
											uint fragment_unnamed_817 = fragment_unnamed_815 ? 4294967295u : 0u;
											uint fragment_unnamed_818 = fragment_unnamed_816 ? 4294967295u : 0u;
											uint fragment_unnamed_822 = fragment_unnamed_815 ? fragment_unnamed_750 : asuint(mad((-0.0f) - fragment_unnamed_191, 2.0f, fragment_unnamed_751));
											float fragment_unnamed_823 = asfloat(fragment_unnamed_822);
											uint fragment_unnamed_827 = fragment_unnamed_815 ? fragment_unnamed_755 : asuint(mad((-0.0f) - fragment_unnamed_197, 2.0f, fragment_unnamed_756));
											float fragment_unnamed_828 = asfloat(fragment_unnamed_827);
											uint fragment_unnamed_834 = fragment_unnamed_816 ? fragment_unnamed_762 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_763));
											float fragment_unnamed_835 = asfloat(fragment_unnamed_834);
											uint fragment_unnamed_838 = fragment_unnamed_816 ? fragment_unnamed_766 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_767));
											float fragment_unnamed_839 = asfloat(fragment_unnamed_838);
											float fragment_unnamed_770;
											float fragment_unnamed_771;
											float fragment_unnamed_772;
											float fragment_unnamed_773;
											float fragment_unnamed_774;
											float fragment_unnamed_775;
											if (((~fragment_unnamed_818) | (~fragment_unnamed_817)) != 0u)
											{
												float fragment_unnamed_859;
												if (fragment_unnamed_817 == 0u)
												{
													fragment_unnamed_859 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_823, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_828, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
												}
												else
												{
													fragment_unnamed_859 = fragment_unnamed_806;
												}
												float fragment_unnamed_872;
												if (fragment_unnamed_818 == 0u)
												{
													fragment_unnamed_872 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_835, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_839, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
												}
												else
												{
													fragment_unnamed_872 = fragment_unnamed_812;
												}
												float fragment_unnamed_878 = asfloat(fragment_unnamed_815 ? asuint(fragment_unnamed_859) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_859)));
												float fragment_unnamed_884 = asfloat(fragment_unnamed_816 ? asuint(fragment_unnamed_872) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_872)));
												bool fragment_unnamed_887 = abs(fragment_unnamed_878) >= fragment_unnamed_244;
												bool fragment_unnamed_888 = abs(fragment_unnamed_884) >= fragment_unnamed_244;
												uint fragment_unnamed_889 = fragment_unnamed_887 ? 4294967295u : 0u;
												uint fragment_unnamed_890 = fragment_unnamed_888 ? 4294967295u : 0u;
												uint fragment_unnamed_894 = fragment_unnamed_887 ? fragment_unnamed_822 : asuint(mad((-0.0f) - fragment_unnamed_191, 2.0f, fragment_unnamed_823));
												float fragment_unnamed_895 = asfloat(fragment_unnamed_894);
												uint fragment_unnamed_899 = fragment_unnamed_887 ? fragment_unnamed_827 : asuint(mad((-0.0f) - fragment_unnamed_197, 2.0f, fragment_unnamed_828));
												float fragment_unnamed_900 = asfloat(fragment_unnamed_899);
												uint fragment_unnamed_906 = fragment_unnamed_888 ? fragment_unnamed_834 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_835));
												float fragment_unnamed_907 = asfloat(fragment_unnamed_906);
												uint fragment_unnamed_910 = fragment_unnamed_888 ? fragment_unnamed_838 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_839));
												float fragment_unnamed_911 = asfloat(fragment_unnamed_910);
												float fragment_unnamed_842;
												float fragment_unnamed_843;
												float fragment_unnamed_844;
												float fragment_unnamed_845;
												float fragment_unnamed_846;
												float fragment_unnamed_847;
												if (((~fragment_unnamed_890) | (~fragment_unnamed_889)) != 0u)
												{
													float fragment_unnamed_931;
													if (fragment_unnamed_889 == 0u)
													{
														fragment_unnamed_931 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_895, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_900, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
													}
													else
													{
														fragment_unnamed_931 = fragment_unnamed_878;
													}
													float fragment_unnamed_944;
													if (fragment_unnamed_890 == 0u)
													{
														fragment_unnamed_944 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_907, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_911, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
													}
													else
													{
														fragment_unnamed_944 = fragment_unnamed_884;
													}
													float fragment_unnamed_950 = asfloat(fragment_unnamed_887 ? asuint(fragment_unnamed_931) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_931)));
													float fragment_unnamed_956 = asfloat(fragment_unnamed_888 ? asuint(fragment_unnamed_944) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_944)));
													bool fragment_unnamed_959 = abs(fragment_unnamed_950) >= fragment_unnamed_244;
													bool fragment_unnamed_960 = abs(fragment_unnamed_956) >= fragment_unnamed_244;
													uint fragment_unnamed_961 = fragment_unnamed_959 ? 4294967295u : 0u;
													uint fragment_unnamed_962 = fragment_unnamed_960 ? 4294967295u : 0u;
													uint fragment_unnamed_967 = fragment_unnamed_959 ? fragment_unnamed_894 : asuint(mad((-0.0f) - fragment_unnamed_191, 4.0f, fragment_unnamed_895));
													float fragment_unnamed_968 = asfloat(fragment_unnamed_967);
													uint fragment_unnamed_972 = fragment_unnamed_959 ? fragment_unnamed_899 : asuint(mad((-0.0f) - fragment_unnamed_197, 4.0f, fragment_unnamed_900));
													float fragment_unnamed_973 = asfloat(fragment_unnamed_972);
													uint fragment_unnamed_979 = fragment_unnamed_960 ? fragment_unnamed_906 : asuint(mad(fragment_unnamed_191, 4.0f, fragment_unnamed_907));
													float fragment_unnamed_980 = asfloat(fragment_unnamed_979);
													uint fragment_unnamed_983 = fragment_unnamed_960 ? fragment_unnamed_910 : asuint(mad(fragment_unnamed_197, 4.0f, fragment_unnamed_911));
													float fragment_unnamed_984 = asfloat(fragment_unnamed_983);
													float fragment_unnamed_914;
													float fragment_unnamed_915;
													float fragment_unnamed_916;
													float fragment_unnamed_917;
													float fragment_unnamed_918;
													float fragment_unnamed_919;
													if (((~fragment_unnamed_962) | (~fragment_unnamed_961)) != 0u)
													{
														float fragment_unnamed_1004;
														if (fragment_unnamed_961 == 0u)
														{
															fragment_unnamed_1004 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_968, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_973, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
														}
														else
														{
															fragment_unnamed_1004 = fragment_unnamed_950;
														}
														float fragment_unnamed_1017;
														if (fragment_unnamed_962 == 0u)
														{
															fragment_unnamed_1017 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_980, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_984, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
														}
														else
														{
															fragment_unnamed_1017 = fragment_unnamed_956;
														}
														float fragment_unnamed_987 = asfloat(fragment_unnamed_959 ? asuint(fragment_unnamed_1004) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_1004)));
														float fragment_unnamed_988 = asfloat(fragment_unnamed_960 ? asuint(fragment_unnamed_1017) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_1017)));
														bool fragment_unnamed_1030 = abs(fragment_unnamed_987) >= fragment_unnamed_244;
														bool fragment_unnamed_1031 = abs(fragment_unnamed_988) >= fragment_unnamed_244;
														fragment_unnamed_914 = fragment_unnamed_987;
														fragment_unnamed_915 = fragment_unnamed_988;
														fragment_unnamed_916 = asfloat(fragment_unnamed_1030 ? fragment_unnamed_967 : asuint(mad((-0.0f) - fragment_unnamed_191, 8.0f, fragment_unnamed_968)));
														fragment_unnamed_917 = asfloat(fragment_unnamed_1031 ? fragment_unnamed_979 : asuint(mad(fragment_unnamed_191, 8.0f, fragment_unnamed_980)));
														fragment_unnamed_918 = asfloat(fragment_unnamed_1030 ? fragment_unnamed_972 : asuint(mad((-0.0f) - fragment_unnamed_197, 8.0f, fragment_unnamed_973)));
														fragment_unnamed_919 = asfloat(fragment_unnamed_1031 ? fragment_unnamed_983 : asuint(mad(fragment_unnamed_197, 8.0f, fragment_unnamed_984)));
													}
													else
													{
														fragment_unnamed_914 = fragment_unnamed_950;
														fragment_unnamed_915 = fragment_unnamed_956;
														fragment_unnamed_916 = fragment_unnamed_968;
														fragment_unnamed_917 = fragment_unnamed_980;
														fragment_unnamed_918 = fragment_unnamed_973;
														fragment_unnamed_919 = fragment_unnamed_984;
													}
													fragment_unnamed_842 = fragment_unnamed_914;
													fragment_unnamed_843 = fragment_unnamed_915;
													fragment_unnamed_844 = fragment_unnamed_916;
													fragment_unnamed_845 = fragment_unnamed_917;
													fragment_unnamed_846 = fragment_unnamed_918;
													fragment_unnamed_847 = fragment_unnamed_919;
												}
												else
												{
													fragment_unnamed_842 = fragment_unnamed_878;
													fragment_unnamed_843 = fragment_unnamed_884;
													fragment_unnamed_844 = fragment_unnamed_895;
													fragment_unnamed_845 = fragment_unnamed_907;
													fragment_unnamed_846 = fragment_unnamed_900;
													fragment_unnamed_847 = fragment_unnamed_911;
												}
												fragment_unnamed_770 = fragment_unnamed_842;
												fragment_unnamed_771 = fragment_unnamed_843;
												fragment_unnamed_772 = fragment_unnamed_844;
												fragment_unnamed_773 = fragment_unnamed_845;
												fragment_unnamed_774 = fragment_unnamed_846;
												fragment_unnamed_775 = fragment_unnamed_847;
											}
											else
											{
												fragment_unnamed_770 = fragment_unnamed_806;
												fragment_unnamed_771 = fragment_unnamed_812;
												fragment_unnamed_772 = fragment_unnamed_823;
												fragment_unnamed_773 = fragment_unnamed_835;
												fragment_unnamed_774 = fragment_unnamed_828;
												fragment_unnamed_775 = fragment_unnamed_839;
											}
											fragment_unnamed_698 = fragment_unnamed_770;
											fragment_unnamed_699 = fragment_unnamed_771;
											fragment_unnamed_700 = fragment_unnamed_772;
											fragment_unnamed_701 = fragment_unnamed_773;
											fragment_unnamed_702 = fragment_unnamed_774;
											fragment_unnamed_703 = fragment_unnamed_775;
										}
										else
										{
											fragment_unnamed_698 = fragment_unnamed_734;
											fragment_unnamed_699 = fragment_unnamed_740;
											fragment_unnamed_700 = fragment_unnamed_751;
											fragment_unnamed_701 = fragment_unnamed_763;
											fragment_unnamed_702 = fragment_unnamed_756;
											fragment_unnamed_703 = fragment_unnamed_767;
										}
										fragment_unnamed_626 = fragment_unnamed_698;
										fragment_unnamed_627 = fragment_unnamed_699;
										fragment_unnamed_628 = fragment_unnamed_700;
										fragment_unnamed_629 = fragment_unnamed_701;
										fragment_unnamed_630 = fragment_unnamed_702;
										fragment_unnamed_631 = fragment_unnamed_703;
									}
									else
									{
										fragment_unnamed_626 = fragment_unnamed_662;
										fragment_unnamed_627 = fragment_unnamed_668;
										fragment_unnamed_628 = fragment_unnamed_679;
										fragment_unnamed_629 = fragment_unnamed_691;
										fragment_unnamed_630 = fragment_unnamed_684;
										fragment_unnamed_631 = fragment_unnamed_695;
									}
									fragment_unnamed_554 = fragment_unnamed_626;
									fragment_unnamed_555 = fragment_unnamed_627;
									fragment_unnamed_556 = fragment_unnamed_628;
									fragment_unnamed_557 = fragment_unnamed_629;
									fragment_unnamed_558 = fragment_unnamed_630;
									fragment_unnamed_559 = fragment_unnamed_631;
								}
								else
								{
									fragment_unnamed_554 = fragment_unnamed_590;
									fragment_unnamed_555 = fragment_unnamed_596;
									fragment_unnamed_556 = fragment_unnamed_607;
									fragment_unnamed_557 = fragment_unnamed_619;
									fragment_unnamed_558 = fragment_unnamed_612;
									fragment_unnamed_559 = fragment_unnamed_623;
								}
								fragment_unnamed_482 = fragment_unnamed_554;
								fragment_unnamed_483 = fragment_unnamed_555;
								fragment_unnamed_484 = fragment_unnamed_556;
								fragment_unnamed_485 = fragment_unnamed_557;
								fragment_unnamed_486 = fragment_unnamed_558;
								fragment_unnamed_487 = fragment_unnamed_559;
							}
							else
							{
								fragment_unnamed_482 = fragment_unnamed_518;
								fragment_unnamed_483 = fragment_unnamed_524;
								fragment_unnamed_484 = fragment_unnamed_535;
								fragment_unnamed_485 = fragment_unnamed_547;
								fragment_unnamed_486 = fragment_unnamed_540;
								fragment_unnamed_487 = fragment_unnamed_551;
							}
							fragment_unnamed_339 = fragment_unnamed_482;
							fragment_unnamed_341 = fragment_unnamed_483;
							fragment_unnamed_343 = fragment_unnamed_484;
							fragment_unnamed_345 = fragment_unnamed_485;
							fragment_unnamed_347 = fragment_unnamed_486;
							fragment_unnamed_349 = fragment_unnamed_487;
						}
						else
						{
							fragment_unnamed_339 = fragment_unnamed_446;
							fragment_unnamed_341 = fragment_unnamed_452;
							fragment_unnamed_343 = fragment_unnamed_463;
							fragment_unnamed_345 = fragment_unnamed_475;
							fragment_unnamed_347 = fragment_unnamed_468;
							fragment_unnamed_349 = fragment_unnamed_479;
						}
						fragment_unnamed_338 = fragment_unnamed_339;
						fragment_unnamed_340 = fragment_unnamed_341;
						fragment_unnamed_342 = fragment_unnamed_343;
						fragment_unnamed_344 = fragment_unnamed_345;
						fragment_unnamed_346 = fragment_unnamed_347;
						fragment_unnamed_348 = fragment_unnamed_349;
					}
					else
					{
						fragment_unnamed_338 = fragment_unnamed_252;
						fragment_unnamed_340 = fragment_unnamed_254;
						fragment_unnamed_342 = fragment_unnamed_267;
						fragment_unnamed_344 = fragment_unnamed_281;
						fragment_unnamed_346 = fragment_unnamed_273;
						fragment_unnamed_348 = fragment_unnamed_286;
					}
					float fragment_unnamed_361 = asfloat(fragment_unnamed_142 ? asuint(((-0.0f) - fragment_unnamed_342) + fragment_input_1.x) : asuint(((-0.0f) - fragment_unnamed_346) + fragment_input_1.y));
					float fragment_unnamed_373 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_344 + ((-0.0f) - fragment_input_1.x)) : asuint(fragment_unnamed_348 + ((-0.0f) - fragment_input_1.y)));
					float fragment_unnamed_393 = max(fragment_unnamed_248 * fragment_unnamed_248, asfloat(asuint(mad(min(fragment_unnamed_361, fragment_unnamed_373), (-0.0f) - (1.0f / (fragment_unnamed_361 + fragment_unnamed_373)), 0.5f)) & ((fragment_unnamed_361 < fragment_unnamed_373) ? ((fragment_unnamed_250 != ((fragment_unnamed_338 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_250 != ((fragment_unnamed_340 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					float4 fragment_unnamed_414 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_393, fragment_unnamed_182, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_142 ? mad(fragment_unnamed_393, fragment_unnamed_182, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f);
					fragment_unnamed_288 = fragment_unnamed_414.x;
					fragment_unnamed_290 = fragment_unnamed_414.y;
					fragment_unnamed_292 = fragment_unnamed_414.z;
				}
				else
				{
					fragment_unnamed_288 = fragment_unnamed_54.x;
					fragment_unnamed_290 = fragment_unnamed_54.y;
					fragment_unnamed_292 = fragment_unnamed_54.z;
				}
				float fragment_unnamed_313 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[29u].x, fragment_uniform_buffer_0[29u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[29u].y, fragment_uniform_buffer_0[29u].w))).w, 2.0f, -1.0f);
				float fragment_unnamed_325 = (((-0.0f) - sqrt(((-0.0f) - abs(fragment_unnamed_313)) + 1.0f)) + 1.0f) * mad(clamp(mad(fragment_unnamed_313, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_288);
				fragment_output_0.y = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_290);
				fragment_output_0.z = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_292);
				fragment_output_0.w = fragment_unnamed_59;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[29] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[30] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA_LOW)


			#if defined(FXAA) && defined(FXAA_KEEP_ALPHA) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
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
				float vertex_unnamed_57 = mad((vertex_input_0.x + 1.0f) * vertex_uniform_buffer_0[27u].x, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_59 = mad((vertex_input_0.y + 1.0f) * vertex_uniform_buffer_0[27u].y, 0.5f, vertex_uniform_buffer_0[27u].w);
				vertex_output_1.x = vertex_unnamed_57 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_57;
				vertex_output_1.y = vertex_unnamed_59;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f);
				float fragment_unnamed_57 = fragment_unnamed_54.y;
				float4 fragment_unnamed_62 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, 1));
				float fragment_unnamed_66 = fragment_unnamed_62.y;
				float4 fragment_unnamed_67 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 0));
				float fragment_unnamed_70 = fragment_unnamed_67.y;
				float4 fragment_unnamed_72 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, -1));
				float fragment_unnamed_75 = fragment_unnamed_72.y;
				float4 fragment_unnamed_76 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 0));
				float fragment_unnamed_79 = fragment_unnamed_76.y;
				float fragment_unnamed_86 = max(max(fragment_unnamed_70, max(fragment_unnamed_57, fragment_unnamed_66)), max(fragment_unnamed_75, fragment_unnamed_79));
				float fragment_unnamed_92 = ((-0.0f) - min(min(fragment_unnamed_70, min(fragment_unnamed_57, fragment_unnamed_66)), min(fragment_unnamed_75, fragment_unnamed_79))) + fragment_unnamed_86;
				float fragment_unnamed_286;
				float fragment_unnamed_288;
				float fragment_unnamed_290;
				if (fragment_unnamed_92 >= max(fragment_unnamed_86 * 0.063000001013278961181640625f, 0.031199999153614044189453125f))
				{
					float4 fragment_unnamed_98 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, -1));
					float fragment_unnamed_101 = fragment_unnamed_98.y;
					float4 fragment_unnamed_102 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 1));
					float fragment_unnamed_105 = fragment_unnamed_102.y;
					float4 fragment_unnamed_106 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, -1));
					float fragment_unnamed_109 = fragment_unnamed_106.y;
					float4 fragment_unnamed_110 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 1));
					float fragment_unnamed_113 = fragment_unnamed_110.y;
					float fragment_unnamed_114 = fragment_unnamed_66 + fragment_unnamed_75;
					float fragment_unnamed_115 = fragment_unnamed_70 + fragment_unnamed_79;
					float fragment_unnamed_121 = fragment_unnamed_105 + fragment_unnamed_109;
					float fragment_unnamed_125 = fragment_unnamed_113 + fragment_unnamed_101;
					bool fragment_unnamed_141 = (mad(abs(mad(fragment_unnamed_57, -2.0f, fragment_unnamed_114)), 2.0f, abs(mad(fragment_unnamed_70, -2.0f, fragment_unnamed_121))) + abs(mad(fragment_unnamed_79, -2.0f, fragment_unnamed_125))) >= (mad(abs(mad(fragment_unnamed_57, -2.0f, fragment_unnamed_115)), 2.0f, abs(mad(fragment_unnamed_75, -2.0f, fragment_unnamed_101 + fragment_unnamed_109))) + abs(mad(fragment_unnamed_66, -2.0f, fragment_unnamed_105 + fragment_unnamed_113)));
					float fragment_unnamed_148 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_75) : asuint(fragment_unnamed_79));
					float fragment_unnamed_152 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_66) : asuint(fragment_unnamed_70));
					float fragment_unnamed_164 = asfloat(fragment_unnamed_141 ? asuint(fragment_uniform_buffer_0[29u]).y : asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_169 = ((-0.0f) - fragment_unnamed_57) + fragment_unnamed_148;
					float fragment_unnamed_171 = ((-0.0f) - fragment_unnamed_57) + fragment_unnamed_152;
					bool fragment_unnamed_176 = abs(fragment_unnamed_169) >= abs(fragment_unnamed_171);
					float fragment_unnamed_181 = fragment_unnamed_176 ? ((-0.0f) - fragment_unnamed_164) : fragment_unnamed_164;
					float fragment_unnamed_184 = clamp((1.0f / fragment_unnamed_92) * abs(mad(mad(fragment_unnamed_114 + fragment_unnamed_115, 2.0f, fragment_unnamed_121 + fragment_unnamed_125), 0.083333335816860198974609375f, (-0.0f) - fragment_unnamed_57)), 0.0f, 1.0f);
					float fragment_unnamed_190 = asfloat((fragment_unnamed_141 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_196 = asfloat(fragment_unnamed_141 ? 0u : asuint(fragment_uniform_buffer_0[29u]).y);
					float fragment_unnamed_206 = fragment_unnamed_141 ? fragment_input_1.x : mad(fragment_unnamed_181, 0.5f, fragment_input_1.x);
					float fragment_unnamed_209 = fragment_unnamed_141 ? mad(fragment_unnamed_181, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					float fragment_unnamed_212 = ((-0.0f) - fragment_unnamed_190) + fragment_unnamed_206;
					float fragment_unnamed_213 = ((-0.0f) - fragment_unnamed_196) + fragment_unnamed_209;
					float fragment_unnamed_214 = fragment_unnamed_190 + fragment_unnamed_206;
					float fragment_unnamed_215 = fragment_unnamed_196 + fragment_unnamed_209;
					float fragment_unnamed_242 = asfloat(fragment_unnamed_176 ? asuint(fragment_unnamed_57 + fragment_unnamed_148) : asuint(fragment_unnamed_57 + fragment_unnamed_152));
					float fragment_unnamed_243 = max(abs(fragment_unnamed_171), abs(fragment_unnamed_169)) * 0.25f;
					float fragment_unnamed_247 = (fragment_unnamed_184 * fragment_unnamed_184) * mad(fragment_unnamed_184, -2.0f, 3.0f);
					uint fragment_unnamed_249 = (mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_57) < 0.0f) ? 4294967295u : 0u;
					float fragment_unnamed_251 = mad((-0.0f) - fragment_unnamed_242, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_212, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_213, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y);
					float fragment_unnamed_253 = mad((-0.0f) - fragment_unnamed_242, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_214, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_215, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y);
					bool fragment_unnamed_256 = abs(fragment_unnamed_251) >= fragment_unnamed_243;
					bool fragment_unnamed_257 = abs(fragment_unnamed_253) >= fragment_unnamed_243;
					uint fragment_unnamed_258 = fragment_unnamed_256 ? 4294967295u : 0u;
					uint fragment_unnamed_259 = fragment_unnamed_257 ? 4294967295u : 0u;
					uint fragment_unnamed_265 = fragment_unnamed_256 ? asuint(fragment_unnamed_212) : asuint(mad((-0.0f) - fragment_unnamed_190, 1.5f, fragment_unnamed_212));
					float fragment_unnamed_266 = asfloat(fragment_unnamed_265);
					uint fragment_unnamed_271 = fragment_unnamed_256 ? asuint(fragment_unnamed_213) : asuint(mad((-0.0f) - fragment_unnamed_196, 1.5f, fragment_unnamed_213));
					float fragment_unnamed_272 = asfloat(fragment_unnamed_271);
					uint fragment_unnamed_279 = fragment_unnamed_257 ? asuint(fragment_unnamed_214) : asuint(mad(fragment_unnamed_190, 1.5f, fragment_unnamed_214));
					float fragment_unnamed_280 = asfloat(fragment_unnamed_279);
					uint fragment_unnamed_284 = fragment_unnamed_257 ? asuint(fragment_unnamed_215) : asuint(mad(fragment_unnamed_196, 1.5f, fragment_unnamed_215));
					float fragment_unnamed_344;
					float fragment_unnamed_346;
					float fragment_unnamed_348;
					float fragment_unnamed_350;
					float fragment_unnamed_352;
					uint fragment_unnamed_354;
					if (((~fragment_unnamed_259) | (~fragment_unnamed_258)) != 0u)
					{
						float fragment_unnamed_434;
						if (fragment_unnamed_258 == 0u)
						{
							fragment_unnamed_434 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_266, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_272, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
						}
						else
						{
							fragment_unnamed_434 = fragment_unnamed_251;
						}
						float fragment_unnamed_448;
						if (fragment_unnamed_259 == 0u)
						{
							fragment_unnamed_448 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_280, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_284), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
						}
						else
						{
							fragment_unnamed_448 = fragment_unnamed_253;
						}
						float fragment_unnamed_454 = asfloat(fragment_unnamed_256 ? asuint(fragment_unnamed_434) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_434)));
						float fragment_unnamed_460 = asfloat(fragment_unnamed_257 ? asuint(fragment_unnamed_448) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_448)));
						bool fragment_unnamed_463 = abs(fragment_unnamed_454) >= fragment_unnamed_243;
						bool fragment_unnamed_464 = abs(fragment_unnamed_460) >= fragment_unnamed_243;
						uint fragment_unnamed_465 = fragment_unnamed_463 ? 4294967295u : 0u;
						uint fragment_unnamed_466 = fragment_unnamed_464 ? 4294967295u : 0u;
						uint fragment_unnamed_470 = fragment_unnamed_463 ? fragment_unnamed_265 : asuint(mad((-0.0f) - fragment_unnamed_190, 2.0f, fragment_unnamed_266));
						float fragment_unnamed_471 = asfloat(fragment_unnamed_470);
						uint fragment_unnamed_475 = fragment_unnamed_463 ? fragment_unnamed_271 : asuint(mad((-0.0f) - fragment_unnamed_196, 2.0f, fragment_unnamed_272));
						float fragment_unnamed_476 = asfloat(fragment_unnamed_475);
						uint fragment_unnamed_482 = fragment_unnamed_464 ? fragment_unnamed_279 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_280));
						float fragment_unnamed_483 = asfloat(fragment_unnamed_482);
						uint fragment_unnamed_487 = fragment_unnamed_464 ? fragment_unnamed_284 : asuint(mad(fragment_unnamed_196, 2.0f, asfloat(fragment_unnamed_284)));
						float fragment_unnamed_345;
						float fragment_unnamed_347;
						float fragment_unnamed_349;
						float fragment_unnamed_351;
						float fragment_unnamed_353;
						uint fragment_unnamed_355;
						if (((~fragment_unnamed_466) | (~fragment_unnamed_465)) != 0u)
						{
							float fragment_unnamed_507;
							if (fragment_unnamed_465 == 0u)
							{
								fragment_unnamed_507 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_471, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_476, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
							}
							else
							{
								fragment_unnamed_507 = fragment_unnamed_454;
							}
							float fragment_unnamed_521;
							if (fragment_unnamed_466 == 0u)
							{
								fragment_unnamed_521 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_483, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_487), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
							}
							else
							{
								fragment_unnamed_521 = fragment_unnamed_460;
							}
							float fragment_unnamed_527 = asfloat(fragment_unnamed_463 ? asuint(fragment_unnamed_507) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_507)));
							float fragment_unnamed_533 = asfloat(fragment_unnamed_464 ? asuint(fragment_unnamed_521) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_521)));
							bool fragment_unnamed_536 = abs(fragment_unnamed_527) >= fragment_unnamed_243;
							bool fragment_unnamed_537 = abs(fragment_unnamed_533) >= fragment_unnamed_243;
							uint fragment_unnamed_538 = fragment_unnamed_536 ? 4294967295u : 0u;
							uint fragment_unnamed_539 = fragment_unnamed_537 ? 4294967295u : 0u;
							uint fragment_unnamed_543 = fragment_unnamed_536 ? fragment_unnamed_470 : asuint(mad((-0.0f) - fragment_unnamed_190, 2.0f, fragment_unnamed_471));
							float fragment_unnamed_544 = asfloat(fragment_unnamed_543);
							uint fragment_unnamed_548 = fragment_unnamed_536 ? fragment_unnamed_475 : asuint(mad((-0.0f) - fragment_unnamed_196, 2.0f, fragment_unnamed_476));
							float fragment_unnamed_549 = asfloat(fragment_unnamed_548);
							uint fragment_unnamed_555 = fragment_unnamed_537 ? fragment_unnamed_482 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_483));
							float fragment_unnamed_556 = asfloat(fragment_unnamed_555);
							uint fragment_unnamed_560 = fragment_unnamed_537 ? fragment_unnamed_487 : asuint(mad(fragment_unnamed_196, 2.0f, asfloat(fragment_unnamed_487)));
							float fragment_unnamed_490;
							float fragment_unnamed_491;
							float fragment_unnamed_492;
							float fragment_unnamed_493;
							float fragment_unnamed_494;
							uint fragment_unnamed_495;
							if (((~fragment_unnamed_539) | (~fragment_unnamed_538)) != 0u)
							{
								float fragment_unnamed_580;
								if (fragment_unnamed_538 == 0u)
								{
									fragment_unnamed_580 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_544, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_549, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
								}
								else
								{
									fragment_unnamed_580 = fragment_unnamed_527;
								}
								float fragment_unnamed_594;
								if (fragment_unnamed_539 == 0u)
								{
									fragment_unnamed_594 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_556, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_560), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
								}
								else
								{
									fragment_unnamed_594 = fragment_unnamed_533;
								}
								float fragment_unnamed_600 = asfloat(fragment_unnamed_536 ? asuint(fragment_unnamed_580) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_580)));
								float fragment_unnamed_606 = asfloat(fragment_unnamed_537 ? asuint(fragment_unnamed_594) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_594)));
								bool fragment_unnamed_609 = abs(fragment_unnamed_600) >= fragment_unnamed_243;
								bool fragment_unnamed_610 = abs(fragment_unnamed_606) >= fragment_unnamed_243;
								uint fragment_unnamed_611 = fragment_unnamed_609 ? 4294967295u : 0u;
								uint fragment_unnamed_612 = fragment_unnamed_610 ? 4294967295u : 0u;
								uint fragment_unnamed_616 = fragment_unnamed_609 ? fragment_unnamed_543 : asuint(mad((-0.0f) - fragment_unnamed_190, 2.0f, fragment_unnamed_544));
								float fragment_unnamed_617 = asfloat(fragment_unnamed_616);
								uint fragment_unnamed_621 = fragment_unnamed_609 ? fragment_unnamed_548 : asuint(mad((-0.0f) - fragment_unnamed_196, 2.0f, fragment_unnamed_549));
								float fragment_unnamed_622 = asfloat(fragment_unnamed_621);
								uint fragment_unnamed_628 = fragment_unnamed_610 ? fragment_unnamed_555 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_556));
								float fragment_unnamed_629 = asfloat(fragment_unnamed_628);
								uint fragment_unnamed_633 = fragment_unnamed_610 ? fragment_unnamed_560 : asuint(mad(fragment_unnamed_196, 2.0f, asfloat(fragment_unnamed_560)));
								float fragment_unnamed_563;
								float fragment_unnamed_564;
								float fragment_unnamed_565;
								float fragment_unnamed_566;
								float fragment_unnamed_567;
								uint fragment_unnamed_568;
								if (((~fragment_unnamed_612) | (~fragment_unnamed_611)) != 0u)
								{
									float fragment_unnamed_653;
									if (fragment_unnamed_611 == 0u)
									{
										fragment_unnamed_653 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_617, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_622, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
									}
									else
									{
										fragment_unnamed_653 = fragment_unnamed_600;
									}
									float fragment_unnamed_667;
									if (fragment_unnamed_612 == 0u)
									{
										fragment_unnamed_667 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_629, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_633), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
									}
									else
									{
										fragment_unnamed_667 = fragment_unnamed_606;
									}
									float fragment_unnamed_673 = asfloat(fragment_unnamed_609 ? asuint(fragment_unnamed_653) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_653)));
									float fragment_unnamed_679 = asfloat(fragment_unnamed_610 ? asuint(fragment_unnamed_667) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_667)));
									bool fragment_unnamed_682 = abs(fragment_unnamed_673) >= fragment_unnamed_243;
									bool fragment_unnamed_683 = abs(fragment_unnamed_679) >= fragment_unnamed_243;
									uint fragment_unnamed_684 = fragment_unnamed_682 ? 4294967295u : 0u;
									uint fragment_unnamed_685 = fragment_unnamed_683 ? 4294967295u : 0u;
									uint fragment_unnamed_689 = fragment_unnamed_682 ? fragment_unnamed_616 : asuint(mad((-0.0f) - fragment_unnamed_190, 2.0f, fragment_unnamed_617));
									float fragment_unnamed_690 = asfloat(fragment_unnamed_689);
									uint fragment_unnamed_694 = fragment_unnamed_682 ? fragment_unnamed_621 : asuint(mad((-0.0f) - fragment_unnamed_196, 2.0f, fragment_unnamed_622));
									float fragment_unnamed_695 = asfloat(fragment_unnamed_694);
									uint fragment_unnamed_701 = fragment_unnamed_683 ? fragment_unnamed_628 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_629));
									float fragment_unnamed_702 = asfloat(fragment_unnamed_701);
									uint fragment_unnamed_706 = fragment_unnamed_683 ? fragment_unnamed_633 : asuint(mad(fragment_unnamed_196, 2.0f, asfloat(fragment_unnamed_633)));
									float fragment_unnamed_636;
									float fragment_unnamed_637;
									float fragment_unnamed_638;
									float fragment_unnamed_639;
									float fragment_unnamed_640;
									uint fragment_unnamed_641;
									if (((~fragment_unnamed_685) | (~fragment_unnamed_684)) != 0u)
									{
										float fragment_unnamed_726;
										if (fragment_unnamed_684 == 0u)
										{
											fragment_unnamed_726 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_690, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_695, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
										}
										else
										{
											fragment_unnamed_726 = fragment_unnamed_673;
										}
										float fragment_unnamed_740;
										if (fragment_unnamed_685 == 0u)
										{
											fragment_unnamed_740 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_702, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_706), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
										}
										else
										{
											fragment_unnamed_740 = fragment_unnamed_679;
										}
										float fragment_unnamed_746 = asfloat(fragment_unnamed_682 ? asuint(fragment_unnamed_726) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_726)));
										float fragment_unnamed_752 = asfloat(fragment_unnamed_683 ? asuint(fragment_unnamed_740) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_740)));
										bool fragment_unnamed_755 = abs(fragment_unnamed_746) >= fragment_unnamed_243;
										bool fragment_unnamed_756 = abs(fragment_unnamed_752) >= fragment_unnamed_243;
										uint fragment_unnamed_757 = fragment_unnamed_755 ? 4294967295u : 0u;
										uint fragment_unnamed_758 = fragment_unnamed_756 ? 4294967295u : 0u;
										uint fragment_unnamed_762 = fragment_unnamed_755 ? fragment_unnamed_689 : asuint(mad((-0.0f) - fragment_unnamed_190, 2.0f, fragment_unnamed_690));
										float fragment_unnamed_763 = asfloat(fragment_unnamed_762);
										uint fragment_unnamed_767 = fragment_unnamed_755 ? fragment_unnamed_694 : asuint(mad((-0.0f) - fragment_unnamed_196, 2.0f, fragment_unnamed_695));
										float fragment_unnamed_768 = asfloat(fragment_unnamed_767);
										uint fragment_unnamed_774 = fragment_unnamed_756 ? fragment_unnamed_701 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_702));
										float fragment_unnamed_775 = asfloat(fragment_unnamed_774);
										uint fragment_unnamed_779 = fragment_unnamed_756 ? fragment_unnamed_706 : asuint(mad(fragment_unnamed_196, 2.0f, asfloat(fragment_unnamed_706)));
										float fragment_unnamed_709;
										float fragment_unnamed_710;
										float fragment_unnamed_711;
										float fragment_unnamed_712;
										float fragment_unnamed_713;
										uint fragment_unnamed_714;
										if (((~fragment_unnamed_758) | (~fragment_unnamed_757)) != 0u)
										{
											float fragment_unnamed_799;
											if (fragment_unnamed_757 == 0u)
											{
												fragment_unnamed_799 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_763, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_768, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
											}
											else
											{
												fragment_unnamed_799 = fragment_unnamed_746;
											}
											float fragment_unnamed_813;
											if (fragment_unnamed_758 == 0u)
											{
												fragment_unnamed_813 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_775, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_779), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
											}
											else
											{
												fragment_unnamed_813 = fragment_unnamed_752;
											}
											float fragment_unnamed_819 = asfloat(fragment_unnamed_755 ? asuint(fragment_unnamed_799) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_799)));
											float fragment_unnamed_825 = asfloat(fragment_unnamed_756 ? asuint(fragment_unnamed_813) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_813)));
											bool fragment_unnamed_828 = abs(fragment_unnamed_819) >= fragment_unnamed_243;
											bool fragment_unnamed_829 = abs(fragment_unnamed_825) >= fragment_unnamed_243;
											uint fragment_unnamed_830 = fragment_unnamed_828 ? 4294967295u : 0u;
											uint fragment_unnamed_831 = fragment_unnamed_829 ? 4294967295u : 0u;
											uint fragment_unnamed_835 = fragment_unnamed_828 ? fragment_unnamed_762 : asuint(mad((-0.0f) - fragment_unnamed_190, 2.0f, fragment_unnamed_763));
											float fragment_unnamed_836 = asfloat(fragment_unnamed_835);
											uint fragment_unnamed_840 = fragment_unnamed_828 ? fragment_unnamed_767 : asuint(mad((-0.0f) - fragment_unnamed_196, 2.0f, fragment_unnamed_768));
											float fragment_unnamed_841 = asfloat(fragment_unnamed_840);
											uint fragment_unnamed_847 = fragment_unnamed_829 ? fragment_unnamed_774 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_775));
											float fragment_unnamed_848 = asfloat(fragment_unnamed_847);
											uint fragment_unnamed_852 = fragment_unnamed_829 ? fragment_unnamed_779 : asuint(mad(fragment_unnamed_196, 2.0f, asfloat(fragment_unnamed_779)));
											float fragment_unnamed_782;
											float fragment_unnamed_783;
											float fragment_unnamed_784;
											float fragment_unnamed_785;
											float fragment_unnamed_786;
											uint fragment_unnamed_787;
											if (((~fragment_unnamed_831) | (~fragment_unnamed_830)) != 0u)
											{
												float fragment_unnamed_872;
												if (fragment_unnamed_830 == 0u)
												{
													fragment_unnamed_872 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_836, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_841, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
												}
												else
												{
													fragment_unnamed_872 = fragment_unnamed_819;
												}
												float fragment_unnamed_886;
												if (fragment_unnamed_831 == 0u)
												{
													fragment_unnamed_886 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_848, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_852), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
												}
												else
												{
													fragment_unnamed_886 = fragment_unnamed_825;
												}
												float fragment_unnamed_892 = asfloat(fragment_unnamed_828 ? asuint(fragment_unnamed_872) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_872)));
												float fragment_unnamed_898 = asfloat(fragment_unnamed_829 ? asuint(fragment_unnamed_886) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_886)));
												bool fragment_unnamed_901 = abs(fragment_unnamed_892) >= fragment_unnamed_243;
												bool fragment_unnamed_902 = abs(fragment_unnamed_898) >= fragment_unnamed_243;
												uint fragment_unnamed_903 = fragment_unnamed_901 ? 4294967295u : 0u;
												uint fragment_unnamed_904 = fragment_unnamed_902 ? 4294967295u : 0u;
												uint fragment_unnamed_908 = fragment_unnamed_901 ? fragment_unnamed_835 : asuint(mad((-0.0f) - fragment_unnamed_190, 2.0f, fragment_unnamed_836));
												float fragment_unnamed_909 = asfloat(fragment_unnamed_908);
												uint fragment_unnamed_913 = fragment_unnamed_901 ? fragment_unnamed_840 : asuint(mad((-0.0f) - fragment_unnamed_196, 2.0f, fragment_unnamed_841));
												float fragment_unnamed_914 = asfloat(fragment_unnamed_913);
												uint fragment_unnamed_920 = fragment_unnamed_902 ? fragment_unnamed_847 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_848));
												float fragment_unnamed_921 = asfloat(fragment_unnamed_920);
												uint fragment_unnamed_925 = fragment_unnamed_902 ? fragment_unnamed_852 : asuint(mad(fragment_unnamed_196, 2.0f, asfloat(fragment_unnamed_852)));
												float fragment_unnamed_855;
												float fragment_unnamed_856;
												float fragment_unnamed_857;
												float fragment_unnamed_858;
												float fragment_unnamed_859;
												uint fragment_unnamed_860;
												if (((~fragment_unnamed_904) | (~fragment_unnamed_903)) != 0u)
												{
													float fragment_unnamed_945;
													if (fragment_unnamed_903 == 0u)
													{
														fragment_unnamed_945 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_909, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_914, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
													}
													else
													{
														fragment_unnamed_945 = fragment_unnamed_892;
													}
													float fragment_unnamed_959;
													if (fragment_unnamed_904 == 0u)
													{
														fragment_unnamed_959 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_921, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_925), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
													}
													else
													{
														fragment_unnamed_959 = fragment_unnamed_898;
													}
													float fragment_unnamed_965 = asfloat(fragment_unnamed_901 ? asuint(fragment_unnamed_945) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_945)));
													float fragment_unnamed_971 = asfloat(fragment_unnamed_902 ? asuint(fragment_unnamed_959) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_959)));
													bool fragment_unnamed_974 = abs(fragment_unnamed_965) >= fragment_unnamed_243;
													bool fragment_unnamed_975 = abs(fragment_unnamed_971) >= fragment_unnamed_243;
													uint fragment_unnamed_976 = fragment_unnamed_974 ? 4294967295u : 0u;
													uint fragment_unnamed_977 = fragment_unnamed_975 ? 4294967295u : 0u;
													uint fragment_unnamed_982 = fragment_unnamed_974 ? fragment_unnamed_908 : asuint(mad((-0.0f) - fragment_unnamed_190, 4.0f, fragment_unnamed_909));
													float fragment_unnamed_983 = asfloat(fragment_unnamed_982);
													uint fragment_unnamed_987 = fragment_unnamed_974 ? fragment_unnamed_913 : asuint(mad((-0.0f) - fragment_unnamed_196, 4.0f, fragment_unnamed_914));
													float fragment_unnamed_988 = asfloat(fragment_unnamed_987);
													uint fragment_unnamed_994 = fragment_unnamed_975 ? fragment_unnamed_920 : asuint(mad(fragment_unnamed_190, 4.0f, fragment_unnamed_921));
													float fragment_unnamed_995 = asfloat(fragment_unnamed_994);
													uint fragment_unnamed_999 = fragment_unnamed_975 ? fragment_unnamed_925 : asuint(mad(fragment_unnamed_196, 4.0f, asfloat(fragment_unnamed_925)));
													float fragment_unnamed_928;
													float fragment_unnamed_929;
													float fragment_unnamed_930;
													float fragment_unnamed_931;
													float fragment_unnamed_932;
													uint fragment_unnamed_933;
													if (((~fragment_unnamed_977) | (~fragment_unnamed_976)) != 0u)
													{
														float fragment_unnamed_1019;
														if (fragment_unnamed_976 == 0u)
														{
															fragment_unnamed_1019 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_983, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_988, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
														}
														else
														{
															fragment_unnamed_1019 = fragment_unnamed_965;
														}
														float fragment_unnamed_1033;
														if (fragment_unnamed_977 == 0u)
														{
															fragment_unnamed_1033 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_995, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_999), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
														}
														else
														{
															fragment_unnamed_1033 = fragment_unnamed_971;
														}
														float fragment_unnamed_1002 = asfloat(fragment_unnamed_974 ? asuint(fragment_unnamed_1019) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_1019)));
														float fragment_unnamed_1003 = asfloat(fragment_unnamed_975 ? asuint(fragment_unnamed_1033) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_1033)));
														bool fragment_unnamed_1046 = abs(fragment_unnamed_1002) >= fragment_unnamed_243;
														bool fragment_unnamed_1047 = abs(fragment_unnamed_1003) >= fragment_unnamed_243;
														fragment_unnamed_928 = fragment_unnamed_1002;
														fragment_unnamed_929 = fragment_unnamed_1003;
														fragment_unnamed_930 = asfloat(fragment_unnamed_1046 ? fragment_unnamed_982 : asuint(mad((-0.0f) - fragment_unnamed_190, 8.0f, fragment_unnamed_983)));
														fragment_unnamed_931 = asfloat(fragment_unnamed_1047 ? fragment_unnamed_994 : asuint(mad(fragment_unnamed_190, 8.0f, fragment_unnamed_995)));
														fragment_unnamed_932 = asfloat(fragment_unnamed_1046 ? fragment_unnamed_987 : asuint(mad((-0.0f) - fragment_unnamed_196, 8.0f, fragment_unnamed_988)));
														fragment_unnamed_933 = fragment_unnamed_1047 ? fragment_unnamed_999 : asuint(mad(fragment_unnamed_196, 8.0f, asfloat(fragment_unnamed_999)));
													}
													else
													{
														fragment_unnamed_928 = fragment_unnamed_965;
														fragment_unnamed_929 = fragment_unnamed_971;
														fragment_unnamed_930 = fragment_unnamed_983;
														fragment_unnamed_931 = fragment_unnamed_995;
														fragment_unnamed_932 = fragment_unnamed_988;
														fragment_unnamed_933 = fragment_unnamed_999;
													}
													fragment_unnamed_855 = fragment_unnamed_928;
													fragment_unnamed_856 = fragment_unnamed_929;
													fragment_unnamed_857 = fragment_unnamed_930;
													fragment_unnamed_858 = fragment_unnamed_931;
													fragment_unnamed_859 = fragment_unnamed_932;
													fragment_unnamed_860 = fragment_unnamed_933;
												}
												else
												{
													fragment_unnamed_855 = fragment_unnamed_892;
													fragment_unnamed_856 = fragment_unnamed_898;
													fragment_unnamed_857 = fragment_unnamed_909;
													fragment_unnamed_858 = fragment_unnamed_921;
													fragment_unnamed_859 = fragment_unnamed_914;
													fragment_unnamed_860 = fragment_unnamed_925;
												}
												fragment_unnamed_782 = fragment_unnamed_855;
												fragment_unnamed_783 = fragment_unnamed_856;
												fragment_unnamed_784 = fragment_unnamed_857;
												fragment_unnamed_785 = fragment_unnamed_858;
												fragment_unnamed_786 = fragment_unnamed_859;
												fragment_unnamed_787 = fragment_unnamed_860;
											}
											else
											{
												fragment_unnamed_782 = fragment_unnamed_819;
												fragment_unnamed_783 = fragment_unnamed_825;
												fragment_unnamed_784 = fragment_unnamed_836;
												fragment_unnamed_785 = fragment_unnamed_848;
												fragment_unnamed_786 = fragment_unnamed_841;
												fragment_unnamed_787 = fragment_unnamed_852;
											}
											fragment_unnamed_709 = fragment_unnamed_782;
											fragment_unnamed_710 = fragment_unnamed_783;
											fragment_unnamed_711 = fragment_unnamed_784;
											fragment_unnamed_712 = fragment_unnamed_785;
											fragment_unnamed_713 = fragment_unnamed_786;
											fragment_unnamed_714 = fragment_unnamed_787;
										}
										else
										{
											fragment_unnamed_709 = fragment_unnamed_746;
											fragment_unnamed_710 = fragment_unnamed_752;
											fragment_unnamed_711 = fragment_unnamed_763;
											fragment_unnamed_712 = fragment_unnamed_775;
											fragment_unnamed_713 = fragment_unnamed_768;
											fragment_unnamed_714 = fragment_unnamed_779;
										}
										fragment_unnamed_636 = fragment_unnamed_709;
										fragment_unnamed_637 = fragment_unnamed_710;
										fragment_unnamed_638 = fragment_unnamed_711;
										fragment_unnamed_639 = fragment_unnamed_712;
										fragment_unnamed_640 = fragment_unnamed_713;
										fragment_unnamed_641 = fragment_unnamed_714;
									}
									else
									{
										fragment_unnamed_636 = fragment_unnamed_673;
										fragment_unnamed_637 = fragment_unnamed_679;
										fragment_unnamed_638 = fragment_unnamed_690;
										fragment_unnamed_639 = fragment_unnamed_702;
										fragment_unnamed_640 = fragment_unnamed_695;
										fragment_unnamed_641 = fragment_unnamed_706;
									}
									fragment_unnamed_563 = fragment_unnamed_636;
									fragment_unnamed_564 = fragment_unnamed_637;
									fragment_unnamed_565 = fragment_unnamed_638;
									fragment_unnamed_566 = fragment_unnamed_639;
									fragment_unnamed_567 = fragment_unnamed_640;
									fragment_unnamed_568 = fragment_unnamed_641;
								}
								else
								{
									fragment_unnamed_563 = fragment_unnamed_600;
									fragment_unnamed_564 = fragment_unnamed_606;
									fragment_unnamed_565 = fragment_unnamed_617;
									fragment_unnamed_566 = fragment_unnamed_629;
									fragment_unnamed_567 = fragment_unnamed_622;
									fragment_unnamed_568 = fragment_unnamed_633;
								}
								fragment_unnamed_490 = fragment_unnamed_563;
								fragment_unnamed_491 = fragment_unnamed_564;
								fragment_unnamed_492 = fragment_unnamed_565;
								fragment_unnamed_493 = fragment_unnamed_566;
								fragment_unnamed_494 = fragment_unnamed_567;
								fragment_unnamed_495 = fragment_unnamed_568;
							}
							else
							{
								fragment_unnamed_490 = fragment_unnamed_527;
								fragment_unnamed_491 = fragment_unnamed_533;
								fragment_unnamed_492 = fragment_unnamed_544;
								fragment_unnamed_493 = fragment_unnamed_556;
								fragment_unnamed_494 = fragment_unnamed_549;
								fragment_unnamed_495 = fragment_unnamed_560;
							}
							fragment_unnamed_345 = fragment_unnamed_490;
							fragment_unnamed_347 = fragment_unnamed_491;
							fragment_unnamed_349 = fragment_unnamed_492;
							fragment_unnamed_351 = fragment_unnamed_493;
							fragment_unnamed_353 = fragment_unnamed_494;
							fragment_unnamed_355 = fragment_unnamed_495;
						}
						else
						{
							fragment_unnamed_345 = fragment_unnamed_454;
							fragment_unnamed_347 = fragment_unnamed_460;
							fragment_unnamed_349 = fragment_unnamed_471;
							fragment_unnamed_351 = fragment_unnamed_483;
							fragment_unnamed_353 = fragment_unnamed_476;
							fragment_unnamed_355 = fragment_unnamed_487;
						}
						fragment_unnamed_344 = fragment_unnamed_345;
						fragment_unnamed_346 = fragment_unnamed_347;
						fragment_unnamed_348 = fragment_unnamed_349;
						fragment_unnamed_350 = fragment_unnamed_351;
						fragment_unnamed_352 = fragment_unnamed_353;
						fragment_unnamed_354 = fragment_unnamed_355;
					}
					else
					{
						fragment_unnamed_344 = fragment_unnamed_251;
						fragment_unnamed_346 = fragment_unnamed_253;
						fragment_unnamed_348 = fragment_unnamed_266;
						fragment_unnamed_350 = fragment_unnamed_280;
						fragment_unnamed_352 = fragment_unnamed_272;
						fragment_unnamed_354 = fragment_unnamed_284;
					}
					float fragment_unnamed_371 = asfloat(fragment_unnamed_141 ? asuint(((-0.0f) - fragment_unnamed_348) + fragment_input_1.x) : asuint(((-0.0f) - fragment_unnamed_352) + fragment_input_1.y));
					float fragment_unnamed_380 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_350 + ((-0.0f) - fragment_input_1.x)) : asuint(asfloat(fragment_unnamed_354) + ((-0.0f) - fragment_input_1.y)));
					float fragment_unnamed_400 = max(fragment_unnamed_247 * fragment_unnamed_247, asfloat(asuint(mad(min(fragment_unnamed_371, fragment_unnamed_380), (-0.0f) - (1.0f / (fragment_unnamed_371 + fragment_unnamed_380)), 0.5f)) & ((fragment_unnamed_371 < fragment_unnamed_380) ? ((fragment_unnamed_249 != ((fragment_unnamed_344 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_249 != ((fragment_unnamed_346 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					float4 fragment_unnamed_421 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_141 ? fragment_input_1.x : mad(fragment_unnamed_400, fragment_unnamed_181, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_141 ? mad(fragment_unnamed_400, fragment_unnamed_181, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f);
					fragment_unnamed_286 = fragment_unnamed_421.x;
					fragment_unnamed_288 = fragment_unnamed_421.y;
					fragment_unnamed_290 = fragment_unnamed_421.z;
				}
				else
				{
					fragment_unnamed_286 = fragment_unnamed_54.x;
					fragment_unnamed_288 = fragment_unnamed_57;
					fragment_unnamed_290 = fragment_unnamed_54.z;
				}
				float fragment_unnamed_319 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				float fragment_unnamed_331 = (((-0.0f) - sqrt(((-0.0f) - abs(fragment_unnamed_319)) + 1.0f)) + 1.0f) * mad(clamp(mad(fragment_unnamed_319, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_331, 0.0039215688593685626983642578125f, fragment_unnamed_286);
				fragment_output_0.y = mad(fragment_unnamed_331, 0.0039215688593685626983642578125f, fragment_unnamed_288);
				fragment_output_0.z = mad(fragment_unnamed_331, 0.0039215688593685626983642578125f, fragment_unnamed_290);
				fragment_output_0.w = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[29] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA) && defined(FXAA_KEEP_ALPHA) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_LOW)


			#if defined(FXAA) && defined(FXAA_KEEP_ALPHA) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float _DepthSlice;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
			static float4 gl_Position;
			static uint gl_Layer;
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
				uint gl_Layer : SV_RenderTargetArrayIndex;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				float vertex_unnamed_59 = mad((vertex_input_0.x + 1.0f) * vertex_uniform_buffer_0[27u].x, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_61 = mad((vertex_input_0.y + 1.0f) * vertex_uniform_buffer_0[27u].y, 0.5f, vertex_uniform_buffer_0[27u].w);
				vertex_output_1.x = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = vertex_unnamed_61 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_59;
				vertex_output_1.y = vertex_unnamed_61;
				gl_Layer = int(uint(vertex_uniform_buffer_0[26u].y));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[26] = float4(vertex_uniform_buffer_0[26][0], _DepthSlice, vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.gl_Layer = gl_Layer;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_52 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float fragment_unnamed_53 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_56 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f);
				float fragment_unnamed_59 = fragment_unnamed_56.y;
				float4 fragment_unnamed_64 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(0, 1));
				float fragment_unnamed_68 = fragment_unnamed_64.y;
				float4 fragment_unnamed_69 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, 0));
				float fragment_unnamed_72 = fragment_unnamed_69.y;
				float4 fragment_unnamed_74 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(0, -1));
				float fragment_unnamed_77 = fragment_unnamed_74.y;
				float4 fragment_unnamed_78 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, 0));
				float fragment_unnamed_81 = fragment_unnamed_78.y;
				float fragment_unnamed_88 = max(max(fragment_unnamed_72, max(fragment_unnamed_59, fragment_unnamed_68)), max(fragment_unnamed_77, fragment_unnamed_81));
				float fragment_unnamed_94 = ((-0.0f) - min(min(fragment_unnamed_72, min(fragment_unnamed_59, fragment_unnamed_68)), min(fragment_unnamed_77, fragment_unnamed_81))) + fragment_unnamed_88;
				float fragment_unnamed_288;
				float fragment_unnamed_290;
				float fragment_unnamed_292;
				if (fragment_unnamed_94 >= max(fragment_unnamed_88 * 0.063000001013278961181640625f, 0.031199999153614044189453125f))
				{
					float4 fragment_unnamed_100 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, -1));
					float fragment_unnamed_103 = fragment_unnamed_100.y;
					float4 fragment_unnamed_104 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, 1));
					float fragment_unnamed_107 = fragment_unnamed_104.y;
					float4 fragment_unnamed_108 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, -1));
					float fragment_unnamed_111 = fragment_unnamed_108.y;
					float4 fragment_unnamed_112 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, 1));
					float fragment_unnamed_115 = fragment_unnamed_112.y;
					float fragment_unnamed_116 = fragment_unnamed_68 + fragment_unnamed_77;
					float fragment_unnamed_117 = fragment_unnamed_72 + fragment_unnamed_81;
					float fragment_unnamed_123 = fragment_unnamed_107 + fragment_unnamed_111;
					float fragment_unnamed_127 = fragment_unnamed_115 + fragment_unnamed_103;
					bool fragment_unnamed_143 = (mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_116)), 2.0f, abs(mad(fragment_unnamed_72, -2.0f, fragment_unnamed_123))) + abs(mad(fragment_unnamed_81, -2.0f, fragment_unnamed_127))) >= (mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_117)), 2.0f, abs(mad(fragment_unnamed_77, -2.0f, fragment_unnamed_103 + fragment_unnamed_111))) + abs(mad(fragment_unnamed_68, -2.0f, fragment_unnamed_107 + fragment_unnamed_115)));
					float fragment_unnamed_150 = asfloat(fragment_unnamed_143 ? asuint(fragment_unnamed_77) : asuint(fragment_unnamed_81));
					float fragment_unnamed_154 = asfloat(fragment_unnamed_143 ? asuint(fragment_unnamed_68) : asuint(fragment_unnamed_72));
					float fragment_unnamed_166 = asfloat(fragment_unnamed_143 ? asuint(fragment_uniform_buffer_0[29u]).y : asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_171 = ((-0.0f) - fragment_unnamed_59) + fragment_unnamed_150;
					float fragment_unnamed_173 = ((-0.0f) - fragment_unnamed_59) + fragment_unnamed_154;
					bool fragment_unnamed_178 = abs(fragment_unnamed_171) >= abs(fragment_unnamed_173);
					float fragment_unnamed_183 = fragment_unnamed_178 ? ((-0.0f) - fragment_unnamed_166) : fragment_unnamed_166;
					float fragment_unnamed_186 = clamp((1.0f / fragment_unnamed_94) * abs(mad(mad(fragment_unnamed_116 + fragment_unnamed_117, 2.0f, fragment_unnamed_123 + fragment_unnamed_127), 0.083333335816860198974609375f, (-0.0f) - fragment_unnamed_59)), 0.0f, 1.0f);
					float fragment_unnamed_192 = asfloat((fragment_unnamed_143 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_198 = asfloat(fragment_unnamed_143 ? 0u : asuint(fragment_uniform_buffer_0[29u]).y);
					float fragment_unnamed_208 = fragment_unnamed_143 ? fragment_input_1.x : mad(fragment_unnamed_183, 0.5f, fragment_input_1.x);
					float fragment_unnamed_211 = fragment_unnamed_143 ? mad(fragment_unnamed_183, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					float fragment_unnamed_214 = ((-0.0f) - fragment_unnamed_192) + fragment_unnamed_208;
					float fragment_unnamed_215 = ((-0.0f) - fragment_unnamed_198) + fragment_unnamed_211;
					float fragment_unnamed_216 = fragment_unnamed_192 + fragment_unnamed_208;
					float fragment_unnamed_217 = fragment_unnamed_198 + fragment_unnamed_211;
					float fragment_unnamed_244 = asfloat(fragment_unnamed_178 ? asuint(fragment_unnamed_59 + fragment_unnamed_150) : asuint(fragment_unnamed_59 + fragment_unnamed_154));
					float fragment_unnamed_245 = max(abs(fragment_unnamed_173), abs(fragment_unnamed_171)) * 0.25f;
					float fragment_unnamed_249 = (fragment_unnamed_186 * fragment_unnamed_186) * mad(fragment_unnamed_186, -2.0f, 3.0f);
					uint fragment_unnamed_251 = (mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_59) < 0.0f) ? 4294967295u : 0u;
					float fragment_unnamed_253 = mad((-0.0f) - fragment_unnamed_244, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_214, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_215, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y);
					float fragment_unnamed_255 = mad((-0.0f) - fragment_unnamed_244, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_216, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_217, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y);
					bool fragment_unnamed_258 = abs(fragment_unnamed_253) >= fragment_unnamed_245;
					bool fragment_unnamed_259 = abs(fragment_unnamed_255) >= fragment_unnamed_245;
					uint fragment_unnamed_260 = fragment_unnamed_258 ? 4294967295u : 0u;
					uint fragment_unnamed_261 = fragment_unnamed_259 ? 4294967295u : 0u;
					uint fragment_unnamed_267 = fragment_unnamed_258 ? asuint(fragment_unnamed_214) : asuint(mad((-0.0f) - fragment_unnamed_192, 1.5f, fragment_unnamed_214));
					float fragment_unnamed_268 = asfloat(fragment_unnamed_267);
					uint fragment_unnamed_273 = fragment_unnamed_258 ? asuint(fragment_unnamed_215) : asuint(mad((-0.0f) - fragment_unnamed_198, 1.5f, fragment_unnamed_215));
					float fragment_unnamed_274 = asfloat(fragment_unnamed_273);
					uint fragment_unnamed_281 = fragment_unnamed_259 ? asuint(fragment_unnamed_216) : asuint(mad(fragment_unnamed_192, 1.5f, fragment_unnamed_216));
					float fragment_unnamed_282 = asfloat(fragment_unnamed_281);
					uint fragment_unnamed_286 = fragment_unnamed_259 ? asuint(fragment_unnamed_217) : asuint(mad(fragment_unnamed_198, 1.5f, fragment_unnamed_217));
					float fragment_unnamed_346;
					float fragment_unnamed_348;
					float fragment_unnamed_350;
					float fragment_unnamed_352;
					float fragment_unnamed_354;
					uint fragment_unnamed_356;
					if (((~fragment_unnamed_261) | (~fragment_unnamed_260)) != 0u)
					{
						float fragment_unnamed_436;
						if (fragment_unnamed_260 == 0u)
						{
							fragment_unnamed_436 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_268, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_274, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
						}
						else
						{
							fragment_unnamed_436 = fragment_unnamed_253;
						}
						float fragment_unnamed_450;
						if (fragment_unnamed_261 == 0u)
						{
							fragment_unnamed_450 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_282, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_286), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
						}
						else
						{
							fragment_unnamed_450 = fragment_unnamed_255;
						}
						float fragment_unnamed_456 = asfloat(fragment_unnamed_258 ? asuint(fragment_unnamed_436) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_436)));
						float fragment_unnamed_462 = asfloat(fragment_unnamed_259 ? asuint(fragment_unnamed_450) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_450)));
						bool fragment_unnamed_465 = abs(fragment_unnamed_456) >= fragment_unnamed_245;
						bool fragment_unnamed_466 = abs(fragment_unnamed_462) >= fragment_unnamed_245;
						uint fragment_unnamed_467 = fragment_unnamed_465 ? 4294967295u : 0u;
						uint fragment_unnamed_468 = fragment_unnamed_466 ? 4294967295u : 0u;
						uint fragment_unnamed_472 = fragment_unnamed_465 ? fragment_unnamed_267 : asuint(mad((-0.0f) - fragment_unnamed_192, 2.0f, fragment_unnamed_268));
						float fragment_unnamed_473 = asfloat(fragment_unnamed_472);
						uint fragment_unnamed_477 = fragment_unnamed_465 ? fragment_unnamed_273 : asuint(mad((-0.0f) - fragment_unnamed_198, 2.0f, fragment_unnamed_274));
						float fragment_unnamed_478 = asfloat(fragment_unnamed_477);
						uint fragment_unnamed_484 = fragment_unnamed_466 ? fragment_unnamed_281 : asuint(mad(fragment_unnamed_192, 2.0f, fragment_unnamed_282));
						float fragment_unnamed_485 = asfloat(fragment_unnamed_484);
						uint fragment_unnamed_489 = fragment_unnamed_466 ? fragment_unnamed_286 : asuint(mad(fragment_unnamed_198, 2.0f, asfloat(fragment_unnamed_286)));
						float fragment_unnamed_347;
						float fragment_unnamed_349;
						float fragment_unnamed_351;
						float fragment_unnamed_353;
						float fragment_unnamed_355;
						uint fragment_unnamed_357;
						if (((~fragment_unnamed_468) | (~fragment_unnamed_467)) != 0u)
						{
							float fragment_unnamed_509;
							if (fragment_unnamed_467 == 0u)
							{
								fragment_unnamed_509 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_473, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_478, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
							}
							else
							{
								fragment_unnamed_509 = fragment_unnamed_456;
							}
							float fragment_unnamed_523;
							if (fragment_unnamed_468 == 0u)
							{
								fragment_unnamed_523 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_485, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_489), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
							}
							else
							{
								fragment_unnamed_523 = fragment_unnamed_462;
							}
							float fragment_unnamed_529 = asfloat(fragment_unnamed_465 ? asuint(fragment_unnamed_509) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_509)));
							float fragment_unnamed_535 = asfloat(fragment_unnamed_466 ? asuint(fragment_unnamed_523) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_523)));
							bool fragment_unnamed_538 = abs(fragment_unnamed_529) >= fragment_unnamed_245;
							bool fragment_unnamed_539 = abs(fragment_unnamed_535) >= fragment_unnamed_245;
							uint fragment_unnamed_540 = fragment_unnamed_538 ? 4294967295u : 0u;
							uint fragment_unnamed_541 = fragment_unnamed_539 ? 4294967295u : 0u;
							uint fragment_unnamed_545 = fragment_unnamed_538 ? fragment_unnamed_472 : asuint(mad((-0.0f) - fragment_unnamed_192, 2.0f, fragment_unnamed_473));
							float fragment_unnamed_546 = asfloat(fragment_unnamed_545);
							uint fragment_unnamed_550 = fragment_unnamed_538 ? fragment_unnamed_477 : asuint(mad((-0.0f) - fragment_unnamed_198, 2.0f, fragment_unnamed_478));
							float fragment_unnamed_551 = asfloat(fragment_unnamed_550);
							uint fragment_unnamed_557 = fragment_unnamed_539 ? fragment_unnamed_484 : asuint(mad(fragment_unnamed_192, 2.0f, fragment_unnamed_485));
							float fragment_unnamed_558 = asfloat(fragment_unnamed_557);
							uint fragment_unnamed_562 = fragment_unnamed_539 ? fragment_unnamed_489 : asuint(mad(fragment_unnamed_198, 2.0f, asfloat(fragment_unnamed_489)));
							float fragment_unnamed_492;
							float fragment_unnamed_493;
							float fragment_unnamed_494;
							float fragment_unnamed_495;
							float fragment_unnamed_496;
							uint fragment_unnamed_497;
							if (((~fragment_unnamed_541) | (~fragment_unnamed_540)) != 0u)
							{
								float fragment_unnamed_582;
								if (fragment_unnamed_540 == 0u)
								{
									fragment_unnamed_582 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_546, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_551, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
								}
								else
								{
									fragment_unnamed_582 = fragment_unnamed_529;
								}
								float fragment_unnamed_596;
								if (fragment_unnamed_541 == 0u)
								{
									fragment_unnamed_596 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_558, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_562), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
								}
								else
								{
									fragment_unnamed_596 = fragment_unnamed_535;
								}
								float fragment_unnamed_602 = asfloat(fragment_unnamed_538 ? asuint(fragment_unnamed_582) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_582)));
								float fragment_unnamed_608 = asfloat(fragment_unnamed_539 ? asuint(fragment_unnamed_596) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_596)));
								bool fragment_unnamed_611 = abs(fragment_unnamed_602) >= fragment_unnamed_245;
								bool fragment_unnamed_612 = abs(fragment_unnamed_608) >= fragment_unnamed_245;
								uint fragment_unnamed_613 = fragment_unnamed_611 ? 4294967295u : 0u;
								uint fragment_unnamed_614 = fragment_unnamed_612 ? 4294967295u : 0u;
								uint fragment_unnamed_618 = fragment_unnamed_611 ? fragment_unnamed_545 : asuint(mad((-0.0f) - fragment_unnamed_192, 2.0f, fragment_unnamed_546));
								float fragment_unnamed_619 = asfloat(fragment_unnamed_618);
								uint fragment_unnamed_623 = fragment_unnamed_611 ? fragment_unnamed_550 : asuint(mad((-0.0f) - fragment_unnamed_198, 2.0f, fragment_unnamed_551));
								float fragment_unnamed_624 = asfloat(fragment_unnamed_623);
								uint fragment_unnamed_630 = fragment_unnamed_612 ? fragment_unnamed_557 : asuint(mad(fragment_unnamed_192, 2.0f, fragment_unnamed_558));
								float fragment_unnamed_631 = asfloat(fragment_unnamed_630);
								uint fragment_unnamed_635 = fragment_unnamed_612 ? fragment_unnamed_562 : asuint(mad(fragment_unnamed_198, 2.0f, asfloat(fragment_unnamed_562)));
								float fragment_unnamed_565;
								float fragment_unnamed_566;
								float fragment_unnamed_567;
								float fragment_unnamed_568;
								float fragment_unnamed_569;
								uint fragment_unnamed_570;
								if (((~fragment_unnamed_614) | (~fragment_unnamed_613)) != 0u)
								{
									float fragment_unnamed_655;
									if (fragment_unnamed_613 == 0u)
									{
										fragment_unnamed_655 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_619, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_624, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
									}
									else
									{
										fragment_unnamed_655 = fragment_unnamed_602;
									}
									float fragment_unnamed_669;
									if (fragment_unnamed_614 == 0u)
									{
										fragment_unnamed_669 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_631, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_635), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
									}
									else
									{
										fragment_unnamed_669 = fragment_unnamed_608;
									}
									float fragment_unnamed_675 = asfloat(fragment_unnamed_611 ? asuint(fragment_unnamed_655) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_655)));
									float fragment_unnamed_681 = asfloat(fragment_unnamed_612 ? asuint(fragment_unnamed_669) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_669)));
									bool fragment_unnamed_684 = abs(fragment_unnamed_675) >= fragment_unnamed_245;
									bool fragment_unnamed_685 = abs(fragment_unnamed_681) >= fragment_unnamed_245;
									uint fragment_unnamed_686 = fragment_unnamed_684 ? 4294967295u : 0u;
									uint fragment_unnamed_687 = fragment_unnamed_685 ? 4294967295u : 0u;
									uint fragment_unnamed_691 = fragment_unnamed_684 ? fragment_unnamed_618 : asuint(mad((-0.0f) - fragment_unnamed_192, 2.0f, fragment_unnamed_619));
									float fragment_unnamed_692 = asfloat(fragment_unnamed_691);
									uint fragment_unnamed_696 = fragment_unnamed_684 ? fragment_unnamed_623 : asuint(mad((-0.0f) - fragment_unnamed_198, 2.0f, fragment_unnamed_624));
									float fragment_unnamed_697 = asfloat(fragment_unnamed_696);
									uint fragment_unnamed_703 = fragment_unnamed_685 ? fragment_unnamed_630 : asuint(mad(fragment_unnamed_192, 2.0f, fragment_unnamed_631));
									float fragment_unnamed_704 = asfloat(fragment_unnamed_703);
									uint fragment_unnamed_708 = fragment_unnamed_685 ? fragment_unnamed_635 : asuint(mad(fragment_unnamed_198, 2.0f, asfloat(fragment_unnamed_635)));
									float fragment_unnamed_638;
									float fragment_unnamed_639;
									float fragment_unnamed_640;
									float fragment_unnamed_641;
									float fragment_unnamed_642;
									uint fragment_unnamed_643;
									if (((~fragment_unnamed_687) | (~fragment_unnamed_686)) != 0u)
									{
										float fragment_unnamed_728;
										if (fragment_unnamed_686 == 0u)
										{
											fragment_unnamed_728 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_692, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_697, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
										}
										else
										{
											fragment_unnamed_728 = fragment_unnamed_675;
										}
										float fragment_unnamed_742;
										if (fragment_unnamed_687 == 0u)
										{
											fragment_unnamed_742 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_704, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_708), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
										}
										else
										{
											fragment_unnamed_742 = fragment_unnamed_681;
										}
										float fragment_unnamed_748 = asfloat(fragment_unnamed_684 ? asuint(fragment_unnamed_728) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_728)));
										float fragment_unnamed_754 = asfloat(fragment_unnamed_685 ? asuint(fragment_unnamed_742) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_742)));
										bool fragment_unnamed_757 = abs(fragment_unnamed_748) >= fragment_unnamed_245;
										bool fragment_unnamed_758 = abs(fragment_unnamed_754) >= fragment_unnamed_245;
										uint fragment_unnamed_759 = fragment_unnamed_757 ? 4294967295u : 0u;
										uint fragment_unnamed_760 = fragment_unnamed_758 ? 4294967295u : 0u;
										uint fragment_unnamed_764 = fragment_unnamed_757 ? fragment_unnamed_691 : asuint(mad((-0.0f) - fragment_unnamed_192, 2.0f, fragment_unnamed_692));
										float fragment_unnamed_765 = asfloat(fragment_unnamed_764);
										uint fragment_unnamed_769 = fragment_unnamed_757 ? fragment_unnamed_696 : asuint(mad((-0.0f) - fragment_unnamed_198, 2.0f, fragment_unnamed_697));
										float fragment_unnamed_770 = asfloat(fragment_unnamed_769);
										uint fragment_unnamed_776 = fragment_unnamed_758 ? fragment_unnamed_703 : asuint(mad(fragment_unnamed_192, 2.0f, fragment_unnamed_704));
										float fragment_unnamed_777 = asfloat(fragment_unnamed_776);
										uint fragment_unnamed_781 = fragment_unnamed_758 ? fragment_unnamed_708 : asuint(mad(fragment_unnamed_198, 2.0f, asfloat(fragment_unnamed_708)));
										float fragment_unnamed_711;
										float fragment_unnamed_712;
										float fragment_unnamed_713;
										float fragment_unnamed_714;
										float fragment_unnamed_715;
										uint fragment_unnamed_716;
										if (((~fragment_unnamed_760) | (~fragment_unnamed_759)) != 0u)
										{
											float fragment_unnamed_801;
											if (fragment_unnamed_759 == 0u)
											{
												fragment_unnamed_801 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_765, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_770, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
											}
											else
											{
												fragment_unnamed_801 = fragment_unnamed_748;
											}
											float fragment_unnamed_815;
											if (fragment_unnamed_760 == 0u)
											{
												fragment_unnamed_815 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_777, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_781), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
											}
											else
											{
												fragment_unnamed_815 = fragment_unnamed_754;
											}
											float fragment_unnamed_821 = asfloat(fragment_unnamed_757 ? asuint(fragment_unnamed_801) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_801)));
											float fragment_unnamed_827 = asfloat(fragment_unnamed_758 ? asuint(fragment_unnamed_815) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_815)));
											bool fragment_unnamed_830 = abs(fragment_unnamed_821) >= fragment_unnamed_245;
											bool fragment_unnamed_831 = abs(fragment_unnamed_827) >= fragment_unnamed_245;
											uint fragment_unnamed_832 = fragment_unnamed_830 ? 4294967295u : 0u;
											uint fragment_unnamed_833 = fragment_unnamed_831 ? 4294967295u : 0u;
											uint fragment_unnamed_837 = fragment_unnamed_830 ? fragment_unnamed_764 : asuint(mad((-0.0f) - fragment_unnamed_192, 2.0f, fragment_unnamed_765));
											float fragment_unnamed_838 = asfloat(fragment_unnamed_837);
											uint fragment_unnamed_842 = fragment_unnamed_830 ? fragment_unnamed_769 : asuint(mad((-0.0f) - fragment_unnamed_198, 2.0f, fragment_unnamed_770));
											float fragment_unnamed_843 = asfloat(fragment_unnamed_842);
											uint fragment_unnamed_849 = fragment_unnamed_831 ? fragment_unnamed_776 : asuint(mad(fragment_unnamed_192, 2.0f, fragment_unnamed_777));
											float fragment_unnamed_850 = asfloat(fragment_unnamed_849);
											uint fragment_unnamed_854 = fragment_unnamed_831 ? fragment_unnamed_781 : asuint(mad(fragment_unnamed_198, 2.0f, asfloat(fragment_unnamed_781)));
											float fragment_unnamed_784;
											float fragment_unnamed_785;
											float fragment_unnamed_786;
											float fragment_unnamed_787;
											float fragment_unnamed_788;
											uint fragment_unnamed_789;
											if (((~fragment_unnamed_833) | (~fragment_unnamed_832)) != 0u)
											{
												float fragment_unnamed_874;
												if (fragment_unnamed_832 == 0u)
												{
													fragment_unnamed_874 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_838, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_843, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
												}
												else
												{
													fragment_unnamed_874 = fragment_unnamed_821;
												}
												float fragment_unnamed_888;
												if (fragment_unnamed_833 == 0u)
												{
													fragment_unnamed_888 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_850, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_854), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
												}
												else
												{
													fragment_unnamed_888 = fragment_unnamed_827;
												}
												float fragment_unnamed_894 = asfloat(fragment_unnamed_830 ? asuint(fragment_unnamed_874) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_874)));
												float fragment_unnamed_900 = asfloat(fragment_unnamed_831 ? asuint(fragment_unnamed_888) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_888)));
												bool fragment_unnamed_903 = abs(fragment_unnamed_894) >= fragment_unnamed_245;
												bool fragment_unnamed_904 = abs(fragment_unnamed_900) >= fragment_unnamed_245;
												uint fragment_unnamed_905 = fragment_unnamed_903 ? 4294967295u : 0u;
												uint fragment_unnamed_906 = fragment_unnamed_904 ? 4294967295u : 0u;
												uint fragment_unnamed_910 = fragment_unnamed_903 ? fragment_unnamed_837 : asuint(mad((-0.0f) - fragment_unnamed_192, 2.0f, fragment_unnamed_838));
												float fragment_unnamed_911 = asfloat(fragment_unnamed_910);
												uint fragment_unnamed_915 = fragment_unnamed_903 ? fragment_unnamed_842 : asuint(mad((-0.0f) - fragment_unnamed_198, 2.0f, fragment_unnamed_843));
												float fragment_unnamed_916 = asfloat(fragment_unnamed_915);
												uint fragment_unnamed_922 = fragment_unnamed_904 ? fragment_unnamed_849 : asuint(mad(fragment_unnamed_192, 2.0f, fragment_unnamed_850));
												float fragment_unnamed_923 = asfloat(fragment_unnamed_922);
												uint fragment_unnamed_927 = fragment_unnamed_904 ? fragment_unnamed_854 : asuint(mad(fragment_unnamed_198, 2.0f, asfloat(fragment_unnamed_854)));
												float fragment_unnamed_857;
												float fragment_unnamed_858;
												float fragment_unnamed_859;
												float fragment_unnamed_860;
												float fragment_unnamed_861;
												uint fragment_unnamed_862;
												if (((~fragment_unnamed_906) | (~fragment_unnamed_905)) != 0u)
												{
													float fragment_unnamed_947;
													if (fragment_unnamed_905 == 0u)
													{
														fragment_unnamed_947 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_911, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_916, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
													}
													else
													{
														fragment_unnamed_947 = fragment_unnamed_894;
													}
													float fragment_unnamed_961;
													if (fragment_unnamed_906 == 0u)
													{
														fragment_unnamed_961 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_923, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_927), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
													}
													else
													{
														fragment_unnamed_961 = fragment_unnamed_900;
													}
													float fragment_unnamed_967 = asfloat(fragment_unnamed_903 ? asuint(fragment_unnamed_947) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_947)));
													float fragment_unnamed_973 = asfloat(fragment_unnamed_904 ? asuint(fragment_unnamed_961) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_961)));
													bool fragment_unnamed_976 = abs(fragment_unnamed_967) >= fragment_unnamed_245;
													bool fragment_unnamed_977 = abs(fragment_unnamed_973) >= fragment_unnamed_245;
													uint fragment_unnamed_978 = fragment_unnamed_976 ? 4294967295u : 0u;
													uint fragment_unnamed_979 = fragment_unnamed_977 ? 4294967295u : 0u;
													uint fragment_unnamed_984 = fragment_unnamed_976 ? fragment_unnamed_910 : asuint(mad((-0.0f) - fragment_unnamed_192, 4.0f, fragment_unnamed_911));
													float fragment_unnamed_985 = asfloat(fragment_unnamed_984);
													uint fragment_unnamed_989 = fragment_unnamed_976 ? fragment_unnamed_915 : asuint(mad((-0.0f) - fragment_unnamed_198, 4.0f, fragment_unnamed_916));
													float fragment_unnamed_990 = asfloat(fragment_unnamed_989);
													uint fragment_unnamed_996 = fragment_unnamed_977 ? fragment_unnamed_922 : asuint(mad(fragment_unnamed_192, 4.0f, fragment_unnamed_923));
													float fragment_unnamed_997 = asfloat(fragment_unnamed_996);
													uint fragment_unnamed_1001 = fragment_unnamed_977 ? fragment_unnamed_927 : asuint(mad(fragment_unnamed_198, 4.0f, asfloat(fragment_unnamed_927)));
													float fragment_unnamed_930;
													float fragment_unnamed_931;
													float fragment_unnamed_932;
													float fragment_unnamed_933;
													float fragment_unnamed_934;
													uint fragment_unnamed_935;
													if (((~fragment_unnamed_979) | (~fragment_unnamed_978)) != 0u)
													{
														float fragment_unnamed_1021;
														if (fragment_unnamed_978 == 0u)
														{
															fragment_unnamed_1021 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_985, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_990, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
														}
														else
														{
															fragment_unnamed_1021 = fragment_unnamed_967;
														}
														float fragment_unnamed_1035;
														if (fragment_unnamed_979 == 0u)
														{
															fragment_unnamed_1035 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_997, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_1001), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
														}
														else
														{
															fragment_unnamed_1035 = fragment_unnamed_973;
														}
														float fragment_unnamed_1004 = asfloat(fragment_unnamed_976 ? asuint(fragment_unnamed_1021) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_1021)));
														float fragment_unnamed_1005 = asfloat(fragment_unnamed_977 ? asuint(fragment_unnamed_1035) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_1035)));
														bool fragment_unnamed_1048 = abs(fragment_unnamed_1004) >= fragment_unnamed_245;
														bool fragment_unnamed_1049 = abs(fragment_unnamed_1005) >= fragment_unnamed_245;
														fragment_unnamed_930 = fragment_unnamed_1004;
														fragment_unnamed_931 = fragment_unnamed_1005;
														fragment_unnamed_932 = asfloat(fragment_unnamed_1048 ? fragment_unnamed_984 : asuint(mad((-0.0f) - fragment_unnamed_192, 8.0f, fragment_unnamed_985)));
														fragment_unnamed_933 = asfloat(fragment_unnamed_1049 ? fragment_unnamed_996 : asuint(mad(fragment_unnamed_192, 8.0f, fragment_unnamed_997)));
														fragment_unnamed_934 = asfloat(fragment_unnamed_1048 ? fragment_unnamed_989 : asuint(mad((-0.0f) - fragment_unnamed_198, 8.0f, fragment_unnamed_990)));
														fragment_unnamed_935 = fragment_unnamed_1049 ? fragment_unnamed_1001 : asuint(mad(fragment_unnamed_198, 8.0f, asfloat(fragment_unnamed_1001)));
													}
													else
													{
														fragment_unnamed_930 = fragment_unnamed_967;
														fragment_unnamed_931 = fragment_unnamed_973;
														fragment_unnamed_932 = fragment_unnamed_985;
														fragment_unnamed_933 = fragment_unnamed_997;
														fragment_unnamed_934 = fragment_unnamed_990;
														fragment_unnamed_935 = fragment_unnamed_1001;
													}
													fragment_unnamed_857 = fragment_unnamed_930;
													fragment_unnamed_858 = fragment_unnamed_931;
													fragment_unnamed_859 = fragment_unnamed_932;
													fragment_unnamed_860 = fragment_unnamed_933;
													fragment_unnamed_861 = fragment_unnamed_934;
													fragment_unnamed_862 = fragment_unnamed_935;
												}
												else
												{
													fragment_unnamed_857 = fragment_unnamed_894;
													fragment_unnamed_858 = fragment_unnamed_900;
													fragment_unnamed_859 = fragment_unnamed_911;
													fragment_unnamed_860 = fragment_unnamed_923;
													fragment_unnamed_861 = fragment_unnamed_916;
													fragment_unnamed_862 = fragment_unnamed_927;
												}
												fragment_unnamed_784 = fragment_unnamed_857;
												fragment_unnamed_785 = fragment_unnamed_858;
												fragment_unnamed_786 = fragment_unnamed_859;
												fragment_unnamed_787 = fragment_unnamed_860;
												fragment_unnamed_788 = fragment_unnamed_861;
												fragment_unnamed_789 = fragment_unnamed_862;
											}
											else
											{
												fragment_unnamed_784 = fragment_unnamed_821;
												fragment_unnamed_785 = fragment_unnamed_827;
												fragment_unnamed_786 = fragment_unnamed_838;
												fragment_unnamed_787 = fragment_unnamed_850;
												fragment_unnamed_788 = fragment_unnamed_843;
												fragment_unnamed_789 = fragment_unnamed_854;
											}
											fragment_unnamed_711 = fragment_unnamed_784;
											fragment_unnamed_712 = fragment_unnamed_785;
											fragment_unnamed_713 = fragment_unnamed_786;
											fragment_unnamed_714 = fragment_unnamed_787;
											fragment_unnamed_715 = fragment_unnamed_788;
											fragment_unnamed_716 = fragment_unnamed_789;
										}
										else
										{
											fragment_unnamed_711 = fragment_unnamed_748;
											fragment_unnamed_712 = fragment_unnamed_754;
											fragment_unnamed_713 = fragment_unnamed_765;
											fragment_unnamed_714 = fragment_unnamed_777;
											fragment_unnamed_715 = fragment_unnamed_770;
											fragment_unnamed_716 = fragment_unnamed_781;
										}
										fragment_unnamed_638 = fragment_unnamed_711;
										fragment_unnamed_639 = fragment_unnamed_712;
										fragment_unnamed_640 = fragment_unnamed_713;
										fragment_unnamed_641 = fragment_unnamed_714;
										fragment_unnamed_642 = fragment_unnamed_715;
										fragment_unnamed_643 = fragment_unnamed_716;
									}
									else
									{
										fragment_unnamed_638 = fragment_unnamed_675;
										fragment_unnamed_639 = fragment_unnamed_681;
										fragment_unnamed_640 = fragment_unnamed_692;
										fragment_unnamed_641 = fragment_unnamed_704;
										fragment_unnamed_642 = fragment_unnamed_697;
										fragment_unnamed_643 = fragment_unnamed_708;
									}
									fragment_unnamed_565 = fragment_unnamed_638;
									fragment_unnamed_566 = fragment_unnamed_639;
									fragment_unnamed_567 = fragment_unnamed_640;
									fragment_unnamed_568 = fragment_unnamed_641;
									fragment_unnamed_569 = fragment_unnamed_642;
									fragment_unnamed_570 = fragment_unnamed_643;
								}
								else
								{
									fragment_unnamed_565 = fragment_unnamed_602;
									fragment_unnamed_566 = fragment_unnamed_608;
									fragment_unnamed_567 = fragment_unnamed_619;
									fragment_unnamed_568 = fragment_unnamed_631;
									fragment_unnamed_569 = fragment_unnamed_624;
									fragment_unnamed_570 = fragment_unnamed_635;
								}
								fragment_unnamed_492 = fragment_unnamed_565;
								fragment_unnamed_493 = fragment_unnamed_566;
								fragment_unnamed_494 = fragment_unnamed_567;
								fragment_unnamed_495 = fragment_unnamed_568;
								fragment_unnamed_496 = fragment_unnamed_569;
								fragment_unnamed_497 = fragment_unnamed_570;
							}
							else
							{
								fragment_unnamed_492 = fragment_unnamed_529;
								fragment_unnamed_493 = fragment_unnamed_535;
								fragment_unnamed_494 = fragment_unnamed_546;
								fragment_unnamed_495 = fragment_unnamed_558;
								fragment_unnamed_496 = fragment_unnamed_551;
								fragment_unnamed_497 = fragment_unnamed_562;
							}
							fragment_unnamed_347 = fragment_unnamed_492;
							fragment_unnamed_349 = fragment_unnamed_493;
							fragment_unnamed_351 = fragment_unnamed_494;
							fragment_unnamed_353 = fragment_unnamed_495;
							fragment_unnamed_355 = fragment_unnamed_496;
							fragment_unnamed_357 = fragment_unnamed_497;
						}
						else
						{
							fragment_unnamed_347 = fragment_unnamed_456;
							fragment_unnamed_349 = fragment_unnamed_462;
							fragment_unnamed_351 = fragment_unnamed_473;
							fragment_unnamed_353 = fragment_unnamed_485;
							fragment_unnamed_355 = fragment_unnamed_478;
							fragment_unnamed_357 = fragment_unnamed_489;
						}
						fragment_unnamed_346 = fragment_unnamed_347;
						fragment_unnamed_348 = fragment_unnamed_349;
						fragment_unnamed_350 = fragment_unnamed_351;
						fragment_unnamed_352 = fragment_unnamed_353;
						fragment_unnamed_354 = fragment_unnamed_355;
						fragment_unnamed_356 = fragment_unnamed_357;
					}
					else
					{
						fragment_unnamed_346 = fragment_unnamed_253;
						fragment_unnamed_348 = fragment_unnamed_255;
						fragment_unnamed_350 = fragment_unnamed_268;
						fragment_unnamed_352 = fragment_unnamed_282;
						fragment_unnamed_354 = fragment_unnamed_274;
						fragment_unnamed_356 = fragment_unnamed_286;
					}
					float fragment_unnamed_373 = asfloat(fragment_unnamed_143 ? asuint(((-0.0f) - fragment_unnamed_350) + fragment_input_1.x) : asuint(((-0.0f) - fragment_unnamed_354) + fragment_input_1.y));
					float fragment_unnamed_382 = asfloat(fragment_unnamed_143 ? asuint(fragment_unnamed_352 + ((-0.0f) - fragment_input_1.x)) : asuint(asfloat(fragment_unnamed_356) + ((-0.0f) - fragment_input_1.y)));
					float fragment_unnamed_402 = max(fragment_unnamed_249 * fragment_unnamed_249, asfloat(asuint(mad(min(fragment_unnamed_373, fragment_unnamed_382), (-0.0f) - (1.0f / (fragment_unnamed_373 + fragment_unnamed_382)), 0.5f)) & ((fragment_unnamed_373 < fragment_unnamed_382) ? ((fragment_unnamed_251 != ((fragment_unnamed_346 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_251 != ((fragment_unnamed_348 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					float4 fragment_unnamed_423 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_143 ? fragment_input_1.x : mad(fragment_unnamed_402, fragment_unnamed_183, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_143 ? mad(fragment_unnamed_402, fragment_unnamed_183, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f);
					fragment_unnamed_288 = fragment_unnamed_423.x;
					fragment_unnamed_290 = fragment_unnamed_423.y;
					fragment_unnamed_292 = fragment_unnamed_423.z;
				}
				else
				{
					fragment_unnamed_288 = fragment_unnamed_56.x;
					fragment_unnamed_290 = fragment_unnamed_59;
					fragment_unnamed_292 = fragment_unnamed_56.z;
				}
				float fragment_unnamed_321 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				float fragment_unnamed_333 = (((-0.0f) - sqrt(((-0.0f) - abs(fragment_unnamed_321)) + 1.0f)) + 1.0f) * mad(clamp(mad(fragment_unnamed_321, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_333, 0.0039215688593685626983642578125f, fragment_unnamed_288);
				fragment_output_0.y = mad(fragment_unnamed_333, 0.0039215688593685626983642578125f, fragment_unnamed_290);
				fragment_output_0.z = mad(fragment_unnamed_333, 0.0039215688593685626983642578125f, fragment_unnamed_292);
				fragment_output_0.w = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[29] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA) && defined(FXAA_KEEP_ALPHA) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_LOW)


			#if defined(FXAA) && defined(FXAA_KEEP_ALPHA) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;
			float4 _PosScaleOffset;

			static float4 vertex_uniform_buffer_0[29];
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
				gl_Position.x = mad(vertex_input_0.x, vertex_uniform_buffer_0[28u].x, vertex_uniform_buffer_0[28u].z);
				gl_Position.y = mad(vertex_input_0.y, vertex_uniform_buffer_0[28u].y, vertex_uniform_buffer_0[28u].w);
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				float vertex_unnamed_68 = mad((vertex_input_0.x + 1.0f) * vertex_uniform_buffer_0[27u].x, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_70 = mad((vertex_input_0.y + 1.0f) * vertex_uniform_buffer_0[27u].y, 0.5f, vertex_uniform_buffer_0[27u].w);
				vertex_output_1.x = vertex_unnamed_68 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = vertex_unnamed_70 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_68;
				vertex_output_1.y = vertex_unnamed_70;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_uniform_buffer_0[28] = float4(_PosScaleOffset[0], _PosScaleOffset[1], _PosScaleOffset[2], _PosScaleOffset[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[31];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f);
				float fragment_unnamed_57 = fragment_unnamed_54.y;
				float4 fragment_unnamed_62 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, 1));
				float fragment_unnamed_66 = fragment_unnamed_62.y;
				float4 fragment_unnamed_67 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 0));
				float fragment_unnamed_70 = fragment_unnamed_67.y;
				float4 fragment_unnamed_72 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, -1));
				float fragment_unnamed_75 = fragment_unnamed_72.y;
				float4 fragment_unnamed_76 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 0));
				float fragment_unnamed_79 = fragment_unnamed_76.y;
				float fragment_unnamed_86 = max(max(fragment_unnamed_70, max(fragment_unnamed_57, fragment_unnamed_66)), max(fragment_unnamed_75, fragment_unnamed_79));
				float fragment_unnamed_92 = ((-0.0f) - min(min(fragment_unnamed_70, min(fragment_unnamed_57, fragment_unnamed_66)), min(fragment_unnamed_75, fragment_unnamed_79))) + fragment_unnamed_86;
				float fragment_unnamed_286;
				float fragment_unnamed_288;
				float fragment_unnamed_290;
				if (fragment_unnamed_92 >= max(fragment_unnamed_86 * 0.063000001013278961181640625f, 0.031199999153614044189453125f))
				{
					float4 fragment_unnamed_98 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, -1));
					float fragment_unnamed_101 = fragment_unnamed_98.y;
					float4 fragment_unnamed_102 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 1));
					float fragment_unnamed_105 = fragment_unnamed_102.y;
					float4 fragment_unnamed_106 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, -1));
					float fragment_unnamed_109 = fragment_unnamed_106.y;
					float4 fragment_unnamed_110 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 1));
					float fragment_unnamed_113 = fragment_unnamed_110.y;
					float fragment_unnamed_114 = fragment_unnamed_66 + fragment_unnamed_75;
					float fragment_unnamed_115 = fragment_unnamed_70 + fragment_unnamed_79;
					float fragment_unnamed_121 = fragment_unnamed_105 + fragment_unnamed_109;
					float fragment_unnamed_125 = fragment_unnamed_113 + fragment_unnamed_101;
					bool fragment_unnamed_141 = (mad(abs(mad(fragment_unnamed_57, -2.0f, fragment_unnamed_114)), 2.0f, abs(mad(fragment_unnamed_70, -2.0f, fragment_unnamed_121))) + abs(mad(fragment_unnamed_79, -2.0f, fragment_unnamed_125))) >= (mad(abs(mad(fragment_unnamed_57, -2.0f, fragment_unnamed_115)), 2.0f, abs(mad(fragment_unnamed_75, -2.0f, fragment_unnamed_101 + fragment_unnamed_109))) + abs(mad(fragment_unnamed_66, -2.0f, fragment_unnamed_105 + fragment_unnamed_113)));
					float fragment_unnamed_148 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_75) : asuint(fragment_unnamed_79));
					float fragment_unnamed_152 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_66) : asuint(fragment_unnamed_70));
					float fragment_unnamed_164 = asfloat(fragment_unnamed_141 ? asuint(fragment_uniform_buffer_0[30u]).y : asuint(fragment_uniform_buffer_0[30u]).x);
					float fragment_unnamed_169 = ((-0.0f) - fragment_unnamed_57) + fragment_unnamed_148;
					float fragment_unnamed_171 = ((-0.0f) - fragment_unnamed_57) + fragment_unnamed_152;
					bool fragment_unnamed_176 = abs(fragment_unnamed_169) >= abs(fragment_unnamed_171);
					float fragment_unnamed_181 = fragment_unnamed_176 ? ((-0.0f) - fragment_unnamed_164) : fragment_unnamed_164;
					float fragment_unnamed_184 = clamp((1.0f / fragment_unnamed_92) * abs(mad(mad(fragment_unnamed_114 + fragment_unnamed_115, 2.0f, fragment_unnamed_121 + fragment_unnamed_125), 0.083333335816860198974609375f, (-0.0f) - fragment_unnamed_57)), 0.0f, 1.0f);
					float fragment_unnamed_190 = asfloat((fragment_unnamed_141 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[30u]).x);
					float fragment_unnamed_196 = asfloat(fragment_unnamed_141 ? 0u : asuint(fragment_uniform_buffer_0[30u]).y);
					float fragment_unnamed_206 = fragment_unnamed_141 ? fragment_input_1.x : mad(fragment_unnamed_181, 0.5f, fragment_input_1.x);
					float fragment_unnamed_209 = fragment_unnamed_141 ? mad(fragment_unnamed_181, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					float fragment_unnamed_212 = ((-0.0f) - fragment_unnamed_190) + fragment_unnamed_206;
					float fragment_unnamed_213 = ((-0.0f) - fragment_unnamed_196) + fragment_unnamed_209;
					float fragment_unnamed_214 = fragment_unnamed_190 + fragment_unnamed_206;
					float fragment_unnamed_215 = fragment_unnamed_196 + fragment_unnamed_209;
					float fragment_unnamed_242 = asfloat(fragment_unnamed_176 ? asuint(fragment_unnamed_57 + fragment_unnamed_148) : asuint(fragment_unnamed_57 + fragment_unnamed_152));
					float fragment_unnamed_243 = max(abs(fragment_unnamed_171), abs(fragment_unnamed_169)) * 0.25f;
					float fragment_unnamed_247 = (fragment_unnamed_184 * fragment_unnamed_184) * mad(fragment_unnamed_184, -2.0f, 3.0f);
					uint fragment_unnamed_249 = (mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_57) < 0.0f) ? 4294967295u : 0u;
					float fragment_unnamed_251 = mad((-0.0f) - fragment_unnamed_242, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_212, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_213, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y);
					float fragment_unnamed_253 = mad((-0.0f) - fragment_unnamed_242, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_214, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_215, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y);
					bool fragment_unnamed_256 = abs(fragment_unnamed_251) >= fragment_unnamed_243;
					bool fragment_unnamed_257 = abs(fragment_unnamed_253) >= fragment_unnamed_243;
					uint fragment_unnamed_258 = fragment_unnamed_256 ? 4294967295u : 0u;
					uint fragment_unnamed_259 = fragment_unnamed_257 ? 4294967295u : 0u;
					uint fragment_unnamed_265 = fragment_unnamed_256 ? asuint(fragment_unnamed_212) : asuint(mad((-0.0f) - fragment_unnamed_190, 1.5f, fragment_unnamed_212));
					float fragment_unnamed_266 = asfloat(fragment_unnamed_265);
					uint fragment_unnamed_271 = fragment_unnamed_256 ? asuint(fragment_unnamed_213) : asuint(mad((-0.0f) - fragment_unnamed_196, 1.5f, fragment_unnamed_213));
					float fragment_unnamed_272 = asfloat(fragment_unnamed_271);
					uint fragment_unnamed_279 = fragment_unnamed_257 ? asuint(fragment_unnamed_214) : asuint(mad(fragment_unnamed_190, 1.5f, fragment_unnamed_214));
					float fragment_unnamed_280 = asfloat(fragment_unnamed_279);
					uint fragment_unnamed_284 = fragment_unnamed_257 ? asuint(fragment_unnamed_215) : asuint(mad(fragment_unnamed_196, 1.5f, fragment_unnamed_215));
					float fragment_unnamed_344;
					float fragment_unnamed_346;
					float fragment_unnamed_348;
					float fragment_unnamed_350;
					float fragment_unnamed_352;
					uint fragment_unnamed_354;
					if (((~fragment_unnamed_259) | (~fragment_unnamed_258)) != 0u)
					{
						float fragment_unnamed_434;
						if (fragment_unnamed_258 == 0u)
						{
							fragment_unnamed_434 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_266, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_272, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
						}
						else
						{
							fragment_unnamed_434 = fragment_unnamed_251;
						}
						float fragment_unnamed_448;
						if (fragment_unnamed_259 == 0u)
						{
							fragment_unnamed_448 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_280, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_284), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
						}
						else
						{
							fragment_unnamed_448 = fragment_unnamed_253;
						}
						float fragment_unnamed_454 = asfloat(fragment_unnamed_256 ? asuint(fragment_unnamed_434) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_434)));
						float fragment_unnamed_460 = asfloat(fragment_unnamed_257 ? asuint(fragment_unnamed_448) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_448)));
						bool fragment_unnamed_463 = abs(fragment_unnamed_454) >= fragment_unnamed_243;
						bool fragment_unnamed_464 = abs(fragment_unnamed_460) >= fragment_unnamed_243;
						uint fragment_unnamed_465 = fragment_unnamed_463 ? 4294967295u : 0u;
						uint fragment_unnamed_466 = fragment_unnamed_464 ? 4294967295u : 0u;
						uint fragment_unnamed_470 = fragment_unnamed_463 ? fragment_unnamed_265 : asuint(mad((-0.0f) - fragment_unnamed_190, 2.0f, fragment_unnamed_266));
						float fragment_unnamed_471 = asfloat(fragment_unnamed_470);
						uint fragment_unnamed_475 = fragment_unnamed_463 ? fragment_unnamed_271 : asuint(mad((-0.0f) - fragment_unnamed_196, 2.0f, fragment_unnamed_272));
						float fragment_unnamed_476 = asfloat(fragment_unnamed_475);
						uint fragment_unnamed_482 = fragment_unnamed_464 ? fragment_unnamed_279 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_280));
						float fragment_unnamed_483 = asfloat(fragment_unnamed_482);
						uint fragment_unnamed_487 = fragment_unnamed_464 ? fragment_unnamed_284 : asuint(mad(fragment_unnamed_196, 2.0f, asfloat(fragment_unnamed_284)));
						float fragment_unnamed_345;
						float fragment_unnamed_347;
						float fragment_unnamed_349;
						float fragment_unnamed_351;
						float fragment_unnamed_353;
						uint fragment_unnamed_355;
						if (((~fragment_unnamed_466) | (~fragment_unnamed_465)) != 0u)
						{
							float fragment_unnamed_507;
							if (fragment_unnamed_465 == 0u)
							{
								fragment_unnamed_507 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_471, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_476, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
							}
							else
							{
								fragment_unnamed_507 = fragment_unnamed_454;
							}
							float fragment_unnamed_521;
							if (fragment_unnamed_466 == 0u)
							{
								fragment_unnamed_521 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_483, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_487), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
							}
							else
							{
								fragment_unnamed_521 = fragment_unnamed_460;
							}
							float fragment_unnamed_527 = asfloat(fragment_unnamed_463 ? asuint(fragment_unnamed_507) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_507)));
							float fragment_unnamed_533 = asfloat(fragment_unnamed_464 ? asuint(fragment_unnamed_521) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_521)));
							bool fragment_unnamed_536 = abs(fragment_unnamed_527) >= fragment_unnamed_243;
							bool fragment_unnamed_537 = abs(fragment_unnamed_533) >= fragment_unnamed_243;
							uint fragment_unnamed_538 = fragment_unnamed_536 ? 4294967295u : 0u;
							uint fragment_unnamed_539 = fragment_unnamed_537 ? 4294967295u : 0u;
							uint fragment_unnamed_543 = fragment_unnamed_536 ? fragment_unnamed_470 : asuint(mad((-0.0f) - fragment_unnamed_190, 2.0f, fragment_unnamed_471));
							float fragment_unnamed_544 = asfloat(fragment_unnamed_543);
							uint fragment_unnamed_548 = fragment_unnamed_536 ? fragment_unnamed_475 : asuint(mad((-0.0f) - fragment_unnamed_196, 2.0f, fragment_unnamed_476));
							float fragment_unnamed_549 = asfloat(fragment_unnamed_548);
							uint fragment_unnamed_555 = fragment_unnamed_537 ? fragment_unnamed_482 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_483));
							float fragment_unnamed_556 = asfloat(fragment_unnamed_555);
							uint fragment_unnamed_560 = fragment_unnamed_537 ? fragment_unnamed_487 : asuint(mad(fragment_unnamed_196, 2.0f, asfloat(fragment_unnamed_487)));
							float fragment_unnamed_490;
							float fragment_unnamed_491;
							float fragment_unnamed_492;
							float fragment_unnamed_493;
							float fragment_unnamed_494;
							uint fragment_unnamed_495;
							if (((~fragment_unnamed_539) | (~fragment_unnamed_538)) != 0u)
							{
								float fragment_unnamed_580;
								if (fragment_unnamed_538 == 0u)
								{
									fragment_unnamed_580 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_544, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_549, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
								}
								else
								{
									fragment_unnamed_580 = fragment_unnamed_527;
								}
								float fragment_unnamed_594;
								if (fragment_unnamed_539 == 0u)
								{
									fragment_unnamed_594 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_556, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_560), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
								}
								else
								{
									fragment_unnamed_594 = fragment_unnamed_533;
								}
								float fragment_unnamed_600 = asfloat(fragment_unnamed_536 ? asuint(fragment_unnamed_580) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_580)));
								float fragment_unnamed_606 = asfloat(fragment_unnamed_537 ? asuint(fragment_unnamed_594) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_594)));
								bool fragment_unnamed_609 = abs(fragment_unnamed_600) >= fragment_unnamed_243;
								bool fragment_unnamed_610 = abs(fragment_unnamed_606) >= fragment_unnamed_243;
								uint fragment_unnamed_611 = fragment_unnamed_609 ? 4294967295u : 0u;
								uint fragment_unnamed_612 = fragment_unnamed_610 ? 4294967295u : 0u;
								uint fragment_unnamed_616 = fragment_unnamed_609 ? fragment_unnamed_543 : asuint(mad((-0.0f) - fragment_unnamed_190, 2.0f, fragment_unnamed_544));
								float fragment_unnamed_617 = asfloat(fragment_unnamed_616);
								uint fragment_unnamed_621 = fragment_unnamed_609 ? fragment_unnamed_548 : asuint(mad((-0.0f) - fragment_unnamed_196, 2.0f, fragment_unnamed_549));
								float fragment_unnamed_622 = asfloat(fragment_unnamed_621);
								uint fragment_unnamed_628 = fragment_unnamed_610 ? fragment_unnamed_555 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_556));
								float fragment_unnamed_629 = asfloat(fragment_unnamed_628);
								uint fragment_unnamed_633 = fragment_unnamed_610 ? fragment_unnamed_560 : asuint(mad(fragment_unnamed_196, 2.0f, asfloat(fragment_unnamed_560)));
								float fragment_unnamed_563;
								float fragment_unnamed_564;
								float fragment_unnamed_565;
								float fragment_unnamed_566;
								float fragment_unnamed_567;
								uint fragment_unnamed_568;
								if (((~fragment_unnamed_612) | (~fragment_unnamed_611)) != 0u)
								{
									float fragment_unnamed_653;
									if (fragment_unnamed_611 == 0u)
									{
										fragment_unnamed_653 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_617, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_622, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
									}
									else
									{
										fragment_unnamed_653 = fragment_unnamed_600;
									}
									float fragment_unnamed_667;
									if (fragment_unnamed_612 == 0u)
									{
										fragment_unnamed_667 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_629, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_633), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
									}
									else
									{
										fragment_unnamed_667 = fragment_unnamed_606;
									}
									float fragment_unnamed_673 = asfloat(fragment_unnamed_609 ? asuint(fragment_unnamed_653) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_653)));
									float fragment_unnamed_679 = asfloat(fragment_unnamed_610 ? asuint(fragment_unnamed_667) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_667)));
									bool fragment_unnamed_682 = abs(fragment_unnamed_673) >= fragment_unnamed_243;
									bool fragment_unnamed_683 = abs(fragment_unnamed_679) >= fragment_unnamed_243;
									uint fragment_unnamed_684 = fragment_unnamed_682 ? 4294967295u : 0u;
									uint fragment_unnamed_685 = fragment_unnamed_683 ? 4294967295u : 0u;
									uint fragment_unnamed_689 = fragment_unnamed_682 ? fragment_unnamed_616 : asuint(mad((-0.0f) - fragment_unnamed_190, 2.0f, fragment_unnamed_617));
									float fragment_unnamed_690 = asfloat(fragment_unnamed_689);
									uint fragment_unnamed_694 = fragment_unnamed_682 ? fragment_unnamed_621 : asuint(mad((-0.0f) - fragment_unnamed_196, 2.0f, fragment_unnamed_622));
									float fragment_unnamed_695 = asfloat(fragment_unnamed_694);
									uint fragment_unnamed_701 = fragment_unnamed_683 ? fragment_unnamed_628 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_629));
									float fragment_unnamed_702 = asfloat(fragment_unnamed_701);
									uint fragment_unnamed_706 = fragment_unnamed_683 ? fragment_unnamed_633 : asuint(mad(fragment_unnamed_196, 2.0f, asfloat(fragment_unnamed_633)));
									float fragment_unnamed_636;
									float fragment_unnamed_637;
									float fragment_unnamed_638;
									float fragment_unnamed_639;
									float fragment_unnamed_640;
									uint fragment_unnamed_641;
									if (((~fragment_unnamed_685) | (~fragment_unnamed_684)) != 0u)
									{
										float fragment_unnamed_726;
										if (fragment_unnamed_684 == 0u)
										{
											fragment_unnamed_726 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_690, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_695, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
										}
										else
										{
											fragment_unnamed_726 = fragment_unnamed_673;
										}
										float fragment_unnamed_740;
										if (fragment_unnamed_685 == 0u)
										{
											fragment_unnamed_740 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_702, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_706), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
										}
										else
										{
											fragment_unnamed_740 = fragment_unnamed_679;
										}
										float fragment_unnamed_746 = asfloat(fragment_unnamed_682 ? asuint(fragment_unnamed_726) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_726)));
										float fragment_unnamed_752 = asfloat(fragment_unnamed_683 ? asuint(fragment_unnamed_740) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_740)));
										bool fragment_unnamed_755 = abs(fragment_unnamed_746) >= fragment_unnamed_243;
										bool fragment_unnamed_756 = abs(fragment_unnamed_752) >= fragment_unnamed_243;
										uint fragment_unnamed_757 = fragment_unnamed_755 ? 4294967295u : 0u;
										uint fragment_unnamed_758 = fragment_unnamed_756 ? 4294967295u : 0u;
										uint fragment_unnamed_762 = fragment_unnamed_755 ? fragment_unnamed_689 : asuint(mad((-0.0f) - fragment_unnamed_190, 2.0f, fragment_unnamed_690));
										float fragment_unnamed_763 = asfloat(fragment_unnamed_762);
										uint fragment_unnamed_767 = fragment_unnamed_755 ? fragment_unnamed_694 : asuint(mad((-0.0f) - fragment_unnamed_196, 2.0f, fragment_unnamed_695));
										float fragment_unnamed_768 = asfloat(fragment_unnamed_767);
										uint fragment_unnamed_774 = fragment_unnamed_756 ? fragment_unnamed_701 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_702));
										float fragment_unnamed_775 = asfloat(fragment_unnamed_774);
										uint fragment_unnamed_779 = fragment_unnamed_756 ? fragment_unnamed_706 : asuint(mad(fragment_unnamed_196, 2.0f, asfloat(fragment_unnamed_706)));
										float fragment_unnamed_709;
										float fragment_unnamed_710;
										float fragment_unnamed_711;
										float fragment_unnamed_712;
										float fragment_unnamed_713;
										uint fragment_unnamed_714;
										if (((~fragment_unnamed_758) | (~fragment_unnamed_757)) != 0u)
										{
											float fragment_unnamed_799;
											if (fragment_unnamed_757 == 0u)
											{
												fragment_unnamed_799 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_763, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_768, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
											}
											else
											{
												fragment_unnamed_799 = fragment_unnamed_746;
											}
											float fragment_unnamed_813;
											if (fragment_unnamed_758 == 0u)
											{
												fragment_unnamed_813 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_775, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_779), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
											}
											else
											{
												fragment_unnamed_813 = fragment_unnamed_752;
											}
											float fragment_unnamed_819 = asfloat(fragment_unnamed_755 ? asuint(fragment_unnamed_799) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_799)));
											float fragment_unnamed_825 = asfloat(fragment_unnamed_756 ? asuint(fragment_unnamed_813) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_813)));
											bool fragment_unnamed_828 = abs(fragment_unnamed_819) >= fragment_unnamed_243;
											bool fragment_unnamed_829 = abs(fragment_unnamed_825) >= fragment_unnamed_243;
											uint fragment_unnamed_830 = fragment_unnamed_828 ? 4294967295u : 0u;
											uint fragment_unnamed_831 = fragment_unnamed_829 ? 4294967295u : 0u;
											uint fragment_unnamed_835 = fragment_unnamed_828 ? fragment_unnamed_762 : asuint(mad((-0.0f) - fragment_unnamed_190, 2.0f, fragment_unnamed_763));
											float fragment_unnamed_836 = asfloat(fragment_unnamed_835);
											uint fragment_unnamed_840 = fragment_unnamed_828 ? fragment_unnamed_767 : asuint(mad((-0.0f) - fragment_unnamed_196, 2.0f, fragment_unnamed_768));
											float fragment_unnamed_841 = asfloat(fragment_unnamed_840);
											uint fragment_unnamed_847 = fragment_unnamed_829 ? fragment_unnamed_774 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_775));
											float fragment_unnamed_848 = asfloat(fragment_unnamed_847);
											uint fragment_unnamed_852 = fragment_unnamed_829 ? fragment_unnamed_779 : asuint(mad(fragment_unnamed_196, 2.0f, asfloat(fragment_unnamed_779)));
											float fragment_unnamed_782;
											float fragment_unnamed_783;
											float fragment_unnamed_784;
											float fragment_unnamed_785;
											float fragment_unnamed_786;
											uint fragment_unnamed_787;
											if (((~fragment_unnamed_831) | (~fragment_unnamed_830)) != 0u)
											{
												float fragment_unnamed_872;
												if (fragment_unnamed_830 == 0u)
												{
													fragment_unnamed_872 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_836, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_841, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
												}
												else
												{
													fragment_unnamed_872 = fragment_unnamed_819;
												}
												float fragment_unnamed_886;
												if (fragment_unnamed_831 == 0u)
												{
													fragment_unnamed_886 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_848, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_852), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
												}
												else
												{
													fragment_unnamed_886 = fragment_unnamed_825;
												}
												float fragment_unnamed_892 = asfloat(fragment_unnamed_828 ? asuint(fragment_unnamed_872) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_872)));
												float fragment_unnamed_898 = asfloat(fragment_unnamed_829 ? asuint(fragment_unnamed_886) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_886)));
												bool fragment_unnamed_901 = abs(fragment_unnamed_892) >= fragment_unnamed_243;
												bool fragment_unnamed_902 = abs(fragment_unnamed_898) >= fragment_unnamed_243;
												uint fragment_unnamed_903 = fragment_unnamed_901 ? 4294967295u : 0u;
												uint fragment_unnamed_904 = fragment_unnamed_902 ? 4294967295u : 0u;
												uint fragment_unnamed_908 = fragment_unnamed_901 ? fragment_unnamed_835 : asuint(mad((-0.0f) - fragment_unnamed_190, 2.0f, fragment_unnamed_836));
												float fragment_unnamed_909 = asfloat(fragment_unnamed_908);
												uint fragment_unnamed_913 = fragment_unnamed_901 ? fragment_unnamed_840 : asuint(mad((-0.0f) - fragment_unnamed_196, 2.0f, fragment_unnamed_841));
												float fragment_unnamed_914 = asfloat(fragment_unnamed_913);
												uint fragment_unnamed_920 = fragment_unnamed_902 ? fragment_unnamed_847 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_848));
												float fragment_unnamed_921 = asfloat(fragment_unnamed_920);
												uint fragment_unnamed_925 = fragment_unnamed_902 ? fragment_unnamed_852 : asuint(mad(fragment_unnamed_196, 2.0f, asfloat(fragment_unnamed_852)));
												float fragment_unnamed_855;
												float fragment_unnamed_856;
												float fragment_unnamed_857;
												float fragment_unnamed_858;
												float fragment_unnamed_859;
												uint fragment_unnamed_860;
												if (((~fragment_unnamed_904) | (~fragment_unnamed_903)) != 0u)
												{
													float fragment_unnamed_945;
													if (fragment_unnamed_903 == 0u)
													{
														fragment_unnamed_945 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_909, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_914, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
													}
													else
													{
														fragment_unnamed_945 = fragment_unnamed_892;
													}
													float fragment_unnamed_959;
													if (fragment_unnamed_904 == 0u)
													{
														fragment_unnamed_959 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_921, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_925), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
													}
													else
													{
														fragment_unnamed_959 = fragment_unnamed_898;
													}
													float fragment_unnamed_965 = asfloat(fragment_unnamed_901 ? asuint(fragment_unnamed_945) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_945)));
													float fragment_unnamed_971 = asfloat(fragment_unnamed_902 ? asuint(fragment_unnamed_959) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_959)));
													bool fragment_unnamed_974 = abs(fragment_unnamed_965) >= fragment_unnamed_243;
													bool fragment_unnamed_975 = abs(fragment_unnamed_971) >= fragment_unnamed_243;
													uint fragment_unnamed_976 = fragment_unnamed_974 ? 4294967295u : 0u;
													uint fragment_unnamed_977 = fragment_unnamed_975 ? 4294967295u : 0u;
													uint fragment_unnamed_982 = fragment_unnamed_974 ? fragment_unnamed_908 : asuint(mad((-0.0f) - fragment_unnamed_190, 4.0f, fragment_unnamed_909));
													float fragment_unnamed_983 = asfloat(fragment_unnamed_982);
													uint fragment_unnamed_987 = fragment_unnamed_974 ? fragment_unnamed_913 : asuint(mad((-0.0f) - fragment_unnamed_196, 4.0f, fragment_unnamed_914));
													float fragment_unnamed_988 = asfloat(fragment_unnamed_987);
													uint fragment_unnamed_994 = fragment_unnamed_975 ? fragment_unnamed_920 : asuint(mad(fragment_unnamed_190, 4.0f, fragment_unnamed_921));
													float fragment_unnamed_995 = asfloat(fragment_unnamed_994);
													uint fragment_unnamed_999 = fragment_unnamed_975 ? fragment_unnamed_925 : asuint(mad(fragment_unnamed_196, 4.0f, asfloat(fragment_unnamed_925)));
													float fragment_unnamed_928;
													float fragment_unnamed_929;
													float fragment_unnamed_930;
													float fragment_unnamed_931;
													float fragment_unnamed_932;
													uint fragment_unnamed_933;
													if (((~fragment_unnamed_977) | (~fragment_unnamed_976)) != 0u)
													{
														float fragment_unnamed_1019;
														if (fragment_unnamed_976 == 0u)
														{
															fragment_unnamed_1019 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_983, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_988, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
														}
														else
														{
															fragment_unnamed_1019 = fragment_unnamed_965;
														}
														float fragment_unnamed_1033;
														if (fragment_unnamed_977 == 0u)
														{
															fragment_unnamed_1033 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_995, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_999), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
														}
														else
														{
															fragment_unnamed_1033 = fragment_unnamed_971;
														}
														float fragment_unnamed_1002 = asfloat(fragment_unnamed_974 ? asuint(fragment_unnamed_1019) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_1019)));
														float fragment_unnamed_1003 = asfloat(fragment_unnamed_975 ? asuint(fragment_unnamed_1033) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_1033)));
														bool fragment_unnamed_1046 = abs(fragment_unnamed_1002) >= fragment_unnamed_243;
														bool fragment_unnamed_1047 = abs(fragment_unnamed_1003) >= fragment_unnamed_243;
														fragment_unnamed_928 = fragment_unnamed_1002;
														fragment_unnamed_929 = fragment_unnamed_1003;
														fragment_unnamed_930 = asfloat(fragment_unnamed_1046 ? fragment_unnamed_982 : asuint(mad((-0.0f) - fragment_unnamed_190, 8.0f, fragment_unnamed_983)));
														fragment_unnamed_931 = asfloat(fragment_unnamed_1047 ? fragment_unnamed_994 : asuint(mad(fragment_unnamed_190, 8.0f, fragment_unnamed_995)));
														fragment_unnamed_932 = asfloat(fragment_unnamed_1046 ? fragment_unnamed_987 : asuint(mad((-0.0f) - fragment_unnamed_196, 8.0f, fragment_unnamed_988)));
														fragment_unnamed_933 = fragment_unnamed_1047 ? fragment_unnamed_999 : asuint(mad(fragment_unnamed_196, 8.0f, asfloat(fragment_unnamed_999)));
													}
													else
													{
														fragment_unnamed_928 = fragment_unnamed_965;
														fragment_unnamed_929 = fragment_unnamed_971;
														fragment_unnamed_930 = fragment_unnamed_983;
														fragment_unnamed_931 = fragment_unnamed_995;
														fragment_unnamed_932 = fragment_unnamed_988;
														fragment_unnamed_933 = fragment_unnamed_999;
													}
													fragment_unnamed_855 = fragment_unnamed_928;
													fragment_unnamed_856 = fragment_unnamed_929;
													fragment_unnamed_857 = fragment_unnamed_930;
													fragment_unnamed_858 = fragment_unnamed_931;
													fragment_unnamed_859 = fragment_unnamed_932;
													fragment_unnamed_860 = fragment_unnamed_933;
												}
												else
												{
													fragment_unnamed_855 = fragment_unnamed_892;
													fragment_unnamed_856 = fragment_unnamed_898;
													fragment_unnamed_857 = fragment_unnamed_909;
													fragment_unnamed_858 = fragment_unnamed_921;
													fragment_unnamed_859 = fragment_unnamed_914;
													fragment_unnamed_860 = fragment_unnamed_925;
												}
												fragment_unnamed_782 = fragment_unnamed_855;
												fragment_unnamed_783 = fragment_unnamed_856;
												fragment_unnamed_784 = fragment_unnamed_857;
												fragment_unnamed_785 = fragment_unnamed_858;
												fragment_unnamed_786 = fragment_unnamed_859;
												fragment_unnamed_787 = fragment_unnamed_860;
											}
											else
											{
												fragment_unnamed_782 = fragment_unnamed_819;
												fragment_unnamed_783 = fragment_unnamed_825;
												fragment_unnamed_784 = fragment_unnamed_836;
												fragment_unnamed_785 = fragment_unnamed_848;
												fragment_unnamed_786 = fragment_unnamed_841;
												fragment_unnamed_787 = fragment_unnamed_852;
											}
											fragment_unnamed_709 = fragment_unnamed_782;
											fragment_unnamed_710 = fragment_unnamed_783;
											fragment_unnamed_711 = fragment_unnamed_784;
											fragment_unnamed_712 = fragment_unnamed_785;
											fragment_unnamed_713 = fragment_unnamed_786;
											fragment_unnamed_714 = fragment_unnamed_787;
										}
										else
										{
											fragment_unnamed_709 = fragment_unnamed_746;
											fragment_unnamed_710 = fragment_unnamed_752;
											fragment_unnamed_711 = fragment_unnamed_763;
											fragment_unnamed_712 = fragment_unnamed_775;
											fragment_unnamed_713 = fragment_unnamed_768;
											fragment_unnamed_714 = fragment_unnamed_779;
										}
										fragment_unnamed_636 = fragment_unnamed_709;
										fragment_unnamed_637 = fragment_unnamed_710;
										fragment_unnamed_638 = fragment_unnamed_711;
										fragment_unnamed_639 = fragment_unnamed_712;
										fragment_unnamed_640 = fragment_unnamed_713;
										fragment_unnamed_641 = fragment_unnamed_714;
									}
									else
									{
										fragment_unnamed_636 = fragment_unnamed_673;
										fragment_unnamed_637 = fragment_unnamed_679;
										fragment_unnamed_638 = fragment_unnamed_690;
										fragment_unnamed_639 = fragment_unnamed_702;
										fragment_unnamed_640 = fragment_unnamed_695;
										fragment_unnamed_641 = fragment_unnamed_706;
									}
									fragment_unnamed_563 = fragment_unnamed_636;
									fragment_unnamed_564 = fragment_unnamed_637;
									fragment_unnamed_565 = fragment_unnamed_638;
									fragment_unnamed_566 = fragment_unnamed_639;
									fragment_unnamed_567 = fragment_unnamed_640;
									fragment_unnamed_568 = fragment_unnamed_641;
								}
								else
								{
									fragment_unnamed_563 = fragment_unnamed_600;
									fragment_unnamed_564 = fragment_unnamed_606;
									fragment_unnamed_565 = fragment_unnamed_617;
									fragment_unnamed_566 = fragment_unnamed_629;
									fragment_unnamed_567 = fragment_unnamed_622;
									fragment_unnamed_568 = fragment_unnamed_633;
								}
								fragment_unnamed_490 = fragment_unnamed_563;
								fragment_unnamed_491 = fragment_unnamed_564;
								fragment_unnamed_492 = fragment_unnamed_565;
								fragment_unnamed_493 = fragment_unnamed_566;
								fragment_unnamed_494 = fragment_unnamed_567;
								fragment_unnamed_495 = fragment_unnamed_568;
							}
							else
							{
								fragment_unnamed_490 = fragment_unnamed_527;
								fragment_unnamed_491 = fragment_unnamed_533;
								fragment_unnamed_492 = fragment_unnamed_544;
								fragment_unnamed_493 = fragment_unnamed_556;
								fragment_unnamed_494 = fragment_unnamed_549;
								fragment_unnamed_495 = fragment_unnamed_560;
							}
							fragment_unnamed_345 = fragment_unnamed_490;
							fragment_unnamed_347 = fragment_unnamed_491;
							fragment_unnamed_349 = fragment_unnamed_492;
							fragment_unnamed_351 = fragment_unnamed_493;
							fragment_unnamed_353 = fragment_unnamed_494;
							fragment_unnamed_355 = fragment_unnamed_495;
						}
						else
						{
							fragment_unnamed_345 = fragment_unnamed_454;
							fragment_unnamed_347 = fragment_unnamed_460;
							fragment_unnamed_349 = fragment_unnamed_471;
							fragment_unnamed_351 = fragment_unnamed_483;
							fragment_unnamed_353 = fragment_unnamed_476;
							fragment_unnamed_355 = fragment_unnamed_487;
						}
						fragment_unnamed_344 = fragment_unnamed_345;
						fragment_unnamed_346 = fragment_unnamed_347;
						fragment_unnamed_348 = fragment_unnamed_349;
						fragment_unnamed_350 = fragment_unnamed_351;
						fragment_unnamed_352 = fragment_unnamed_353;
						fragment_unnamed_354 = fragment_unnamed_355;
					}
					else
					{
						fragment_unnamed_344 = fragment_unnamed_251;
						fragment_unnamed_346 = fragment_unnamed_253;
						fragment_unnamed_348 = fragment_unnamed_266;
						fragment_unnamed_350 = fragment_unnamed_280;
						fragment_unnamed_352 = fragment_unnamed_272;
						fragment_unnamed_354 = fragment_unnamed_284;
					}
					float fragment_unnamed_371 = asfloat(fragment_unnamed_141 ? asuint(((-0.0f) - fragment_unnamed_348) + fragment_input_1.x) : asuint(((-0.0f) - fragment_unnamed_352) + fragment_input_1.y));
					float fragment_unnamed_380 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_350 + ((-0.0f) - fragment_input_1.x)) : asuint(asfloat(fragment_unnamed_354) + ((-0.0f) - fragment_input_1.y)));
					float fragment_unnamed_400 = max(fragment_unnamed_247 * fragment_unnamed_247, asfloat(asuint(mad(min(fragment_unnamed_371, fragment_unnamed_380), (-0.0f) - (1.0f / (fragment_unnamed_371 + fragment_unnamed_380)), 0.5f)) & ((fragment_unnamed_371 < fragment_unnamed_380) ? ((fragment_unnamed_249 != ((fragment_unnamed_344 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_249 != ((fragment_unnamed_346 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					float4 fragment_unnamed_421 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_141 ? fragment_input_1.x : mad(fragment_unnamed_400, fragment_unnamed_181, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_141 ? mad(fragment_unnamed_400, fragment_unnamed_181, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f);
					fragment_unnamed_286 = fragment_unnamed_421.x;
					fragment_unnamed_288 = fragment_unnamed_421.y;
					fragment_unnamed_290 = fragment_unnamed_421.z;
				}
				else
				{
					fragment_unnamed_286 = fragment_unnamed_54.x;
					fragment_unnamed_288 = fragment_unnamed_57;
					fragment_unnamed_290 = fragment_unnamed_54.z;
				}
				float fragment_unnamed_319 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[29u].x, fragment_uniform_buffer_0[29u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[29u].y, fragment_uniform_buffer_0[29u].w))).w, 2.0f, -1.0f);
				float fragment_unnamed_331 = (((-0.0f) - sqrt(((-0.0f) - abs(fragment_unnamed_319)) + 1.0f)) + 1.0f) * mad(clamp(mad(fragment_unnamed_319, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_331, 0.0039215688593685626983642578125f, fragment_unnamed_286);
				fragment_output_0.y = mad(fragment_unnamed_331, 0.0039215688593685626983642578125f, fragment_unnamed_288);
				fragment_output_0.z = mad(fragment_unnamed_331, 0.0039215688593685626983642578125f, fragment_unnamed_290);
				fragment_output_0.w = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[29] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[30] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA) && defined(FXAA_KEEP_ALPHA) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA_LOW)


			#if defined(FXAA_LOW) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
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
				float vertex_unnamed_57 = mad((vertex_input_0.x + 1.0f) * vertex_uniform_buffer_0[27u].x, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_59 = mad((vertex_input_0.y + 1.0f) * vertex_uniform_buffer_0[27u].y, 0.5f, vertex_uniform_buffer_0[27u].w);
				vertex_output_1.x = vertex_unnamed_57 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_57;
				vertex_output_1.y = vertex_unnamed_59;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f);
				float fragment_unnamed_59 = fragment_unnamed_54.w;
				float4 fragment_unnamed_63 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, 1));
				float fragment_unnamed_67 = fragment_unnamed_63.w;
				float4 fragment_unnamed_68 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 0));
				float fragment_unnamed_71 = fragment_unnamed_68.w;
				float4 fragment_unnamed_73 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, -1));
				float fragment_unnamed_76 = fragment_unnamed_73.w;
				float4 fragment_unnamed_77 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 0));
				float fragment_unnamed_80 = fragment_unnamed_77.w;
				float fragment_unnamed_87 = max(max(fragment_unnamed_71, max(fragment_unnamed_59, fragment_unnamed_67)), max(fragment_unnamed_80, fragment_unnamed_76));
				float fragment_unnamed_93 = ((-0.0f) - min(min(fragment_unnamed_71, min(fragment_unnamed_59, fragment_unnamed_67)), min(fragment_unnamed_80, fragment_unnamed_76))) + fragment_unnamed_87;
				float fragment_unnamed_288;
				float fragment_unnamed_290;
				float fragment_unnamed_292;
				if (fragment_unnamed_93 >= max(fragment_unnamed_87 * 0.16599999368190765380859375f, 0.0625f))
				{
					float4 fragment_unnamed_99 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, -1));
					float fragment_unnamed_102 = fragment_unnamed_99.w;
					float4 fragment_unnamed_103 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 1));
					float fragment_unnamed_106 = fragment_unnamed_103.w;
					float4 fragment_unnamed_107 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, -1));
					float fragment_unnamed_110 = fragment_unnamed_107.w;
					float4 fragment_unnamed_111 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 1));
					float fragment_unnamed_114 = fragment_unnamed_111.w;
					float fragment_unnamed_115 = fragment_unnamed_67 + fragment_unnamed_76;
					float fragment_unnamed_116 = fragment_unnamed_71 + fragment_unnamed_80;
					float fragment_unnamed_122 = fragment_unnamed_106 + fragment_unnamed_110;
					float fragment_unnamed_126 = fragment_unnamed_114 + fragment_unnamed_102;
					bool fragment_unnamed_142 = (mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_115)), 2.0f, abs(mad(fragment_unnamed_71, -2.0f, fragment_unnamed_122))) + abs(mad(fragment_unnamed_80, -2.0f, fragment_unnamed_126))) >= (mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_116)), 2.0f, abs(mad(fragment_unnamed_76, -2.0f, fragment_unnamed_102 + fragment_unnamed_110))) + abs(mad(fragment_unnamed_67, -2.0f, fragment_unnamed_106 + fragment_unnamed_114)));
					float fragment_unnamed_149 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_76) : asuint(fragment_unnamed_80));
					float fragment_unnamed_153 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_67) : asuint(fragment_unnamed_71));
					float fragment_unnamed_165 = asfloat(fragment_unnamed_142 ? asuint(fragment_uniform_buffer_0[29u]).y : asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_170 = ((-0.0f) - fragment_unnamed_59) + fragment_unnamed_149;
					float fragment_unnamed_172 = ((-0.0f) - fragment_unnamed_59) + fragment_unnamed_153;
					bool fragment_unnamed_177 = abs(fragment_unnamed_170) >= abs(fragment_unnamed_172);
					float fragment_unnamed_182 = fragment_unnamed_177 ? ((-0.0f) - fragment_unnamed_165) : fragment_unnamed_165;
					float fragment_unnamed_185 = clamp((1.0f / fragment_unnamed_93) * abs(mad(mad(fragment_unnamed_115 + fragment_unnamed_116, 2.0f, fragment_unnamed_122 + fragment_unnamed_126), 0.083333335816860198974609375f, (-0.0f) - fragment_unnamed_59)), 0.0f, 1.0f);
					float fragment_unnamed_191 = asfloat((fragment_unnamed_142 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_197 = asfloat(fragment_unnamed_142 ? 0u : asuint(fragment_uniform_buffer_0[29u]).y);
					float fragment_unnamed_207 = fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_182, 0.5f, fragment_input_1.x);
					float fragment_unnamed_210 = fragment_unnamed_142 ? mad(fragment_unnamed_182, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					float fragment_unnamed_213 = ((-0.0f) - fragment_unnamed_191) + fragment_unnamed_207;
					float fragment_unnamed_214 = ((-0.0f) - fragment_unnamed_197) + fragment_unnamed_210;
					float fragment_unnamed_215 = fragment_unnamed_191 + fragment_unnamed_207;
					float fragment_unnamed_216 = fragment_unnamed_197 + fragment_unnamed_210;
					float fragment_unnamed_243 = asfloat(fragment_unnamed_177 ? asuint(fragment_unnamed_59 + fragment_unnamed_149) : asuint(fragment_unnamed_59 + fragment_unnamed_153));
					float fragment_unnamed_244 = max(abs(fragment_unnamed_172), abs(fragment_unnamed_170)) * 0.25f;
					float fragment_unnamed_248 = (fragment_unnamed_185 * fragment_unnamed_185) * mad(fragment_unnamed_185, -2.0f, 3.0f);
					uint fragment_unnamed_250 = (mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_59) < 0.0f) ? 4294967295u : 0u;
					float fragment_unnamed_252 = mad((-0.0f) - fragment_unnamed_243, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_213, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_214, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w);
					float fragment_unnamed_254 = mad((-0.0f) - fragment_unnamed_243, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_215, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_216, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w);
					bool fragment_unnamed_257 = abs(fragment_unnamed_252) >= fragment_unnamed_244;
					bool fragment_unnamed_258 = abs(fragment_unnamed_254) >= fragment_unnamed_244;
					uint fragment_unnamed_259 = fragment_unnamed_257 ? 4294967295u : 0u;
					uint fragment_unnamed_260 = fragment_unnamed_258 ? 4294967295u : 0u;
					uint fragment_unnamed_266 = fragment_unnamed_257 ? asuint(fragment_unnamed_213) : asuint(mad((-0.0f) - fragment_unnamed_191, 1.5f, fragment_unnamed_213));
					float fragment_unnamed_267 = asfloat(fragment_unnamed_266);
					uint fragment_unnamed_272 = fragment_unnamed_257 ? asuint(fragment_unnamed_214) : asuint(mad((-0.0f) - fragment_unnamed_197, 1.5f, fragment_unnamed_214));
					float fragment_unnamed_273 = asfloat(fragment_unnamed_272);
					uint fragment_unnamed_280 = fragment_unnamed_258 ? asuint(fragment_unnamed_215) : asuint(mad(fragment_unnamed_191, 1.5f, fragment_unnamed_215));
					float fragment_unnamed_281 = asfloat(fragment_unnamed_280);
					uint fragment_unnamed_285 = fragment_unnamed_258 ? asuint(fragment_unnamed_216) : asuint(mad(fragment_unnamed_197, 1.5f, fragment_unnamed_216));
					float fragment_unnamed_286 = asfloat(fragment_unnamed_285);
					float fragment_unnamed_338;
					float fragment_unnamed_340;
					float fragment_unnamed_342;
					float fragment_unnamed_344;
					float fragment_unnamed_346;
					float fragment_unnamed_348;
					if (((~fragment_unnamed_260) | (~fragment_unnamed_259)) != 0u)
					{
						float fragment_unnamed_427;
						if (fragment_unnamed_259 == 0u)
						{
							fragment_unnamed_427 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_267, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_273, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
						}
						else
						{
							fragment_unnamed_427 = fragment_unnamed_252;
						}
						float fragment_unnamed_440;
						if (fragment_unnamed_260 == 0u)
						{
							fragment_unnamed_440 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_281, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_286, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
						}
						else
						{
							fragment_unnamed_440 = fragment_unnamed_254;
						}
						float fragment_unnamed_446 = asfloat(fragment_unnamed_257 ? asuint(fragment_unnamed_427) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_427)));
						float fragment_unnamed_452 = asfloat(fragment_unnamed_258 ? asuint(fragment_unnamed_440) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_440)));
						bool fragment_unnamed_455 = abs(fragment_unnamed_446) >= fragment_unnamed_244;
						bool fragment_unnamed_456 = abs(fragment_unnamed_452) >= fragment_unnamed_244;
						uint fragment_unnamed_457 = fragment_unnamed_455 ? 4294967295u : 0u;
						uint fragment_unnamed_458 = fragment_unnamed_456 ? 4294967295u : 0u;
						uint fragment_unnamed_462 = fragment_unnamed_455 ? fragment_unnamed_266 : asuint(mad((-0.0f) - fragment_unnamed_191, 2.0f, fragment_unnamed_267));
						float fragment_unnamed_463 = asfloat(fragment_unnamed_462);
						uint fragment_unnamed_467 = fragment_unnamed_455 ? fragment_unnamed_272 : asuint(mad((-0.0f) - fragment_unnamed_197, 2.0f, fragment_unnamed_273));
						float fragment_unnamed_468 = asfloat(fragment_unnamed_467);
						uint fragment_unnamed_474 = fragment_unnamed_456 ? fragment_unnamed_280 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_281));
						float fragment_unnamed_475 = asfloat(fragment_unnamed_474);
						uint fragment_unnamed_478 = fragment_unnamed_456 ? fragment_unnamed_285 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_286));
						float fragment_unnamed_479 = asfloat(fragment_unnamed_478);
						float fragment_unnamed_339;
						float fragment_unnamed_341;
						float fragment_unnamed_343;
						float fragment_unnamed_345;
						float fragment_unnamed_347;
						float fragment_unnamed_349;
						if (((~fragment_unnamed_458) | (~fragment_unnamed_457)) != 0u)
						{
							float fragment_unnamed_499;
							if (fragment_unnamed_457 == 0u)
							{
								fragment_unnamed_499 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_463, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_468, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
							}
							else
							{
								fragment_unnamed_499 = fragment_unnamed_446;
							}
							float fragment_unnamed_512;
							if (fragment_unnamed_458 == 0u)
							{
								fragment_unnamed_512 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_475, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_479, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
							}
							else
							{
								fragment_unnamed_512 = fragment_unnamed_452;
							}
							float fragment_unnamed_518 = asfloat(fragment_unnamed_455 ? asuint(fragment_unnamed_499) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_499)));
							float fragment_unnamed_524 = asfloat(fragment_unnamed_456 ? asuint(fragment_unnamed_512) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_512)));
							bool fragment_unnamed_527 = abs(fragment_unnamed_518) >= fragment_unnamed_244;
							bool fragment_unnamed_528 = abs(fragment_unnamed_524) >= fragment_unnamed_244;
							uint fragment_unnamed_529 = fragment_unnamed_527 ? 4294967295u : 0u;
							uint fragment_unnamed_530 = fragment_unnamed_528 ? 4294967295u : 0u;
							uint fragment_unnamed_535 = fragment_unnamed_527 ? fragment_unnamed_462 : asuint(mad((-0.0f) - fragment_unnamed_191, 4.0f, fragment_unnamed_463));
							float fragment_unnamed_536 = asfloat(fragment_unnamed_535);
							uint fragment_unnamed_540 = fragment_unnamed_527 ? fragment_unnamed_467 : asuint(mad((-0.0f) - fragment_unnamed_197, 4.0f, fragment_unnamed_468));
							float fragment_unnamed_541 = asfloat(fragment_unnamed_540);
							uint fragment_unnamed_547 = fragment_unnamed_528 ? fragment_unnamed_474 : asuint(mad(fragment_unnamed_191, 4.0f, fragment_unnamed_475));
							float fragment_unnamed_548 = asfloat(fragment_unnamed_547);
							uint fragment_unnamed_551 = fragment_unnamed_528 ? fragment_unnamed_478 : asuint(mad(fragment_unnamed_197, 4.0f, fragment_unnamed_479));
							float fragment_unnamed_552 = asfloat(fragment_unnamed_551);
							float fragment_unnamed_482;
							float fragment_unnamed_483;
							float fragment_unnamed_484;
							float fragment_unnamed_485;
							float fragment_unnamed_486;
							float fragment_unnamed_487;
							if (((~fragment_unnamed_530) | (~fragment_unnamed_529)) != 0u)
							{
								float fragment_unnamed_572;
								if (fragment_unnamed_529 == 0u)
								{
									fragment_unnamed_572 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_536, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_541, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
								}
								else
								{
									fragment_unnamed_572 = fragment_unnamed_518;
								}
								float fragment_unnamed_585;
								if (fragment_unnamed_530 == 0u)
								{
									fragment_unnamed_585 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_548, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_552, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
								}
								else
								{
									fragment_unnamed_585 = fragment_unnamed_524;
								}
								float fragment_unnamed_555 = asfloat(fragment_unnamed_527 ? asuint(fragment_unnamed_572) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_572)));
								float fragment_unnamed_556 = asfloat(fragment_unnamed_528 ? asuint(fragment_unnamed_585) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_585)));
								bool fragment_unnamed_598 = abs(fragment_unnamed_555) >= fragment_unnamed_244;
								bool fragment_unnamed_599 = abs(fragment_unnamed_556) >= fragment_unnamed_244;
								fragment_unnamed_482 = fragment_unnamed_555;
								fragment_unnamed_483 = fragment_unnamed_556;
								fragment_unnamed_484 = asfloat(fragment_unnamed_598 ? fragment_unnamed_535 : asuint(mad((-0.0f) - fragment_unnamed_191, 12.0f, fragment_unnamed_536)));
								fragment_unnamed_485 = asfloat(fragment_unnamed_599 ? fragment_unnamed_547 : asuint(mad(fragment_unnamed_191, 12.0f, fragment_unnamed_548)));
								fragment_unnamed_486 = asfloat(fragment_unnamed_598 ? fragment_unnamed_540 : asuint(mad((-0.0f) - fragment_unnamed_197, 12.0f, fragment_unnamed_541)));
								fragment_unnamed_487 = asfloat(fragment_unnamed_599 ? fragment_unnamed_551 : asuint(mad(fragment_unnamed_197, 12.0f, fragment_unnamed_552)));
							}
							else
							{
								fragment_unnamed_482 = fragment_unnamed_518;
								fragment_unnamed_483 = fragment_unnamed_524;
								fragment_unnamed_484 = fragment_unnamed_536;
								fragment_unnamed_485 = fragment_unnamed_548;
								fragment_unnamed_486 = fragment_unnamed_541;
								fragment_unnamed_487 = fragment_unnamed_552;
							}
							fragment_unnamed_339 = fragment_unnamed_482;
							fragment_unnamed_341 = fragment_unnamed_483;
							fragment_unnamed_343 = fragment_unnamed_484;
							fragment_unnamed_345 = fragment_unnamed_485;
							fragment_unnamed_347 = fragment_unnamed_486;
							fragment_unnamed_349 = fragment_unnamed_487;
						}
						else
						{
							fragment_unnamed_339 = fragment_unnamed_446;
							fragment_unnamed_341 = fragment_unnamed_452;
							fragment_unnamed_343 = fragment_unnamed_463;
							fragment_unnamed_345 = fragment_unnamed_475;
							fragment_unnamed_347 = fragment_unnamed_468;
							fragment_unnamed_349 = fragment_unnamed_479;
						}
						fragment_unnamed_338 = fragment_unnamed_339;
						fragment_unnamed_340 = fragment_unnamed_341;
						fragment_unnamed_342 = fragment_unnamed_343;
						fragment_unnamed_344 = fragment_unnamed_345;
						fragment_unnamed_346 = fragment_unnamed_347;
						fragment_unnamed_348 = fragment_unnamed_349;
					}
					else
					{
						fragment_unnamed_338 = fragment_unnamed_252;
						fragment_unnamed_340 = fragment_unnamed_254;
						fragment_unnamed_342 = fragment_unnamed_267;
						fragment_unnamed_344 = fragment_unnamed_281;
						fragment_unnamed_346 = fragment_unnamed_273;
						fragment_unnamed_348 = fragment_unnamed_286;
					}
					float fragment_unnamed_361 = asfloat(fragment_unnamed_142 ? asuint(((-0.0f) - fragment_unnamed_342) + fragment_input_1.x) : asuint(((-0.0f) - fragment_unnamed_346) + fragment_input_1.y));
					float fragment_unnamed_373 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_344 + ((-0.0f) - fragment_input_1.x)) : asuint(fragment_unnamed_348 + ((-0.0f) - fragment_input_1.y)));
					float fragment_unnamed_393 = max(fragment_unnamed_248 * fragment_unnamed_248, asfloat(asuint(mad(min(fragment_unnamed_361, fragment_unnamed_373), (-0.0f) - (1.0f / (fragment_unnamed_361 + fragment_unnamed_373)), 0.5f)) & ((fragment_unnamed_361 < fragment_unnamed_373) ? ((fragment_unnamed_250 != ((fragment_unnamed_338 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_250 != ((fragment_unnamed_340 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					float4 fragment_unnamed_414 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_393, fragment_unnamed_182, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_142 ? mad(fragment_unnamed_393, fragment_unnamed_182, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f);
					fragment_unnamed_288 = fragment_unnamed_414.x;
					fragment_unnamed_290 = fragment_unnamed_414.y;
					fragment_unnamed_292 = fragment_unnamed_414.z;
				}
				else
				{
					fragment_unnamed_288 = fragment_unnamed_54.x;
					fragment_unnamed_290 = fragment_unnamed_54.y;
					fragment_unnamed_292 = fragment_unnamed_54.z;
				}
				float fragment_unnamed_313 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				float fragment_unnamed_325 = (((-0.0f) - sqrt(((-0.0f) - abs(fragment_unnamed_313)) + 1.0f)) + 1.0f) * mad(clamp(mad(fragment_unnamed_313, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_288);
				fragment_output_0.y = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_290);
				fragment_output_0.z = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_292);
				fragment_output_0.w = fragment_unnamed_59;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[29] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA_LOW) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA)


			#if defined(FXAA_LOW) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float _DepthSlice;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
			static float4 gl_Position;
			static uint gl_Layer;
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
				uint gl_Layer : SV_RenderTargetArrayIndex;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				float vertex_unnamed_59 = mad((vertex_input_0.x + 1.0f) * vertex_uniform_buffer_0[27u].x, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_61 = mad((vertex_input_0.y + 1.0f) * vertex_uniform_buffer_0[27u].y, 0.5f, vertex_uniform_buffer_0[27u].w);
				vertex_output_1.x = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = vertex_unnamed_61 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_59;
				vertex_output_1.y = vertex_unnamed_61;
				gl_Layer = int(uint(vertex_uniform_buffer_0[26u].y));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[26] = float4(vertex_uniform_buffer_0[26][0], _DepthSlice, vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.gl_Layer = gl_Layer;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_52 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float fragment_unnamed_53 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_56 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f);
				float fragment_unnamed_61 = fragment_unnamed_56.w;
				float4 fragment_unnamed_65 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(0, 1));
				float fragment_unnamed_69 = fragment_unnamed_65.w;
				float4 fragment_unnamed_70 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, 0));
				float fragment_unnamed_73 = fragment_unnamed_70.w;
				float4 fragment_unnamed_75 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(0, -1));
				float fragment_unnamed_78 = fragment_unnamed_75.w;
				float4 fragment_unnamed_79 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, 0));
				float fragment_unnamed_82 = fragment_unnamed_79.w;
				float fragment_unnamed_89 = max(max(fragment_unnamed_73, max(fragment_unnamed_61, fragment_unnamed_69)), max(fragment_unnamed_82, fragment_unnamed_78));
				float fragment_unnamed_95 = ((-0.0f) - min(min(fragment_unnamed_73, min(fragment_unnamed_61, fragment_unnamed_69)), min(fragment_unnamed_82, fragment_unnamed_78))) + fragment_unnamed_89;
				float fragment_unnamed_290;
				float fragment_unnamed_292;
				float fragment_unnamed_294;
				if (fragment_unnamed_95 >= max(fragment_unnamed_89 * 0.16599999368190765380859375f, 0.0625f))
				{
					float4 fragment_unnamed_101 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, -1));
					float fragment_unnamed_104 = fragment_unnamed_101.w;
					float4 fragment_unnamed_105 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, 1));
					float fragment_unnamed_108 = fragment_unnamed_105.w;
					float4 fragment_unnamed_109 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, -1));
					float fragment_unnamed_112 = fragment_unnamed_109.w;
					float4 fragment_unnamed_113 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, 1));
					float fragment_unnamed_116 = fragment_unnamed_113.w;
					float fragment_unnamed_117 = fragment_unnamed_69 + fragment_unnamed_78;
					float fragment_unnamed_118 = fragment_unnamed_73 + fragment_unnamed_82;
					float fragment_unnamed_124 = fragment_unnamed_108 + fragment_unnamed_112;
					float fragment_unnamed_128 = fragment_unnamed_116 + fragment_unnamed_104;
					bool fragment_unnamed_144 = (mad(abs(mad(fragment_unnamed_61, -2.0f, fragment_unnamed_117)), 2.0f, abs(mad(fragment_unnamed_73, -2.0f, fragment_unnamed_124))) + abs(mad(fragment_unnamed_82, -2.0f, fragment_unnamed_128))) >= (mad(abs(mad(fragment_unnamed_61, -2.0f, fragment_unnamed_118)), 2.0f, abs(mad(fragment_unnamed_78, -2.0f, fragment_unnamed_104 + fragment_unnamed_112))) + abs(mad(fragment_unnamed_69, -2.0f, fragment_unnamed_108 + fragment_unnamed_116)));
					float fragment_unnamed_151 = asfloat(fragment_unnamed_144 ? asuint(fragment_unnamed_78) : asuint(fragment_unnamed_82));
					float fragment_unnamed_155 = asfloat(fragment_unnamed_144 ? asuint(fragment_unnamed_69) : asuint(fragment_unnamed_73));
					float fragment_unnamed_167 = asfloat(fragment_unnamed_144 ? asuint(fragment_uniform_buffer_0[29u]).y : asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_172 = ((-0.0f) - fragment_unnamed_61) + fragment_unnamed_151;
					float fragment_unnamed_174 = ((-0.0f) - fragment_unnamed_61) + fragment_unnamed_155;
					bool fragment_unnamed_179 = abs(fragment_unnamed_172) >= abs(fragment_unnamed_174);
					float fragment_unnamed_184 = fragment_unnamed_179 ? ((-0.0f) - fragment_unnamed_167) : fragment_unnamed_167;
					float fragment_unnamed_187 = clamp((1.0f / fragment_unnamed_95) * abs(mad(mad(fragment_unnamed_117 + fragment_unnamed_118, 2.0f, fragment_unnamed_124 + fragment_unnamed_128), 0.083333335816860198974609375f, (-0.0f) - fragment_unnamed_61)), 0.0f, 1.0f);
					float fragment_unnamed_193 = asfloat((fragment_unnamed_144 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_199 = asfloat(fragment_unnamed_144 ? 0u : asuint(fragment_uniform_buffer_0[29u]).y);
					float fragment_unnamed_209 = fragment_unnamed_144 ? fragment_input_1.x : mad(fragment_unnamed_184, 0.5f, fragment_input_1.x);
					float fragment_unnamed_212 = fragment_unnamed_144 ? mad(fragment_unnamed_184, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					float fragment_unnamed_215 = ((-0.0f) - fragment_unnamed_193) + fragment_unnamed_209;
					float fragment_unnamed_216 = ((-0.0f) - fragment_unnamed_199) + fragment_unnamed_212;
					float fragment_unnamed_217 = fragment_unnamed_193 + fragment_unnamed_209;
					float fragment_unnamed_218 = fragment_unnamed_199 + fragment_unnamed_212;
					float fragment_unnamed_245 = asfloat(fragment_unnamed_179 ? asuint(fragment_unnamed_61 + fragment_unnamed_151) : asuint(fragment_unnamed_61 + fragment_unnamed_155));
					float fragment_unnamed_246 = max(abs(fragment_unnamed_174), abs(fragment_unnamed_172)) * 0.25f;
					float fragment_unnamed_250 = (fragment_unnamed_187 * fragment_unnamed_187) * mad(fragment_unnamed_187, -2.0f, 3.0f);
					uint fragment_unnamed_252 = (mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_61) < 0.0f) ? 4294967295u : 0u;
					float fragment_unnamed_254 = mad((-0.0f) - fragment_unnamed_245, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_215, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_216, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w);
					float fragment_unnamed_256 = mad((-0.0f) - fragment_unnamed_245, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_217, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_218, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w);
					bool fragment_unnamed_259 = abs(fragment_unnamed_254) >= fragment_unnamed_246;
					bool fragment_unnamed_260 = abs(fragment_unnamed_256) >= fragment_unnamed_246;
					uint fragment_unnamed_261 = fragment_unnamed_259 ? 4294967295u : 0u;
					uint fragment_unnamed_262 = fragment_unnamed_260 ? 4294967295u : 0u;
					uint fragment_unnamed_268 = fragment_unnamed_259 ? asuint(fragment_unnamed_215) : asuint(mad((-0.0f) - fragment_unnamed_193, 1.5f, fragment_unnamed_215));
					float fragment_unnamed_269 = asfloat(fragment_unnamed_268);
					uint fragment_unnamed_274 = fragment_unnamed_259 ? asuint(fragment_unnamed_216) : asuint(mad((-0.0f) - fragment_unnamed_199, 1.5f, fragment_unnamed_216));
					float fragment_unnamed_275 = asfloat(fragment_unnamed_274);
					uint fragment_unnamed_282 = fragment_unnamed_260 ? asuint(fragment_unnamed_217) : asuint(mad(fragment_unnamed_193, 1.5f, fragment_unnamed_217));
					float fragment_unnamed_283 = asfloat(fragment_unnamed_282);
					uint fragment_unnamed_287 = fragment_unnamed_260 ? asuint(fragment_unnamed_218) : asuint(mad(fragment_unnamed_199, 1.5f, fragment_unnamed_218));
					float fragment_unnamed_288 = asfloat(fragment_unnamed_287);
					float fragment_unnamed_340;
					float fragment_unnamed_342;
					float fragment_unnamed_344;
					float fragment_unnamed_346;
					float fragment_unnamed_348;
					float fragment_unnamed_350;
					if (((~fragment_unnamed_262) | (~fragment_unnamed_261)) != 0u)
					{
						float fragment_unnamed_429;
						if (fragment_unnamed_261 == 0u)
						{
							fragment_unnamed_429 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_269, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_275, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
						}
						else
						{
							fragment_unnamed_429 = fragment_unnamed_254;
						}
						float fragment_unnamed_442;
						if (fragment_unnamed_262 == 0u)
						{
							fragment_unnamed_442 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_283, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_288, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
						}
						else
						{
							fragment_unnamed_442 = fragment_unnamed_256;
						}
						float fragment_unnamed_448 = asfloat(fragment_unnamed_259 ? asuint(fragment_unnamed_429) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_429)));
						float fragment_unnamed_454 = asfloat(fragment_unnamed_260 ? asuint(fragment_unnamed_442) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_442)));
						bool fragment_unnamed_457 = abs(fragment_unnamed_448) >= fragment_unnamed_246;
						bool fragment_unnamed_458 = abs(fragment_unnamed_454) >= fragment_unnamed_246;
						uint fragment_unnamed_459 = fragment_unnamed_457 ? 4294967295u : 0u;
						uint fragment_unnamed_460 = fragment_unnamed_458 ? 4294967295u : 0u;
						uint fragment_unnamed_464 = fragment_unnamed_457 ? fragment_unnamed_268 : asuint(mad((-0.0f) - fragment_unnamed_193, 2.0f, fragment_unnamed_269));
						float fragment_unnamed_465 = asfloat(fragment_unnamed_464);
						uint fragment_unnamed_469 = fragment_unnamed_457 ? fragment_unnamed_274 : asuint(mad((-0.0f) - fragment_unnamed_199, 2.0f, fragment_unnamed_275));
						float fragment_unnamed_470 = asfloat(fragment_unnamed_469);
						uint fragment_unnamed_476 = fragment_unnamed_458 ? fragment_unnamed_282 : asuint(mad(fragment_unnamed_193, 2.0f, fragment_unnamed_283));
						float fragment_unnamed_477 = asfloat(fragment_unnamed_476);
						uint fragment_unnamed_480 = fragment_unnamed_458 ? fragment_unnamed_287 : asuint(mad(fragment_unnamed_199, 2.0f, fragment_unnamed_288));
						float fragment_unnamed_481 = asfloat(fragment_unnamed_480);
						float fragment_unnamed_341;
						float fragment_unnamed_343;
						float fragment_unnamed_345;
						float fragment_unnamed_347;
						float fragment_unnamed_349;
						float fragment_unnamed_351;
						if (((~fragment_unnamed_460) | (~fragment_unnamed_459)) != 0u)
						{
							float fragment_unnamed_501;
							if (fragment_unnamed_459 == 0u)
							{
								fragment_unnamed_501 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_465, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_470, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
							}
							else
							{
								fragment_unnamed_501 = fragment_unnamed_448;
							}
							float fragment_unnamed_514;
							if (fragment_unnamed_460 == 0u)
							{
								fragment_unnamed_514 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_477, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_481, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
							}
							else
							{
								fragment_unnamed_514 = fragment_unnamed_454;
							}
							float fragment_unnamed_520 = asfloat(fragment_unnamed_457 ? asuint(fragment_unnamed_501) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_501)));
							float fragment_unnamed_526 = asfloat(fragment_unnamed_458 ? asuint(fragment_unnamed_514) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_514)));
							bool fragment_unnamed_529 = abs(fragment_unnamed_520) >= fragment_unnamed_246;
							bool fragment_unnamed_530 = abs(fragment_unnamed_526) >= fragment_unnamed_246;
							uint fragment_unnamed_531 = fragment_unnamed_529 ? 4294967295u : 0u;
							uint fragment_unnamed_532 = fragment_unnamed_530 ? 4294967295u : 0u;
							uint fragment_unnamed_537 = fragment_unnamed_529 ? fragment_unnamed_464 : asuint(mad((-0.0f) - fragment_unnamed_193, 4.0f, fragment_unnamed_465));
							float fragment_unnamed_538 = asfloat(fragment_unnamed_537);
							uint fragment_unnamed_542 = fragment_unnamed_529 ? fragment_unnamed_469 : asuint(mad((-0.0f) - fragment_unnamed_199, 4.0f, fragment_unnamed_470));
							float fragment_unnamed_543 = asfloat(fragment_unnamed_542);
							uint fragment_unnamed_549 = fragment_unnamed_530 ? fragment_unnamed_476 : asuint(mad(fragment_unnamed_193, 4.0f, fragment_unnamed_477));
							float fragment_unnamed_550 = asfloat(fragment_unnamed_549);
							uint fragment_unnamed_553 = fragment_unnamed_530 ? fragment_unnamed_480 : asuint(mad(fragment_unnamed_199, 4.0f, fragment_unnamed_481));
							float fragment_unnamed_554 = asfloat(fragment_unnamed_553);
							float fragment_unnamed_484;
							float fragment_unnamed_485;
							float fragment_unnamed_486;
							float fragment_unnamed_487;
							float fragment_unnamed_488;
							float fragment_unnamed_489;
							if (((~fragment_unnamed_532) | (~fragment_unnamed_531)) != 0u)
							{
								float fragment_unnamed_574;
								if (fragment_unnamed_531 == 0u)
								{
									fragment_unnamed_574 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_538, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_543, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
								}
								else
								{
									fragment_unnamed_574 = fragment_unnamed_520;
								}
								float fragment_unnamed_587;
								if (fragment_unnamed_532 == 0u)
								{
									fragment_unnamed_587 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_550, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_554, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
								}
								else
								{
									fragment_unnamed_587 = fragment_unnamed_526;
								}
								float fragment_unnamed_557 = asfloat(fragment_unnamed_529 ? asuint(fragment_unnamed_574) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_574)));
								float fragment_unnamed_558 = asfloat(fragment_unnamed_530 ? asuint(fragment_unnamed_587) : asuint(mad((-0.0f) - fragment_unnamed_245, 0.5f, fragment_unnamed_587)));
								bool fragment_unnamed_600 = abs(fragment_unnamed_557) >= fragment_unnamed_246;
								bool fragment_unnamed_601 = abs(fragment_unnamed_558) >= fragment_unnamed_246;
								fragment_unnamed_484 = fragment_unnamed_557;
								fragment_unnamed_485 = fragment_unnamed_558;
								fragment_unnamed_486 = asfloat(fragment_unnamed_600 ? fragment_unnamed_537 : asuint(mad((-0.0f) - fragment_unnamed_193, 12.0f, fragment_unnamed_538)));
								fragment_unnamed_487 = asfloat(fragment_unnamed_601 ? fragment_unnamed_549 : asuint(mad(fragment_unnamed_193, 12.0f, fragment_unnamed_550)));
								fragment_unnamed_488 = asfloat(fragment_unnamed_600 ? fragment_unnamed_542 : asuint(mad((-0.0f) - fragment_unnamed_199, 12.0f, fragment_unnamed_543)));
								fragment_unnamed_489 = asfloat(fragment_unnamed_601 ? fragment_unnamed_553 : asuint(mad(fragment_unnamed_199, 12.0f, fragment_unnamed_554)));
							}
							else
							{
								fragment_unnamed_484 = fragment_unnamed_520;
								fragment_unnamed_485 = fragment_unnamed_526;
								fragment_unnamed_486 = fragment_unnamed_538;
								fragment_unnamed_487 = fragment_unnamed_550;
								fragment_unnamed_488 = fragment_unnamed_543;
								fragment_unnamed_489 = fragment_unnamed_554;
							}
							fragment_unnamed_341 = fragment_unnamed_484;
							fragment_unnamed_343 = fragment_unnamed_485;
							fragment_unnamed_345 = fragment_unnamed_486;
							fragment_unnamed_347 = fragment_unnamed_487;
							fragment_unnamed_349 = fragment_unnamed_488;
							fragment_unnamed_351 = fragment_unnamed_489;
						}
						else
						{
							fragment_unnamed_341 = fragment_unnamed_448;
							fragment_unnamed_343 = fragment_unnamed_454;
							fragment_unnamed_345 = fragment_unnamed_465;
							fragment_unnamed_347 = fragment_unnamed_477;
							fragment_unnamed_349 = fragment_unnamed_470;
							fragment_unnamed_351 = fragment_unnamed_481;
						}
						fragment_unnamed_340 = fragment_unnamed_341;
						fragment_unnamed_342 = fragment_unnamed_343;
						fragment_unnamed_344 = fragment_unnamed_345;
						fragment_unnamed_346 = fragment_unnamed_347;
						fragment_unnamed_348 = fragment_unnamed_349;
						fragment_unnamed_350 = fragment_unnamed_351;
					}
					else
					{
						fragment_unnamed_340 = fragment_unnamed_254;
						fragment_unnamed_342 = fragment_unnamed_256;
						fragment_unnamed_344 = fragment_unnamed_269;
						fragment_unnamed_346 = fragment_unnamed_283;
						fragment_unnamed_348 = fragment_unnamed_275;
						fragment_unnamed_350 = fragment_unnamed_288;
					}
					float fragment_unnamed_363 = asfloat(fragment_unnamed_144 ? asuint(((-0.0f) - fragment_unnamed_344) + fragment_input_1.x) : asuint(((-0.0f) - fragment_unnamed_348) + fragment_input_1.y));
					float fragment_unnamed_375 = asfloat(fragment_unnamed_144 ? asuint(fragment_unnamed_346 + ((-0.0f) - fragment_input_1.x)) : asuint(fragment_unnamed_350 + ((-0.0f) - fragment_input_1.y)));
					float fragment_unnamed_395 = max(fragment_unnamed_250 * fragment_unnamed_250, asfloat(asuint(mad(min(fragment_unnamed_363, fragment_unnamed_375), (-0.0f) - (1.0f / (fragment_unnamed_363 + fragment_unnamed_375)), 0.5f)) & ((fragment_unnamed_363 < fragment_unnamed_375) ? ((fragment_unnamed_252 != ((fragment_unnamed_340 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_252 != ((fragment_unnamed_342 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					float4 fragment_unnamed_416 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_144 ? fragment_input_1.x : mad(fragment_unnamed_395, fragment_unnamed_184, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_144 ? mad(fragment_unnamed_395, fragment_unnamed_184, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f);
					fragment_unnamed_290 = fragment_unnamed_416.x;
					fragment_unnamed_292 = fragment_unnamed_416.y;
					fragment_unnamed_294 = fragment_unnamed_416.z;
				}
				else
				{
					fragment_unnamed_290 = fragment_unnamed_56.x;
					fragment_unnamed_292 = fragment_unnamed_56.y;
					fragment_unnamed_294 = fragment_unnamed_56.z;
				}
				float fragment_unnamed_315 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				float fragment_unnamed_327 = (((-0.0f) - sqrt(((-0.0f) - abs(fragment_unnamed_315)) + 1.0f)) + 1.0f) * mad(clamp(mad(fragment_unnamed_315, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_327, 0.0039215688593685626983642578125f, fragment_unnamed_290);
				fragment_output_0.y = mad(fragment_unnamed_327, 0.0039215688593685626983642578125f, fragment_unnamed_292);
				fragment_output_0.z = mad(fragment_unnamed_327, 0.0039215688593685626983642578125f, fragment_unnamed_294);
				fragment_output_0.w = fragment_unnamed_61;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[29] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA_LOW) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA)


			#if defined(FXAA_LOW) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;
			float4 _PosScaleOffset;

			static float4 vertex_uniform_buffer_0[29];
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
				gl_Position.x = mad(vertex_input_0.x, vertex_uniform_buffer_0[28u].x, vertex_uniform_buffer_0[28u].z);
				gl_Position.y = mad(vertex_input_0.y, vertex_uniform_buffer_0[28u].y, vertex_uniform_buffer_0[28u].w);
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				float vertex_unnamed_68 = mad((vertex_input_0.x + 1.0f) * vertex_uniform_buffer_0[27u].x, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_70 = mad((vertex_input_0.y + 1.0f) * vertex_uniform_buffer_0[27u].y, 0.5f, vertex_uniform_buffer_0[27u].w);
				vertex_output_1.x = vertex_unnamed_68 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = vertex_unnamed_70 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_68;
				vertex_output_1.y = vertex_unnamed_70;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_uniform_buffer_0[28] = float4(_PosScaleOffset[0], _PosScaleOffset[1], _PosScaleOffset[2], _PosScaleOffset[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[31];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f);
				float fragment_unnamed_59 = fragment_unnamed_54.w;
				float4 fragment_unnamed_63 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, 1));
				float fragment_unnamed_67 = fragment_unnamed_63.w;
				float4 fragment_unnamed_68 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 0));
				float fragment_unnamed_71 = fragment_unnamed_68.w;
				float4 fragment_unnamed_73 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, -1));
				float fragment_unnamed_76 = fragment_unnamed_73.w;
				float4 fragment_unnamed_77 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 0));
				float fragment_unnamed_80 = fragment_unnamed_77.w;
				float fragment_unnamed_87 = max(max(fragment_unnamed_71, max(fragment_unnamed_59, fragment_unnamed_67)), max(fragment_unnamed_80, fragment_unnamed_76));
				float fragment_unnamed_93 = ((-0.0f) - min(min(fragment_unnamed_71, min(fragment_unnamed_59, fragment_unnamed_67)), min(fragment_unnamed_80, fragment_unnamed_76))) + fragment_unnamed_87;
				float fragment_unnamed_288;
				float fragment_unnamed_290;
				float fragment_unnamed_292;
				if (fragment_unnamed_93 >= max(fragment_unnamed_87 * 0.16599999368190765380859375f, 0.0625f))
				{
					float4 fragment_unnamed_99 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, -1));
					float fragment_unnamed_102 = fragment_unnamed_99.w;
					float4 fragment_unnamed_103 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 1));
					float fragment_unnamed_106 = fragment_unnamed_103.w;
					float4 fragment_unnamed_107 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, -1));
					float fragment_unnamed_110 = fragment_unnamed_107.w;
					float4 fragment_unnamed_111 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 1));
					float fragment_unnamed_114 = fragment_unnamed_111.w;
					float fragment_unnamed_115 = fragment_unnamed_67 + fragment_unnamed_76;
					float fragment_unnamed_116 = fragment_unnamed_71 + fragment_unnamed_80;
					float fragment_unnamed_122 = fragment_unnamed_106 + fragment_unnamed_110;
					float fragment_unnamed_126 = fragment_unnamed_114 + fragment_unnamed_102;
					bool fragment_unnamed_142 = (mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_115)), 2.0f, abs(mad(fragment_unnamed_71, -2.0f, fragment_unnamed_122))) + abs(mad(fragment_unnamed_80, -2.0f, fragment_unnamed_126))) >= (mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_116)), 2.0f, abs(mad(fragment_unnamed_76, -2.0f, fragment_unnamed_102 + fragment_unnamed_110))) + abs(mad(fragment_unnamed_67, -2.0f, fragment_unnamed_106 + fragment_unnamed_114)));
					float fragment_unnamed_149 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_76) : asuint(fragment_unnamed_80));
					float fragment_unnamed_153 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_67) : asuint(fragment_unnamed_71));
					float fragment_unnamed_165 = asfloat(fragment_unnamed_142 ? asuint(fragment_uniform_buffer_0[30u]).y : asuint(fragment_uniform_buffer_0[30u]).x);
					float fragment_unnamed_170 = ((-0.0f) - fragment_unnamed_59) + fragment_unnamed_149;
					float fragment_unnamed_172 = ((-0.0f) - fragment_unnamed_59) + fragment_unnamed_153;
					bool fragment_unnamed_177 = abs(fragment_unnamed_170) >= abs(fragment_unnamed_172);
					float fragment_unnamed_182 = fragment_unnamed_177 ? ((-0.0f) - fragment_unnamed_165) : fragment_unnamed_165;
					float fragment_unnamed_185 = clamp((1.0f / fragment_unnamed_93) * abs(mad(mad(fragment_unnamed_115 + fragment_unnamed_116, 2.0f, fragment_unnamed_122 + fragment_unnamed_126), 0.083333335816860198974609375f, (-0.0f) - fragment_unnamed_59)), 0.0f, 1.0f);
					float fragment_unnamed_191 = asfloat((fragment_unnamed_142 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[30u]).x);
					float fragment_unnamed_197 = asfloat(fragment_unnamed_142 ? 0u : asuint(fragment_uniform_buffer_0[30u]).y);
					float fragment_unnamed_207 = fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_182, 0.5f, fragment_input_1.x);
					float fragment_unnamed_210 = fragment_unnamed_142 ? mad(fragment_unnamed_182, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					float fragment_unnamed_213 = ((-0.0f) - fragment_unnamed_191) + fragment_unnamed_207;
					float fragment_unnamed_214 = ((-0.0f) - fragment_unnamed_197) + fragment_unnamed_210;
					float fragment_unnamed_215 = fragment_unnamed_191 + fragment_unnamed_207;
					float fragment_unnamed_216 = fragment_unnamed_197 + fragment_unnamed_210;
					float fragment_unnamed_243 = asfloat(fragment_unnamed_177 ? asuint(fragment_unnamed_59 + fragment_unnamed_149) : asuint(fragment_unnamed_59 + fragment_unnamed_153));
					float fragment_unnamed_244 = max(abs(fragment_unnamed_172), abs(fragment_unnamed_170)) * 0.25f;
					float fragment_unnamed_248 = (fragment_unnamed_185 * fragment_unnamed_185) * mad(fragment_unnamed_185, -2.0f, 3.0f);
					uint fragment_unnamed_250 = (mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_59) < 0.0f) ? 4294967295u : 0u;
					float fragment_unnamed_252 = mad((-0.0f) - fragment_unnamed_243, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_213, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_214, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w);
					float fragment_unnamed_254 = mad((-0.0f) - fragment_unnamed_243, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_215, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_216, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w);
					bool fragment_unnamed_257 = abs(fragment_unnamed_252) >= fragment_unnamed_244;
					bool fragment_unnamed_258 = abs(fragment_unnamed_254) >= fragment_unnamed_244;
					uint fragment_unnamed_259 = fragment_unnamed_257 ? 4294967295u : 0u;
					uint fragment_unnamed_260 = fragment_unnamed_258 ? 4294967295u : 0u;
					uint fragment_unnamed_266 = fragment_unnamed_257 ? asuint(fragment_unnamed_213) : asuint(mad((-0.0f) - fragment_unnamed_191, 1.5f, fragment_unnamed_213));
					float fragment_unnamed_267 = asfloat(fragment_unnamed_266);
					uint fragment_unnamed_272 = fragment_unnamed_257 ? asuint(fragment_unnamed_214) : asuint(mad((-0.0f) - fragment_unnamed_197, 1.5f, fragment_unnamed_214));
					float fragment_unnamed_273 = asfloat(fragment_unnamed_272);
					uint fragment_unnamed_280 = fragment_unnamed_258 ? asuint(fragment_unnamed_215) : asuint(mad(fragment_unnamed_191, 1.5f, fragment_unnamed_215));
					float fragment_unnamed_281 = asfloat(fragment_unnamed_280);
					uint fragment_unnamed_285 = fragment_unnamed_258 ? asuint(fragment_unnamed_216) : asuint(mad(fragment_unnamed_197, 1.5f, fragment_unnamed_216));
					float fragment_unnamed_286 = asfloat(fragment_unnamed_285);
					float fragment_unnamed_338;
					float fragment_unnamed_340;
					float fragment_unnamed_342;
					float fragment_unnamed_344;
					float fragment_unnamed_346;
					float fragment_unnamed_348;
					if (((~fragment_unnamed_260) | (~fragment_unnamed_259)) != 0u)
					{
						float fragment_unnamed_427;
						if (fragment_unnamed_259 == 0u)
						{
							fragment_unnamed_427 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_267, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_273, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
						}
						else
						{
							fragment_unnamed_427 = fragment_unnamed_252;
						}
						float fragment_unnamed_440;
						if (fragment_unnamed_260 == 0u)
						{
							fragment_unnamed_440 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_281, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_286, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
						}
						else
						{
							fragment_unnamed_440 = fragment_unnamed_254;
						}
						float fragment_unnamed_446 = asfloat(fragment_unnamed_257 ? asuint(fragment_unnamed_427) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_427)));
						float fragment_unnamed_452 = asfloat(fragment_unnamed_258 ? asuint(fragment_unnamed_440) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_440)));
						bool fragment_unnamed_455 = abs(fragment_unnamed_446) >= fragment_unnamed_244;
						bool fragment_unnamed_456 = abs(fragment_unnamed_452) >= fragment_unnamed_244;
						uint fragment_unnamed_457 = fragment_unnamed_455 ? 4294967295u : 0u;
						uint fragment_unnamed_458 = fragment_unnamed_456 ? 4294967295u : 0u;
						uint fragment_unnamed_462 = fragment_unnamed_455 ? fragment_unnamed_266 : asuint(mad((-0.0f) - fragment_unnamed_191, 2.0f, fragment_unnamed_267));
						float fragment_unnamed_463 = asfloat(fragment_unnamed_462);
						uint fragment_unnamed_467 = fragment_unnamed_455 ? fragment_unnamed_272 : asuint(mad((-0.0f) - fragment_unnamed_197, 2.0f, fragment_unnamed_273));
						float fragment_unnamed_468 = asfloat(fragment_unnamed_467);
						uint fragment_unnamed_474 = fragment_unnamed_456 ? fragment_unnamed_280 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_281));
						float fragment_unnamed_475 = asfloat(fragment_unnamed_474);
						uint fragment_unnamed_478 = fragment_unnamed_456 ? fragment_unnamed_285 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_286));
						float fragment_unnamed_479 = asfloat(fragment_unnamed_478);
						float fragment_unnamed_339;
						float fragment_unnamed_341;
						float fragment_unnamed_343;
						float fragment_unnamed_345;
						float fragment_unnamed_347;
						float fragment_unnamed_349;
						if (((~fragment_unnamed_458) | (~fragment_unnamed_457)) != 0u)
						{
							float fragment_unnamed_499;
							if (fragment_unnamed_457 == 0u)
							{
								fragment_unnamed_499 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_463, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_468, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
							}
							else
							{
								fragment_unnamed_499 = fragment_unnamed_446;
							}
							float fragment_unnamed_512;
							if (fragment_unnamed_458 == 0u)
							{
								fragment_unnamed_512 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_475, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_479, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
							}
							else
							{
								fragment_unnamed_512 = fragment_unnamed_452;
							}
							float fragment_unnamed_518 = asfloat(fragment_unnamed_455 ? asuint(fragment_unnamed_499) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_499)));
							float fragment_unnamed_524 = asfloat(fragment_unnamed_456 ? asuint(fragment_unnamed_512) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_512)));
							bool fragment_unnamed_527 = abs(fragment_unnamed_518) >= fragment_unnamed_244;
							bool fragment_unnamed_528 = abs(fragment_unnamed_524) >= fragment_unnamed_244;
							uint fragment_unnamed_529 = fragment_unnamed_527 ? 4294967295u : 0u;
							uint fragment_unnamed_530 = fragment_unnamed_528 ? 4294967295u : 0u;
							uint fragment_unnamed_535 = fragment_unnamed_527 ? fragment_unnamed_462 : asuint(mad((-0.0f) - fragment_unnamed_191, 4.0f, fragment_unnamed_463));
							float fragment_unnamed_536 = asfloat(fragment_unnamed_535);
							uint fragment_unnamed_540 = fragment_unnamed_527 ? fragment_unnamed_467 : asuint(mad((-0.0f) - fragment_unnamed_197, 4.0f, fragment_unnamed_468));
							float fragment_unnamed_541 = asfloat(fragment_unnamed_540);
							uint fragment_unnamed_547 = fragment_unnamed_528 ? fragment_unnamed_474 : asuint(mad(fragment_unnamed_191, 4.0f, fragment_unnamed_475));
							float fragment_unnamed_548 = asfloat(fragment_unnamed_547);
							uint fragment_unnamed_551 = fragment_unnamed_528 ? fragment_unnamed_478 : asuint(mad(fragment_unnamed_197, 4.0f, fragment_unnamed_479));
							float fragment_unnamed_552 = asfloat(fragment_unnamed_551);
							float fragment_unnamed_482;
							float fragment_unnamed_483;
							float fragment_unnamed_484;
							float fragment_unnamed_485;
							float fragment_unnamed_486;
							float fragment_unnamed_487;
							if (((~fragment_unnamed_530) | (~fragment_unnamed_529)) != 0u)
							{
								float fragment_unnamed_572;
								if (fragment_unnamed_529 == 0u)
								{
									fragment_unnamed_572 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_536, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_541, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
								}
								else
								{
									fragment_unnamed_572 = fragment_unnamed_518;
								}
								float fragment_unnamed_585;
								if (fragment_unnamed_530 == 0u)
								{
									fragment_unnamed_585 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_548, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_552, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).w;
								}
								else
								{
									fragment_unnamed_585 = fragment_unnamed_524;
								}
								float fragment_unnamed_555 = asfloat(fragment_unnamed_527 ? asuint(fragment_unnamed_572) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_572)));
								float fragment_unnamed_556 = asfloat(fragment_unnamed_528 ? asuint(fragment_unnamed_585) : asuint(mad((-0.0f) - fragment_unnamed_243, 0.5f, fragment_unnamed_585)));
								bool fragment_unnamed_598 = abs(fragment_unnamed_555) >= fragment_unnamed_244;
								bool fragment_unnamed_599 = abs(fragment_unnamed_556) >= fragment_unnamed_244;
								fragment_unnamed_482 = fragment_unnamed_555;
								fragment_unnamed_483 = fragment_unnamed_556;
								fragment_unnamed_484 = asfloat(fragment_unnamed_598 ? fragment_unnamed_535 : asuint(mad((-0.0f) - fragment_unnamed_191, 12.0f, fragment_unnamed_536)));
								fragment_unnamed_485 = asfloat(fragment_unnamed_599 ? fragment_unnamed_547 : asuint(mad(fragment_unnamed_191, 12.0f, fragment_unnamed_548)));
								fragment_unnamed_486 = asfloat(fragment_unnamed_598 ? fragment_unnamed_540 : asuint(mad((-0.0f) - fragment_unnamed_197, 12.0f, fragment_unnamed_541)));
								fragment_unnamed_487 = asfloat(fragment_unnamed_599 ? fragment_unnamed_551 : asuint(mad(fragment_unnamed_197, 12.0f, fragment_unnamed_552)));
							}
							else
							{
								fragment_unnamed_482 = fragment_unnamed_518;
								fragment_unnamed_483 = fragment_unnamed_524;
								fragment_unnamed_484 = fragment_unnamed_536;
								fragment_unnamed_485 = fragment_unnamed_548;
								fragment_unnamed_486 = fragment_unnamed_541;
								fragment_unnamed_487 = fragment_unnamed_552;
							}
							fragment_unnamed_339 = fragment_unnamed_482;
							fragment_unnamed_341 = fragment_unnamed_483;
							fragment_unnamed_343 = fragment_unnamed_484;
							fragment_unnamed_345 = fragment_unnamed_485;
							fragment_unnamed_347 = fragment_unnamed_486;
							fragment_unnamed_349 = fragment_unnamed_487;
						}
						else
						{
							fragment_unnamed_339 = fragment_unnamed_446;
							fragment_unnamed_341 = fragment_unnamed_452;
							fragment_unnamed_343 = fragment_unnamed_463;
							fragment_unnamed_345 = fragment_unnamed_475;
							fragment_unnamed_347 = fragment_unnamed_468;
							fragment_unnamed_349 = fragment_unnamed_479;
						}
						fragment_unnamed_338 = fragment_unnamed_339;
						fragment_unnamed_340 = fragment_unnamed_341;
						fragment_unnamed_342 = fragment_unnamed_343;
						fragment_unnamed_344 = fragment_unnamed_345;
						fragment_unnamed_346 = fragment_unnamed_347;
						fragment_unnamed_348 = fragment_unnamed_349;
					}
					else
					{
						fragment_unnamed_338 = fragment_unnamed_252;
						fragment_unnamed_340 = fragment_unnamed_254;
						fragment_unnamed_342 = fragment_unnamed_267;
						fragment_unnamed_344 = fragment_unnamed_281;
						fragment_unnamed_346 = fragment_unnamed_273;
						fragment_unnamed_348 = fragment_unnamed_286;
					}
					float fragment_unnamed_361 = asfloat(fragment_unnamed_142 ? asuint(((-0.0f) - fragment_unnamed_342) + fragment_input_1.x) : asuint(((-0.0f) - fragment_unnamed_346) + fragment_input_1.y));
					float fragment_unnamed_373 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_344 + ((-0.0f) - fragment_input_1.x)) : asuint(fragment_unnamed_348 + ((-0.0f) - fragment_input_1.y)));
					float fragment_unnamed_393 = max(fragment_unnamed_248 * fragment_unnamed_248, asfloat(asuint(mad(min(fragment_unnamed_361, fragment_unnamed_373), (-0.0f) - (1.0f / (fragment_unnamed_361 + fragment_unnamed_373)), 0.5f)) & ((fragment_unnamed_361 < fragment_unnamed_373) ? ((fragment_unnamed_250 != ((fragment_unnamed_338 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_250 != ((fragment_unnamed_340 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					float4 fragment_unnamed_414 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_393, fragment_unnamed_182, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_142 ? mad(fragment_unnamed_393, fragment_unnamed_182, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f);
					fragment_unnamed_288 = fragment_unnamed_414.x;
					fragment_unnamed_290 = fragment_unnamed_414.y;
					fragment_unnamed_292 = fragment_unnamed_414.z;
				}
				else
				{
					fragment_unnamed_288 = fragment_unnamed_54.x;
					fragment_unnamed_290 = fragment_unnamed_54.y;
					fragment_unnamed_292 = fragment_unnamed_54.z;
				}
				float fragment_unnamed_313 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[29u].x, fragment_uniform_buffer_0[29u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[29u].y, fragment_uniform_buffer_0[29u].w))).w, 2.0f, -1.0f);
				float fragment_unnamed_325 = (((-0.0f) - sqrt(((-0.0f) - abs(fragment_unnamed_313)) + 1.0f)) + 1.0f) * mad(clamp(mad(fragment_unnamed_313, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_288);
				fragment_output_0.y = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_290);
				fragment_output_0.z = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_292);
				fragment_output_0.w = fragment_unnamed_59;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[29] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[30] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA_LOW) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA)


			#if defined(FXAA_KEEP_ALPHA) && defined(FXAA_LOW) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
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
				float vertex_unnamed_57 = mad((vertex_input_0.x + 1.0f) * vertex_uniform_buffer_0[27u].x, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_59 = mad((vertex_input_0.y + 1.0f) * vertex_uniform_buffer_0[27u].y, 0.5f, vertex_uniform_buffer_0[27u].w);
				vertex_output_1.x = vertex_unnamed_57 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_57;
				vertex_output_1.y = vertex_unnamed_59;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f);
				float fragment_unnamed_57 = fragment_unnamed_54.y;
				float4 fragment_unnamed_62 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, 1));
				float fragment_unnamed_66 = fragment_unnamed_62.y;
				float4 fragment_unnamed_67 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 0));
				float fragment_unnamed_70 = fragment_unnamed_67.y;
				float4 fragment_unnamed_72 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, -1));
				float fragment_unnamed_75 = fragment_unnamed_72.y;
				float4 fragment_unnamed_76 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 0));
				float fragment_unnamed_79 = fragment_unnamed_76.y;
				float fragment_unnamed_86 = max(max(fragment_unnamed_70, max(fragment_unnamed_57, fragment_unnamed_66)), max(fragment_unnamed_75, fragment_unnamed_79));
				float fragment_unnamed_92 = ((-0.0f) - min(min(fragment_unnamed_70, min(fragment_unnamed_57, fragment_unnamed_66)), min(fragment_unnamed_75, fragment_unnamed_79))) + fragment_unnamed_86;
				float fragment_unnamed_286;
				float fragment_unnamed_288;
				float fragment_unnamed_290;
				if (fragment_unnamed_92 >= max(fragment_unnamed_86 * 0.16599999368190765380859375f, 0.0625f))
				{
					float4 fragment_unnamed_98 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, -1));
					float fragment_unnamed_101 = fragment_unnamed_98.y;
					float4 fragment_unnamed_102 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 1));
					float fragment_unnamed_105 = fragment_unnamed_102.y;
					float4 fragment_unnamed_106 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, -1));
					float fragment_unnamed_109 = fragment_unnamed_106.y;
					float4 fragment_unnamed_110 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 1));
					float fragment_unnamed_113 = fragment_unnamed_110.y;
					float fragment_unnamed_114 = fragment_unnamed_66 + fragment_unnamed_75;
					float fragment_unnamed_115 = fragment_unnamed_70 + fragment_unnamed_79;
					float fragment_unnamed_121 = fragment_unnamed_105 + fragment_unnamed_109;
					float fragment_unnamed_125 = fragment_unnamed_113 + fragment_unnamed_101;
					bool fragment_unnamed_141 = (mad(abs(mad(fragment_unnamed_57, -2.0f, fragment_unnamed_114)), 2.0f, abs(mad(fragment_unnamed_70, -2.0f, fragment_unnamed_121))) + abs(mad(fragment_unnamed_79, -2.0f, fragment_unnamed_125))) >= (mad(abs(mad(fragment_unnamed_57, -2.0f, fragment_unnamed_115)), 2.0f, abs(mad(fragment_unnamed_75, -2.0f, fragment_unnamed_101 + fragment_unnamed_109))) + abs(mad(fragment_unnamed_66, -2.0f, fragment_unnamed_105 + fragment_unnamed_113)));
					float fragment_unnamed_148 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_75) : asuint(fragment_unnamed_79));
					float fragment_unnamed_152 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_66) : asuint(fragment_unnamed_70));
					float fragment_unnamed_164 = asfloat(fragment_unnamed_141 ? asuint(fragment_uniform_buffer_0[29u]).y : asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_169 = ((-0.0f) - fragment_unnamed_57) + fragment_unnamed_148;
					float fragment_unnamed_171 = ((-0.0f) - fragment_unnamed_57) + fragment_unnamed_152;
					bool fragment_unnamed_176 = abs(fragment_unnamed_169) >= abs(fragment_unnamed_171);
					float fragment_unnamed_181 = fragment_unnamed_176 ? ((-0.0f) - fragment_unnamed_164) : fragment_unnamed_164;
					float fragment_unnamed_184 = clamp((1.0f / fragment_unnamed_92) * abs(mad(mad(fragment_unnamed_114 + fragment_unnamed_115, 2.0f, fragment_unnamed_121 + fragment_unnamed_125), 0.083333335816860198974609375f, (-0.0f) - fragment_unnamed_57)), 0.0f, 1.0f);
					float fragment_unnamed_190 = asfloat((fragment_unnamed_141 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_196 = asfloat(fragment_unnamed_141 ? 0u : asuint(fragment_uniform_buffer_0[29u]).y);
					float fragment_unnamed_206 = fragment_unnamed_141 ? fragment_input_1.x : mad(fragment_unnamed_181, 0.5f, fragment_input_1.x);
					float fragment_unnamed_209 = fragment_unnamed_141 ? mad(fragment_unnamed_181, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					float fragment_unnamed_212 = ((-0.0f) - fragment_unnamed_190) + fragment_unnamed_206;
					float fragment_unnamed_213 = ((-0.0f) - fragment_unnamed_196) + fragment_unnamed_209;
					float fragment_unnamed_214 = fragment_unnamed_190 + fragment_unnamed_206;
					float fragment_unnamed_215 = fragment_unnamed_196 + fragment_unnamed_209;
					float fragment_unnamed_242 = asfloat(fragment_unnamed_176 ? asuint(fragment_unnamed_57 + fragment_unnamed_148) : asuint(fragment_unnamed_57 + fragment_unnamed_152));
					float fragment_unnamed_243 = max(abs(fragment_unnamed_171), abs(fragment_unnamed_169)) * 0.25f;
					float fragment_unnamed_247 = (fragment_unnamed_184 * fragment_unnamed_184) * mad(fragment_unnamed_184, -2.0f, 3.0f);
					uint fragment_unnamed_249 = (mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_57) < 0.0f) ? 4294967295u : 0u;
					float fragment_unnamed_251 = mad((-0.0f) - fragment_unnamed_242, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_212, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_213, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y);
					float fragment_unnamed_253 = mad((-0.0f) - fragment_unnamed_242, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_214, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_215, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y);
					bool fragment_unnamed_256 = abs(fragment_unnamed_251) >= fragment_unnamed_243;
					bool fragment_unnamed_257 = abs(fragment_unnamed_253) >= fragment_unnamed_243;
					uint fragment_unnamed_258 = fragment_unnamed_256 ? 4294967295u : 0u;
					uint fragment_unnamed_259 = fragment_unnamed_257 ? 4294967295u : 0u;
					uint fragment_unnamed_265 = fragment_unnamed_256 ? asuint(fragment_unnamed_212) : asuint(mad((-0.0f) - fragment_unnamed_190, 1.5f, fragment_unnamed_212));
					float fragment_unnamed_266 = asfloat(fragment_unnamed_265);
					uint fragment_unnamed_271 = fragment_unnamed_256 ? asuint(fragment_unnamed_213) : asuint(mad((-0.0f) - fragment_unnamed_196, 1.5f, fragment_unnamed_213));
					float fragment_unnamed_272 = asfloat(fragment_unnamed_271);
					uint fragment_unnamed_279 = fragment_unnamed_257 ? asuint(fragment_unnamed_214) : asuint(mad(fragment_unnamed_190, 1.5f, fragment_unnamed_214));
					float fragment_unnamed_280 = asfloat(fragment_unnamed_279);
					uint fragment_unnamed_284 = fragment_unnamed_257 ? asuint(fragment_unnamed_215) : asuint(mad(fragment_unnamed_196, 1.5f, fragment_unnamed_215));
					float fragment_unnamed_344;
					float fragment_unnamed_346;
					float fragment_unnamed_348;
					float fragment_unnamed_350;
					float fragment_unnamed_352;
					uint fragment_unnamed_354;
					if (((~fragment_unnamed_259) | (~fragment_unnamed_258)) != 0u)
					{
						float fragment_unnamed_434;
						if (fragment_unnamed_258 == 0u)
						{
							fragment_unnamed_434 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_266, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_272, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
						}
						else
						{
							fragment_unnamed_434 = fragment_unnamed_251;
						}
						float fragment_unnamed_448;
						if (fragment_unnamed_259 == 0u)
						{
							fragment_unnamed_448 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_280, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_284), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
						}
						else
						{
							fragment_unnamed_448 = fragment_unnamed_253;
						}
						float fragment_unnamed_454 = asfloat(fragment_unnamed_256 ? asuint(fragment_unnamed_434) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_434)));
						float fragment_unnamed_460 = asfloat(fragment_unnamed_257 ? asuint(fragment_unnamed_448) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_448)));
						bool fragment_unnamed_463 = abs(fragment_unnamed_454) >= fragment_unnamed_243;
						bool fragment_unnamed_464 = abs(fragment_unnamed_460) >= fragment_unnamed_243;
						uint fragment_unnamed_465 = fragment_unnamed_463 ? 4294967295u : 0u;
						uint fragment_unnamed_466 = fragment_unnamed_464 ? 4294967295u : 0u;
						uint fragment_unnamed_470 = fragment_unnamed_463 ? fragment_unnamed_265 : asuint(mad((-0.0f) - fragment_unnamed_190, 2.0f, fragment_unnamed_266));
						float fragment_unnamed_471 = asfloat(fragment_unnamed_470);
						uint fragment_unnamed_475 = fragment_unnamed_463 ? fragment_unnamed_271 : asuint(mad((-0.0f) - fragment_unnamed_196, 2.0f, fragment_unnamed_272));
						float fragment_unnamed_476 = asfloat(fragment_unnamed_475);
						uint fragment_unnamed_482 = fragment_unnamed_464 ? fragment_unnamed_279 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_280));
						float fragment_unnamed_483 = asfloat(fragment_unnamed_482);
						uint fragment_unnamed_487 = fragment_unnamed_464 ? fragment_unnamed_284 : asuint(mad(fragment_unnamed_196, 2.0f, asfloat(fragment_unnamed_284)));
						float fragment_unnamed_345;
						float fragment_unnamed_347;
						float fragment_unnamed_349;
						float fragment_unnamed_351;
						float fragment_unnamed_353;
						uint fragment_unnamed_355;
						if (((~fragment_unnamed_466) | (~fragment_unnamed_465)) != 0u)
						{
							float fragment_unnamed_507;
							if (fragment_unnamed_465 == 0u)
							{
								fragment_unnamed_507 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_471, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_476, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
							}
							else
							{
								fragment_unnamed_507 = fragment_unnamed_454;
							}
							float fragment_unnamed_521;
							if (fragment_unnamed_466 == 0u)
							{
								fragment_unnamed_521 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_483, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_487), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
							}
							else
							{
								fragment_unnamed_521 = fragment_unnamed_460;
							}
							float fragment_unnamed_527 = asfloat(fragment_unnamed_463 ? asuint(fragment_unnamed_507) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_507)));
							float fragment_unnamed_533 = asfloat(fragment_unnamed_464 ? asuint(fragment_unnamed_521) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_521)));
							bool fragment_unnamed_536 = abs(fragment_unnamed_527) >= fragment_unnamed_243;
							bool fragment_unnamed_537 = abs(fragment_unnamed_533) >= fragment_unnamed_243;
							uint fragment_unnamed_538 = fragment_unnamed_536 ? 4294967295u : 0u;
							uint fragment_unnamed_539 = fragment_unnamed_537 ? 4294967295u : 0u;
							uint fragment_unnamed_544 = fragment_unnamed_536 ? fragment_unnamed_470 : asuint(mad((-0.0f) - fragment_unnamed_190, 4.0f, fragment_unnamed_471));
							float fragment_unnamed_545 = asfloat(fragment_unnamed_544);
							uint fragment_unnamed_549 = fragment_unnamed_536 ? fragment_unnamed_475 : asuint(mad((-0.0f) - fragment_unnamed_196, 4.0f, fragment_unnamed_476));
							float fragment_unnamed_550 = asfloat(fragment_unnamed_549);
							uint fragment_unnamed_556 = fragment_unnamed_537 ? fragment_unnamed_482 : asuint(mad(fragment_unnamed_190, 4.0f, fragment_unnamed_483));
							float fragment_unnamed_557 = asfloat(fragment_unnamed_556);
							uint fragment_unnamed_561 = fragment_unnamed_537 ? fragment_unnamed_487 : asuint(mad(fragment_unnamed_196, 4.0f, asfloat(fragment_unnamed_487)));
							float fragment_unnamed_490;
							float fragment_unnamed_491;
							float fragment_unnamed_492;
							float fragment_unnamed_493;
							float fragment_unnamed_494;
							uint fragment_unnamed_495;
							if (((~fragment_unnamed_539) | (~fragment_unnamed_538)) != 0u)
							{
								float fragment_unnamed_581;
								if (fragment_unnamed_538 == 0u)
								{
									fragment_unnamed_581 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_545, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_550, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
								}
								else
								{
									fragment_unnamed_581 = fragment_unnamed_527;
								}
								float fragment_unnamed_595;
								if (fragment_unnamed_539 == 0u)
								{
									fragment_unnamed_595 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_557, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_561), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
								}
								else
								{
									fragment_unnamed_595 = fragment_unnamed_533;
								}
								float fragment_unnamed_564 = asfloat(fragment_unnamed_536 ? asuint(fragment_unnamed_581) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_581)));
								float fragment_unnamed_565 = asfloat(fragment_unnamed_537 ? asuint(fragment_unnamed_595) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_595)));
								bool fragment_unnamed_608 = abs(fragment_unnamed_564) >= fragment_unnamed_243;
								bool fragment_unnamed_609 = abs(fragment_unnamed_565) >= fragment_unnamed_243;
								fragment_unnamed_490 = fragment_unnamed_564;
								fragment_unnamed_491 = fragment_unnamed_565;
								fragment_unnamed_492 = asfloat(fragment_unnamed_608 ? fragment_unnamed_544 : asuint(mad((-0.0f) - fragment_unnamed_190, 12.0f, fragment_unnamed_545)));
								fragment_unnamed_493 = asfloat(fragment_unnamed_609 ? fragment_unnamed_556 : asuint(mad(fragment_unnamed_190, 12.0f, fragment_unnamed_557)));
								fragment_unnamed_494 = asfloat(fragment_unnamed_608 ? fragment_unnamed_549 : asuint(mad((-0.0f) - fragment_unnamed_196, 12.0f, fragment_unnamed_550)));
								fragment_unnamed_495 = fragment_unnamed_609 ? fragment_unnamed_561 : asuint(mad(fragment_unnamed_196, 12.0f, asfloat(fragment_unnamed_561)));
							}
							else
							{
								fragment_unnamed_490 = fragment_unnamed_527;
								fragment_unnamed_491 = fragment_unnamed_533;
								fragment_unnamed_492 = fragment_unnamed_545;
								fragment_unnamed_493 = fragment_unnamed_557;
								fragment_unnamed_494 = fragment_unnamed_550;
								fragment_unnamed_495 = fragment_unnamed_561;
							}
							fragment_unnamed_345 = fragment_unnamed_490;
							fragment_unnamed_347 = fragment_unnamed_491;
							fragment_unnamed_349 = fragment_unnamed_492;
							fragment_unnamed_351 = fragment_unnamed_493;
							fragment_unnamed_353 = fragment_unnamed_494;
							fragment_unnamed_355 = fragment_unnamed_495;
						}
						else
						{
							fragment_unnamed_345 = fragment_unnamed_454;
							fragment_unnamed_347 = fragment_unnamed_460;
							fragment_unnamed_349 = fragment_unnamed_471;
							fragment_unnamed_351 = fragment_unnamed_483;
							fragment_unnamed_353 = fragment_unnamed_476;
							fragment_unnamed_355 = fragment_unnamed_487;
						}
						fragment_unnamed_344 = fragment_unnamed_345;
						fragment_unnamed_346 = fragment_unnamed_347;
						fragment_unnamed_348 = fragment_unnamed_349;
						fragment_unnamed_350 = fragment_unnamed_351;
						fragment_unnamed_352 = fragment_unnamed_353;
						fragment_unnamed_354 = fragment_unnamed_355;
					}
					else
					{
						fragment_unnamed_344 = fragment_unnamed_251;
						fragment_unnamed_346 = fragment_unnamed_253;
						fragment_unnamed_348 = fragment_unnamed_266;
						fragment_unnamed_350 = fragment_unnamed_280;
						fragment_unnamed_352 = fragment_unnamed_272;
						fragment_unnamed_354 = fragment_unnamed_284;
					}
					float fragment_unnamed_371 = asfloat(fragment_unnamed_141 ? asuint(((-0.0f) - fragment_unnamed_348) + fragment_input_1.x) : asuint(((-0.0f) - fragment_unnamed_352) + fragment_input_1.y));
					float fragment_unnamed_380 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_350 + ((-0.0f) - fragment_input_1.x)) : asuint(asfloat(fragment_unnamed_354) + ((-0.0f) - fragment_input_1.y)));
					float fragment_unnamed_400 = max(fragment_unnamed_247 * fragment_unnamed_247, asfloat(asuint(mad(min(fragment_unnamed_371, fragment_unnamed_380), (-0.0f) - (1.0f / (fragment_unnamed_371 + fragment_unnamed_380)), 0.5f)) & ((fragment_unnamed_371 < fragment_unnamed_380) ? ((fragment_unnamed_249 != ((fragment_unnamed_344 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_249 != ((fragment_unnamed_346 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					float4 fragment_unnamed_421 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_141 ? fragment_input_1.x : mad(fragment_unnamed_400, fragment_unnamed_181, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_141 ? mad(fragment_unnamed_400, fragment_unnamed_181, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f);
					fragment_unnamed_286 = fragment_unnamed_421.x;
					fragment_unnamed_288 = fragment_unnamed_421.y;
					fragment_unnamed_290 = fragment_unnamed_421.z;
				}
				else
				{
					fragment_unnamed_286 = fragment_unnamed_54.x;
					fragment_unnamed_288 = fragment_unnamed_57;
					fragment_unnamed_290 = fragment_unnamed_54.z;
				}
				float fragment_unnamed_319 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				float fragment_unnamed_331 = (((-0.0f) - sqrt(((-0.0f) - abs(fragment_unnamed_319)) + 1.0f)) + 1.0f) * mad(clamp(mad(fragment_unnamed_319, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_331, 0.0039215688593685626983642578125f, fragment_unnamed_286);
				fragment_output_0.y = mad(fragment_unnamed_331, 0.0039215688593685626983642578125f, fragment_unnamed_288);
				fragment_output_0.z = mad(fragment_unnamed_331, 0.0039215688593685626983642578125f, fragment_unnamed_290);
				fragment_output_0.w = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[29] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA_KEEP_ALPHA) && defined(FXAA_LOW) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA)


			#if defined(FXAA_KEEP_ALPHA) && defined(FXAA_LOW) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float _DepthSlice;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
			static float4 gl_Position;
			static uint gl_Layer;
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
				uint gl_Layer : SV_RenderTargetArrayIndex;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				float vertex_unnamed_59 = mad((vertex_input_0.x + 1.0f) * vertex_uniform_buffer_0[27u].x, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_61 = mad((vertex_input_0.y + 1.0f) * vertex_uniform_buffer_0[27u].y, 0.5f, vertex_uniform_buffer_0[27u].w);
				vertex_output_1.x = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = vertex_unnamed_61 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_59;
				vertex_output_1.y = vertex_unnamed_61;
				gl_Layer = int(uint(vertex_uniform_buffer_0[26u].y));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[26] = float4(vertex_uniform_buffer_0[26][0], _DepthSlice, vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.gl_Layer = gl_Layer;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_52 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float fragment_unnamed_53 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_56 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f);
				float fragment_unnamed_59 = fragment_unnamed_56.y;
				float4 fragment_unnamed_64 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(0, 1));
				float fragment_unnamed_68 = fragment_unnamed_64.y;
				float4 fragment_unnamed_69 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, 0));
				float fragment_unnamed_72 = fragment_unnamed_69.y;
				float4 fragment_unnamed_74 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(0, -1));
				float fragment_unnamed_77 = fragment_unnamed_74.y;
				float4 fragment_unnamed_78 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, 0));
				float fragment_unnamed_81 = fragment_unnamed_78.y;
				float fragment_unnamed_88 = max(max(fragment_unnamed_72, max(fragment_unnamed_59, fragment_unnamed_68)), max(fragment_unnamed_77, fragment_unnamed_81));
				float fragment_unnamed_94 = ((-0.0f) - min(min(fragment_unnamed_72, min(fragment_unnamed_59, fragment_unnamed_68)), min(fragment_unnamed_77, fragment_unnamed_81))) + fragment_unnamed_88;
				float fragment_unnamed_288;
				float fragment_unnamed_290;
				float fragment_unnamed_292;
				if (fragment_unnamed_94 >= max(fragment_unnamed_88 * 0.16599999368190765380859375f, 0.0625f))
				{
					float4 fragment_unnamed_100 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, -1));
					float fragment_unnamed_103 = fragment_unnamed_100.y;
					float4 fragment_unnamed_104 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, 1));
					float fragment_unnamed_107 = fragment_unnamed_104.y;
					float4 fragment_unnamed_108 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, -1));
					float fragment_unnamed_111 = fragment_unnamed_108.y;
					float4 fragment_unnamed_112 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, 1));
					float fragment_unnamed_115 = fragment_unnamed_112.y;
					float fragment_unnamed_116 = fragment_unnamed_68 + fragment_unnamed_77;
					float fragment_unnamed_117 = fragment_unnamed_72 + fragment_unnamed_81;
					float fragment_unnamed_123 = fragment_unnamed_107 + fragment_unnamed_111;
					float fragment_unnamed_127 = fragment_unnamed_115 + fragment_unnamed_103;
					bool fragment_unnamed_143 = (mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_116)), 2.0f, abs(mad(fragment_unnamed_72, -2.0f, fragment_unnamed_123))) + abs(mad(fragment_unnamed_81, -2.0f, fragment_unnamed_127))) >= (mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_117)), 2.0f, abs(mad(fragment_unnamed_77, -2.0f, fragment_unnamed_103 + fragment_unnamed_111))) + abs(mad(fragment_unnamed_68, -2.0f, fragment_unnamed_107 + fragment_unnamed_115)));
					float fragment_unnamed_150 = asfloat(fragment_unnamed_143 ? asuint(fragment_unnamed_77) : asuint(fragment_unnamed_81));
					float fragment_unnamed_154 = asfloat(fragment_unnamed_143 ? asuint(fragment_unnamed_68) : asuint(fragment_unnamed_72));
					float fragment_unnamed_166 = asfloat(fragment_unnamed_143 ? asuint(fragment_uniform_buffer_0[29u]).y : asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_171 = ((-0.0f) - fragment_unnamed_59) + fragment_unnamed_150;
					float fragment_unnamed_173 = ((-0.0f) - fragment_unnamed_59) + fragment_unnamed_154;
					bool fragment_unnamed_178 = abs(fragment_unnamed_171) >= abs(fragment_unnamed_173);
					float fragment_unnamed_183 = fragment_unnamed_178 ? ((-0.0f) - fragment_unnamed_166) : fragment_unnamed_166;
					float fragment_unnamed_186 = clamp((1.0f / fragment_unnamed_94) * abs(mad(mad(fragment_unnamed_116 + fragment_unnamed_117, 2.0f, fragment_unnamed_123 + fragment_unnamed_127), 0.083333335816860198974609375f, (-0.0f) - fragment_unnamed_59)), 0.0f, 1.0f);
					float fragment_unnamed_192 = asfloat((fragment_unnamed_143 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_198 = asfloat(fragment_unnamed_143 ? 0u : asuint(fragment_uniform_buffer_0[29u]).y);
					float fragment_unnamed_208 = fragment_unnamed_143 ? fragment_input_1.x : mad(fragment_unnamed_183, 0.5f, fragment_input_1.x);
					float fragment_unnamed_211 = fragment_unnamed_143 ? mad(fragment_unnamed_183, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					float fragment_unnamed_214 = ((-0.0f) - fragment_unnamed_192) + fragment_unnamed_208;
					float fragment_unnamed_215 = ((-0.0f) - fragment_unnamed_198) + fragment_unnamed_211;
					float fragment_unnamed_216 = fragment_unnamed_192 + fragment_unnamed_208;
					float fragment_unnamed_217 = fragment_unnamed_198 + fragment_unnamed_211;
					float fragment_unnamed_244 = asfloat(fragment_unnamed_178 ? asuint(fragment_unnamed_59 + fragment_unnamed_150) : asuint(fragment_unnamed_59 + fragment_unnamed_154));
					float fragment_unnamed_245 = max(abs(fragment_unnamed_173), abs(fragment_unnamed_171)) * 0.25f;
					float fragment_unnamed_249 = (fragment_unnamed_186 * fragment_unnamed_186) * mad(fragment_unnamed_186, -2.0f, 3.0f);
					uint fragment_unnamed_251 = (mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_59) < 0.0f) ? 4294967295u : 0u;
					float fragment_unnamed_253 = mad((-0.0f) - fragment_unnamed_244, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_214, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_215, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y);
					float fragment_unnamed_255 = mad((-0.0f) - fragment_unnamed_244, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_216, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_217, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y);
					bool fragment_unnamed_258 = abs(fragment_unnamed_253) >= fragment_unnamed_245;
					bool fragment_unnamed_259 = abs(fragment_unnamed_255) >= fragment_unnamed_245;
					uint fragment_unnamed_260 = fragment_unnamed_258 ? 4294967295u : 0u;
					uint fragment_unnamed_261 = fragment_unnamed_259 ? 4294967295u : 0u;
					uint fragment_unnamed_267 = fragment_unnamed_258 ? asuint(fragment_unnamed_214) : asuint(mad((-0.0f) - fragment_unnamed_192, 1.5f, fragment_unnamed_214));
					float fragment_unnamed_268 = asfloat(fragment_unnamed_267);
					uint fragment_unnamed_273 = fragment_unnamed_258 ? asuint(fragment_unnamed_215) : asuint(mad((-0.0f) - fragment_unnamed_198, 1.5f, fragment_unnamed_215));
					float fragment_unnamed_274 = asfloat(fragment_unnamed_273);
					uint fragment_unnamed_281 = fragment_unnamed_259 ? asuint(fragment_unnamed_216) : asuint(mad(fragment_unnamed_192, 1.5f, fragment_unnamed_216));
					float fragment_unnamed_282 = asfloat(fragment_unnamed_281);
					uint fragment_unnamed_286 = fragment_unnamed_259 ? asuint(fragment_unnamed_217) : asuint(mad(fragment_unnamed_198, 1.5f, fragment_unnamed_217));
					float fragment_unnamed_346;
					float fragment_unnamed_348;
					float fragment_unnamed_350;
					float fragment_unnamed_352;
					float fragment_unnamed_354;
					uint fragment_unnamed_356;
					if (((~fragment_unnamed_261) | (~fragment_unnamed_260)) != 0u)
					{
						float fragment_unnamed_436;
						if (fragment_unnamed_260 == 0u)
						{
							fragment_unnamed_436 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_268, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_274, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
						}
						else
						{
							fragment_unnamed_436 = fragment_unnamed_253;
						}
						float fragment_unnamed_450;
						if (fragment_unnamed_261 == 0u)
						{
							fragment_unnamed_450 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_282, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_286), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
						}
						else
						{
							fragment_unnamed_450 = fragment_unnamed_255;
						}
						float fragment_unnamed_456 = asfloat(fragment_unnamed_258 ? asuint(fragment_unnamed_436) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_436)));
						float fragment_unnamed_462 = asfloat(fragment_unnamed_259 ? asuint(fragment_unnamed_450) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_450)));
						bool fragment_unnamed_465 = abs(fragment_unnamed_456) >= fragment_unnamed_245;
						bool fragment_unnamed_466 = abs(fragment_unnamed_462) >= fragment_unnamed_245;
						uint fragment_unnamed_467 = fragment_unnamed_465 ? 4294967295u : 0u;
						uint fragment_unnamed_468 = fragment_unnamed_466 ? 4294967295u : 0u;
						uint fragment_unnamed_472 = fragment_unnamed_465 ? fragment_unnamed_267 : asuint(mad((-0.0f) - fragment_unnamed_192, 2.0f, fragment_unnamed_268));
						float fragment_unnamed_473 = asfloat(fragment_unnamed_472);
						uint fragment_unnamed_477 = fragment_unnamed_465 ? fragment_unnamed_273 : asuint(mad((-0.0f) - fragment_unnamed_198, 2.0f, fragment_unnamed_274));
						float fragment_unnamed_478 = asfloat(fragment_unnamed_477);
						uint fragment_unnamed_484 = fragment_unnamed_466 ? fragment_unnamed_281 : asuint(mad(fragment_unnamed_192, 2.0f, fragment_unnamed_282));
						float fragment_unnamed_485 = asfloat(fragment_unnamed_484);
						uint fragment_unnamed_489 = fragment_unnamed_466 ? fragment_unnamed_286 : asuint(mad(fragment_unnamed_198, 2.0f, asfloat(fragment_unnamed_286)));
						float fragment_unnamed_347;
						float fragment_unnamed_349;
						float fragment_unnamed_351;
						float fragment_unnamed_353;
						float fragment_unnamed_355;
						uint fragment_unnamed_357;
						if (((~fragment_unnamed_468) | (~fragment_unnamed_467)) != 0u)
						{
							float fragment_unnamed_509;
							if (fragment_unnamed_467 == 0u)
							{
								fragment_unnamed_509 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_473, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_478, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
							}
							else
							{
								fragment_unnamed_509 = fragment_unnamed_456;
							}
							float fragment_unnamed_523;
							if (fragment_unnamed_468 == 0u)
							{
								fragment_unnamed_523 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_485, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_489), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
							}
							else
							{
								fragment_unnamed_523 = fragment_unnamed_462;
							}
							float fragment_unnamed_529 = asfloat(fragment_unnamed_465 ? asuint(fragment_unnamed_509) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_509)));
							float fragment_unnamed_535 = asfloat(fragment_unnamed_466 ? asuint(fragment_unnamed_523) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_523)));
							bool fragment_unnamed_538 = abs(fragment_unnamed_529) >= fragment_unnamed_245;
							bool fragment_unnamed_539 = abs(fragment_unnamed_535) >= fragment_unnamed_245;
							uint fragment_unnamed_540 = fragment_unnamed_538 ? 4294967295u : 0u;
							uint fragment_unnamed_541 = fragment_unnamed_539 ? 4294967295u : 0u;
							uint fragment_unnamed_546 = fragment_unnamed_538 ? fragment_unnamed_472 : asuint(mad((-0.0f) - fragment_unnamed_192, 4.0f, fragment_unnamed_473));
							float fragment_unnamed_547 = asfloat(fragment_unnamed_546);
							uint fragment_unnamed_551 = fragment_unnamed_538 ? fragment_unnamed_477 : asuint(mad((-0.0f) - fragment_unnamed_198, 4.0f, fragment_unnamed_478));
							float fragment_unnamed_552 = asfloat(fragment_unnamed_551);
							uint fragment_unnamed_558 = fragment_unnamed_539 ? fragment_unnamed_484 : asuint(mad(fragment_unnamed_192, 4.0f, fragment_unnamed_485));
							float fragment_unnamed_559 = asfloat(fragment_unnamed_558);
							uint fragment_unnamed_563 = fragment_unnamed_539 ? fragment_unnamed_489 : asuint(mad(fragment_unnamed_198, 4.0f, asfloat(fragment_unnamed_489)));
							float fragment_unnamed_492;
							float fragment_unnamed_493;
							float fragment_unnamed_494;
							float fragment_unnamed_495;
							float fragment_unnamed_496;
							uint fragment_unnamed_497;
							if (((~fragment_unnamed_541) | (~fragment_unnamed_540)) != 0u)
							{
								float fragment_unnamed_583;
								if (fragment_unnamed_540 == 0u)
								{
									fragment_unnamed_583 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_547, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_552, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
								}
								else
								{
									fragment_unnamed_583 = fragment_unnamed_529;
								}
								float fragment_unnamed_597;
								if (fragment_unnamed_541 == 0u)
								{
									fragment_unnamed_597 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_559, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_563), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
								}
								else
								{
									fragment_unnamed_597 = fragment_unnamed_535;
								}
								float fragment_unnamed_566 = asfloat(fragment_unnamed_538 ? asuint(fragment_unnamed_583) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_583)));
								float fragment_unnamed_567 = asfloat(fragment_unnamed_539 ? asuint(fragment_unnamed_597) : asuint(mad((-0.0f) - fragment_unnamed_244, 0.5f, fragment_unnamed_597)));
								bool fragment_unnamed_610 = abs(fragment_unnamed_566) >= fragment_unnamed_245;
								bool fragment_unnamed_611 = abs(fragment_unnamed_567) >= fragment_unnamed_245;
								fragment_unnamed_492 = fragment_unnamed_566;
								fragment_unnamed_493 = fragment_unnamed_567;
								fragment_unnamed_494 = asfloat(fragment_unnamed_610 ? fragment_unnamed_546 : asuint(mad((-0.0f) - fragment_unnamed_192, 12.0f, fragment_unnamed_547)));
								fragment_unnamed_495 = asfloat(fragment_unnamed_611 ? fragment_unnamed_558 : asuint(mad(fragment_unnamed_192, 12.0f, fragment_unnamed_559)));
								fragment_unnamed_496 = asfloat(fragment_unnamed_610 ? fragment_unnamed_551 : asuint(mad((-0.0f) - fragment_unnamed_198, 12.0f, fragment_unnamed_552)));
								fragment_unnamed_497 = fragment_unnamed_611 ? fragment_unnamed_563 : asuint(mad(fragment_unnamed_198, 12.0f, asfloat(fragment_unnamed_563)));
							}
							else
							{
								fragment_unnamed_492 = fragment_unnamed_529;
								fragment_unnamed_493 = fragment_unnamed_535;
								fragment_unnamed_494 = fragment_unnamed_547;
								fragment_unnamed_495 = fragment_unnamed_559;
								fragment_unnamed_496 = fragment_unnamed_552;
								fragment_unnamed_497 = fragment_unnamed_563;
							}
							fragment_unnamed_347 = fragment_unnamed_492;
							fragment_unnamed_349 = fragment_unnamed_493;
							fragment_unnamed_351 = fragment_unnamed_494;
							fragment_unnamed_353 = fragment_unnamed_495;
							fragment_unnamed_355 = fragment_unnamed_496;
							fragment_unnamed_357 = fragment_unnamed_497;
						}
						else
						{
							fragment_unnamed_347 = fragment_unnamed_456;
							fragment_unnamed_349 = fragment_unnamed_462;
							fragment_unnamed_351 = fragment_unnamed_473;
							fragment_unnamed_353 = fragment_unnamed_485;
							fragment_unnamed_355 = fragment_unnamed_478;
							fragment_unnamed_357 = fragment_unnamed_489;
						}
						fragment_unnamed_346 = fragment_unnamed_347;
						fragment_unnamed_348 = fragment_unnamed_349;
						fragment_unnamed_350 = fragment_unnamed_351;
						fragment_unnamed_352 = fragment_unnamed_353;
						fragment_unnamed_354 = fragment_unnamed_355;
						fragment_unnamed_356 = fragment_unnamed_357;
					}
					else
					{
						fragment_unnamed_346 = fragment_unnamed_253;
						fragment_unnamed_348 = fragment_unnamed_255;
						fragment_unnamed_350 = fragment_unnamed_268;
						fragment_unnamed_352 = fragment_unnamed_282;
						fragment_unnamed_354 = fragment_unnamed_274;
						fragment_unnamed_356 = fragment_unnamed_286;
					}
					float fragment_unnamed_373 = asfloat(fragment_unnamed_143 ? asuint(((-0.0f) - fragment_unnamed_350) + fragment_input_1.x) : asuint(((-0.0f) - fragment_unnamed_354) + fragment_input_1.y));
					float fragment_unnamed_382 = asfloat(fragment_unnamed_143 ? asuint(fragment_unnamed_352 + ((-0.0f) - fragment_input_1.x)) : asuint(asfloat(fragment_unnamed_356) + ((-0.0f) - fragment_input_1.y)));
					float fragment_unnamed_402 = max(fragment_unnamed_249 * fragment_unnamed_249, asfloat(asuint(mad(min(fragment_unnamed_373, fragment_unnamed_382), (-0.0f) - (1.0f / (fragment_unnamed_373 + fragment_unnamed_382)), 0.5f)) & ((fragment_unnamed_373 < fragment_unnamed_382) ? ((fragment_unnamed_251 != ((fragment_unnamed_346 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_251 != ((fragment_unnamed_348 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					float4 fragment_unnamed_423 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_143 ? fragment_input_1.x : mad(fragment_unnamed_402, fragment_unnamed_183, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_143 ? mad(fragment_unnamed_402, fragment_unnamed_183, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f);
					fragment_unnamed_288 = fragment_unnamed_423.x;
					fragment_unnamed_290 = fragment_unnamed_423.y;
					fragment_unnamed_292 = fragment_unnamed_423.z;
				}
				else
				{
					fragment_unnamed_288 = fragment_unnamed_56.x;
					fragment_unnamed_290 = fragment_unnamed_59;
					fragment_unnamed_292 = fragment_unnamed_56.z;
				}
				float fragment_unnamed_321 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				float fragment_unnamed_333 = (((-0.0f) - sqrt(((-0.0f) - abs(fragment_unnamed_321)) + 1.0f)) + 1.0f) * mad(clamp(mad(fragment_unnamed_321, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_333, 0.0039215688593685626983642578125f, fragment_unnamed_288);
				fragment_output_0.y = mad(fragment_unnamed_333, 0.0039215688593685626983642578125f, fragment_unnamed_290);
				fragment_output_0.z = mad(fragment_unnamed_333, 0.0039215688593685626983642578125f, fragment_unnamed_292);
				fragment_output_0.w = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[29] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA_KEEP_ALPHA) && defined(FXAA_LOW) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA)


			#if defined(FXAA_KEEP_ALPHA) && defined(FXAA_LOW) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;
			float4 _PosScaleOffset;

			static float4 vertex_uniform_buffer_0[29];
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
				gl_Position.x = mad(vertex_input_0.x, vertex_uniform_buffer_0[28u].x, vertex_uniform_buffer_0[28u].z);
				gl_Position.y = mad(vertex_input_0.y, vertex_uniform_buffer_0[28u].y, vertex_uniform_buffer_0[28u].w);
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				float vertex_unnamed_68 = mad((vertex_input_0.x + 1.0f) * vertex_uniform_buffer_0[27u].x, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_70 = mad((vertex_input_0.y + 1.0f) * vertex_uniform_buffer_0[27u].y, 0.5f, vertex_uniform_buffer_0[27u].w);
				vertex_output_1.x = vertex_unnamed_68 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = vertex_unnamed_70 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_68;
				vertex_output_1.y = vertex_unnamed_70;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_uniform_buffer_0[28] = float4(_PosScaleOffset[0], _PosScaleOffset[1], _PosScaleOffset[2], _PosScaleOffset[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[31];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f);
				float fragment_unnamed_57 = fragment_unnamed_54.y;
				float4 fragment_unnamed_62 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, 1));
				float fragment_unnamed_66 = fragment_unnamed_62.y;
				float4 fragment_unnamed_67 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 0));
				float fragment_unnamed_70 = fragment_unnamed_67.y;
				float4 fragment_unnamed_72 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, -1));
				float fragment_unnamed_75 = fragment_unnamed_72.y;
				float4 fragment_unnamed_76 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 0));
				float fragment_unnamed_79 = fragment_unnamed_76.y;
				float fragment_unnamed_86 = max(max(fragment_unnamed_70, max(fragment_unnamed_57, fragment_unnamed_66)), max(fragment_unnamed_75, fragment_unnamed_79));
				float fragment_unnamed_92 = ((-0.0f) - min(min(fragment_unnamed_70, min(fragment_unnamed_57, fragment_unnamed_66)), min(fragment_unnamed_75, fragment_unnamed_79))) + fragment_unnamed_86;
				float fragment_unnamed_286;
				float fragment_unnamed_288;
				float fragment_unnamed_290;
				if (fragment_unnamed_92 >= max(fragment_unnamed_86 * 0.16599999368190765380859375f, 0.0625f))
				{
					float4 fragment_unnamed_98 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, -1));
					float fragment_unnamed_101 = fragment_unnamed_98.y;
					float4 fragment_unnamed_102 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 1));
					float fragment_unnamed_105 = fragment_unnamed_102.y;
					float4 fragment_unnamed_106 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, -1));
					float fragment_unnamed_109 = fragment_unnamed_106.y;
					float4 fragment_unnamed_110 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 1));
					float fragment_unnamed_113 = fragment_unnamed_110.y;
					float fragment_unnamed_114 = fragment_unnamed_66 + fragment_unnamed_75;
					float fragment_unnamed_115 = fragment_unnamed_70 + fragment_unnamed_79;
					float fragment_unnamed_121 = fragment_unnamed_105 + fragment_unnamed_109;
					float fragment_unnamed_125 = fragment_unnamed_113 + fragment_unnamed_101;
					bool fragment_unnamed_141 = (mad(abs(mad(fragment_unnamed_57, -2.0f, fragment_unnamed_114)), 2.0f, abs(mad(fragment_unnamed_70, -2.0f, fragment_unnamed_121))) + abs(mad(fragment_unnamed_79, -2.0f, fragment_unnamed_125))) >= (mad(abs(mad(fragment_unnamed_57, -2.0f, fragment_unnamed_115)), 2.0f, abs(mad(fragment_unnamed_75, -2.0f, fragment_unnamed_101 + fragment_unnamed_109))) + abs(mad(fragment_unnamed_66, -2.0f, fragment_unnamed_105 + fragment_unnamed_113)));
					float fragment_unnamed_148 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_75) : asuint(fragment_unnamed_79));
					float fragment_unnamed_152 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_66) : asuint(fragment_unnamed_70));
					float fragment_unnamed_164 = asfloat(fragment_unnamed_141 ? asuint(fragment_uniform_buffer_0[30u]).y : asuint(fragment_uniform_buffer_0[30u]).x);
					float fragment_unnamed_169 = ((-0.0f) - fragment_unnamed_57) + fragment_unnamed_148;
					float fragment_unnamed_171 = ((-0.0f) - fragment_unnamed_57) + fragment_unnamed_152;
					bool fragment_unnamed_176 = abs(fragment_unnamed_169) >= abs(fragment_unnamed_171);
					float fragment_unnamed_181 = fragment_unnamed_176 ? ((-0.0f) - fragment_unnamed_164) : fragment_unnamed_164;
					float fragment_unnamed_184 = clamp((1.0f / fragment_unnamed_92) * abs(mad(mad(fragment_unnamed_114 + fragment_unnamed_115, 2.0f, fragment_unnamed_121 + fragment_unnamed_125), 0.083333335816860198974609375f, (-0.0f) - fragment_unnamed_57)), 0.0f, 1.0f);
					float fragment_unnamed_190 = asfloat((fragment_unnamed_141 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[30u]).x);
					float fragment_unnamed_196 = asfloat(fragment_unnamed_141 ? 0u : asuint(fragment_uniform_buffer_0[30u]).y);
					float fragment_unnamed_206 = fragment_unnamed_141 ? fragment_input_1.x : mad(fragment_unnamed_181, 0.5f, fragment_input_1.x);
					float fragment_unnamed_209 = fragment_unnamed_141 ? mad(fragment_unnamed_181, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					float fragment_unnamed_212 = ((-0.0f) - fragment_unnamed_190) + fragment_unnamed_206;
					float fragment_unnamed_213 = ((-0.0f) - fragment_unnamed_196) + fragment_unnamed_209;
					float fragment_unnamed_214 = fragment_unnamed_190 + fragment_unnamed_206;
					float fragment_unnamed_215 = fragment_unnamed_196 + fragment_unnamed_209;
					float fragment_unnamed_242 = asfloat(fragment_unnamed_176 ? asuint(fragment_unnamed_57 + fragment_unnamed_148) : asuint(fragment_unnamed_57 + fragment_unnamed_152));
					float fragment_unnamed_243 = max(abs(fragment_unnamed_171), abs(fragment_unnamed_169)) * 0.25f;
					float fragment_unnamed_247 = (fragment_unnamed_184 * fragment_unnamed_184) * mad(fragment_unnamed_184, -2.0f, 3.0f);
					uint fragment_unnamed_249 = (mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_57) < 0.0f) ? 4294967295u : 0u;
					float fragment_unnamed_251 = mad((-0.0f) - fragment_unnamed_242, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_212, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_213, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y);
					float fragment_unnamed_253 = mad((-0.0f) - fragment_unnamed_242, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_214, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_215, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y);
					bool fragment_unnamed_256 = abs(fragment_unnamed_251) >= fragment_unnamed_243;
					bool fragment_unnamed_257 = abs(fragment_unnamed_253) >= fragment_unnamed_243;
					uint fragment_unnamed_258 = fragment_unnamed_256 ? 4294967295u : 0u;
					uint fragment_unnamed_259 = fragment_unnamed_257 ? 4294967295u : 0u;
					uint fragment_unnamed_265 = fragment_unnamed_256 ? asuint(fragment_unnamed_212) : asuint(mad((-0.0f) - fragment_unnamed_190, 1.5f, fragment_unnamed_212));
					float fragment_unnamed_266 = asfloat(fragment_unnamed_265);
					uint fragment_unnamed_271 = fragment_unnamed_256 ? asuint(fragment_unnamed_213) : asuint(mad((-0.0f) - fragment_unnamed_196, 1.5f, fragment_unnamed_213));
					float fragment_unnamed_272 = asfloat(fragment_unnamed_271);
					uint fragment_unnamed_279 = fragment_unnamed_257 ? asuint(fragment_unnamed_214) : asuint(mad(fragment_unnamed_190, 1.5f, fragment_unnamed_214));
					float fragment_unnamed_280 = asfloat(fragment_unnamed_279);
					uint fragment_unnamed_284 = fragment_unnamed_257 ? asuint(fragment_unnamed_215) : asuint(mad(fragment_unnamed_196, 1.5f, fragment_unnamed_215));
					float fragment_unnamed_344;
					float fragment_unnamed_346;
					float fragment_unnamed_348;
					float fragment_unnamed_350;
					float fragment_unnamed_352;
					uint fragment_unnamed_354;
					if (((~fragment_unnamed_259) | (~fragment_unnamed_258)) != 0u)
					{
						float fragment_unnamed_434;
						if (fragment_unnamed_258 == 0u)
						{
							fragment_unnamed_434 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_266, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_272, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
						}
						else
						{
							fragment_unnamed_434 = fragment_unnamed_251;
						}
						float fragment_unnamed_448;
						if (fragment_unnamed_259 == 0u)
						{
							fragment_unnamed_448 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_280, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_284), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
						}
						else
						{
							fragment_unnamed_448 = fragment_unnamed_253;
						}
						float fragment_unnamed_454 = asfloat(fragment_unnamed_256 ? asuint(fragment_unnamed_434) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_434)));
						float fragment_unnamed_460 = asfloat(fragment_unnamed_257 ? asuint(fragment_unnamed_448) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_448)));
						bool fragment_unnamed_463 = abs(fragment_unnamed_454) >= fragment_unnamed_243;
						bool fragment_unnamed_464 = abs(fragment_unnamed_460) >= fragment_unnamed_243;
						uint fragment_unnamed_465 = fragment_unnamed_463 ? 4294967295u : 0u;
						uint fragment_unnamed_466 = fragment_unnamed_464 ? 4294967295u : 0u;
						uint fragment_unnamed_470 = fragment_unnamed_463 ? fragment_unnamed_265 : asuint(mad((-0.0f) - fragment_unnamed_190, 2.0f, fragment_unnamed_266));
						float fragment_unnamed_471 = asfloat(fragment_unnamed_470);
						uint fragment_unnamed_475 = fragment_unnamed_463 ? fragment_unnamed_271 : asuint(mad((-0.0f) - fragment_unnamed_196, 2.0f, fragment_unnamed_272));
						float fragment_unnamed_476 = asfloat(fragment_unnamed_475);
						uint fragment_unnamed_482 = fragment_unnamed_464 ? fragment_unnamed_279 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_280));
						float fragment_unnamed_483 = asfloat(fragment_unnamed_482);
						uint fragment_unnamed_487 = fragment_unnamed_464 ? fragment_unnamed_284 : asuint(mad(fragment_unnamed_196, 2.0f, asfloat(fragment_unnamed_284)));
						float fragment_unnamed_345;
						float fragment_unnamed_347;
						float fragment_unnamed_349;
						float fragment_unnamed_351;
						float fragment_unnamed_353;
						uint fragment_unnamed_355;
						if (((~fragment_unnamed_466) | (~fragment_unnamed_465)) != 0u)
						{
							float fragment_unnamed_507;
							if (fragment_unnamed_465 == 0u)
							{
								fragment_unnamed_507 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_471, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_476, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
							}
							else
							{
								fragment_unnamed_507 = fragment_unnamed_454;
							}
							float fragment_unnamed_521;
							if (fragment_unnamed_466 == 0u)
							{
								fragment_unnamed_521 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_483, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_487), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
							}
							else
							{
								fragment_unnamed_521 = fragment_unnamed_460;
							}
							float fragment_unnamed_527 = asfloat(fragment_unnamed_463 ? asuint(fragment_unnamed_507) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_507)));
							float fragment_unnamed_533 = asfloat(fragment_unnamed_464 ? asuint(fragment_unnamed_521) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_521)));
							bool fragment_unnamed_536 = abs(fragment_unnamed_527) >= fragment_unnamed_243;
							bool fragment_unnamed_537 = abs(fragment_unnamed_533) >= fragment_unnamed_243;
							uint fragment_unnamed_538 = fragment_unnamed_536 ? 4294967295u : 0u;
							uint fragment_unnamed_539 = fragment_unnamed_537 ? 4294967295u : 0u;
							uint fragment_unnamed_544 = fragment_unnamed_536 ? fragment_unnamed_470 : asuint(mad((-0.0f) - fragment_unnamed_190, 4.0f, fragment_unnamed_471));
							float fragment_unnamed_545 = asfloat(fragment_unnamed_544);
							uint fragment_unnamed_549 = fragment_unnamed_536 ? fragment_unnamed_475 : asuint(mad((-0.0f) - fragment_unnamed_196, 4.0f, fragment_unnamed_476));
							float fragment_unnamed_550 = asfloat(fragment_unnamed_549);
							uint fragment_unnamed_556 = fragment_unnamed_537 ? fragment_unnamed_482 : asuint(mad(fragment_unnamed_190, 4.0f, fragment_unnamed_483));
							float fragment_unnamed_557 = asfloat(fragment_unnamed_556);
							uint fragment_unnamed_561 = fragment_unnamed_537 ? fragment_unnamed_487 : asuint(mad(fragment_unnamed_196, 4.0f, asfloat(fragment_unnamed_487)));
							float fragment_unnamed_490;
							float fragment_unnamed_491;
							float fragment_unnamed_492;
							float fragment_unnamed_493;
							float fragment_unnamed_494;
							uint fragment_unnamed_495;
							if (((~fragment_unnamed_539) | (~fragment_unnamed_538)) != 0u)
							{
								float fragment_unnamed_581;
								if (fragment_unnamed_538 == 0u)
								{
									fragment_unnamed_581 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_545, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_550, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
								}
								else
								{
									fragment_unnamed_581 = fragment_unnamed_527;
								}
								float fragment_unnamed_595;
								if (fragment_unnamed_539 == 0u)
								{
									fragment_unnamed_595 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_557, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(asfloat(fragment_unnamed_561), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f).y;
								}
								else
								{
									fragment_unnamed_595 = fragment_unnamed_533;
								}
								float fragment_unnamed_564 = asfloat(fragment_unnamed_536 ? asuint(fragment_unnamed_581) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_581)));
								float fragment_unnamed_565 = asfloat(fragment_unnamed_537 ? asuint(fragment_unnamed_595) : asuint(mad((-0.0f) - fragment_unnamed_242, 0.5f, fragment_unnamed_595)));
								bool fragment_unnamed_608 = abs(fragment_unnamed_564) >= fragment_unnamed_243;
								bool fragment_unnamed_609 = abs(fragment_unnamed_565) >= fragment_unnamed_243;
								fragment_unnamed_490 = fragment_unnamed_564;
								fragment_unnamed_491 = fragment_unnamed_565;
								fragment_unnamed_492 = asfloat(fragment_unnamed_608 ? fragment_unnamed_544 : asuint(mad((-0.0f) - fragment_unnamed_190, 12.0f, fragment_unnamed_545)));
								fragment_unnamed_493 = asfloat(fragment_unnamed_609 ? fragment_unnamed_556 : asuint(mad(fragment_unnamed_190, 12.0f, fragment_unnamed_557)));
								fragment_unnamed_494 = asfloat(fragment_unnamed_608 ? fragment_unnamed_549 : asuint(mad((-0.0f) - fragment_unnamed_196, 12.0f, fragment_unnamed_550)));
								fragment_unnamed_495 = fragment_unnamed_609 ? fragment_unnamed_561 : asuint(mad(fragment_unnamed_196, 12.0f, asfloat(fragment_unnamed_561)));
							}
							else
							{
								fragment_unnamed_490 = fragment_unnamed_527;
								fragment_unnamed_491 = fragment_unnamed_533;
								fragment_unnamed_492 = fragment_unnamed_545;
								fragment_unnamed_493 = fragment_unnamed_557;
								fragment_unnamed_494 = fragment_unnamed_550;
								fragment_unnamed_495 = fragment_unnamed_561;
							}
							fragment_unnamed_345 = fragment_unnamed_490;
							fragment_unnamed_347 = fragment_unnamed_491;
							fragment_unnamed_349 = fragment_unnamed_492;
							fragment_unnamed_351 = fragment_unnamed_493;
							fragment_unnamed_353 = fragment_unnamed_494;
							fragment_unnamed_355 = fragment_unnamed_495;
						}
						else
						{
							fragment_unnamed_345 = fragment_unnamed_454;
							fragment_unnamed_347 = fragment_unnamed_460;
							fragment_unnamed_349 = fragment_unnamed_471;
							fragment_unnamed_351 = fragment_unnamed_483;
							fragment_unnamed_353 = fragment_unnamed_476;
							fragment_unnamed_355 = fragment_unnamed_487;
						}
						fragment_unnamed_344 = fragment_unnamed_345;
						fragment_unnamed_346 = fragment_unnamed_347;
						fragment_unnamed_348 = fragment_unnamed_349;
						fragment_unnamed_350 = fragment_unnamed_351;
						fragment_unnamed_352 = fragment_unnamed_353;
						fragment_unnamed_354 = fragment_unnamed_355;
					}
					else
					{
						fragment_unnamed_344 = fragment_unnamed_251;
						fragment_unnamed_346 = fragment_unnamed_253;
						fragment_unnamed_348 = fragment_unnamed_266;
						fragment_unnamed_350 = fragment_unnamed_280;
						fragment_unnamed_352 = fragment_unnamed_272;
						fragment_unnamed_354 = fragment_unnamed_284;
					}
					float fragment_unnamed_371 = asfloat(fragment_unnamed_141 ? asuint(((-0.0f) - fragment_unnamed_348) + fragment_input_1.x) : asuint(((-0.0f) - fragment_unnamed_352) + fragment_input_1.y));
					float fragment_unnamed_380 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_350 + ((-0.0f) - fragment_input_1.x)) : asuint(asfloat(fragment_unnamed_354) + ((-0.0f) - fragment_input_1.y)));
					float fragment_unnamed_400 = max(fragment_unnamed_247 * fragment_unnamed_247, asfloat(asuint(mad(min(fragment_unnamed_371, fragment_unnamed_380), (-0.0f) - (1.0f / (fragment_unnamed_371 + fragment_unnamed_380)), 0.5f)) & ((fragment_unnamed_371 < fragment_unnamed_380) ? ((fragment_unnamed_249 != ((fragment_unnamed_344 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_249 != ((fragment_unnamed_346 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					float4 fragment_unnamed_421 = _MainTex.SampleLevel(sampler_MainTex, float2(clamp(fragment_unnamed_141 ? fragment_input_1.x : mad(fragment_unnamed_400, fragment_unnamed_181, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x, clamp(fragment_unnamed_141 ? mad(fragment_unnamed_400, fragment_unnamed_181, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x), 0.0f);
					fragment_unnamed_286 = fragment_unnamed_421.x;
					fragment_unnamed_288 = fragment_unnamed_421.y;
					fragment_unnamed_290 = fragment_unnamed_421.z;
				}
				else
				{
					fragment_unnamed_286 = fragment_unnamed_54.x;
					fragment_unnamed_288 = fragment_unnamed_57;
					fragment_unnamed_290 = fragment_unnamed_54.z;
				}
				float fragment_unnamed_319 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[29u].x, fragment_uniform_buffer_0[29u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[29u].y, fragment_uniform_buffer_0[29u].w))).w, 2.0f, -1.0f);
				float fragment_unnamed_331 = (((-0.0f) - sqrt(((-0.0f) - abs(fragment_unnamed_319)) + 1.0f)) + 1.0f) * mad(clamp(mad(fragment_unnamed_319, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_331, 0.0039215688593685626983642578125f, fragment_unnamed_286);
				fragment_output_0.y = mad(fragment_unnamed_331, 0.0039215688593685626983642578125f, fragment_unnamed_288);
				fragment_output_0.z = mad(fragment_unnamed_331, 0.0039215688593685626983642578125f, fragment_unnamed_290);
				fragment_output_0.w = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[29] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[30] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA_KEEP_ALPHA) && defined(FXAA_LOW) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA)


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
			GpuProgramID 91651

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#pragma shader_feature FXAA
			#pragma multi_compile _ FXAA_KEEP_ALPHA
			#pragma shader_feature FXAA_LOW
			#pragma shader_feature STEREO_DOUBLEWIDE_TARGET
			#pragma shader_feature STEREO_INSTANCING_ENABLED


			#if !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
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
				precise float vertex_unnamed_50 = vertex_unnamed_42 * vertex_uniform_buffer_0[27u].x;
				precise float vertex_unnamed_51 = vertex_unnamed_43 * vertex_uniform_buffer_0[27u].y;
				float vertex_unnamed_57 = mad(vertex_unnamed_50, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_59 = mad(vertex_unnamed_51, 0.5f, vertex_uniform_buffer_0[27u].w);
				precise float vertex_unnamed_64 = vertex_unnamed_57 * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_65 = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_64;
				vertex_output_1.y = vertex_unnamed_65;
				vertex_output_1.x = vertex_unnamed_57;
				vertex_output_1.y = vertex_unnamed_59;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4 _Dithering_Coords;

			static float4 fragment_uniform_buffer_0[29];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_59 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				precise float fragment_unnamed_63 = (-0.0f) - abs(fragment_unnamed_59);
				precise float fragment_unnamed_65 = fragment_unnamed_63 + 1.0f;
				precise float fragment_unnamed_73 = (-0.0f) - sqrt(fragment_unnamed_65);
				precise float fragment_unnamed_74 = fragment_unnamed_73 + 1.0f;
				precise float fragment_unnamed_75 = fragment_unnamed_74 * mad(clamp(mad(fragment_unnamed_59, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				float4 fragment_unnamed_81 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				fragment_output_0.x = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.x);
				fragment_output_0.y = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.y);
				fragment_output_0.z = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.z);
				fragment_output_0.w = fragment_unnamed_81.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA) && !defined(FXAA_LOW)


			#if defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float _DepthSlice;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
			static float4 gl_Position;
			static uint gl_Layer;
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
				uint gl_Layer : SV_RenderTargetArrayIndex;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_44 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_45 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_52 = vertex_unnamed_44 * vertex_uniform_buffer_0[27u].x;
				precise float vertex_unnamed_53 = vertex_unnamed_45 * vertex_uniform_buffer_0[27u].y;
				float vertex_unnamed_59 = mad(vertex_unnamed_52, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_61 = mad(vertex_unnamed_53, 0.5f, vertex_uniform_buffer_0[27u].w);
				precise float vertex_unnamed_66 = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_67 = vertex_unnamed_61 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_66;
				vertex_output_1.y = vertex_unnamed_67;
				vertex_output_1.x = vertex_unnamed_59;
				vertex_output_1.y = vertex_unnamed_61;
				gl_Layer = int(uint(vertex_uniform_buffer_0[26u].y));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[26] = float4(vertex_uniform_buffer_0[26][0], _DepthSlice, vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.gl_Layer = gl_Layer;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4 _Dithering_Coords;

			static float4 fragment_uniform_buffer_0[29];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_61 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				precise float fragment_unnamed_65 = (-0.0f) - abs(fragment_unnamed_61);
				precise float fragment_unnamed_67 = fragment_unnamed_65 + 1.0f;
				precise float fragment_unnamed_75 = (-0.0f) - sqrt(fragment_unnamed_67);
				precise float fragment_unnamed_76 = fragment_unnamed_75 + 1.0f;
				precise float fragment_unnamed_77 = fragment_unnamed_76 * mad(clamp(mad(fragment_unnamed_61, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				float4 fragment_unnamed_83 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				fragment_output_0.x = mad(fragment_unnamed_77, 0.0039215688593685626983642578125f, fragment_unnamed_83.x);
				fragment_output_0.y = mad(fragment_unnamed_77, 0.0039215688593685626983642578125f, fragment_unnamed_83.y);
				fragment_output_0.z = mad(fragment_unnamed_77, 0.0039215688593685626983642578125f, fragment_unnamed_83.z);
				fragment_output_0.w = fragment_unnamed_83.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA) && !defined(FXAA_LOW)


			#if defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;
			float4 _PosScaleOffset;

			static float4 vertex_uniform_buffer_0[29];
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
				gl_Position.x = mad(vertex_input_0.x, vertex_uniform_buffer_0[28u].x, vertex_uniform_buffer_0[28u].z);
				gl_Position.y = mad(vertex_input_0.y, vertex_uniform_buffer_0[28u].y, vertex_uniform_buffer_0[28u].w);
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_55 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_56 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_62 = vertex_unnamed_55 * vertex_uniform_buffer_0[27u].x;
				precise float vertex_unnamed_63 = vertex_unnamed_56 * vertex_uniform_buffer_0[27u].y;
				float vertex_unnamed_68 = mad(vertex_unnamed_62, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_70 = mad(vertex_unnamed_63, 0.5f, vertex_uniform_buffer_0[27u].w);
				precise float vertex_unnamed_75 = vertex_unnamed_68 * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_76 = vertex_unnamed_70 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_75;
				vertex_output_1.y = vertex_unnamed_76;
				vertex_output_1.x = vertex_unnamed_68;
				vertex_output_1.y = vertex_unnamed_70;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_uniform_buffer_0[28] = float4(_PosScaleOffset[0], _PosScaleOffset[1], _PosScaleOffset[2], _PosScaleOffset[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4 _Dithering_Coords;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_59 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[29u].x, fragment_uniform_buffer_0[29u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[29u].y, fragment_uniform_buffer_0[29u].w))).w, 2.0f, -1.0f);
				precise float fragment_unnamed_63 = (-0.0f) - abs(fragment_unnamed_59);
				precise float fragment_unnamed_65 = fragment_unnamed_63 + 1.0f;
				precise float fragment_unnamed_73 = (-0.0f) - sqrt(fragment_unnamed_65);
				precise float fragment_unnamed_74 = fragment_unnamed_73 + 1.0f;
				precise float fragment_unnamed_75 = fragment_unnamed_74 * mad(clamp(mad(fragment_unnamed_59, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				float4 fragment_unnamed_81 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				fragment_output_0.x = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.x);
				fragment_output_0.y = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.y);
				fragment_output_0.z = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.z);
				fragment_output_0.w = fragment_unnamed_81.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[29] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA) && !defined(FXAA_LOW)


			#if defined(FXAA_KEEP_ALPHA) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
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
				precise float vertex_unnamed_50 = vertex_unnamed_42 * vertex_uniform_buffer_0[27u].x;
				precise float vertex_unnamed_51 = vertex_unnamed_43 * vertex_uniform_buffer_0[27u].y;
				float vertex_unnamed_57 = mad(vertex_unnamed_50, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_59 = mad(vertex_unnamed_51, 0.5f, vertex_uniform_buffer_0[27u].w);
				precise float vertex_unnamed_64 = vertex_unnamed_57 * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_65 = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_64;
				vertex_output_1.y = vertex_unnamed_65;
				vertex_output_1.x = vertex_unnamed_57;
				vertex_output_1.y = vertex_unnamed_59;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4 _Dithering_Coords;

			static float4 fragment_uniform_buffer_0[29];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_59 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				precise float fragment_unnamed_63 = (-0.0f) - abs(fragment_unnamed_59);
				precise float fragment_unnamed_65 = fragment_unnamed_63 + 1.0f;
				precise float fragment_unnamed_73 = (-0.0f) - sqrt(fragment_unnamed_65);
				precise float fragment_unnamed_74 = fragment_unnamed_73 + 1.0f;
				precise float fragment_unnamed_75 = fragment_unnamed_74 * mad(clamp(mad(fragment_unnamed_59, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				float4 fragment_unnamed_81 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				fragment_output_0.x = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.x);
				fragment_output_0.y = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.y);
				fragment_output_0.z = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.z);
				fragment_output_0.w = fragment_unnamed_81.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA_KEEP_ALPHA) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA) && !defined(FXAA_LOW)


			#if defined(FXAA_KEEP_ALPHA) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float _DepthSlice;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
			static float4 gl_Position;
			static uint gl_Layer;
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
				uint gl_Layer : SV_RenderTargetArrayIndex;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_44 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_45 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_52 = vertex_unnamed_44 * vertex_uniform_buffer_0[27u].x;
				precise float vertex_unnamed_53 = vertex_unnamed_45 * vertex_uniform_buffer_0[27u].y;
				float vertex_unnamed_59 = mad(vertex_unnamed_52, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_61 = mad(vertex_unnamed_53, 0.5f, vertex_uniform_buffer_0[27u].w);
				precise float vertex_unnamed_66 = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_67 = vertex_unnamed_61 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_66;
				vertex_output_1.y = vertex_unnamed_67;
				vertex_output_1.x = vertex_unnamed_59;
				vertex_output_1.y = vertex_unnamed_61;
				gl_Layer = int(uint(vertex_uniform_buffer_0[26u].y));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[26] = float4(vertex_uniform_buffer_0[26][0], _DepthSlice, vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.gl_Layer = gl_Layer;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4 _Dithering_Coords;

			static float4 fragment_uniform_buffer_0[29];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_61 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				precise float fragment_unnamed_65 = (-0.0f) - abs(fragment_unnamed_61);
				precise float fragment_unnamed_67 = fragment_unnamed_65 + 1.0f;
				precise float fragment_unnamed_75 = (-0.0f) - sqrt(fragment_unnamed_67);
				precise float fragment_unnamed_76 = fragment_unnamed_75 + 1.0f;
				precise float fragment_unnamed_77 = fragment_unnamed_76 * mad(clamp(mad(fragment_unnamed_61, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				float4 fragment_unnamed_83 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				fragment_output_0.x = mad(fragment_unnamed_77, 0.0039215688593685626983642578125f, fragment_unnamed_83.x);
				fragment_output_0.y = mad(fragment_unnamed_77, 0.0039215688593685626983642578125f, fragment_unnamed_83.y);
				fragment_output_0.z = mad(fragment_unnamed_77, 0.0039215688593685626983642578125f, fragment_unnamed_83.z);
				fragment_output_0.w = fragment_unnamed_83.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA_KEEP_ALPHA) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA) && !defined(FXAA_LOW)


			#if defined(FXAA_KEEP_ALPHA) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;
			float4 _PosScaleOffset;

			static float4 vertex_uniform_buffer_0[29];
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
				gl_Position.x = mad(vertex_input_0.x, vertex_uniform_buffer_0[28u].x, vertex_uniform_buffer_0[28u].z);
				gl_Position.y = mad(vertex_input_0.y, vertex_uniform_buffer_0[28u].y, vertex_uniform_buffer_0[28u].w);
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_55 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_56 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_62 = vertex_unnamed_55 * vertex_uniform_buffer_0[27u].x;
				precise float vertex_unnamed_63 = vertex_unnamed_56 * vertex_uniform_buffer_0[27u].y;
				float vertex_unnamed_68 = mad(vertex_unnamed_62, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_70 = mad(vertex_unnamed_63, 0.5f, vertex_uniform_buffer_0[27u].w);
				precise float vertex_unnamed_75 = vertex_unnamed_68 * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_76 = vertex_unnamed_70 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_75;
				vertex_output_1.y = vertex_unnamed_76;
				vertex_output_1.x = vertex_unnamed_68;
				vertex_output_1.y = vertex_unnamed_70;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_uniform_buffer_0[28] = float4(_PosScaleOffset[0], _PosScaleOffset[1], _PosScaleOffset[2], _PosScaleOffset[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4 _Dithering_Coords;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				float fragment_unnamed_59 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[29u].x, fragment_uniform_buffer_0[29u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[29u].y, fragment_uniform_buffer_0[29u].w))).w, 2.0f, -1.0f);
				precise float fragment_unnamed_63 = (-0.0f) - abs(fragment_unnamed_59);
				precise float fragment_unnamed_65 = fragment_unnamed_63 + 1.0f;
				precise float fragment_unnamed_73 = (-0.0f) - sqrt(fragment_unnamed_65);
				precise float fragment_unnamed_74 = fragment_unnamed_73 + 1.0f;
				precise float fragment_unnamed_75 = fragment_unnamed_74 * mad(clamp(mad(fragment_unnamed_59, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				float4 fragment_unnamed_81 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				fragment_output_0.x = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.x);
				fragment_output_0.y = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.y);
				fragment_output_0.z = mad(fragment_unnamed_75, 0.0039215688593685626983642578125f, fragment_unnamed_81.z);
				fragment_output_0.w = fragment_unnamed_81.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[29] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA_KEEP_ALPHA) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA) && !defined(FXAA_LOW)


			#if defined(FXAA) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
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
				precise float vertex_unnamed_50 = vertex_unnamed_42 * vertex_uniform_buffer_0[27u].x;
				precise float vertex_unnamed_51 = vertex_unnamed_43 * vertex_uniform_buffer_0[27u].y;
				float vertex_unnamed_57 = mad(vertex_unnamed_50, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_59 = mad(vertex_unnamed_51, 0.5f, vertex_uniform_buffer_0[27u].w);
				precise float vertex_unnamed_64 = vertex_unnamed_57 * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_65 = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_64;
				vertex_output_1.y = vertex_unnamed_65;
				vertex_output_1.x = vertex_unnamed_57;
				vertex_output_1.y = vertex_unnamed_59;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				precise float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f);
				float fragment_unnamed_59 = fragment_unnamed_54.w;
				float4 fragment_unnamed_63 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, 1));
				float fragment_unnamed_67 = fragment_unnamed_63.w;
				float4 fragment_unnamed_68 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 0));
				float fragment_unnamed_71 = fragment_unnamed_68.w;
				float4 fragment_unnamed_73 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, -1));
				float fragment_unnamed_76 = fragment_unnamed_73.w;
				float4 fragment_unnamed_77 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 0));
				float fragment_unnamed_80 = fragment_unnamed_77.w;
				float fragment_unnamed_87 = max(max(max(fragment_unnamed_59, fragment_unnamed_67), fragment_unnamed_71), max(fragment_unnamed_76, fragment_unnamed_80));
				precise float fragment_unnamed_89 = fragment_unnamed_87 * 0.063000001013278961181640625f;
				precise float fragment_unnamed_91 = (-0.0f) - min(min(min(fragment_unnamed_59, fragment_unnamed_67), fragment_unnamed_71), min(fragment_unnamed_76, fragment_unnamed_80));
				precise float fragment_unnamed_93 = fragment_unnamed_91 + fragment_unnamed_87;
				float fragment_unnamed_288;
				float fragment_unnamed_290;
				float fragment_unnamed_292;
				if (fragment_unnamed_93 >= max(fragment_unnamed_89, 0.031199999153614044189453125f))
				{
					float4 fragment_unnamed_99 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, -1));
					float fragment_unnamed_102 = fragment_unnamed_99.w;
					float4 fragment_unnamed_103 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 1));
					float fragment_unnamed_106 = fragment_unnamed_103.w;
					float4 fragment_unnamed_107 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, -1));
					float fragment_unnamed_110 = fragment_unnamed_107.w;
					float4 fragment_unnamed_111 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 1));
					float fragment_unnamed_114 = fragment_unnamed_111.w;
					precise float fragment_unnamed_115 = fragment_unnamed_67 + fragment_unnamed_76;
					precise float fragment_unnamed_116 = fragment_unnamed_71 + fragment_unnamed_80;
					precise float fragment_unnamed_117 = 1.0f / fragment_unnamed_93;
					precise float fragment_unnamed_118 = fragment_unnamed_116 + fragment_unnamed_115;
					precise float fragment_unnamed_122 = fragment_unnamed_106 + fragment_unnamed_110;
					precise float fragment_unnamed_123 = fragment_unnamed_102 + fragment_unnamed_110;
					precise float fragment_unnamed_126 = fragment_unnamed_102 + fragment_unnamed_114;
					precise float fragment_unnamed_127 = fragment_unnamed_106 + fragment_unnamed_114;
					precise float fragment_unnamed_139 = mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_115)), 2.0f, abs(mad(fragment_unnamed_71, -2.0f, fragment_unnamed_122))) + abs(mad(fragment_unnamed_80, -2.0f, fragment_unnamed_126));
					precise float fragment_unnamed_140 = mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_116)), 2.0f, abs(mad(fragment_unnamed_76, -2.0f, fragment_unnamed_123))) + abs(mad(fragment_unnamed_67, -2.0f, fragment_unnamed_127));
					precise float fragment_unnamed_141 = fragment_unnamed_122 + fragment_unnamed_126;
					bool fragment_unnamed_142 = fragment_unnamed_139 >= fragment_unnamed_140;
					float fragment_unnamed_149 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_76) : asuint(fragment_unnamed_80));
					float fragment_unnamed_153 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_67) : asuint(fragment_unnamed_71));
					float fragment_unnamed_165 = asfloat(fragment_unnamed_142 ? asuint(fragment_uniform_buffer_0[29u]).y : asuint(fragment_uniform_buffer_0[29u]).x);
					precise float fragment_unnamed_166 = (-0.0f) - fragment_unnamed_59;
					precise float fragment_unnamed_169 = (-0.0f) - fragment_unnamed_59;
					precise float fragment_unnamed_170 = fragment_unnamed_169 + fragment_unnamed_149;
					precise float fragment_unnamed_171 = (-0.0f) - fragment_unnamed_59;
					precise float fragment_unnamed_172 = fragment_unnamed_171 + fragment_unnamed_153;
					precise float fragment_unnamed_173 = fragment_unnamed_59 + fragment_unnamed_149;
					precise float fragment_unnamed_174 = fragment_unnamed_59 + fragment_unnamed_153;
					bool fragment_unnamed_177 = abs(fragment_unnamed_170) >= abs(fragment_unnamed_172);
					precise float fragment_unnamed_181 = (-0.0f) - fragment_unnamed_165;
					float fragment_unnamed_182 = fragment_unnamed_177 ? fragment_unnamed_181 : fragment_unnamed_165;
					precise float fragment_unnamed_184 = fragment_unnamed_117 * abs(mad(mad(fragment_unnamed_118, 2.0f, fragment_unnamed_141), 0.083333335816860198974609375f, fragment_unnamed_166));
					float fragment_unnamed_185 = clamp(fragment_unnamed_184, 0.0f, 1.0f);
					float fragment_unnamed_191 = asfloat((fragment_unnamed_142 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_197 = asfloat(fragment_unnamed_142 ? 0u : asuint(fragment_uniform_buffer_0[29u]).y);
					float fragment_unnamed_207 = fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_182, 0.5f, fragment_input_1.x);
					float fragment_unnamed_210 = fragment_unnamed_142 ? mad(fragment_unnamed_182, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					precise float fragment_unnamed_211 = (-0.0f) - fragment_unnamed_191;
					precise float fragment_unnamed_212 = fragment_unnamed_211 + fragment_unnamed_207;
					precise float fragment_unnamed_214 = (-0.0f) - fragment_unnamed_197;
					precise float fragment_unnamed_215 = fragment_unnamed_214 + fragment_unnamed_210;
					precise float fragment_unnamed_217 = fragment_unnamed_191 + fragment_unnamed_207;
					precise float fragment_unnamed_218 = fragment_unnamed_197 + fragment_unnamed_210;
					precise float fragment_unnamed_226 = clamp(fragment_unnamed_212, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_227 = clamp(fragment_unnamed_215, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_231 = fragment_unnamed_185 * fragment_unnamed_185;
					precise float fragment_unnamed_237 = clamp(fragment_unnamed_217, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_238 = clamp(fragment_unnamed_218, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float fragment_unnamed_245 = asfloat(fragment_unnamed_177 ? asuint(fragment_unnamed_173) : asuint(fragment_unnamed_174));
					precise float fragment_unnamed_246 = max(abs(fragment_unnamed_172), abs(fragment_unnamed_170)) * 0.25f;
					precise float fragment_unnamed_248 = (-0.0f) - fragment_unnamed_245;
					precise float fragment_unnamed_250 = fragment_unnamed_231 * mad(fragment_unnamed_185, -2.0f, 3.0f);
					uint fragment_unnamed_252 = (mad(fragment_unnamed_248, 0.5f, fragment_unnamed_59) < 0.0f) ? 4294967295u : 0u;
					precise float fragment_unnamed_253 = (-0.0f) - fragment_unnamed_245;
					float fragment_unnamed_254 = mad(fragment_unnamed_253, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_226, fragment_unnamed_227), 0.0f).w);
					precise float fragment_unnamed_255 = (-0.0f) - fragment_unnamed_245;
					float fragment_unnamed_256 = mad(fragment_unnamed_255, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_237, fragment_unnamed_238), 0.0f).w);
					bool fragment_unnamed_259 = abs(fragment_unnamed_254) >= fragment_unnamed_246;
					bool fragment_unnamed_260 = abs(fragment_unnamed_256) >= fragment_unnamed_246;
					uint fragment_unnamed_261 = fragment_unnamed_259 ? 4294967295u : 0u;
					uint fragment_unnamed_262 = fragment_unnamed_260 ? 4294967295u : 0u;
					precise float fragment_unnamed_263 = (-0.0f) - fragment_unnamed_191;
					uint fragment_unnamed_267 = fragment_unnamed_259 ? asuint(fragment_unnamed_212) : asuint(mad(fragment_unnamed_263, 1.5f, fragment_unnamed_212));
					float fragment_unnamed_268 = asfloat(fragment_unnamed_267);
					precise float fragment_unnamed_269 = (-0.0f) - fragment_unnamed_197;
					uint fragment_unnamed_272 = fragment_unnamed_259 ? asuint(fragment_unnamed_215) : asuint(mad(fragment_unnamed_269, 1.5f, fragment_unnamed_215));
					float fragment_unnamed_273 = asfloat(fragment_unnamed_272);
					uint fragment_unnamed_280 = fragment_unnamed_260 ? asuint(fragment_unnamed_217) : asuint(mad(fragment_unnamed_191, 1.5f, fragment_unnamed_217));
					float fragment_unnamed_281 = asfloat(fragment_unnamed_280);
					uint fragment_unnamed_285 = fragment_unnamed_260 ? asuint(fragment_unnamed_218) : asuint(mad(fragment_unnamed_197, 1.5f, fragment_unnamed_218));
					float fragment_unnamed_286 = asfloat(fragment_unnamed_285);
					float fragment_unnamed_338;
					float fragment_unnamed_340;
					float fragment_unnamed_342;
					float fragment_unnamed_344;
					float fragment_unnamed_346;
					float fragment_unnamed_348;
					if (((~fragment_unnamed_262) | (~fragment_unnamed_261)) != 0u)
					{
						float fragment_unnamed_427;
						if (fragment_unnamed_261 == 0u)
						{
							precise float fragment_unnamed_421 = clamp(fragment_unnamed_268, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_422 = clamp(fragment_unnamed_273, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_427 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_421, fragment_unnamed_422), 0.0f).w;
						}
						else
						{
							fragment_unnamed_427 = fragment_unnamed_254;
						}
						float fragment_unnamed_440;
						if (fragment_unnamed_262 == 0u)
						{
							precise float fragment_unnamed_434 = clamp(fragment_unnamed_281, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_435 = clamp(fragment_unnamed_286, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_440 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_434, fragment_unnamed_435), 0.0f).w;
						}
						else
						{
							fragment_unnamed_440 = fragment_unnamed_256;
						}
						precise float fragment_unnamed_441 = (-0.0f) - fragment_unnamed_245;
						uint fragment_unnamed_445 = fragment_unnamed_259 ? asuint(fragment_unnamed_427) : asuint(mad(fragment_unnamed_441, 0.5f, fragment_unnamed_427));
						float fragment_unnamed_446 = asfloat(fragment_unnamed_445);
						precise float fragment_unnamed_447 = (-0.0f) - fragment_unnamed_245;
						float fragment_unnamed_452 = asfloat(fragment_unnamed_260 ? asuint(fragment_unnamed_440) : asuint(mad(fragment_unnamed_447, 0.5f, fragment_unnamed_440)));
						bool fragment_unnamed_455 = abs(fragment_unnamed_446) >= fragment_unnamed_246;
						bool fragment_unnamed_456 = abs(fragment_unnamed_452) >= fragment_unnamed_246;
						uint fragment_unnamed_457 = fragment_unnamed_455 ? 4294967295u : 0u;
						uint fragment_unnamed_458 = fragment_unnamed_456 ? 4294967295u : 0u;
						precise float fragment_unnamed_459 = (-0.0f) - fragment_unnamed_191;
						uint fragment_unnamed_462 = fragment_unnamed_455 ? fragment_unnamed_267 : asuint(mad(fragment_unnamed_459, 2.0f, fragment_unnamed_268));
						float fragment_unnamed_463 = asfloat(fragment_unnamed_462);
						precise float fragment_unnamed_464 = (-0.0f) - fragment_unnamed_197;
						uint fragment_unnamed_467 = fragment_unnamed_455 ? fragment_unnamed_272 : asuint(mad(fragment_unnamed_464, 2.0f, fragment_unnamed_273));
						float fragment_unnamed_468 = asfloat(fragment_unnamed_467);
						uint fragment_unnamed_474 = fragment_unnamed_456 ? fragment_unnamed_280 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_281));
						float fragment_unnamed_475 = asfloat(fragment_unnamed_474);
						uint fragment_unnamed_478 = fragment_unnamed_456 ? fragment_unnamed_285 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_286));
						float fragment_unnamed_479 = asfloat(fragment_unnamed_478);
						float fragment_unnamed_339;
						float fragment_unnamed_341;
						float fragment_unnamed_343;
						float fragment_unnamed_345;
						float fragment_unnamed_347;
						float fragment_unnamed_349;
						if (((~fragment_unnamed_458) | (~fragment_unnamed_457)) != 0u)
						{
							float fragment_unnamed_500;
							if (fragment_unnamed_457 == 0u)
							{
								precise float fragment_unnamed_493 = clamp(fragment_unnamed_463, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_494 = clamp(fragment_unnamed_468, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_500 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_493, fragment_unnamed_494), 0.0f).w;
							}
							else
							{
								fragment_unnamed_500 = asfloat(fragment_unnamed_445);
							}
							float fragment_unnamed_513;
							if (fragment_unnamed_458 == 0u)
							{
								precise float fragment_unnamed_507 = clamp(fragment_unnamed_475, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_508 = clamp(fragment_unnamed_479, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_513 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_507, fragment_unnamed_508), 0.0f).w;
							}
							else
							{
								fragment_unnamed_513 = fragment_unnamed_452;
							}
							precise float fragment_unnamed_514 = (-0.0f) - fragment_unnamed_245;
							uint fragment_unnamed_518 = fragment_unnamed_455 ? asuint(fragment_unnamed_500) : asuint(mad(fragment_unnamed_514, 0.5f, fragment_unnamed_500));
							float fragment_unnamed_519 = asfloat(fragment_unnamed_518);
							precise float fragment_unnamed_520 = (-0.0f) - fragment_unnamed_245;
							float fragment_unnamed_525 = asfloat(fragment_unnamed_456 ? asuint(fragment_unnamed_513) : asuint(mad(fragment_unnamed_520, 0.5f, fragment_unnamed_513)));
							bool fragment_unnamed_528 = abs(fragment_unnamed_519) >= fragment_unnamed_246;
							bool fragment_unnamed_529 = abs(fragment_unnamed_525) >= fragment_unnamed_246;
							uint fragment_unnamed_530 = fragment_unnamed_528 ? 4294967295u : 0u;
							uint fragment_unnamed_531 = fragment_unnamed_529 ? 4294967295u : 0u;
							precise float fragment_unnamed_532 = (-0.0f) - fragment_unnamed_191;
							uint fragment_unnamed_535 = fragment_unnamed_528 ? fragment_unnamed_462 : asuint(mad(fragment_unnamed_532, 2.0f, fragment_unnamed_463));
							float fragment_unnamed_536 = asfloat(fragment_unnamed_535);
							precise float fragment_unnamed_537 = (-0.0f) - fragment_unnamed_197;
							uint fragment_unnamed_540 = fragment_unnamed_528 ? fragment_unnamed_467 : asuint(mad(fragment_unnamed_537, 2.0f, fragment_unnamed_468));
							float fragment_unnamed_541 = asfloat(fragment_unnamed_540);
							uint fragment_unnamed_547 = fragment_unnamed_529 ? fragment_unnamed_474 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_475));
							float fragment_unnamed_548 = asfloat(fragment_unnamed_547);
							uint fragment_unnamed_551 = fragment_unnamed_529 ? fragment_unnamed_478 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_479));
							float fragment_unnamed_552 = asfloat(fragment_unnamed_551);
							float fragment_unnamed_482;
							float fragment_unnamed_483;
							float fragment_unnamed_484;
							float fragment_unnamed_485;
							float fragment_unnamed_486;
							float fragment_unnamed_487;
							if (((~fragment_unnamed_531) | (~fragment_unnamed_530)) != 0u)
							{
								float fragment_unnamed_573;
								if (fragment_unnamed_530 == 0u)
								{
									precise float fragment_unnamed_566 = clamp(fragment_unnamed_536, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_567 = clamp(fragment_unnamed_541, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_573 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_566, fragment_unnamed_567), 0.0f).w;
								}
								else
								{
									fragment_unnamed_573 = asfloat(fragment_unnamed_518);
								}
								float fragment_unnamed_586;
								if (fragment_unnamed_531 == 0u)
								{
									precise float fragment_unnamed_580 = clamp(fragment_unnamed_548, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_581 = clamp(fragment_unnamed_552, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_586 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_580, fragment_unnamed_581), 0.0f).w;
								}
								else
								{
									fragment_unnamed_586 = fragment_unnamed_525;
								}
								precise float fragment_unnamed_587 = (-0.0f) - fragment_unnamed_245;
								uint fragment_unnamed_591 = fragment_unnamed_528 ? asuint(fragment_unnamed_573) : asuint(mad(fragment_unnamed_587, 0.5f, fragment_unnamed_573));
								float fragment_unnamed_592 = asfloat(fragment_unnamed_591);
								precise float fragment_unnamed_593 = (-0.0f) - fragment_unnamed_245;
								float fragment_unnamed_598 = asfloat(fragment_unnamed_529 ? asuint(fragment_unnamed_586) : asuint(mad(fragment_unnamed_593, 0.5f, fragment_unnamed_586)));
								bool fragment_unnamed_601 = abs(fragment_unnamed_592) >= fragment_unnamed_246;
								bool fragment_unnamed_602 = abs(fragment_unnamed_598) >= fragment_unnamed_246;
								uint fragment_unnamed_603 = fragment_unnamed_601 ? 4294967295u : 0u;
								uint fragment_unnamed_604 = fragment_unnamed_602 ? 4294967295u : 0u;
								precise float fragment_unnamed_605 = (-0.0f) - fragment_unnamed_191;
								uint fragment_unnamed_608 = fragment_unnamed_601 ? fragment_unnamed_535 : asuint(mad(fragment_unnamed_605, 2.0f, fragment_unnamed_536));
								float fragment_unnamed_609 = asfloat(fragment_unnamed_608);
								precise float fragment_unnamed_610 = (-0.0f) - fragment_unnamed_197;
								uint fragment_unnamed_613 = fragment_unnamed_601 ? fragment_unnamed_540 : asuint(mad(fragment_unnamed_610, 2.0f, fragment_unnamed_541));
								float fragment_unnamed_614 = asfloat(fragment_unnamed_613);
								uint fragment_unnamed_620 = fragment_unnamed_602 ? fragment_unnamed_547 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_548));
								float fragment_unnamed_621 = asfloat(fragment_unnamed_620);
								uint fragment_unnamed_624 = fragment_unnamed_602 ? fragment_unnamed_551 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_552));
								float fragment_unnamed_625 = asfloat(fragment_unnamed_624);
								float fragment_unnamed_555;
								float fragment_unnamed_556;
								float fragment_unnamed_557;
								float fragment_unnamed_558;
								float fragment_unnamed_559;
								float fragment_unnamed_560;
								if (((~fragment_unnamed_604) | (~fragment_unnamed_603)) != 0u)
								{
									float fragment_unnamed_646;
									if (fragment_unnamed_603 == 0u)
									{
										precise float fragment_unnamed_639 = clamp(fragment_unnamed_609, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										precise float fragment_unnamed_640 = clamp(fragment_unnamed_614, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										fragment_unnamed_646 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_639, fragment_unnamed_640), 0.0f).w;
									}
									else
									{
										fragment_unnamed_646 = asfloat(fragment_unnamed_591);
									}
									float fragment_unnamed_659;
									if (fragment_unnamed_604 == 0u)
									{
										precise float fragment_unnamed_653 = clamp(fragment_unnamed_621, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										precise float fragment_unnamed_654 = clamp(fragment_unnamed_625, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										fragment_unnamed_659 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_653, fragment_unnamed_654), 0.0f).w;
									}
									else
									{
										fragment_unnamed_659 = fragment_unnamed_598;
									}
									precise float fragment_unnamed_660 = (-0.0f) - fragment_unnamed_245;
									uint fragment_unnamed_664 = fragment_unnamed_601 ? asuint(fragment_unnamed_646) : asuint(mad(fragment_unnamed_660, 0.5f, fragment_unnamed_646));
									float fragment_unnamed_665 = asfloat(fragment_unnamed_664);
									precise float fragment_unnamed_666 = (-0.0f) - fragment_unnamed_245;
									float fragment_unnamed_671 = asfloat(fragment_unnamed_602 ? asuint(fragment_unnamed_659) : asuint(mad(fragment_unnamed_666, 0.5f, fragment_unnamed_659)));
									bool fragment_unnamed_674 = abs(fragment_unnamed_665) >= fragment_unnamed_246;
									bool fragment_unnamed_675 = abs(fragment_unnamed_671) >= fragment_unnamed_246;
									uint fragment_unnamed_676 = fragment_unnamed_674 ? 4294967295u : 0u;
									uint fragment_unnamed_677 = fragment_unnamed_675 ? 4294967295u : 0u;
									precise float fragment_unnamed_678 = (-0.0f) - fragment_unnamed_191;
									uint fragment_unnamed_681 = fragment_unnamed_674 ? fragment_unnamed_608 : asuint(mad(fragment_unnamed_678, 2.0f, fragment_unnamed_609));
									float fragment_unnamed_682 = asfloat(fragment_unnamed_681);
									precise float fragment_unnamed_683 = (-0.0f) - fragment_unnamed_197;
									uint fragment_unnamed_686 = fragment_unnamed_674 ? fragment_unnamed_613 : asuint(mad(fragment_unnamed_683, 2.0f, fragment_unnamed_614));
									float fragment_unnamed_687 = asfloat(fragment_unnamed_686);
									uint fragment_unnamed_693 = fragment_unnamed_675 ? fragment_unnamed_620 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_621));
									float fragment_unnamed_694 = asfloat(fragment_unnamed_693);
									uint fragment_unnamed_697 = fragment_unnamed_675 ? fragment_unnamed_624 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_625));
									float fragment_unnamed_698 = asfloat(fragment_unnamed_697);
									float fragment_unnamed_628;
									float fragment_unnamed_629;
									float fragment_unnamed_630;
									float fragment_unnamed_631;
									float fragment_unnamed_632;
									float fragment_unnamed_633;
									if (((~fragment_unnamed_677) | (~fragment_unnamed_676)) != 0u)
									{
										float fragment_unnamed_719;
										if (fragment_unnamed_676 == 0u)
										{
											precise float fragment_unnamed_712 = clamp(fragment_unnamed_682, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											precise float fragment_unnamed_713 = clamp(fragment_unnamed_687, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											fragment_unnamed_719 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_712, fragment_unnamed_713), 0.0f).w;
										}
										else
										{
											fragment_unnamed_719 = asfloat(fragment_unnamed_664);
										}
										float fragment_unnamed_732;
										if (fragment_unnamed_677 == 0u)
										{
											precise float fragment_unnamed_726 = clamp(fragment_unnamed_694, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											precise float fragment_unnamed_727 = clamp(fragment_unnamed_698, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											fragment_unnamed_732 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_726, fragment_unnamed_727), 0.0f).w;
										}
										else
										{
											fragment_unnamed_732 = fragment_unnamed_671;
										}
										precise float fragment_unnamed_733 = (-0.0f) - fragment_unnamed_245;
										uint fragment_unnamed_737 = fragment_unnamed_674 ? asuint(fragment_unnamed_719) : asuint(mad(fragment_unnamed_733, 0.5f, fragment_unnamed_719));
										float fragment_unnamed_738 = asfloat(fragment_unnamed_737);
										precise float fragment_unnamed_739 = (-0.0f) - fragment_unnamed_245;
										float fragment_unnamed_744 = asfloat(fragment_unnamed_675 ? asuint(fragment_unnamed_732) : asuint(mad(fragment_unnamed_739, 0.5f, fragment_unnamed_732)));
										bool fragment_unnamed_747 = abs(fragment_unnamed_738) >= fragment_unnamed_246;
										bool fragment_unnamed_748 = abs(fragment_unnamed_744) >= fragment_unnamed_246;
										uint fragment_unnamed_749 = fragment_unnamed_747 ? 4294967295u : 0u;
										uint fragment_unnamed_750 = fragment_unnamed_748 ? 4294967295u : 0u;
										precise float fragment_unnamed_751 = (-0.0f) - fragment_unnamed_191;
										uint fragment_unnamed_754 = fragment_unnamed_747 ? fragment_unnamed_681 : asuint(mad(fragment_unnamed_751, 2.0f, fragment_unnamed_682));
										float fragment_unnamed_755 = asfloat(fragment_unnamed_754);
										precise float fragment_unnamed_756 = (-0.0f) - fragment_unnamed_197;
										uint fragment_unnamed_759 = fragment_unnamed_747 ? fragment_unnamed_686 : asuint(mad(fragment_unnamed_756, 2.0f, fragment_unnamed_687));
										float fragment_unnamed_760 = asfloat(fragment_unnamed_759);
										uint fragment_unnamed_766 = fragment_unnamed_748 ? fragment_unnamed_693 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_694));
										float fragment_unnamed_767 = asfloat(fragment_unnamed_766);
										uint fragment_unnamed_770 = fragment_unnamed_748 ? fragment_unnamed_697 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_698));
										float fragment_unnamed_771 = asfloat(fragment_unnamed_770);
										float fragment_unnamed_701;
										float fragment_unnamed_702;
										float fragment_unnamed_703;
										float fragment_unnamed_704;
										float fragment_unnamed_705;
										float fragment_unnamed_706;
										if (((~fragment_unnamed_750) | (~fragment_unnamed_749)) != 0u)
										{
											float fragment_unnamed_792;
											if (fragment_unnamed_749 == 0u)
											{
												precise float fragment_unnamed_785 = clamp(fragment_unnamed_755, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												precise float fragment_unnamed_786 = clamp(fragment_unnamed_760, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												fragment_unnamed_792 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_785, fragment_unnamed_786), 0.0f).w;
											}
											else
											{
												fragment_unnamed_792 = asfloat(fragment_unnamed_737);
											}
											float fragment_unnamed_805;
											if (fragment_unnamed_750 == 0u)
											{
												precise float fragment_unnamed_799 = clamp(fragment_unnamed_767, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												precise float fragment_unnamed_800 = clamp(fragment_unnamed_771, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												fragment_unnamed_805 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_799, fragment_unnamed_800), 0.0f).w;
											}
											else
											{
												fragment_unnamed_805 = fragment_unnamed_744;
											}
											precise float fragment_unnamed_806 = (-0.0f) - fragment_unnamed_245;
											uint fragment_unnamed_810 = fragment_unnamed_747 ? asuint(fragment_unnamed_792) : asuint(mad(fragment_unnamed_806, 0.5f, fragment_unnamed_792));
											float fragment_unnamed_811 = asfloat(fragment_unnamed_810);
											precise float fragment_unnamed_812 = (-0.0f) - fragment_unnamed_245;
											float fragment_unnamed_817 = asfloat(fragment_unnamed_748 ? asuint(fragment_unnamed_805) : asuint(mad(fragment_unnamed_812, 0.5f, fragment_unnamed_805)));
											bool fragment_unnamed_820 = abs(fragment_unnamed_811) >= fragment_unnamed_246;
											bool fragment_unnamed_821 = abs(fragment_unnamed_817) >= fragment_unnamed_246;
											uint fragment_unnamed_822 = fragment_unnamed_820 ? 4294967295u : 0u;
											uint fragment_unnamed_823 = fragment_unnamed_821 ? 4294967295u : 0u;
											precise float fragment_unnamed_824 = (-0.0f) - fragment_unnamed_191;
											uint fragment_unnamed_827 = fragment_unnamed_820 ? fragment_unnamed_754 : asuint(mad(fragment_unnamed_824, 2.0f, fragment_unnamed_755));
											float fragment_unnamed_828 = asfloat(fragment_unnamed_827);
											precise float fragment_unnamed_829 = (-0.0f) - fragment_unnamed_197;
											uint fragment_unnamed_832 = fragment_unnamed_820 ? fragment_unnamed_759 : asuint(mad(fragment_unnamed_829, 2.0f, fragment_unnamed_760));
											float fragment_unnamed_833 = asfloat(fragment_unnamed_832);
											uint fragment_unnamed_839 = fragment_unnamed_821 ? fragment_unnamed_766 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_767));
											float fragment_unnamed_840 = asfloat(fragment_unnamed_839);
											uint fragment_unnamed_843 = fragment_unnamed_821 ? fragment_unnamed_770 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_771));
											float fragment_unnamed_844 = asfloat(fragment_unnamed_843);
											float fragment_unnamed_774;
											float fragment_unnamed_775;
											float fragment_unnamed_776;
											float fragment_unnamed_777;
											float fragment_unnamed_778;
											float fragment_unnamed_779;
											if (((~fragment_unnamed_823) | (~fragment_unnamed_822)) != 0u)
											{
												float fragment_unnamed_865;
												if (fragment_unnamed_822 == 0u)
												{
													precise float fragment_unnamed_858 = clamp(fragment_unnamed_828, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													precise float fragment_unnamed_859 = clamp(fragment_unnamed_833, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													fragment_unnamed_865 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_858, fragment_unnamed_859), 0.0f).w;
												}
												else
												{
													fragment_unnamed_865 = asfloat(fragment_unnamed_810);
												}
												float fragment_unnamed_878;
												if (fragment_unnamed_823 == 0u)
												{
													precise float fragment_unnamed_872 = clamp(fragment_unnamed_840, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													precise float fragment_unnamed_873 = clamp(fragment_unnamed_844, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													fragment_unnamed_878 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_872, fragment_unnamed_873), 0.0f).w;
												}
												else
												{
													fragment_unnamed_878 = fragment_unnamed_817;
												}
												precise float fragment_unnamed_879 = (-0.0f) - fragment_unnamed_245;
												uint fragment_unnamed_883 = fragment_unnamed_820 ? asuint(fragment_unnamed_865) : asuint(mad(fragment_unnamed_879, 0.5f, fragment_unnamed_865));
												float fragment_unnamed_884 = asfloat(fragment_unnamed_883);
												precise float fragment_unnamed_885 = (-0.0f) - fragment_unnamed_245;
												float fragment_unnamed_890 = asfloat(fragment_unnamed_821 ? asuint(fragment_unnamed_878) : asuint(mad(fragment_unnamed_885, 0.5f, fragment_unnamed_878)));
												bool fragment_unnamed_893 = abs(fragment_unnamed_884) >= fragment_unnamed_246;
												bool fragment_unnamed_894 = abs(fragment_unnamed_890) >= fragment_unnamed_246;
												uint fragment_unnamed_895 = fragment_unnamed_893 ? 4294967295u : 0u;
												uint fragment_unnamed_896 = fragment_unnamed_894 ? 4294967295u : 0u;
												precise float fragment_unnamed_897 = (-0.0f) - fragment_unnamed_191;
												uint fragment_unnamed_900 = fragment_unnamed_893 ? fragment_unnamed_827 : asuint(mad(fragment_unnamed_897, 2.0f, fragment_unnamed_828));
												float fragment_unnamed_901 = asfloat(fragment_unnamed_900);
												precise float fragment_unnamed_902 = (-0.0f) - fragment_unnamed_197;
												uint fragment_unnamed_905 = fragment_unnamed_893 ? fragment_unnamed_832 : asuint(mad(fragment_unnamed_902, 2.0f, fragment_unnamed_833));
												float fragment_unnamed_906 = asfloat(fragment_unnamed_905);
												uint fragment_unnamed_912 = fragment_unnamed_894 ? fragment_unnamed_839 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_840));
												float fragment_unnamed_913 = asfloat(fragment_unnamed_912);
												uint fragment_unnamed_916 = fragment_unnamed_894 ? fragment_unnamed_843 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_844));
												float fragment_unnamed_917 = asfloat(fragment_unnamed_916);
												float fragment_unnamed_847;
												float fragment_unnamed_848;
												float fragment_unnamed_849;
												float fragment_unnamed_850;
												float fragment_unnamed_851;
												float fragment_unnamed_852;
												if (((~fragment_unnamed_896) | (~fragment_unnamed_895)) != 0u)
												{
													float fragment_unnamed_938;
													if (fragment_unnamed_895 == 0u)
													{
														precise float fragment_unnamed_931 = clamp(fragment_unnamed_901, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														precise float fragment_unnamed_932 = clamp(fragment_unnamed_906, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														fragment_unnamed_938 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_931, fragment_unnamed_932), 0.0f).w;
													}
													else
													{
														fragment_unnamed_938 = asfloat(fragment_unnamed_883);
													}
													float fragment_unnamed_951;
													if (fragment_unnamed_896 == 0u)
													{
														precise float fragment_unnamed_945 = clamp(fragment_unnamed_913, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														precise float fragment_unnamed_946 = clamp(fragment_unnamed_917, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														fragment_unnamed_951 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_945, fragment_unnamed_946), 0.0f).w;
													}
													else
													{
														fragment_unnamed_951 = fragment_unnamed_890;
													}
													precise float fragment_unnamed_952 = (-0.0f) - fragment_unnamed_245;
													uint fragment_unnamed_956 = fragment_unnamed_893 ? asuint(fragment_unnamed_938) : asuint(mad(fragment_unnamed_952, 0.5f, fragment_unnamed_938));
													float fragment_unnamed_957 = asfloat(fragment_unnamed_956);
													precise float fragment_unnamed_958 = (-0.0f) - fragment_unnamed_245;
													float fragment_unnamed_963 = asfloat(fragment_unnamed_894 ? asuint(fragment_unnamed_951) : asuint(mad(fragment_unnamed_958, 0.5f, fragment_unnamed_951)));
													bool fragment_unnamed_966 = abs(fragment_unnamed_957) >= fragment_unnamed_246;
													bool fragment_unnamed_967 = abs(fragment_unnamed_963) >= fragment_unnamed_246;
													uint fragment_unnamed_968 = fragment_unnamed_966 ? 4294967295u : 0u;
													uint fragment_unnamed_969 = fragment_unnamed_967 ? 4294967295u : 0u;
													precise float fragment_unnamed_970 = (-0.0f) - fragment_unnamed_191;
													uint fragment_unnamed_974 = fragment_unnamed_966 ? fragment_unnamed_900 : asuint(mad(fragment_unnamed_970, 4.0f, fragment_unnamed_901));
													float fragment_unnamed_975 = asfloat(fragment_unnamed_974);
													precise float fragment_unnamed_976 = (-0.0f) - fragment_unnamed_197;
													uint fragment_unnamed_979 = fragment_unnamed_966 ? fragment_unnamed_905 : asuint(mad(fragment_unnamed_976, 4.0f, fragment_unnamed_906));
													float fragment_unnamed_980 = asfloat(fragment_unnamed_979);
													uint fragment_unnamed_986 = fragment_unnamed_967 ? fragment_unnamed_912 : asuint(mad(fragment_unnamed_191, 4.0f, fragment_unnamed_913));
													float fragment_unnamed_987 = asfloat(fragment_unnamed_986);
													uint fragment_unnamed_990 = fragment_unnamed_967 ? fragment_unnamed_916 : asuint(mad(fragment_unnamed_197, 4.0f, fragment_unnamed_917));
													float fragment_unnamed_991 = asfloat(fragment_unnamed_990);
													float fragment_unnamed_920;
													float fragment_unnamed_921;
													float fragment_unnamed_922;
													float fragment_unnamed_923;
													float fragment_unnamed_924;
													float fragment_unnamed_925;
													if (((~fragment_unnamed_969) | (~fragment_unnamed_968)) != 0u)
													{
														float fragment_unnamed_1012;
														if (fragment_unnamed_968 == 0u)
														{
															precise float fragment_unnamed_1005 = clamp(fragment_unnamed_975, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															precise float fragment_unnamed_1006 = clamp(fragment_unnamed_980, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															fragment_unnamed_1012 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_1005, fragment_unnamed_1006), 0.0f).w;
														}
														else
														{
															fragment_unnamed_1012 = asfloat(fragment_unnamed_956);
														}
														float fragment_unnamed_1025;
														if (fragment_unnamed_969 == 0u)
														{
															precise float fragment_unnamed_1019 = clamp(fragment_unnamed_987, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															precise float fragment_unnamed_1020 = clamp(fragment_unnamed_991, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															fragment_unnamed_1025 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_1019, fragment_unnamed_1020), 0.0f).w;
														}
														else
														{
															fragment_unnamed_1025 = fragment_unnamed_963;
														}
														precise float fragment_unnamed_1026 = (-0.0f) - fragment_unnamed_245;
														float fragment_unnamed_994 = asfloat(fragment_unnamed_966 ? asuint(fragment_unnamed_1012) : asuint(mad(fragment_unnamed_1026, 0.5f, fragment_unnamed_1012)));
														precise float fragment_unnamed_1031 = (-0.0f) - fragment_unnamed_245;
														float fragment_unnamed_999 = asfloat(fragment_unnamed_967 ? asuint(fragment_unnamed_1025) : asuint(mad(fragment_unnamed_1031, 0.5f, fragment_unnamed_1025)));
														bool fragment_unnamed_1038 = abs(fragment_unnamed_994) >= fragment_unnamed_246;
														bool fragment_unnamed_1039 = abs(fragment_unnamed_999) >= fragment_unnamed_246;
														precise float fragment_unnamed_1040 = (-0.0f) - fragment_unnamed_191;
														precise float fragment_unnamed_1045 = (-0.0f) - fragment_unnamed_197;
														fragment_unnamed_920 = fragment_unnamed_994;
														fragment_unnamed_921 = asfloat(fragment_unnamed_1038 ? fragment_unnamed_974 : asuint(mad(fragment_unnamed_1040, 8.0f, fragment_unnamed_975)));
														fragment_unnamed_922 = asfloat(fragment_unnamed_1038 ? fragment_unnamed_979 : asuint(mad(fragment_unnamed_1045, 8.0f, fragment_unnamed_980)));
														fragment_unnamed_923 = asfloat(fragment_unnamed_1039 ? fragment_unnamed_986 : asuint(mad(fragment_unnamed_191, 8.0f, fragment_unnamed_987)));
														fragment_unnamed_924 = asfloat(fragment_unnamed_1039 ? fragment_unnamed_990 : asuint(mad(fragment_unnamed_197, 8.0f, fragment_unnamed_991)));
														fragment_unnamed_925 = fragment_unnamed_999;
													}
													else
													{
														fragment_unnamed_920 = fragment_unnamed_957;
														fragment_unnamed_921 = fragment_unnamed_975;
														fragment_unnamed_922 = fragment_unnamed_980;
														fragment_unnamed_923 = fragment_unnamed_987;
														fragment_unnamed_924 = fragment_unnamed_991;
														fragment_unnamed_925 = fragment_unnamed_963;
													}
													fragment_unnamed_847 = fragment_unnamed_920;
													fragment_unnamed_848 = fragment_unnamed_921;
													fragment_unnamed_849 = fragment_unnamed_922;
													fragment_unnamed_850 = fragment_unnamed_923;
													fragment_unnamed_851 = fragment_unnamed_924;
													fragment_unnamed_852 = fragment_unnamed_925;
												}
												else
												{
													fragment_unnamed_847 = fragment_unnamed_884;
													fragment_unnamed_848 = fragment_unnamed_901;
													fragment_unnamed_849 = fragment_unnamed_906;
													fragment_unnamed_850 = fragment_unnamed_913;
													fragment_unnamed_851 = fragment_unnamed_917;
													fragment_unnamed_852 = fragment_unnamed_890;
												}
												fragment_unnamed_774 = fragment_unnamed_847;
												fragment_unnamed_775 = fragment_unnamed_848;
												fragment_unnamed_776 = fragment_unnamed_849;
												fragment_unnamed_777 = fragment_unnamed_850;
												fragment_unnamed_778 = fragment_unnamed_851;
												fragment_unnamed_779 = fragment_unnamed_852;
											}
											else
											{
												fragment_unnamed_774 = fragment_unnamed_811;
												fragment_unnamed_775 = fragment_unnamed_828;
												fragment_unnamed_776 = fragment_unnamed_833;
												fragment_unnamed_777 = fragment_unnamed_840;
												fragment_unnamed_778 = fragment_unnamed_844;
												fragment_unnamed_779 = fragment_unnamed_817;
											}
											fragment_unnamed_701 = fragment_unnamed_774;
											fragment_unnamed_702 = fragment_unnamed_775;
											fragment_unnamed_703 = fragment_unnamed_776;
											fragment_unnamed_704 = fragment_unnamed_777;
											fragment_unnamed_705 = fragment_unnamed_778;
											fragment_unnamed_706 = fragment_unnamed_779;
										}
										else
										{
											fragment_unnamed_701 = fragment_unnamed_738;
											fragment_unnamed_702 = fragment_unnamed_755;
											fragment_unnamed_703 = fragment_unnamed_760;
											fragment_unnamed_704 = fragment_unnamed_767;
											fragment_unnamed_705 = fragment_unnamed_771;
											fragment_unnamed_706 = fragment_unnamed_744;
										}
										fragment_unnamed_628 = fragment_unnamed_701;
										fragment_unnamed_629 = fragment_unnamed_702;
										fragment_unnamed_630 = fragment_unnamed_703;
										fragment_unnamed_631 = fragment_unnamed_704;
										fragment_unnamed_632 = fragment_unnamed_705;
										fragment_unnamed_633 = fragment_unnamed_706;
									}
									else
									{
										fragment_unnamed_628 = fragment_unnamed_665;
										fragment_unnamed_629 = fragment_unnamed_682;
										fragment_unnamed_630 = fragment_unnamed_687;
										fragment_unnamed_631 = fragment_unnamed_694;
										fragment_unnamed_632 = fragment_unnamed_698;
										fragment_unnamed_633 = fragment_unnamed_671;
									}
									fragment_unnamed_555 = fragment_unnamed_628;
									fragment_unnamed_556 = fragment_unnamed_629;
									fragment_unnamed_557 = fragment_unnamed_630;
									fragment_unnamed_558 = fragment_unnamed_631;
									fragment_unnamed_559 = fragment_unnamed_632;
									fragment_unnamed_560 = fragment_unnamed_633;
								}
								else
								{
									fragment_unnamed_555 = fragment_unnamed_592;
									fragment_unnamed_556 = fragment_unnamed_609;
									fragment_unnamed_557 = fragment_unnamed_614;
									fragment_unnamed_558 = fragment_unnamed_621;
									fragment_unnamed_559 = fragment_unnamed_625;
									fragment_unnamed_560 = fragment_unnamed_598;
								}
								fragment_unnamed_482 = fragment_unnamed_555;
								fragment_unnamed_483 = fragment_unnamed_556;
								fragment_unnamed_484 = fragment_unnamed_557;
								fragment_unnamed_485 = fragment_unnamed_558;
								fragment_unnamed_486 = fragment_unnamed_559;
								fragment_unnamed_487 = fragment_unnamed_560;
							}
							else
							{
								fragment_unnamed_482 = fragment_unnamed_519;
								fragment_unnamed_483 = fragment_unnamed_536;
								fragment_unnamed_484 = fragment_unnamed_541;
								fragment_unnamed_485 = fragment_unnamed_548;
								fragment_unnamed_486 = fragment_unnamed_552;
								fragment_unnamed_487 = fragment_unnamed_525;
							}
							fragment_unnamed_339 = fragment_unnamed_482;
							fragment_unnamed_341 = fragment_unnamed_483;
							fragment_unnamed_343 = fragment_unnamed_484;
							fragment_unnamed_345 = fragment_unnamed_485;
							fragment_unnamed_347 = fragment_unnamed_486;
							fragment_unnamed_349 = fragment_unnamed_487;
						}
						else
						{
							fragment_unnamed_339 = fragment_unnamed_446;
							fragment_unnamed_341 = fragment_unnamed_463;
							fragment_unnamed_343 = fragment_unnamed_468;
							fragment_unnamed_345 = fragment_unnamed_475;
							fragment_unnamed_347 = fragment_unnamed_479;
							fragment_unnamed_349 = fragment_unnamed_452;
						}
						fragment_unnamed_338 = fragment_unnamed_339;
						fragment_unnamed_340 = fragment_unnamed_341;
						fragment_unnamed_342 = fragment_unnamed_343;
						fragment_unnamed_344 = fragment_unnamed_345;
						fragment_unnamed_346 = fragment_unnamed_347;
						fragment_unnamed_348 = fragment_unnamed_349;
					}
					else
					{
						fragment_unnamed_338 = fragment_unnamed_254;
						fragment_unnamed_340 = fragment_unnamed_268;
						fragment_unnamed_342 = fragment_unnamed_273;
						fragment_unnamed_344 = fragment_unnamed_281;
						fragment_unnamed_346 = fragment_unnamed_286;
						fragment_unnamed_348 = fragment_unnamed_256;
					}
					precise float fragment_unnamed_350 = (-0.0f) - fragment_unnamed_340;
					precise float fragment_unnamed_353 = fragment_unnamed_350 + fragment_input_1.x;
					precise float fragment_unnamed_356 = (-0.0f) - fragment_input_1.x;
					precise float fragment_unnamed_357 = fragment_unnamed_344 + fragment_unnamed_356;
					precise float fragment_unnamed_358 = (-0.0f) - fragment_unnamed_342;
					precise float fragment_unnamed_361 = fragment_unnamed_358 + fragment_input_1.y;
					float fragment_unnamed_365 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_353) : asuint(fragment_unnamed_361));
					precise float fragment_unnamed_368 = (-0.0f) - fragment_input_1.y;
					precise float fragment_unnamed_369 = fragment_unnamed_346 + fragment_unnamed_368;
					float fragment_unnamed_373 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_357) : asuint(fragment_unnamed_369));
					precise float fragment_unnamed_378 = fragment_unnamed_365 + fragment_unnamed_373;
					precise float fragment_unnamed_383 = 1.0f / fragment_unnamed_378;
					precise float fragment_unnamed_387 = fragment_unnamed_250 * fragment_unnamed_250;
					precise float fragment_unnamed_388 = (-0.0f) - fragment_unnamed_383;
					float fragment_unnamed_393 = max(fragment_unnamed_387, asfloat(asuint(mad(min(fragment_unnamed_373, fragment_unnamed_365), fragment_unnamed_388, 0.5f)) & ((fragment_unnamed_365 < fragment_unnamed_373) ? ((fragment_unnamed_252 != ((fragment_unnamed_338 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_252 != ((fragment_unnamed_348 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					precise float fragment_unnamed_411 = clamp(fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_393, fragment_unnamed_182, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_412 = clamp(fragment_unnamed_142 ? mad(fragment_unnamed_393, fragment_unnamed_182, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float4 fragment_unnamed_414 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_411, fragment_unnamed_412), 0.0f);
					fragment_unnamed_288 = fragment_unnamed_414.z;
					fragment_unnamed_290 = fragment_unnamed_414.y;
					fragment_unnamed_292 = fragment_unnamed_414.x;
				}
				else
				{
					fragment_unnamed_288 = fragment_unnamed_54.z;
					fragment_unnamed_290 = fragment_unnamed_54.y;
					fragment_unnamed_292 = fragment_unnamed_54.x;
				}
				float fragment_unnamed_313 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				precise float fragment_unnamed_320 = (-0.0f) - abs(fragment_unnamed_313);
				precise float fragment_unnamed_321 = fragment_unnamed_320 + 1.0f;
				precise float fragment_unnamed_323 = (-0.0f) - sqrt(fragment_unnamed_321);
				precise float fragment_unnamed_324 = fragment_unnamed_323 + 1.0f;
				precise float fragment_unnamed_325 = fragment_unnamed_324 * mad(clamp(mad(fragment_unnamed_313, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_292);
				fragment_output_0.y = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_290);
				fragment_output_0.z = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_288);
				fragment_output_0.w = fragment_unnamed_59;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[29] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA_LOW)


			#if defined(FXAA) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float _DepthSlice;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
			static float4 gl_Position;
			static uint gl_Layer;
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
				uint gl_Layer : SV_RenderTargetArrayIndex;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_44 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_45 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_52 = vertex_unnamed_44 * vertex_uniform_buffer_0[27u].x;
				precise float vertex_unnamed_53 = vertex_unnamed_45 * vertex_uniform_buffer_0[27u].y;
				float vertex_unnamed_59 = mad(vertex_unnamed_52, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_61 = mad(vertex_unnamed_53, 0.5f, vertex_uniform_buffer_0[27u].w);
				precise float vertex_unnamed_66 = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_67 = vertex_unnamed_61 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_66;
				vertex_output_1.y = vertex_unnamed_67;
				vertex_output_1.x = vertex_unnamed_59;
				vertex_output_1.y = vertex_unnamed_61;
				gl_Layer = int(uint(vertex_uniform_buffer_0[26u].y));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[26] = float4(vertex_uniform_buffer_0[26][0], _DepthSlice, vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.gl_Layer = gl_Layer;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				precise float fragment_unnamed_52 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_53 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_56 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f);
				float fragment_unnamed_61 = fragment_unnamed_56.w;
				float4 fragment_unnamed_65 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(0, 1));
				float fragment_unnamed_69 = fragment_unnamed_65.w;
				float4 fragment_unnamed_70 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, 0));
				float fragment_unnamed_73 = fragment_unnamed_70.w;
				float4 fragment_unnamed_75 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(0, -1));
				float fragment_unnamed_78 = fragment_unnamed_75.w;
				float4 fragment_unnamed_79 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, 0));
				float fragment_unnamed_82 = fragment_unnamed_79.w;
				float fragment_unnamed_89 = max(max(max(fragment_unnamed_61, fragment_unnamed_69), fragment_unnamed_73), max(fragment_unnamed_78, fragment_unnamed_82));
				precise float fragment_unnamed_91 = fragment_unnamed_89 * 0.063000001013278961181640625f;
				precise float fragment_unnamed_93 = (-0.0f) - min(min(min(fragment_unnamed_61, fragment_unnamed_69), fragment_unnamed_73), min(fragment_unnamed_78, fragment_unnamed_82));
				precise float fragment_unnamed_95 = fragment_unnamed_93 + fragment_unnamed_89;
				float fragment_unnamed_290;
				float fragment_unnamed_292;
				float fragment_unnamed_294;
				if (fragment_unnamed_95 >= max(fragment_unnamed_91, 0.031199999153614044189453125f))
				{
					float4 fragment_unnamed_101 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, -1));
					float fragment_unnamed_104 = fragment_unnamed_101.w;
					float4 fragment_unnamed_105 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, 1));
					float fragment_unnamed_108 = fragment_unnamed_105.w;
					float4 fragment_unnamed_109 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, -1));
					float fragment_unnamed_112 = fragment_unnamed_109.w;
					float4 fragment_unnamed_113 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, 1));
					float fragment_unnamed_116 = fragment_unnamed_113.w;
					precise float fragment_unnamed_117 = fragment_unnamed_69 + fragment_unnamed_78;
					precise float fragment_unnamed_118 = fragment_unnamed_73 + fragment_unnamed_82;
					precise float fragment_unnamed_119 = 1.0f / fragment_unnamed_95;
					precise float fragment_unnamed_120 = fragment_unnamed_118 + fragment_unnamed_117;
					precise float fragment_unnamed_124 = fragment_unnamed_108 + fragment_unnamed_112;
					precise float fragment_unnamed_125 = fragment_unnamed_104 + fragment_unnamed_112;
					precise float fragment_unnamed_128 = fragment_unnamed_104 + fragment_unnamed_116;
					precise float fragment_unnamed_129 = fragment_unnamed_108 + fragment_unnamed_116;
					precise float fragment_unnamed_141 = mad(abs(mad(fragment_unnamed_61, -2.0f, fragment_unnamed_117)), 2.0f, abs(mad(fragment_unnamed_73, -2.0f, fragment_unnamed_124))) + abs(mad(fragment_unnamed_82, -2.0f, fragment_unnamed_128));
					precise float fragment_unnamed_142 = mad(abs(mad(fragment_unnamed_61, -2.0f, fragment_unnamed_118)), 2.0f, abs(mad(fragment_unnamed_78, -2.0f, fragment_unnamed_125))) + abs(mad(fragment_unnamed_69, -2.0f, fragment_unnamed_129));
					precise float fragment_unnamed_143 = fragment_unnamed_124 + fragment_unnamed_128;
					bool fragment_unnamed_144 = fragment_unnamed_141 >= fragment_unnamed_142;
					float fragment_unnamed_151 = asfloat(fragment_unnamed_144 ? asuint(fragment_unnamed_78) : asuint(fragment_unnamed_82));
					float fragment_unnamed_155 = asfloat(fragment_unnamed_144 ? asuint(fragment_unnamed_69) : asuint(fragment_unnamed_73));
					float fragment_unnamed_167 = asfloat(fragment_unnamed_144 ? asuint(fragment_uniform_buffer_0[29u]).y : asuint(fragment_uniform_buffer_0[29u]).x);
					precise float fragment_unnamed_168 = (-0.0f) - fragment_unnamed_61;
					precise float fragment_unnamed_171 = (-0.0f) - fragment_unnamed_61;
					precise float fragment_unnamed_172 = fragment_unnamed_171 + fragment_unnamed_151;
					precise float fragment_unnamed_173 = (-0.0f) - fragment_unnamed_61;
					precise float fragment_unnamed_174 = fragment_unnamed_173 + fragment_unnamed_155;
					precise float fragment_unnamed_175 = fragment_unnamed_61 + fragment_unnamed_151;
					precise float fragment_unnamed_176 = fragment_unnamed_61 + fragment_unnamed_155;
					bool fragment_unnamed_179 = abs(fragment_unnamed_172) >= abs(fragment_unnamed_174);
					precise float fragment_unnamed_183 = (-0.0f) - fragment_unnamed_167;
					float fragment_unnamed_184 = fragment_unnamed_179 ? fragment_unnamed_183 : fragment_unnamed_167;
					precise float fragment_unnamed_186 = fragment_unnamed_119 * abs(mad(mad(fragment_unnamed_120, 2.0f, fragment_unnamed_143), 0.083333335816860198974609375f, fragment_unnamed_168));
					float fragment_unnamed_187 = clamp(fragment_unnamed_186, 0.0f, 1.0f);
					float fragment_unnamed_193 = asfloat((fragment_unnamed_144 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_199 = asfloat(fragment_unnamed_144 ? 0u : asuint(fragment_uniform_buffer_0[29u]).y);
					float fragment_unnamed_209 = fragment_unnamed_144 ? fragment_input_1.x : mad(fragment_unnamed_184, 0.5f, fragment_input_1.x);
					float fragment_unnamed_212 = fragment_unnamed_144 ? mad(fragment_unnamed_184, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					precise float fragment_unnamed_213 = (-0.0f) - fragment_unnamed_193;
					precise float fragment_unnamed_214 = fragment_unnamed_213 + fragment_unnamed_209;
					precise float fragment_unnamed_216 = (-0.0f) - fragment_unnamed_199;
					precise float fragment_unnamed_217 = fragment_unnamed_216 + fragment_unnamed_212;
					precise float fragment_unnamed_219 = fragment_unnamed_193 + fragment_unnamed_209;
					precise float fragment_unnamed_220 = fragment_unnamed_199 + fragment_unnamed_212;
					precise float fragment_unnamed_228 = clamp(fragment_unnamed_214, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_229 = clamp(fragment_unnamed_217, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_233 = fragment_unnamed_187 * fragment_unnamed_187;
					precise float fragment_unnamed_239 = clamp(fragment_unnamed_219, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_240 = clamp(fragment_unnamed_220, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float fragment_unnamed_247 = asfloat(fragment_unnamed_179 ? asuint(fragment_unnamed_175) : asuint(fragment_unnamed_176));
					precise float fragment_unnamed_248 = max(abs(fragment_unnamed_174), abs(fragment_unnamed_172)) * 0.25f;
					precise float fragment_unnamed_250 = (-0.0f) - fragment_unnamed_247;
					precise float fragment_unnamed_252 = fragment_unnamed_233 * mad(fragment_unnamed_187, -2.0f, 3.0f);
					uint fragment_unnamed_254 = (mad(fragment_unnamed_250, 0.5f, fragment_unnamed_61) < 0.0f) ? 4294967295u : 0u;
					precise float fragment_unnamed_255 = (-0.0f) - fragment_unnamed_247;
					float fragment_unnamed_256 = mad(fragment_unnamed_255, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_228, fragment_unnamed_229), 0.0f).w);
					precise float fragment_unnamed_257 = (-0.0f) - fragment_unnamed_247;
					float fragment_unnamed_258 = mad(fragment_unnamed_257, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_239, fragment_unnamed_240), 0.0f).w);
					bool fragment_unnamed_261 = abs(fragment_unnamed_256) >= fragment_unnamed_248;
					bool fragment_unnamed_262 = abs(fragment_unnamed_258) >= fragment_unnamed_248;
					uint fragment_unnamed_263 = fragment_unnamed_261 ? 4294967295u : 0u;
					uint fragment_unnamed_264 = fragment_unnamed_262 ? 4294967295u : 0u;
					precise float fragment_unnamed_265 = (-0.0f) - fragment_unnamed_193;
					uint fragment_unnamed_269 = fragment_unnamed_261 ? asuint(fragment_unnamed_214) : asuint(mad(fragment_unnamed_265, 1.5f, fragment_unnamed_214));
					float fragment_unnamed_270 = asfloat(fragment_unnamed_269);
					precise float fragment_unnamed_271 = (-0.0f) - fragment_unnamed_199;
					uint fragment_unnamed_274 = fragment_unnamed_261 ? asuint(fragment_unnamed_217) : asuint(mad(fragment_unnamed_271, 1.5f, fragment_unnamed_217));
					float fragment_unnamed_275 = asfloat(fragment_unnamed_274);
					uint fragment_unnamed_282 = fragment_unnamed_262 ? asuint(fragment_unnamed_219) : asuint(mad(fragment_unnamed_193, 1.5f, fragment_unnamed_219));
					float fragment_unnamed_283 = asfloat(fragment_unnamed_282);
					uint fragment_unnamed_287 = fragment_unnamed_262 ? asuint(fragment_unnamed_220) : asuint(mad(fragment_unnamed_199, 1.5f, fragment_unnamed_220));
					float fragment_unnamed_288 = asfloat(fragment_unnamed_287);
					float fragment_unnamed_340;
					float fragment_unnamed_342;
					float fragment_unnamed_344;
					float fragment_unnamed_346;
					float fragment_unnamed_348;
					float fragment_unnamed_350;
					if (((~fragment_unnamed_264) | (~fragment_unnamed_263)) != 0u)
					{
						float fragment_unnamed_429;
						if (fragment_unnamed_263 == 0u)
						{
							precise float fragment_unnamed_423 = clamp(fragment_unnamed_270, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_424 = clamp(fragment_unnamed_275, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_429 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_423, fragment_unnamed_424), 0.0f).w;
						}
						else
						{
							fragment_unnamed_429 = fragment_unnamed_256;
						}
						float fragment_unnamed_442;
						if (fragment_unnamed_264 == 0u)
						{
							precise float fragment_unnamed_436 = clamp(fragment_unnamed_283, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_437 = clamp(fragment_unnamed_288, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_442 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_436, fragment_unnamed_437), 0.0f).w;
						}
						else
						{
							fragment_unnamed_442 = fragment_unnamed_258;
						}
						precise float fragment_unnamed_443 = (-0.0f) - fragment_unnamed_247;
						uint fragment_unnamed_447 = fragment_unnamed_261 ? asuint(fragment_unnamed_429) : asuint(mad(fragment_unnamed_443, 0.5f, fragment_unnamed_429));
						float fragment_unnamed_448 = asfloat(fragment_unnamed_447);
						precise float fragment_unnamed_449 = (-0.0f) - fragment_unnamed_247;
						float fragment_unnamed_454 = asfloat(fragment_unnamed_262 ? asuint(fragment_unnamed_442) : asuint(mad(fragment_unnamed_449, 0.5f, fragment_unnamed_442)));
						bool fragment_unnamed_457 = abs(fragment_unnamed_448) >= fragment_unnamed_248;
						bool fragment_unnamed_458 = abs(fragment_unnamed_454) >= fragment_unnamed_248;
						uint fragment_unnamed_459 = fragment_unnamed_457 ? 4294967295u : 0u;
						uint fragment_unnamed_460 = fragment_unnamed_458 ? 4294967295u : 0u;
						precise float fragment_unnamed_461 = (-0.0f) - fragment_unnamed_193;
						uint fragment_unnamed_464 = fragment_unnamed_457 ? fragment_unnamed_269 : asuint(mad(fragment_unnamed_461, 2.0f, fragment_unnamed_270));
						float fragment_unnamed_465 = asfloat(fragment_unnamed_464);
						precise float fragment_unnamed_466 = (-0.0f) - fragment_unnamed_199;
						uint fragment_unnamed_469 = fragment_unnamed_457 ? fragment_unnamed_274 : asuint(mad(fragment_unnamed_466, 2.0f, fragment_unnamed_275));
						float fragment_unnamed_470 = asfloat(fragment_unnamed_469);
						uint fragment_unnamed_476 = fragment_unnamed_458 ? fragment_unnamed_282 : asuint(mad(fragment_unnamed_193, 2.0f, fragment_unnamed_283));
						float fragment_unnamed_477 = asfloat(fragment_unnamed_476);
						uint fragment_unnamed_480 = fragment_unnamed_458 ? fragment_unnamed_287 : asuint(mad(fragment_unnamed_199, 2.0f, fragment_unnamed_288));
						float fragment_unnamed_481 = asfloat(fragment_unnamed_480);
						float fragment_unnamed_341;
						float fragment_unnamed_343;
						float fragment_unnamed_345;
						float fragment_unnamed_347;
						float fragment_unnamed_349;
						float fragment_unnamed_351;
						if (((~fragment_unnamed_460) | (~fragment_unnamed_459)) != 0u)
						{
							float fragment_unnamed_502;
							if (fragment_unnamed_459 == 0u)
							{
								precise float fragment_unnamed_495 = clamp(fragment_unnamed_465, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_496 = clamp(fragment_unnamed_470, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_502 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_495, fragment_unnamed_496), 0.0f).w;
							}
							else
							{
								fragment_unnamed_502 = asfloat(fragment_unnamed_447);
							}
							float fragment_unnamed_515;
							if (fragment_unnamed_460 == 0u)
							{
								precise float fragment_unnamed_509 = clamp(fragment_unnamed_477, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_510 = clamp(fragment_unnamed_481, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_515 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_509, fragment_unnamed_510), 0.0f).w;
							}
							else
							{
								fragment_unnamed_515 = fragment_unnamed_454;
							}
							precise float fragment_unnamed_516 = (-0.0f) - fragment_unnamed_247;
							uint fragment_unnamed_520 = fragment_unnamed_457 ? asuint(fragment_unnamed_502) : asuint(mad(fragment_unnamed_516, 0.5f, fragment_unnamed_502));
							float fragment_unnamed_521 = asfloat(fragment_unnamed_520);
							precise float fragment_unnamed_522 = (-0.0f) - fragment_unnamed_247;
							float fragment_unnamed_527 = asfloat(fragment_unnamed_458 ? asuint(fragment_unnamed_515) : asuint(mad(fragment_unnamed_522, 0.5f, fragment_unnamed_515)));
							bool fragment_unnamed_530 = abs(fragment_unnamed_521) >= fragment_unnamed_248;
							bool fragment_unnamed_531 = abs(fragment_unnamed_527) >= fragment_unnamed_248;
							uint fragment_unnamed_532 = fragment_unnamed_530 ? 4294967295u : 0u;
							uint fragment_unnamed_533 = fragment_unnamed_531 ? 4294967295u : 0u;
							precise float fragment_unnamed_534 = (-0.0f) - fragment_unnamed_193;
							uint fragment_unnamed_537 = fragment_unnamed_530 ? fragment_unnamed_464 : asuint(mad(fragment_unnamed_534, 2.0f, fragment_unnamed_465));
							float fragment_unnamed_538 = asfloat(fragment_unnamed_537);
							precise float fragment_unnamed_539 = (-0.0f) - fragment_unnamed_199;
							uint fragment_unnamed_542 = fragment_unnamed_530 ? fragment_unnamed_469 : asuint(mad(fragment_unnamed_539, 2.0f, fragment_unnamed_470));
							float fragment_unnamed_543 = asfloat(fragment_unnamed_542);
							uint fragment_unnamed_549 = fragment_unnamed_531 ? fragment_unnamed_476 : asuint(mad(fragment_unnamed_193, 2.0f, fragment_unnamed_477));
							float fragment_unnamed_550 = asfloat(fragment_unnamed_549);
							uint fragment_unnamed_553 = fragment_unnamed_531 ? fragment_unnamed_480 : asuint(mad(fragment_unnamed_199, 2.0f, fragment_unnamed_481));
							float fragment_unnamed_554 = asfloat(fragment_unnamed_553);
							float fragment_unnamed_484;
							float fragment_unnamed_485;
							float fragment_unnamed_486;
							float fragment_unnamed_487;
							float fragment_unnamed_488;
							float fragment_unnamed_489;
							if (((~fragment_unnamed_533) | (~fragment_unnamed_532)) != 0u)
							{
								float fragment_unnamed_575;
								if (fragment_unnamed_532 == 0u)
								{
									precise float fragment_unnamed_568 = clamp(fragment_unnamed_538, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_569 = clamp(fragment_unnamed_543, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_575 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_568, fragment_unnamed_569), 0.0f).w;
								}
								else
								{
									fragment_unnamed_575 = asfloat(fragment_unnamed_520);
								}
								float fragment_unnamed_588;
								if (fragment_unnamed_533 == 0u)
								{
									precise float fragment_unnamed_582 = clamp(fragment_unnamed_550, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_583 = clamp(fragment_unnamed_554, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_588 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_582, fragment_unnamed_583), 0.0f).w;
								}
								else
								{
									fragment_unnamed_588 = fragment_unnamed_527;
								}
								precise float fragment_unnamed_589 = (-0.0f) - fragment_unnamed_247;
								uint fragment_unnamed_593 = fragment_unnamed_530 ? asuint(fragment_unnamed_575) : asuint(mad(fragment_unnamed_589, 0.5f, fragment_unnamed_575));
								float fragment_unnamed_594 = asfloat(fragment_unnamed_593);
								precise float fragment_unnamed_595 = (-0.0f) - fragment_unnamed_247;
								float fragment_unnamed_600 = asfloat(fragment_unnamed_531 ? asuint(fragment_unnamed_588) : asuint(mad(fragment_unnamed_595, 0.5f, fragment_unnamed_588)));
								bool fragment_unnamed_603 = abs(fragment_unnamed_594) >= fragment_unnamed_248;
								bool fragment_unnamed_604 = abs(fragment_unnamed_600) >= fragment_unnamed_248;
								uint fragment_unnamed_605 = fragment_unnamed_603 ? 4294967295u : 0u;
								uint fragment_unnamed_606 = fragment_unnamed_604 ? 4294967295u : 0u;
								precise float fragment_unnamed_607 = (-0.0f) - fragment_unnamed_193;
								uint fragment_unnamed_610 = fragment_unnamed_603 ? fragment_unnamed_537 : asuint(mad(fragment_unnamed_607, 2.0f, fragment_unnamed_538));
								float fragment_unnamed_611 = asfloat(fragment_unnamed_610);
								precise float fragment_unnamed_612 = (-0.0f) - fragment_unnamed_199;
								uint fragment_unnamed_615 = fragment_unnamed_603 ? fragment_unnamed_542 : asuint(mad(fragment_unnamed_612, 2.0f, fragment_unnamed_543));
								float fragment_unnamed_616 = asfloat(fragment_unnamed_615);
								uint fragment_unnamed_622 = fragment_unnamed_604 ? fragment_unnamed_549 : asuint(mad(fragment_unnamed_193, 2.0f, fragment_unnamed_550));
								float fragment_unnamed_623 = asfloat(fragment_unnamed_622);
								uint fragment_unnamed_626 = fragment_unnamed_604 ? fragment_unnamed_553 : asuint(mad(fragment_unnamed_199, 2.0f, fragment_unnamed_554));
								float fragment_unnamed_627 = asfloat(fragment_unnamed_626);
								float fragment_unnamed_557;
								float fragment_unnamed_558;
								float fragment_unnamed_559;
								float fragment_unnamed_560;
								float fragment_unnamed_561;
								float fragment_unnamed_562;
								if (((~fragment_unnamed_606) | (~fragment_unnamed_605)) != 0u)
								{
									float fragment_unnamed_648;
									if (fragment_unnamed_605 == 0u)
									{
										precise float fragment_unnamed_641 = clamp(fragment_unnamed_611, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										precise float fragment_unnamed_642 = clamp(fragment_unnamed_616, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										fragment_unnamed_648 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_641, fragment_unnamed_642), 0.0f).w;
									}
									else
									{
										fragment_unnamed_648 = asfloat(fragment_unnamed_593);
									}
									float fragment_unnamed_661;
									if (fragment_unnamed_606 == 0u)
									{
										precise float fragment_unnamed_655 = clamp(fragment_unnamed_623, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										precise float fragment_unnamed_656 = clamp(fragment_unnamed_627, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										fragment_unnamed_661 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_655, fragment_unnamed_656), 0.0f).w;
									}
									else
									{
										fragment_unnamed_661 = fragment_unnamed_600;
									}
									precise float fragment_unnamed_662 = (-0.0f) - fragment_unnamed_247;
									uint fragment_unnamed_666 = fragment_unnamed_603 ? asuint(fragment_unnamed_648) : asuint(mad(fragment_unnamed_662, 0.5f, fragment_unnamed_648));
									float fragment_unnamed_667 = asfloat(fragment_unnamed_666);
									precise float fragment_unnamed_668 = (-0.0f) - fragment_unnamed_247;
									float fragment_unnamed_673 = asfloat(fragment_unnamed_604 ? asuint(fragment_unnamed_661) : asuint(mad(fragment_unnamed_668, 0.5f, fragment_unnamed_661)));
									bool fragment_unnamed_676 = abs(fragment_unnamed_667) >= fragment_unnamed_248;
									bool fragment_unnamed_677 = abs(fragment_unnamed_673) >= fragment_unnamed_248;
									uint fragment_unnamed_678 = fragment_unnamed_676 ? 4294967295u : 0u;
									uint fragment_unnamed_679 = fragment_unnamed_677 ? 4294967295u : 0u;
									precise float fragment_unnamed_680 = (-0.0f) - fragment_unnamed_193;
									uint fragment_unnamed_683 = fragment_unnamed_676 ? fragment_unnamed_610 : asuint(mad(fragment_unnamed_680, 2.0f, fragment_unnamed_611));
									float fragment_unnamed_684 = asfloat(fragment_unnamed_683);
									precise float fragment_unnamed_685 = (-0.0f) - fragment_unnamed_199;
									uint fragment_unnamed_688 = fragment_unnamed_676 ? fragment_unnamed_615 : asuint(mad(fragment_unnamed_685, 2.0f, fragment_unnamed_616));
									float fragment_unnamed_689 = asfloat(fragment_unnamed_688);
									uint fragment_unnamed_695 = fragment_unnamed_677 ? fragment_unnamed_622 : asuint(mad(fragment_unnamed_193, 2.0f, fragment_unnamed_623));
									float fragment_unnamed_696 = asfloat(fragment_unnamed_695);
									uint fragment_unnamed_699 = fragment_unnamed_677 ? fragment_unnamed_626 : asuint(mad(fragment_unnamed_199, 2.0f, fragment_unnamed_627));
									float fragment_unnamed_700 = asfloat(fragment_unnamed_699);
									float fragment_unnamed_630;
									float fragment_unnamed_631;
									float fragment_unnamed_632;
									float fragment_unnamed_633;
									float fragment_unnamed_634;
									float fragment_unnamed_635;
									if (((~fragment_unnamed_679) | (~fragment_unnamed_678)) != 0u)
									{
										float fragment_unnamed_721;
										if (fragment_unnamed_678 == 0u)
										{
											precise float fragment_unnamed_714 = clamp(fragment_unnamed_684, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											precise float fragment_unnamed_715 = clamp(fragment_unnamed_689, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											fragment_unnamed_721 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_714, fragment_unnamed_715), 0.0f).w;
										}
										else
										{
											fragment_unnamed_721 = asfloat(fragment_unnamed_666);
										}
										float fragment_unnamed_734;
										if (fragment_unnamed_679 == 0u)
										{
											precise float fragment_unnamed_728 = clamp(fragment_unnamed_696, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											precise float fragment_unnamed_729 = clamp(fragment_unnamed_700, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											fragment_unnamed_734 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_728, fragment_unnamed_729), 0.0f).w;
										}
										else
										{
											fragment_unnamed_734 = fragment_unnamed_673;
										}
										precise float fragment_unnamed_735 = (-0.0f) - fragment_unnamed_247;
										uint fragment_unnamed_739 = fragment_unnamed_676 ? asuint(fragment_unnamed_721) : asuint(mad(fragment_unnamed_735, 0.5f, fragment_unnamed_721));
										float fragment_unnamed_740 = asfloat(fragment_unnamed_739);
										precise float fragment_unnamed_741 = (-0.0f) - fragment_unnamed_247;
										float fragment_unnamed_746 = asfloat(fragment_unnamed_677 ? asuint(fragment_unnamed_734) : asuint(mad(fragment_unnamed_741, 0.5f, fragment_unnamed_734)));
										bool fragment_unnamed_749 = abs(fragment_unnamed_740) >= fragment_unnamed_248;
										bool fragment_unnamed_750 = abs(fragment_unnamed_746) >= fragment_unnamed_248;
										uint fragment_unnamed_751 = fragment_unnamed_749 ? 4294967295u : 0u;
										uint fragment_unnamed_752 = fragment_unnamed_750 ? 4294967295u : 0u;
										precise float fragment_unnamed_753 = (-0.0f) - fragment_unnamed_193;
										uint fragment_unnamed_756 = fragment_unnamed_749 ? fragment_unnamed_683 : asuint(mad(fragment_unnamed_753, 2.0f, fragment_unnamed_684));
										float fragment_unnamed_757 = asfloat(fragment_unnamed_756);
										precise float fragment_unnamed_758 = (-0.0f) - fragment_unnamed_199;
										uint fragment_unnamed_761 = fragment_unnamed_749 ? fragment_unnamed_688 : asuint(mad(fragment_unnamed_758, 2.0f, fragment_unnamed_689));
										float fragment_unnamed_762 = asfloat(fragment_unnamed_761);
										uint fragment_unnamed_768 = fragment_unnamed_750 ? fragment_unnamed_695 : asuint(mad(fragment_unnamed_193, 2.0f, fragment_unnamed_696));
										float fragment_unnamed_769 = asfloat(fragment_unnamed_768);
										uint fragment_unnamed_772 = fragment_unnamed_750 ? fragment_unnamed_699 : asuint(mad(fragment_unnamed_199, 2.0f, fragment_unnamed_700));
										float fragment_unnamed_773 = asfloat(fragment_unnamed_772);
										float fragment_unnamed_703;
										float fragment_unnamed_704;
										float fragment_unnamed_705;
										float fragment_unnamed_706;
										float fragment_unnamed_707;
										float fragment_unnamed_708;
										if (((~fragment_unnamed_752) | (~fragment_unnamed_751)) != 0u)
										{
											float fragment_unnamed_794;
											if (fragment_unnamed_751 == 0u)
											{
												precise float fragment_unnamed_787 = clamp(fragment_unnamed_757, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												precise float fragment_unnamed_788 = clamp(fragment_unnamed_762, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												fragment_unnamed_794 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_787, fragment_unnamed_788), 0.0f).w;
											}
											else
											{
												fragment_unnamed_794 = asfloat(fragment_unnamed_739);
											}
											float fragment_unnamed_807;
											if (fragment_unnamed_752 == 0u)
											{
												precise float fragment_unnamed_801 = clamp(fragment_unnamed_769, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												precise float fragment_unnamed_802 = clamp(fragment_unnamed_773, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												fragment_unnamed_807 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_801, fragment_unnamed_802), 0.0f).w;
											}
											else
											{
												fragment_unnamed_807 = fragment_unnamed_746;
											}
											precise float fragment_unnamed_808 = (-0.0f) - fragment_unnamed_247;
											uint fragment_unnamed_812 = fragment_unnamed_749 ? asuint(fragment_unnamed_794) : asuint(mad(fragment_unnamed_808, 0.5f, fragment_unnamed_794));
											float fragment_unnamed_813 = asfloat(fragment_unnamed_812);
											precise float fragment_unnamed_814 = (-0.0f) - fragment_unnamed_247;
											float fragment_unnamed_819 = asfloat(fragment_unnamed_750 ? asuint(fragment_unnamed_807) : asuint(mad(fragment_unnamed_814, 0.5f, fragment_unnamed_807)));
											bool fragment_unnamed_822 = abs(fragment_unnamed_813) >= fragment_unnamed_248;
											bool fragment_unnamed_823 = abs(fragment_unnamed_819) >= fragment_unnamed_248;
											uint fragment_unnamed_824 = fragment_unnamed_822 ? 4294967295u : 0u;
											uint fragment_unnamed_825 = fragment_unnamed_823 ? 4294967295u : 0u;
											precise float fragment_unnamed_826 = (-0.0f) - fragment_unnamed_193;
											uint fragment_unnamed_829 = fragment_unnamed_822 ? fragment_unnamed_756 : asuint(mad(fragment_unnamed_826, 2.0f, fragment_unnamed_757));
											float fragment_unnamed_830 = asfloat(fragment_unnamed_829);
											precise float fragment_unnamed_831 = (-0.0f) - fragment_unnamed_199;
											uint fragment_unnamed_834 = fragment_unnamed_822 ? fragment_unnamed_761 : asuint(mad(fragment_unnamed_831, 2.0f, fragment_unnamed_762));
											float fragment_unnamed_835 = asfloat(fragment_unnamed_834);
											uint fragment_unnamed_841 = fragment_unnamed_823 ? fragment_unnamed_768 : asuint(mad(fragment_unnamed_193, 2.0f, fragment_unnamed_769));
											float fragment_unnamed_842 = asfloat(fragment_unnamed_841);
											uint fragment_unnamed_845 = fragment_unnamed_823 ? fragment_unnamed_772 : asuint(mad(fragment_unnamed_199, 2.0f, fragment_unnamed_773));
											float fragment_unnamed_846 = asfloat(fragment_unnamed_845);
											float fragment_unnamed_776;
											float fragment_unnamed_777;
											float fragment_unnamed_778;
											float fragment_unnamed_779;
											float fragment_unnamed_780;
											float fragment_unnamed_781;
											if (((~fragment_unnamed_825) | (~fragment_unnamed_824)) != 0u)
											{
												float fragment_unnamed_867;
												if (fragment_unnamed_824 == 0u)
												{
													precise float fragment_unnamed_860 = clamp(fragment_unnamed_830, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													precise float fragment_unnamed_861 = clamp(fragment_unnamed_835, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													fragment_unnamed_867 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_860, fragment_unnamed_861), 0.0f).w;
												}
												else
												{
													fragment_unnamed_867 = asfloat(fragment_unnamed_812);
												}
												float fragment_unnamed_880;
												if (fragment_unnamed_825 == 0u)
												{
													precise float fragment_unnamed_874 = clamp(fragment_unnamed_842, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													precise float fragment_unnamed_875 = clamp(fragment_unnamed_846, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													fragment_unnamed_880 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_874, fragment_unnamed_875), 0.0f).w;
												}
												else
												{
													fragment_unnamed_880 = fragment_unnamed_819;
												}
												precise float fragment_unnamed_881 = (-0.0f) - fragment_unnamed_247;
												uint fragment_unnamed_885 = fragment_unnamed_822 ? asuint(fragment_unnamed_867) : asuint(mad(fragment_unnamed_881, 0.5f, fragment_unnamed_867));
												float fragment_unnamed_886 = asfloat(fragment_unnamed_885);
												precise float fragment_unnamed_887 = (-0.0f) - fragment_unnamed_247;
												float fragment_unnamed_892 = asfloat(fragment_unnamed_823 ? asuint(fragment_unnamed_880) : asuint(mad(fragment_unnamed_887, 0.5f, fragment_unnamed_880)));
												bool fragment_unnamed_895 = abs(fragment_unnamed_886) >= fragment_unnamed_248;
												bool fragment_unnamed_896 = abs(fragment_unnamed_892) >= fragment_unnamed_248;
												uint fragment_unnamed_897 = fragment_unnamed_895 ? 4294967295u : 0u;
												uint fragment_unnamed_898 = fragment_unnamed_896 ? 4294967295u : 0u;
												precise float fragment_unnamed_899 = (-0.0f) - fragment_unnamed_193;
												uint fragment_unnamed_902 = fragment_unnamed_895 ? fragment_unnamed_829 : asuint(mad(fragment_unnamed_899, 2.0f, fragment_unnamed_830));
												float fragment_unnamed_903 = asfloat(fragment_unnamed_902);
												precise float fragment_unnamed_904 = (-0.0f) - fragment_unnamed_199;
												uint fragment_unnamed_907 = fragment_unnamed_895 ? fragment_unnamed_834 : asuint(mad(fragment_unnamed_904, 2.0f, fragment_unnamed_835));
												float fragment_unnamed_908 = asfloat(fragment_unnamed_907);
												uint fragment_unnamed_914 = fragment_unnamed_896 ? fragment_unnamed_841 : asuint(mad(fragment_unnamed_193, 2.0f, fragment_unnamed_842));
												float fragment_unnamed_915 = asfloat(fragment_unnamed_914);
												uint fragment_unnamed_918 = fragment_unnamed_896 ? fragment_unnamed_845 : asuint(mad(fragment_unnamed_199, 2.0f, fragment_unnamed_846));
												float fragment_unnamed_919 = asfloat(fragment_unnamed_918);
												float fragment_unnamed_849;
												float fragment_unnamed_850;
												float fragment_unnamed_851;
												float fragment_unnamed_852;
												float fragment_unnamed_853;
												float fragment_unnamed_854;
												if (((~fragment_unnamed_898) | (~fragment_unnamed_897)) != 0u)
												{
													float fragment_unnamed_940;
													if (fragment_unnamed_897 == 0u)
													{
														precise float fragment_unnamed_933 = clamp(fragment_unnamed_903, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														precise float fragment_unnamed_934 = clamp(fragment_unnamed_908, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														fragment_unnamed_940 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_933, fragment_unnamed_934), 0.0f).w;
													}
													else
													{
														fragment_unnamed_940 = asfloat(fragment_unnamed_885);
													}
													float fragment_unnamed_953;
													if (fragment_unnamed_898 == 0u)
													{
														precise float fragment_unnamed_947 = clamp(fragment_unnamed_915, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														precise float fragment_unnamed_948 = clamp(fragment_unnamed_919, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														fragment_unnamed_953 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_947, fragment_unnamed_948), 0.0f).w;
													}
													else
													{
														fragment_unnamed_953 = fragment_unnamed_892;
													}
													precise float fragment_unnamed_954 = (-0.0f) - fragment_unnamed_247;
													uint fragment_unnamed_958 = fragment_unnamed_895 ? asuint(fragment_unnamed_940) : asuint(mad(fragment_unnamed_954, 0.5f, fragment_unnamed_940));
													float fragment_unnamed_959 = asfloat(fragment_unnamed_958);
													precise float fragment_unnamed_960 = (-0.0f) - fragment_unnamed_247;
													float fragment_unnamed_965 = asfloat(fragment_unnamed_896 ? asuint(fragment_unnamed_953) : asuint(mad(fragment_unnamed_960, 0.5f, fragment_unnamed_953)));
													bool fragment_unnamed_968 = abs(fragment_unnamed_959) >= fragment_unnamed_248;
													bool fragment_unnamed_969 = abs(fragment_unnamed_965) >= fragment_unnamed_248;
													uint fragment_unnamed_970 = fragment_unnamed_968 ? 4294967295u : 0u;
													uint fragment_unnamed_971 = fragment_unnamed_969 ? 4294967295u : 0u;
													precise float fragment_unnamed_972 = (-0.0f) - fragment_unnamed_193;
													uint fragment_unnamed_976 = fragment_unnamed_968 ? fragment_unnamed_902 : asuint(mad(fragment_unnamed_972, 4.0f, fragment_unnamed_903));
													float fragment_unnamed_977 = asfloat(fragment_unnamed_976);
													precise float fragment_unnamed_978 = (-0.0f) - fragment_unnamed_199;
													uint fragment_unnamed_981 = fragment_unnamed_968 ? fragment_unnamed_907 : asuint(mad(fragment_unnamed_978, 4.0f, fragment_unnamed_908));
													float fragment_unnamed_982 = asfloat(fragment_unnamed_981);
													uint fragment_unnamed_988 = fragment_unnamed_969 ? fragment_unnamed_914 : asuint(mad(fragment_unnamed_193, 4.0f, fragment_unnamed_915));
													float fragment_unnamed_989 = asfloat(fragment_unnamed_988);
													uint fragment_unnamed_992 = fragment_unnamed_969 ? fragment_unnamed_918 : asuint(mad(fragment_unnamed_199, 4.0f, fragment_unnamed_919));
													float fragment_unnamed_993 = asfloat(fragment_unnamed_992);
													float fragment_unnamed_922;
													float fragment_unnamed_923;
													float fragment_unnamed_924;
													float fragment_unnamed_925;
													float fragment_unnamed_926;
													float fragment_unnamed_927;
													if (((~fragment_unnamed_971) | (~fragment_unnamed_970)) != 0u)
													{
														float fragment_unnamed_1014;
														if (fragment_unnamed_970 == 0u)
														{
															precise float fragment_unnamed_1007 = clamp(fragment_unnamed_977, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															precise float fragment_unnamed_1008 = clamp(fragment_unnamed_982, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															fragment_unnamed_1014 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_1007, fragment_unnamed_1008), 0.0f).w;
														}
														else
														{
															fragment_unnamed_1014 = asfloat(fragment_unnamed_958);
														}
														float fragment_unnamed_1027;
														if (fragment_unnamed_971 == 0u)
														{
															precise float fragment_unnamed_1021 = clamp(fragment_unnamed_989, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															precise float fragment_unnamed_1022 = clamp(fragment_unnamed_993, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															fragment_unnamed_1027 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_1021, fragment_unnamed_1022), 0.0f).w;
														}
														else
														{
															fragment_unnamed_1027 = fragment_unnamed_965;
														}
														precise float fragment_unnamed_1028 = (-0.0f) - fragment_unnamed_247;
														float fragment_unnamed_996 = asfloat(fragment_unnamed_968 ? asuint(fragment_unnamed_1014) : asuint(mad(fragment_unnamed_1028, 0.5f, fragment_unnamed_1014)));
														precise float fragment_unnamed_1033 = (-0.0f) - fragment_unnamed_247;
														float fragment_unnamed_1001 = asfloat(fragment_unnamed_969 ? asuint(fragment_unnamed_1027) : asuint(mad(fragment_unnamed_1033, 0.5f, fragment_unnamed_1027)));
														bool fragment_unnamed_1040 = abs(fragment_unnamed_996) >= fragment_unnamed_248;
														bool fragment_unnamed_1041 = abs(fragment_unnamed_1001) >= fragment_unnamed_248;
														precise float fragment_unnamed_1042 = (-0.0f) - fragment_unnamed_193;
														precise float fragment_unnamed_1047 = (-0.0f) - fragment_unnamed_199;
														fragment_unnamed_922 = fragment_unnamed_996;
														fragment_unnamed_923 = asfloat(fragment_unnamed_1040 ? fragment_unnamed_976 : asuint(mad(fragment_unnamed_1042, 8.0f, fragment_unnamed_977)));
														fragment_unnamed_924 = asfloat(fragment_unnamed_1040 ? fragment_unnamed_981 : asuint(mad(fragment_unnamed_1047, 8.0f, fragment_unnamed_982)));
														fragment_unnamed_925 = asfloat(fragment_unnamed_1041 ? fragment_unnamed_988 : asuint(mad(fragment_unnamed_193, 8.0f, fragment_unnamed_989)));
														fragment_unnamed_926 = asfloat(fragment_unnamed_1041 ? fragment_unnamed_992 : asuint(mad(fragment_unnamed_199, 8.0f, fragment_unnamed_993)));
														fragment_unnamed_927 = fragment_unnamed_1001;
													}
													else
													{
														fragment_unnamed_922 = fragment_unnamed_959;
														fragment_unnamed_923 = fragment_unnamed_977;
														fragment_unnamed_924 = fragment_unnamed_982;
														fragment_unnamed_925 = fragment_unnamed_989;
														fragment_unnamed_926 = fragment_unnamed_993;
														fragment_unnamed_927 = fragment_unnamed_965;
													}
													fragment_unnamed_849 = fragment_unnamed_922;
													fragment_unnamed_850 = fragment_unnamed_923;
													fragment_unnamed_851 = fragment_unnamed_924;
													fragment_unnamed_852 = fragment_unnamed_925;
													fragment_unnamed_853 = fragment_unnamed_926;
													fragment_unnamed_854 = fragment_unnamed_927;
												}
												else
												{
													fragment_unnamed_849 = fragment_unnamed_886;
													fragment_unnamed_850 = fragment_unnamed_903;
													fragment_unnamed_851 = fragment_unnamed_908;
													fragment_unnamed_852 = fragment_unnamed_915;
													fragment_unnamed_853 = fragment_unnamed_919;
													fragment_unnamed_854 = fragment_unnamed_892;
												}
												fragment_unnamed_776 = fragment_unnamed_849;
												fragment_unnamed_777 = fragment_unnamed_850;
												fragment_unnamed_778 = fragment_unnamed_851;
												fragment_unnamed_779 = fragment_unnamed_852;
												fragment_unnamed_780 = fragment_unnamed_853;
												fragment_unnamed_781 = fragment_unnamed_854;
											}
											else
											{
												fragment_unnamed_776 = fragment_unnamed_813;
												fragment_unnamed_777 = fragment_unnamed_830;
												fragment_unnamed_778 = fragment_unnamed_835;
												fragment_unnamed_779 = fragment_unnamed_842;
												fragment_unnamed_780 = fragment_unnamed_846;
												fragment_unnamed_781 = fragment_unnamed_819;
											}
											fragment_unnamed_703 = fragment_unnamed_776;
											fragment_unnamed_704 = fragment_unnamed_777;
											fragment_unnamed_705 = fragment_unnamed_778;
											fragment_unnamed_706 = fragment_unnamed_779;
											fragment_unnamed_707 = fragment_unnamed_780;
											fragment_unnamed_708 = fragment_unnamed_781;
										}
										else
										{
											fragment_unnamed_703 = fragment_unnamed_740;
											fragment_unnamed_704 = fragment_unnamed_757;
											fragment_unnamed_705 = fragment_unnamed_762;
											fragment_unnamed_706 = fragment_unnamed_769;
											fragment_unnamed_707 = fragment_unnamed_773;
											fragment_unnamed_708 = fragment_unnamed_746;
										}
										fragment_unnamed_630 = fragment_unnamed_703;
										fragment_unnamed_631 = fragment_unnamed_704;
										fragment_unnamed_632 = fragment_unnamed_705;
										fragment_unnamed_633 = fragment_unnamed_706;
										fragment_unnamed_634 = fragment_unnamed_707;
										fragment_unnamed_635 = fragment_unnamed_708;
									}
									else
									{
										fragment_unnamed_630 = fragment_unnamed_667;
										fragment_unnamed_631 = fragment_unnamed_684;
										fragment_unnamed_632 = fragment_unnamed_689;
										fragment_unnamed_633 = fragment_unnamed_696;
										fragment_unnamed_634 = fragment_unnamed_700;
										fragment_unnamed_635 = fragment_unnamed_673;
									}
									fragment_unnamed_557 = fragment_unnamed_630;
									fragment_unnamed_558 = fragment_unnamed_631;
									fragment_unnamed_559 = fragment_unnamed_632;
									fragment_unnamed_560 = fragment_unnamed_633;
									fragment_unnamed_561 = fragment_unnamed_634;
									fragment_unnamed_562 = fragment_unnamed_635;
								}
								else
								{
									fragment_unnamed_557 = fragment_unnamed_594;
									fragment_unnamed_558 = fragment_unnamed_611;
									fragment_unnamed_559 = fragment_unnamed_616;
									fragment_unnamed_560 = fragment_unnamed_623;
									fragment_unnamed_561 = fragment_unnamed_627;
									fragment_unnamed_562 = fragment_unnamed_600;
								}
								fragment_unnamed_484 = fragment_unnamed_557;
								fragment_unnamed_485 = fragment_unnamed_558;
								fragment_unnamed_486 = fragment_unnamed_559;
								fragment_unnamed_487 = fragment_unnamed_560;
								fragment_unnamed_488 = fragment_unnamed_561;
								fragment_unnamed_489 = fragment_unnamed_562;
							}
							else
							{
								fragment_unnamed_484 = fragment_unnamed_521;
								fragment_unnamed_485 = fragment_unnamed_538;
								fragment_unnamed_486 = fragment_unnamed_543;
								fragment_unnamed_487 = fragment_unnamed_550;
								fragment_unnamed_488 = fragment_unnamed_554;
								fragment_unnamed_489 = fragment_unnamed_527;
							}
							fragment_unnamed_341 = fragment_unnamed_484;
							fragment_unnamed_343 = fragment_unnamed_485;
							fragment_unnamed_345 = fragment_unnamed_486;
							fragment_unnamed_347 = fragment_unnamed_487;
							fragment_unnamed_349 = fragment_unnamed_488;
							fragment_unnamed_351 = fragment_unnamed_489;
						}
						else
						{
							fragment_unnamed_341 = fragment_unnamed_448;
							fragment_unnamed_343 = fragment_unnamed_465;
							fragment_unnamed_345 = fragment_unnamed_470;
							fragment_unnamed_347 = fragment_unnamed_477;
							fragment_unnamed_349 = fragment_unnamed_481;
							fragment_unnamed_351 = fragment_unnamed_454;
						}
						fragment_unnamed_340 = fragment_unnamed_341;
						fragment_unnamed_342 = fragment_unnamed_343;
						fragment_unnamed_344 = fragment_unnamed_345;
						fragment_unnamed_346 = fragment_unnamed_347;
						fragment_unnamed_348 = fragment_unnamed_349;
						fragment_unnamed_350 = fragment_unnamed_351;
					}
					else
					{
						fragment_unnamed_340 = fragment_unnamed_256;
						fragment_unnamed_342 = fragment_unnamed_270;
						fragment_unnamed_344 = fragment_unnamed_275;
						fragment_unnamed_346 = fragment_unnamed_283;
						fragment_unnamed_348 = fragment_unnamed_288;
						fragment_unnamed_350 = fragment_unnamed_258;
					}
					precise float fragment_unnamed_352 = (-0.0f) - fragment_unnamed_342;
					precise float fragment_unnamed_355 = fragment_unnamed_352 + fragment_input_1.x;
					precise float fragment_unnamed_358 = (-0.0f) - fragment_input_1.x;
					precise float fragment_unnamed_359 = fragment_unnamed_346 + fragment_unnamed_358;
					precise float fragment_unnamed_360 = (-0.0f) - fragment_unnamed_344;
					precise float fragment_unnamed_363 = fragment_unnamed_360 + fragment_input_1.y;
					float fragment_unnamed_367 = asfloat(fragment_unnamed_144 ? asuint(fragment_unnamed_355) : asuint(fragment_unnamed_363));
					precise float fragment_unnamed_370 = (-0.0f) - fragment_input_1.y;
					precise float fragment_unnamed_371 = fragment_unnamed_348 + fragment_unnamed_370;
					float fragment_unnamed_375 = asfloat(fragment_unnamed_144 ? asuint(fragment_unnamed_359) : asuint(fragment_unnamed_371));
					precise float fragment_unnamed_380 = fragment_unnamed_367 + fragment_unnamed_375;
					precise float fragment_unnamed_385 = 1.0f / fragment_unnamed_380;
					precise float fragment_unnamed_389 = fragment_unnamed_252 * fragment_unnamed_252;
					precise float fragment_unnamed_390 = (-0.0f) - fragment_unnamed_385;
					float fragment_unnamed_395 = max(fragment_unnamed_389, asfloat(asuint(mad(min(fragment_unnamed_375, fragment_unnamed_367), fragment_unnamed_390, 0.5f)) & ((fragment_unnamed_367 < fragment_unnamed_375) ? ((fragment_unnamed_254 != ((fragment_unnamed_340 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_254 != ((fragment_unnamed_350 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					precise float fragment_unnamed_413 = clamp(fragment_unnamed_144 ? fragment_input_1.x : mad(fragment_unnamed_395, fragment_unnamed_184, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_414 = clamp(fragment_unnamed_144 ? mad(fragment_unnamed_395, fragment_unnamed_184, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float4 fragment_unnamed_416 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_413, fragment_unnamed_414), 0.0f);
					fragment_unnamed_290 = fragment_unnamed_416.z;
					fragment_unnamed_292 = fragment_unnamed_416.y;
					fragment_unnamed_294 = fragment_unnamed_416.x;
				}
				else
				{
					fragment_unnamed_290 = fragment_unnamed_56.z;
					fragment_unnamed_292 = fragment_unnamed_56.y;
					fragment_unnamed_294 = fragment_unnamed_56.x;
				}
				float fragment_unnamed_315 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				precise float fragment_unnamed_322 = (-0.0f) - abs(fragment_unnamed_315);
				precise float fragment_unnamed_323 = fragment_unnamed_322 + 1.0f;
				precise float fragment_unnamed_325 = (-0.0f) - sqrt(fragment_unnamed_323);
				precise float fragment_unnamed_326 = fragment_unnamed_325 + 1.0f;
				precise float fragment_unnamed_327 = fragment_unnamed_326 * mad(clamp(mad(fragment_unnamed_315, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_327, 0.0039215688593685626983642578125f, fragment_unnamed_294);
				fragment_output_0.y = mad(fragment_unnamed_327, 0.0039215688593685626983642578125f, fragment_unnamed_292);
				fragment_output_0.z = mad(fragment_unnamed_327, 0.0039215688593685626983642578125f, fragment_unnamed_290);
				fragment_output_0.w = fragment_unnamed_61;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[29] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA_LOW)


			#if defined(FXAA) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;
			float4 _PosScaleOffset;

			static float4 vertex_uniform_buffer_0[29];
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
				gl_Position.x = mad(vertex_input_0.x, vertex_uniform_buffer_0[28u].x, vertex_uniform_buffer_0[28u].z);
				gl_Position.y = mad(vertex_input_0.y, vertex_uniform_buffer_0[28u].y, vertex_uniform_buffer_0[28u].w);
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_55 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_56 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_62 = vertex_unnamed_55 * vertex_uniform_buffer_0[27u].x;
				precise float vertex_unnamed_63 = vertex_unnamed_56 * vertex_uniform_buffer_0[27u].y;
				float vertex_unnamed_68 = mad(vertex_unnamed_62, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_70 = mad(vertex_unnamed_63, 0.5f, vertex_uniform_buffer_0[27u].w);
				precise float vertex_unnamed_75 = vertex_unnamed_68 * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_76 = vertex_unnamed_70 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_75;
				vertex_output_1.y = vertex_unnamed_76;
				vertex_output_1.x = vertex_unnamed_68;
				vertex_output_1.y = vertex_unnamed_70;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_uniform_buffer_0[28] = float4(_PosScaleOffset[0], _PosScaleOffset[1], _PosScaleOffset[2], _PosScaleOffset[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[31];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				precise float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f);
				float fragment_unnamed_59 = fragment_unnamed_54.w;
				float4 fragment_unnamed_63 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, 1));
				float fragment_unnamed_67 = fragment_unnamed_63.w;
				float4 fragment_unnamed_68 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 0));
				float fragment_unnamed_71 = fragment_unnamed_68.w;
				float4 fragment_unnamed_73 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, -1));
				float fragment_unnamed_76 = fragment_unnamed_73.w;
				float4 fragment_unnamed_77 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 0));
				float fragment_unnamed_80 = fragment_unnamed_77.w;
				float fragment_unnamed_87 = max(max(max(fragment_unnamed_59, fragment_unnamed_67), fragment_unnamed_71), max(fragment_unnamed_76, fragment_unnamed_80));
				precise float fragment_unnamed_89 = fragment_unnamed_87 * 0.063000001013278961181640625f;
				precise float fragment_unnamed_91 = (-0.0f) - min(min(min(fragment_unnamed_59, fragment_unnamed_67), fragment_unnamed_71), min(fragment_unnamed_76, fragment_unnamed_80));
				precise float fragment_unnamed_93 = fragment_unnamed_91 + fragment_unnamed_87;
				float fragment_unnamed_288;
				float fragment_unnamed_290;
				float fragment_unnamed_292;
				if (fragment_unnamed_93 >= max(fragment_unnamed_89, 0.031199999153614044189453125f))
				{
					float4 fragment_unnamed_99 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, -1));
					float fragment_unnamed_102 = fragment_unnamed_99.w;
					float4 fragment_unnamed_103 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 1));
					float fragment_unnamed_106 = fragment_unnamed_103.w;
					float4 fragment_unnamed_107 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, -1));
					float fragment_unnamed_110 = fragment_unnamed_107.w;
					float4 fragment_unnamed_111 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 1));
					float fragment_unnamed_114 = fragment_unnamed_111.w;
					precise float fragment_unnamed_115 = fragment_unnamed_67 + fragment_unnamed_76;
					precise float fragment_unnamed_116 = fragment_unnamed_71 + fragment_unnamed_80;
					precise float fragment_unnamed_117 = 1.0f / fragment_unnamed_93;
					precise float fragment_unnamed_118 = fragment_unnamed_116 + fragment_unnamed_115;
					precise float fragment_unnamed_122 = fragment_unnamed_106 + fragment_unnamed_110;
					precise float fragment_unnamed_123 = fragment_unnamed_102 + fragment_unnamed_110;
					precise float fragment_unnamed_126 = fragment_unnamed_102 + fragment_unnamed_114;
					precise float fragment_unnamed_127 = fragment_unnamed_106 + fragment_unnamed_114;
					precise float fragment_unnamed_139 = mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_115)), 2.0f, abs(mad(fragment_unnamed_71, -2.0f, fragment_unnamed_122))) + abs(mad(fragment_unnamed_80, -2.0f, fragment_unnamed_126));
					precise float fragment_unnamed_140 = mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_116)), 2.0f, abs(mad(fragment_unnamed_76, -2.0f, fragment_unnamed_123))) + abs(mad(fragment_unnamed_67, -2.0f, fragment_unnamed_127));
					precise float fragment_unnamed_141 = fragment_unnamed_122 + fragment_unnamed_126;
					bool fragment_unnamed_142 = fragment_unnamed_139 >= fragment_unnamed_140;
					float fragment_unnamed_149 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_76) : asuint(fragment_unnamed_80));
					float fragment_unnamed_153 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_67) : asuint(fragment_unnamed_71));
					float fragment_unnamed_165 = asfloat(fragment_unnamed_142 ? asuint(fragment_uniform_buffer_0[30u]).y : asuint(fragment_uniform_buffer_0[30u]).x);
					precise float fragment_unnamed_166 = (-0.0f) - fragment_unnamed_59;
					precise float fragment_unnamed_169 = (-0.0f) - fragment_unnamed_59;
					precise float fragment_unnamed_170 = fragment_unnamed_169 + fragment_unnamed_149;
					precise float fragment_unnamed_171 = (-0.0f) - fragment_unnamed_59;
					precise float fragment_unnamed_172 = fragment_unnamed_171 + fragment_unnamed_153;
					precise float fragment_unnamed_173 = fragment_unnamed_59 + fragment_unnamed_149;
					precise float fragment_unnamed_174 = fragment_unnamed_59 + fragment_unnamed_153;
					bool fragment_unnamed_177 = abs(fragment_unnamed_170) >= abs(fragment_unnamed_172);
					precise float fragment_unnamed_181 = (-0.0f) - fragment_unnamed_165;
					float fragment_unnamed_182 = fragment_unnamed_177 ? fragment_unnamed_181 : fragment_unnamed_165;
					precise float fragment_unnamed_184 = fragment_unnamed_117 * abs(mad(mad(fragment_unnamed_118, 2.0f, fragment_unnamed_141), 0.083333335816860198974609375f, fragment_unnamed_166));
					float fragment_unnamed_185 = clamp(fragment_unnamed_184, 0.0f, 1.0f);
					float fragment_unnamed_191 = asfloat((fragment_unnamed_142 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[30u]).x);
					float fragment_unnamed_197 = asfloat(fragment_unnamed_142 ? 0u : asuint(fragment_uniform_buffer_0[30u]).y);
					float fragment_unnamed_207 = fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_182, 0.5f, fragment_input_1.x);
					float fragment_unnamed_210 = fragment_unnamed_142 ? mad(fragment_unnamed_182, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					precise float fragment_unnamed_211 = (-0.0f) - fragment_unnamed_191;
					precise float fragment_unnamed_212 = fragment_unnamed_211 + fragment_unnamed_207;
					precise float fragment_unnamed_214 = (-0.0f) - fragment_unnamed_197;
					precise float fragment_unnamed_215 = fragment_unnamed_214 + fragment_unnamed_210;
					precise float fragment_unnamed_217 = fragment_unnamed_191 + fragment_unnamed_207;
					precise float fragment_unnamed_218 = fragment_unnamed_197 + fragment_unnamed_210;
					precise float fragment_unnamed_226 = clamp(fragment_unnamed_212, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_227 = clamp(fragment_unnamed_215, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_231 = fragment_unnamed_185 * fragment_unnamed_185;
					precise float fragment_unnamed_237 = clamp(fragment_unnamed_217, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_238 = clamp(fragment_unnamed_218, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float fragment_unnamed_245 = asfloat(fragment_unnamed_177 ? asuint(fragment_unnamed_173) : asuint(fragment_unnamed_174));
					precise float fragment_unnamed_246 = max(abs(fragment_unnamed_172), abs(fragment_unnamed_170)) * 0.25f;
					precise float fragment_unnamed_248 = (-0.0f) - fragment_unnamed_245;
					precise float fragment_unnamed_250 = fragment_unnamed_231 * mad(fragment_unnamed_185, -2.0f, 3.0f);
					uint fragment_unnamed_252 = (mad(fragment_unnamed_248, 0.5f, fragment_unnamed_59) < 0.0f) ? 4294967295u : 0u;
					precise float fragment_unnamed_253 = (-0.0f) - fragment_unnamed_245;
					float fragment_unnamed_254 = mad(fragment_unnamed_253, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_226, fragment_unnamed_227), 0.0f).w);
					precise float fragment_unnamed_255 = (-0.0f) - fragment_unnamed_245;
					float fragment_unnamed_256 = mad(fragment_unnamed_255, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_237, fragment_unnamed_238), 0.0f).w);
					bool fragment_unnamed_259 = abs(fragment_unnamed_254) >= fragment_unnamed_246;
					bool fragment_unnamed_260 = abs(fragment_unnamed_256) >= fragment_unnamed_246;
					uint fragment_unnamed_261 = fragment_unnamed_259 ? 4294967295u : 0u;
					uint fragment_unnamed_262 = fragment_unnamed_260 ? 4294967295u : 0u;
					precise float fragment_unnamed_263 = (-0.0f) - fragment_unnamed_191;
					uint fragment_unnamed_267 = fragment_unnamed_259 ? asuint(fragment_unnamed_212) : asuint(mad(fragment_unnamed_263, 1.5f, fragment_unnamed_212));
					float fragment_unnamed_268 = asfloat(fragment_unnamed_267);
					precise float fragment_unnamed_269 = (-0.0f) - fragment_unnamed_197;
					uint fragment_unnamed_272 = fragment_unnamed_259 ? asuint(fragment_unnamed_215) : asuint(mad(fragment_unnamed_269, 1.5f, fragment_unnamed_215));
					float fragment_unnamed_273 = asfloat(fragment_unnamed_272);
					uint fragment_unnamed_280 = fragment_unnamed_260 ? asuint(fragment_unnamed_217) : asuint(mad(fragment_unnamed_191, 1.5f, fragment_unnamed_217));
					float fragment_unnamed_281 = asfloat(fragment_unnamed_280);
					uint fragment_unnamed_285 = fragment_unnamed_260 ? asuint(fragment_unnamed_218) : asuint(mad(fragment_unnamed_197, 1.5f, fragment_unnamed_218));
					float fragment_unnamed_286 = asfloat(fragment_unnamed_285);
					float fragment_unnamed_338;
					float fragment_unnamed_340;
					float fragment_unnamed_342;
					float fragment_unnamed_344;
					float fragment_unnamed_346;
					float fragment_unnamed_348;
					if (((~fragment_unnamed_262) | (~fragment_unnamed_261)) != 0u)
					{
						float fragment_unnamed_427;
						if (fragment_unnamed_261 == 0u)
						{
							precise float fragment_unnamed_421 = clamp(fragment_unnamed_268, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_422 = clamp(fragment_unnamed_273, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_427 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_421, fragment_unnamed_422), 0.0f).w;
						}
						else
						{
							fragment_unnamed_427 = fragment_unnamed_254;
						}
						float fragment_unnamed_440;
						if (fragment_unnamed_262 == 0u)
						{
							precise float fragment_unnamed_434 = clamp(fragment_unnamed_281, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_435 = clamp(fragment_unnamed_286, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_440 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_434, fragment_unnamed_435), 0.0f).w;
						}
						else
						{
							fragment_unnamed_440 = fragment_unnamed_256;
						}
						precise float fragment_unnamed_441 = (-0.0f) - fragment_unnamed_245;
						uint fragment_unnamed_445 = fragment_unnamed_259 ? asuint(fragment_unnamed_427) : asuint(mad(fragment_unnamed_441, 0.5f, fragment_unnamed_427));
						float fragment_unnamed_446 = asfloat(fragment_unnamed_445);
						precise float fragment_unnamed_447 = (-0.0f) - fragment_unnamed_245;
						float fragment_unnamed_452 = asfloat(fragment_unnamed_260 ? asuint(fragment_unnamed_440) : asuint(mad(fragment_unnamed_447, 0.5f, fragment_unnamed_440)));
						bool fragment_unnamed_455 = abs(fragment_unnamed_446) >= fragment_unnamed_246;
						bool fragment_unnamed_456 = abs(fragment_unnamed_452) >= fragment_unnamed_246;
						uint fragment_unnamed_457 = fragment_unnamed_455 ? 4294967295u : 0u;
						uint fragment_unnamed_458 = fragment_unnamed_456 ? 4294967295u : 0u;
						precise float fragment_unnamed_459 = (-0.0f) - fragment_unnamed_191;
						uint fragment_unnamed_462 = fragment_unnamed_455 ? fragment_unnamed_267 : asuint(mad(fragment_unnamed_459, 2.0f, fragment_unnamed_268));
						float fragment_unnamed_463 = asfloat(fragment_unnamed_462);
						precise float fragment_unnamed_464 = (-0.0f) - fragment_unnamed_197;
						uint fragment_unnamed_467 = fragment_unnamed_455 ? fragment_unnamed_272 : asuint(mad(fragment_unnamed_464, 2.0f, fragment_unnamed_273));
						float fragment_unnamed_468 = asfloat(fragment_unnamed_467);
						uint fragment_unnamed_474 = fragment_unnamed_456 ? fragment_unnamed_280 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_281));
						float fragment_unnamed_475 = asfloat(fragment_unnamed_474);
						uint fragment_unnamed_478 = fragment_unnamed_456 ? fragment_unnamed_285 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_286));
						float fragment_unnamed_479 = asfloat(fragment_unnamed_478);
						float fragment_unnamed_339;
						float fragment_unnamed_341;
						float fragment_unnamed_343;
						float fragment_unnamed_345;
						float fragment_unnamed_347;
						float fragment_unnamed_349;
						if (((~fragment_unnamed_458) | (~fragment_unnamed_457)) != 0u)
						{
							float fragment_unnamed_500;
							if (fragment_unnamed_457 == 0u)
							{
								precise float fragment_unnamed_493 = clamp(fragment_unnamed_463, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_494 = clamp(fragment_unnamed_468, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_500 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_493, fragment_unnamed_494), 0.0f).w;
							}
							else
							{
								fragment_unnamed_500 = asfloat(fragment_unnamed_445);
							}
							float fragment_unnamed_513;
							if (fragment_unnamed_458 == 0u)
							{
								precise float fragment_unnamed_507 = clamp(fragment_unnamed_475, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_508 = clamp(fragment_unnamed_479, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_513 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_507, fragment_unnamed_508), 0.0f).w;
							}
							else
							{
								fragment_unnamed_513 = fragment_unnamed_452;
							}
							precise float fragment_unnamed_514 = (-0.0f) - fragment_unnamed_245;
							uint fragment_unnamed_518 = fragment_unnamed_455 ? asuint(fragment_unnamed_500) : asuint(mad(fragment_unnamed_514, 0.5f, fragment_unnamed_500));
							float fragment_unnamed_519 = asfloat(fragment_unnamed_518);
							precise float fragment_unnamed_520 = (-0.0f) - fragment_unnamed_245;
							float fragment_unnamed_525 = asfloat(fragment_unnamed_456 ? asuint(fragment_unnamed_513) : asuint(mad(fragment_unnamed_520, 0.5f, fragment_unnamed_513)));
							bool fragment_unnamed_528 = abs(fragment_unnamed_519) >= fragment_unnamed_246;
							bool fragment_unnamed_529 = abs(fragment_unnamed_525) >= fragment_unnamed_246;
							uint fragment_unnamed_530 = fragment_unnamed_528 ? 4294967295u : 0u;
							uint fragment_unnamed_531 = fragment_unnamed_529 ? 4294967295u : 0u;
							precise float fragment_unnamed_532 = (-0.0f) - fragment_unnamed_191;
							uint fragment_unnamed_535 = fragment_unnamed_528 ? fragment_unnamed_462 : asuint(mad(fragment_unnamed_532, 2.0f, fragment_unnamed_463));
							float fragment_unnamed_536 = asfloat(fragment_unnamed_535);
							precise float fragment_unnamed_537 = (-0.0f) - fragment_unnamed_197;
							uint fragment_unnamed_540 = fragment_unnamed_528 ? fragment_unnamed_467 : asuint(mad(fragment_unnamed_537, 2.0f, fragment_unnamed_468));
							float fragment_unnamed_541 = asfloat(fragment_unnamed_540);
							uint fragment_unnamed_547 = fragment_unnamed_529 ? fragment_unnamed_474 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_475));
							float fragment_unnamed_548 = asfloat(fragment_unnamed_547);
							uint fragment_unnamed_551 = fragment_unnamed_529 ? fragment_unnamed_478 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_479));
							float fragment_unnamed_552 = asfloat(fragment_unnamed_551);
							float fragment_unnamed_482;
							float fragment_unnamed_483;
							float fragment_unnamed_484;
							float fragment_unnamed_485;
							float fragment_unnamed_486;
							float fragment_unnamed_487;
							if (((~fragment_unnamed_531) | (~fragment_unnamed_530)) != 0u)
							{
								float fragment_unnamed_573;
								if (fragment_unnamed_530 == 0u)
								{
									precise float fragment_unnamed_566 = clamp(fragment_unnamed_536, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_567 = clamp(fragment_unnamed_541, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_573 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_566, fragment_unnamed_567), 0.0f).w;
								}
								else
								{
									fragment_unnamed_573 = asfloat(fragment_unnamed_518);
								}
								float fragment_unnamed_586;
								if (fragment_unnamed_531 == 0u)
								{
									precise float fragment_unnamed_580 = clamp(fragment_unnamed_548, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_581 = clamp(fragment_unnamed_552, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_586 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_580, fragment_unnamed_581), 0.0f).w;
								}
								else
								{
									fragment_unnamed_586 = fragment_unnamed_525;
								}
								precise float fragment_unnamed_587 = (-0.0f) - fragment_unnamed_245;
								uint fragment_unnamed_591 = fragment_unnamed_528 ? asuint(fragment_unnamed_573) : asuint(mad(fragment_unnamed_587, 0.5f, fragment_unnamed_573));
								float fragment_unnamed_592 = asfloat(fragment_unnamed_591);
								precise float fragment_unnamed_593 = (-0.0f) - fragment_unnamed_245;
								float fragment_unnamed_598 = asfloat(fragment_unnamed_529 ? asuint(fragment_unnamed_586) : asuint(mad(fragment_unnamed_593, 0.5f, fragment_unnamed_586)));
								bool fragment_unnamed_601 = abs(fragment_unnamed_592) >= fragment_unnamed_246;
								bool fragment_unnamed_602 = abs(fragment_unnamed_598) >= fragment_unnamed_246;
								uint fragment_unnamed_603 = fragment_unnamed_601 ? 4294967295u : 0u;
								uint fragment_unnamed_604 = fragment_unnamed_602 ? 4294967295u : 0u;
								precise float fragment_unnamed_605 = (-0.0f) - fragment_unnamed_191;
								uint fragment_unnamed_608 = fragment_unnamed_601 ? fragment_unnamed_535 : asuint(mad(fragment_unnamed_605, 2.0f, fragment_unnamed_536));
								float fragment_unnamed_609 = asfloat(fragment_unnamed_608);
								precise float fragment_unnamed_610 = (-0.0f) - fragment_unnamed_197;
								uint fragment_unnamed_613 = fragment_unnamed_601 ? fragment_unnamed_540 : asuint(mad(fragment_unnamed_610, 2.0f, fragment_unnamed_541));
								float fragment_unnamed_614 = asfloat(fragment_unnamed_613);
								uint fragment_unnamed_620 = fragment_unnamed_602 ? fragment_unnamed_547 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_548));
								float fragment_unnamed_621 = asfloat(fragment_unnamed_620);
								uint fragment_unnamed_624 = fragment_unnamed_602 ? fragment_unnamed_551 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_552));
								float fragment_unnamed_625 = asfloat(fragment_unnamed_624);
								float fragment_unnamed_555;
								float fragment_unnamed_556;
								float fragment_unnamed_557;
								float fragment_unnamed_558;
								float fragment_unnamed_559;
								float fragment_unnamed_560;
								if (((~fragment_unnamed_604) | (~fragment_unnamed_603)) != 0u)
								{
									float fragment_unnamed_646;
									if (fragment_unnamed_603 == 0u)
									{
										precise float fragment_unnamed_639 = clamp(fragment_unnamed_609, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										precise float fragment_unnamed_640 = clamp(fragment_unnamed_614, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										fragment_unnamed_646 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_639, fragment_unnamed_640), 0.0f).w;
									}
									else
									{
										fragment_unnamed_646 = asfloat(fragment_unnamed_591);
									}
									float fragment_unnamed_659;
									if (fragment_unnamed_604 == 0u)
									{
										precise float fragment_unnamed_653 = clamp(fragment_unnamed_621, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										precise float fragment_unnamed_654 = clamp(fragment_unnamed_625, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										fragment_unnamed_659 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_653, fragment_unnamed_654), 0.0f).w;
									}
									else
									{
										fragment_unnamed_659 = fragment_unnamed_598;
									}
									precise float fragment_unnamed_660 = (-0.0f) - fragment_unnamed_245;
									uint fragment_unnamed_664 = fragment_unnamed_601 ? asuint(fragment_unnamed_646) : asuint(mad(fragment_unnamed_660, 0.5f, fragment_unnamed_646));
									float fragment_unnamed_665 = asfloat(fragment_unnamed_664);
									precise float fragment_unnamed_666 = (-0.0f) - fragment_unnamed_245;
									float fragment_unnamed_671 = asfloat(fragment_unnamed_602 ? asuint(fragment_unnamed_659) : asuint(mad(fragment_unnamed_666, 0.5f, fragment_unnamed_659)));
									bool fragment_unnamed_674 = abs(fragment_unnamed_665) >= fragment_unnamed_246;
									bool fragment_unnamed_675 = abs(fragment_unnamed_671) >= fragment_unnamed_246;
									uint fragment_unnamed_676 = fragment_unnamed_674 ? 4294967295u : 0u;
									uint fragment_unnamed_677 = fragment_unnamed_675 ? 4294967295u : 0u;
									precise float fragment_unnamed_678 = (-0.0f) - fragment_unnamed_191;
									uint fragment_unnamed_681 = fragment_unnamed_674 ? fragment_unnamed_608 : asuint(mad(fragment_unnamed_678, 2.0f, fragment_unnamed_609));
									float fragment_unnamed_682 = asfloat(fragment_unnamed_681);
									precise float fragment_unnamed_683 = (-0.0f) - fragment_unnamed_197;
									uint fragment_unnamed_686 = fragment_unnamed_674 ? fragment_unnamed_613 : asuint(mad(fragment_unnamed_683, 2.0f, fragment_unnamed_614));
									float fragment_unnamed_687 = asfloat(fragment_unnamed_686);
									uint fragment_unnamed_693 = fragment_unnamed_675 ? fragment_unnamed_620 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_621));
									float fragment_unnamed_694 = asfloat(fragment_unnamed_693);
									uint fragment_unnamed_697 = fragment_unnamed_675 ? fragment_unnamed_624 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_625));
									float fragment_unnamed_698 = asfloat(fragment_unnamed_697);
									float fragment_unnamed_628;
									float fragment_unnamed_629;
									float fragment_unnamed_630;
									float fragment_unnamed_631;
									float fragment_unnamed_632;
									float fragment_unnamed_633;
									if (((~fragment_unnamed_677) | (~fragment_unnamed_676)) != 0u)
									{
										float fragment_unnamed_719;
										if (fragment_unnamed_676 == 0u)
										{
											precise float fragment_unnamed_712 = clamp(fragment_unnamed_682, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											precise float fragment_unnamed_713 = clamp(fragment_unnamed_687, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											fragment_unnamed_719 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_712, fragment_unnamed_713), 0.0f).w;
										}
										else
										{
											fragment_unnamed_719 = asfloat(fragment_unnamed_664);
										}
										float fragment_unnamed_732;
										if (fragment_unnamed_677 == 0u)
										{
											precise float fragment_unnamed_726 = clamp(fragment_unnamed_694, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											precise float fragment_unnamed_727 = clamp(fragment_unnamed_698, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											fragment_unnamed_732 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_726, fragment_unnamed_727), 0.0f).w;
										}
										else
										{
											fragment_unnamed_732 = fragment_unnamed_671;
										}
										precise float fragment_unnamed_733 = (-0.0f) - fragment_unnamed_245;
										uint fragment_unnamed_737 = fragment_unnamed_674 ? asuint(fragment_unnamed_719) : asuint(mad(fragment_unnamed_733, 0.5f, fragment_unnamed_719));
										float fragment_unnamed_738 = asfloat(fragment_unnamed_737);
										precise float fragment_unnamed_739 = (-0.0f) - fragment_unnamed_245;
										float fragment_unnamed_744 = asfloat(fragment_unnamed_675 ? asuint(fragment_unnamed_732) : asuint(mad(fragment_unnamed_739, 0.5f, fragment_unnamed_732)));
										bool fragment_unnamed_747 = abs(fragment_unnamed_738) >= fragment_unnamed_246;
										bool fragment_unnamed_748 = abs(fragment_unnamed_744) >= fragment_unnamed_246;
										uint fragment_unnamed_749 = fragment_unnamed_747 ? 4294967295u : 0u;
										uint fragment_unnamed_750 = fragment_unnamed_748 ? 4294967295u : 0u;
										precise float fragment_unnamed_751 = (-0.0f) - fragment_unnamed_191;
										uint fragment_unnamed_754 = fragment_unnamed_747 ? fragment_unnamed_681 : asuint(mad(fragment_unnamed_751, 2.0f, fragment_unnamed_682));
										float fragment_unnamed_755 = asfloat(fragment_unnamed_754);
										precise float fragment_unnamed_756 = (-0.0f) - fragment_unnamed_197;
										uint fragment_unnamed_759 = fragment_unnamed_747 ? fragment_unnamed_686 : asuint(mad(fragment_unnamed_756, 2.0f, fragment_unnamed_687));
										float fragment_unnamed_760 = asfloat(fragment_unnamed_759);
										uint fragment_unnamed_766 = fragment_unnamed_748 ? fragment_unnamed_693 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_694));
										float fragment_unnamed_767 = asfloat(fragment_unnamed_766);
										uint fragment_unnamed_770 = fragment_unnamed_748 ? fragment_unnamed_697 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_698));
										float fragment_unnamed_771 = asfloat(fragment_unnamed_770);
										float fragment_unnamed_701;
										float fragment_unnamed_702;
										float fragment_unnamed_703;
										float fragment_unnamed_704;
										float fragment_unnamed_705;
										float fragment_unnamed_706;
										if (((~fragment_unnamed_750) | (~fragment_unnamed_749)) != 0u)
										{
											float fragment_unnamed_792;
											if (fragment_unnamed_749 == 0u)
											{
												precise float fragment_unnamed_785 = clamp(fragment_unnamed_755, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												precise float fragment_unnamed_786 = clamp(fragment_unnamed_760, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												fragment_unnamed_792 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_785, fragment_unnamed_786), 0.0f).w;
											}
											else
											{
												fragment_unnamed_792 = asfloat(fragment_unnamed_737);
											}
											float fragment_unnamed_805;
											if (fragment_unnamed_750 == 0u)
											{
												precise float fragment_unnamed_799 = clamp(fragment_unnamed_767, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												precise float fragment_unnamed_800 = clamp(fragment_unnamed_771, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												fragment_unnamed_805 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_799, fragment_unnamed_800), 0.0f).w;
											}
											else
											{
												fragment_unnamed_805 = fragment_unnamed_744;
											}
											precise float fragment_unnamed_806 = (-0.0f) - fragment_unnamed_245;
											uint fragment_unnamed_810 = fragment_unnamed_747 ? asuint(fragment_unnamed_792) : asuint(mad(fragment_unnamed_806, 0.5f, fragment_unnamed_792));
											float fragment_unnamed_811 = asfloat(fragment_unnamed_810);
											precise float fragment_unnamed_812 = (-0.0f) - fragment_unnamed_245;
											float fragment_unnamed_817 = asfloat(fragment_unnamed_748 ? asuint(fragment_unnamed_805) : asuint(mad(fragment_unnamed_812, 0.5f, fragment_unnamed_805)));
											bool fragment_unnamed_820 = abs(fragment_unnamed_811) >= fragment_unnamed_246;
											bool fragment_unnamed_821 = abs(fragment_unnamed_817) >= fragment_unnamed_246;
											uint fragment_unnamed_822 = fragment_unnamed_820 ? 4294967295u : 0u;
											uint fragment_unnamed_823 = fragment_unnamed_821 ? 4294967295u : 0u;
											precise float fragment_unnamed_824 = (-0.0f) - fragment_unnamed_191;
											uint fragment_unnamed_827 = fragment_unnamed_820 ? fragment_unnamed_754 : asuint(mad(fragment_unnamed_824, 2.0f, fragment_unnamed_755));
											float fragment_unnamed_828 = asfloat(fragment_unnamed_827);
											precise float fragment_unnamed_829 = (-0.0f) - fragment_unnamed_197;
											uint fragment_unnamed_832 = fragment_unnamed_820 ? fragment_unnamed_759 : asuint(mad(fragment_unnamed_829, 2.0f, fragment_unnamed_760));
											float fragment_unnamed_833 = asfloat(fragment_unnamed_832);
											uint fragment_unnamed_839 = fragment_unnamed_821 ? fragment_unnamed_766 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_767));
											float fragment_unnamed_840 = asfloat(fragment_unnamed_839);
											uint fragment_unnamed_843 = fragment_unnamed_821 ? fragment_unnamed_770 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_771));
											float fragment_unnamed_844 = asfloat(fragment_unnamed_843);
											float fragment_unnamed_774;
											float fragment_unnamed_775;
											float fragment_unnamed_776;
											float fragment_unnamed_777;
											float fragment_unnamed_778;
											float fragment_unnamed_779;
											if (((~fragment_unnamed_823) | (~fragment_unnamed_822)) != 0u)
											{
												float fragment_unnamed_865;
												if (fragment_unnamed_822 == 0u)
												{
													precise float fragment_unnamed_858 = clamp(fragment_unnamed_828, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													precise float fragment_unnamed_859 = clamp(fragment_unnamed_833, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													fragment_unnamed_865 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_858, fragment_unnamed_859), 0.0f).w;
												}
												else
												{
													fragment_unnamed_865 = asfloat(fragment_unnamed_810);
												}
												float fragment_unnamed_878;
												if (fragment_unnamed_823 == 0u)
												{
													precise float fragment_unnamed_872 = clamp(fragment_unnamed_840, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													precise float fragment_unnamed_873 = clamp(fragment_unnamed_844, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													fragment_unnamed_878 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_872, fragment_unnamed_873), 0.0f).w;
												}
												else
												{
													fragment_unnamed_878 = fragment_unnamed_817;
												}
												precise float fragment_unnamed_879 = (-0.0f) - fragment_unnamed_245;
												uint fragment_unnamed_883 = fragment_unnamed_820 ? asuint(fragment_unnamed_865) : asuint(mad(fragment_unnamed_879, 0.5f, fragment_unnamed_865));
												float fragment_unnamed_884 = asfloat(fragment_unnamed_883);
												precise float fragment_unnamed_885 = (-0.0f) - fragment_unnamed_245;
												float fragment_unnamed_890 = asfloat(fragment_unnamed_821 ? asuint(fragment_unnamed_878) : asuint(mad(fragment_unnamed_885, 0.5f, fragment_unnamed_878)));
												bool fragment_unnamed_893 = abs(fragment_unnamed_884) >= fragment_unnamed_246;
												bool fragment_unnamed_894 = abs(fragment_unnamed_890) >= fragment_unnamed_246;
												uint fragment_unnamed_895 = fragment_unnamed_893 ? 4294967295u : 0u;
												uint fragment_unnamed_896 = fragment_unnamed_894 ? 4294967295u : 0u;
												precise float fragment_unnamed_897 = (-0.0f) - fragment_unnamed_191;
												uint fragment_unnamed_900 = fragment_unnamed_893 ? fragment_unnamed_827 : asuint(mad(fragment_unnamed_897, 2.0f, fragment_unnamed_828));
												float fragment_unnamed_901 = asfloat(fragment_unnamed_900);
												precise float fragment_unnamed_902 = (-0.0f) - fragment_unnamed_197;
												uint fragment_unnamed_905 = fragment_unnamed_893 ? fragment_unnamed_832 : asuint(mad(fragment_unnamed_902, 2.0f, fragment_unnamed_833));
												float fragment_unnamed_906 = asfloat(fragment_unnamed_905);
												uint fragment_unnamed_912 = fragment_unnamed_894 ? fragment_unnamed_839 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_840));
												float fragment_unnamed_913 = asfloat(fragment_unnamed_912);
												uint fragment_unnamed_916 = fragment_unnamed_894 ? fragment_unnamed_843 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_844));
												float fragment_unnamed_917 = asfloat(fragment_unnamed_916);
												float fragment_unnamed_847;
												float fragment_unnamed_848;
												float fragment_unnamed_849;
												float fragment_unnamed_850;
												float fragment_unnamed_851;
												float fragment_unnamed_852;
												if (((~fragment_unnamed_896) | (~fragment_unnamed_895)) != 0u)
												{
													float fragment_unnamed_938;
													if (fragment_unnamed_895 == 0u)
													{
														precise float fragment_unnamed_931 = clamp(fragment_unnamed_901, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														precise float fragment_unnamed_932 = clamp(fragment_unnamed_906, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														fragment_unnamed_938 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_931, fragment_unnamed_932), 0.0f).w;
													}
													else
													{
														fragment_unnamed_938 = asfloat(fragment_unnamed_883);
													}
													float fragment_unnamed_951;
													if (fragment_unnamed_896 == 0u)
													{
														precise float fragment_unnamed_945 = clamp(fragment_unnamed_913, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														precise float fragment_unnamed_946 = clamp(fragment_unnamed_917, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														fragment_unnamed_951 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_945, fragment_unnamed_946), 0.0f).w;
													}
													else
													{
														fragment_unnamed_951 = fragment_unnamed_890;
													}
													precise float fragment_unnamed_952 = (-0.0f) - fragment_unnamed_245;
													uint fragment_unnamed_956 = fragment_unnamed_893 ? asuint(fragment_unnamed_938) : asuint(mad(fragment_unnamed_952, 0.5f, fragment_unnamed_938));
													float fragment_unnamed_957 = asfloat(fragment_unnamed_956);
													precise float fragment_unnamed_958 = (-0.0f) - fragment_unnamed_245;
													float fragment_unnamed_963 = asfloat(fragment_unnamed_894 ? asuint(fragment_unnamed_951) : asuint(mad(fragment_unnamed_958, 0.5f, fragment_unnamed_951)));
													bool fragment_unnamed_966 = abs(fragment_unnamed_957) >= fragment_unnamed_246;
													bool fragment_unnamed_967 = abs(fragment_unnamed_963) >= fragment_unnamed_246;
													uint fragment_unnamed_968 = fragment_unnamed_966 ? 4294967295u : 0u;
													uint fragment_unnamed_969 = fragment_unnamed_967 ? 4294967295u : 0u;
													precise float fragment_unnamed_970 = (-0.0f) - fragment_unnamed_191;
													uint fragment_unnamed_974 = fragment_unnamed_966 ? fragment_unnamed_900 : asuint(mad(fragment_unnamed_970, 4.0f, fragment_unnamed_901));
													float fragment_unnamed_975 = asfloat(fragment_unnamed_974);
													precise float fragment_unnamed_976 = (-0.0f) - fragment_unnamed_197;
													uint fragment_unnamed_979 = fragment_unnamed_966 ? fragment_unnamed_905 : asuint(mad(fragment_unnamed_976, 4.0f, fragment_unnamed_906));
													float fragment_unnamed_980 = asfloat(fragment_unnamed_979);
													uint fragment_unnamed_986 = fragment_unnamed_967 ? fragment_unnamed_912 : asuint(mad(fragment_unnamed_191, 4.0f, fragment_unnamed_913));
													float fragment_unnamed_987 = asfloat(fragment_unnamed_986);
													uint fragment_unnamed_990 = fragment_unnamed_967 ? fragment_unnamed_916 : asuint(mad(fragment_unnamed_197, 4.0f, fragment_unnamed_917));
													float fragment_unnamed_991 = asfloat(fragment_unnamed_990);
													float fragment_unnamed_920;
													float fragment_unnamed_921;
													float fragment_unnamed_922;
													float fragment_unnamed_923;
													float fragment_unnamed_924;
													float fragment_unnamed_925;
													if (((~fragment_unnamed_969) | (~fragment_unnamed_968)) != 0u)
													{
														float fragment_unnamed_1012;
														if (fragment_unnamed_968 == 0u)
														{
															precise float fragment_unnamed_1005 = clamp(fragment_unnamed_975, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															precise float fragment_unnamed_1006 = clamp(fragment_unnamed_980, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															fragment_unnamed_1012 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_1005, fragment_unnamed_1006), 0.0f).w;
														}
														else
														{
															fragment_unnamed_1012 = asfloat(fragment_unnamed_956);
														}
														float fragment_unnamed_1025;
														if (fragment_unnamed_969 == 0u)
														{
															precise float fragment_unnamed_1019 = clamp(fragment_unnamed_987, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															precise float fragment_unnamed_1020 = clamp(fragment_unnamed_991, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															fragment_unnamed_1025 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_1019, fragment_unnamed_1020), 0.0f).w;
														}
														else
														{
															fragment_unnamed_1025 = fragment_unnamed_963;
														}
														precise float fragment_unnamed_1026 = (-0.0f) - fragment_unnamed_245;
														float fragment_unnamed_994 = asfloat(fragment_unnamed_966 ? asuint(fragment_unnamed_1012) : asuint(mad(fragment_unnamed_1026, 0.5f, fragment_unnamed_1012)));
														precise float fragment_unnamed_1031 = (-0.0f) - fragment_unnamed_245;
														float fragment_unnamed_999 = asfloat(fragment_unnamed_967 ? asuint(fragment_unnamed_1025) : asuint(mad(fragment_unnamed_1031, 0.5f, fragment_unnamed_1025)));
														bool fragment_unnamed_1038 = abs(fragment_unnamed_994) >= fragment_unnamed_246;
														bool fragment_unnamed_1039 = abs(fragment_unnamed_999) >= fragment_unnamed_246;
														precise float fragment_unnamed_1040 = (-0.0f) - fragment_unnamed_191;
														precise float fragment_unnamed_1045 = (-0.0f) - fragment_unnamed_197;
														fragment_unnamed_920 = fragment_unnamed_994;
														fragment_unnamed_921 = asfloat(fragment_unnamed_1038 ? fragment_unnamed_974 : asuint(mad(fragment_unnamed_1040, 8.0f, fragment_unnamed_975)));
														fragment_unnamed_922 = asfloat(fragment_unnamed_1038 ? fragment_unnamed_979 : asuint(mad(fragment_unnamed_1045, 8.0f, fragment_unnamed_980)));
														fragment_unnamed_923 = asfloat(fragment_unnamed_1039 ? fragment_unnamed_986 : asuint(mad(fragment_unnamed_191, 8.0f, fragment_unnamed_987)));
														fragment_unnamed_924 = asfloat(fragment_unnamed_1039 ? fragment_unnamed_990 : asuint(mad(fragment_unnamed_197, 8.0f, fragment_unnamed_991)));
														fragment_unnamed_925 = fragment_unnamed_999;
													}
													else
													{
														fragment_unnamed_920 = fragment_unnamed_957;
														fragment_unnamed_921 = fragment_unnamed_975;
														fragment_unnamed_922 = fragment_unnamed_980;
														fragment_unnamed_923 = fragment_unnamed_987;
														fragment_unnamed_924 = fragment_unnamed_991;
														fragment_unnamed_925 = fragment_unnamed_963;
													}
													fragment_unnamed_847 = fragment_unnamed_920;
													fragment_unnamed_848 = fragment_unnamed_921;
													fragment_unnamed_849 = fragment_unnamed_922;
													fragment_unnamed_850 = fragment_unnamed_923;
													fragment_unnamed_851 = fragment_unnamed_924;
													fragment_unnamed_852 = fragment_unnamed_925;
												}
												else
												{
													fragment_unnamed_847 = fragment_unnamed_884;
													fragment_unnamed_848 = fragment_unnamed_901;
													fragment_unnamed_849 = fragment_unnamed_906;
													fragment_unnamed_850 = fragment_unnamed_913;
													fragment_unnamed_851 = fragment_unnamed_917;
													fragment_unnamed_852 = fragment_unnamed_890;
												}
												fragment_unnamed_774 = fragment_unnamed_847;
												fragment_unnamed_775 = fragment_unnamed_848;
												fragment_unnamed_776 = fragment_unnamed_849;
												fragment_unnamed_777 = fragment_unnamed_850;
												fragment_unnamed_778 = fragment_unnamed_851;
												fragment_unnamed_779 = fragment_unnamed_852;
											}
											else
											{
												fragment_unnamed_774 = fragment_unnamed_811;
												fragment_unnamed_775 = fragment_unnamed_828;
												fragment_unnamed_776 = fragment_unnamed_833;
												fragment_unnamed_777 = fragment_unnamed_840;
												fragment_unnamed_778 = fragment_unnamed_844;
												fragment_unnamed_779 = fragment_unnamed_817;
											}
											fragment_unnamed_701 = fragment_unnamed_774;
											fragment_unnamed_702 = fragment_unnamed_775;
											fragment_unnamed_703 = fragment_unnamed_776;
											fragment_unnamed_704 = fragment_unnamed_777;
											fragment_unnamed_705 = fragment_unnamed_778;
											fragment_unnamed_706 = fragment_unnamed_779;
										}
										else
										{
											fragment_unnamed_701 = fragment_unnamed_738;
											fragment_unnamed_702 = fragment_unnamed_755;
											fragment_unnamed_703 = fragment_unnamed_760;
											fragment_unnamed_704 = fragment_unnamed_767;
											fragment_unnamed_705 = fragment_unnamed_771;
											fragment_unnamed_706 = fragment_unnamed_744;
										}
										fragment_unnamed_628 = fragment_unnamed_701;
										fragment_unnamed_629 = fragment_unnamed_702;
										fragment_unnamed_630 = fragment_unnamed_703;
										fragment_unnamed_631 = fragment_unnamed_704;
										fragment_unnamed_632 = fragment_unnamed_705;
										fragment_unnamed_633 = fragment_unnamed_706;
									}
									else
									{
										fragment_unnamed_628 = fragment_unnamed_665;
										fragment_unnamed_629 = fragment_unnamed_682;
										fragment_unnamed_630 = fragment_unnamed_687;
										fragment_unnamed_631 = fragment_unnamed_694;
										fragment_unnamed_632 = fragment_unnamed_698;
										fragment_unnamed_633 = fragment_unnamed_671;
									}
									fragment_unnamed_555 = fragment_unnamed_628;
									fragment_unnamed_556 = fragment_unnamed_629;
									fragment_unnamed_557 = fragment_unnamed_630;
									fragment_unnamed_558 = fragment_unnamed_631;
									fragment_unnamed_559 = fragment_unnamed_632;
									fragment_unnamed_560 = fragment_unnamed_633;
								}
								else
								{
									fragment_unnamed_555 = fragment_unnamed_592;
									fragment_unnamed_556 = fragment_unnamed_609;
									fragment_unnamed_557 = fragment_unnamed_614;
									fragment_unnamed_558 = fragment_unnamed_621;
									fragment_unnamed_559 = fragment_unnamed_625;
									fragment_unnamed_560 = fragment_unnamed_598;
								}
								fragment_unnamed_482 = fragment_unnamed_555;
								fragment_unnamed_483 = fragment_unnamed_556;
								fragment_unnamed_484 = fragment_unnamed_557;
								fragment_unnamed_485 = fragment_unnamed_558;
								fragment_unnamed_486 = fragment_unnamed_559;
								fragment_unnamed_487 = fragment_unnamed_560;
							}
							else
							{
								fragment_unnamed_482 = fragment_unnamed_519;
								fragment_unnamed_483 = fragment_unnamed_536;
								fragment_unnamed_484 = fragment_unnamed_541;
								fragment_unnamed_485 = fragment_unnamed_548;
								fragment_unnamed_486 = fragment_unnamed_552;
								fragment_unnamed_487 = fragment_unnamed_525;
							}
							fragment_unnamed_339 = fragment_unnamed_482;
							fragment_unnamed_341 = fragment_unnamed_483;
							fragment_unnamed_343 = fragment_unnamed_484;
							fragment_unnamed_345 = fragment_unnamed_485;
							fragment_unnamed_347 = fragment_unnamed_486;
							fragment_unnamed_349 = fragment_unnamed_487;
						}
						else
						{
							fragment_unnamed_339 = fragment_unnamed_446;
							fragment_unnamed_341 = fragment_unnamed_463;
							fragment_unnamed_343 = fragment_unnamed_468;
							fragment_unnamed_345 = fragment_unnamed_475;
							fragment_unnamed_347 = fragment_unnamed_479;
							fragment_unnamed_349 = fragment_unnamed_452;
						}
						fragment_unnamed_338 = fragment_unnamed_339;
						fragment_unnamed_340 = fragment_unnamed_341;
						fragment_unnamed_342 = fragment_unnamed_343;
						fragment_unnamed_344 = fragment_unnamed_345;
						fragment_unnamed_346 = fragment_unnamed_347;
						fragment_unnamed_348 = fragment_unnamed_349;
					}
					else
					{
						fragment_unnamed_338 = fragment_unnamed_254;
						fragment_unnamed_340 = fragment_unnamed_268;
						fragment_unnamed_342 = fragment_unnamed_273;
						fragment_unnamed_344 = fragment_unnamed_281;
						fragment_unnamed_346 = fragment_unnamed_286;
						fragment_unnamed_348 = fragment_unnamed_256;
					}
					precise float fragment_unnamed_350 = (-0.0f) - fragment_unnamed_340;
					precise float fragment_unnamed_353 = fragment_unnamed_350 + fragment_input_1.x;
					precise float fragment_unnamed_356 = (-0.0f) - fragment_input_1.x;
					precise float fragment_unnamed_357 = fragment_unnamed_344 + fragment_unnamed_356;
					precise float fragment_unnamed_358 = (-0.0f) - fragment_unnamed_342;
					precise float fragment_unnamed_361 = fragment_unnamed_358 + fragment_input_1.y;
					float fragment_unnamed_365 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_353) : asuint(fragment_unnamed_361));
					precise float fragment_unnamed_368 = (-0.0f) - fragment_input_1.y;
					precise float fragment_unnamed_369 = fragment_unnamed_346 + fragment_unnamed_368;
					float fragment_unnamed_373 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_357) : asuint(fragment_unnamed_369));
					precise float fragment_unnamed_378 = fragment_unnamed_365 + fragment_unnamed_373;
					precise float fragment_unnamed_383 = 1.0f / fragment_unnamed_378;
					precise float fragment_unnamed_387 = fragment_unnamed_250 * fragment_unnamed_250;
					precise float fragment_unnamed_388 = (-0.0f) - fragment_unnamed_383;
					float fragment_unnamed_393 = max(fragment_unnamed_387, asfloat(asuint(mad(min(fragment_unnamed_373, fragment_unnamed_365), fragment_unnamed_388, 0.5f)) & ((fragment_unnamed_365 < fragment_unnamed_373) ? ((fragment_unnamed_252 != ((fragment_unnamed_338 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_252 != ((fragment_unnamed_348 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					precise float fragment_unnamed_411 = clamp(fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_393, fragment_unnamed_182, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_412 = clamp(fragment_unnamed_142 ? mad(fragment_unnamed_393, fragment_unnamed_182, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float4 fragment_unnamed_414 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_411, fragment_unnamed_412), 0.0f);
					fragment_unnamed_288 = fragment_unnamed_414.z;
					fragment_unnamed_290 = fragment_unnamed_414.y;
					fragment_unnamed_292 = fragment_unnamed_414.x;
				}
				else
				{
					fragment_unnamed_288 = fragment_unnamed_54.z;
					fragment_unnamed_290 = fragment_unnamed_54.y;
					fragment_unnamed_292 = fragment_unnamed_54.x;
				}
				float fragment_unnamed_313 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[29u].x, fragment_uniform_buffer_0[29u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[29u].y, fragment_uniform_buffer_0[29u].w))).w, 2.0f, -1.0f);
				precise float fragment_unnamed_320 = (-0.0f) - abs(fragment_unnamed_313);
				precise float fragment_unnamed_321 = fragment_unnamed_320 + 1.0f;
				precise float fragment_unnamed_323 = (-0.0f) - sqrt(fragment_unnamed_321);
				precise float fragment_unnamed_324 = fragment_unnamed_323 + 1.0f;
				precise float fragment_unnamed_325 = fragment_unnamed_324 * mad(clamp(mad(fragment_unnamed_313, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_292);
				fragment_output_0.y = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_290);
				fragment_output_0.z = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_288);
				fragment_output_0.w = fragment_unnamed_59;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[29] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[30] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA_LOW)


			#if defined(FXAA) && defined(FXAA_KEEP_ALPHA) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
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
				precise float vertex_unnamed_50 = vertex_unnamed_42 * vertex_uniform_buffer_0[27u].x;
				precise float vertex_unnamed_51 = vertex_unnamed_43 * vertex_uniform_buffer_0[27u].y;
				float vertex_unnamed_57 = mad(vertex_unnamed_50, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_59 = mad(vertex_unnamed_51, 0.5f, vertex_uniform_buffer_0[27u].w);
				precise float vertex_unnamed_64 = vertex_unnamed_57 * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_65 = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_64;
				vertex_output_1.y = vertex_unnamed_65;
				vertex_output_1.x = vertex_unnamed_57;
				vertex_output_1.y = vertex_unnamed_59;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				precise float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f);
				float fragment_unnamed_57 = fragment_unnamed_54.y;
				float4 fragment_unnamed_62 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, 1));
				float fragment_unnamed_66 = fragment_unnamed_62.y;
				float4 fragment_unnamed_67 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 0));
				float fragment_unnamed_70 = fragment_unnamed_67.y;
				float4 fragment_unnamed_72 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, -1));
				float fragment_unnamed_75 = fragment_unnamed_72.y;
				float4 fragment_unnamed_77 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 0));
				float fragment_unnamed_80 = fragment_unnamed_77.y;
				float fragment_unnamed_87 = max(max(max(fragment_unnamed_57, fragment_unnamed_66), fragment_unnamed_70), max(fragment_unnamed_75, fragment_unnamed_80));
				precise float fragment_unnamed_89 = fragment_unnamed_87 * 0.063000001013278961181640625f;
				precise float fragment_unnamed_91 = (-0.0f) - min(min(min(fragment_unnamed_57, fragment_unnamed_66), fragment_unnamed_70), min(fragment_unnamed_75, fragment_unnamed_80));
				precise float fragment_unnamed_93 = fragment_unnamed_91 + fragment_unnamed_87;
				float fragment_unnamed_287;
				float fragment_unnamed_289;
				float fragment_unnamed_291;
				if (fragment_unnamed_93 >= max(fragment_unnamed_89, 0.031199999153614044189453125f))
				{
					float4 fragment_unnamed_99 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, -1));
					float fragment_unnamed_102 = fragment_unnamed_99.y;
					float4 fragment_unnamed_103 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 1));
					float fragment_unnamed_106 = fragment_unnamed_103.y;
					float4 fragment_unnamed_107 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, -1));
					float fragment_unnamed_110 = fragment_unnamed_107.y;
					float4 fragment_unnamed_111 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 1));
					float fragment_unnamed_114 = fragment_unnamed_111.y;
					precise float fragment_unnamed_115 = fragment_unnamed_66 + fragment_unnamed_75;
					precise float fragment_unnamed_116 = fragment_unnamed_70 + fragment_unnamed_80;
					precise float fragment_unnamed_117 = 1.0f / fragment_unnamed_93;
					precise float fragment_unnamed_118 = fragment_unnamed_116 + fragment_unnamed_115;
					precise float fragment_unnamed_122 = fragment_unnamed_106 + fragment_unnamed_110;
					precise float fragment_unnamed_123 = fragment_unnamed_102 + fragment_unnamed_110;
					precise float fragment_unnamed_126 = fragment_unnamed_102 + fragment_unnamed_114;
					precise float fragment_unnamed_127 = fragment_unnamed_106 + fragment_unnamed_114;
					precise float fragment_unnamed_139 = mad(abs(mad(fragment_unnamed_57, -2.0f, fragment_unnamed_115)), 2.0f, abs(mad(fragment_unnamed_70, -2.0f, fragment_unnamed_122))) + abs(mad(fragment_unnamed_80, -2.0f, fragment_unnamed_126));
					precise float fragment_unnamed_140 = mad(abs(mad(fragment_unnamed_57, -2.0f, fragment_unnamed_116)), 2.0f, abs(mad(fragment_unnamed_75, -2.0f, fragment_unnamed_123))) + abs(mad(fragment_unnamed_66, -2.0f, fragment_unnamed_127));
					precise float fragment_unnamed_141 = fragment_unnamed_122 + fragment_unnamed_126;
					bool fragment_unnamed_142 = fragment_unnamed_139 >= fragment_unnamed_140;
					float fragment_unnamed_148 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_75) : asuint(fragment_unnamed_80));
					float fragment_unnamed_152 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_66) : asuint(fragment_unnamed_70));
					float fragment_unnamed_164 = asfloat(fragment_unnamed_142 ? asuint(fragment_uniform_buffer_0[29u]).y : asuint(fragment_uniform_buffer_0[29u]).x);
					precise float fragment_unnamed_165 = (-0.0f) - fragment_unnamed_57;
					precise float fragment_unnamed_168 = (-0.0f) - fragment_unnamed_57;
					precise float fragment_unnamed_169 = fragment_unnamed_168 + fragment_unnamed_148;
					precise float fragment_unnamed_170 = (-0.0f) - fragment_unnamed_57;
					precise float fragment_unnamed_171 = fragment_unnamed_170 + fragment_unnamed_152;
					precise float fragment_unnamed_172 = fragment_unnamed_57 + fragment_unnamed_148;
					precise float fragment_unnamed_173 = fragment_unnamed_57 + fragment_unnamed_152;
					bool fragment_unnamed_176 = abs(fragment_unnamed_169) >= abs(fragment_unnamed_171);
					precise float fragment_unnamed_180 = (-0.0f) - fragment_unnamed_164;
					float fragment_unnamed_181 = fragment_unnamed_176 ? fragment_unnamed_180 : fragment_unnamed_164;
					precise float fragment_unnamed_183 = fragment_unnamed_117 * abs(mad(mad(fragment_unnamed_118, 2.0f, fragment_unnamed_141), 0.083333335816860198974609375f, fragment_unnamed_165));
					float fragment_unnamed_184 = clamp(fragment_unnamed_183, 0.0f, 1.0f);
					float fragment_unnamed_190 = asfloat((fragment_unnamed_142 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_196 = asfloat(fragment_unnamed_142 ? 0u : asuint(fragment_uniform_buffer_0[29u]).y);
					float fragment_unnamed_206 = fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_181, 0.5f, fragment_input_1.x);
					float fragment_unnamed_209 = fragment_unnamed_142 ? mad(fragment_unnamed_181, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					precise float fragment_unnamed_210 = (-0.0f) - fragment_unnamed_190;
					precise float fragment_unnamed_211 = fragment_unnamed_210 + fragment_unnamed_206;
					precise float fragment_unnamed_213 = (-0.0f) - fragment_unnamed_196;
					precise float fragment_unnamed_214 = fragment_unnamed_213 + fragment_unnamed_209;
					precise float fragment_unnamed_216 = fragment_unnamed_190 + fragment_unnamed_206;
					precise float fragment_unnamed_217 = fragment_unnamed_196 + fragment_unnamed_209;
					precise float fragment_unnamed_225 = clamp(fragment_unnamed_211, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_226 = clamp(fragment_unnamed_214, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_230 = fragment_unnamed_184 * fragment_unnamed_184;
					precise float fragment_unnamed_236 = clamp(fragment_unnamed_216, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_237 = clamp(fragment_unnamed_217, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float fragment_unnamed_244 = asfloat(fragment_unnamed_176 ? asuint(fragment_unnamed_172) : asuint(fragment_unnamed_173));
					precise float fragment_unnamed_245 = max(abs(fragment_unnamed_171), abs(fragment_unnamed_169)) * 0.25f;
					precise float fragment_unnamed_247 = (-0.0f) - fragment_unnamed_244;
					precise float fragment_unnamed_249 = fragment_unnamed_230 * mad(fragment_unnamed_184, -2.0f, 3.0f);
					uint fragment_unnamed_251 = (mad(fragment_unnamed_247, 0.5f, fragment_unnamed_57) < 0.0f) ? 4294967295u : 0u;
					precise float fragment_unnamed_252 = (-0.0f) - fragment_unnamed_244;
					float fragment_unnamed_253 = mad(fragment_unnamed_252, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_225, fragment_unnamed_226), 0.0f).y);
					precise float fragment_unnamed_254 = (-0.0f) - fragment_unnamed_244;
					float fragment_unnamed_255 = mad(fragment_unnamed_254, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_236, fragment_unnamed_237), 0.0f).y);
					bool fragment_unnamed_258 = abs(fragment_unnamed_253) >= fragment_unnamed_245;
					bool fragment_unnamed_259 = abs(fragment_unnamed_255) >= fragment_unnamed_245;
					uint fragment_unnamed_260 = fragment_unnamed_258 ? 4294967295u : 0u;
					uint fragment_unnamed_261 = fragment_unnamed_259 ? 4294967295u : 0u;
					precise float fragment_unnamed_262 = (-0.0f) - fragment_unnamed_190;
					uint fragment_unnamed_266 = fragment_unnamed_258 ? asuint(fragment_unnamed_211) : asuint(mad(fragment_unnamed_262, 1.5f, fragment_unnamed_211));
					float fragment_unnamed_267 = asfloat(fragment_unnamed_266);
					precise float fragment_unnamed_268 = (-0.0f) - fragment_unnamed_196;
					uint fragment_unnamed_271 = fragment_unnamed_258 ? asuint(fragment_unnamed_214) : asuint(mad(fragment_unnamed_268, 1.5f, fragment_unnamed_214));
					float fragment_unnamed_272 = asfloat(fragment_unnamed_271);
					uint fragment_unnamed_279 = fragment_unnamed_259 ? asuint(fragment_unnamed_216) : asuint(mad(fragment_unnamed_190, 1.5f, fragment_unnamed_216));
					float fragment_unnamed_280 = asfloat(fragment_unnamed_279);
					uint fragment_unnamed_284 = fragment_unnamed_259 ? asuint(fragment_unnamed_217) : asuint(mad(fragment_unnamed_196, 1.5f, fragment_unnamed_217));
					float fragment_unnamed_285 = asfloat(fragment_unnamed_284);
					float fragment_unnamed_345;
					float fragment_unnamed_347;
					float fragment_unnamed_349;
					float fragment_unnamed_351;
					float fragment_unnamed_353;
					float fragment_unnamed_355;
					if (((~fragment_unnamed_261) | (~fragment_unnamed_260)) != 0u)
					{
						float fragment_unnamed_434;
						if (fragment_unnamed_260 == 0u)
						{
							precise float fragment_unnamed_428 = clamp(fragment_unnamed_267, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_429 = clamp(fragment_unnamed_272, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_434 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_428, fragment_unnamed_429), 0.0f).y;
						}
						else
						{
							fragment_unnamed_434 = fragment_unnamed_253;
						}
						float fragment_unnamed_447;
						if (fragment_unnamed_261 == 0u)
						{
							precise float fragment_unnamed_441 = clamp(fragment_unnamed_280, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_442 = clamp(fragment_unnamed_285, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_447 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_441, fragment_unnamed_442), 0.0f).y;
						}
						else
						{
							fragment_unnamed_447 = fragment_unnamed_255;
						}
						precise float fragment_unnamed_448 = (-0.0f) - fragment_unnamed_244;
						uint fragment_unnamed_452 = fragment_unnamed_258 ? asuint(fragment_unnamed_434) : asuint(mad(fragment_unnamed_448, 0.5f, fragment_unnamed_434));
						float fragment_unnamed_453 = asfloat(fragment_unnamed_452);
						precise float fragment_unnamed_454 = (-0.0f) - fragment_unnamed_244;
						float fragment_unnamed_459 = asfloat(fragment_unnamed_259 ? asuint(fragment_unnamed_447) : asuint(mad(fragment_unnamed_454, 0.5f, fragment_unnamed_447)));
						bool fragment_unnamed_462 = abs(fragment_unnamed_453) >= fragment_unnamed_245;
						bool fragment_unnamed_463 = abs(fragment_unnamed_459) >= fragment_unnamed_245;
						uint fragment_unnamed_464 = fragment_unnamed_462 ? 4294967295u : 0u;
						uint fragment_unnamed_465 = fragment_unnamed_463 ? 4294967295u : 0u;
						precise float fragment_unnamed_466 = (-0.0f) - fragment_unnamed_190;
						uint fragment_unnamed_469 = fragment_unnamed_462 ? fragment_unnamed_266 : asuint(mad(fragment_unnamed_466, 2.0f, fragment_unnamed_267));
						float fragment_unnamed_470 = asfloat(fragment_unnamed_469);
						precise float fragment_unnamed_471 = (-0.0f) - fragment_unnamed_196;
						uint fragment_unnamed_474 = fragment_unnamed_462 ? fragment_unnamed_271 : asuint(mad(fragment_unnamed_471, 2.0f, fragment_unnamed_272));
						float fragment_unnamed_475 = asfloat(fragment_unnamed_474);
						uint fragment_unnamed_481 = fragment_unnamed_463 ? fragment_unnamed_279 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_280));
						float fragment_unnamed_482 = asfloat(fragment_unnamed_481);
						uint fragment_unnamed_485 = fragment_unnamed_463 ? fragment_unnamed_284 : asuint(mad(fragment_unnamed_196, 2.0f, fragment_unnamed_285));
						float fragment_unnamed_486 = asfloat(fragment_unnamed_485);
						float fragment_unnamed_346;
						float fragment_unnamed_348;
						float fragment_unnamed_350;
						float fragment_unnamed_352;
						float fragment_unnamed_354;
						float fragment_unnamed_356;
						if (((~fragment_unnamed_465) | (~fragment_unnamed_464)) != 0u)
						{
							float fragment_unnamed_507;
							if (fragment_unnamed_464 == 0u)
							{
								precise float fragment_unnamed_500 = clamp(fragment_unnamed_470, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_501 = clamp(fragment_unnamed_475, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_507 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_500, fragment_unnamed_501), 0.0f).y;
							}
							else
							{
								fragment_unnamed_507 = asfloat(fragment_unnamed_452);
							}
							float fragment_unnamed_520;
							if (fragment_unnamed_465 == 0u)
							{
								precise float fragment_unnamed_514 = clamp(fragment_unnamed_482, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_515 = clamp(fragment_unnamed_486, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_520 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_514, fragment_unnamed_515), 0.0f).y;
							}
							else
							{
								fragment_unnamed_520 = fragment_unnamed_459;
							}
							precise float fragment_unnamed_521 = (-0.0f) - fragment_unnamed_244;
							uint fragment_unnamed_525 = fragment_unnamed_462 ? asuint(fragment_unnamed_507) : asuint(mad(fragment_unnamed_521, 0.5f, fragment_unnamed_507));
							float fragment_unnamed_526 = asfloat(fragment_unnamed_525);
							precise float fragment_unnamed_527 = (-0.0f) - fragment_unnamed_244;
							float fragment_unnamed_532 = asfloat(fragment_unnamed_463 ? asuint(fragment_unnamed_520) : asuint(mad(fragment_unnamed_527, 0.5f, fragment_unnamed_520)));
							bool fragment_unnamed_535 = abs(fragment_unnamed_526) >= fragment_unnamed_245;
							bool fragment_unnamed_536 = abs(fragment_unnamed_532) >= fragment_unnamed_245;
							uint fragment_unnamed_537 = fragment_unnamed_535 ? 4294967295u : 0u;
							uint fragment_unnamed_538 = fragment_unnamed_536 ? 4294967295u : 0u;
							precise float fragment_unnamed_539 = (-0.0f) - fragment_unnamed_190;
							uint fragment_unnamed_542 = fragment_unnamed_535 ? fragment_unnamed_469 : asuint(mad(fragment_unnamed_539, 2.0f, fragment_unnamed_470));
							float fragment_unnamed_543 = asfloat(fragment_unnamed_542);
							precise float fragment_unnamed_544 = (-0.0f) - fragment_unnamed_196;
							uint fragment_unnamed_547 = fragment_unnamed_535 ? fragment_unnamed_474 : asuint(mad(fragment_unnamed_544, 2.0f, fragment_unnamed_475));
							float fragment_unnamed_548 = asfloat(fragment_unnamed_547);
							uint fragment_unnamed_554 = fragment_unnamed_536 ? fragment_unnamed_481 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_482));
							float fragment_unnamed_555 = asfloat(fragment_unnamed_554);
							uint fragment_unnamed_558 = fragment_unnamed_536 ? fragment_unnamed_485 : asuint(mad(fragment_unnamed_196, 2.0f, fragment_unnamed_486));
							float fragment_unnamed_559 = asfloat(fragment_unnamed_558);
							float fragment_unnamed_489;
							float fragment_unnamed_490;
							float fragment_unnamed_491;
							float fragment_unnamed_492;
							float fragment_unnamed_493;
							float fragment_unnamed_494;
							if (((~fragment_unnamed_538) | (~fragment_unnamed_537)) != 0u)
							{
								float fragment_unnamed_580;
								if (fragment_unnamed_537 == 0u)
								{
									precise float fragment_unnamed_573 = clamp(fragment_unnamed_543, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_574 = clamp(fragment_unnamed_548, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_580 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_573, fragment_unnamed_574), 0.0f).y;
								}
								else
								{
									fragment_unnamed_580 = asfloat(fragment_unnamed_525);
								}
								float fragment_unnamed_593;
								if (fragment_unnamed_538 == 0u)
								{
									precise float fragment_unnamed_587 = clamp(fragment_unnamed_555, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_588 = clamp(fragment_unnamed_559, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_593 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_587, fragment_unnamed_588), 0.0f).y;
								}
								else
								{
									fragment_unnamed_593 = fragment_unnamed_532;
								}
								precise float fragment_unnamed_594 = (-0.0f) - fragment_unnamed_244;
								uint fragment_unnamed_598 = fragment_unnamed_535 ? asuint(fragment_unnamed_580) : asuint(mad(fragment_unnamed_594, 0.5f, fragment_unnamed_580));
								float fragment_unnamed_599 = asfloat(fragment_unnamed_598);
								precise float fragment_unnamed_600 = (-0.0f) - fragment_unnamed_244;
								float fragment_unnamed_605 = asfloat(fragment_unnamed_536 ? asuint(fragment_unnamed_593) : asuint(mad(fragment_unnamed_600, 0.5f, fragment_unnamed_593)));
								bool fragment_unnamed_608 = abs(fragment_unnamed_599) >= fragment_unnamed_245;
								bool fragment_unnamed_609 = abs(fragment_unnamed_605) >= fragment_unnamed_245;
								uint fragment_unnamed_610 = fragment_unnamed_608 ? 4294967295u : 0u;
								uint fragment_unnamed_611 = fragment_unnamed_609 ? 4294967295u : 0u;
								precise float fragment_unnamed_612 = (-0.0f) - fragment_unnamed_190;
								uint fragment_unnamed_615 = fragment_unnamed_608 ? fragment_unnamed_542 : asuint(mad(fragment_unnamed_612, 2.0f, fragment_unnamed_543));
								float fragment_unnamed_616 = asfloat(fragment_unnamed_615);
								precise float fragment_unnamed_617 = (-0.0f) - fragment_unnamed_196;
								uint fragment_unnamed_620 = fragment_unnamed_608 ? fragment_unnamed_547 : asuint(mad(fragment_unnamed_617, 2.0f, fragment_unnamed_548));
								float fragment_unnamed_621 = asfloat(fragment_unnamed_620);
								uint fragment_unnamed_627 = fragment_unnamed_609 ? fragment_unnamed_554 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_555));
								float fragment_unnamed_628 = asfloat(fragment_unnamed_627);
								uint fragment_unnamed_631 = fragment_unnamed_609 ? fragment_unnamed_558 : asuint(mad(fragment_unnamed_196, 2.0f, fragment_unnamed_559));
								float fragment_unnamed_632 = asfloat(fragment_unnamed_631);
								float fragment_unnamed_562;
								float fragment_unnamed_563;
								float fragment_unnamed_564;
								float fragment_unnamed_565;
								float fragment_unnamed_566;
								float fragment_unnamed_567;
								if (((~fragment_unnamed_611) | (~fragment_unnamed_610)) != 0u)
								{
									float fragment_unnamed_653;
									if (fragment_unnamed_610 == 0u)
									{
										precise float fragment_unnamed_646 = clamp(fragment_unnamed_616, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										precise float fragment_unnamed_647 = clamp(fragment_unnamed_621, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										fragment_unnamed_653 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_646, fragment_unnamed_647), 0.0f).y;
									}
									else
									{
										fragment_unnamed_653 = asfloat(fragment_unnamed_598);
									}
									float fragment_unnamed_666;
									if (fragment_unnamed_611 == 0u)
									{
										precise float fragment_unnamed_660 = clamp(fragment_unnamed_628, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										precise float fragment_unnamed_661 = clamp(fragment_unnamed_632, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										fragment_unnamed_666 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_660, fragment_unnamed_661), 0.0f).y;
									}
									else
									{
										fragment_unnamed_666 = fragment_unnamed_605;
									}
									precise float fragment_unnamed_667 = (-0.0f) - fragment_unnamed_244;
									uint fragment_unnamed_671 = fragment_unnamed_608 ? asuint(fragment_unnamed_653) : asuint(mad(fragment_unnamed_667, 0.5f, fragment_unnamed_653));
									float fragment_unnamed_672 = asfloat(fragment_unnamed_671);
									precise float fragment_unnamed_673 = (-0.0f) - fragment_unnamed_244;
									float fragment_unnamed_678 = asfloat(fragment_unnamed_609 ? asuint(fragment_unnamed_666) : asuint(mad(fragment_unnamed_673, 0.5f, fragment_unnamed_666)));
									bool fragment_unnamed_681 = abs(fragment_unnamed_672) >= fragment_unnamed_245;
									bool fragment_unnamed_682 = abs(fragment_unnamed_678) >= fragment_unnamed_245;
									uint fragment_unnamed_683 = fragment_unnamed_681 ? 4294967295u : 0u;
									uint fragment_unnamed_684 = fragment_unnamed_682 ? 4294967295u : 0u;
									precise float fragment_unnamed_685 = (-0.0f) - fragment_unnamed_190;
									uint fragment_unnamed_688 = fragment_unnamed_681 ? fragment_unnamed_615 : asuint(mad(fragment_unnamed_685, 2.0f, fragment_unnamed_616));
									float fragment_unnamed_689 = asfloat(fragment_unnamed_688);
									precise float fragment_unnamed_690 = (-0.0f) - fragment_unnamed_196;
									uint fragment_unnamed_693 = fragment_unnamed_681 ? fragment_unnamed_620 : asuint(mad(fragment_unnamed_690, 2.0f, fragment_unnamed_621));
									float fragment_unnamed_694 = asfloat(fragment_unnamed_693);
									uint fragment_unnamed_700 = fragment_unnamed_682 ? fragment_unnamed_627 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_628));
									float fragment_unnamed_701 = asfloat(fragment_unnamed_700);
									uint fragment_unnamed_704 = fragment_unnamed_682 ? fragment_unnamed_631 : asuint(mad(fragment_unnamed_196, 2.0f, fragment_unnamed_632));
									float fragment_unnamed_705 = asfloat(fragment_unnamed_704);
									float fragment_unnamed_635;
									float fragment_unnamed_636;
									float fragment_unnamed_637;
									float fragment_unnamed_638;
									float fragment_unnamed_639;
									float fragment_unnamed_640;
									if (((~fragment_unnamed_684) | (~fragment_unnamed_683)) != 0u)
									{
										float fragment_unnamed_726;
										if (fragment_unnamed_683 == 0u)
										{
											precise float fragment_unnamed_719 = clamp(fragment_unnamed_689, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											precise float fragment_unnamed_720 = clamp(fragment_unnamed_694, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											fragment_unnamed_726 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_719, fragment_unnamed_720), 0.0f).y;
										}
										else
										{
											fragment_unnamed_726 = asfloat(fragment_unnamed_671);
										}
										float fragment_unnamed_739;
										if (fragment_unnamed_684 == 0u)
										{
											precise float fragment_unnamed_733 = clamp(fragment_unnamed_701, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											precise float fragment_unnamed_734 = clamp(fragment_unnamed_705, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											fragment_unnamed_739 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_733, fragment_unnamed_734), 0.0f).y;
										}
										else
										{
											fragment_unnamed_739 = fragment_unnamed_678;
										}
										precise float fragment_unnamed_740 = (-0.0f) - fragment_unnamed_244;
										uint fragment_unnamed_744 = fragment_unnamed_681 ? asuint(fragment_unnamed_726) : asuint(mad(fragment_unnamed_740, 0.5f, fragment_unnamed_726));
										float fragment_unnamed_745 = asfloat(fragment_unnamed_744);
										precise float fragment_unnamed_746 = (-0.0f) - fragment_unnamed_244;
										float fragment_unnamed_751 = asfloat(fragment_unnamed_682 ? asuint(fragment_unnamed_739) : asuint(mad(fragment_unnamed_746, 0.5f, fragment_unnamed_739)));
										bool fragment_unnamed_754 = abs(fragment_unnamed_745) >= fragment_unnamed_245;
										bool fragment_unnamed_755 = abs(fragment_unnamed_751) >= fragment_unnamed_245;
										uint fragment_unnamed_756 = fragment_unnamed_754 ? 4294967295u : 0u;
										uint fragment_unnamed_757 = fragment_unnamed_755 ? 4294967295u : 0u;
										precise float fragment_unnamed_758 = (-0.0f) - fragment_unnamed_190;
										uint fragment_unnamed_761 = fragment_unnamed_754 ? fragment_unnamed_688 : asuint(mad(fragment_unnamed_758, 2.0f, fragment_unnamed_689));
										float fragment_unnamed_762 = asfloat(fragment_unnamed_761);
										precise float fragment_unnamed_763 = (-0.0f) - fragment_unnamed_196;
										uint fragment_unnamed_766 = fragment_unnamed_754 ? fragment_unnamed_693 : asuint(mad(fragment_unnamed_763, 2.0f, fragment_unnamed_694));
										float fragment_unnamed_767 = asfloat(fragment_unnamed_766);
										uint fragment_unnamed_773 = fragment_unnamed_755 ? fragment_unnamed_700 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_701));
										float fragment_unnamed_774 = asfloat(fragment_unnamed_773);
										uint fragment_unnamed_777 = fragment_unnamed_755 ? fragment_unnamed_704 : asuint(mad(fragment_unnamed_196, 2.0f, fragment_unnamed_705));
										float fragment_unnamed_778 = asfloat(fragment_unnamed_777);
										float fragment_unnamed_708;
										float fragment_unnamed_709;
										float fragment_unnamed_710;
										float fragment_unnamed_711;
										float fragment_unnamed_712;
										float fragment_unnamed_713;
										if (((~fragment_unnamed_757) | (~fragment_unnamed_756)) != 0u)
										{
											float fragment_unnamed_799;
											if (fragment_unnamed_756 == 0u)
											{
												precise float fragment_unnamed_792 = clamp(fragment_unnamed_762, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												precise float fragment_unnamed_793 = clamp(fragment_unnamed_767, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												fragment_unnamed_799 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_792, fragment_unnamed_793), 0.0f).y;
											}
											else
											{
												fragment_unnamed_799 = asfloat(fragment_unnamed_744);
											}
											float fragment_unnamed_812;
											if (fragment_unnamed_757 == 0u)
											{
												precise float fragment_unnamed_806 = clamp(fragment_unnamed_774, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												precise float fragment_unnamed_807 = clamp(fragment_unnamed_778, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												fragment_unnamed_812 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_806, fragment_unnamed_807), 0.0f).y;
											}
											else
											{
												fragment_unnamed_812 = fragment_unnamed_751;
											}
											precise float fragment_unnamed_813 = (-0.0f) - fragment_unnamed_244;
											uint fragment_unnamed_817 = fragment_unnamed_754 ? asuint(fragment_unnamed_799) : asuint(mad(fragment_unnamed_813, 0.5f, fragment_unnamed_799));
											float fragment_unnamed_818 = asfloat(fragment_unnamed_817);
											precise float fragment_unnamed_819 = (-0.0f) - fragment_unnamed_244;
											float fragment_unnamed_824 = asfloat(fragment_unnamed_755 ? asuint(fragment_unnamed_812) : asuint(mad(fragment_unnamed_819, 0.5f, fragment_unnamed_812)));
											bool fragment_unnamed_827 = abs(fragment_unnamed_818) >= fragment_unnamed_245;
											bool fragment_unnamed_828 = abs(fragment_unnamed_824) >= fragment_unnamed_245;
											uint fragment_unnamed_829 = fragment_unnamed_827 ? 4294967295u : 0u;
											uint fragment_unnamed_830 = fragment_unnamed_828 ? 4294967295u : 0u;
											precise float fragment_unnamed_831 = (-0.0f) - fragment_unnamed_190;
											uint fragment_unnamed_834 = fragment_unnamed_827 ? fragment_unnamed_761 : asuint(mad(fragment_unnamed_831, 2.0f, fragment_unnamed_762));
											float fragment_unnamed_835 = asfloat(fragment_unnamed_834);
											precise float fragment_unnamed_836 = (-0.0f) - fragment_unnamed_196;
											uint fragment_unnamed_839 = fragment_unnamed_827 ? fragment_unnamed_766 : asuint(mad(fragment_unnamed_836, 2.0f, fragment_unnamed_767));
											float fragment_unnamed_840 = asfloat(fragment_unnamed_839);
											uint fragment_unnamed_846 = fragment_unnamed_828 ? fragment_unnamed_773 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_774));
											float fragment_unnamed_847 = asfloat(fragment_unnamed_846);
											uint fragment_unnamed_850 = fragment_unnamed_828 ? fragment_unnamed_777 : asuint(mad(fragment_unnamed_196, 2.0f, fragment_unnamed_778));
											float fragment_unnamed_851 = asfloat(fragment_unnamed_850);
											float fragment_unnamed_781;
											float fragment_unnamed_782;
											float fragment_unnamed_783;
											float fragment_unnamed_784;
											float fragment_unnamed_785;
											float fragment_unnamed_786;
											if (((~fragment_unnamed_830) | (~fragment_unnamed_829)) != 0u)
											{
												float fragment_unnamed_872;
												if (fragment_unnamed_829 == 0u)
												{
													precise float fragment_unnamed_865 = clamp(fragment_unnamed_835, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													precise float fragment_unnamed_866 = clamp(fragment_unnamed_840, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													fragment_unnamed_872 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_865, fragment_unnamed_866), 0.0f).y;
												}
												else
												{
													fragment_unnamed_872 = asfloat(fragment_unnamed_817);
												}
												float fragment_unnamed_885;
												if (fragment_unnamed_830 == 0u)
												{
													precise float fragment_unnamed_879 = clamp(fragment_unnamed_847, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													precise float fragment_unnamed_880 = clamp(fragment_unnamed_851, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													fragment_unnamed_885 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_879, fragment_unnamed_880), 0.0f).y;
												}
												else
												{
													fragment_unnamed_885 = fragment_unnamed_824;
												}
												precise float fragment_unnamed_886 = (-0.0f) - fragment_unnamed_244;
												uint fragment_unnamed_890 = fragment_unnamed_827 ? asuint(fragment_unnamed_872) : asuint(mad(fragment_unnamed_886, 0.5f, fragment_unnamed_872));
												float fragment_unnamed_891 = asfloat(fragment_unnamed_890);
												precise float fragment_unnamed_892 = (-0.0f) - fragment_unnamed_244;
												float fragment_unnamed_897 = asfloat(fragment_unnamed_828 ? asuint(fragment_unnamed_885) : asuint(mad(fragment_unnamed_892, 0.5f, fragment_unnamed_885)));
												bool fragment_unnamed_900 = abs(fragment_unnamed_891) >= fragment_unnamed_245;
												bool fragment_unnamed_901 = abs(fragment_unnamed_897) >= fragment_unnamed_245;
												uint fragment_unnamed_902 = fragment_unnamed_900 ? 4294967295u : 0u;
												uint fragment_unnamed_903 = fragment_unnamed_901 ? 4294967295u : 0u;
												precise float fragment_unnamed_904 = (-0.0f) - fragment_unnamed_190;
												uint fragment_unnamed_907 = fragment_unnamed_900 ? fragment_unnamed_834 : asuint(mad(fragment_unnamed_904, 2.0f, fragment_unnamed_835));
												float fragment_unnamed_908 = asfloat(fragment_unnamed_907);
												precise float fragment_unnamed_909 = (-0.0f) - fragment_unnamed_196;
												uint fragment_unnamed_912 = fragment_unnamed_900 ? fragment_unnamed_839 : asuint(mad(fragment_unnamed_909, 2.0f, fragment_unnamed_840));
												float fragment_unnamed_913 = asfloat(fragment_unnamed_912);
												uint fragment_unnamed_919 = fragment_unnamed_901 ? fragment_unnamed_846 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_847));
												float fragment_unnamed_920 = asfloat(fragment_unnamed_919);
												uint fragment_unnamed_923 = fragment_unnamed_901 ? fragment_unnamed_850 : asuint(mad(fragment_unnamed_196, 2.0f, fragment_unnamed_851));
												float fragment_unnamed_924 = asfloat(fragment_unnamed_923);
												float fragment_unnamed_854;
												float fragment_unnamed_855;
												float fragment_unnamed_856;
												float fragment_unnamed_857;
												float fragment_unnamed_858;
												float fragment_unnamed_859;
												if (((~fragment_unnamed_903) | (~fragment_unnamed_902)) != 0u)
												{
													float fragment_unnamed_945;
													if (fragment_unnamed_902 == 0u)
													{
														precise float fragment_unnamed_938 = clamp(fragment_unnamed_908, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														precise float fragment_unnamed_939 = clamp(fragment_unnamed_913, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														fragment_unnamed_945 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_938, fragment_unnamed_939), 0.0f).y;
													}
													else
													{
														fragment_unnamed_945 = asfloat(fragment_unnamed_890);
													}
													float fragment_unnamed_958;
													if (fragment_unnamed_903 == 0u)
													{
														precise float fragment_unnamed_952 = clamp(fragment_unnamed_920, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														precise float fragment_unnamed_953 = clamp(fragment_unnamed_924, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														fragment_unnamed_958 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_952, fragment_unnamed_953), 0.0f).y;
													}
													else
													{
														fragment_unnamed_958 = fragment_unnamed_897;
													}
													precise float fragment_unnamed_959 = (-0.0f) - fragment_unnamed_244;
													uint fragment_unnamed_963 = fragment_unnamed_900 ? asuint(fragment_unnamed_945) : asuint(mad(fragment_unnamed_959, 0.5f, fragment_unnamed_945));
													float fragment_unnamed_964 = asfloat(fragment_unnamed_963);
													precise float fragment_unnamed_965 = (-0.0f) - fragment_unnamed_244;
													float fragment_unnamed_970 = asfloat(fragment_unnamed_901 ? asuint(fragment_unnamed_958) : asuint(mad(fragment_unnamed_965, 0.5f, fragment_unnamed_958)));
													bool fragment_unnamed_973 = abs(fragment_unnamed_964) >= fragment_unnamed_245;
													bool fragment_unnamed_974 = abs(fragment_unnamed_970) >= fragment_unnamed_245;
													uint fragment_unnamed_975 = fragment_unnamed_973 ? 4294967295u : 0u;
													uint fragment_unnamed_976 = fragment_unnamed_974 ? 4294967295u : 0u;
													precise float fragment_unnamed_977 = (-0.0f) - fragment_unnamed_190;
													uint fragment_unnamed_981 = fragment_unnamed_973 ? fragment_unnamed_907 : asuint(mad(fragment_unnamed_977, 4.0f, fragment_unnamed_908));
													float fragment_unnamed_982 = asfloat(fragment_unnamed_981);
													precise float fragment_unnamed_983 = (-0.0f) - fragment_unnamed_196;
													uint fragment_unnamed_986 = fragment_unnamed_973 ? fragment_unnamed_912 : asuint(mad(fragment_unnamed_983, 4.0f, fragment_unnamed_913));
													float fragment_unnamed_987 = asfloat(fragment_unnamed_986);
													uint fragment_unnamed_993 = fragment_unnamed_974 ? fragment_unnamed_919 : asuint(mad(fragment_unnamed_190, 4.0f, fragment_unnamed_920));
													float fragment_unnamed_994 = asfloat(fragment_unnamed_993);
													uint fragment_unnamed_997 = fragment_unnamed_974 ? fragment_unnamed_923 : asuint(mad(fragment_unnamed_196, 4.0f, fragment_unnamed_924));
													float fragment_unnamed_998 = asfloat(fragment_unnamed_997);
													float fragment_unnamed_927;
													float fragment_unnamed_928;
													float fragment_unnamed_929;
													float fragment_unnamed_930;
													float fragment_unnamed_931;
													float fragment_unnamed_932;
													if (((~fragment_unnamed_976) | (~fragment_unnamed_975)) != 0u)
													{
														float fragment_unnamed_1019;
														if (fragment_unnamed_975 == 0u)
														{
															precise float fragment_unnamed_1012 = clamp(fragment_unnamed_982, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															precise float fragment_unnamed_1013 = clamp(fragment_unnamed_987, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															fragment_unnamed_1019 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_1012, fragment_unnamed_1013), 0.0f).y;
														}
														else
														{
															fragment_unnamed_1019 = asfloat(fragment_unnamed_963);
														}
														float fragment_unnamed_1032;
														if (fragment_unnamed_976 == 0u)
														{
															precise float fragment_unnamed_1026 = clamp(fragment_unnamed_994, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															precise float fragment_unnamed_1027 = clamp(fragment_unnamed_998, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															fragment_unnamed_1032 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_1026, fragment_unnamed_1027), 0.0f).y;
														}
														else
														{
															fragment_unnamed_1032 = fragment_unnamed_970;
														}
														precise float fragment_unnamed_1033 = (-0.0f) - fragment_unnamed_244;
														float fragment_unnamed_1002 = asfloat(fragment_unnamed_973 ? asuint(fragment_unnamed_1019) : asuint(mad(fragment_unnamed_1033, 0.5f, fragment_unnamed_1019)));
														precise float fragment_unnamed_1038 = (-0.0f) - fragment_unnamed_244;
														float fragment_unnamed_1001 = asfloat(fragment_unnamed_974 ? asuint(fragment_unnamed_1032) : asuint(mad(fragment_unnamed_1038, 0.5f, fragment_unnamed_1032)));
														bool fragment_unnamed_1045 = abs(fragment_unnamed_1002) >= fragment_unnamed_245;
														bool fragment_unnamed_1046 = abs(fragment_unnamed_1001) >= fragment_unnamed_245;
														precise float fragment_unnamed_1047 = (-0.0f) - fragment_unnamed_190;
														precise float fragment_unnamed_1052 = (-0.0f) - fragment_unnamed_196;
														fragment_unnamed_927 = fragment_unnamed_1001;
														fragment_unnamed_928 = fragment_unnamed_1002;
														fragment_unnamed_929 = asfloat(fragment_unnamed_1045 ? fragment_unnamed_981 : asuint(mad(fragment_unnamed_1047, 8.0f, fragment_unnamed_982)));
														fragment_unnamed_930 = asfloat(fragment_unnamed_1045 ? fragment_unnamed_986 : asuint(mad(fragment_unnamed_1052, 8.0f, fragment_unnamed_987)));
														fragment_unnamed_931 = asfloat(fragment_unnamed_1046 ? fragment_unnamed_993 : asuint(mad(fragment_unnamed_190, 8.0f, fragment_unnamed_994)));
														fragment_unnamed_932 = asfloat(fragment_unnamed_1046 ? fragment_unnamed_997 : asuint(mad(fragment_unnamed_196, 8.0f, fragment_unnamed_998)));
													}
													else
													{
														fragment_unnamed_927 = fragment_unnamed_970;
														fragment_unnamed_928 = fragment_unnamed_964;
														fragment_unnamed_929 = fragment_unnamed_982;
														fragment_unnamed_930 = fragment_unnamed_987;
														fragment_unnamed_931 = fragment_unnamed_994;
														fragment_unnamed_932 = fragment_unnamed_998;
													}
													fragment_unnamed_854 = fragment_unnamed_927;
													fragment_unnamed_855 = fragment_unnamed_928;
													fragment_unnamed_856 = fragment_unnamed_929;
													fragment_unnamed_857 = fragment_unnamed_930;
													fragment_unnamed_858 = fragment_unnamed_931;
													fragment_unnamed_859 = fragment_unnamed_932;
												}
												else
												{
													fragment_unnamed_854 = fragment_unnamed_897;
													fragment_unnamed_855 = fragment_unnamed_891;
													fragment_unnamed_856 = fragment_unnamed_908;
													fragment_unnamed_857 = fragment_unnamed_913;
													fragment_unnamed_858 = fragment_unnamed_920;
													fragment_unnamed_859 = fragment_unnamed_924;
												}
												fragment_unnamed_781 = fragment_unnamed_854;
												fragment_unnamed_782 = fragment_unnamed_855;
												fragment_unnamed_783 = fragment_unnamed_856;
												fragment_unnamed_784 = fragment_unnamed_857;
												fragment_unnamed_785 = fragment_unnamed_858;
												fragment_unnamed_786 = fragment_unnamed_859;
											}
											else
											{
												fragment_unnamed_781 = fragment_unnamed_824;
												fragment_unnamed_782 = fragment_unnamed_818;
												fragment_unnamed_783 = fragment_unnamed_835;
												fragment_unnamed_784 = fragment_unnamed_840;
												fragment_unnamed_785 = fragment_unnamed_847;
												fragment_unnamed_786 = fragment_unnamed_851;
											}
											fragment_unnamed_708 = fragment_unnamed_781;
											fragment_unnamed_709 = fragment_unnamed_782;
											fragment_unnamed_710 = fragment_unnamed_783;
											fragment_unnamed_711 = fragment_unnamed_784;
											fragment_unnamed_712 = fragment_unnamed_785;
											fragment_unnamed_713 = fragment_unnamed_786;
										}
										else
										{
											fragment_unnamed_708 = fragment_unnamed_751;
											fragment_unnamed_709 = fragment_unnamed_745;
											fragment_unnamed_710 = fragment_unnamed_762;
											fragment_unnamed_711 = fragment_unnamed_767;
											fragment_unnamed_712 = fragment_unnamed_774;
											fragment_unnamed_713 = fragment_unnamed_778;
										}
										fragment_unnamed_635 = fragment_unnamed_708;
										fragment_unnamed_636 = fragment_unnamed_709;
										fragment_unnamed_637 = fragment_unnamed_710;
										fragment_unnamed_638 = fragment_unnamed_711;
										fragment_unnamed_639 = fragment_unnamed_712;
										fragment_unnamed_640 = fragment_unnamed_713;
									}
									else
									{
										fragment_unnamed_635 = fragment_unnamed_678;
										fragment_unnamed_636 = fragment_unnamed_672;
										fragment_unnamed_637 = fragment_unnamed_689;
										fragment_unnamed_638 = fragment_unnamed_694;
										fragment_unnamed_639 = fragment_unnamed_701;
										fragment_unnamed_640 = fragment_unnamed_705;
									}
									fragment_unnamed_562 = fragment_unnamed_635;
									fragment_unnamed_563 = fragment_unnamed_636;
									fragment_unnamed_564 = fragment_unnamed_637;
									fragment_unnamed_565 = fragment_unnamed_638;
									fragment_unnamed_566 = fragment_unnamed_639;
									fragment_unnamed_567 = fragment_unnamed_640;
								}
								else
								{
									fragment_unnamed_562 = fragment_unnamed_605;
									fragment_unnamed_563 = fragment_unnamed_599;
									fragment_unnamed_564 = fragment_unnamed_616;
									fragment_unnamed_565 = fragment_unnamed_621;
									fragment_unnamed_566 = fragment_unnamed_628;
									fragment_unnamed_567 = fragment_unnamed_632;
								}
								fragment_unnamed_489 = fragment_unnamed_562;
								fragment_unnamed_490 = fragment_unnamed_563;
								fragment_unnamed_491 = fragment_unnamed_564;
								fragment_unnamed_492 = fragment_unnamed_565;
								fragment_unnamed_493 = fragment_unnamed_566;
								fragment_unnamed_494 = fragment_unnamed_567;
							}
							else
							{
								fragment_unnamed_489 = fragment_unnamed_532;
								fragment_unnamed_490 = fragment_unnamed_526;
								fragment_unnamed_491 = fragment_unnamed_543;
								fragment_unnamed_492 = fragment_unnamed_548;
								fragment_unnamed_493 = fragment_unnamed_555;
								fragment_unnamed_494 = fragment_unnamed_559;
							}
							fragment_unnamed_346 = fragment_unnamed_489;
							fragment_unnamed_348 = fragment_unnamed_490;
							fragment_unnamed_350 = fragment_unnamed_491;
							fragment_unnamed_352 = fragment_unnamed_492;
							fragment_unnamed_354 = fragment_unnamed_493;
							fragment_unnamed_356 = fragment_unnamed_494;
						}
						else
						{
							fragment_unnamed_346 = fragment_unnamed_459;
							fragment_unnamed_348 = fragment_unnamed_453;
							fragment_unnamed_350 = fragment_unnamed_470;
							fragment_unnamed_352 = fragment_unnamed_475;
							fragment_unnamed_354 = fragment_unnamed_482;
							fragment_unnamed_356 = fragment_unnamed_486;
						}
						fragment_unnamed_345 = fragment_unnamed_346;
						fragment_unnamed_347 = fragment_unnamed_348;
						fragment_unnamed_349 = fragment_unnamed_350;
						fragment_unnamed_351 = fragment_unnamed_352;
						fragment_unnamed_353 = fragment_unnamed_354;
						fragment_unnamed_355 = fragment_unnamed_356;
					}
					else
					{
						fragment_unnamed_345 = fragment_unnamed_255;
						fragment_unnamed_347 = fragment_unnamed_253;
						fragment_unnamed_349 = fragment_unnamed_267;
						fragment_unnamed_351 = fragment_unnamed_272;
						fragment_unnamed_353 = fragment_unnamed_280;
						fragment_unnamed_355 = fragment_unnamed_285;
					}
					precise float fragment_unnamed_357 = (-0.0f) - fragment_unnamed_349;
					precise float fragment_unnamed_360 = fragment_unnamed_357 + fragment_input_1.x;
					precise float fragment_unnamed_363 = (-0.0f) - fragment_input_1.x;
					precise float fragment_unnamed_364 = fragment_unnamed_353 + fragment_unnamed_363;
					precise float fragment_unnamed_365 = (-0.0f) - fragment_unnamed_351;
					precise float fragment_unnamed_368 = fragment_unnamed_365 + fragment_input_1.y;
					float fragment_unnamed_372 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_360) : asuint(fragment_unnamed_368));
					precise float fragment_unnamed_375 = (-0.0f) - fragment_input_1.y;
					precise float fragment_unnamed_376 = fragment_unnamed_355 + fragment_unnamed_375;
					float fragment_unnamed_380 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_364) : asuint(fragment_unnamed_376));
					precise float fragment_unnamed_385 = fragment_unnamed_372 + fragment_unnamed_380;
					precise float fragment_unnamed_390 = 1.0f / fragment_unnamed_385;
					precise float fragment_unnamed_394 = fragment_unnamed_249 * fragment_unnamed_249;
					precise float fragment_unnamed_395 = (-0.0f) - fragment_unnamed_390;
					float fragment_unnamed_400 = max(fragment_unnamed_394, asfloat(asuint(mad(min(fragment_unnamed_380, fragment_unnamed_372), fragment_unnamed_395, 0.5f)) & ((fragment_unnamed_372 < fragment_unnamed_380) ? ((fragment_unnamed_251 != ((fragment_unnamed_347 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_251 != ((fragment_unnamed_345 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					precise float fragment_unnamed_418 = clamp(fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_400, fragment_unnamed_181, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_419 = clamp(fragment_unnamed_142 ? mad(fragment_unnamed_400, fragment_unnamed_181, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float4 fragment_unnamed_421 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_418, fragment_unnamed_419), 0.0f);
					fragment_unnamed_287 = fragment_unnamed_421.z;
					fragment_unnamed_289 = fragment_unnamed_421.y;
					fragment_unnamed_291 = fragment_unnamed_421.x;
				}
				else
				{
					fragment_unnamed_287 = fragment_unnamed_54.z;
					fragment_unnamed_289 = fragment_unnamed_57;
					fragment_unnamed_291 = fragment_unnamed_54.x;
				}
				float fragment_unnamed_320 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				precise float fragment_unnamed_327 = (-0.0f) - abs(fragment_unnamed_320);
				precise float fragment_unnamed_328 = fragment_unnamed_327 + 1.0f;
				precise float fragment_unnamed_330 = (-0.0f) - sqrt(fragment_unnamed_328);
				precise float fragment_unnamed_331 = fragment_unnamed_330 + 1.0f;
				precise float fragment_unnamed_332 = fragment_unnamed_331 * mad(clamp(mad(fragment_unnamed_320, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_332, 0.0039215688593685626983642578125f, fragment_unnamed_291);
				fragment_output_0.y = mad(fragment_unnamed_332, 0.0039215688593685626983642578125f, fragment_unnamed_289);
				fragment_output_0.z = mad(fragment_unnamed_332, 0.0039215688593685626983642578125f, fragment_unnamed_287);
				fragment_output_0.w = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[29] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA) && defined(FXAA_KEEP_ALPHA) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_LOW)


			#if defined(FXAA) && defined(FXAA_KEEP_ALPHA) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float _DepthSlice;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
			static float4 gl_Position;
			static uint gl_Layer;
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
				uint gl_Layer : SV_RenderTargetArrayIndex;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_44 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_45 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_52 = vertex_unnamed_44 * vertex_uniform_buffer_0[27u].x;
				precise float vertex_unnamed_53 = vertex_unnamed_45 * vertex_uniform_buffer_0[27u].y;
				float vertex_unnamed_59 = mad(vertex_unnamed_52, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_61 = mad(vertex_unnamed_53, 0.5f, vertex_uniform_buffer_0[27u].w);
				precise float vertex_unnamed_66 = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_67 = vertex_unnamed_61 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_66;
				vertex_output_1.y = vertex_unnamed_67;
				vertex_output_1.x = vertex_unnamed_59;
				vertex_output_1.y = vertex_unnamed_61;
				gl_Layer = int(uint(vertex_uniform_buffer_0[26u].y));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[26] = float4(vertex_uniform_buffer_0[26][0], _DepthSlice, vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.gl_Layer = gl_Layer;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				precise float fragment_unnamed_52 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_53 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_56 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f);
				float fragment_unnamed_59 = fragment_unnamed_56.y;
				float4 fragment_unnamed_64 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(0, 1));
				float fragment_unnamed_68 = fragment_unnamed_64.y;
				float4 fragment_unnamed_69 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, 0));
				float fragment_unnamed_72 = fragment_unnamed_69.y;
				float4 fragment_unnamed_74 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(0, -1));
				float fragment_unnamed_77 = fragment_unnamed_74.y;
				float4 fragment_unnamed_79 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, 0));
				float fragment_unnamed_82 = fragment_unnamed_79.y;
				float fragment_unnamed_89 = max(max(max(fragment_unnamed_59, fragment_unnamed_68), fragment_unnamed_72), max(fragment_unnamed_77, fragment_unnamed_82));
				precise float fragment_unnamed_91 = fragment_unnamed_89 * 0.063000001013278961181640625f;
				precise float fragment_unnamed_93 = (-0.0f) - min(min(min(fragment_unnamed_59, fragment_unnamed_68), fragment_unnamed_72), min(fragment_unnamed_77, fragment_unnamed_82));
				precise float fragment_unnamed_95 = fragment_unnamed_93 + fragment_unnamed_89;
				float fragment_unnamed_289;
				float fragment_unnamed_291;
				float fragment_unnamed_293;
				if (fragment_unnamed_95 >= max(fragment_unnamed_91, 0.031199999153614044189453125f))
				{
					float4 fragment_unnamed_101 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, -1));
					float fragment_unnamed_104 = fragment_unnamed_101.y;
					float4 fragment_unnamed_105 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, 1));
					float fragment_unnamed_108 = fragment_unnamed_105.y;
					float4 fragment_unnamed_109 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, -1));
					float fragment_unnamed_112 = fragment_unnamed_109.y;
					float4 fragment_unnamed_113 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, 1));
					float fragment_unnamed_116 = fragment_unnamed_113.y;
					precise float fragment_unnamed_117 = fragment_unnamed_68 + fragment_unnamed_77;
					precise float fragment_unnamed_118 = fragment_unnamed_72 + fragment_unnamed_82;
					precise float fragment_unnamed_119 = 1.0f / fragment_unnamed_95;
					precise float fragment_unnamed_120 = fragment_unnamed_118 + fragment_unnamed_117;
					precise float fragment_unnamed_124 = fragment_unnamed_108 + fragment_unnamed_112;
					precise float fragment_unnamed_125 = fragment_unnamed_104 + fragment_unnamed_112;
					precise float fragment_unnamed_128 = fragment_unnamed_104 + fragment_unnamed_116;
					precise float fragment_unnamed_129 = fragment_unnamed_108 + fragment_unnamed_116;
					precise float fragment_unnamed_141 = mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_117)), 2.0f, abs(mad(fragment_unnamed_72, -2.0f, fragment_unnamed_124))) + abs(mad(fragment_unnamed_82, -2.0f, fragment_unnamed_128));
					precise float fragment_unnamed_142 = mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_118)), 2.0f, abs(mad(fragment_unnamed_77, -2.0f, fragment_unnamed_125))) + abs(mad(fragment_unnamed_68, -2.0f, fragment_unnamed_129));
					precise float fragment_unnamed_143 = fragment_unnamed_124 + fragment_unnamed_128;
					bool fragment_unnamed_144 = fragment_unnamed_141 >= fragment_unnamed_142;
					float fragment_unnamed_150 = asfloat(fragment_unnamed_144 ? asuint(fragment_unnamed_77) : asuint(fragment_unnamed_82));
					float fragment_unnamed_154 = asfloat(fragment_unnamed_144 ? asuint(fragment_unnamed_68) : asuint(fragment_unnamed_72));
					float fragment_unnamed_166 = asfloat(fragment_unnamed_144 ? asuint(fragment_uniform_buffer_0[29u]).y : asuint(fragment_uniform_buffer_0[29u]).x);
					precise float fragment_unnamed_167 = (-0.0f) - fragment_unnamed_59;
					precise float fragment_unnamed_170 = (-0.0f) - fragment_unnamed_59;
					precise float fragment_unnamed_171 = fragment_unnamed_170 + fragment_unnamed_150;
					precise float fragment_unnamed_172 = (-0.0f) - fragment_unnamed_59;
					precise float fragment_unnamed_173 = fragment_unnamed_172 + fragment_unnamed_154;
					precise float fragment_unnamed_174 = fragment_unnamed_59 + fragment_unnamed_150;
					precise float fragment_unnamed_175 = fragment_unnamed_59 + fragment_unnamed_154;
					bool fragment_unnamed_178 = abs(fragment_unnamed_171) >= abs(fragment_unnamed_173);
					precise float fragment_unnamed_182 = (-0.0f) - fragment_unnamed_166;
					float fragment_unnamed_183 = fragment_unnamed_178 ? fragment_unnamed_182 : fragment_unnamed_166;
					precise float fragment_unnamed_185 = fragment_unnamed_119 * abs(mad(mad(fragment_unnamed_120, 2.0f, fragment_unnamed_143), 0.083333335816860198974609375f, fragment_unnamed_167));
					float fragment_unnamed_186 = clamp(fragment_unnamed_185, 0.0f, 1.0f);
					float fragment_unnamed_192 = asfloat((fragment_unnamed_144 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_198 = asfloat(fragment_unnamed_144 ? 0u : asuint(fragment_uniform_buffer_0[29u]).y);
					float fragment_unnamed_208 = fragment_unnamed_144 ? fragment_input_1.x : mad(fragment_unnamed_183, 0.5f, fragment_input_1.x);
					float fragment_unnamed_211 = fragment_unnamed_144 ? mad(fragment_unnamed_183, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					precise float fragment_unnamed_212 = (-0.0f) - fragment_unnamed_192;
					precise float fragment_unnamed_213 = fragment_unnamed_212 + fragment_unnamed_208;
					precise float fragment_unnamed_215 = (-0.0f) - fragment_unnamed_198;
					precise float fragment_unnamed_216 = fragment_unnamed_215 + fragment_unnamed_211;
					precise float fragment_unnamed_218 = fragment_unnamed_192 + fragment_unnamed_208;
					precise float fragment_unnamed_219 = fragment_unnamed_198 + fragment_unnamed_211;
					precise float fragment_unnamed_227 = clamp(fragment_unnamed_213, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_228 = clamp(fragment_unnamed_216, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_232 = fragment_unnamed_186 * fragment_unnamed_186;
					precise float fragment_unnamed_238 = clamp(fragment_unnamed_218, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_239 = clamp(fragment_unnamed_219, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float fragment_unnamed_246 = asfloat(fragment_unnamed_178 ? asuint(fragment_unnamed_174) : asuint(fragment_unnamed_175));
					precise float fragment_unnamed_247 = max(abs(fragment_unnamed_173), abs(fragment_unnamed_171)) * 0.25f;
					precise float fragment_unnamed_249 = (-0.0f) - fragment_unnamed_246;
					precise float fragment_unnamed_251 = fragment_unnamed_232 * mad(fragment_unnamed_186, -2.0f, 3.0f);
					uint fragment_unnamed_253 = (mad(fragment_unnamed_249, 0.5f, fragment_unnamed_59) < 0.0f) ? 4294967295u : 0u;
					precise float fragment_unnamed_254 = (-0.0f) - fragment_unnamed_246;
					float fragment_unnamed_255 = mad(fragment_unnamed_254, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_227, fragment_unnamed_228), 0.0f).y);
					precise float fragment_unnamed_256 = (-0.0f) - fragment_unnamed_246;
					float fragment_unnamed_257 = mad(fragment_unnamed_256, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_238, fragment_unnamed_239), 0.0f).y);
					bool fragment_unnamed_260 = abs(fragment_unnamed_255) >= fragment_unnamed_247;
					bool fragment_unnamed_261 = abs(fragment_unnamed_257) >= fragment_unnamed_247;
					uint fragment_unnamed_262 = fragment_unnamed_260 ? 4294967295u : 0u;
					uint fragment_unnamed_263 = fragment_unnamed_261 ? 4294967295u : 0u;
					precise float fragment_unnamed_264 = (-0.0f) - fragment_unnamed_192;
					uint fragment_unnamed_268 = fragment_unnamed_260 ? asuint(fragment_unnamed_213) : asuint(mad(fragment_unnamed_264, 1.5f, fragment_unnamed_213));
					float fragment_unnamed_269 = asfloat(fragment_unnamed_268);
					precise float fragment_unnamed_270 = (-0.0f) - fragment_unnamed_198;
					uint fragment_unnamed_273 = fragment_unnamed_260 ? asuint(fragment_unnamed_216) : asuint(mad(fragment_unnamed_270, 1.5f, fragment_unnamed_216));
					float fragment_unnamed_274 = asfloat(fragment_unnamed_273);
					uint fragment_unnamed_281 = fragment_unnamed_261 ? asuint(fragment_unnamed_218) : asuint(mad(fragment_unnamed_192, 1.5f, fragment_unnamed_218));
					float fragment_unnamed_282 = asfloat(fragment_unnamed_281);
					uint fragment_unnamed_286 = fragment_unnamed_261 ? asuint(fragment_unnamed_219) : asuint(mad(fragment_unnamed_198, 1.5f, fragment_unnamed_219));
					float fragment_unnamed_287 = asfloat(fragment_unnamed_286);
					float fragment_unnamed_347;
					float fragment_unnamed_349;
					float fragment_unnamed_351;
					float fragment_unnamed_353;
					float fragment_unnamed_355;
					float fragment_unnamed_357;
					if (((~fragment_unnamed_263) | (~fragment_unnamed_262)) != 0u)
					{
						float fragment_unnamed_436;
						if (fragment_unnamed_262 == 0u)
						{
							precise float fragment_unnamed_430 = clamp(fragment_unnamed_269, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_431 = clamp(fragment_unnamed_274, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_436 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_430, fragment_unnamed_431), 0.0f).y;
						}
						else
						{
							fragment_unnamed_436 = fragment_unnamed_255;
						}
						float fragment_unnamed_449;
						if (fragment_unnamed_263 == 0u)
						{
							precise float fragment_unnamed_443 = clamp(fragment_unnamed_282, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_444 = clamp(fragment_unnamed_287, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_449 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_443, fragment_unnamed_444), 0.0f).y;
						}
						else
						{
							fragment_unnamed_449 = fragment_unnamed_257;
						}
						precise float fragment_unnamed_450 = (-0.0f) - fragment_unnamed_246;
						uint fragment_unnamed_454 = fragment_unnamed_260 ? asuint(fragment_unnamed_436) : asuint(mad(fragment_unnamed_450, 0.5f, fragment_unnamed_436));
						float fragment_unnamed_455 = asfloat(fragment_unnamed_454);
						precise float fragment_unnamed_456 = (-0.0f) - fragment_unnamed_246;
						float fragment_unnamed_461 = asfloat(fragment_unnamed_261 ? asuint(fragment_unnamed_449) : asuint(mad(fragment_unnamed_456, 0.5f, fragment_unnamed_449)));
						bool fragment_unnamed_464 = abs(fragment_unnamed_455) >= fragment_unnamed_247;
						bool fragment_unnamed_465 = abs(fragment_unnamed_461) >= fragment_unnamed_247;
						uint fragment_unnamed_466 = fragment_unnamed_464 ? 4294967295u : 0u;
						uint fragment_unnamed_467 = fragment_unnamed_465 ? 4294967295u : 0u;
						precise float fragment_unnamed_468 = (-0.0f) - fragment_unnamed_192;
						uint fragment_unnamed_471 = fragment_unnamed_464 ? fragment_unnamed_268 : asuint(mad(fragment_unnamed_468, 2.0f, fragment_unnamed_269));
						float fragment_unnamed_472 = asfloat(fragment_unnamed_471);
						precise float fragment_unnamed_473 = (-0.0f) - fragment_unnamed_198;
						uint fragment_unnamed_476 = fragment_unnamed_464 ? fragment_unnamed_273 : asuint(mad(fragment_unnamed_473, 2.0f, fragment_unnamed_274));
						float fragment_unnamed_477 = asfloat(fragment_unnamed_476);
						uint fragment_unnamed_483 = fragment_unnamed_465 ? fragment_unnamed_281 : asuint(mad(fragment_unnamed_192, 2.0f, fragment_unnamed_282));
						float fragment_unnamed_484 = asfloat(fragment_unnamed_483);
						uint fragment_unnamed_487 = fragment_unnamed_465 ? fragment_unnamed_286 : asuint(mad(fragment_unnamed_198, 2.0f, fragment_unnamed_287));
						float fragment_unnamed_488 = asfloat(fragment_unnamed_487);
						float fragment_unnamed_348;
						float fragment_unnamed_350;
						float fragment_unnamed_352;
						float fragment_unnamed_354;
						float fragment_unnamed_356;
						float fragment_unnamed_358;
						if (((~fragment_unnamed_467) | (~fragment_unnamed_466)) != 0u)
						{
							float fragment_unnamed_509;
							if (fragment_unnamed_466 == 0u)
							{
								precise float fragment_unnamed_502 = clamp(fragment_unnamed_472, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_503 = clamp(fragment_unnamed_477, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_509 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_502, fragment_unnamed_503), 0.0f).y;
							}
							else
							{
								fragment_unnamed_509 = asfloat(fragment_unnamed_454);
							}
							float fragment_unnamed_522;
							if (fragment_unnamed_467 == 0u)
							{
								precise float fragment_unnamed_516 = clamp(fragment_unnamed_484, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_517 = clamp(fragment_unnamed_488, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_522 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_516, fragment_unnamed_517), 0.0f).y;
							}
							else
							{
								fragment_unnamed_522 = fragment_unnamed_461;
							}
							precise float fragment_unnamed_523 = (-0.0f) - fragment_unnamed_246;
							uint fragment_unnamed_527 = fragment_unnamed_464 ? asuint(fragment_unnamed_509) : asuint(mad(fragment_unnamed_523, 0.5f, fragment_unnamed_509));
							float fragment_unnamed_528 = asfloat(fragment_unnamed_527);
							precise float fragment_unnamed_529 = (-0.0f) - fragment_unnamed_246;
							float fragment_unnamed_534 = asfloat(fragment_unnamed_465 ? asuint(fragment_unnamed_522) : asuint(mad(fragment_unnamed_529, 0.5f, fragment_unnamed_522)));
							bool fragment_unnamed_537 = abs(fragment_unnamed_528) >= fragment_unnamed_247;
							bool fragment_unnamed_538 = abs(fragment_unnamed_534) >= fragment_unnamed_247;
							uint fragment_unnamed_539 = fragment_unnamed_537 ? 4294967295u : 0u;
							uint fragment_unnamed_540 = fragment_unnamed_538 ? 4294967295u : 0u;
							precise float fragment_unnamed_541 = (-0.0f) - fragment_unnamed_192;
							uint fragment_unnamed_544 = fragment_unnamed_537 ? fragment_unnamed_471 : asuint(mad(fragment_unnamed_541, 2.0f, fragment_unnamed_472));
							float fragment_unnamed_545 = asfloat(fragment_unnamed_544);
							precise float fragment_unnamed_546 = (-0.0f) - fragment_unnamed_198;
							uint fragment_unnamed_549 = fragment_unnamed_537 ? fragment_unnamed_476 : asuint(mad(fragment_unnamed_546, 2.0f, fragment_unnamed_477));
							float fragment_unnamed_550 = asfloat(fragment_unnamed_549);
							uint fragment_unnamed_556 = fragment_unnamed_538 ? fragment_unnamed_483 : asuint(mad(fragment_unnamed_192, 2.0f, fragment_unnamed_484));
							float fragment_unnamed_557 = asfloat(fragment_unnamed_556);
							uint fragment_unnamed_560 = fragment_unnamed_538 ? fragment_unnamed_487 : asuint(mad(fragment_unnamed_198, 2.0f, fragment_unnamed_488));
							float fragment_unnamed_561 = asfloat(fragment_unnamed_560);
							float fragment_unnamed_491;
							float fragment_unnamed_492;
							float fragment_unnamed_493;
							float fragment_unnamed_494;
							float fragment_unnamed_495;
							float fragment_unnamed_496;
							if (((~fragment_unnamed_540) | (~fragment_unnamed_539)) != 0u)
							{
								float fragment_unnamed_582;
								if (fragment_unnamed_539 == 0u)
								{
									precise float fragment_unnamed_575 = clamp(fragment_unnamed_545, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_576 = clamp(fragment_unnamed_550, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_582 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_575, fragment_unnamed_576), 0.0f).y;
								}
								else
								{
									fragment_unnamed_582 = asfloat(fragment_unnamed_527);
								}
								float fragment_unnamed_595;
								if (fragment_unnamed_540 == 0u)
								{
									precise float fragment_unnamed_589 = clamp(fragment_unnamed_557, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_590 = clamp(fragment_unnamed_561, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_595 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_589, fragment_unnamed_590), 0.0f).y;
								}
								else
								{
									fragment_unnamed_595 = fragment_unnamed_534;
								}
								precise float fragment_unnamed_596 = (-0.0f) - fragment_unnamed_246;
								uint fragment_unnamed_600 = fragment_unnamed_537 ? asuint(fragment_unnamed_582) : asuint(mad(fragment_unnamed_596, 0.5f, fragment_unnamed_582));
								float fragment_unnamed_601 = asfloat(fragment_unnamed_600);
								precise float fragment_unnamed_602 = (-0.0f) - fragment_unnamed_246;
								float fragment_unnamed_607 = asfloat(fragment_unnamed_538 ? asuint(fragment_unnamed_595) : asuint(mad(fragment_unnamed_602, 0.5f, fragment_unnamed_595)));
								bool fragment_unnamed_610 = abs(fragment_unnamed_601) >= fragment_unnamed_247;
								bool fragment_unnamed_611 = abs(fragment_unnamed_607) >= fragment_unnamed_247;
								uint fragment_unnamed_612 = fragment_unnamed_610 ? 4294967295u : 0u;
								uint fragment_unnamed_613 = fragment_unnamed_611 ? 4294967295u : 0u;
								precise float fragment_unnamed_614 = (-0.0f) - fragment_unnamed_192;
								uint fragment_unnamed_617 = fragment_unnamed_610 ? fragment_unnamed_544 : asuint(mad(fragment_unnamed_614, 2.0f, fragment_unnamed_545));
								float fragment_unnamed_618 = asfloat(fragment_unnamed_617);
								precise float fragment_unnamed_619 = (-0.0f) - fragment_unnamed_198;
								uint fragment_unnamed_622 = fragment_unnamed_610 ? fragment_unnamed_549 : asuint(mad(fragment_unnamed_619, 2.0f, fragment_unnamed_550));
								float fragment_unnamed_623 = asfloat(fragment_unnamed_622);
								uint fragment_unnamed_629 = fragment_unnamed_611 ? fragment_unnamed_556 : asuint(mad(fragment_unnamed_192, 2.0f, fragment_unnamed_557));
								float fragment_unnamed_630 = asfloat(fragment_unnamed_629);
								uint fragment_unnamed_633 = fragment_unnamed_611 ? fragment_unnamed_560 : asuint(mad(fragment_unnamed_198, 2.0f, fragment_unnamed_561));
								float fragment_unnamed_634 = asfloat(fragment_unnamed_633);
								float fragment_unnamed_564;
								float fragment_unnamed_565;
								float fragment_unnamed_566;
								float fragment_unnamed_567;
								float fragment_unnamed_568;
								float fragment_unnamed_569;
								if (((~fragment_unnamed_613) | (~fragment_unnamed_612)) != 0u)
								{
									float fragment_unnamed_655;
									if (fragment_unnamed_612 == 0u)
									{
										precise float fragment_unnamed_648 = clamp(fragment_unnamed_618, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										precise float fragment_unnamed_649 = clamp(fragment_unnamed_623, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										fragment_unnamed_655 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_648, fragment_unnamed_649), 0.0f).y;
									}
									else
									{
										fragment_unnamed_655 = asfloat(fragment_unnamed_600);
									}
									float fragment_unnamed_668;
									if (fragment_unnamed_613 == 0u)
									{
										precise float fragment_unnamed_662 = clamp(fragment_unnamed_630, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										precise float fragment_unnamed_663 = clamp(fragment_unnamed_634, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										fragment_unnamed_668 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_662, fragment_unnamed_663), 0.0f).y;
									}
									else
									{
										fragment_unnamed_668 = fragment_unnamed_607;
									}
									precise float fragment_unnamed_669 = (-0.0f) - fragment_unnamed_246;
									uint fragment_unnamed_673 = fragment_unnamed_610 ? asuint(fragment_unnamed_655) : asuint(mad(fragment_unnamed_669, 0.5f, fragment_unnamed_655));
									float fragment_unnamed_674 = asfloat(fragment_unnamed_673);
									precise float fragment_unnamed_675 = (-0.0f) - fragment_unnamed_246;
									float fragment_unnamed_680 = asfloat(fragment_unnamed_611 ? asuint(fragment_unnamed_668) : asuint(mad(fragment_unnamed_675, 0.5f, fragment_unnamed_668)));
									bool fragment_unnamed_683 = abs(fragment_unnamed_674) >= fragment_unnamed_247;
									bool fragment_unnamed_684 = abs(fragment_unnamed_680) >= fragment_unnamed_247;
									uint fragment_unnamed_685 = fragment_unnamed_683 ? 4294967295u : 0u;
									uint fragment_unnamed_686 = fragment_unnamed_684 ? 4294967295u : 0u;
									precise float fragment_unnamed_687 = (-0.0f) - fragment_unnamed_192;
									uint fragment_unnamed_690 = fragment_unnamed_683 ? fragment_unnamed_617 : asuint(mad(fragment_unnamed_687, 2.0f, fragment_unnamed_618));
									float fragment_unnamed_691 = asfloat(fragment_unnamed_690);
									precise float fragment_unnamed_692 = (-0.0f) - fragment_unnamed_198;
									uint fragment_unnamed_695 = fragment_unnamed_683 ? fragment_unnamed_622 : asuint(mad(fragment_unnamed_692, 2.0f, fragment_unnamed_623));
									float fragment_unnamed_696 = asfloat(fragment_unnamed_695);
									uint fragment_unnamed_702 = fragment_unnamed_684 ? fragment_unnamed_629 : asuint(mad(fragment_unnamed_192, 2.0f, fragment_unnamed_630));
									float fragment_unnamed_703 = asfloat(fragment_unnamed_702);
									uint fragment_unnamed_706 = fragment_unnamed_684 ? fragment_unnamed_633 : asuint(mad(fragment_unnamed_198, 2.0f, fragment_unnamed_634));
									float fragment_unnamed_707 = asfloat(fragment_unnamed_706);
									float fragment_unnamed_637;
									float fragment_unnamed_638;
									float fragment_unnamed_639;
									float fragment_unnamed_640;
									float fragment_unnamed_641;
									float fragment_unnamed_642;
									if (((~fragment_unnamed_686) | (~fragment_unnamed_685)) != 0u)
									{
										float fragment_unnamed_728;
										if (fragment_unnamed_685 == 0u)
										{
											precise float fragment_unnamed_721 = clamp(fragment_unnamed_691, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											precise float fragment_unnamed_722 = clamp(fragment_unnamed_696, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											fragment_unnamed_728 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_721, fragment_unnamed_722), 0.0f).y;
										}
										else
										{
											fragment_unnamed_728 = asfloat(fragment_unnamed_673);
										}
										float fragment_unnamed_741;
										if (fragment_unnamed_686 == 0u)
										{
											precise float fragment_unnamed_735 = clamp(fragment_unnamed_703, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											precise float fragment_unnamed_736 = clamp(fragment_unnamed_707, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											fragment_unnamed_741 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_735, fragment_unnamed_736), 0.0f).y;
										}
										else
										{
											fragment_unnamed_741 = fragment_unnamed_680;
										}
										precise float fragment_unnamed_742 = (-0.0f) - fragment_unnamed_246;
										uint fragment_unnamed_746 = fragment_unnamed_683 ? asuint(fragment_unnamed_728) : asuint(mad(fragment_unnamed_742, 0.5f, fragment_unnamed_728));
										float fragment_unnamed_747 = asfloat(fragment_unnamed_746);
										precise float fragment_unnamed_748 = (-0.0f) - fragment_unnamed_246;
										float fragment_unnamed_753 = asfloat(fragment_unnamed_684 ? asuint(fragment_unnamed_741) : asuint(mad(fragment_unnamed_748, 0.5f, fragment_unnamed_741)));
										bool fragment_unnamed_756 = abs(fragment_unnamed_747) >= fragment_unnamed_247;
										bool fragment_unnamed_757 = abs(fragment_unnamed_753) >= fragment_unnamed_247;
										uint fragment_unnamed_758 = fragment_unnamed_756 ? 4294967295u : 0u;
										uint fragment_unnamed_759 = fragment_unnamed_757 ? 4294967295u : 0u;
										precise float fragment_unnamed_760 = (-0.0f) - fragment_unnamed_192;
										uint fragment_unnamed_763 = fragment_unnamed_756 ? fragment_unnamed_690 : asuint(mad(fragment_unnamed_760, 2.0f, fragment_unnamed_691));
										float fragment_unnamed_764 = asfloat(fragment_unnamed_763);
										precise float fragment_unnamed_765 = (-0.0f) - fragment_unnamed_198;
										uint fragment_unnamed_768 = fragment_unnamed_756 ? fragment_unnamed_695 : asuint(mad(fragment_unnamed_765, 2.0f, fragment_unnamed_696));
										float fragment_unnamed_769 = asfloat(fragment_unnamed_768);
										uint fragment_unnamed_775 = fragment_unnamed_757 ? fragment_unnamed_702 : asuint(mad(fragment_unnamed_192, 2.0f, fragment_unnamed_703));
										float fragment_unnamed_776 = asfloat(fragment_unnamed_775);
										uint fragment_unnamed_779 = fragment_unnamed_757 ? fragment_unnamed_706 : asuint(mad(fragment_unnamed_198, 2.0f, fragment_unnamed_707));
										float fragment_unnamed_780 = asfloat(fragment_unnamed_779);
										float fragment_unnamed_710;
										float fragment_unnamed_711;
										float fragment_unnamed_712;
										float fragment_unnamed_713;
										float fragment_unnamed_714;
										float fragment_unnamed_715;
										if (((~fragment_unnamed_759) | (~fragment_unnamed_758)) != 0u)
										{
											float fragment_unnamed_801;
											if (fragment_unnamed_758 == 0u)
											{
												precise float fragment_unnamed_794 = clamp(fragment_unnamed_764, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												precise float fragment_unnamed_795 = clamp(fragment_unnamed_769, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												fragment_unnamed_801 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_794, fragment_unnamed_795), 0.0f).y;
											}
											else
											{
												fragment_unnamed_801 = asfloat(fragment_unnamed_746);
											}
											float fragment_unnamed_814;
											if (fragment_unnamed_759 == 0u)
											{
												precise float fragment_unnamed_808 = clamp(fragment_unnamed_776, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												precise float fragment_unnamed_809 = clamp(fragment_unnamed_780, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												fragment_unnamed_814 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_808, fragment_unnamed_809), 0.0f).y;
											}
											else
											{
												fragment_unnamed_814 = fragment_unnamed_753;
											}
											precise float fragment_unnamed_815 = (-0.0f) - fragment_unnamed_246;
											uint fragment_unnamed_819 = fragment_unnamed_756 ? asuint(fragment_unnamed_801) : asuint(mad(fragment_unnamed_815, 0.5f, fragment_unnamed_801));
											float fragment_unnamed_820 = asfloat(fragment_unnamed_819);
											precise float fragment_unnamed_821 = (-0.0f) - fragment_unnamed_246;
											float fragment_unnamed_826 = asfloat(fragment_unnamed_757 ? asuint(fragment_unnamed_814) : asuint(mad(fragment_unnamed_821, 0.5f, fragment_unnamed_814)));
											bool fragment_unnamed_829 = abs(fragment_unnamed_820) >= fragment_unnamed_247;
											bool fragment_unnamed_830 = abs(fragment_unnamed_826) >= fragment_unnamed_247;
											uint fragment_unnamed_831 = fragment_unnamed_829 ? 4294967295u : 0u;
											uint fragment_unnamed_832 = fragment_unnamed_830 ? 4294967295u : 0u;
											precise float fragment_unnamed_833 = (-0.0f) - fragment_unnamed_192;
											uint fragment_unnamed_836 = fragment_unnamed_829 ? fragment_unnamed_763 : asuint(mad(fragment_unnamed_833, 2.0f, fragment_unnamed_764));
											float fragment_unnamed_837 = asfloat(fragment_unnamed_836);
											precise float fragment_unnamed_838 = (-0.0f) - fragment_unnamed_198;
											uint fragment_unnamed_841 = fragment_unnamed_829 ? fragment_unnamed_768 : asuint(mad(fragment_unnamed_838, 2.0f, fragment_unnamed_769));
											float fragment_unnamed_842 = asfloat(fragment_unnamed_841);
											uint fragment_unnamed_848 = fragment_unnamed_830 ? fragment_unnamed_775 : asuint(mad(fragment_unnamed_192, 2.0f, fragment_unnamed_776));
											float fragment_unnamed_849 = asfloat(fragment_unnamed_848);
											uint fragment_unnamed_852 = fragment_unnamed_830 ? fragment_unnamed_779 : asuint(mad(fragment_unnamed_198, 2.0f, fragment_unnamed_780));
											float fragment_unnamed_853 = asfloat(fragment_unnamed_852);
											float fragment_unnamed_783;
											float fragment_unnamed_784;
											float fragment_unnamed_785;
											float fragment_unnamed_786;
											float fragment_unnamed_787;
											float fragment_unnamed_788;
											if (((~fragment_unnamed_832) | (~fragment_unnamed_831)) != 0u)
											{
												float fragment_unnamed_874;
												if (fragment_unnamed_831 == 0u)
												{
													precise float fragment_unnamed_867 = clamp(fragment_unnamed_837, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													precise float fragment_unnamed_868 = clamp(fragment_unnamed_842, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													fragment_unnamed_874 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_867, fragment_unnamed_868), 0.0f).y;
												}
												else
												{
													fragment_unnamed_874 = asfloat(fragment_unnamed_819);
												}
												float fragment_unnamed_887;
												if (fragment_unnamed_832 == 0u)
												{
													precise float fragment_unnamed_881 = clamp(fragment_unnamed_849, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													precise float fragment_unnamed_882 = clamp(fragment_unnamed_853, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													fragment_unnamed_887 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_881, fragment_unnamed_882), 0.0f).y;
												}
												else
												{
													fragment_unnamed_887 = fragment_unnamed_826;
												}
												precise float fragment_unnamed_888 = (-0.0f) - fragment_unnamed_246;
												uint fragment_unnamed_892 = fragment_unnamed_829 ? asuint(fragment_unnamed_874) : asuint(mad(fragment_unnamed_888, 0.5f, fragment_unnamed_874));
												float fragment_unnamed_893 = asfloat(fragment_unnamed_892);
												precise float fragment_unnamed_894 = (-0.0f) - fragment_unnamed_246;
												float fragment_unnamed_899 = asfloat(fragment_unnamed_830 ? asuint(fragment_unnamed_887) : asuint(mad(fragment_unnamed_894, 0.5f, fragment_unnamed_887)));
												bool fragment_unnamed_902 = abs(fragment_unnamed_893) >= fragment_unnamed_247;
												bool fragment_unnamed_903 = abs(fragment_unnamed_899) >= fragment_unnamed_247;
												uint fragment_unnamed_904 = fragment_unnamed_902 ? 4294967295u : 0u;
												uint fragment_unnamed_905 = fragment_unnamed_903 ? 4294967295u : 0u;
												precise float fragment_unnamed_906 = (-0.0f) - fragment_unnamed_192;
												uint fragment_unnamed_909 = fragment_unnamed_902 ? fragment_unnamed_836 : asuint(mad(fragment_unnamed_906, 2.0f, fragment_unnamed_837));
												float fragment_unnamed_910 = asfloat(fragment_unnamed_909);
												precise float fragment_unnamed_911 = (-0.0f) - fragment_unnamed_198;
												uint fragment_unnamed_914 = fragment_unnamed_902 ? fragment_unnamed_841 : asuint(mad(fragment_unnamed_911, 2.0f, fragment_unnamed_842));
												float fragment_unnamed_915 = asfloat(fragment_unnamed_914);
												uint fragment_unnamed_921 = fragment_unnamed_903 ? fragment_unnamed_848 : asuint(mad(fragment_unnamed_192, 2.0f, fragment_unnamed_849));
												float fragment_unnamed_922 = asfloat(fragment_unnamed_921);
												uint fragment_unnamed_925 = fragment_unnamed_903 ? fragment_unnamed_852 : asuint(mad(fragment_unnamed_198, 2.0f, fragment_unnamed_853));
												float fragment_unnamed_926 = asfloat(fragment_unnamed_925);
												float fragment_unnamed_856;
												float fragment_unnamed_857;
												float fragment_unnamed_858;
												float fragment_unnamed_859;
												float fragment_unnamed_860;
												float fragment_unnamed_861;
												if (((~fragment_unnamed_905) | (~fragment_unnamed_904)) != 0u)
												{
													float fragment_unnamed_947;
													if (fragment_unnamed_904 == 0u)
													{
														precise float fragment_unnamed_940 = clamp(fragment_unnamed_910, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														precise float fragment_unnamed_941 = clamp(fragment_unnamed_915, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														fragment_unnamed_947 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_940, fragment_unnamed_941), 0.0f).y;
													}
													else
													{
														fragment_unnamed_947 = asfloat(fragment_unnamed_892);
													}
													float fragment_unnamed_960;
													if (fragment_unnamed_905 == 0u)
													{
														precise float fragment_unnamed_954 = clamp(fragment_unnamed_922, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														precise float fragment_unnamed_955 = clamp(fragment_unnamed_926, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														fragment_unnamed_960 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_954, fragment_unnamed_955), 0.0f).y;
													}
													else
													{
														fragment_unnamed_960 = fragment_unnamed_899;
													}
													precise float fragment_unnamed_961 = (-0.0f) - fragment_unnamed_246;
													uint fragment_unnamed_965 = fragment_unnamed_902 ? asuint(fragment_unnamed_947) : asuint(mad(fragment_unnamed_961, 0.5f, fragment_unnamed_947));
													float fragment_unnamed_966 = asfloat(fragment_unnamed_965);
													precise float fragment_unnamed_967 = (-0.0f) - fragment_unnamed_246;
													float fragment_unnamed_972 = asfloat(fragment_unnamed_903 ? asuint(fragment_unnamed_960) : asuint(mad(fragment_unnamed_967, 0.5f, fragment_unnamed_960)));
													bool fragment_unnamed_975 = abs(fragment_unnamed_966) >= fragment_unnamed_247;
													bool fragment_unnamed_976 = abs(fragment_unnamed_972) >= fragment_unnamed_247;
													uint fragment_unnamed_977 = fragment_unnamed_975 ? 4294967295u : 0u;
													uint fragment_unnamed_978 = fragment_unnamed_976 ? 4294967295u : 0u;
													precise float fragment_unnamed_979 = (-0.0f) - fragment_unnamed_192;
													uint fragment_unnamed_983 = fragment_unnamed_975 ? fragment_unnamed_909 : asuint(mad(fragment_unnamed_979, 4.0f, fragment_unnamed_910));
													float fragment_unnamed_984 = asfloat(fragment_unnamed_983);
													precise float fragment_unnamed_985 = (-0.0f) - fragment_unnamed_198;
													uint fragment_unnamed_988 = fragment_unnamed_975 ? fragment_unnamed_914 : asuint(mad(fragment_unnamed_985, 4.0f, fragment_unnamed_915));
													float fragment_unnamed_989 = asfloat(fragment_unnamed_988);
													uint fragment_unnamed_995 = fragment_unnamed_976 ? fragment_unnamed_921 : asuint(mad(fragment_unnamed_192, 4.0f, fragment_unnamed_922));
													float fragment_unnamed_996 = asfloat(fragment_unnamed_995);
													uint fragment_unnamed_999 = fragment_unnamed_976 ? fragment_unnamed_925 : asuint(mad(fragment_unnamed_198, 4.0f, fragment_unnamed_926));
													float fragment_unnamed_1000 = asfloat(fragment_unnamed_999);
													float fragment_unnamed_929;
													float fragment_unnamed_930;
													float fragment_unnamed_931;
													float fragment_unnamed_932;
													float fragment_unnamed_933;
													float fragment_unnamed_934;
													if (((~fragment_unnamed_978) | (~fragment_unnamed_977)) != 0u)
													{
														float fragment_unnamed_1021;
														if (fragment_unnamed_977 == 0u)
														{
															precise float fragment_unnamed_1014 = clamp(fragment_unnamed_984, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															precise float fragment_unnamed_1015 = clamp(fragment_unnamed_989, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															fragment_unnamed_1021 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_1014, fragment_unnamed_1015), 0.0f).y;
														}
														else
														{
															fragment_unnamed_1021 = asfloat(fragment_unnamed_965);
														}
														float fragment_unnamed_1034;
														if (fragment_unnamed_978 == 0u)
														{
															precise float fragment_unnamed_1028 = clamp(fragment_unnamed_996, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															precise float fragment_unnamed_1029 = clamp(fragment_unnamed_1000, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															fragment_unnamed_1034 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_1028, fragment_unnamed_1029), 0.0f).y;
														}
														else
														{
															fragment_unnamed_1034 = fragment_unnamed_972;
														}
														precise float fragment_unnamed_1035 = (-0.0f) - fragment_unnamed_246;
														float fragment_unnamed_1004 = asfloat(fragment_unnamed_975 ? asuint(fragment_unnamed_1021) : asuint(mad(fragment_unnamed_1035, 0.5f, fragment_unnamed_1021)));
														precise float fragment_unnamed_1040 = (-0.0f) - fragment_unnamed_246;
														float fragment_unnamed_1003 = asfloat(fragment_unnamed_976 ? asuint(fragment_unnamed_1034) : asuint(mad(fragment_unnamed_1040, 0.5f, fragment_unnamed_1034)));
														bool fragment_unnamed_1047 = abs(fragment_unnamed_1004) >= fragment_unnamed_247;
														bool fragment_unnamed_1048 = abs(fragment_unnamed_1003) >= fragment_unnamed_247;
														precise float fragment_unnamed_1049 = (-0.0f) - fragment_unnamed_192;
														precise float fragment_unnamed_1054 = (-0.0f) - fragment_unnamed_198;
														fragment_unnamed_929 = fragment_unnamed_1003;
														fragment_unnamed_930 = fragment_unnamed_1004;
														fragment_unnamed_931 = asfloat(fragment_unnamed_1047 ? fragment_unnamed_983 : asuint(mad(fragment_unnamed_1049, 8.0f, fragment_unnamed_984)));
														fragment_unnamed_932 = asfloat(fragment_unnamed_1047 ? fragment_unnamed_988 : asuint(mad(fragment_unnamed_1054, 8.0f, fragment_unnamed_989)));
														fragment_unnamed_933 = asfloat(fragment_unnamed_1048 ? fragment_unnamed_995 : asuint(mad(fragment_unnamed_192, 8.0f, fragment_unnamed_996)));
														fragment_unnamed_934 = asfloat(fragment_unnamed_1048 ? fragment_unnamed_999 : asuint(mad(fragment_unnamed_198, 8.0f, fragment_unnamed_1000)));
													}
													else
													{
														fragment_unnamed_929 = fragment_unnamed_972;
														fragment_unnamed_930 = fragment_unnamed_966;
														fragment_unnamed_931 = fragment_unnamed_984;
														fragment_unnamed_932 = fragment_unnamed_989;
														fragment_unnamed_933 = fragment_unnamed_996;
														fragment_unnamed_934 = fragment_unnamed_1000;
													}
													fragment_unnamed_856 = fragment_unnamed_929;
													fragment_unnamed_857 = fragment_unnamed_930;
													fragment_unnamed_858 = fragment_unnamed_931;
													fragment_unnamed_859 = fragment_unnamed_932;
													fragment_unnamed_860 = fragment_unnamed_933;
													fragment_unnamed_861 = fragment_unnamed_934;
												}
												else
												{
													fragment_unnamed_856 = fragment_unnamed_899;
													fragment_unnamed_857 = fragment_unnamed_893;
													fragment_unnamed_858 = fragment_unnamed_910;
													fragment_unnamed_859 = fragment_unnamed_915;
													fragment_unnamed_860 = fragment_unnamed_922;
													fragment_unnamed_861 = fragment_unnamed_926;
												}
												fragment_unnamed_783 = fragment_unnamed_856;
												fragment_unnamed_784 = fragment_unnamed_857;
												fragment_unnamed_785 = fragment_unnamed_858;
												fragment_unnamed_786 = fragment_unnamed_859;
												fragment_unnamed_787 = fragment_unnamed_860;
												fragment_unnamed_788 = fragment_unnamed_861;
											}
											else
											{
												fragment_unnamed_783 = fragment_unnamed_826;
												fragment_unnamed_784 = fragment_unnamed_820;
												fragment_unnamed_785 = fragment_unnamed_837;
												fragment_unnamed_786 = fragment_unnamed_842;
												fragment_unnamed_787 = fragment_unnamed_849;
												fragment_unnamed_788 = fragment_unnamed_853;
											}
											fragment_unnamed_710 = fragment_unnamed_783;
											fragment_unnamed_711 = fragment_unnamed_784;
											fragment_unnamed_712 = fragment_unnamed_785;
											fragment_unnamed_713 = fragment_unnamed_786;
											fragment_unnamed_714 = fragment_unnamed_787;
											fragment_unnamed_715 = fragment_unnamed_788;
										}
										else
										{
											fragment_unnamed_710 = fragment_unnamed_753;
											fragment_unnamed_711 = fragment_unnamed_747;
											fragment_unnamed_712 = fragment_unnamed_764;
											fragment_unnamed_713 = fragment_unnamed_769;
											fragment_unnamed_714 = fragment_unnamed_776;
											fragment_unnamed_715 = fragment_unnamed_780;
										}
										fragment_unnamed_637 = fragment_unnamed_710;
										fragment_unnamed_638 = fragment_unnamed_711;
										fragment_unnamed_639 = fragment_unnamed_712;
										fragment_unnamed_640 = fragment_unnamed_713;
										fragment_unnamed_641 = fragment_unnamed_714;
										fragment_unnamed_642 = fragment_unnamed_715;
									}
									else
									{
										fragment_unnamed_637 = fragment_unnamed_680;
										fragment_unnamed_638 = fragment_unnamed_674;
										fragment_unnamed_639 = fragment_unnamed_691;
										fragment_unnamed_640 = fragment_unnamed_696;
										fragment_unnamed_641 = fragment_unnamed_703;
										fragment_unnamed_642 = fragment_unnamed_707;
									}
									fragment_unnamed_564 = fragment_unnamed_637;
									fragment_unnamed_565 = fragment_unnamed_638;
									fragment_unnamed_566 = fragment_unnamed_639;
									fragment_unnamed_567 = fragment_unnamed_640;
									fragment_unnamed_568 = fragment_unnamed_641;
									fragment_unnamed_569 = fragment_unnamed_642;
								}
								else
								{
									fragment_unnamed_564 = fragment_unnamed_607;
									fragment_unnamed_565 = fragment_unnamed_601;
									fragment_unnamed_566 = fragment_unnamed_618;
									fragment_unnamed_567 = fragment_unnamed_623;
									fragment_unnamed_568 = fragment_unnamed_630;
									fragment_unnamed_569 = fragment_unnamed_634;
								}
								fragment_unnamed_491 = fragment_unnamed_564;
								fragment_unnamed_492 = fragment_unnamed_565;
								fragment_unnamed_493 = fragment_unnamed_566;
								fragment_unnamed_494 = fragment_unnamed_567;
								fragment_unnamed_495 = fragment_unnamed_568;
								fragment_unnamed_496 = fragment_unnamed_569;
							}
							else
							{
								fragment_unnamed_491 = fragment_unnamed_534;
								fragment_unnamed_492 = fragment_unnamed_528;
								fragment_unnamed_493 = fragment_unnamed_545;
								fragment_unnamed_494 = fragment_unnamed_550;
								fragment_unnamed_495 = fragment_unnamed_557;
								fragment_unnamed_496 = fragment_unnamed_561;
							}
							fragment_unnamed_348 = fragment_unnamed_491;
							fragment_unnamed_350 = fragment_unnamed_492;
							fragment_unnamed_352 = fragment_unnamed_493;
							fragment_unnamed_354 = fragment_unnamed_494;
							fragment_unnamed_356 = fragment_unnamed_495;
							fragment_unnamed_358 = fragment_unnamed_496;
						}
						else
						{
							fragment_unnamed_348 = fragment_unnamed_461;
							fragment_unnamed_350 = fragment_unnamed_455;
							fragment_unnamed_352 = fragment_unnamed_472;
							fragment_unnamed_354 = fragment_unnamed_477;
							fragment_unnamed_356 = fragment_unnamed_484;
							fragment_unnamed_358 = fragment_unnamed_488;
						}
						fragment_unnamed_347 = fragment_unnamed_348;
						fragment_unnamed_349 = fragment_unnamed_350;
						fragment_unnamed_351 = fragment_unnamed_352;
						fragment_unnamed_353 = fragment_unnamed_354;
						fragment_unnamed_355 = fragment_unnamed_356;
						fragment_unnamed_357 = fragment_unnamed_358;
					}
					else
					{
						fragment_unnamed_347 = fragment_unnamed_257;
						fragment_unnamed_349 = fragment_unnamed_255;
						fragment_unnamed_351 = fragment_unnamed_269;
						fragment_unnamed_353 = fragment_unnamed_274;
						fragment_unnamed_355 = fragment_unnamed_282;
						fragment_unnamed_357 = fragment_unnamed_287;
					}
					precise float fragment_unnamed_359 = (-0.0f) - fragment_unnamed_351;
					precise float fragment_unnamed_362 = fragment_unnamed_359 + fragment_input_1.x;
					precise float fragment_unnamed_365 = (-0.0f) - fragment_input_1.x;
					precise float fragment_unnamed_366 = fragment_unnamed_355 + fragment_unnamed_365;
					precise float fragment_unnamed_367 = (-0.0f) - fragment_unnamed_353;
					precise float fragment_unnamed_370 = fragment_unnamed_367 + fragment_input_1.y;
					float fragment_unnamed_374 = asfloat(fragment_unnamed_144 ? asuint(fragment_unnamed_362) : asuint(fragment_unnamed_370));
					precise float fragment_unnamed_377 = (-0.0f) - fragment_input_1.y;
					precise float fragment_unnamed_378 = fragment_unnamed_357 + fragment_unnamed_377;
					float fragment_unnamed_382 = asfloat(fragment_unnamed_144 ? asuint(fragment_unnamed_366) : asuint(fragment_unnamed_378));
					precise float fragment_unnamed_387 = fragment_unnamed_374 + fragment_unnamed_382;
					precise float fragment_unnamed_392 = 1.0f / fragment_unnamed_387;
					precise float fragment_unnamed_396 = fragment_unnamed_251 * fragment_unnamed_251;
					precise float fragment_unnamed_397 = (-0.0f) - fragment_unnamed_392;
					float fragment_unnamed_402 = max(fragment_unnamed_396, asfloat(asuint(mad(min(fragment_unnamed_382, fragment_unnamed_374), fragment_unnamed_397, 0.5f)) & ((fragment_unnamed_374 < fragment_unnamed_382) ? ((fragment_unnamed_253 != ((fragment_unnamed_349 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_253 != ((fragment_unnamed_347 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					precise float fragment_unnamed_420 = clamp(fragment_unnamed_144 ? fragment_input_1.x : mad(fragment_unnamed_402, fragment_unnamed_183, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_421 = clamp(fragment_unnamed_144 ? mad(fragment_unnamed_402, fragment_unnamed_183, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float4 fragment_unnamed_423 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_420, fragment_unnamed_421), 0.0f);
					fragment_unnamed_289 = fragment_unnamed_423.z;
					fragment_unnamed_291 = fragment_unnamed_423.y;
					fragment_unnamed_293 = fragment_unnamed_423.x;
				}
				else
				{
					fragment_unnamed_289 = fragment_unnamed_56.z;
					fragment_unnamed_291 = fragment_unnamed_59;
					fragment_unnamed_293 = fragment_unnamed_56.x;
				}
				float fragment_unnamed_322 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				precise float fragment_unnamed_329 = (-0.0f) - abs(fragment_unnamed_322);
				precise float fragment_unnamed_330 = fragment_unnamed_329 + 1.0f;
				precise float fragment_unnamed_332 = (-0.0f) - sqrt(fragment_unnamed_330);
				precise float fragment_unnamed_333 = fragment_unnamed_332 + 1.0f;
				precise float fragment_unnamed_334 = fragment_unnamed_333 * mad(clamp(mad(fragment_unnamed_322, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_334, 0.0039215688593685626983642578125f, fragment_unnamed_293);
				fragment_output_0.y = mad(fragment_unnamed_334, 0.0039215688593685626983642578125f, fragment_unnamed_291);
				fragment_output_0.z = mad(fragment_unnamed_334, 0.0039215688593685626983642578125f, fragment_unnamed_289);
				fragment_output_0.w = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[29] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA) && defined(FXAA_KEEP_ALPHA) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_LOW)


			#if defined(FXAA) && defined(FXAA_KEEP_ALPHA) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA_LOW)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;
			float4 _PosScaleOffset;

			static float4 vertex_uniform_buffer_0[29];
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
				gl_Position.x = mad(vertex_input_0.x, vertex_uniform_buffer_0[28u].x, vertex_uniform_buffer_0[28u].z);
				gl_Position.y = mad(vertex_input_0.y, vertex_uniform_buffer_0[28u].y, vertex_uniform_buffer_0[28u].w);
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_55 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_56 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_62 = vertex_unnamed_55 * vertex_uniform_buffer_0[27u].x;
				precise float vertex_unnamed_63 = vertex_unnamed_56 * vertex_uniform_buffer_0[27u].y;
				float vertex_unnamed_68 = mad(vertex_unnamed_62, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_70 = mad(vertex_unnamed_63, 0.5f, vertex_uniform_buffer_0[27u].w);
				precise float vertex_unnamed_75 = vertex_unnamed_68 * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_76 = vertex_unnamed_70 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_75;
				vertex_output_1.y = vertex_unnamed_76;
				vertex_output_1.x = vertex_unnamed_68;
				vertex_output_1.y = vertex_unnamed_70;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_uniform_buffer_0[28] = float4(_PosScaleOffset[0], _PosScaleOffset[1], _PosScaleOffset[2], _PosScaleOffset[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[31];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				precise float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f);
				float fragment_unnamed_57 = fragment_unnamed_54.y;
				float4 fragment_unnamed_62 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, 1));
				float fragment_unnamed_66 = fragment_unnamed_62.y;
				float4 fragment_unnamed_67 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 0));
				float fragment_unnamed_70 = fragment_unnamed_67.y;
				float4 fragment_unnamed_72 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, -1));
				float fragment_unnamed_75 = fragment_unnamed_72.y;
				float4 fragment_unnamed_77 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 0));
				float fragment_unnamed_80 = fragment_unnamed_77.y;
				float fragment_unnamed_87 = max(max(max(fragment_unnamed_57, fragment_unnamed_66), fragment_unnamed_70), max(fragment_unnamed_75, fragment_unnamed_80));
				precise float fragment_unnamed_89 = fragment_unnamed_87 * 0.063000001013278961181640625f;
				precise float fragment_unnamed_91 = (-0.0f) - min(min(min(fragment_unnamed_57, fragment_unnamed_66), fragment_unnamed_70), min(fragment_unnamed_75, fragment_unnamed_80));
				precise float fragment_unnamed_93 = fragment_unnamed_91 + fragment_unnamed_87;
				float fragment_unnamed_287;
				float fragment_unnamed_289;
				float fragment_unnamed_291;
				if (fragment_unnamed_93 >= max(fragment_unnamed_89, 0.031199999153614044189453125f))
				{
					float4 fragment_unnamed_99 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, -1));
					float fragment_unnamed_102 = fragment_unnamed_99.y;
					float4 fragment_unnamed_103 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 1));
					float fragment_unnamed_106 = fragment_unnamed_103.y;
					float4 fragment_unnamed_107 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, -1));
					float fragment_unnamed_110 = fragment_unnamed_107.y;
					float4 fragment_unnamed_111 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 1));
					float fragment_unnamed_114 = fragment_unnamed_111.y;
					precise float fragment_unnamed_115 = fragment_unnamed_66 + fragment_unnamed_75;
					precise float fragment_unnamed_116 = fragment_unnamed_70 + fragment_unnamed_80;
					precise float fragment_unnamed_117 = 1.0f / fragment_unnamed_93;
					precise float fragment_unnamed_118 = fragment_unnamed_116 + fragment_unnamed_115;
					precise float fragment_unnamed_122 = fragment_unnamed_106 + fragment_unnamed_110;
					precise float fragment_unnamed_123 = fragment_unnamed_102 + fragment_unnamed_110;
					precise float fragment_unnamed_126 = fragment_unnamed_102 + fragment_unnamed_114;
					precise float fragment_unnamed_127 = fragment_unnamed_106 + fragment_unnamed_114;
					precise float fragment_unnamed_139 = mad(abs(mad(fragment_unnamed_57, -2.0f, fragment_unnamed_115)), 2.0f, abs(mad(fragment_unnamed_70, -2.0f, fragment_unnamed_122))) + abs(mad(fragment_unnamed_80, -2.0f, fragment_unnamed_126));
					precise float fragment_unnamed_140 = mad(abs(mad(fragment_unnamed_57, -2.0f, fragment_unnamed_116)), 2.0f, abs(mad(fragment_unnamed_75, -2.0f, fragment_unnamed_123))) + abs(mad(fragment_unnamed_66, -2.0f, fragment_unnamed_127));
					precise float fragment_unnamed_141 = fragment_unnamed_122 + fragment_unnamed_126;
					bool fragment_unnamed_142 = fragment_unnamed_139 >= fragment_unnamed_140;
					float fragment_unnamed_148 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_75) : asuint(fragment_unnamed_80));
					float fragment_unnamed_152 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_66) : asuint(fragment_unnamed_70));
					float fragment_unnamed_164 = asfloat(fragment_unnamed_142 ? asuint(fragment_uniform_buffer_0[30u]).y : asuint(fragment_uniform_buffer_0[30u]).x);
					precise float fragment_unnamed_165 = (-0.0f) - fragment_unnamed_57;
					precise float fragment_unnamed_168 = (-0.0f) - fragment_unnamed_57;
					precise float fragment_unnamed_169 = fragment_unnamed_168 + fragment_unnamed_148;
					precise float fragment_unnamed_170 = (-0.0f) - fragment_unnamed_57;
					precise float fragment_unnamed_171 = fragment_unnamed_170 + fragment_unnamed_152;
					precise float fragment_unnamed_172 = fragment_unnamed_57 + fragment_unnamed_148;
					precise float fragment_unnamed_173 = fragment_unnamed_57 + fragment_unnamed_152;
					bool fragment_unnamed_176 = abs(fragment_unnamed_169) >= abs(fragment_unnamed_171);
					precise float fragment_unnamed_180 = (-0.0f) - fragment_unnamed_164;
					float fragment_unnamed_181 = fragment_unnamed_176 ? fragment_unnamed_180 : fragment_unnamed_164;
					precise float fragment_unnamed_183 = fragment_unnamed_117 * abs(mad(mad(fragment_unnamed_118, 2.0f, fragment_unnamed_141), 0.083333335816860198974609375f, fragment_unnamed_165));
					float fragment_unnamed_184 = clamp(fragment_unnamed_183, 0.0f, 1.0f);
					float fragment_unnamed_190 = asfloat((fragment_unnamed_142 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[30u]).x);
					float fragment_unnamed_196 = asfloat(fragment_unnamed_142 ? 0u : asuint(fragment_uniform_buffer_0[30u]).y);
					float fragment_unnamed_206 = fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_181, 0.5f, fragment_input_1.x);
					float fragment_unnamed_209 = fragment_unnamed_142 ? mad(fragment_unnamed_181, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					precise float fragment_unnamed_210 = (-0.0f) - fragment_unnamed_190;
					precise float fragment_unnamed_211 = fragment_unnamed_210 + fragment_unnamed_206;
					precise float fragment_unnamed_213 = (-0.0f) - fragment_unnamed_196;
					precise float fragment_unnamed_214 = fragment_unnamed_213 + fragment_unnamed_209;
					precise float fragment_unnamed_216 = fragment_unnamed_190 + fragment_unnamed_206;
					precise float fragment_unnamed_217 = fragment_unnamed_196 + fragment_unnamed_209;
					precise float fragment_unnamed_225 = clamp(fragment_unnamed_211, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_226 = clamp(fragment_unnamed_214, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_230 = fragment_unnamed_184 * fragment_unnamed_184;
					precise float fragment_unnamed_236 = clamp(fragment_unnamed_216, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_237 = clamp(fragment_unnamed_217, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float fragment_unnamed_244 = asfloat(fragment_unnamed_176 ? asuint(fragment_unnamed_172) : asuint(fragment_unnamed_173));
					precise float fragment_unnamed_245 = max(abs(fragment_unnamed_171), abs(fragment_unnamed_169)) * 0.25f;
					precise float fragment_unnamed_247 = (-0.0f) - fragment_unnamed_244;
					precise float fragment_unnamed_249 = fragment_unnamed_230 * mad(fragment_unnamed_184, -2.0f, 3.0f);
					uint fragment_unnamed_251 = (mad(fragment_unnamed_247, 0.5f, fragment_unnamed_57) < 0.0f) ? 4294967295u : 0u;
					precise float fragment_unnamed_252 = (-0.0f) - fragment_unnamed_244;
					float fragment_unnamed_253 = mad(fragment_unnamed_252, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_225, fragment_unnamed_226), 0.0f).y);
					precise float fragment_unnamed_254 = (-0.0f) - fragment_unnamed_244;
					float fragment_unnamed_255 = mad(fragment_unnamed_254, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_236, fragment_unnamed_237), 0.0f).y);
					bool fragment_unnamed_258 = abs(fragment_unnamed_253) >= fragment_unnamed_245;
					bool fragment_unnamed_259 = abs(fragment_unnamed_255) >= fragment_unnamed_245;
					uint fragment_unnamed_260 = fragment_unnamed_258 ? 4294967295u : 0u;
					uint fragment_unnamed_261 = fragment_unnamed_259 ? 4294967295u : 0u;
					precise float fragment_unnamed_262 = (-0.0f) - fragment_unnamed_190;
					uint fragment_unnamed_266 = fragment_unnamed_258 ? asuint(fragment_unnamed_211) : asuint(mad(fragment_unnamed_262, 1.5f, fragment_unnamed_211));
					float fragment_unnamed_267 = asfloat(fragment_unnamed_266);
					precise float fragment_unnamed_268 = (-0.0f) - fragment_unnamed_196;
					uint fragment_unnamed_271 = fragment_unnamed_258 ? asuint(fragment_unnamed_214) : asuint(mad(fragment_unnamed_268, 1.5f, fragment_unnamed_214));
					float fragment_unnamed_272 = asfloat(fragment_unnamed_271);
					uint fragment_unnamed_279 = fragment_unnamed_259 ? asuint(fragment_unnamed_216) : asuint(mad(fragment_unnamed_190, 1.5f, fragment_unnamed_216));
					float fragment_unnamed_280 = asfloat(fragment_unnamed_279);
					uint fragment_unnamed_284 = fragment_unnamed_259 ? asuint(fragment_unnamed_217) : asuint(mad(fragment_unnamed_196, 1.5f, fragment_unnamed_217));
					float fragment_unnamed_285 = asfloat(fragment_unnamed_284);
					float fragment_unnamed_345;
					float fragment_unnamed_347;
					float fragment_unnamed_349;
					float fragment_unnamed_351;
					float fragment_unnamed_353;
					float fragment_unnamed_355;
					if (((~fragment_unnamed_261) | (~fragment_unnamed_260)) != 0u)
					{
						float fragment_unnamed_434;
						if (fragment_unnamed_260 == 0u)
						{
							precise float fragment_unnamed_428 = clamp(fragment_unnamed_267, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_429 = clamp(fragment_unnamed_272, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_434 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_428, fragment_unnamed_429), 0.0f).y;
						}
						else
						{
							fragment_unnamed_434 = fragment_unnamed_253;
						}
						float fragment_unnamed_447;
						if (fragment_unnamed_261 == 0u)
						{
							precise float fragment_unnamed_441 = clamp(fragment_unnamed_280, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_442 = clamp(fragment_unnamed_285, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_447 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_441, fragment_unnamed_442), 0.0f).y;
						}
						else
						{
							fragment_unnamed_447 = fragment_unnamed_255;
						}
						precise float fragment_unnamed_448 = (-0.0f) - fragment_unnamed_244;
						uint fragment_unnamed_452 = fragment_unnamed_258 ? asuint(fragment_unnamed_434) : asuint(mad(fragment_unnamed_448, 0.5f, fragment_unnamed_434));
						float fragment_unnamed_453 = asfloat(fragment_unnamed_452);
						precise float fragment_unnamed_454 = (-0.0f) - fragment_unnamed_244;
						float fragment_unnamed_459 = asfloat(fragment_unnamed_259 ? asuint(fragment_unnamed_447) : asuint(mad(fragment_unnamed_454, 0.5f, fragment_unnamed_447)));
						bool fragment_unnamed_462 = abs(fragment_unnamed_453) >= fragment_unnamed_245;
						bool fragment_unnamed_463 = abs(fragment_unnamed_459) >= fragment_unnamed_245;
						uint fragment_unnamed_464 = fragment_unnamed_462 ? 4294967295u : 0u;
						uint fragment_unnamed_465 = fragment_unnamed_463 ? 4294967295u : 0u;
						precise float fragment_unnamed_466 = (-0.0f) - fragment_unnamed_190;
						uint fragment_unnamed_469 = fragment_unnamed_462 ? fragment_unnamed_266 : asuint(mad(fragment_unnamed_466, 2.0f, fragment_unnamed_267));
						float fragment_unnamed_470 = asfloat(fragment_unnamed_469);
						precise float fragment_unnamed_471 = (-0.0f) - fragment_unnamed_196;
						uint fragment_unnamed_474 = fragment_unnamed_462 ? fragment_unnamed_271 : asuint(mad(fragment_unnamed_471, 2.0f, fragment_unnamed_272));
						float fragment_unnamed_475 = asfloat(fragment_unnamed_474);
						uint fragment_unnamed_481 = fragment_unnamed_463 ? fragment_unnamed_279 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_280));
						float fragment_unnamed_482 = asfloat(fragment_unnamed_481);
						uint fragment_unnamed_485 = fragment_unnamed_463 ? fragment_unnamed_284 : asuint(mad(fragment_unnamed_196, 2.0f, fragment_unnamed_285));
						float fragment_unnamed_486 = asfloat(fragment_unnamed_485);
						float fragment_unnamed_346;
						float fragment_unnamed_348;
						float fragment_unnamed_350;
						float fragment_unnamed_352;
						float fragment_unnamed_354;
						float fragment_unnamed_356;
						if (((~fragment_unnamed_465) | (~fragment_unnamed_464)) != 0u)
						{
							float fragment_unnamed_507;
							if (fragment_unnamed_464 == 0u)
							{
								precise float fragment_unnamed_500 = clamp(fragment_unnamed_470, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_501 = clamp(fragment_unnamed_475, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_507 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_500, fragment_unnamed_501), 0.0f).y;
							}
							else
							{
								fragment_unnamed_507 = asfloat(fragment_unnamed_452);
							}
							float fragment_unnamed_520;
							if (fragment_unnamed_465 == 0u)
							{
								precise float fragment_unnamed_514 = clamp(fragment_unnamed_482, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_515 = clamp(fragment_unnamed_486, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_520 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_514, fragment_unnamed_515), 0.0f).y;
							}
							else
							{
								fragment_unnamed_520 = fragment_unnamed_459;
							}
							precise float fragment_unnamed_521 = (-0.0f) - fragment_unnamed_244;
							uint fragment_unnamed_525 = fragment_unnamed_462 ? asuint(fragment_unnamed_507) : asuint(mad(fragment_unnamed_521, 0.5f, fragment_unnamed_507));
							float fragment_unnamed_526 = asfloat(fragment_unnamed_525);
							precise float fragment_unnamed_527 = (-0.0f) - fragment_unnamed_244;
							float fragment_unnamed_532 = asfloat(fragment_unnamed_463 ? asuint(fragment_unnamed_520) : asuint(mad(fragment_unnamed_527, 0.5f, fragment_unnamed_520)));
							bool fragment_unnamed_535 = abs(fragment_unnamed_526) >= fragment_unnamed_245;
							bool fragment_unnamed_536 = abs(fragment_unnamed_532) >= fragment_unnamed_245;
							uint fragment_unnamed_537 = fragment_unnamed_535 ? 4294967295u : 0u;
							uint fragment_unnamed_538 = fragment_unnamed_536 ? 4294967295u : 0u;
							precise float fragment_unnamed_539 = (-0.0f) - fragment_unnamed_190;
							uint fragment_unnamed_542 = fragment_unnamed_535 ? fragment_unnamed_469 : asuint(mad(fragment_unnamed_539, 2.0f, fragment_unnamed_470));
							float fragment_unnamed_543 = asfloat(fragment_unnamed_542);
							precise float fragment_unnamed_544 = (-0.0f) - fragment_unnamed_196;
							uint fragment_unnamed_547 = fragment_unnamed_535 ? fragment_unnamed_474 : asuint(mad(fragment_unnamed_544, 2.0f, fragment_unnamed_475));
							float fragment_unnamed_548 = asfloat(fragment_unnamed_547);
							uint fragment_unnamed_554 = fragment_unnamed_536 ? fragment_unnamed_481 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_482));
							float fragment_unnamed_555 = asfloat(fragment_unnamed_554);
							uint fragment_unnamed_558 = fragment_unnamed_536 ? fragment_unnamed_485 : asuint(mad(fragment_unnamed_196, 2.0f, fragment_unnamed_486));
							float fragment_unnamed_559 = asfloat(fragment_unnamed_558);
							float fragment_unnamed_489;
							float fragment_unnamed_490;
							float fragment_unnamed_491;
							float fragment_unnamed_492;
							float fragment_unnamed_493;
							float fragment_unnamed_494;
							if (((~fragment_unnamed_538) | (~fragment_unnamed_537)) != 0u)
							{
								float fragment_unnamed_580;
								if (fragment_unnamed_537 == 0u)
								{
									precise float fragment_unnamed_573 = clamp(fragment_unnamed_543, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_574 = clamp(fragment_unnamed_548, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_580 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_573, fragment_unnamed_574), 0.0f).y;
								}
								else
								{
									fragment_unnamed_580 = asfloat(fragment_unnamed_525);
								}
								float fragment_unnamed_593;
								if (fragment_unnamed_538 == 0u)
								{
									precise float fragment_unnamed_587 = clamp(fragment_unnamed_555, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_588 = clamp(fragment_unnamed_559, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_593 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_587, fragment_unnamed_588), 0.0f).y;
								}
								else
								{
									fragment_unnamed_593 = fragment_unnamed_532;
								}
								precise float fragment_unnamed_594 = (-0.0f) - fragment_unnamed_244;
								uint fragment_unnamed_598 = fragment_unnamed_535 ? asuint(fragment_unnamed_580) : asuint(mad(fragment_unnamed_594, 0.5f, fragment_unnamed_580));
								float fragment_unnamed_599 = asfloat(fragment_unnamed_598);
								precise float fragment_unnamed_600 = (-0.0f) - fragment_unnamed_244;
								float fragment_unnamed_605 = asfloat(fragment_unnamed_536 ? asuint(fragment_unnamed_593) : asuint(mad(fragment_unnamed_600, 0.5f, fragment_unnamed_593)));
								bool fragment_unnamed_608 = abs(fragment_unnamed_599) >= fragment_unnamed_245;
								bool fragment_unnamed_609 = abs(fragment_unnamed_605) >= fragment_unnamed_245;
								uint fragment_unnamed_610 = fragment_unnamed_608 ? 4294967295u : 0u;
								uint fragment_unnamed_611 = fragment_unnamed_609 ? 4294967295u : 0u;
								precise float fragment_unnamed_612 = (-0.0f) - fragment_unnamed_190;
								uint fragment_unnamed_615 = fragment_unnamed_608 ? fragment_unnamed_542 : asuint(mad(fragment_unnamed_612, 2.0f, fragment_unnamed_543));
								float fragment_unnamed_616 = asfloat(fragment_unnamed_615);
								precise float fragment_unnamed_617 = (-0.0f) - fragment_unnamed_196;
								uint fragment_unnamed_620 = fragment_unnamed_608 ? fragment_unnamed_547 : asuint(mad(fragment_unnamed_617, 2.0f, fragment_unnamed_548));
								float fragment_unnamed_621 = asfloat(fragment_unnamed_620);
								uint fragment_unnamed_627 = fragment_unnamed_609 ? fragment_unnamed_554 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_555));
								float fragment_unnamed_628 = asfloat(fragment_unnamed_627);
								uint fragment_unnamed_631 = fragment_unnamed_609 ? fragment_unnamed_558 : asuint(mad(fragment_unnamed_196, 2.0f, fragment_unnamed_559));
								float fragment_unnamed_632 = asfloat(fragment_unnamed_631);
								float fragment_unnamed_562;
								float fragment_unnamed_563;
								float fragment_unnamed_564;
								float fragment_unnamed_565;
								float fragment_unnamed_566;
								float fragment_unnamed_567;
								if (((~fragment_unnamed_611) | (~fragment_unnamed_610)) != 0u)
								{
									float fragment_unnamed_653;
									if (fragment_unnamed_610 == 0u)
									{
										precise float fragment_unnamed_646 = clamp(fragment_unnamed_616, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										precise float fragment_unnamed_647 = clamp(fragment_unnamed_621, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										fragment_unnamed_653 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_646, fragment_unnamed_647), 0.0f).y;
									}
									else
									{
										fragment_unnamed_653 = asfloat(fragment_unnamed_598);
									}
									float fragment_unnamed_666;
									if (fragment_unnamed_611 == 0u)
									{
										precise float fragment_unnamed_660 = clamp(fragment_unnamed_628, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										precise float fragment_unnamed_661 = clamp(fragment_unnamed_632, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
										fragment_unnamed_666 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_660, fragment_unnamed_661), 0.0f).y;
									}
									else
									{
										fragment_unnamed_666 = fragment_unnamed_605;
									}
									precise float fragment_unnamed_667 = (-0.0f) - fragment_unnamed_244;
									uint fragment_unnamed_671 = fragment_unnamed_608 ? asuint(fragment_unnamed_653) : asuint(mad(fragment_unnamed_667, 0.5f, fragment_unnamed_653));
									float fragment_unnamed_672 = asfloat(fragment_unnamed_671);
									precise float fragment_unnamed_673 = (-0.0f) - fragment_unnamed_244;
									float fragment_unnamed_678 = asfloat(fragment_unnamed_609 ? asuint(fragment_unnamed_666) : asuint(mad(fragment_unnamed_673, 0.5f, fragment_unnamed_666)));
									bool fragment_unnamed_681 = abs(fragment_unnamed_672) >= fragment_unnamed_245;
									bool fragment_unnamed_682 = abs(fragment_unnamed_678) >= fragment_unnamed_245;
									uint fragment_unnamed_683 = fragment_unnamed_681 ? 4294967295u : 0u;
									uint fragment_unnamed_684 = fragment_unnamed_682 ? 4294967295u : 0u;
									precise float fragment_unnamed_685 = (-0.0f) - fragment_unnamed_190;
									uint fragment_unnamed_688 = fragment_unnamed_681 ? fragment_unnamed_615 : asuint(mad(fragment_unnamed_685, 2.0f, fragment_unnamed_616));
									float fragment_unnamed_689 = asfloat(fragment_unnamed_688);
									precise float fragment_unnamed_690 = (-0.0f) - fragment_unnamed_196;
									uint fragment_unnamed_693 = fragment_unnamed_681 ? fragment_unnamed_620 : asuint(mad(fragment_unnamed_690, 2.0f, fragment_unnamed_621));
									float fragment_unnamed_694 = asfloat(fragment_unnamed_693);
									uint fragment_unnamed_700 = fragment_unnamed_682 ? fragment_unnamed_627 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_628));
									float fragment_unnamed_701 = asfloat(fragment_unnamed_700);
									uint fragment_unnamed_704 = fragment_unnamed_682 ? fragment_unnamed_631 : asuint(mad(fragment_unnamed_196, 2.0f, fragment_unnamed_632));
									float fragment_unnamed_705 = asfloat(fragment_unnamed_704);
									float fragment_unnamed_635;
									float fragment_unnamed_636;
									float fragment_unnamed_637;
									float fragment_unnamed_638;
									float fragment_unnamed_639;
									float fragment_unnamed_640;
									if (((~fragment_unnamed_684) | (~fragment_unnamed_683)) != 0u)
									{
										float fragment_unnamed_726;
										if (fragment_unnamed_683 == 0u)
										{
											precise float fragment_unnamed_719 = clamp(fragment_unnamed_689, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											precise float fragment_unnamed_720 = clamp(fragment_unnamed_694, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											fragment_unnamed_726 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_719, fragment_unnamed_720), 0.0f).y;
										}
										else
										{
											fragment_unnamed_726 = asfloat(fragment_unnamed_671);
										}
										float fragment_unnamed_739;
										if (fragment_unnamed_684 == 0u)
										{
											precise float fragment_unnamed_733 = clamp(fragment_unnamed_701, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											precise float fragment_unnamed_734 = clamp(fragment_unnamed_705, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
											fragment_unnamed_739 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_733, fragment_unnamed_734), 0.0f).y;
										}
										else
										{
											fragment_unnamed_739 = fragment_unnamed_678;
										}
										precise float fragment_unnamed_740 = (-0.0f) - fragment_unnamed_244;
										uint fragment_unnamed_744 = fragment_unnamed_681 ? asuint(fragment_unnamed_726) : asuint(mad(fragment_unnamed_740, 0.5f, fragment_unnamed_726));
										float fragment_unnamed_745 = asfloat(fragment_unnamed_744);
										precise float fragment_unnamed_746 = (-0.0f) - fragment_unnamed_244;
										float fragment_unnamed_751 = asfloat(fragment_unnamed_682 ? asuint(fragment_unnamed_739) : asuint(mad(fragment_unnamed_746, 0.5f, fragment_unnamed_739)));
										bool fragment_unnamed_754 = abs(fragment_unnamed_745) >= fragment_unnamed_245;
										bool fragment_unnamed_755 = abs(fragment_unnamed_751) >= fragment_unnamed_245;
										uint fragment_unnamed_756 = fragment_unnamed_754 ? 4294967295u : 0u;
										uint fragment_unnamed_757 = fragment_unnamed_755 ? 4294967295u : 0u;
										precise float fragment_unnamed_758 = (-0.0f) - fragment_unnamed_190;
										uint fragment_unnamed_761 = fragment_unnamed_754 ? fragment_unnamed_688 : asuint(mad(fragment_unnamed_758, 2.0f, fragment_unnamed_689));
										float fragment_unnamed_762 = asfloat(fragment_unnamed_761);
										precise float fragment_unnamed_763 = (-0.0f) - fragment_unnamed_196;
										uint fragment_unnamed_766 = fragment_unnamed_754 ? fragment_unnamed_693 : asuint(mad(fragment_unnamed_763, 2.0f, fragment_unnamed_694));
										float fragment_unnamed_767 = asfloat(fragment_unnamed_766);
										uint fragment_unnamed_773 = fragment_unnamed_755 ? fragment_unnamed_700 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_701));
										float fragment_unnamed_774 = asfloat(fragment_unnamed_773);
										uint fragment_unnamed_777 = fragment_unnamed_755 ? fragment_unnamed_704 : asuint(mad(fragment_unnamed_196, 2.0f, fragment_unnamed_705));
										float fragment_unnamed_778 = asfloat(fragment_unnamed_777);
										float fragment_unnamed_708;
										float fragment_unnamed_709;
										float fragment_unnamed_710;
										float fragment_unnamed_711;
										float fragment_unnamed_712;
										float fragment_unnamed_713;
										if (((~fragment_unnamed_757) | (~fragment_unnamed_756)) != 0u)
										{
											float fragment_unnamed_799;
											if (fragment_unnamed_756 == 0u)
											{
												precise float fragment_unnamed_792 = clamp(fragment_unnamed_762, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												precise float fragment_unnamed_793 = clamp(fragment_unnamed_767, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												fragment_unnamed_799 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_792, fragment_unnamed_793), 0.0f).y;
											}
											else
											{
												fragment_unnamed_799 = asfloat(fragment_unnamed_744);
											}
											float fragment_unnamed_812;
											if (fragment_unnamed_757 == 0u)
											{
												precise float fragment_unnamed_806 = clamp(fragment_unnamed_774, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												precise float fragment_unnamed_807 = clamp(fragment_unnamed_778, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
												fragment_unnamed_812 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_806, fragment_unnamed_807), 0.0f).y;
											}
											else
											{
												fragment_unnamed_812 = fragment_unnamed_751;
											}
											precise float fragment_unnamed_813 = (-0.0f) - fragment_unnamed_244;
											uint fragment_unnamed_817 = fragment_unnamed_754 ? asuint(fragment_unnamed_799) : asuint(mad(fragment_unnamed_813, 0.5f, fragment_unnamed_799));
											float fragment_unnamed_818 = asfloat(fragment_unnamed_817);
											precise float fragment_unnamed_819 = (-0.0f) - fragment_unnamed_244;
											float fragment_unnamed_824 = asfloat(fragment_unnamed_755 ? asuint(fragment_unnamed_812) : asuint(mad(fragment_unnamed_819, 0.5f, fragment_unnamed_812)));
											bool fragment_unnamed_827 = abs(fragment_unnamed_818) >= fragment_unnamed_245;
											bool fragment_unnamed_828 = abs(fragment_unnamed_824) >= fragment_unnamed_245;
											uint fragment_unnamed_829 = fragment_unnamed_827 ? 4294967295u : 0u;
											uint fragment_unnamed_830 = fragment_unnamed_828 ? 4294967295u : 0u;
											precise float fragment_unnamed_831 = (-0.0f) - fragment_unnamed_190;
											uint fragment_unnamed_834 = fragment_unnamed_827 ? fragment_unnamed_761 : asuint(mad(fragment_unnamed_831, 2.0f, fragment_unnamed_762));
											float fragment_unnamed_835 = asfloat(fragment_unnamed_834);
											precise float fragment_unnamed_836 = (-0.0f) - fragment_unnamed_196;
											uint fragment_unnamed_839 = fragment_unnamed_827 ? fragment_unnamed_766 : asuint(mad(fragment_unnamed_836, 2.0f, fragment_unnamed_767));
											float fragment_unnamed_840 = asfloat(fragment_unnamed_839);
											uint fragment_unnamed_846 = fragment_unnamed_828 ? fragment_unnamed_773 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_774));
											float fragment_unnamed_847 = asfloat(fragment_unnamed_846);
											uint fragment_unnamed_850 = fragment_unnamed_828 ? fragment_unnamed_777 : asuint(mad(fragment_unnamed_196, 2.0f, fragment_unnamed_778));
											float fragment_unnamed_851 = asfloat(fragment_unnamed_850);
											float fragment_unnamed_781;
											float fragment_unnamed_782;
											float fragment_unnamed_783;
											float fragment_unnamed_784;
											float fragment_unnamed_785;
											float fragment_unnamed_786;
											if (((~fragment_unnamed_830) | (~fragment_unnamed_829)) != 0u)
											{
												float fragment_unnamed_872;
												if (fragment_unnamed_829 == 0u)
												{
													precise float fragment_unnamed_865 = clamp(fragment_unnamed_835, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													precise float fragment_unnamed_866 = clamp(fragment_unnamed_840, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													fragment_unnamed_872 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_865, fragment_unnamed_866), 0.0f).y;
												}
												else
												{
													fragment_unnamed_872 = asfloat(fragment_unnamed_817);
												}
												float fragment_unnamed_885;
												if (fragment_unnamed_830 == 0u)
												{
													precise float fragment_unnamed_879 = clamp(fragment_unnamed_847, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													precise float fragment_unnamed_880 = clamp(fragment_unnamed_851, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
													fragment_unnamed_885 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_879, fragment_unnamed_880), 0.0f).y;
												}
												else
												{
													fragment_unnamed_885 = fragment_unnamed_824;
												}
												precise float fragment_unnamed_886 = (-0.0f) - fragment_unnamed_244;
												uint fragment_unnamed_890 = fragment_unnamed_827 ? asuint(fragment_unnamed_872) : asuint(mad(fragment_unnamed_886, 0.5f, fragment_unnamed_872));
												float fragment_unnamed_891 = asfloat(fragment_unnamed_890);
												precise float fragment_unnamed_892 = (-0.0f) - fragment_unnamed_244;
												float fragment_unnamed_897 = asfloat(fragment_unnamed_828 ? asuint(fragment_unnamed_885) : asuint(mad(fragment_unnamed_892, 0.5f, fragment_unnamed_885)));
												bool fragment_unnamed_900 = abs(fragment_unnamed_891) >= fragment_unnamed_245;
												bool fragment_unnamed_901 = abs(fragment_unnamed_897) >= fragment_unnamed_245;
												uint fragment_unnamed_902 = fragment_unnamed_900 ? 4294967295u : 0u;
												uint fragment_unnamed_903 = fragment_unnamed_901 ? 4294967295u : 0u;
												precise float fragment_unnamed_904 = (-0.0f) - fragment_unnamed_190;
												uint fragment_unnamed_907 = fragment_unnamed_900 ? fragment_unnamed_834 : asuint(mad(fragment_unnamed_904, 2.0f, fragment_unnamed_835));
												float fragment_unnamed_908 = asfloat(fragment_unnamed_907);
												precise float fragment_unnamed_909 = (-0.0f) - fragment_unnamed_196;
												uint fragment_unnamed_912 = fragment_unnamed_900 ? fragment_unnamed_839 : asuint(mad(fragment_unnamed_909, 2.0f, fragment_unnamed_840));
												float fragment_unnamed_913 = asfloat(fragment_unnamed_912);
												uint fragment_unnamed_919 = fragment_unnamed_901 ? fragment_unnamed_846 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_847));
												float fragment_unnamed_920 = asfloat(fragment_unnamed_919);
												uint fragment_unnamed_923 = fragment_unnamed_901 ? fragment_unnamed_850 : asuint(mad(fragment_unnamed_196, 2.0f, fragment_unnamed_851));
												float fragment_unnamed_924 = asfloat(fragment_unnamed_923);
												float fragment_unnamed_854;
												float fragment_unnamed_855;
												float fragment_unnamed_856;
												float fragment_unnamed_857;
												float fragment_unnamed_858;
												float fragment_unnamed_859;
												if (((~fragment_unnamed_903) | (~fragment_unnamed_902)) != 0u)
												{
													float fragment_unnamed_945;
													if (fragment_unnamed_902 == 0u)
													{
														precise float fragment_unnamed_938 = clamp(fragment_unnamed_908, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														precise float fragment_unnamed_939 = clamp(fragment_unnamed_913, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														fragment_unnamed_945 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_938, fragment_unnamed_939), 0.0f).y;
													}
													else
													{
														fragment_unnamed_945 = asfloat(fragment_unnamed_890);
													}
													float fragment_unnamed_958;
													if (fragment_unnamed_903 == 0u)
													{
														precise float fragment_unnamed_952 = clamp(fragment_unnamed_920, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														precise float fragment_unnamed_953 = clamp(fragment_unnamed_924, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
														fragment_unnamed_958 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_952, fragment_unnamed_953), 0.0f).y;
													}
													else
													{
														fragment_unnamed_958 = fragment_unnamed_897;
													}
													precise float fragment_unnamed_959 = (-0.0f) - fragment_unnamed_244;
													uint fragment_unnamed_963 = fragment_unnamed_900 ? asuint(fragment_unnamed_945) : asuint(mad(fragment_unnamed_959, 0.5f, fragment_unnamed_945));
													float fragment_unnamed_964 = asfloat(fragment_unnamed_963);
													precise float fragment_unnamed_965 = (-0.0f) - fragment_unnamed_244;
													float fragment_unnamed_970 = asfloat(fragment_unnamed_901 ? asuint(fragment_unnamed_958) : asuint(mad(fragment_unnamed_965, 0.5f, fragment_unnamed_958)));
													bool fragment_unnamed_973 = abs(fragment_unnamed_964) >= fragment_unnamed_245;
													bool fragment_unnamed_974 = abs(fragment_unnamed_970) >= fragment_unnamed_245;
													uint fragment_unnamed_975 = fragment_unnamed_973 ? 4294967295u : 0u;
													uint fragment_unnamed_976 = fragment_unnamed_974 ? 4294967295u : 0u;
													precise float fragment_unnamed_977 = (-0.0f) - fragment_unnamed_190;
													uint fragment_unnamed_981 = fragment_unnamed_973 ? fragment_unnamed_907 : asuint(mad(fragment_unnamed_977, 4.0f, fragment_unnamed_908));
													float fragment_unnamed_982 = asfloat(fragment_unnamed_981);
													precise float fragment_unnamed_983 = (-0.0f) - fragment_unnamed_196;
													uint fragment_unnamed_986 = fragment_unnamed_973 ? fragment_unnamed_912 : asuint(mad(fragment_unnamed_983, 4.0f, fragment_unnamed_913));
													float fragment_unnamed_987 = asfloat(fragment_unnamed_986);
													uint fragment_unnamed_993 = fragment_unnamed_974 ? fragment_unnamed_919 : asuint(mad(fragment_unnamed_190, 4.0f, fragment_unnamed_920));
													float fragment_unnamed_994 = asfloat(fragment_unnamed_993);
													uint fragment_unnamed_997 = fragment_unnamed_974 ? fragment_unnamed_923 : asuint(mad(fragment_unnamed_196, 4.0f, fragment_unnamed_924));
													float fragment_unnamed_998 = asfloat(fragment_unnamed_997);
													float fragment_unnamed_927;
													float fragment_unnamed_928;
													float fragment_unnamed_929;
													float fragment_unnamed_930;
													float fragment_unnamed_931;
													float fragment_unnamed_932;
													if (((~fragment_unnamed_976) | (~fragment_unnamed_975)) != 0u)
													{
														float fragment_unnamed_1019;
														if (fragment_unnamed_975 == 0u)
														{
															precise float fragment_unnamed_1012 = clamp(fragment_unnamed_982, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															precise float fragment_unnamed_1013 = clamp(fragment_unnamed_987, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															fragment_unnamed_1019 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_1012, fragment_unnamed_1013), 0.0f).y;
														}
														else
														{
															fragment_unnamed_1019 = asfloat(fragment_unnamed_963);
														}
														float fragment_unnamed_1032;
														if (fragment_unnamed_976 == 0u)
														{
															precise float fragment_unnamed_1026 = clamp(fragment_unnamed_994, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															precise float fragment_unnamed_1027 = clamp(fragment_unnamed_998, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
															fragment_unnamed_1032 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_1026, fragment_unnamed_1027), 0.0f).y;
														}
														else
														{
															fragment_unnamed_1032 = fragment_unnamed_970;
														}
														precise float fragment_unnamed_1033 = (-0.0f) - fragment_unnamed_244;
														float fragment_unnamed_1002 = asfloat(fragment_unnamed_973 ? asuint(fragment_unnamed_1019) : asuint(mad(fragment_unnamed_1033, 0.5f, fragment_unnamed_1019)));
														precise float fragment_unnamed_1038 = (-0.0f) - fragment_unnamed_244;
														float fragment_unnamed_1001 = asfloat(fragment_unnamed_974 ? asuint(fragment_unnamed_1032) : asuint(mad(fragment_unnamed_1038, 0.5f, fragment_unnamed_1032)));
														bool fragment_unnamed_1045 = abs(fragment_unnamed_1002) >= fragment_unnamed_245;
														bool fragment_unnamed_1046 = abs(fragment_unnamed_1001) >= fragment_unnamed_245;
														precise float fragment_unnamed_1047 = (-0.0f) - fragment_unnamed_190;
														precise float fragment_unnamed_1052 = (-0.0f) - fragment_unnamed_196;
														fragment_unnamed_927 = fragment_unnamed_1001;
														fragment_unnamed_928 = fragment_unnamed_1002;
														fragment_unnamed_929 = asfloat(fragment_unnamed_1045 ? fragment_unnamed_981 : asuint(mad(fragment_unnamed_1047, 8.0f, fragment_unnamed_982)));
														fragment_unnamed_930 = asfloat(fragment_unnamed_1045 ? fragment_unnamed_986 : asuint(mad(fragment_unnamed_1052, 8.0f, fragment_unnamed_987)));
														fragment_unnamed_931 = asfloat(fragment_unnamed_1046 ? fragment_unnamed_993 : asuint(mad(fragment_unnamed_190, 8.0f, fragment_unnamed_994)));
														fragment_unnamed_932 = asfloat(fragment_unnamed_1046 ? fragment_unnamed_997 : asuint(mad(fragment_unnamed_196, 8.0f, fragment_unnamed_998)));
													}
													else
													{
														fragment_unnamed_927 = fragment_unnamed_970;
														fragment_unnamed_928 = fragment_unnamed_964;
														fragment_unnamed_929 = fragment_unnamed_982;
														fragment_unnamed_930 = fragment_unnamed_987;
														fragment_unnamed_931 = fragment_unnamed_994;
														fragment_unnamed_932 = fragment_unnamed_998;
													}
													fragment_unnamed_854 = fragment_unnamed_927;
													fragment_unnamed_855 = fragment_unnamed_928;
													fragment_unnamed_856 = fragment_unnamed_929;
													fragment_unnamed_857 = fragment_unnamed_930;
													fragment_unnamed_858 = fragment_unnamed_931;
													fragment_unnamed_859 = fragment_unnamed_932;
												}
												else
												{
													fragment_unnamed_854 = fragment_unnamed_897;
													fragment_unnamed_855 = fragment_unnamed_891;
													fragment_unnamed_856 = fragment_unnamed_908;
													fragment_unnamed_857 = fragment_unnamed_913;
													fragment_unnamed_858 = fragment_unnamed_920;
													fragment_unnamed_859 = fragment_unnamed_924;
												}
												fragment_unnamed_781 = fragment_unnamed_854;
												fragment_unnamed_782 = fragment_unnamed_855;
												fragment_unnamed_783 = fragment_unnamed_856;
												fragment_unnamed_784 = fragment_unnamed_857;
												fragment_unnamed_785 = fragment_unnamed_858;
												fragment_unnamed_786 = fragment_unnamed_859;
											}
											else
											{
												fragment_unnamed_781 = fragment_unnamed_824;
												fragment_unnamed_782 = fragment_unnamed_818;
												fragment_unnamed_783 = fragment_unnamed_835;
												fragment_unnamed_784 = fragment_unnamed_840;
												fragment_unnamed_785 = fragment_unnamed_847;
												fragment_unnamed_786 = fragment_unnamed_851;
											}
											fragment_unnamed_708 = fragment_unnamed_781;
											fragment_unnamed_709 = fragment_unnamed_782;
											fragment_unnamed_710 = fragment_unnamed_783;
											fragment_unnamed_711 = fragment_unnamed_784;
											fragment_unnamed_712 = fragment_unnamed_785;
											fragment_unnamed_713 = fragment_unnamed_786;
										}
										else
										{
											fragment_unnamed_708 = fragment_unnamed_751;
											fragment_unnamed_709 = fragment_unnamed_745;
											fragment_unnamed_710 = fragment_unnamed_762;
											fragment_unnamed_711 = fragment_unnamed_767;
											fragment_unnamed_712 = fragment_unnamed_774;
											fragment_unnamed_713 = fragment_unnamed_778;
										}
										fragment_unnamed_635 = fragment_unnamed_708;
										fragment_unnamed_636 = fragment_unnamed_709;
										fragment_unnamed_637 = fragment_unnamed_710;
										fragment_unnamed_638 = fragment_unnamed_711;
										fragment_unnamed_639 = fragment_unnamed_712;
										fragment_unnamed_640 = fragment_unnamed_713;
									}
									else
									{
										fragment_unnamed_635 = fragment_unnamed_678;
										fragment_unnamed_636 = fragment_unnamed_672;
										fragment_unnamed_637 = fragment_unnamed_689;
										fragment_unnamed_638 = fragment_unnamed_694;
										fragment_unnamed_639 = fragment_unnamed_701;
										fragment_unnamed_640 = fragment_unnamed_705;
									}
									fragment_unnamed_562 = fragment_unnamed_635;
									fragment_unnamed_563 = fragment_unnamed_636;
									fragment_unnamed_564 = fragment_unnamed_637;
									fragment_unnamed_565 = fragment_unnamed_638;
									fragment_unnamed_566 = fragment_unnamed_639;
									fragment_unnamed_567 = fragment_unnamed_640;
								}
								else
								{
									fragment_unnamed_562 = fragment_unnamed_605;
									fragment_unnamed_563 = fragment_unnamed_599;
									fragment_unnamed_564 = fragment_unnamed_616;
									fragment_unnamed_565 = fragment_unnamed_621;
									fragment_unnamed_566 = fragment_unnamed_628;
									fragment_unnamed_567 = fragment_unnamed_632;
								}
								fragment_unnamed_489 = fragment_unnamed_562;
								fragment_unnamed_490 = fragment_unnamed_563;
								fragment_unnamed_491 = fragment_unnamed_564;
								fragment_unnamed_492 = fragment_unnamed_565;
								fragment_unnamed_493 = fragment_unnamed_566;
								fragment_unnamed_494 = fragment_unnamed_567;
							}
							else
							{
								fragment_unnamed_489 = fragment_unnamed_532;
								fragment_unnamed_490 = fragment_unnamed_526;
								fragment_unnamed_491 = fragment_unnamed_543;
								fragment_unnamed_492 = fragment_unnamed_548;
								fragment_unnamed_493 = fragment_unnamed_555;
								fragment_unnamed_494 = fragment_unnamed_559;
							}
							fragment_unnamed_346 = fragment_unnamed_489;
							fragment_unnamed_348 = fragment_unnamed_490;
							fragment_unnamed_350 = fragment_unnamed_491;
							fragment_unnamed_352 = fragment_unnamed_492;
							fragment_unnamed_354 = fragment_unnamed_493;
							fragment_unnamed_356 = fragment_unnamed_494;
						}
						else
						{
							fragment_unnamed_346 = fragment_unnamed_459;
							fragment_unnamed_348 = fragment_unnamed_453;
							fragment_unnamed_350 = fragment_unnamed_470;
							fragment_unnamed_352 = fragment_unnamed_475;
							fragment_unnamed_354 = fragment_unnamed_482;
							fragment_unnamed_356 = fragment_unnamed_486;
						}
						fragment_unnamed_345 = fragment_unnamed_346;
						fragment_unnamed_347 = fragment_unnamed_348;
						fragment_unnamed_349 = fragment_unnamed_350;
						fragment_unnamed_351 = fragment_unnamed_352;
						fragment_unnamed_353 = fragment_unnamed_354;
						fragment_unnamed_355 = fragment_unnamed_356;
					}
					else
					{
						fragment_unnamed_345 = fragment_unnamed_255;
						fragment_unnamed_347 = fragment_unnamed_253;
						fragment_unnamed_349 = fragment_unnamed_267;
						fragment_unnamed_351 = fragment_unnamed_272;
						fragment_unnamed_353 = fragment_unnamed_280;
						fragment_unnamed_355 = fragment_unnamed_285;
					}
					precise float fragment_unnamed_357 = (-0.0f) - fragment_unnamed_349;
					precise float fragment_unnamed_360 = fragment_unnamed_357 + fragment_input_1.x;
					precise float fragment_unnamed_363 = (-0.0f) - fragment_input_1.x;
					precise float fragment_unnamed_364 = fragment_unnamed_353 + fragment_unnamed_363;
					precise float fragment_unnamed_365 = (-0.0f) - fragment_unnamed_351;
					precise float fragment_unnamed_368 = fragment_unnamed_365 + fragment_input_1.y;
					float fragment_unnamed_372 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_360) : asuint(fragment_unnamed_368));
					precise float fragment_unnamed_375 = (-0.0f) - fragment_input_1.y;
					precise float fragment_unnamed_376 = fragment_unnamed_355 + fragment_unnamed_375;
					float fragment_unnamed_380 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_364) : asuint(fragment_unnamed_376));
					precise float fragment_unnamed_385 = fragment_unnamed_372 + fragment_unnamed_380;
					precise float fragment_unnamed_390 = 1.0f / fragment_unnamed_385;
					precise float fragment_unnamed_394 = fragment_unnamed_249 * fragment_unnamed_249;
					precise float fragment_unnamed_395 = (-0.0f) - fragment_unnamed_390;
					float fragment_unnamed_400 = max(fragment_unnamed_394, asfloat(asuint(mad(min(fragment_unnamed_380, fragment_unnamed_372), fragment_unnamed_395, 0.5f)) & ((fragment_unnamed_372 < fragment_unnamed_380) ? ((fragment_unnamed_251 != ((fragment_unnamed_347 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_251 != ((fragment_unnamed_345 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					precise float fragment_unnamed_418 = clamp(fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_400, fragment_unnamed_181, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_419 = clamp(fragment_unnamed_142 ? mad(fragment_unnamed_400, fragment_unnamed_181, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float4 fragment_unnamed_421 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_418, fragment_unnamed_419), 0.0f);
					fragment_unnamed_287 = fragment_unnamed_421.z;
					fragment_unnamed_289 = fragment_unnamed_421.y;
					fragment_unnamed_291 = fragment_unnamed_421.x;
				}
				else
				{
					fragment_unnamed_287 = fragment_unnamed_54.z;
					fragment_unnamed_289 = fragment_unnamed_57;
					fragment_unnamed_291 = fragment_unnamed_54.x;
				}
				float fragment_unnamed_320 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[29u].x, fragment_uniform_buffer_0[29u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[29u].y, fragment_uniform_buffer_0[29u].w))).w, 2.0f, -1.0f);
				precise float fragment_unnamed_327 = (-0.0f) - abs(fragment_unnamed_320);
				precise float fragment_unnamed_328 = fragment_unnamed_327 + 1.0f;
				precise float fragment_unnamed_330 = (-0.0f) - sqrt(fragment_unnamed_328);
				precise float fragment_unnamed_331 = fragment_unnamed_330 + 1.0f;
				precise float fragment_unnamed_332 = fragment_unnamed_331 * mad(clamp(mad(fragment_unnamed_320, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_332, 0.0039215688593685626983642578125f, fragment_unnamed_291);
				fragment_output_0.y = mad(fragment_unnamed_332, 0.0039215688593685626983642578125f, fragment_unnamed_289);
				fragment_output_0.z = mad(fragment_unnamed_332, 0.0039215688593685626983642578125f, fragment_unnamed_287);
				fragment_output_0.w = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[29] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[30] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA) && defined(FXAA_KEEP_ALPHA) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA_LOW)


			#if defined(FXAA_LOW) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
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
				precise float vertex_unnamed_50 = vertex_unnamed_42 * vertex_uniform_buffer_0[27u].x;
				precise float vertex_unnamed_51 = vertex_unnamed_43 * vertex_uniform_buffer_0[27u].y;
				float vertex_unnamed_57 = mad(vertex_unnamed_50, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_59 = mad(vertex_unnamed_51, 0.5f, vertex_uniform_buffer_0[27u].w);
				precise float vertex_unnamed_64 = vertex_unnamed_57 * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_65 = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_64;
				vertex_output_1.y = vertex_unnamed_65;
				vertex_output_1.x = vertex_unnamed_57;
				vertex_output_1.y = vertex_unnamed_59;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				precise float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f);
				float fragment_unnamed_59 = fragment_unnamed_54.w;
				float4 fragment_unnamed_63 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, 1));
				float fragment_unnamed_67 = fragment_unnamed_63.w;
				float4 fragment_unnamed_68 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 0));
				float fragment_unnamed_71 = fragment_unnamed_68.w;
				float4 fragment_unnamed_73 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, -1));
				float fragment_unnamed_76 = fragment_unnamed_73.w;
				float4 fragment_unnamed_77 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 0));
				float fragment_unnamed_80 = fragment_unnamed_77.w;
				float fragment_unnamed_87 = max(max(max(fragment_unnamed_59, fragment_unnamed_67), fragment_unnamed_71), max(fragment_unnamed_76, fragment_unnamed_80));
				precise float fragment_unnamed_89 = fragment_unnamed_87 * 0.16599999368190765380859375f;
				precise float fragment_unnamed_91 = (-0.0f) - min(min(min(fragment_unnamed_59, fragment_unnamed_67), fragment_unnamed_71), min(fragment_unnamed_76, fragment_unnamed_80));
				precise float fragment_unnamed_93 = fragment_unnamed_91 + fragment_unnamed_87;
				float fragment_unnamed_288;
				float fragment_unnamed_290;
				float fragment_unnamed_292;
				if (fragment_unnamed_93 >= max(fragment_unnamed_89, 0.0625f))
				{
					float4 fragment_unnamed_99 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, -1));
					float fragment_unnamed_102 = fragment_unnamed_99.w;
					float4 fragment_unnamed_103 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 1));
					float fragment_unnamed_106 = fragment_unnamed_103.w;
					float4 fragment_unnamed_107 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, -1));
					float fragment_unnamed_110 = fragment_unnamed_107.w;
					float4 fragment_unnamed_111 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 1));
					float fragment_unnamed_114 = fragment_unnamed_111.w;
					precise float fragment_unnamed_115 = fragment_unnamed_67 + fragment_unnamed_76;
					precise float fragment_unnamed_116 = fragment_unnamed_71 + fragment_unnamed_80;
					precise float fragment_unnamed_117 = 1.0f / fragment_unnamed_93;
					precise float fragment_unnamed_118 = fragment_unnamed_116 + fragment_unnamed_115;
					precise float fragment_unnamed_122 = fragment_unnamed_106 + fragment_unnamed_110;
					precise float fragment_unnamed_123 = fragment_unnamed_102 + fragment_unnamed_110;
					precise float fragment_unnamed_126 = fragment_unnamed_102 + fragment_unnamed_114;
					precise float fragment_unnamed_127 = fragment_unnamed_106 + fragment_unnamed_114;
					precise float fragment_unnamed_139 = mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_115)), 2.0f, abs(mad(fragment_unnamed_71, -2.0f, fragment_unnamed_122))) + abs(mad(fragment_unnamed_80, -2.0f, fragment_unnamed_126));
					precise float fragment_unnamed_140 = mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_116)), 2.0f, abs(mad(fragment_unnamed_76, -2.0f, fragment_unnamed_123))) + abs(mad(fragment_unnamed_67, -2.0f, fragment_unnamed_127));
					precise float fragment_unnamed_141 = fragment_unnamed_122 + fragment_unnamed_126;
					bool fragment_unnamed_142 = fragment_unnamed_139 >= fragment_unnamed_140;
					float fragment_unnamed_149 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_76) : asuint(fragment_unnamed_80));
					float fragment_unnamed_153 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_67) : asuint(fragment_unnamed_71));
					float fragment_unnamed_165 = asfloat(fragment_unnamed_142 ? asuint(fragment_uniform_buffer_0[29u]).y : asuint(fragment_uniform_buffer_0[29u]).x);
					precise float fragment_unnamed_166 = (-0.0f) - fragment_unnamed_59;
					precise float fragment_unnamed_169 = (-0.0f) - fragment_unnamed_59;
					precise float fragment_unnamed_170 = fragment_unnamed_169 + fragment_unnamed_149;
					precise float fragment_unnamed_171 = (-0.0f) - fragment_unnamed_59;
					precise float fragment_unnamed_172 = fragment_unnamed_171 + fragment_unnamed_153;
					precise float fragment_unnamed_173 = fragment_unnamed_59 + fragment_unnamed_149;
					precise float fragment_unnamed_174 = fragment_unnamed_59 + fragment_unnamed_153;
					bool fragment_unnamed_177 = abs(fragment_unnamed_170) >= abs(fragment_unnamed_172);
					precise float fragment_unnamed_181 = (-0.0f) - fragment_unnamed_165;
					float fragment_unnamed_182 = fragment_unnamed_177 ? fragment_unnamed_181 : fragment_unnamed_165;
					precise float fragment_unnamed_184 = fragment_unnamed_117 * abs(mad(mad(fragment_unnamed_118, 2.0f, fragment_unnamed_141), 0.083333335816860198974609375f, fragment_unnamed_166));
					float fragment_unnamed_185 = clamp(fragment_unnamed_184, 0.0f, 1.0f);
					float fragment_unnamed_191 = asfloat((fragment_unnamed_142 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_197 = asfloat(fragment_unnamed_142 ? 0u : asuint(fragment_uniform_buffer_0[29u]).y);
					float fragment_unnamed_207 = fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_182, 0.5f, fragment_input_1.x);
					float fragment_unnamed_210 = fragment_unnamed_142 ? mad(fragment_unnamed_182, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					precise float fragment_unnamed_211 = (-0.0f) - fragment_unnamed_191;
					precise float fragment_unnamed_212 = fragment_unnamed_211 + fragment_unnamed_207;
					precise float fragment_unnamed_214 = (-0.0f) - fragment_unnamed_197;
					precise float fragment_unnamed_215 = fragment_unnamed_214 + fragment_unnamed_210;
					precise float fragment_unnamed_217 = fragment_unnamed_191 + fragment_unnamed_207;
					precise float fragment_unnamed_218 = fragment_unnamed_197 + fragment_unnamed_210;
					precise float fragment_unnamed_226 = clamp(fragment_unnamed_212, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_227 = clamp(fragment_unnamed_215, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_231 = fragment_unnamed_185 * fragment_unnamed_185;
					precise float fragment_unnamed_237 = clamp(fragment_unnamed_217, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_238 = clamp(fragment_unnamed_218, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float fragment_unnamed_245 = asfloat(fragment_unnamed_177 ? asuint(fragment_unnamed_173) : asuint(fragment_unnamed_174));
					precise float fragment_unnamed_246 = max(abs(fragment_unnamed_172), abs(fragment_unnamed_170)) * 0.25f;
					precise float fragment_unnamed_248 = (-0.0f) - fragment_unnamed_245;
					precise float fragment_unnamed_250 = fragment_unnamed_231 * mad(fragment_unnamed_185, -2.0f, 3.0f);
					uint fragment_unnamed_252 = (mad(fragment_unnamed_248, 0.5f, fragment_unnamed_59) < 0.0f) ? 4294967295u : 0u;
					precise float fragment_unnamed_253 = (-0.0f) - fragment_unnamed_245;
					float fragment_unnamed_254 = mad(fragment_unnamed_253, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_226, fragment_unnamed_227), 0.0f).w);
					precise float fragment_unnamed_255 = (-0.0f) - fragment_unnamed_245;
					float fragment_unnamed_256 = mad(fragment_unnamed_255, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_237, fragment_unnamed_238), 0.0f).w);
					bool fragment_unnamed_259 = abs(fragment_unnamed_254) >= fragment_unnamed_246;
					bool fragment_unnamed_260 = abs(fragment_unnamed_256) >= fragment_unnamed_246;
					uint fragment_unnamed_261 = fragment_unnamed_259 ? 4294967295u : 0u;
					uint fragment_unnamed_262 = fragment_unnamed_260 ? 4294967295u : 0u;
					precise float fragment_unnamed_263 = (-0.0f) - fragment_unnamed_191;
					uint fragment_unnamed_267 = fragment_unnamed_259 ? asuint(fragment_unnamed_212) : asuint(mad(fragment_unnamed_263, 1.5f, fragment_unnamed_212));
					float fragment_unnamed_268 = asfloat(fragment_unnamed_267);
					precise float fragment_unnamed_269 = (-0.0f) - fragment_unnamed_197;
					uint fragment_unnamed_272 = fragment_unnamed_259 ? asuint(fragment_unnamed_215) : asuint(mad(fragment_unnamed_269, 1.5f, fragment_unnamed_215));
					float fragment_unnamed_273 = asfloat(fragment_unnamed_272);
					uint fragment_unnamed_280 = fragment_unnamed_260 ? asuint(fragment_unnamed_217) : asuint(mad(fragment_unnamed_191, 1.5f, fragment_unnamed_217));
					float fragment_unnamed_281 = asfloat(fragment_unnamed_280);
					uint fragment_unnamed_285 = fragment_unnamed_260 ? asuint(fragment_unnamed_218) : asuint(mad(fragment_unnamed_197, 1.5f, fragment_unnamed_218));
					float fragment_unnamed_286 = asfloat(fragment_unnamed_285);
					float fragment_unnamed_338;
					float fragment_unnamed_340;
					float fragment_unnamed_342;
					float fragment_unnamed_344;
					float fragment_unnamed_346;
					float fragment_unnamed_348;
					if (((~fragment_unnamed_262) | (~fragment_unnamed_261)) != 0u)
					{
						float fragment_unnamed_427;
						if (fragment_unnamed_261 == 0u)
						{
							precise float fragment_unnamed_421 = clamp(fragment_unnamed_268, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_422 = clamp(fragment_unnamed_273, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_427 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_421, fragment_unnamed_422), 0.0f).w;
						}
						else
						{
							fragment_unnamed_427 = fragment_unnamed_254;
						}
						float fragment_unnamed_440;
						if (fragment_unnamed_262 == 0u)
						{
							precise float fragment_unnamed_434 = clamp(fragment_unnamed_281, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_435 = clamp(fragment_unnamed_286, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_440 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_434, fragment_unnamed_435), 0.0f).w;
						}
						else
						{
							fragment_unnamed_440 = fragment_unnamed_256;
						}
						precise float fragment_unnamed_441 = (-0.0f) - fragment_unnamed_245;
						uint fragment_unnamed_445 = fragment_unnamed_259 ? asuint(fragment_unnamed_427) : asuint(mad(fragment_unnamed_441, 0.5f, fragment_unnamed_427));
						float fragment_unnamed_446 = asfloat(fragment_unnamed_445);
						precise float fragment_unnamed_447 = (-0.0f) - fragment_unnamed_245;
						float fragment_unnamed_452 = asfloat(fragment_unnamed_260 ? asuint(fragment_unnamed_440) : asuint(mad(fragment_unnamed_447, 0.5f, fragment_unnamed_440)));
						bool fragment_unnamed_455 = abs(fragment_unnamed_446) >= fragment_unnamed_246;
						bool fragment_unnamed_456 = abs(fragment_unnamed_452) >= fragment_unnamed_246;
						uint fragment_unnamed_457 = fragment_unnamed_455 ? 4294967295u : 0u;
						uint fragment_unnamed_458 = fragment_unnamed_456 ? 4294967295u : 0u;
						precise float fragment_unnamed_459 = (-0.0f) - fragment_unnamed_191;
						uint fragment_unnamed_462 = fragment_unnamed_455 ? fragment_unnamed_267 : asuint(mad(fragment_unnamed_459, 2.0f, fragment_unnamed_268));
						float fragment_unnamed_463 = asfloat(fragment_unnamed_462);
						precise float fragment_unnamed_464 = (-0.0f) - fragment_unnamed_197;
						uint fragment_unnamed_467 = fragment_unnamed_455 ? fragment_unnamed_272 : asuint(mad(fragment_unnamed_464, 2.0f, fragment_unnamed_273));
						float fragment_unnamed_468 = asfloat(fragment_unnamed_467);
						uint fragment_unnamed_474 = fragment_unnamed_456 ? fragment_unnamed_280 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_281));
						float fragment_unnamed_475 = asfloat(fragment_unnamed_474);
						uint fragment_unnamed_478 = fragment_unnamed_456 ? fragment_unnamed_285 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_286));
						float fragment_unnamed_479 = asfloat(fragment_unnamed_478);
						float fragment_unnamed_339;
						float fragment_unnamed_341;
						float fragment_unnamed_343;
						float fragment_unnamed_345;
						float fragment_unnamed_347;
						float fragment_unnamed_349;
						if (((~fragment_unnamed_458) | (~fragment_unnamed_457)) != 0u)
						{
							float fragment_unnamed_500;
							if (fragment_unnamed_457 == 0u)
							{
								precise float fragment_unnamed_493 = clamp(fragment_unnamed_463, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_494 = clamp(fragment_unnamed_468, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_500 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_493, fragment_unnamed_494), 0.0f).w;
							}
							else
							{
								fragment_unnamed_500 = asfloat(fragment_unnamed_445);
							}
							float fragment_unnamed_513;
							if (fragment_unnamed_458 == 0u)
							{
								precise float fragment_unnamed_507 = clamp(fragment_unnamed_475, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_508 = clamp(fragment_unnamed_479, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_513 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_507, fragment_unnamed_508), 0.0f).w;
							}
							else
							{
								fragment_unnamed_513 = fragment_unnamed_452;
							}
							precise float fragment_unnamed_514 = (-0.0f) - fragment_unnamed_245;
							uint fragment_unnamed_518 = fragment_unnamed_455 ? asuint(fragment_unnamed_500) : asuint(mad(fragment_unnamed_514, 0.5f, fragment_unnamed_500));
							float fragment_unnamed_519 = asfloat(fragment_unnamed_518);
							precise float fragment_unnamed_520 = (-0.0f) - fragment_unnamed_245;
							float fragment_unnamed_525 = asfloat(fragment_unnamed_456 ? asuint(fragment_unnamed_513) : asuint(mad(fragment_unnamed_520, 0.5f, fragment_unnamed_513)));
							bool fragment_unnamed_528 = abs(fragment_unnamed_519) >= fragment_unnamed_246;
							bool fragment_unnamed_529 = abs(fragment_unnamed_525) >= fragment_unnamed_246;
							uint fragment_unnamed_530 = fragment_unnamed_528 ? 4294967295u : 0u;
							uint fragment_unnamed_531 = fragment_unnamed_529 ? 4294967295u : 0u;
							precise float fragment_unnamed_532 = (-0.0f) - fragment_unnamed_191;
							uint fragment_unnamed_536 = fragment_unnamed_528 ? fragment_unnamed_462 : asuint(mad(fragment_unnamed_532, 4.0f, fragment_unnamed_463));
							float fragment_unnamed_537 = asfloat(fragment_unnamed_536);
							precise float fragment_unnamed_538 = (-0.0f) - fragment_unnamed_197;
							uint fragment_unnamed_541 = fragment_unnamed_528 ? fragment_unnamed_467 : asuint(mad(fragment_unnamed_538, 4.0f, fragment_unnamed_468));
							float fragment_unnamed_542 = asfloat(fragment_unnamed_541);
							uint fragment_unnamed_548 = fragment_unnamed_529 ? fragment_unnamed_474 : asuint(mad(fragment_unnamed_191, 4.0f, fragment_unnamed_475));
							float fragment_unnamed_549 = asfloat(fragment_unnamed_548);
							uint fragment_unnamed_552 = fragment_unnamed_529 ? fragment_unnamed_478 : asuint(mad(fragment_unnamed_197, 4.0f, fragment_unnamed_479));
							float fragment_unnamed_553 = asfloat(fragment_unnamed_552);
							float fragment_unnamed_482;
							float fragment_unnamed_483;
							float fragment_unnamed_484;
							float fragment_unnamed_485;
							float fragment_unnamed_486;
							float fragment_unnamed_487;
							if (((~fragment_unnamed_531) | (~fragment_unnamed_530)) != 0u)
							{
								float fragment_unnamed_574;
								if (fragment_unnamed_530 == 0u)
								{
									precise float fragment_unnamed_567 = clamp(fragment_unnamed_537, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_568 = clamp(fragment_unnamed_542, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_574 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_567, fragment_unnamed_568), 0.0f).w;
								}
								else
								{
									fragment_unnamed_574 = asfloat(fragment_unnamed_518);
								}
								float fragment_unnamed_587;
								if (fragment_unnamed_531 == 0u)
								{
									precise float fragment_unnamed_581 = clamp(fragment_unnamed_549, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_582 = clamp(fragment_unnamed_553, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_587 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_581, fragment_unnamed_582), 0.0f).w;
								}
								else
								{
									fragment_unnamed_587 = fragment_unnamed_525;
								}
								precise float fragment_unnamed_588 = (-0.0f) - fragment_unnamed_245;
								float fragment_unnamed_556 = asfloat(fragment_unnamed_528 ? asuint(fragment_unnamed_574) : asuint(mad(fragment_unnamed_588, 0.5f, fragment_unnamed_574)));
								precise float fragment_unnamed_593 = (-0.0f) - fragment_unnamed_245;
								float fragment_unnamed_561 = asfloat(fragment_unnamed_529 ? asuint(fragment_unnamed_587) : asuint(mad(fragment_unnamed_593, 0.5f, fragment_unnamed_587)));
								bool fragment_unnamed_600 = abs(fragment_unnamed_556) >= fragment_unnamed_246;
								bool fragment_unnamed_601 = abs(fragment_unnamed_561) >= fragment_unnamed_246;
								precise float fragment_unnamed_602 = (-0.0f) - fragment_unnamed_191;
								precise float fragment_unnamed_607 = (-0.0f) - fragment_unnamed_197;
								fragment_unnamed_482 = fragment_unnamed_556;
								fragment_unnamed_483 = asfloat(fragment_unnamed_600 ? fragment_unnamed_536 : asuint(mad(fragment_unnamed_602, 12.0f, fragment_unnamed_537)));
								fragment_unnamed_484 = asfloat(fragment_unnamed_600 ? fragment_unnamed_541 : asuint(mad(fragment_unnamed_607, 12.0f, fragment_unnamed_542)));
								fragment_unnamed_485 = asfloat(fragment_unnamed_601 ? fragment_unnamed_548 : asuint(mad(fragment_unnamed_191, 12.0f, fragment_unnamed_549)));
								fragment_unnamed_486 = asfloat(fragment_unnamed_601 ? fragment_unnamed_552 : asuint(mad(fragment_unnamed_197, 12.0f, fragment_unnamed_553)));
								fragment_unnamed_487 = fragment_unnamed_561;
							}
							else
							{
								fragment_unnamed_482 = fragment_unnamed_519;
								fragment_unnamed_483 = fragment_unnamed_537;
								fragment_unnamed_484 = fragment_unnamed_542;
								fragment_unnamed_485 = fragment_unnamed_549;
								fragment_unnamed_486 = fragment_unnamed_553;
								fragment_unnamed_487 = fragment_unnamed_525;
							}
							fragment_unnamed_339 = fragment_unnamed_482;
							fragment_unnamed_341 = fragment_unnamed_483;
							fragment_unnamed_343 = fragment_unnamed_484;
							fragment_unnamed_345 = fragment_unnamed_485;
							fragment_unnamed_347 = fragment_unnamed_486;
							fragment_unnamed_349 = fragment_unnamed_487;
						}
						else
						{
							fragment_unnamed_339 = fragment_unnamed_446;
							fragment_unnamed_341 = fragment_unnamed_463;
							fragment_unnamed_343 = fragment_unnamed_468;
							fragment_unnamed_345 = fragment_unnamed_475;
							fragment_unnamed_347 = fragment_unnamed_479;
							fragment_unnamed_349 = fragment_unnamed_452;
						}
						fragment_unnamed_338 = fragment_unnamed_339;
						fragment_unnamed_340 = fragment_unnamed_341;
						fragment_unnamed_342 = fragment_unnamed_343;
						fragment_unnamed_344 = fragment_unnamed_345;
						fragment_unnamed_346 = fragment_unnamed_347;
						fragment_unnamed_348 = fragment_unnamed_349;
					}
					else
					{
						fragment_unnamed_338 = fragment_unnamed_254;
						fragment_unnamed_340 = fragment_unnamed_268;
						fragment_unnamed_342 = fragment_unnamed_273;
						fragment_unnamed_344 = fragment_unnamed_281;
						fragment_unnamed_346 = fragment_unnamed_286;
						fragment_unnamed_348 = fragment_unnamed_256;
					}
					precise float fragment_unnamed_350 = (-0.0f) - fragment_unnamed_340;
					precise float fragment_unnamed_353 = fragment_unnamed_350 + fragment_input_1.x;
					precise float fragment_unnamed_356 = (-0.0f) - fragment_input_1.x;
					precise float fragment_unnamed_357 = fragment_unnamed_344 + fragment_unnamed_356;
					precise float fragment_unnamed_358 = (-0.0f) - fragment_unnamed_342;
					precise float fragment_unnamed_361 = fragment_unnamed_358 + fragment_input_1.y;
					float fragment_unnamed_365 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_353) : asuint(fragment_unnamed_361));
					precise float fragment_unnamed_368 = (-0.0f) - fragment_input_1.y;
					precise float fragment_unnamed_369 = fragment_unnamed_346 + fragment_unnamed_368;
					float fragment_unnamed_373 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_357) : asuint(fragment_unnamed_369));
					precise float fragment_unnamed_378 = fragment_unnamed_365 + fragment_unnamed_373;
					precise float fragment_unnamed_383 = 1.0f / fragment_unnamed_378;
					precise float fragment_unnamed_387 = fragment_unnamed_250 * fragment_unnamed_250;
					precise float fragment_unnamed_388 = (-0.0f) - fragment_unnamed_383;
					float fragment_unnamed_393 = max(fragment_unnamed_387, asfloat(asuint(mad(min(fragment_unnamed_373, fragment_unnamed_365), fragment_unnamed_388, 0.5f)) & ((fragment_unnamed_365 < fragment_unnamed_373) ? ((fragment_unnamed_252 != ((fragment_unnamed_338 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_252 != ((fragment_unnamed_348 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					precise float fragment_unnamed_411 = clamp(fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_393, fragment_unnamed_182, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_412 = clamp(fragment_unnamed_142 ? mad(fragment_unnamed_393, fragment_unnamed_182, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float4 fragment_unnamed_414 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_411, fragment_unnamed_412), 0.0f);
					fragment_unnamed_288 = fragment_unnamed_414.z;
					fragment_unnamed_290 = fragment_unnamed_414.y;
					fragment_unnamed_292 = fragment_unnamed_414.x;
				}
				else
				{
					fragment_unnamed_288 = fragment_unnamed_54.z;
					fragment_unnamed_290 = fragment_unnamed_54.y;
					fragment_unnamed_292 = fragment_unnamed_54.x;
				}
				float fragment_unnamed_313 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				precise float fragment_unnamed_320 = (-0.0f) - abs(fragment_unnamed_313);
				precise float fragment_unnamed_321 = fragment_unnamed_320 + 1.0f;
				precise float fragment_unnamed_323 = (-0.0f) - sqrt(fragment_unnamed_321);
				precise float fragment_unnamed_324 = fragment_unnamed_323 + 1.0f;
				precise float fragment_unnamed_325 = fragment_unnamed_324 * mad(clamp(mad(fragment_unnamed_313, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_292);
				fragment_output_0.y = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_290);
				fragment_output_0.z = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_288);
				fragment_output_0.w = fragment_unnamed_59;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[29] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA_LOW) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA)


			#if defined(FXAA_LOW) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float _DepthSlice;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
			static float4 gl_Position;
			static uint gl_Layer;
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
				uint gl_Layer : SV_RenderTargetArrayIndex;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_44 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_45 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_52 = vertex_unnamed_44 * vertex_uniform_buffer_0[27u].x;
				precise float vertex_unnamed_53 = vertex_unnamed_45 * vertex_uniform_buffer_0[27u].y;
				float vertex_unnamed_59 = mad(vertex_unnamed_52, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_61 = mad(vertex_unnamed_53, 0.5f, vertex_uniform_buffer_0[27u].w);
				precise float vertex_unnamed_66 = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_67 = vertex_unnamed_61 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_66;
				vertex_output_1.y = vertex_unnamed_67;
				vertex_output_1.x = vertex_unnamed_59;
				vertex_output_1.y = vertex_unnamed_61;
				gl_Layer = int(uint(vertex_uniform_buffer_0[26u].y));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[26] = float4(vertex_uniform_buffer_0[26][0], _DepthSlice, vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.gl_Layer = gl_Layer;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				precise float fragment_unnamed_52 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_53 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_56 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f);
				float fragment_unnamed_61 = fragment_unnamed_56.w;
				float4 fragment_unnamed_65 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(0, 1));
				float fragment_unnamed_69 = fragment_unnamed_65.w;
				float4 fragment_unnamed_70 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, 0));
				float fragment_unnamed_73 = fragment_unnamed_70.w;
				float4 fragment_unnamed_75 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(0, -1));
				float fragment_unnamed_78 = fragment_unnamed_75.w;
				float4 fragment_unnamed_79 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, 0));
				float fragment_unnamed_82 = fragment_unnamed_79.w;
				float fragment_unnamed_89 = max(max(max(fragment_unnamed_61, fragment_unnamed_69), fragment_unnamed_73), max(fragment_unnamed_78, fragment_unnamed_82));
				precise float fragment_unnamed_91 = fragment_unnamed_89 * 0.16599999368190765380859375f;
				precise float fragment_unnamed_93 = (-0.0f) - min(min(min(fragment_unnamed_61, fragment_unnamed_69), fragment_unnamed_73), min(fragment_unnamed_78, fragment_unnamed_82));
				precise float fragment_unnamed_95 = fragment_unnamed_93 + fragment_unnamed_89;
				float fragment_unnamed_290;
				float fragment_unnamed_292;
				float fragment_unnamed_294;
				if (fragment_unnamed_95 >= max(fragment_unnamed_91, 0.0625f))
				{
					float4 fragment_unnamed_101 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, -1));
					float fragment_unnamed_104 = fragment_unnamed_101.w;
					float4 fragment_unnamed_105 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, 1));
					float fragment_unnamed_108 = fragment_unnamed_105.w;
					float4 fragment_unnamed_109 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, -1));
					float fragment_unnamed_112 = fragment_unnamed_109.w;
					float4 fragment_unnamed_113 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, 1));
					float fragment_unnamed_116 = fragment_unnamed_113.w;
					precise float fragment_unnamed_117 = fragment_unnamed_69 + fragment_unnamed_78;
					precise float fragment_unnamed_118 = fragment_unnamed_73 + fragment_unnamed_82;
					precise float fragment_unnamed_119 = 1.0f / fragment_unnamed_95;
					precise float fragment_unnamed_120 = fragment_unnamed_118 + fragment_unnamed_117;
					precise float fragment_unnamed_124 = fragment_unnamed_108 + fragment_unnamed_112;
					precise float fragment_unnamed_125 = fragment_unnamed_104 + fragment_unnamed_112;
					precise float fragment_unnamed_128 = fragment_unnamed_104 + fragment_unnamed_116;
					precise float fragment_unnamed_129 = fragment_unnamed_108 + fragment_unnamed_116;
					precise float fragment_unnamed_141 = mad(abs(mad(fragment_unnamed_61, -2.0f, fragment_unnamed_117)), 2.0f, abs(mad(fragment_unnamed_73, -2.0f, fragment_unnamed_124))) + abs(mad(fragment_unnamed_82, -2.0f, fragment_unnamed_128));
					precise float fragment_unnamed_142 = mad(abs(mad(fragment_unnamed_61, -2.0f, fragment_unnamed_118)), 2.0f, abs(mad(fragment_unnamed_78, -2.0f, fragment_unnamed_125))) + abs(mad(fragment_unnamed_69, -2.0f, fragment_unnamed_129));
					precise float fragment_unnamed_143 = fragment_unnamed_124 + fragment_unnamed_128;
					bool fragment_unnamed_144 = fragment_unnamed_141 >= fragment_unnamed_142;
					float fragment_unnamed_151 = asfloat(fragment_unnamed_144 ? asuint(fragment_unnamed_78) : asuint(fragment_unnamed_82));
					float fragment_unnamed_155 = asfloat(fragment_unnamed_144 ? asuint(fragment_unnamed_69) : asuint(fragment_unnamed_73));
					float fragment_unnamed_167 = asfloat(fragment_unnamed_144 ? asuint(fragment_uniform_buffer_0[29u]).y : asuint(fragment_uniform_buffer_0[29u]).x);
					precise float fragment_unnamed_168 = (-0.0f) - fragment_unnamed_61;
					precise float fragment_unnamed_171 = (-0.0f) - fragment_unnamed_61;
					precise float fragment_unnamed_172 = fragment_unnamed_171 + fragment_unnamed_151;
					precise float fragment_unnamed_173 = (-0.0f) - fragment_unnamed_61;
					precise float fragment_unnamed_174 = fragment_unnamed_173 + fragment_unnamed_155;
					precise float fragment_unnamed_175 = fragment_unnamed_61 + fragment_unnamed_151;
					precise float fragment_unnamed_176 = fragment_unnamed_61 + fragment_unnamed_155;
					bool fragment_unnamed_179 = abs(fragment_unnamed_172) >= abs(fragment_unnamed_174);
					precise float fragment_unnamed_183 = (-0.0f) - fragment_unnamed_167;
					float fragment_unnamed_184 = fragment_unnamed_179 ? fragment_unnamed_183 : fragment_unnamed_167;
					precise float fragment_unnamed_186 = fragment_unnamed_119 * abs(mad(mad(fragment_unnamed_120, 2.0f, fragment_unnamed_143), 0.083333335816860198974609375f, fragment_unnamed_168));
					float fragment_unnamed_187 = clamp(fragment_unnamed_186, 0.0f, 1.0f);
					float fragment_unnamed_193 = asfloat((fragment_unnamed_144 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_199 = asfloat(fragment_unnamed_144 ? 0u : asuint(fragment_uniform_buffer_0[29u]).y);
					float fragment_unnamed_209 = fragment_unnamed_144 ? fragment_input_1.x : mad(fragment_unnamed_184, 0.5f, fragment_input_1.x);
					float fragment_unnamed_212 = fragment_unnamed_144 ? mad(fragment_unnamed_184, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					precise float fragment_unnamed_213 = (-0.0f) - fragment_unnamed_193;
					precise float fragment_unnamed_214 = fragment_unnamed_213 + fragment_unnamed_209;
					precise float fragment_unnamed_216 = (-0.0f) - fragment_unnamed_199;
					precise float fragment_unnamed_217 = fragment_unnamed_216 + fragment_unnamed_212;
					precise float fragment_unnamed_219 = fragment_unnamed_193 + fragment_unnamed_209;
					precise float fragment_unnamed_220 = fragment_unnamed_199 + fragment_unnamed_212;
					precise float fragment_unnamed_228 = clamp(fragment_unnamed_214, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_229 = clamp(fragment_unnamed_217, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_233 = fragment_unnamed_187 * fragment_unnamed_187;
					precise float fragment_unnamed_239 = clamp(fragment_unnamed_219, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_240 = clamp(fragment_unnamed_220, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float fragment_unnamed_247 = asfloat(fragment_unnamed_179 ? asuint(fragment_unnamed_175) : asuint(fragment_unnamed_176));
					precise float fragment_unnamed_248 = max(abs(fragment_unnamed_174), abs(fragment_unnamed_172)) * 0.25f;
					precise float fragment_unnamed_250 = (-0.0f) - fragment_unnamed_247;
					precise float fragment_unnamed_252 = fragment_unnamed_233 * mad(fragment_unnamed_187, -2.0f, 3.0f);
					uint fragment_unnamed_254 = (mad(fragment_unnamed_250, 0.5f, fragment_unnamed_61) < 0.0f) ? 4294967295u : 0u;
					precise float fragment_unnamed_255 = (-0.0f) - fragment_unnamed_247;
					float fragment_unnamed_256 = mad(fragment_unnamed_255, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_228, fragment_unnamed_229), 0.0f).w);
					precise float fragment_unnamed_257 = (-0.0f) - fragment_unnamed_247;
					float fragment_unnamed_258 = mad(fragment_unnamed_257, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_239, fragment_unnamed_240), 0.0f).w);
					bool fragment_unnamed_261 = abs(fragment_unnamed_256) >= fragment_unnamed_248;
					bool fragment_unnamed_262 = abs(fragment_unnamed_258) >= fragment_unnamed_248;
					uint fragment_unnamed_263 = fragment_unnamed_261 ? 4294967295u : 0u;
					uint fragment_unnamed_264 = fragment_unnamed_262 ? 4294967295u : 0u;
					precise float fragment_unnamed_265 = (-0.0f) - fragment_unnamed_193;
					uint fragment_unnamed_269 = fragment_unnamed_261 ? asuint(fragment_unnamed_214) : asuint(mad(fragment_unnamed_265, 1.5f, fragment_unnamed_214));
					float fragment_unnamed_270 = asfloat(fragment_unnamed_269);
					precise float fragment_unnamed_271 = (-0.0f) - fragment_unnamed_199;
					uint fragment_unnamed_274 = fragment_unnamed_261 ? asuint(fragment_unnamed_217) : asuint(mad(fragment_unnamed_271, 1.5f, fragment_unnamed_217));
					float fragment_unnamed_275 = asfloat(fragment_unnamed_274);
					uint fragment_unnamed_282 = fragment_unnamed_262 ? asuint(fragment_unnamed_219) : asuint(mad(fragment_unnamed_193, 1.5f, fragment_unnamed_219));
					float fragment_unnamed_283 = asfloat(fragment_unnamed_282);
					uint fragment_unnamed_287 = fragment_unnamed_262 ? asuint(fragment_unnamed_220) : asuint(mad(fragment_unnamed_199, 1.5f, fragment_unnamed_220));
					float fragment_unnamed_288 = asfloat(fragment_unnamed_287);
					float fragment_unnamed_340;
					float fragment_unnamed_342;
					float fragment_unnamed_344;
					float fragment_unnamed_346;
					float fragment_unnamed_348;
					float fragment_unnamed_350;
					if (((~fragment_unnamed_264) | (~fragment_unnamed_263)) != 0u)
					{
						float fragment_unnamed_429;
						if (fragment_unnamed_263 == 0u)
						{
							precise float fragment_unnamed_423 = clamp(fragment_unnamed_270, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_424 = clamp(fragment_unnamed_275, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_429 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_423, fragment_unnamed_424), 0.0f).w;
						}
						else
						{
							fragment_unnamed_429 = fragment_unnamed_256;
						}
						float fragment_unnamed_442;
						if (fragment_unnamed_264 == 0u)
						{
							precise float fragment_unnamed_436 = clamp(fragment_unnamed_283, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_437 = clamp(fragment_unnamed_288, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_442 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_436, fragment_unnamed_437), 0.0f).w;
						}
						else
						{
							fragment_unnamed_442 = fragment_unnamed_258;
						}
						precise float fragment_unnamed_443 = (-0.0f) - fragment_unnamed_247;
						uint fragment_unnamed_447 = fragment_unnamed_261 ? asuint(fragment_unnamed_429) : asuint(mad(fragment_unnamed_443, 0.5f, fragment_unnamed_429));
						float fragment_unnamed_448 = asfloat(fragment_unnamed_447);
						precise float fragment_unnamed_449 = (-0.0f) - fragment_unnamed_247;
						float fragment_unnamed_454 = asfloat(fragment_unnamed_262 ? asuint(fragment_unnamed_442) : asuint(mad(fragment_unnamed_449, 0.5f, fragment_unnamed_442)));
						bool fragment_unnamed_457 = abs(fragment_unnamed_448) >= fragment_unnamed_248;
						bool fragment_unnamed_458 = abs(fragment_unnamed_454) >= fragment_unnamed_248;
						uint fragment_unnamed_459 = fragment_unnamed_457 ? 4294967295u : 0u;
						uint fragment_unnamed_460 = fragment_unnamed_458 ? 4294967295u : 0u;
						precise float fragment_unnamed_461 = (-0.0f) - fragment_unnamed_193;
						uint fragment_unnamed_464 = fragment_unnamed_457 ? fragment_unnamed_269 : asuint(mad(fragment_unnamed_461, 2.0f, fragment_unnamed_270));
						float fragment_unnamed_465 = asfloat(fragment_unnamed_464);
						precise float fragment_unnamed_466 = (-0.0f) - fragment_unnamed_199;
						uint fragment_unnamed_469 = fragment_unnamed_457 ? fragment_unnamed_274 : asuint(mad(fragment_unnamed_466, 2.0f, fragment_unnamed_275));
						float fragment_unnamed_470 = asfloat(fragment_unnamed_469);
						uint fragment_unnamed_476 = fragment_unnamed_458 ? fragment_unnamed_282 : asuint(mad(fragment_unnamed_193, 2.0f, fragment_unnamed_283));
						float fragment_unnamed_477 = asfloat(fragment_unnamed_476);
						uint fragment_unnamed_480 = fragment_unnamed_458 ? fragment_unnamed_287 : asuint(mad(fragment_unnamed_199, 2.0f, fragment_unnamed_288));
						float fragment_unnamed_481 = asfloat(fragment_unnamed_480);
						float fragment_unnamed_341;
						float fragment_unnamed_343;
						float fragment_unnamed_345;
						float fragment_unnamed_347;
						float fragment_unnamed_349;
						float fragment_unnamed_351;
						if (((~fragment_unnamed_460) | (~fragment_unnamed_459)) != 0u)
						{
							float fragment_unnamed_502;
							if (fragment_unnamed_459 == 0u)
							{
								precise float fragment_unnamed_495 = clamp(fragment_unnamed_465, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_496 = clamp(fragment_unnamed_470, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_502 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_495, fragment_unnamed_496), 0.0f).w;
							}
							else
							{
								fragment_unnamed_502 = asfloat(fragment_unnamed_447);
							}
							float fragment_unnamed_515;
							if (fragment_unnamed_460 == 0u)
							{
								precise float fragment_unnamed_509 = clamp(fragment_unnamed_477, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_510 = clamp(fragment_unnamed_481, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_515 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_509, fragment_unnamed_510), 0.0f).w;
							}
							else
							{
								fragment_unnamed_515 = fragment_unnamed_454;
							}
							precise float fragment_unnamed_516 = (-0.0f) - fragment_unnamed_247;
							uint fragment_unnamed_520 = fragment_unnamed_457 ? asuint(fragment_unnamed_502) : asuint(mad(fragment_unnamed_516, 0.5f, fragment_unnamed_502));
							float fragment_unnamed_521 = asfloat(fragment_unnamed_520);
							precise float fragment_unnamed_522 = (-0.0f) - fragment_unnamed_247;
							float fragment_unnamed_527 = asfloat(fragment_unnamed_458 ? asuint(fragment_unnamed_515) : asuint(mad(fragment_unnamed_522, 0.5f, fragment_unnamed_515)));
							bool fragment_unnamed_530 = abs(fragment_unnamed_521) >= fragment_unnamed_248;
							bool fragment_unnamed_531 = abs(fragment_unnamed_527) >= fragment_unnamed_248;
							uint fragment_unnamed_532 = fragment_unnamed_530 ? 4294967295u : 0u;
							uint fragment_unnamed_533 = fragment_unnamed_531 ? 4294967295u : 0u;
							precise float fragment_unnamed_534 = (-0.0f) - fragment_unnamed_193;
							uint fragment_unnamed_538 = fragment_unnamed_530 ? fragment_unnamed_464 : asuint(mad(fragment_unnamed_534, 4.0f, fragment_unnamed_465));
							float fragment_unnamed_539 = asfloat(fragment_unnamed_538);
							precise float fragment_unnamed_540 = (-0.0f) - fragment_unnamed_199;
							uint fragment_unnamed_543 = fragment_unnamed_530 ? fragment_unnamed_469 : asuint(mad(fragment_unnamed_540, 4.0f, fragment_unnamed_470));
							float fragment_unnamed_544 = asfloat(fragment_unnamed_543);
							uint fragment_unnamed_550 = fragment_unnamed_531 ? fragment_unnamed_476 : asuint(mad(fragment_unnamed_193, 4.0f, fragment_unnamed_477));
							float fragment_unnamed_551 = asfloat(fragment_unnamed_550);
							uint fragment_unnamed_554 = fragment_unnamed_531 ? fragment_unnamed_480 : asuint(mad(fragment_unnamed_199, 4.0f, fragment_unnamed_481));
							float fragment_unnamed_555 = asfloat(fragment_unnamed_554);
							float fragment_unnamed_484;
							float fragment_unnamed_485;
							float fragment_unnamed_486;
							float fragment_unnamed_487;
							float fragment_unnamed_488;
							float fragment_unnamed_489;
							if (((~fragment_unnamed_533) | (~fragment_unnamed_532)) != 0u)
							{
								float fragment_unnamed_576;
								if (fragment_unnamed_532 == 0u)
								{
									precise float fragment_unnamed_569 = clamp(fragment_unnamed_539, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_570 = clamp(fragment_unnamed_544, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_576 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_569, fragment_unnamed_570), 0.0f).w;
								}
								else
								{
									fragment_unnamed_576 = asfloat(fragment_unnamed_520);
								}
								float fragment_unnamed_589;
								if (fragment_unnamed_533 == 0u)
								{
									precise float fragment_unnamed_583 = clamp(fragment_unnamed_551, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_584 = clamp(fragment_unnamed_555, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_589 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_583, fragment_unnamed_584), 0.0f).w;
								}
								else
								{
									fragment_unnamed_589 = fragment_unnamed_527;
								}
								precise float fragment_unnamed_590 = (-0.0f) - fragment_unnamed_247;
								float fragment_unnamed_558 = asfloat(fragment_unnamed_530 ? asuint(fragment_unnamed_576) : asuint(mad(fragment_unnamed_590, 0.5f, fragment_unnamed_576)));
								precise float fragment_unnamed_595 = (-0.0f) - fragment_unnamed_247;
								float fragment_unnamed_563 = asfloat(fragment_unnamed_531 ? asuint(fragment_unnamed_589) : asuint(mad(fragment_unnamed_595, 0.5f, fragment_unnamed_589)));
								bool fragment_unnamed_602 = abs(fragment_unnamed_558) >= fragment_unnamed_248;
								bool fragment_unnamed_603 = abs(fragment_unnamed_563) >= fragment_unnamed_248;
								precise float fragment_unnamed_604 = (-0.0f) - fragment_unnamed_193;
								precise float fragment_unnamed_609 = (-0.0f) - fragment_unnamed_199;
								fragment_unnamed_484 = fragment_unnamed_558;
								fragment_unnamed_485 = asfloat(fragment_unnamed_602 ? fragment_unnamed_538 : asuint(mad(fragment_unnamed_604, 12.0f, fragment_unnamed_539)));
								fragment_unnamed_486 = asfloat(fragment_unnamed_602 ? fragment_unnamed_543 : asuint(mad(fragment_unnamed_609, 12.0f, fragment_unnamed_544)));
								fragment_unnamed_487 = asfloat(fragment_unnamed_603 ? fragment_unnamed_550 : asuint(mad(fragment_unnamed_193, 12.0f, fragment_unnamed_551)));
								fragment_unnamed_488 = asfloat(fragment_unnamed_603 ? fragment_unnamed_554 : asuint(mad(fragment_unnamed_199, 12.0f, fragment_unnamed_555)));
								fragment_unnamed_489 = fragment_unnamed_563;
							}
							else
							{
								fragment_unnamed_484 = fragment_unnamed_521;
								fragment_unnamed_485 = fragment_unnamed_539;
								fragment_unnamed_486 = fragment_unnamed_544;
								fragment_unnamed_487 = fragment_unnamed_551;
								fragment_unnamed_488 = fragment_unnamed_555;
								fragment_unnamed_489 = fragment_unnamed_527;
							}
							fragment_unnamed_341 = fragment_unnamed_484;
							fragment_unnamed_343 = fragment_unnamed_485;
							fragment_unnamed_345 = fragment_unnamed_486;
							fragment_unnamed_347 = fragment_unnamed_487;
							fragment_unnamed_349 = fragment_unnamed_488;
							fragment_unnamed_351 = fragment_unnamed_489;
						}
						else
						{
							fragment_unnamed_341 = fragment_unnamed_448;
							fragment_unnamed_343 = fragment_unnamed_465;
							fragment_unnamed_345 = fragment_unnamed_470;
							fragment_unnamed_347 = fragment_unnamed_477;
							fragment_unnamed_349 = fragment_unnamed_481;
							fragment_unnamed_351 = fragment_unnamed_454;
						}
						fragment_unnamed_340 = fragment_unnamed_341;
						fragment_unnamed_342 = fragment_unnamed_343;
						fragment_unnamed_344 = fragment_unnamed_345;
						fragment_unnamed_346 = fragment_unnamed_347;
						fragment_unnamed_348 = fragment_unnamed_349;
						fragment_unnamed_350 = fragment_unnamed_351;
					}
					else
					{
						fragment_unnamed_340 = fragment_unnamed_256;
						fragment_unnamed_342 = fragment_unnamed_270;
						fragment_unnamed_344 = fragment_unnamed_275;
						fragment_unnamed_346 = fragment_unnamed_283;
						fragment_unnamed_348 = fragment_unnamed_288;
						fragment_unnamed_350 = fragment_unnamed_258;
					}
					precise float fragment_unnamed_352 = (-0.0f) - fragment_unnamed_342;
					precise float fragment_unnamed_355 = fragment_unnamed_352 + fragment_input_1.x;
					precise float fragment_unnamed_358 = (-0.0f) - fragment_input_1.x;
					precise float fragment_unnamed_359 = fragment_unnamed_346 + fragment_unnamed_358;
					precise float fragment_unnamed_360 = (-0.0f) - fragment_unnamed_344;
					precise float fragment_unnamed_363 = fragment_unnamed_360 + fragment_input_1.y;
					float fragment_unnamed_367 = asfloat(fragment_unnamed_144 ? asuint(fragment_unnamed_355) : asuint(fragment_unnamed_363));
					precise float fragment_unnamed_370 = (-0.0f) - fragment_input_1.y;
					precise float fragment_unnamed_371 = fragment_unnamed_348 + fragment_unnamed_370;
					float fragment_unnamed_375 = asfloat(fragment_unnamed_144 ? asuint(fragment_unnamed_359) : asuint(fragment_unnamed_371));
					precise float fragment_unnamed_380 = fragment_unnamed_367 + fragment_unnamed_375;
					precise float fragment_unnamed_385 = 1.0f / fragment_unnamed_380;
					precise float fragment_unnamed_389 = fragment_unnamed_252 * fragment_unnamed_252;
					precise float fragment_unnamed_390 = (-0.0f) - fragment_unnamed_385;
					float fragment_unnamed_395 = max(fragment_unnamed_389, asfloat(asuint(mad(min(fragment_unnamed_375, fragment_unnamed_367), fragment_unnamed_390, 0.5f)) & ((fragment_unnamed_367 < fragment_unnamed_375) ? ((fragment_unnamed_254 != ((fragment_unnamed_340 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_254 != ((fragment_unnamed_350 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					precise float fragment_unnamed_413 = clamp(fragment_unnamed_144 ? fragment_input_1.x : mad(fragment_unnamed_395, fragment_unnamed_184, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_414 = clamp(fragment_unnamed_144 ? mad(fragment_unnamed_395, fragment_unnamed_184, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float4 fragment_unnamed_416 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_413, fragment_unnamed_414), 0.0f);
					fragment_unnamed_290 = fragment_unnamed_416.z;
					fragment_unnamed_292 = fragment_unnamed_416.y;
					fragment_unnamed_294 = fragment_unnamed_416.x;
				}
				else
				{
					fragment_unnamed_290 = fragment_unnamed_56.z;
					fragment_unnamed_292 = fragment_unnamed_56.y;
					fragment_unnamed_294 = fragment_unnamed_56.x;
				}
				float fragment_unnamed_315 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				precise float fragment_unnamed_322 = (-0.0f) - abs(fragment_unnamed_315);
				precise float fragment_unnamed_323 = fragment_unnamed_322 + 1.0f;
				precise float fragment_unnamed_325 = (-0.0f) - sqrt(fragment_unnamed_323);
				precise float fragment_unnamed_326 = fragment_unnamed_325 + 1.0f;
				precise float fragment_unnamed_327 = fragment_unnamed_326 * mad(clamp(mad(fragment_unnamed_315, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_327, 0.0039215688593685626983642578125f, fragment_unnamed_294);
				fragment_output_0.y = mad(fragment_unnamed_327, 0.0039215688593685626983642578125f, fragment_unnamed_292);
				fragment_output_0.z = mad(fragment_unnamed_327, 0.0039215688593685626983642578125f, fragment_unnamed_290);
				fragment_output_0.w = fragment_unnamed_61;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[29] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA_LOW) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA)


			#if defined(FXAA_LOW) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;
			float4 _PosScaleOffset;

			static float4 vertex_uniform_buffer_0[29];
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
				gl_Position.x = mad(vertex_input_0.x, vertex_uniform_buffer_0[28u].x, vertex_uniform_buffer_0[28u].z);
				gl_Position.y = mad(vertex_input_0.y, vertex_uniform_buffer_0[28u].y, vertex_uniform_buffer_0[28u].w);
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_55 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_56 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_62 = vertex_unnamed_55 * vertex_uniform_buffer_0[27u].x;
				precise float vertex_unnamed_63 = vertex_unnamed_56 * vertex_uniform_buffer_0[27u].y;
				float vertex_unnamed_68 = mad(vertex_unnamed_62, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_70 = mad(vertex_unnamed_63, 0.5f, vertex_uniform_buffer_0[27u].w);
				precise float vertex_unnamed_75 = vertex_unnamed_68 * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_76 = vertex_unnamed_70 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_75;
				vertex_output_1.y = vertex_unnamed_76;
				vertex_output_1.x = vertex_unnamed_68;
				vertex_output_1.y = vertex_unnamed_70;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_uniform_buffer_0[28] = float4(_PosScaleOffset[0], _PosScaleOffset[1], _PosScaleOffset[2], _PosScaleOffset[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[31];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				precise float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f);
				float fragment_unnamed_59 = fragment_unnamed_54.w;
				float4 fragment_unnamed_63 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, 1));
				float fragment_unnamed_67 = fragment_unnamed_63.w;
				float4 fragment_unnamed_68 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 0));
				float fragment_unnamed_71 = fragment_unnamed_68.w;
				float4 fragment_unnamed_73 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, -1));
				float fragment_unnamed_76 = fragment_unnamed_73.w;
				float4 fragment_unnamed_77 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 0));
				float fragment_unnamed_80 = fragment_unnamed_77.w;
				float fragment_unnamed_87 = max(max(max(fragment_unnamed_59, fragment_unnamed_67), fragment_unnamed_71), max(fragment_unnamed_76, fragment_unnamed_80));
				precise float fragment_unnamed_89 = fragment_unnamed_87 * 0.16599999368190765380859375f;
				precise float fragment_unnamed_91 = (-0.0f) - min(min(min(fragment_unnamed_59, fragment_unnamed_67), fragment_unnamed_71), min(fragment_unnamed_76, fragment_unnamed_80));
				precise float fragment_unnamed_93 = fragment_unnamed_91 + fragment_unnamed_87;
				float fragment_unnamed_288;
				float fragment_unnamed_290;
				float fragment_unnamed_292;
				if (fragment_unnamed_93 >= max(fragment_unnamed_89, 0.0625f))
				{
					float4 fragment_unnamed_99 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, -1));
					float fragment_unnamed_102 = fragment_unnamed_99.w;
					float4 fragment_unnamed_103 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 1));
					float fragment_unnamed_106 = fragment_unnamed_103.w;
					float4 fragment_unnamed_107 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, -1));
					float fragment_unnamed_110 = fragment_unnamed_107.w;
					float4 fragment_unnamed_111 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 1));
					float fragment_unnamed_114 = fragment_unnamed_111.w;
					precise float fragment_unnamed_115 = fragment_unnamed_67 + fragment_unnamed_76;
					precise float fragment_unnamed_116 = fragment_unnamed_71 + fragment_unnamed_80;
					precise float fragment_unnamed_117 = 1.0f / fragment_unnamed_93;
					precise float fragment_unnamed_118 = fragment_unnamed_116 + fragment_unnamed_115;
					precise float fragment_unnamed_122 = fragment_unnamed_106 + fragment_unnamed_110;
					precise float fragment_unnamed_123 = fragment_unnamed_102 + fragment_unnamed_110;
					precise float fragment_unnamed_126 = fragment_unnamed_102 + fragment_unnamed_114;
					precise float fragment_unnamed_127 = fragment_unnamed_106 + fragment_unnamed_114;
					precise float fragment_unnamed_139 = mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_115)), 2.0f, abs(mad(fragment_unnamed_71, -2.0f, fragment_unnamed_122))) + abs(mad(fragment_unnamed_80, -2.0f, fragment_unnamed_126));
					precise float fragment_unnamed_140 = mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_116)), 2.0f, abs(mad(fragment_unnamed_76, -2.0f, fragment_unnamed_123))) + abs(mad(fragment_unnamed_67, -2.0f, fragment_unnamed_127));
					precise float fragment_unnamed_141 = fragment_unnamed_122 + fragment_unnamed_126;
					bool fragment_unnamed_142 = fragment_unnamed_139 >= fragment_unnamed_140;
					float fragment_unnamed_149 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_76) : asuint(fragment_unnamed_80));
					float fragment_unnamed_153 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_67) : asuint(fragment_unnamed_71));
					float fragment_unnamed_165 = asfloat(fragment_unnamed_142 ? asuint(fragment_uniform_buffer_0[30u]).y : asuint(fragment_uniform_buffer_0[30u]).x);
					precise float fragment_unnamed_166 = (-0.0f) - fragment_unnamed_59;
					precise float fragment_unnamed_169 = (-0.0f) - fragment_unnamed_59;
					precise float fragment_unnamed_170 = fragment_unnamed_169 + fragment_unnamed_149;
					precise float fragment_unnamed_171 = (-0.0f) - fragment_unnamed_59;
					precise float fragment_unnamed_172 = fragment_unnamed_171 + fragment_unnamed_153;
					precise float fragment_unnamed_173 = fragment_unnamed_59 + fragment_unnamed_149;
					precise float fragment_unnamed_174 = fragment_unnamed_59 + fragment_unnamed_153;
					bool fragment_unnamed_177 = abs(fragment_unnamed_170) >= abs(fragment_unnamed_172);
					precise float fragment_unnamed_181 = (-0.0f) - fragment_unnamed_165;
					float fragment_unnamed_182 = fragment_unnamed_177 ? fragment_unnamed_181 : fragment_unnamed_165;
					precise float fragment_unnamed_184 = fragment_unnamed_117 * abs(mad(mad(fragment_unnamed_118, 2.0f, fragment_unnamed_141), 0.083333335816860198974609375f, fragment_unnamed_166));
					float fragment_unnamed_185 = clamp(fragment_unnamed_184, 0.0f, 1.0f);
					float fragment_unnamed_191 = asfloat((fragment_unnamed_142 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[30u]).x);
					float fragment_unnamed_197 = asfloat(fragment_unnamed_142 ? 0u : asuint(fragment_uniform_buffer_0[30u]).y);
					float fragment_unnamed_207 = fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_182, 0.5f, fragment_input_1.x);
					float fragment_unnamed_210 = fragment_unnamed_142 ? mad(fragment_unnamed_182, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					precise float fragment_unnamed_211 = (-0.0f) - fragment_unnamed_191;
					precise float fragment_unnamed_212 = fragment_unnamed_211 + fragment_unnamed_207;
					precise float fragment_unnamed_214 = (-0.0f) - fragment_unnamed_197;
					precise float fragment_unnamed_215 = fragment_unnamed_214 + fragment_unnamed_210;
					precise float fragment_unnamed_217 = fragment_unnamed_191 + fragment_unnamed_207;
					precise float fragment_unnamed_218 = fragment_unnamed_197 + fragment_unnamed_210;
					precise float fragment_unnamed_226 = clamp(fragment_unnamed_212, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_227 = clamp(fragment_unnamed_215, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_231 = fragment_unnamed_185 * fragment_unnamed_185;
					precise float fragment_unnamed_237 = clamp(fragment_unnamed_217, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_238 = clamp(fragment_unnamed_218, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float fragment_unnamed_245 = asfloat(fragment_unnamed_177 ? asuint(fragment_unnamed_173) : asuint(fragment_unnamed_174));
					precise float fragment_unnamed_246 = max(abs(fragment_unnamed_172), abs(fragment_unnamed_170)) * 0.25f;
					precise float fragment_unnamed_248 = (-0.0f) - fragment_unnamed_245;
					precise float fragment_unnamed_250 = fragment_unnamed_231 * mad(fragment_unnamed_185, -2.0f, 3.0f);
					uint fragment_unnamed_252 = (mad(fragment_unnamed_248, 0.5f, fragment_unnamed_59) < 0.0f) ? 4294967295u : 0u;
					precise float fragment_unnamed_253 = (-0.0f) - fragment_unnamed_245;
					float fragment_unnamed_254 = mad(fragment_unnamed_253, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_226, fragment_unnamed_227), 0.0f).w);
					precise float fragment_unnamed_255 = (-0.0f) - fragment_unnamed_245;
					float fragment_unnamed_256 = mad(fragment_unnamed_255, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_237, fragment_unnamed_238), 0.0f).w);
					bool fragment_unnamed_259 = abs(fragment_unnamed_254) >= fragment_unnamed_246;
					bool fragment_unnamed_260 = abs(fragment_unnamed_256) >= fragment_unnamed_246;
					uint fragment_unnamed_261 = fragment_unnamed_259 ? 4294967295u : 0u;
					uint fragment_unnamed_262 = fragment_unnamed_260 ? 4294967295u : 0u;
					precise float fragment_unnamed_263 = (-0.0f) - fragment_unnamed_191;
					uint fragment_unnamed_267 = fragment_unnamed_259 ? asuint(fragment_unnamed_212) : asuint(mad(fragment_unnamed_263, 1.5f, fragment_unnamed_212));
					float fragment_unnamed_268 = asfloat(fragment_unnamed_267);
					precise float fragment_unnamed_269 = (-0.0f) - fragment_unnamed_197;
					uint fragment_unnamed_272 = fragment_unnamed_259 ? asuint(fragment_unnamed_215) : asuint(mad(fragment_unnamed_269, 1.5f, fragment_unnamed_215));
					float fragment_unnamed_273 = asfloat(fragment_unnamed_272);
					uint fragment_unnamed_280 = fragment_unnamed_260 ? asuint(fragment_unnamed_217) : asuint(mad(fragment_unnamed_191, 1.5f, fragment_unnamed_217));
					float fragment_unnamed_281 = asfloat(fragment_unnamed_280);
					uint fragment_unnamed_285 = fragment_unnamed_260 ? asuint(fragment_unnamed_218) : asuint(mad(fragment_unnamed_197, 1.5f, fragment_unnamed_218));
					float fragment_unnamed_286 = asfloat(fragment_unnamed_285);
					float fragment_unnamed_338;
					float fragment_unnamed_340;
					float fragment_unnamed_342;
					float fragment_unnamed_344;
					float fragment_unnamed_346;
					float fragment_unnamed_348;
					if (((~fragment_unnamed_262) | (~fragment_unnamed_261)) != 0u)
					{
						float fragment_unnamed_427;
						if (fragment_unnamed_261 == 0u)
						{
							precise float fragment_unnamed_421 = clamp(fragment_unnamed_268, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_422 = clamp(fragment_unnamed_273, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_427 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_421, fragment_unnamed_422), 0.0f).w;
						}
						else
						{
							fragment_unnamed_427 = fragment_unnamed_254;
						}
						float fragment_unnamed_440;
						if (fragment_unnamed_262 == 0u)
						{
							precise float fragment_unnamed_434 = clamp(fragment_unnamed_281, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_435 = clamp(fragment_unnamed_286, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_440 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_434, fragment_unnamed_435), 0.0f).w;
						}
						else
						{
							fragment_unnamed_440 = fragment_unnamed_256;
						}
						precise float fragment_unnamed_441 = (-0.0f) - fragment_unnamed_245;
						uint fragment_unnamed_445 = fragment_unnamed_259 ? asuint(fragment_unnamed_427) : asuint(mad(fragment_unnamed_441, 0.5f, fragment_unnamed_427));
						float fragment_unnamed_446 = asfloat(fragment_unnamed_445);
						precise float fragment_unnamed_447 = (-0.0f) - fragment_unnamed_245;
						float fragment_unnamed_452 = asfloat(fragment_unnamed_260 ? asuint(fragment_unnamed_440) : asuint(mad(fragment_unnamed_447, 0.5f, fragment_unnamed_440)));
						bool fragment_unnamed_455 = abs(fragment_unnamed_446) >= fragment_unnamed_246;
						bool fragment_unnamed_456 = abs(fragment_unnamed_452) >= fragment_unnamed_246;
						uint fragment_unnamed_457 = fragment_unnamed_455 ? 4294967295u : 0u;
						uint fragment_unnamed_458 = fragment_unnamed_456 ? 4294967295u : 0u;
						precise float fragment_unnamed_459 = (-0.0f) - fragment_unnamed_191;
						uint fragment_unnamed_462 = fragment_unnamed_455 ? fragment_unnamed_267 : asuint(mad(fragment_unnamed_459, 2.0f, fragment_unnamed_268));
						float fragment_unnamed_463 = asfloat(fragment_unnamed_462);
						precise float fragment_unnamed_464 = (-0.0f) - fragment_unnamed_197;
						uint fragment_unnamed_467 = fragment_unnamed_455 ? fragment_unnamed_272 : asuint(mad(fragment_unnamed_464, 2.0f, fragment_unnamed_273));
						float fragment_unnamed_468 = asfloat(fragment_unnamed_467);
						uint fragment_unnamed_474 = fragment_unnamed_456 ? fragment_unnamed_280 : asuint(mad(fragment_unnamed_191, 2.0f, fragment_unnamed_281));
						float fragment_unnamed_475 = asfloat(fragment_unnamed_474);
						uint fragment_unnamed_478 = fragment_unnamed_456 ? fragment_unnamed_285 : asuint(mad(fragment_unnamed_197, 2.0f, fragment_unnamed_286));
						float fragment_unnamed_479 = asfloat(fragment_unnamed_478);
						float fragment_unnamed_339;
						float fragment_unnamed_341;
						float fragment_unnamed_343;
						float fragment_unnamed_345;
						float fragment_unnamed_347;
						float fragment_unnamed_349;
						if (((~fragment_unnamed_458) | (~fragment_unnamed_457)) != 0u)
						{
							float fragment_unnamed_500;
							if (fragment_unnamed_457 == 0u)
							{
								precise float fragment_unnamed_493 = clamp(fragment_unnamed_463, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_494 = clamp(fragment_unnamed_468, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_500 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_493, fragment_unnamed_494), 0.0f).w;
							}
							else
							{
								fragment_unnamed_500 = asfloat(fragment_unnamed_445);
							}
							float fragment_unnamed_513;
							if (fragment_unnamed_458 == 0u)
							{
								precise float fragment_unnamed_507 = clamp(fragment_unnamed_475, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_508 = clamp(fragment_unnamed_479, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_513 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_507, fragment_unnamed_508), 0.0f).w;
							}
							else
							{
								fragment_unnamed_513 = fragment_unnamed_452;
							}
							precise float fragment_unnamed_514 = (-0.0f) - fragment_unnamed_245;
							uint fragment_unnamed_518 = fragment_unnamed_455 ? asuint(fragment_unnamed_500) : asuint(mad(fragment_unnamed_514, 0.5f, fragment_unnamed_500));
							float fragment_unnamed_519 = asfloat(fragment_unnamed_518);
							precise float fragment_unnamed_520 = (-0.0f) - fragment_unnamed_245;
							float fragment_unnamed_525 = asfloat(fragment_unnamed_456 ? asuint(fragment_unnamed_513) : asuint(mad(fragment_unnamed_520, 0.5f, fragment_unnamed_513)));
							bool fragment_unnamed_528 = abs(fragment_unnamed_519) >= fragment_unnamed_246;
							bool fragment_unnamed_529 = abs(fragment_unnamed_525) >= fragment_unnamed_246;
							uint fragment_unnamed_530 = fragment_unnamed_528 ? 4294967295u : 0u;
							uint fragment_unnamed_531 = fragment_unnamed_529 ? 4294967295u : 0u;
							precise float fragment_unnamed_532 = (-0.0f) - fragment_unnamed_191;
							uint fragment_unnamed_536 = fragment_unnamed_528 ? fragment_unnamed_462 : asuint(mad(fragment_unnamed_532, 4.0f, fragment_unnamed_463));
							float fragment_unnamed_537 = asfloat(fragment_unnamed_536);
							precise float fragment_unnamed_538 = (-0.0f) - fragment_unnamed_197;
							uint fragment_unnamed_541 = fragment_unnamed_528 ? fragment_unnamed_467 : asuint(mad(fragment_unnamed_538, 4.0f, fragment_unnamed_468));
							float fragment_unnamed_542 = asfloat(fragment_unnamed_541);
							uint fragment_unnamed_548 = fragment_unnamed_529 ? fragment_unnamed_474 : asuint(mad(fragment_unnamed_191, 4.0f, fragment_unnamed_475));
							float fragment_unnamed_549 = asfloat(fragment_unnamed_548);
							uint fragment_unnamed_552 = fragment_unnamed_529 ? fragment_unnamed_478 : asuint(mad(fragment_unnamed_197, 4.0f, fragment_unnamed_479));
							float fragment_unnamed_553 = asfloat(fragment_unnamed_552);
							float fragment_unnamed_482;
							float fragment_unnamed_483;
							float fragment_unnamed_484;
							float fragment_unnamed_485;
							float fragment_unnamed_486;
							float fragment_unnamed_487;
							if (((~fragment_unnamed_531) | (~fragment_unnamed_530)) != 0u)
							{
								float fragment_unnamed_574;
								if (fragment_unnamed_530 == 0u)
								{
									precise float fragment_unnamed_567 = clamp(fragment_unnamed_537, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_568 = clamp(fragment_unnamed_542, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_574 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_567, fragment_unnamed_568), 0.0f).w;
								}
								else
								{
									fragment_unnamed_574 = asfloat(fragment_unnamed_518);
								}
								float fragment_unnamed_587;
								if (fragment_unnamed_531 == 0u)
								{
									precise float fragment_unnamed_581 = clamp(fragment_unnamed_549, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_582 = clamp(fragment_unnamed_553, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_587 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_581, fragment_unnamed_582), 0.0f).w;
								}
								else
								{
									fragment_unnamed_587 = fragment_unnamed_525;
								}
								precise float fragment_unnamed_588 = (-0.0f) - fragment_unnamed_245;
								float fragment_unnamed_556 = asfloat(fragment_unnamed_528 ? asuint(fragment_unnamed_574) : asuint(mad(fragment_unnamed_588, 0.5f, fragment_unnamed_574)));
								precise float fragment_unnamed_593 = (-0.0f) - fragment_unnamed_245;
								float fragment_unnamed_561 = asfloat(fragment_unnamed_529 ? asuint(fragment_unnamed_587) : asuint(mad(fragment_unnamed_593, 0.5f, fragment_unnamed_587)));
								bool fragment_unnamed_600 = abs(fragment_unnamed_556) >= fragment_unnamed_246;
								bool fragment_unnamed_601 = abs(fragment_unnamed_561) >= fragment_unnamed_246;
								precise float fragment_unnamed_602 = (-0.0f) - fragment_unnamed_191;
								precise float fragment_unnamed_607 = (-0.0f) - fragment_unnamed_197;
								fragment_unnamed_482 = fragment_unnamed_556;
								fragment_unnamed_483 = asfloat(fragment_unnamed_600 ? fragment_unnamed_536 : asuint(mad(fragment_unnamed_602, 12.0f, fragment_unnamed_537)));
								fragment_unnamed_484 = asfloat(fragment_unnamed_600 ? fragment_unnamed_541 : asuint(mad(fragment_unnamed_607, 12.0f, fragment_unnamed_542)));
								fragment_unnamed_485 = asfloat(fragment_unnamed_601 ? fragment_unnamed_548 : asuint(mad(fragment_unnamed_191, 12.0f, fragment_unnamed_549)));
								fragment_unnamed_486 = asfloat(fragment_unnamed_601 ? fragment_unnamed_552 : asuint(mad(fragment_unnamed_197, 12.0f, fragment_unnamed_553)));
								fragment_unnamed_487 = fragment_unnamed_561;
							}
							else
							{
								fragment_unnamed_482 = fragment_unnamed_519;
								fragment_unnamed_483 = fragment_unnamed_537;
								fragment_unnamed_484 = fragment_unnamed_542;
								fragment_unnamed_485 = fragment_unnamed_549;
								fragment_unnamed_486 = fragment_unnamed_553;
								fragment_unnamed_487 = fragment_unnamed_525;
							}
							fragment_unnamed_339 = fragment_unnamed_482;
							fragment_unnamed_341 = fragment_unnamed_483;
							fragment_unnamed_343 = fragment_unnamed_484;
							fragment_unnamed_345 = fragment_unnamed_485;
							fragment_unnamed_347 = fragment_unnamed_486;
							fragment_unnamed_349 = fragment_unnamed_487;
						}
						else
						{
							fragment_unnamed_339 = fragment_unnamed_446;
							fragment_unnamed_341 = fragment_unnamed_463;
							fragment_unnamed_343 = fragment_unnamed_468;
							fragment_unnamed_345 = fragment_unnamed_475;
							fragment_unnamed_347 = fragment_unnamed_479;
							fragment_unnamed_349 = fragment_unnamed_452;
						}
						fragment_unnamed_338 = fragment_unnamed_339;
						fragment_unnamed_340 = fragment_unnamed_341;
						fragment_unnamed_342 = fragment_unnamed_343;
						fragment_unnamed_344 = fragment_unnamed_345;
						fragment_unnamed_346 = fragment_unnamed_347;
						fragment_unnamed_348 = fragment_unnamed_349;
					}
					else
					{
						fragment_unnamed_338 = fragment_unnamed_254;
						fragment_unnamed_340 = fragment_unnamed_268;
						fragment_unnamed_342 = fragment_unnamed_273;
						fragment_unnamed_344 = fragment_unnamed_281;
						fragment_unnamed_346 = fragment_unnamed_286;
						fragment_unnamed_348 = fragment_unnamed_256;
					}
					precise float fragment_unnamed_350 = (-0.0f) - fragment_unnamed_340;
					precise float fragment_unnamed_353 = fragment_unnamed_350 + fragment_input_1.x;
					precise float fragment_unnamed_356 = (-0.0f) - fragment_input_1.x;
					precise float fragment_unnamed_357 = fragment_unnamed_344 + fragment_unnamed_356;
					precise float fragment_unnamed_358 = (-0.0f) - fragment_unnamed_342;
					precise float fragment_unnamed_361 = fragment_unnamed_358 + fragment_input_1.y;
					float fragment_unnamed_365 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_353) : asuint(fragment_unnamed_361));
					precise float fragment_unnamed_368 = (-0.0f) - fragment_input_1.y;
					precise float fragment_unnamed_369 = fragment_unnamed_346 + fragment_unnamed_368;
					float fragment_unnamed_373 = asfloat(fragment_unnamed_142 ? asuint(fragment_unnamed_357) : asuint(fragment_unnamed_369));
					precise float fragment_unnamed_378 = fragment_unnamed_365 + fragment_unnamed_373;
					precise float fragment_unnamed_383 = 1.0f / fragment_unnamed_378;
					precise float fragment_unnamed_387 = fragment_unnamed_250 * fragment_unnamed_250;
					precise float fragment_unnamed_388 = (-0.0f) - fragment_unnamed_383;
					float fragment_unnamed_393 = max(fragment_unnamed_387, asfloat(asuint(mad(min(fragment_unnamed_373, fragment_unnamed_365), fragment_unnamed_388, 0.5f)) & ((fragment_unnamed_365 < fragment_unnamed_373) ? ((fragment_unnamed_252 != ((fragment_unnamed_338 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_252 != ((fragment_unnamed_348 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					precise float fragment_unnamed_411 = clamp(fragment_unnamed_142 ? fragment_input_1.x : mad(fragment_unnamed_393, fragment_unnamed_182, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_412 = clamp(fragment_unnamed_142 ? mad(fragment_unnamed_393, fragment_unnamed_182, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float4 fragment_unnamed_414 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_411, fragment_unnamed_412), 0.0f);
					fragment_unnamed_288 = fragment_unnamed_414.z;
					fragment_unnamed_290 = fragment_unnamed_414.y;
					fragment_unnamed_292 = fragment_unnamed_414.x;
				}
				else
				{
					fragment_unnamed_288 = fragment_unnamed_54.z;
					fragment_unnamed_290 = fragment_unnamed_54.y;
					fragment_unnamed_292 = fragment_unnamed_54.x;
				}
				float fragment_unnamed_313 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[29u].x, fragment_uniform_buffer_0[29u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[29u].y, fragment_uniform_buffer_0[29u].w))).w, 2.0f, -1.0f);
				precise float fragment_unnamed_320 = (-0.0f) - abs(fragment_unnamed_313);
				precise float fragment_unnamed_321 = fragment_unnamed_320 + 1.0f;
				precise float fragment_unnamed_323 = (-0.0f) - sqrt(fragment_unnamed_321);
				precise float fragment_unnamed_324 = fragment_unnamed_323 + 1.0f;
				precise float fragment_unnamed_325 = fragment_unnamed_324 * mad(clamp(mad(fragment_unnamed_313, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_292);
				fragment_output_0.y = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_290);
				fragment_output_0.z = mad(fragment_unnamed_325, 0.0039215688593685626983642578125f, fragment_unnamed_288);
				fragment_output_0.w = fragment_unnamed_59;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[29] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[30] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA_LOW) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA_KEEP_ALPHA) && !defined(FXAA)


			#if defined(FXAA_KEEP_ALPHA) && defined(FXAA_LOW) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
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
				precise float vertex_unnamed_50 = vertex_unnamed_42 * vertex_uniform_buffer_0[27u].x;
				precise float vertex_unnamed_51 = vertex_unnamed_43 * vertex_uniform_buffer_0[27u].y;
				float vertex_unnamed_57 = mad(vertex_unnamed_50, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_59 = mad(vertex_unnamed_51, 0.5f, vertex_uniform_buffer_0[27u].w);
				precise float vertex_unnamed_64 = vertex_unnamed_57 * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_65 = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_64;
				vertex_output_1.y = vertex_unnamed_65;
				vertex_output_1.x = vertex_unnamed_57;
				vertex_output_1.y = vertex_unnamed_59;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				precise float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f);
				float fragment_unnamed_57 = fragment_unnamed_54.y;
				float4 fragment_unnamed_62 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, 1));
				float fragment_unnamed_66 = fragment_unnamed_62.y;
				float4 fragment_unnamed_67 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 0));
				float fragment_unnamed_70 = fragment_unnamed_67.y;
				float4 fragment_unnamed_72 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, -1));
				float fragment_unnamed_75 = fragment_unnamed_72.y;
				float4 fragment_unnamed_76 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 0));
				float fragment_unnamed_79 = fragment_unnamed_76.y;
				float fragment_unnamed_86 = max(max(max(fragment_unnamed_57, fragment_unnamed_66), fragment_unnamed_70), max(fragment_unnamed_75, fragment_unnamed_79));
				precise float fragment_unnamed_88 = fragment_unnamed_86 * 0.16599999368190765380859375f;
				precise float fragment_unnamed_90 = (-0.0f) - min(min(min(fragment_unnamed_57, fragment_unnamed_66), fragment_unnamed_70), min(fragment_unnamed_75, fragment_unnamed_79));
				precise float fragment_unnamed_92 = fragment_unnamed_90 + fragment_unnamed_86;
				float fragment_unnamed_287;
				float fragment_unnamed_289;
				float fragment_unnamed_291;
				if (fragment_unnamed_92 >= max(fragment_unnamed_88, 0.0625f))
				{
					float4 fragment_unnamed_98 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, -1));
					float fragment_unnamed_101 = fragment_unnamed_98.y;
					float4 fragment_unnamed_102 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 1));
					float fragment_unnamed_105 = fragment_unnamed_102.y;
					float4 fragment_unnamed_106 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, -1));
					float fragment_unnamed_109 = fragment_unnamed_106.y;
					float4 fragment_unnamed_110 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 1));
					float fragment_unnamed_113 = fragment_unnamed_110.y;
					precise float fragment_unnamed_114 = fragment_unnamed_66 + fragment_unnamed_75;
					precise float fragment_unnamed_115 = fragment_unnamed_70 + fragment_unnamed_79;
					precise float fragment_unnamed_116 = 1.0f / fragment_unnamed_92;
					precise float fragment_unnamed_117 = fragment_unnamed_115 + fragment_unnamed_114;
					precise float fragment_unnamed_121 = fragment_unnamed_105 + fragment_unnamed_109;
					precise float fragment_unnamed_122 = fragment_unnamed_101 + fragment_unnamed_109;
					precise float fragment_unnamed_125 = fragment_unnamed_101 + fragment_unnamed_113;
					precise float fragment_unnamed_126 = fragment_unnamed_105 + fragment_unnamed_113;
					precise float fragment_unnamed_138 = mad(abs(mad(fragment_unnamed_57, -2.0f, fragment_unnamed_114)), 2.0f, abs(mad(fragment_unnamed_70, -2.0f, fragment_unnamed_121))) + abs(mad(fragment_unnamed_79, -2.0f, fragment_unnamed_125));
					precise float fragment_unnamed_139 = mad(abs(mad(fragment_unnamed_57, -2.0f, fragment_unnamed_115)), 2.0f, abs(mad(fragment_unnamed_75, -2.0f, fragment_unnamed_122))) + abs(mad(fragment_unnamed_66, -2.0f, fragment_unnamed_126));
					precise float fragment_unnamed_140 = fragment_unnamed_121 + fragment_unnamed_125;
					bool fragment_unnamed_141 = fragment_unnamed_138 >= fragment_unnamed_139;
					float fragment_unnamed_148 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_75) : asuint(fragment_unnamed_79));
					float fragment_unnamed_152 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_66) : asuint(fragment_unnamed_70));
					float fragment_unnamed_164 = asfloat(fragment_unnamed_141 ? asuint(fragment_uniform_buffer_0[29u]).y : asuint(fragment_uniform_buffer_0[29u]).x);
					precise float fragment_unnamed_165 = (-0.0f) - fragment_unnamed_57;
					precise float fragment_unnamed_168 = (-0.0f) - fragment_unnamed_57;
					precise float fragment_unnamed_169 = fragment_unnamed_168 + fragment_unnamed_148;
					precise float fragment_unnamed_170 = (-0.0f) - fragment_unnamed_57;
					precise float fragment_unnamed_171 = fragment_unnamed_170 + fragment_unnamed_152;
					precise float fragment_unnamed_172 = fragment_unnamed_57 + fragment_unnamed_148;
					precise float fragment_unnamed_173 = fragment_unnamed_57 + fragment_unnamed_152;
					bool fragment_unnamed_176 = abs(fragment_unnamed_169) >= abs(fragment_unnamed_171);
					precise float fragment_unnamed_180 = (-0.0f) - fragment_unnamed_164;
					float fragment_unnamed_181 = fragment_unnamed_176 ? fragment_unnamed_180 : fragment_unnamed_164;
					precise float fragment_unnamed_183 = fragment_unnamed_116 * abs(mad(mad(fragment_unnamed_117, 2.0f, fragment_unnamed_140), 0.083333335816860198974609375f, fragment_unnamed_165));
					float fragment_unnamed_184 = clamp(fragment_unnamed_183, 0.0f, 1.0f);
					float fragment_unnamed_190 = asfloat((fragment_unnamed_141 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_196 = asfloat(fragment_unnamed_141 ? 0u : asuint(fragment_uniform_buffer_0[29u]).y);
					float fragment_unnamed_206 = fragment_unnamed_141 ? fragment_input_1.x : mad(fragment_unnamed_181, 0.5f, fragment_input_1.x);
					float fragment_unnamed_209 = fragment_unnamed_141 ? mad(fragment_unnamed_181, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					precise float fragment_unnamed_210 = (-0.0f) - fragment_unnamed_190;
					precise float fragment_unnamed_211 = fragment_unnamed_210 + fragment_unnamed_206;
					precise float fragment_unnamed_213 = (-0.0f) - fragment_unnamed_196;
					precise float fragment_unnamed_214 = fragment_unnamed_213 + fragment_unnamed_209;
					precise float fragment_unnamed_215 = fragment_unnamed_190 + fragment_unnamed_206;
					precise float fragment_unnamed_216 = fragment_unnamed_196 + fragment_unnamed_209;
					precise float fragment_unnamed_224 = clamp(fragment_unnamed_211, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_225 = clamp(fragment_unnamed_214, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_229 = fragment_unnamed_184 * fragment_unnamed_184;
					precise float fragment_unnamed_235 = clamp(fragment_unnamed_215, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_236 = clamp(fragment_unnamed_216, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float fragment_unnamed_243 = asfloat(fragment_unnamed_176 ? asuint(fragment_unnamed_172) : asuint(fragment_unnamed_173));
					precise float fragment_unnamed_244 = max(abs(fragment_unnamed_171), abs(fragment_unnamed_169)) * 0.25f;
					precise float fragment_unnamed_246 = (-0.0f) - fragment_unnamed_243;
					precise float fragment_unnamed_248 = fragment_unnamed_229 * mad(fragment_unnamed_184, -2.0f, 3.0f);
					uint fragment_unnamed_250 = (mad(fragment_unnamed_246, 0.5f, fragment_unnamed_57) < 0.0f) ? 4294967295u : 0u;
					precise float fragment_unnamed_251 = (-0.0f) - fragment_unnamed_243;
					float fragment_unnamed_252 = mad(fragment_unnamed_251, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_224, fragment_unnamed_225), 0.0f).y);
					precise float fragment_unnamed_253 = (-0.0f) - fragment_unnamed_243;
					float fragment_unnamed_254 = mad(fragment_unnamed_253, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_235, fragment_unnamed_236), 0.0f).y);
					bool fragment_unnamed_257 = abs(fragment_unnamed_252) >= fragment_unnamed_244;
					bool fragment_unnamed_258 = abs(fragment_unnamed_254) >= fragment_unnamed_244;
					uint fragment_unnamed_259 = fragment_unnamed_257 ? 4294967295u : 0u;
					uint fragment_unnamed_260 = fragment_unnamed_258 ? 4294967295u : 0u;
					precise float fragment_unnamed_261 = (-0.0f) - fragment_unnamed_190;
					uint fragment_unnamed_265 = fragment_unnamed_257 ? asuint(fragment_unnamed_211) : asuint(mad(fragment_unnamed_261, 1.5f, fragment_unnamed_211));
					float fragment_unnamed_266 = asfloat(fragment_unnamed_265);
					precise float fragment_unnamed_267 = (-0.0f) - fragment_unnamed_196;
					uint fragment_unnamed_271 = fragment_unnamed_257 ? asuint(fragment_unnamed_214) : asuint(mad(fragment_unnamed_267, 1.5f, fragment_unnamed_214));
					float fragment_unnamed_272 = asfloat(fragment_unnamed_271);
					uint fragment_unnamed_279 = fragment_unnamed_258 ? asuint(fragment_unnamed_215) : asuint(mad(fragment_unnamed_190, 1.5f, fragment_unnamed_215));
					float fragment_unnamed_280 = asfloat(fragment_unnamed_279);
					uint fragment_unnamed_284 = fragment_unnamed_258 ? asuint(fragment_unnamed_216) : asuint(mad(fragment_unnamed_196, 1.5f, fragment_unnamed_216));
					float fragment_unnamed_285 = asfloat(fragment_unnamed_284);
					float fragment_unnamed_345;
					float fragment_unnamed_347;
					float fragment_unnamed_349;
					float fragment_unnamed_351;
					float fragment_unnamed_353;
					float fragment_unnamed_355;
					if (((~fragment_unnamed_260) | (~fragment_unnamed_259)) != 0u)
					{
						float fragment_unnamed_434;
						if (fragment_unnamed_259 == 0u)
						{
							precise float fragment_unnamed_428 = clamp(fragment_unnamed_266, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_429 = clamp(fragment_unnamed_272, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_434 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_428, fragment_unnamed_429), 0.0f).y;
						}
						else
						{
							fragment_unnamed_434 = fragment_unnamed_252;
						}
						float fragment_unnamed_447;
						if (fragment_unnamed_260 == 0u)
						{
							precise float fragment_unnamed_441 = clamp(fragment_unnamed_280, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_442 = clamp(fragment_unnamed_285, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_447 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_441, fragment_unnamed_442), 0.0f).y;
						}
						else
						{
							fragment_unnamed_447 = fragment_unnamed_254;
						}
						precise float fragment_unnamed_448 = (-0.0f) - fragment_unnamed_243;
						uint fragment_unnamed_452 = fragment_unnamed_257 ? asuint(fragment_unnamed_434) : asuint(mad(fragment_unnamed_448, 0.5f, fragment_unnamed_434));
						float fragment_unnamed_453 = asfloat(fragment_unnamed_452);
						precise float fragment_unnamed_454 = (-0.0f) - fragment_unnamed_243;
						float fragment_unnamed_459 = asfloat(fragment_unnamed_258 ? asuint(fragment_unnamed_447) : asuint(mad(fragment_unnamed_454, 0.5f, fragment_unnamed_447)));
						bool fragment_unnamed_462 = abs(fragment_unnamed_453) >= fragment_unnamed_244;
						bool fragment_unnamed_463 = abs(fragment_unnamed_459) >= fragment_unnamed_244;
						uint fragment_unnamed_464 = fragment_unnamed_462 ? 4294967295u : 0u;
						uint fragment_unnamed_465 = fragment_unnamed_463 ? 4294967295u : 0u;
						precise float fragment_unnamed_466 = (-0.0f) - fragment_unnamed_190;
						uint fragment_unnamed_469 = fragment_unnamed_462 ? fragment_unnamed_265 : asuint(mad(fragment_unnamed_466, 2.0f, fragment_unnamed_266));
						float fragment_unnamed_470 = asfloat(fragment_unnamed_469);
						precise float fragment_unnamed_471 = (-0.0f) - fragment_unnamed_196;
						uint fragment_unnamed_474 = fragment_unnamed_462 ? fragment_unnamed_271 : asuint(mad(fragment_unnamed_471, 2.0f, fragment_unnamed_272));
						float fragment_unnamed_475 = asfloat(fragment_unnamed_474);
						uint fragment_unnamed_481 = fragment_unnamed_463 ? fragment_unnamed_279 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_280));
						float fragment_unnamed_482 = asfloat(fragment_unnamed_481);
						uint fragment_unnamed_485 = fragment_unnamed_463 ? fragment_unnamed_284 : asuint(mad(fragment_unnamed_196, 2.0f, fragment_unnamed_285));
						float fragment_unnamed_486 = asfloat(fragment_unnamed_485);
						float fragment_unnamed_346;
						float fragment_unnamed_348;
						float fragment_unnamed_350;
						float fragment_unnamed_352;
						float fragment_unnamed_354;
						float fragment_unnamed_356;
						if (((~fragment_unnamed_465) | (~fragment_unnamed_464)) != 0u)
						{
							float fragment_unnamed_507;
							if (fragment_unnamed_464 == 0u)
							{
								precise float fragment_unnamed_500 = clamp(fragment_unnamed_470, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_501 = clamp(fragment_unnamed_475, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_507 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_500, fragment_unnamed_501), 0.0f).y;
							}
							else
							{
								fragment_unnamed_507 = asfloat(fragment_unnamed_452);
							}
							float fragment_unnamed_520;
							if (fragment_unnamed_465 == 0u)
							{
								precise float fragment_unnamed_514 = clamp(fragment_unnamed_482, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_515 = clamp(fragment_unnamed_486, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_520 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_514, fragment_unnamed_515), 0.0f).y;
							}
							else
							{
								fragment_unnamed_520 = fragment_unnamed_459;
							}
							precise float fragment_unnamed_521 = (-0.0f) - fragment_unnamed_243;
							uint fragment_unnamed_525 = fragment_unnamed_462 ? asuint(fragment_unnamed_507) : asuint(mad(fragment_unnamed_521, 0.5f, fragment_unnamed_507));
							float fragment_unnamed_526 = asfloat(fragment_unnamed_525);
							precise float fragment_unnamed_527 = (-0.0f) - fragment_unnamed_243;
							float fragment_unnamed_532 = asfloat(fragment_unnamed_463 ? asuint(fragment_unnamed_520) : asuint(mad(fragment_unnamed_527, 0.5f, fragment_unnamed_520)));
							bool fragment_unnamed_535 = abs(fragment_unnamed_526) >= fragment_unnamed_244;
							bool fragment_unnamed_536 = abs(fragment_unnamed_532) >= fragment_unnamed_244;
							uint fragment_unnamed_537 = fragment_unnamed_535 ? 4294967295u : 0u;
							uint fragment_unnamed_538 = fragment_unnamed_536 ? 4294967295u : 0u;
							precise float fragment_unnamed_539 = (-0.0f) - fragment_unnamed_190;
							uint fragment_unnamed_543 = fragment_unnamed_535 ? fragment_unnamed_469 : asuint(mad(fragment_unnamed_539, 4.0f, fragment_unnamed_470));
							float fragment_unnamed_544 = asfloat(fragment_unnamed_543);
							precise float fragment_unnamed_545 = (-0.0f) - fragment_unnamed_196;
							uint fragment_unnamed_548 = fragment_unnamed_535 ? fragment_unnamed_474 : asuint(mad(fragment_unnamed_545, 4.0f, fragment_unnamed_475));
							float fragment_unnamed_549 = asfloat(fragment_unnamed_548);
							uint fragment_unnamed_555 = fragment_unnamed_536 ? fragment_unnamed_481 : asuint(mad(fragment_unnamed_190, 4.0f, fragment_unnamed_482));
							float fragment_unnamed_556 = asfloat(fragment_unnamed_555);
							uint fragment_unnamed_559 = fragment_unnamed_536 ? fragment_unnamed_485 : asuint(mad(fragment_unnamed_196, 4.0f, fragment_unnamed_486));
							float fragment_unnamed_560 = asfloat(fragment_unnamed_559);
							float fragment_unnamed_489;
							float fragment_unnamed_490;
							float fragment_unnamed_491;
							float fragment_unnamed_492;
							float fragment_unnamed_493;
							float fragment_unnamed_494;
							if (((~fragment_unnamed_538) | (~fragment_unnamed_537)) != 0u)
							{
								float fragment_unnamed_581;
								if (fragment_unnamed_537 == 0u)
								{
									precise float fragment_unnamed_574 = clamp(fragment_unnamed_544, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_575 = clamp(fragment_unnamed_549, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_581 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_574, fragment_unnamed_575), 0.0f).y;
								}
								else
								{
									fragment_unnamed_581 = asfloat(fragment_unnamed_525);
								}
								float fragment_unnamed_594;
								if (fragment_unnamed_538 == 0u)
								{
									precise float fragment_unnamed_588 = clamp(fragment_unnamed_556, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_589 = clamp(fragment_unnamed_560, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_594 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_588, fragment_unnamed_589), 0.0f).y;
								}
								else
								{
									fragment_unnamed_594 = fragment_unnamed_532;
								}
								precise float fragment_unnamed_595 = (-0.0f) - fragment_unnamed_243;
								float fragment_unnamed_564 = asfloat(fragment_unnamed_535 ? asuint(fragment_unnamed_581) : asuint(mad(fragment_unnamed_595, 0.5f, fragment_unnamed_581)));
								precise float fragment_unnamed_600 = (-0.0f) - fragment_unnamed_243;
								float fragment_unnamed_563 = asfloat(fragment_unnamed_536 ? asuint(fragment_unnamed_594) : asuint(mad(fragment_unnamed_600, 0.5f, fragment_unnamed_594)));
								bool fragment_unnamed_607 = abs(fragment_unnamed_564) >= fragment_unnamed_244;
								bool fragment_unnamed_608 = abs(fragment_unnamed_563) >= fragment_unnamed_244;
								precise float fragment_unnamed_609 = (-0.0f) - fragment_unnamed_190;
								precise float fragment_unnamed_614 = (-0.0f) - fragment_unnamed_196;
								fragment_unnamed_489 = fragment_unnamed_563;
								fragment_unnamed_490 = fragment_unnamed_564;
								fragment_unnamed_491 = asfloat(fragment_unnamed_607 ? fragment_unnamed_543 : asuint(mad(fragment_unnamed_609, 12.0f, fragment_unnamed_544)));
								fragment_unnamed_492 = asfloat(fragment_unnamed_607 ? fragment_unnamed_548 : asuint(mad(fragment_unnamed_614, 12.0f, fragment_unnamed_549)));
								fragment_unnamed_493 = asfloat(fragment_unnamed_608 ? fragment_unnamed_555 : asuint(mad(fragment_unnamed_190, 12.0f, fragment_unnamed_556)));
								fragment_unnamed_494 = asfloat(fragment_unnamed_608 ? fragment_unnamed_559 : asuint(mad(fragment_unnamed_196, 12.0f, fragment_unnamed_560)));
							}
							else
							{
								fragment_unnamed_489 = fragment_unnamed_532;
								fragment_unnamed_490 = fragment_unnamed_526;
								fragment_unnamed_491 = fragment_unnamed_544;
								fragment_unnamed_492 = fragment_unnamed_549;
								fragment_unnamed_493 = fragment_unnamed_556;
								fragment_unnamed_494 = fragment_unnamed_560;
							}
							fragment_unnamed_346 = fragment_unnamed_489;
							fragment_unnamed_348 = fragment_unnamed_490;
							fragment_unnamed_350 = fragment_unnamed_491;
							fragment_unnamed_352 = fragment_unnamed_492;
							fragment_unnamed_354 = fragment_unnamed_493;
							fragment_unnamed_356 = fragment_unnamed_494;
						}
						else
						{
							fragment_unnamed_346 = fragment_unnamed_459;
							fragment_unnamed_348 = fragment_unnamed_453;
							fragment_unnamed_350 = fragment_unnamed_470;
							fragment_unnamed_352 = fragment_unnamed_475;
							fragment_unnamed_354 = fragment_unnamed_482;
							fragment_unnamed_356 = fragment_unnamed_486;
						}
						fragment_unnamed_345 = fragment_unnamed_346;
						fragment_unnamed_347 = fragment_unnamed_348;
						fragment_unnamed_349 = fragment_unnamed_350;
						fragment_unnamed_351 = fragment_unnamed_352;
						fragment_unnamed_353 = fragment_unnamed_354;
						fragment_unnamed_355 = fragment_unnamed_356;
					}
					else
					{
						fragment_unnamed_345 = fragment_unnamed_254;
						fragment_unnamed_347 = fragment_unnamed_252;
						fragment_unnamed_349 = fragment_unnamed_266;
						fragment_unnamed_351 = fragment_unnamed_272;
						fragment_unnamed_353 = fragment_unnamed_280;
						fragment_unnamed_355 = fragment_unnamed_285;
					}
					precise float fragment_unnamed_357 = (-0.0f) - fragment_unnamed_349;
					precise float fragment_unnamed_360 = fragment_unnamed_357 + fragment_input_1.x;
					precise float fragment_unnamed_363 = (-0.0f) - fragment_input_1.x;
					precise float fragment_unnamed_364 = fragment_unnamed_353 + fragment_unnamed_363;
					precise float fragment_unnamed_365 = (-0.0f) - fragment_unnamed_351;
					precise float fragment_unnamed_368 = fragment_unnamed_365 + fragment_input_1.y;
					float fragment_unnamed_372 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_360) : asuint(fragment_unnamed_368));
					precise float fragment_unnamed_375 = (-0.0f) - fragment_input_1.y;
					precise float fragment_unnamed_376 = fragment_unnamed_355 + fragment_unnamed_375;
					float fragment_unnamed_380 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_364) : asuint(fragment_unnamed_376));
					precise float fragment_unnamed_385 = fragment_unnamed_372 + fragment_unnamed_380;
					precise float fragment_unnamed_390 = 1.0f / fragment_unnamed_385;
					precise float fragment_unnamed_394 = fragment_unnamed_248 * fragment_unnamed_248;
					precise float fragment_unnamed_395 = (-0.0f) - fragment_unnamed_390;
					float fragment_unnamed_400 = max(fragment_unnamed_394, asfloat(asuint(mad(min(fragment_unnamed_380, fragment_unnamed_372), fragment_unnamed_395, 0.5f)) & ((fragment_unnamed_372 < fragment_unnamed_380) ? ((fragment_unnamed_250 != ((fragment_unnamed_347 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_250 != ((fragment_unnamed_345 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					precise float fragment_unnamed_418 = clamp(fragment_unnamed_141 ? fragment_input_1.x : mad(fragment_unnamed_400, fragment_unnamed_181, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_419 = clamp(fragment_unnamed_141 ? mad(fragment_unnamed_400, fragment_unnamed_181, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float4 fragment_unnamed_421 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_418, fragment_unnamed_419), 0.0f);
					fragment_unnamed_287 = fragment_unnamed_421.z;
					fragment_unnamed_289 = fragment_unnamed_421.y;
					fragment_unnamed_291 = fragment_unnamed_421.x;
				}
				else
				{
					fragment_unnamed_287 = fragment_unnamed_54.z;
					fragment_unnamed_289 = fragment_unnamed_57;
					fragment_unnamed_291 = fragment_unnamed_54.x;
				}
				float fragment_unnamed_320 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				precise float fragment_unnamed_327 = (-0.0f) - abs(fragment_unnamed_320);
				precise float fragment_unnamed_328 = fragment_unnamed_327 + 1.0f;
				precise float fragment_unnamed_330 = (-0.0f) - sqrt(fragment_unnamed_328);
				precise float fragment_unnamed_331 = fragment_unnamed_330 + 1.0f;
				precise float fragment_unnamed_332 = fragment_unnamed_331 * mad(clamp(mad(fragment_unnamed_320, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_332, 0.0039215688593685626983642578125f, fragment_unnamed_291);
				fragment_output_0.y = mad(fragment_unnamed_332, 0.0039215688593685626983642578125f, fragment_unnamed_289);
				fragment_output_0.z = mad(fragment_unnamed_332, 0.0039215688593685626983642578125f, fragment_unnamed_287);
				fragment_output_0.w = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[29] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA_KEEP_ALPHA) && defined(FXAA_LOW) && !defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA)


			#if defined(FXAA_KEEP_ALPHA) && defined(FXAA_LOW) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float _DepthSlice;
			float4 _UVTransform;

			static float4 vertex_uniform_buffer_0[28];
			static float4 gl_Position;
			static uint gl_Layer;
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
				uint gl_Layer : SV_RenderTargetArrayIndex;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_44 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_45 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_52 = vertex_unnamed_44 * vertex_uniform_buffer_0[27u].x;
				precise float vertex_unnamed_53 = vertex_unnamed_45 * vertex_uniform_buffer_0[27u].y;
				float vertex_unnamed_59 = mad(vertex_unnamed_52, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_61 = mad(vertex_unnamed_53, 0.5f, vertex_uniform_buffer_0[27u].w);
				precise float vertex_unnamed_66 = vertex_unnamed_59 * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_67 = vertex_unnamed_61 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_66;
				vertex_output_1.y = vertex_unnamed_67;
				vertex_output_1.x = vertex_unnamed_59;
				vertex_output_1.y = vertex_unnamed_61;
				gl_Layer = int(uint(vertex_uniform_buffer_0[26u].y));
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[26] = float4(vertex_uniform_buffer_0[26][0], _DepthSlice, vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.gl_Layer = gl_Layer;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				precise float fragment_unnamed_52 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_53 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_56 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f);
				float fragment_unnamed_59 = fragment_unnamed_56.y;
				float4 fragment_unnamed_64 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(0, 1));
				float fragment_unnamed_68 = fragment_unnamed_64.y;
				float4 fragment_unnamed_69 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, 0));
				float fragment_unnamed_72 = fragment_unnamed_69.y;
				float4 fragment_unnamed_74 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(0, -1));
				float fragment_unnamed_77 = fragment_unnamed_74.y;
				float4 fragment_unnamed_78 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, 0));
				float fragment_unnamed_81 = fragment_unnamed_78.y;
				float fragment_unnamed_88 = max(max(max(fragment_unnamed_59, fragment_unnamed_68), fragment_unnamed_72), max(fragment_unnamed_77, fragment_unnamed_81));
				precise float fragment_unnamed_90 = fragment_unnamed_88 * 0.16599999368190765380859375f;
				precise float fragment_unnamed_92 = (-0.0f) - min(min(min(fragment_unnamed_59, fragment_unnamed_68), fragment_unnamed_72), min(fragment_unnamed_77, fragment_unnamed_81));
				precise float fragment_unnamed_94 = fragment_unnamed_92 + fragment_unnamed_88;
				float fragment_unnamed_289;
				float fragment_unnamed_291;
				float fragment_unnamed_293;
				if (fragment_unnamed_94 >= max(fragment_unnamed_90, 0.0625f))
				{
					float4 fragment_unnamed_100 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, -1));
					float fragment_unnamed_103 = fragment_unnamed_100.y;
					float4 fragment_unnamed_104 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, 1));
					float fragment_unnamed_107 = fragment_unnamed_104.y;
					float4 fragment_unnamed_108 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(1, -1));
					float fragment_unnamed_111 = fragment_unnamed_108.y;
					float4 fragment_unnamed_112 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_52, fragment_unnamed_53), 0.0f, int2(-1, 1));
					float fragment_unnamed_115 = fragment_unnamed_112.y;
					precise float fragment_unnamed_116 = fragment_unnamed_68 + fragment_unnamed_77;
					precise float fragment_unnamed_117 = fragment_unnamed_72 + fragment_unnamed_81;
					precise float fragment_unnamed_118 = 1.0f / fragment_unnamed_94;
					precise float fragment_unnamed_119 = fragment_unnamed_117 + fragment_unnamed_116;
					precise float fragment_unnamed_123 = fragment_unnamed_107 + fragment_unnamed_111;
					precise float fragment_unnamed_124 = fragment_unnamed_103 + fragment_unnamed_111;
					precise float fragment_unnamed_127 = fragment_unnamed_103 + fragment_unnamed_115;
					precise float fragment_unnamed_128 = fragment_unnamed_107 + fragment_unnamed_115;
					precise float fragment_unnamed_140 = mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_116)), 2.0f, abs(mad(fragment_unnamed_72, -2.0f, fragment_unnamed_123))) + abs(mad(fragment_unnamed_81, -2.0f, fragment_unnamed_127));
					precise float fragment_unnamed_141 = mad(abs(mad(fragment_unnamed_59, -2.0f, fragment_unnamed_117)), 2.0f, abs(mad(fragment_unnamed_77, -2.0f, fragment_unnamed_124))) + abs(mad(fragment_unnamed_68, -2.0f, fragment_unnamed_128));
					precise float fragment_unnamed_142 = fragment_unnamed_123 + fragment_unnamed_127;
					bool fragment_unnamed_143 = fragment_unnamed_140 >= fragment_unnamed_141;
					float fragment_unnamed_150 = asfloat(fragment_unnamed_143 ? asuint(fragment_unnamed_77) : asuint(fragment_unnamed_81));
					float fragment_unnamed_154 = asfloat(fragment_unnamed_143 ? asuint(fragment_unnamed_68) : asuint(fragment_unnamed_72));
					float fragment_unnamed_166 = asfloat(fragment_unnamed_143 ? asuint(fragment_uniform_buffer_0[29u]).y : asuint(fragment_uniform_buffer_0[29u]).x);
					precise float fragment_unnamed_167 = (-0.0f) - fragment_unnamed_59;
					precise float fragment_unnamed_170 = (-0.0f) - fragment_unnamed_59;
					precise float fragment_unnamed_171 = fragment_unnamed_170 + fragment_unnamed_150;
					precise float fragment_unnamed_172 = (-0.0f) - fragment_unnamed_59;
					precise float fragment_unnamed_173 = fragment_unnamed_172 + fragment_unnamed_154;
					precise float fragment_unnamed_174 = fragment_unnamed_59 + fragment_unnamed_150;
					precise float fragment_unnamed_175 = fragment_unnamed_59 + fragment_unnamed_154;
					bool fragment_unnamed_178 = abs(fragment_unnamed_171) >= abs(fragment_unnamed_173);
					precise float fragment_unnamed_182 = (-0.0f) - fragment_unnamed_166;
					float fragment_unnamed_183 = fragment_unnamed_178 ? fragment_unnamed_182 : fragment_unnamed_166;
					precise float fragment_unnamed_185 = fragment_unnamed_118 * abs(mad(mad(fragment_unnamed_119, 2.0f, fragment_unnamed_142), 0.083333335816860198974609375f, fragment_unnamed_167));
					float fragment_unnamed_186 = clamp(fragment_unnamed_185, 0.0f, 1.0f);
					float fragment_unnamed_192 = asfloat((fragment_unnamed_143 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[29u]).x);
					float fragment_unnamed_198 = asfloat(fragment_unnamed_143 ? 0u : asuint(fragment_uniform_buffer_0[29u]).y);
					float fragment_unnamed_208 = fragment_unnamed_143 ? fragment_input_1.x : mad(fragment_unnamed_183, 0.5f, fragment_input_1.x);
					float fragment_unnamed_211 = fragment_unnamed_143 ? mad(fragment_unnamed_183, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					precise float fragment_unnamed_212 = (-0.0f) - fragment_unnamed_192;
					precise float fragment_unnamed_213 = fragment_unnamed_212 + fragment_unnamed_208;
					precise float fragment_unnamed_215 = (-0.0f) - fragment_unnamed_198;
					precise float fragment_unnamed_216 = fragment_unnamed_215 + fragment_unnamed_211;
					precise float fragment_unnamed_217 = fragment_unnamed_192 + fragment_unnamed_208;
					precise float fragment_unnamed_218 = fragment_unnamed_198 + fragment_unnamed_211;
					precise float fragment_unnamed_226 = clamp(fragment_unnamed_213, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_227 = clamp(fragment_unnamed_216, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_231 = fragment_unnamed_186 * fragment_unnamed_186;
					precise float fragment_unnamed_237 = clamp(fragment_unnamed_217, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_238 = clamp(fragment_unnamed_218, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float fragment_unnamed_245 = asfloat(fragment_unnamed_178 ? asuint(fragment_unnamed_174) : asuint(fragment_unnamed_175));
					precise float fragment_unnamed_246 = max(abs(fragment_unnamed_173), abs(fragment_unnamed_171)) * 0.25f;
					precise float fragment_unnamed_248 = (-0.0f) - fragment_unnamed_245;
					precise float fragment_unnamed_250 = fragment_unnamed_231 * mad(fragment_unnamed_186, -2.0f, 3.0f);
					uint fragment_unnamed_252 = (mad(fragment_unnamed_248, 0.5f, fragment_unnamed_59) < 0.0f) ? 4294967295u : 0u;
					precise float fragment_unnamed_253 = (-0.0f) - fragment_unnamed_245;
					float fragment_unnamed_254 = mad(fragment_unnamed_253, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_226, fragment_unnamed_227), 0.0f).y);
					precise float fragment_unnamed_255 = (-0.0f) - fragment_unnamed_245;
					float fragment_unnamed_256 = mad(fragment_unnamed_255, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_237, fragment_unnamed_238), 0.0f).y);
					bool fragment_unnamed_259 = abs(fragment_unnamed_254) >= fragment_unnamed_246;
					bool fragment_unnamed_260 = abs(fragment_unnamed_256) >= fragment_unnamed_246;
					uint fragment_unnamed_261 = fragment_unnamed_259 ? 4294967295u : 0u;
					uint fragment_unnamed_262 = fragment_unnamed_260 ? 4294967295u : 0u;
					precise float fragment_unnamed_263 = (-0.0f) - fragment_unnamed_192;
					uint fragment_unnamed_267 = fragment_unnamed_259 ? asuint(fragment_unnamed_213) : asuint(mad(fragment_unnamed_263, 1.5f, fragment_unnamed_213));
					float fragment_unnamed_268 = asfloat(fragment_unnamed_267);
					precise float fragment_unnamed_269 = (-0.0f) - fragment_unnamed_198;
					uint fragment_unnamed_273 = fragment_unnamed_259 ? asuint(fragment_unnamed_216) : asuint(mad(fragment_unnamed_269, 1.5f, fragment_unnamed_216));
					float fragment_unnamed_274 = asfloat(fragment_unnamed_273);
					uint fragment_unnamed_281 = fragment_unnamed_260 ? asuint(fragment_unnamed_217) : asuint(mad(fragment_unnamed_192, 1.5f, fragment_unnamed_217));
					float fragment_unnamed_282 = asfloat(fragment_unnamed_281);
					uint fragment_unnamed_286 = fragment_unnamed_260 ? asuint(fragment_unnamed_218) : asuint(mad(fragment_unnamed_198, 1.5f, fragment_unnamed_218));
					float fragment_unnamed_287 = asfloat(fragment_unnamed_286);
					float fragment_unnamed_347;
					float fragment_unnamed_349;
					float fragment_unnamed_351;
					float fragment_unnamed_353;
					float fragment_unnamed_355;
					float fragment_unnamed_357;
					if (((~fragment_unnamed_262) | (~fragment_unnamed_261)) != 0u)
					{
						float fragment_unnamed_436;
						if (fragment_unnamed_261 == 0u)
						{
							precise float fragment_unnamed_430 = clamp(fragment_unnamed_268, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_431 = clamp(fragment_unnamed_274, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_436 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_430, fragment_unnamed_431), 0.0f).y;
						}
						else
						{
							fragment_unnamed_436 = fragment_unnamed_254;
						}
						float fragment_unnamed_449;
						if (fragment_unnamed_262 == 0u)
						{
							precise float fragment_unnamed_443 = clamp(fragment_unnamed_282, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_444 = clamp(fragment_unnamed_287, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_449 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_443, fragment_unnamed_444), 0.0f).y;
						}
						else
						{
							fragment_unnamed_449 = fragment_unnamed_256;
						}
						precise float fragment_unnamed_450 = (-0.0f) - fragment_unnamed_245;
						uint fragment_unnamed_454 = fragment_unnamed_259 ? asuint(fragment_unnamed_436) : asuint(mad(fragment_unnamed_450, 0.5f, fragment_unnamed_436));
						float fragment_unnamed_455 = asfloat(fragment_unnamed_454);
						precise float fragment_unnamed_456 = (-0.0f) - fragment_unnamed_245;
						float fragment_unnamed_461 = asfloat(fragment_unnamed_260 ? asuint(fragment_unnamed_449) : asuint(mad(fragment_unnamed_456, 0.5f, fragment_unnamed_449)));
						bool fragment_unnamed_464 = abs(fragment_unnamed_455) >= fragment_unnamed_246;
						bool fragment_unnamed_465 = abs(fragment_unnamed_461) >= fragment_unnamed_246;
						uint fragment_unnamed_466 = fragment_unnamed_464 ? 4294967295u : 0u;
						uint fragment_unnamed_467 = fragment_unnamed_465 ? 4294967295u : 0u;
						precise float fragment_unnamed_468 = (-0.0f) - fragment_unnamed_192;
						uint fragment_unnamed_471 = fragment_unnamed_464 ? fragment_unnamed_267 : asuint(mad(fragment_unnamed_468, 2.0f, fragment_unnamed_268));
						float fragment_unnamed_472 = asfloat(fragment_unnamed_471);
						precise float fragment_unnamed_473 = (-0.0f) - fragment_unnamed_198;
						uint fragment_unnamed_476 = fragment_unnamed_464 ? fragment_unnamed_273 : asuint(mad(fragment_unnamed_473, 2.0f, fragment_unnamed_274));
						float fragment_unnamed_477 = asfloat(fragment_unnamed_476);
						uint fragment_unnamed_483 = fragment_unnamed_465 ? fragment_unnamed_281 : asuint(mad(fragment_unnamed_192, 2.0f, fragment_unnamed_282));
						float fragment_unnamed_484 = asfloat(fragment_unnamed_483);
						uint fragment_unnamed_487 = fragment_unnamed_465 ? fragment_unnamed_286 : asuint(mad(fragment_unnamed_198, 2.0f, fragment_unnamed_287));
						float fragment_unnamed_488 = asfloat(fragment_unnamed_487);
						float fragment_unnamed_348;
						float fragment_unnamed_350;
						float fragment_unnamed_352;
						float fragment_unnamed_354;
						float fragment_unnamed_356;
						float fragment_unnamed_358;
						if (((~fragment_unnamed_467) | (~fragment_unnamed_466)) != 0u)
						{
							float fragment_unnamed_509;
							if (fragment_unnamed_466 == 0u)
							{
								precise float fragment_unnamed_502 = clamp(fragment_unnamed_472, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_503 = clamp(fragment_unnamed_477, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_509 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_502, fragment_unnamed_503), 0.0f).y;
							}
							else
							{
								fragment_unnamed_509 = asfloat(fragment_unnamed_454);
							}
							float fragment_unnamed_522;
							if (fragment_unnamed_467 == 0u)
							{
								precise float fragment_unnamed_516 = clamp(fragment_unnamed_484, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_517 = clamp(fragment_unnamed_488, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_522 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_516, fragment_unnamed_517), 0.0f).y;
							}
							else
							{
								fragment_unnamed_522 = fragment_unnamed_461;
							}
							precise float fragment_unnamed_523 = (-0.0f) - fragment_unnamed_245;
							uint fragment_unnamed_527 = fragment_unnamed_464 ? asuint(fragment_unnamed_509) : asuint(mad(fragment_unnamed_523, 0.5f, fragment_unnamed_509));
							float fragment_unnamed_528 = asfloat(fragment_unnamed_527);
							precise float fragment_unnamed_529 = (-0.0f) - fragment_unnamed_245;
							float fragment_unnamed_534 = asfloat(fragment_unnamed_465 ? asuint(fragment_unnamed_522) : asuint(mad(fragment_unnamed_529, 0.5f, fragment_unnamed_522)));
							bool fragment_unnamed_537 = abs(fragment_unnamed_528) >= fragment_unnamed_246;
							bool fragment_unnamed_538 = abs(fragment_unnamed_534) >= fragment_unnamed_246;
							uint fragment_unnamed_539 = fragment_unnamed_537 ? 4294967295u : 0u;
							uint fragment_unnamed_540 = fragment_unnamed_538 ? 4294967295u : 0u;
							precise float fragment_unnamed_541 = (-0.0f) - fragment_unnamed_192;
							uint fragment_unnamed_545 = fragment_unnamed_537 ? fragment_unnamed_471 : asuint(mad(fragment_unnamed_541, 4.0f, fragment_unnamed_472));
							float fragment_unnamed_546 = asfloat(fragment_unnamed_545);
							precise float fragment_unnamed_547 = (-0.0f) - fragment_unnamed_198;
							uint fragment_unnamed_550 = fragment_unnamed_537 ? fragment_unnamed_476 : asuint(mad(fragment_unnamed_547, 4.0f, fragment_unnamed_477));
							float fragment_unnamed_551 = asfloat(fragment_unnamed_550);
							uint fragment_unnamed_557 = fragment_unnamed_538 ? fragment_unnamed_483 : asuint(mad(fragment_unnamed_192, 4.0f, fragment_unnamed_484));
							float fragment_unnamed_558 = asfloat(fragment_unnamed_557);
							uint fragment_unnamed_561 = fragment_unnamed_538 ? fragment_unnamed_487 : asuint(mad(fragment_unnamed_198, 4.0f, fragment_unnamed_488));
							float fragment_unnamed_562 = asfloat(fragment_unnamed_561);
							float fragment_unnamed_491;
							float fragment_unnamed_492;
							float fragment_unnamed_493;
							float fragment_unnamed_494;
							float fragment_unnamed_495;
							float fragment_unnamed_496;
							if (((~fragment_unnamed_540) | (~fragment_unnamed_539)) != 0u)
							{
								float fragment_unnamed_583;
								if (fragment_unnamed_539 == 0u)
								{
									precise float fragment_unnamed_576 = clamp(fragment_unnamed_546, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_577 = clamp(fragment_unnamed_551, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_583 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_576, fragment_unnamed_577), 0.0f).y;
								}
								else
								{
									fragment_unnamed_583 = asfloat(fragment_unnamed_527);
								}
								float fragment_unnamed_596;
								if (fragment_unnamed_540 == 0u)
								{
									precise float fragment_unnamed_590 = clamp(fragment_unnamed_558, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_591 = clamp(fragment_unnamed_562, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_596 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_590, fragment_unnamed_591), 0.0f).y;
								}
								else
								{
									fragment_unnamed_596 = fragment_unnamed_534;
								}
								precise float fragment_unnamed_597 = (-0.0f) - fragment_unnamed_245;
								float fragment_unnamed_566 = asfloat(fragment_unnamed_537 ? asuint(fragment_unnamed_583) : asuint(mad(fragment_unnamed_597, 0.5f, fragment_unnamed_583)));
								precise float fragment_unnamed_602 = (-0.0f) - fragment_unnamed_245;
								float fragment_unnamed_565 = asfloat(fragment_unnamed_538 ? asuint(fragment_unnamed_596) : asuint(mad(fragment_unnamed_602, 0.5f, fragment_unnamed_596)));
								bool fragment_unnamed_609 = abs(fragment_unnamed_566) >= fragment_unnamed_246;
								bool fragment_unnamed_610 = abs(fragment_unnamed_565) >= fragment_unnamed_246;
								precise float fragment_unnamed_611 = (-0.0f) - fragment_unnamed_192;
								precise float fragment_unnamed_616 = (-0.0f) - fragment_unnamed_198;
								fragment_unnamed_491 = fragment_unnamed_565;
								fragment_unnamed_492 = fragment_unnamed_566;
								fragment_unnamed_493 = asfloat(fragment_unnamed_609 ? fragment_unnamed_545 : asuint(mad(fragment_unnamed_611, 12.0f, fragment_unnamed_546)));
								fragment_unnamed_494 = asfloat(fragment_unnamed_609 ? fragment_unnamed_550 : asuint(mad(fragment_unnamed_616, 12.0f, fragment_unnamed_551)));
								fragment_unnamed_495 = asfloat(fragment_unnamed_610 ? fragment_unnamed_557 : asuint(mad(fragment_unnamed_192, 12.0f, fragment_unnamed_558)));
								fragment_unnamed_496 = asfloat(fragment_unnamed_610 ? fragment_unnamed_561 : asuint(mad(fragment_unnamed_198, 12.0f, fragment_unnamed_562)));
							}
							else
							{
								fragment_unnamed_491 = fragment_unnamed_534;
								fragment_unnamed_492 = fragment_unnamed_528;
								fragment_unnamed_493 = fragment_unnamed_546;
								fragment_unnamed_494 = fragment_unnamed_551;
								fragment_unnamed_495 = fragment_unnamed_558;
								fragment_unnamed_496 = fragment_unnamed_562;
							}
							fragment_unnamed_348 = fragment_unnamed_491;
							fragment_unnamed_350 = fragment_unnamed_492;
							fragment_unnamed_352 = fragment_unnamed_493;
							fragment_unnamed_354 = fragment_unnamed_494;
							fragment_unnamed_356 = fragment_unnamed_495;
							fragment_unnamed_358 = fragment_unnamed_496;
						}
						else
						{
							fragment_unnamed_348 = fragment_unnamed_461;
							fragment_unnamed_350 = fragment_unnamed_455;
							fragment_unnamed_352 = fragment_unnamed_472;
							fragment_unnamed_354 = fragment_unnamed_477;
							fragment_unnamed_356 = fragment_unnamed_484;
							fragment_unnamed_358 = fragment_unnamed_488;
						}
						fragment_unnamed_347 = fragment_unnamed_348;
						fragment_unnamed_349 = fragment_unnamed_350;
						fragment_unnamed_351 = fragment_unnamed_352;
						fragment_unnamed_353 = fragment_unnamed_354;
						fragment_unnamed_355 = fragment_unnamed_356;
						fragment_unnamed_357 = fragment_unnamed_358;
					}
					else
					{
						fragment_unnamed_347 = fragment_unnamed_256;
						fragment_unnamed_349 = fragment_unnamed_254;
						fragment_unnamed_351 = fragment_unnamed_268;
						fragment_unnamed_353 = fragment_unnamed_274;
						fragment_unnamed_355 = fragment_unnamed_282;
						fragment_unnamed_357 = fragment_unnamed_287;
					}
					precise float fragment_unnamed_359 = (-0.0f) - fragment_unnamed_351;
					precise float fragment_unnamed_362 = fragment_unnamed_359 + fragment_input_1.x;
					precise float fragment_unnamed_365 = (-0.0f) - fragment_input_1.x;
					precise float fragment_unnamed_366 = fragment_unnamed_355 + fragment_unnamed_365;
					precise float fragment_unnamed_367 = (-0.0f) - fragment_unnamed_353;
					precise float fragment_unnamed_370 = fragment_unnamed_367 + fragment_input_1.y;
					float fragment_unnamed_374 = asfloat(fragment_unnamed_143 ? asuint(fragment_unnamed_362) : asuint(fragment_unnamed_370));
					precise float fragment_unnamed_377 = (-0.0f) - fragment_input_1.y;
					precise float fragment_unnamed_378 = fragment_unnamed_357 + fragment_unnamed_377;
					float fragment_unnamed_382 = asfloat(fragment_unnamed_143 ? asuint(fragment_unnamed_366) : asuint(fragment_unnamed_378));
					precise float fragment_unnamed_387 = fragment_unnamed_374 + fragment_unnamed_382;
					precise float fragment_unnamed_392 = 1.0f / fragment_unnamed_387;
					precise float fragment_unnamed_396 = fragment_unnamed_250 * fragment_unnamed_250;
					precise float fragment_unnamed_397 = (-0.0f) - fragment_unnamed_392;
					float fragment_unnamed_402 = max(fragment_unnamed_396, asfloat(asuint(mad(min(fragment_unnamed_382, fragment_unnamed_374), fragment_unnamed_397, 0.5f)) & ((fragment_unnamed_374 < fragment_unnamed_382) ? ((fragment_unnamed_252 != ((fragment_unnamed_349 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_252 != ((fragment_unnamed_347 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					precise float fragment_unnamed_420 = clamp(fragment_unnamed_143 ? fragment_input_1.x : mad(fragment_unnamed_402, fragment_unnamed_183, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_421 = clamp(fragment_unnamed_143 ? mad(fragment_unnamed_402, fragment_unnamed_183, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float4 fragment_unnamed_423 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_420, fragment_unnamed_421), 0.0f);
					fragment_unnamed_289 = fragment_unnamed_423.z;
					fragment_unnamed_291 = fragment_unnamed_423.y;
					fragment_unnamed_293 = fragment_unnamed_423.x;
				}
				else
				{
					fragment_unnamed_289 = fragment_unnamed_56.z;
					fragment_unnamed_291 = fragment_unnamed_59;
					fragment_unnamed_293 = fragment_unnamed_56.x;
				}
				float fragment_unnamed_322 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[28u].x, fragment_uniform_buffer_0[28u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[28u].y, fragment_uniform_buffer_0[28u].w))).w, 2.0f, -1.0f);
				precise float fragment_unnamed_329 = (-0.0f) - abs(fragment_unnamed_322);
				precise float fragment_unnamed_330 = fragment_unnamed_329 + 1.0f;
				precise float fragment_unnamed_332 = (-0.0f) - sqrt(fragment_unnamed_330);
				precise float fragment_unnamed_333 = fragment_unnamed_332 + 1.0f;
				precise float fragment_unnamed_334 = fragment_unnamed_333 * mad(clamp(mad(fragment_unnamed_322, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_334, 0.0039215688593685626983642578125f, fragment_unnamed_293);
				fragment_output_0.y = mad(fragment_unnamed_334, 0.0039215688593685626983642578125f, fragment_unnamed_291);
				fragment_output_0.z = mad(fragment_unnamed_334, 0.0039215688593685626983642578125f, fragment_unnamed_289);
				fragment_output_0.w = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[29] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA_KEEP_ALPHA) && defined(FXAA_LOW) && defined(STEREO_INSTANCING_ENABLED) && !defined(STEREO_DOUBLEWIDE_TARGET) && !defined(FXAA)


			#if defined(FXAA_KEEP_ALPHA) && defined(FXAA_LOW) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _RenderViewportScaleFactor;
			float4 _UVTransform;
			float4 _PosScaleOffset;

			static float4 vertex_uniform_buffer_0[29];
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
				gl_Position.x = mad(vertex_input_0.x, vertex_uniform_buffer_0[28u].x, vertex_uniform_buffer_0[28u].z);
				gl_Position.y = mad(vertex_input_0.y, vertex_uniform_buffer_0[28u].y, vertex_uniform_buffer_0[28u].w);
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_55 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_56 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_62 = vertex_unnamed_55 * vertex_uniform_buffer_0[27u].x;
				precise float vertex_unnamed_63 = vertex_unnamed_56 * vertex_uniform_buffer_0[27u].y;
				float vertex_unnamed_68 = mad(vertex_unnamed_62, 0.5f, vertex_uniform_buffer_0[27u].z);
				float vertex_unnamed_70 = mad(vertex_unnamed_63, 0.5f, vertex_uniform_buffer_0[27u].w);
				precise float vertex_unnamed_75 = vertex_unnamed_68 * vertex_uniform_buffer_0[26u].x;
				precise float vertex_unnamed_76 = vertex_unnamed_70 * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.x = vertex_unnamed_75;
				vertex_output_1.y = vertex_unnamed_76;
				vertex_output_1.x = vertex_unnamed_68;
				vertex_output_1.y = vertex_unnamed_70;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, vertex_uniform_buffer_0[26][1], vertex_uniform_buffer_0[26][2], vertex_uniform_buffer_0[26][3]);

				vertex_uniform_buffer_0[27] = float4(_UVTransform[0], _UVTransform[1], _UVTransform[2], _UVTransform[3]);

				vertex_uniform_buffer_0[28] = float4(_PosScaleOffset[0], _PosScaleOffset[1], _PosScaleOffset[2], _PosScaleOffset[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _RenderViewportScaleFactor;
			float4 _Dithering_Coords;
			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[31];
			Texture2D<float4> _DitheringTex;
			Texture2D<float4> _MainTex;
			SamplerState sampler_DitheringTex;
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
				precise float fragment_unnamed_50 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_51 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_54 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f);
				float fragment_unnamed_57 = fragment_unnamed_54.y;
				float4 fragment_unnamed_62 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, 1));
				float fragment_unnamed_66 = fragment_unnamed_62.y;
				float4 fragment_unnamed_67 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 0));
				float fragment_unnamed_70 = fragment_unnamed_67.y;
				float4 fragment_unnamed_72 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(0, -1));
				float fragment_unnamed_75 = fragment_unnamed_72.y;
				float4 fragment_unnamed_76 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 0));
				float fragment_unnamed_79 = fragment_unnamed_76.y;
				float fragment_unnamed_86 = max(max(max(fragment_unnamed_57, fragment_unnamed_66), fragment_unnamed_70), max(fragment_unnamed_75, fragment_unnamed_79));
				precise float fragment_unnamed_88 = fragment_unnamed_86 * 0.16599999368190765380859375f;
				precise float fragment_unnamed_90 = (-0.0f) - min(min(min(fragment_unnamed_57, fragment_unnamed_66), fragment_unnamed_70), min(fragment_unnamed_75, fragment_unnamed_79));
				precise float fragment_unnamed_92 = fragment_unnamed_90 + fragment_unnamed_86;
				float fragment_unnamed_287;
				float fragment_unnamed_289;
				float fragment_unnamed_291;
				if (fragment_unnamed_92 >= max(fragment_unnamed_88, 0.0625f))
				{
					float4 fragment_unnamed_98 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, -1));
					float fragment_unnamed_101 = fragment_unnamed_98.y;
					float4 fragment_unnamed_102 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, 1));
					float fragment_unnamed_105 = fragment_unnamed_102.y;
					float4 fragment_unnamed_106 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(1, -1));
					float fragment_unnamed_109 = fragment_unnamed_106.y;
					float4 fragment_unnamed_110 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51), 0.0f, int2(-1, 1));
					float fragment_unnamed_113 = fragment_unnamed_110.y;
					precise float fragment_unnamed_114 = fragment_unnamed_66 + fragment_unnamed_75;
					precise float fragment_unnamed_115 = fragment_unnamed_70 + fragment_unnamed_79;
					precise float fragment_unnamed_116 = 1.0f / fragment_unnamed_92;
					precise float fragment_unnamed_117 = fragment_unnamed_115 + fragment_unnamed_114;
					precise float fragment_unnamed_121 = fragment_unnamed_105 + fragment_unnamed_109;
					precise float fragment_unnamed_122 = fragment_unnamed_101 + fragment_unnamed_109;
					precise float fragment_unnamed_125 = fragment_unnamed_101 + fragment_unnamed_113;
					precise float fragment_unnamed_126 = fragment_unnamed_105 + fragment_unnamed_113;
					precise float fragment_unnamed_138 = mad(abs(mad(fragment_unnamed_57, -2.0f, fragment_unnamed_114)), 2.0f, abs(mad(fragment_unnamed_70, -2.0f, fragment_unnamed_121))) + abs(mad(fragment_unnamed_79, -2.0f, fragment_unnamed_125));
					precise float fragment_unnamed_139 = mad(abs(mad(fragment_unnamed_57, -2.0f, fragment_unnamed_115)), 2.0f, abs(mad(fragment_unnamed_75, -2.0f, fragment_unnamed_122))) + abs(mad(fragment_unnamed_66, -2.0f, fragment_unnamed_126));
					precise float fragment_unnamed_140 = fragment_unnamed_121 + fragment_unnamed_125;
					bool fragment_unnamed_141 = fragment_unnamed_138 >= fragment_unnamed_139;
					float fragment_unnamed_148 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_75) : asuint(fragment_unnamed_79));
					float fragment_unnamed_152 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_66) : asuint(fragment_unnamed_70));
					float fragment_unnamed_164 = asfloat(fragment_unnamed_141 ? asuint(fragment_uniform_buffer_0[30u]).y : asuint(fragment_uniform_buffer_0[30u]).x);
					precise float fragment_unnamed_165 = (-0.0f) - fragment_unnamed_57;
					precise float fragment_unnamed_168 = (-0.0f) - fragment_unnamed_57;
					precise float fragment_unnamed_169 = fragment_unnamed_168 + fragment_unnamed_148;
					precise float fragment_unnamed_170 = (-0.0f) - fragment_unnamed_57;
					precise float fragment_unnamed_171 = fragment_unnamed_170 + fragment_unnamed_152;
					precise float fragment_unnamed_172 = fragment_unnamed_57 + fragment_unnamed_148;
					precise float fragment_unnamed_173 = fragment_unnamed_57 + fragment_unnamed_152;
					bool fragment_unnamed_176 = abs(fragment_unnamed_169) >= abs(fragment_unnamed_171);
					precise float fragment_unnamed_180 = (-0.0f) - fragment_unnamed_164;
					float fragment_unnamed_181 = fragment_unnamed_176 ? fragment_unnamed_180 : fragment_unnamed_164;
					precise float fragment_unnamed_183 = fragment_unnamed_116 * abs(mad(mad(fragment_unnamed_117, 2.0f, fragment_unnamed_140), 0.083333335816860198974609375f, fragment_unnamed_165));
					float fragment_unnamed_184 = clamp(fragment_unnamed_183, 0.0f, 1.0f);
					float fragment_unnamed_190 = asfloat((fragment_unnamed_141 ? 4294967295u : 0u) & asuint(fragment_uniform_buffer_0[30u]).x);
					float fragment_unnamed_196 = asfloat(fragment_unnamed_141 ? 0u : asuint(fragment_uniform_buffer_0[30u]).y);
					float fragment_unnamed_206 = fragment_unnamed_141 ? fragment_input_1.x : mad(fragment_unnamed_181, 0.5f, fragment_input_1.x);
					float fragment_unnamed_209 = fragment_unnamed_141 ? mad(fragment_unnamed_181, 0.5f, fragment_input_1.y) : fragment_input_1.y;
					precise float fragment_unnamed_210 = (-0.0f) - fragment_unnamed_190;
					precise float fragment_unnamed_211 = fragment_unnamed_210 + fragment_unnamed_206;
					precise float fragment_unnamed_213 = (-0.0f) - fragment_unnamed_196;
					precise float fragment_unnamed_214 = fragment_unnamed_213 + fragment_unnamed_209;
					precise float fragment_unnamed_215 = fragment_unnamed_190 + fragment_unnamed_206;
					precise float fragment_unnamed_216 = fragment_unnamed_196 + fragment_unnamed_209;
					precise float fragment_unnamed_224 = clamp(fragment_unnamed_211, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_225 = clamp(fragment_unnamed_214, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_229 = fragment_unnamed_184 * fragment_unnamed_184;
					precise float fragment_unnamed_235 = clamp(fragment_unnamed_215, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_236 = clamp(fragment_unnamed_216, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float fragment_unnamed_243 = asfloat(fragment_unnamed_176 ? asuint(fragment_unnamed_172) : asuint(fragment_unnamed_173));
					precise float fragment_unnamed_244 = max(abs(fragment_unnamed_171), abs(fragment_unnamed_169)) * 0.25f;
					precise float fragment_unnamed_246 = (-0.0f) - fragment_unnamed_243;
					precise float fragment_unnamed_248 = fragment_unnamed_229 * mad(fragment_unnamed_184, -2.0f, 3.0f);
					uint fragment_unnamed_250 = (mad(fragment_unnamed_246, 0.5f, fragment_unnamed_57) < 0.0f) ? 4294967295u : 0u;
					precise float fragment_unnamed_251 = (-0.0f) - fragment_unnamed_243;
					float fragment_unnamed_252 = mad(fragment_unnamed_251, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_224, fragment_unnamed_225), 0.0f).y);
					precise float fragment_unnamed_253 = (-0.0f) - fragment_unnamed_243;
					float fragment_unnamed_254 = mad(fragment_unnamed_253, 0.5f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_235, fragment_unnamed_236), 0.0f).y);
					bool fragment_unnamed_257 = abs(fragment_unnamed_252) >= fragment_unnamed_244;
					bool fragment_unnamed_258 = abs(fragment_unnamed_254) >= fragment_unnamed_244;
					uint fragment_unnamed_259 = fragment_unnamed_257 ? 4294967295u : 0u;
					uint fragment_unnamed_260 = fragment_unnamed_258 ? 4294967295u : 0u;
					precise float fragment_unnamed_261 = (-0.0f) - fragment_unnamed_190;
					uint fragment_unnamed_265 = fragment_unnamed_257 ? asuint(fragment_unnamed_211) : asuint(mad(fragment_unnamed_261, 1.5f, fragment_unnamed_211));
					float fragment_unnamed_266 = asfloat(fragment_unnamed_265);
					precise float fragment_unnamed_267 = (-0.0f) - fragment_unnamed_196;
					uint fragment_unnamed_271 = fragment_unnamed_257 ? asuint(fragment_unnamed_214) : asuint(mad(fragment_unnamed_267, 1.5f, fragment_unnamed_214));
					float fragment_unnamed_272 = asfloat(fragment_unnamed_271);
					uint fragment_unnamed_279 = fragment_unnamed_258 ? asuint(fragment_unnamed_215) : asuint(mad(fragment_unnamed_190, 1.5f, fragment_unnamed_215));
					float fragment_unnamed_280 = asfloat(fragment_unnamed_279);
					uint fragment_unnamed_284 = fragment_unnamed_258 ? asuint(fragment_unnamed_216) : asuint(mad(fragment_unnamed_196, 1.5f, fragment_unnamed_216));
					float fragment_unnamed_285 = asfloat(fragment_unnamed_284);
					float fragment_unnamed_345;
					float fragment_unnamed_347;
					float fragment_unnamed_349;
					float fragment_unnamed_351;
					float fragment_unnamed_353;
					float fragment_unnamed_355;
					if (((~fragment_unnamed_260) | (~fragment_unnamed_259)) != 0u)
					{
						float fragment_unnamed_434;
						if (fragment_unnamed_259 == 0u)
						{
							precise float fragment_unnamed_428 = clamp(fragment_unnamed_266, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_429 = clamp(fragment_unnamed_272, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_434 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_428, fragment_unnamed_429), 0.0f).y;
						}
						else
						{
							fragment_unnamed_434 = fragment_unnamed_252;
						}
						float fragment_unnamed_447;
						if (fragment_unnamed_260 == 0u)
						{
							precise float fragment_unnamed_441 = clamp(fragment_unnamed_280, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							precise float fragment_unnamed_442 = clamp(fragment_unnamed_285, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
							fragment_unnamed_447 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_441, fragment_unnamed_442), 0.0f).y;
						}
						else
						{
							fragment_unnamed_447 = fragment_unnamed_254;
						}
						precise float fragment_unnamed_448 = (-0.0f) - fragment_unnamed_243;
						uint fragment_unnamed_452 = fragment_unnamed_257 ? asuint(fragment_unnamed_434) : asuint(mad(fragment_unnamed_448, 0.5f, fragment_unnamed_434));
						float fragment_unnamed_453 = asfloat(fragment_unnamed_452);
						precise float fragment_unnamed_454 = (-0.0f) - fragment_unnamed_243;
						float fragment_unnamed_459 = asfloat(fragment_unnamed_258 ? asuint(fragment_unnamed_447) : asuint(mad(fragment_unnamed_454, 0.5f, fragment_unnamed_447)));
						bool fragment_unnamed_462 = abs(fragment_unnamed_453) >= fragment_unnamed_244;
						bool fragment_unnamed_463 = abs(fragment_unnamed_459) >= fragment_unnamed_244;
						uint fragment_unnamed_464 = fragment_unnamed_462 ? 4294967295u : 0u;
						uint fragment_unnamed_465 = fragment_unnamed_463 ? 4294967295u : 0u;
						precise float fragment_unnamed_466 = (-0.0f) - fragment_unnamed_190;
						uint fragment_unnamed_469 = fragment_unnamed_462 ? fragment_unnamed_265 : asuint(mad(fragment_unnamed_466, 2.0f, fragment_unnamed_266));
						float fragment_unnamed_470 = asfloat(fragment_unnamed_469);
						precise float fragment_unnamed_471 = (-0.0f) - fragment_unnamed_196;
						uint fragment_unnamed_474 = fragment_unnamed_462 ? fragment_unnamed_271 : asuint(mad(fragment_unnamed_471, 2.0f, fragment_unnamed_272));
						float fragment_unnamed_475 = asfloat(fragment_unnamed_474);
						uint fragment_unnamed_481 = fragment_unnamed_463 ? fragment_unnamed_279 : asuint(mad(fragment_unnamed_190, 2.0f, fragment_unnamed_280));
						float fragment_unnamed_482 = asfloat(fragment_unnamed_481);
						uint fragment_unnamed_485 = fragment_unnamed_463 ? fragment_unnamed_284 : asuint(mad(fragment_unnamed_196, 2.0f, fragment_unnamed_285));
						float fragment_unnamed_486 = asfloat(fragment_unnamed_485);
						float fragment_unnamed_346;
						float fragment_unnamed_348;
						float fragment_unnamed_350;
						float fragment_unnamed_352;
						float fragment_unnamed_354;
						float fragment_unnamed_356;
						if (((~fragment_unnamed_465) | (~fragment_unnamed_464)) != 0u)
						{
							float fragment_unnamed_507;
							if (fragment_unnamed_464 == 0u)
							{
								precise float fragment_unnamed_500 = clamp(fragment_unnamed_470, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_501 = clamp(fragment_unnamed_475, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_507 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_500, fragment_unnamed_501), 0.0f).y;
							}
							else
							{
								fragment_unnamed_507 = asfloat(fragment_unnamed_452);
							}
							float fragment_unnamed_520;
							if (fragment_unnamed_465 == 0u)
							{
								precise float fragment_unnamed_514 = clamp(fragment_unnamed_482, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								precise float fragment_unnamed_515 = clamp(fragment_unnamed_486, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
								fragment_unnamed_520 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_514, fragment_unnamed_515), 0.0f).y;
							}
							else
							{
								fragment_unnamed_520 = fragment_unnamed_459;
							}
							precise float fragment_unnamed_521 = (-0.0f) - fragment_unnamed_243;
							uint fragment_unnamed_525 = fragment_unnamed_462 ? asuint(fragment_unnamed_507) : asuint(mad(fragment_unnamed_521, 0.5f, fragment_unnamed_507));
							float fragment_unnamed_526 = asfloat(fragment_unnamed_525);
							precise float fragment_unnamed_527 = (-0.0f) - fragment_unnamed_243;
							float fragment_unnamed_532 = asfloat(fragment_unnamed_463 ? asuint(fragment_unnamed_520) : asuint(mad(fragment_unnamed_527, 0.5f, fragment_unnamed_520)));
							bool fragment_unnamed_535 = abs(fragment_unnamed_526) >= fragment_unnamed_244;
							bool fragment_unnamed_536 = abs(fragment_unnamed_532) >= fragment_unnamed_244;
							uint fragment_unnamed_537 = fragment_unnamed_535 ? 4294967295u : 0u;
							uint fragment_unnamed_538 = fragment_unnamed_536 ? 4294967295u : 0u;
							precise float fragment_unnamed_539 = (-0.0f) - fragment_unnamed_190;
							uint fragment_unnamed_543 = fragment_unnamed_535 ? fragment_unnamed_469 : asuint(mad(fragment_unnamed_539, 4.0f, fragment_unnamed_470));
							float fragment_unnamed_544 = asfloat(fragment_unnamed_543);
							precise float fragment_unnamed_545 = (-0.0f) - fragment_unnamed_196;
							uint fragment_unnamed_548 = fragment_unnamed_535 ? fragment_unnamed_474 : asuint(mad(fragment_unnamed_545, 4.0f, fragment_unnamed_475));
							float fragment_unnamed_549 = asfloat(fragment_unnamed_548);
							uint fragment_unnamed_555 = fragment_unnamed_536 ? fragment_unnamed_481 : asuint(mad(fragment_unnamed_190, 4.0f, fragment_unnamed_482));
							float fragment_unnamed_556 = asfloat(fragment_unnamed_555);
							uint fragment_unnamed_559 = fragment_unnamed_536 ? fragment_unnamed_485 : asuint(mad(fragment_unnamed_196, 4.0f, fragment_unnamed_486));
							float fragment_unnamed_560 = asfloat(fragment_unnamed_559);
							float fragment_unnamed_489;
							float fragment_unnamed_490;
							float fragment_unnamed_491;
							float fragment_unnamed_492;
							float fragment_unnamed_493;
							float fragment_unnamed_494;
							if (((~fragment_unnamed_538) | (~fragment_unnamed_537)) != 0u)
							{
								float fragment_unnamed_581;
								if (fragment_unnamed_537 == 0u)
								{
									precise float fragment_unnamed_574 = clamp(fragment_unnamed_544, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_575 = clamp(fragment_unnamed_549, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_581 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_574, fragment_unnamed_575), 0.0f).y;
								}
								else
								{
									fragment_unnamed_581 = asfloat(fragment_unnamed_525);
								}
								float fragment_unnamed_594;
								if (fragment_unnamed_538 == 0u)
								{
									precise float fragment_unnamed_588 = clamp(fragment_unnamed_556, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									precise float fragment_unnamed_589 = clamp(fragment_unnamed_560, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
									fragment_unnamed_594 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_588, fragment_unnamed_589), 0.0f).y;
								}
								else
								{
									fragment_unnamed_594 = fragment_unnamed_532;
								}
								precise float fragment_unnamed_595 = (-0.0f) - fragment_unnamed_243;
								float fragment_unnamed_564 = asfloat(fragment_unnamed_535 ? asuint(fragment_unnamed_581) : asuint(mad(fragment_unnamed_595, 0.5f, fragment_unnamed_581)));
								precise float fragment_unnamed_600 = (-0.0f) - fragment_unnamed_243;
								float fragment_unnamed_563 = asfloat(fragment_unnamed_536 ? asuint(fragment_unnamed_594) : asuint(mad(fragment_unnamed_600, 0.5f, fragment_unnamed_594)));
								bool fragment_unnamed_607 = abs(fragment_unnamed_564) >= fragment_unnamed_244;
								bool fragment_unnamed_608 = abs(fragment_unnamed_563) >= fragment_unnamed_244;
								precise float fragment_unnamed_609 = (-0.0f) - fragment_unnamed_190;
								precise float fragment_unnamed_614 = (-0.0f) - fragment_unnamed_196;
								fragment_unnamed_489 = fragment_unnamed_563;
								fragment_unnamed_490 = fragment_unnamed_564;
								fragment_unnamed_491 = asfloat(fragment_unnamed_607 ? fragment_unnamed_543 : asuint(mad(fragment_unnamed_609, 12.0f, fragment_unnamed_544)));
								fragment_unnamed_492 = asfloat(fragment_unnamed_607 ? fragment_unnamed_548 : asuint(mad(fragment_unnamed_614, 12.0f, fragment_unnamed_549)));
								fragment_unnamed_493 = asfloat(fragment_unnamed_608 ? fragment_unnamed_555 : asuint(mad(fragment_unnamed_190, 12.0f, fragment_unnamed_556)));
								fragment_unnamed_494 = asfloat(fragment_unnamed_608 ? fragment_unnamed_559 : asuint(mad(fragment_unnamed_196, 12.0f, fragment_unnamed_560)));
							}
							else
							{
								fragment_unnamed_489 = fragment_unnamed_532;
								fragment_unnamed_490 = fragment_unnamed_526;
								fragment_unnamed_491 = fragment_unnamed_544;
								fragment_unnamed_492 = fragment_unnamed_549;
								fragment_unnamed_493 = fragment_unnamed_556;
								fragment_unnamed_494 = fragment_unnamed_560;
							}
							fragment_unnamed_346 = fragment_unnamed_489;
							fragment_unnamed_348 = fragment_unnamed_490;
							fragment_unnamed_350 = fragment_unnamed_491;
							fragment_unnamed_352 = fragment_unnamed_492;
							fragment_unnamed_354 = fragment_unnamed_493;
							fragment_unnamed_356 = fragment_unnamed_494;
						}
						else
						{
							fragment_unnamed_346 = fragment_unnamed_459;
							fragment_unnamed_348 = fragment_unnamed_453;
							fragment_unnamed_350 = fragment_unnamed_470;
							fragment_unnamed_352 = fragment_unnamed_475;
							fragment_unnamed_354 = fragment_unnamed_482;
							fragment_unnamed_356 = fragment_unnamed_486;
						}
						fragment_unnamed_345 = fragment_unnamed_346;
						fragment_unnamed_347 = fragment_unnamed_348;
						fragment_unnamed_349 = fragment_unnamed_350;
						fragment_unnamed_351 = fragment_unnamed_352;
						fragment_unnamed_353 = fragment_unnamed_354;
						fragment_unnamed_355 = fragment_unnamed_356;
					}
					else
					{
						fragment_unnamed_345 = fragment_unnamed_254;
						fragment_unnamed_347 = fragment_unnamed_252;
						fragment_unnamed_349 = fragment_unnamed_266;
						fragment_unnamed_351 = fragment_unnamed_272;
						fragment_unnamed_353 = fragment_unnamed_280;
						fragment_unnamed_355 = fragment_unnamed_285;
					}
					precise float fragment_unnamed_357 = (-0.0f) - fragment_unnamed_349;
					precise float fragment_unnamed_360 = fragment_unnamed_357 + fragment_input_1.x;
					precise float fragment_unnamed_363 = (-0.0f) - fragment_input_1.x;
					precise float fragment_unnamed_364 = fragment_unnamed_353 + fragment_unnamed_363;
					precise float fragment_unnamed_365 = (-0.0f) - fragment_unnamed_351;
					precise float fragment_unnamed_368 = fragment_unnamed_365 + fragment_input_1.y;
					float fragment_unnamed_372 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_360) : asuint(fragment_unnamed_368));
					precise float fragment_unnamed_375 = (-0.0f) - fragment_input_1.y;
					precise float fragment_unnamed_376 = fragment_unnamed_355 + fragment_unnamed_375;
					float fragment_unnamed_380 = asfloat(fragment_unnamed_141 ? asuint(fragment_unnamed_364) : asuint(fragment_unnamed_376));
					precise float fragment_unnamed_385 = fragment_unnamed_372 + fragment_unnamed_380;
					precise float fragment_unnamed_390 = 1.0f / fragment_unnamed_385;
					precise float fragment_unnamed_394 = fragment_unnamed_248 * fragment_unnamed_248;
					precise float fragment_unnamed_395 = (-0.0f) - fragment_unnamed_390;
					float fragment_unnamed_400 = max(fragment_unnamed_394, asfloat(asuint(mad(min(fragment_unnamed_380, fragment_unnamed_372), fragment_unnamed_395, 0.5f)) & ((fragment_unnamed_372 < fragment_unnamed_380) ? ((fragment_unnamed_250 != ((fragment_unnamed_347 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u) : ((fragment_unnamed_250 != ((fragment_unnamed_345 < 0.0f) ? 4294967295u : 0u)) ? 4294967295u : 0u))));
					precise float fragment_unnamed_418 = clamp(fragment_unnamed_141 ? fragment_input_1.x : mad(fragment_unnamed_400, fragment_unnamed_181, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					precise float fragment_unnamed_419 = clamp(fragment_unnamed_141 ? mad(fragment_unnamed_400, fragment_unnamed_181, fragment_input_1.y) : fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
					float4 fragment_unnamed_421 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_418, fragment_unnamed_419), 0.0f);
					fragment_unnamed_287 = fragment_unnamed_421.z;
					fragment_unnamed_289 = fragment_unnamed_421.y;
					fragment_unnamed_291 = fragment_unnamed_421.x;
				}
				else
				{
					fragment_unnamed_287 = fragment_unnamed_54.z;
					fragment_unnamed_289 = fragment_unnamed_57;
					fragment_unnamed_291 = fragment_unnamed_54.x;
				}
				float fragment_unnamed_320 = mad(_DitheringTex.Sample(sampler_DitheringTex, float2(mad(fragment_input_1.x, fragment_uniform_buffer_0[29u].x, fragment_uniform_buffer_0[29u].z), mad(fragment_input_1.y, fragment_uniform_buffer_0[29u].y, fragment_uniform_buffer_0[29u].w))).w, 2.0f, -1.0f);
				precise float fragment_unnamed_327 = (-0.0f) - abs(fragment_unnamed_320);
				precise float fragment_unnamed_328 = fragment_unnamed_327 + 1.0f;
				precise float fragment_unnamed_330 = (-0.0f) - sqrt(fragment_unnamed_328);
				precise float fragment_unnamed_331 = fragment_unnamed_330 + 1.0f;
				precise float fragment_unnamed_332 = fragment_unnamed_331 * mad(clamp(mad(fragment_unnamed_320, 3.4028234663852885981170418348452e+38f, 0.5f), 0.0f, 1.0f), 2.0f, -1.0f);
				fragment_output_0.x = mad(fragment_unnamed_332, 0.0039215688593685626983642578125f, fragment_unnamed_291);
				fragment_output_0.y = mad(fragment_unnamed_332, 0.0039215688593685626983642578125f, fragment_unnamed_289);
				fragment_output_0.z = mad(fragment_unnamed_332, 0.0039215688593685626983642578125f, fragment_unnamed_287);
				fragment_output_0.w = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y)).w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[29] = float4(_Dithering_Coords[0], _Dithering_Coords[1], _Dithering_Coords[2], _Dithering_Coords[3]);

				fragment_uniform_buffer_0[30] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(FXAA_KEEP_ALPHA) && defined(FXAA_LOW) && defined(STEREO_DOUBLEWIDE_TARGET) && !defined(STEREO_INSTANCING_ENABLED) && !defined(FXAA)


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
			GpuProgramID 192699

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag


			ENDHLSL
		}
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
			GpuProgramID 206267

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag


			ENDHLSL
		}
	}
}
