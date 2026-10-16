Shader "Hidden/PostProcessing/Debug/Vectorscope"
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
			GpuProgramID 9092

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


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
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f) * vertex_uniform_buffer_0[26u].x;
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f) * vertex_uniform_buffer_0[26u].x;
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


			float3 _Params;

			static float4 fragment_uniform_buffer_0[29];
			Buffer<uint4> T0;

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
				float fragment_unnamed_68 = max(mad(float(T0.Load(uint(mad(float(uint(mad(fragment_input_1.y, 1.0f, 0.0f) * fragment_uniform_buffer_0[28u].y)), fragment_uniform_buffer_0[28u].x, float(uint(mad(fragment_input_1.x, -1.0f, 1.0f) * fragment_uniform_buffer_0[28u].x))))).x), fragment_uniform_buffer_0[28u].z, -0.0040000001899898052215576171875f), 0.0f);
				float fragment_unnamed_76 = (fragment_unnamed_68 * mad(fragment_unnamed_68, 6.19999980926513671875f, 0.5f)) / mad(fragment_unnamed_68, mad(fragment_unnamed_68, 6.19999980926513671875f, 1.7000000476837158203125f), 0.0599999986588954925537109375f);
				float fragment_unnamed_78 = min(fragment_unnamed_76 * fragment_unnamed_76, 1.0f);
				float fragment_unnamed_84 = mad((-0.0f) - mad(fragment_input_1.y, 1.0f, -0.5f), 0.7139999866485595703125f, mad((-0.0f) - mad(fragment_input_1.x, -1.0f, 0.5f), 0.3440000116825103759765625f, 0.5f));
				float fragment_unnamed_90 = mad(fragment_input_1.y, 1.40299999713897705078125f, -0.201499998569488525390625f);
				float fragment_unnamed_93 = mad(fragment_input_1.x, 1.7730000019073486328125f, -0.38650000095367431640625f);
				fragment_output_0.x = mad(fragment_unnamed_78, (-0.0f) - fragment_unnamed_90, fragment_unnamed_90);
				fragment_output_0.y = mad(fragment_unnamed_78, (-0.0f) - fragment_unnamed_84, fragment_unnamed_84);
				fragment_output_0.z = mad(fragment_unnamed_78, (-0.0f) - fragment_unnamed_93, fragment_unnamed_93);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Params[0], _Params[1], _Params[2], fragment_uniform_buffer_0[28][3]);

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
