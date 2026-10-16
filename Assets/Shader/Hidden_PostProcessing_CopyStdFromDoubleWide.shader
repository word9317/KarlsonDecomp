Shader "Hidden/PostProcessing/CopyStdFromDoubleWide"
{
	Properties
	{
		_MainTex ("", 2D) = "white" {}
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
			GpuProgramID 12684

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float4 _UVScaleOffset;

			static float4 vertex_uniform_buffer_0[1];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float2 vertex_input_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float2 vertex_input_1 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = mad(vertex_input_0.x, 2.0f, -1.0f);
				gl_Position.y = mad(vertex_input_0.y, 2.0f, -1.0f);
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				vertex_output_1.x = mad(mad(vertex_input_1.x, 1.0f, 0.0f), vertex_uniform_buffer_0[0u].x, vertex_uniform_buffer_0[0u].z);
				vertex_output_1.y = mad(mad(vertex_input_1.y, -1.0f, 1.0f), vertex_uniform_buffer_0[0u].y, vertex_uniform_buffer_0[0u].w);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[0] = float4(_UVScaleOffset[0], _UVScaleOffset[1], _UVScaleOffset[2], _UVScaleOffset[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_33 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				fragment_output_0.x = fragment_unnamed_33.x;
				fragment_output_0.y = fragment_unnamed_33.y;
				fragment_output_0.z = fragment_unnamed_33.z;
				fragment_output_0.w = fragment_unnamed_33.w;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
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
			GpuProgramID 125565

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float4 _UVScaleOffset;

			static float4 vertex_uniform_buffer_0[1];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float2 vertex_input_1;
			static float2 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float2 vertex_input_1 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = mad(vertex_input_0.x, 2.0f, -1.0f);
				gl_Position.y = mad(vertex_input_0.y, 2.0f, -1.0f);
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				vertex_output_1.x = mad(mad(vertex_input_1.x, 1.0f, 0.0f), vertex_uniform_buffer_0[0u].x, vertex_uniform_buffer_0[0u].z);
				vertex_output_1.y = mad(mad(vertex_input_1.y, -1.0f, 1.0f), vertex_uniform_buffer_0[0u].y, vertex_uniform_buffer_0[0u].w);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[0] = float4(_UVScaleOffset[0], _UVScaleOffset[1], _UVScaleOffset[2], _UVScaleOffset[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_33 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_35 = fragment_unnamed_33.x;
				float fragment_unnamed_36 = fragment_unnamed_33.y;
				float fragment_unnamed_37 = fragment_unnamed_33.z;
				float fragment_unnamed_38 = fragment_unnamed_33.w;
				bool fragment_unnamed_84 = (((((((fragment_unnamed_38 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_38) ? 4294967295u : 0u)) | ((fragment_unnamed_38 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u) | (((((((fragment_unnamed_37 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_37) ? 4294967295u : 0u)) | ((fragment_unnamed_37 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u) | (((((((fragment_unnamed_36 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_36) ? 4294967295u : 0u)) | ((fragment_unnamed_36 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u) | ((((((fragment_unnamed_35 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_35) ? 4294967295u : 0u)) | ((fragment_unnamed_35 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u)))) != 0u;
				fragment_output_0.x = fragment_unnamed_84 ? 0.0f : fragment_unnamed_35;
				fragment_output_0.y = fragment_unnamed_84 ? 0.0f : fragment_unnamed_36;
				fragment_output_0.z = fragment_unnamed_84 ? 0.0f : fragment_unnamed_37;
				fragment_output_0.w = fragment_unnamed_84 ? 0.0f : fragment_unnamed_38;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
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
