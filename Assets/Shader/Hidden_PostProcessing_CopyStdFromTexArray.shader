Shader "Hidden/PostProcessing/CopyStdFromTexArray"
{
	Properties
	{
		_MainTex ("", 2DArray) = "white" {}
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
			GpuProgramID 42606

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float _DepthSlice;

			static float4 vertex_uniform_buffer_0[1];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float3 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
				vertex_output_1.z = vertex_uniform_buffer_0[0u].x;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[0] = float4(_DepthSlice, vertex_uniform_buffer_0[0][1], vertex_uniform_buffer_0[0][2], vertex_uniform_buffer_0[0][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			Texture2DArray<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float3 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_1 : TEXCOORD; // TEXCOORD
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_36 = _MainTex.Sample(sampler_MainTex, float3(fragment_input_1.x, fragment_input_1.y, fragment_input_1.z));
				fragment_output_0.x = fragment_unnamed_36.x;
				fragment_output_0.y = fragment_unnamed_36.y;
				fragment_output_0.z = fragment_unnamed_36.z;
				fragment_output_0.w = fragment_unnamed_36.w;
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
			GpuProgramID 92485

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float _DepthSlice;

			static float4 vertex_uniform_buffer_0[1];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float3 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				vertex_output_1.x = mad(vertex_input_0.x, 0.5f, 0.5f);
				vertex_output_1.y = mad(vertex_input_0.y, -0.5f, 0.5f);
				vertex_output_1.z = vertex_uniform_buffer_0[0u].x;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[0] = float4(_DepthSlice, vertex_uniform_buffer_0[0][1], vertex_uniform_buffer_0[0][2], vertex_uniform_buffer_0[0][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			Texture2DArray<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float3 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_1 : TEXCOORD; // TEXCOORD
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_36 = _MainTex.Sample(sampler_MainTex, float3(fragment_input_1.x, fragment_input_1.y, fragment_input_1.z));
				float fragment_unnamed_38 = fragment_unnamed_36.x;
				float fragment_unnamed_39 = fragment_unnamed_36.y;
				float fragment_unnamed_40 = fragment_unnamed_36.z;
				float fragment_unnamed_41 = fragment_unnamed_36.w;
				bool fragment_unnamed_87 = (((((((fragment_unnamed_41 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_41) ? 4294967295u : 0u)) | ((fragment_unnamed_41 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u) | (((((((fragment_unnamed_40 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_40) ? 4294967295u : 0u)) | ((fragment_unnamed_40 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u) | (((((((fragment_unnamed_39 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_39) ? 4294967295u : 0u)) | ((fragment_unnamed_39 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u) | ((((((fragment_unnamed_38 < 0.0f) ? 4294967295u : 0u) | ((0.0f < fragment_unnamed_38) ? 4294967295u : 0u)) | ((fragment_unnamed_38 == 0.0f) ? 4294967295u : 0u)) == 0u) ? 4294967295u : 0u)))) != 0u;
				fragment_output_0.x = fragment_unnamed_87 ? 0.0f : fragment_unnamed_38;
				fragment_output_0.y = fragment_unnamed_87 ? 0.0f : fragment_unnamed_39;
				fragment_output_0.z = fragment_unnamed_87 ? 0.0f : fragment_unnamed_40;
				fragment_output_0.w = fragment_unnamed_87 ? 0.0f : fragment_unnamed_41;
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
