Shader "Stencil/Outline"
{
	Properties
	{
		_Color ("Color", Color) = (1,1,0,1)
		_Thickness ("Thickness", Float) = 7
	}
	SubShader
	{
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Transparent" }
		Pass
		{
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha
			Stencil
			{
				Ref 1
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 18155

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float3 _WorldSpaceCameraPos;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[5];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TANGENT; // TANGENT
				float3 vertex_output_3 : NORMAL; // NORMAL
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_49 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_50 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_51 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_52 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				precise float vertex_unnamed_86 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_49)) + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_87 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_50)) + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_88 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_51)) + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_89 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_52)) + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_97 = vertex_unnamed_87 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_98 = vertex_unnamed_87 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_99 = vertex_unnamed_87 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_100 = vertex_unnamed_87 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_89, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_88, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_86, vertex_unnamed_97)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_89, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_88, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_86, vertex_unnamed_98)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_89, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_88, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_86, vertex_unnamed_99)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_89, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_88, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_86, vertex_unnamed_100)));
				vertex_output_1.x = vertex_input_2.x;
				vertex_output_1.y = vertex_input_2.y;
				precise float vertex_unnamed_154 = vertex_uniform_buffer_0[4u].y * vertex_uniform_buffer_1[5u].x;
				precise float vertex_unnamed_155 = vertex_uniform_buffer_0[4u].y * vertex_uniform_buffer_1[5u].y;
				precise float vertex_unnamed_156 = vertex_uniform_buffer_0[4u].y * vertex_uniform_buffer_1[5u].z;
				precise float vertex_unnamed_186 = mad(vertex_uniform_buffer_1[6u].x, vertex_uniform_buffer_0[4u].z, mad(vertex_uniform_buffer_1[4u].x, vertex_uniform_buffer_0[4u].x, vertex_unnamed_154)) + vertex_uniform_buffer_1[7u].x;
				precise float vertex_unnamed_187 = mad(vertex_uniform_buffer_1[6u].y, vertex_uniform_buffer_0[4u].z, mad(vertex_uniform_buffer_1[4u].y, vertex_uniform_buffer_0[4u].x, vertex_unnamed_155)) + vertex_uniform_buffer_1[7u].y;
				precise float vertex_unnamed_188 = mad(vertex_uniform_buffer_1[6u].z, vertex_uniform_buffer_0[4u].z, mad(vertex_uniform_buffer_1[4u].z, vertex_uniform_buffer_0[4u].x, vertex_unnamed_156)) + vertex_uniform_buffer_1[7u].z;
				precise float vertex_unnamed_191 = (-0.0f) - vertex_input_0.x;
				precise float vertex_unnamed_195 = (-0.0f) - vertex_input_0.y;
				precise float vertex_unnamed_198 = (-0.0f) - vertex_input_0.z;
				precise float vertex_unnamed_199 = vertex_unnamed_186 + vertex_unnamed_191;
				precise float vertex_unnamed_200 = vertex_unnamed_187 + vertex_unnamed_195;
				precise float vertex_unnamed_201 = vertex_unnamed_188 + vertex_unnamed_198;
				vertex_output_2.x = vertex_unnamed_199;
				vertex_output_2.y = vertex_unnamed_200;
				vertex_output_2.z = vertex_unnamed_201;
				vertex_output_3.x = vertex_input_1.x;
				vertex_output_3.y = vertex_input_1.y;
				vertex_output_3.z = vertex_input_1.z;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], vertex_uniform_buffer_0[4][3]);

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
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				return stage_output;
			}


			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TANGENT; // TANGENT
				float3 fragment_input_3 : NORMAL; // NORMAL
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				fragment_output_0.x = 0.0f;
				fragment_output_0.y = 0.0f;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
		Pass
		{
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha
			Stencil
			{
				Comp Equal
				Pass Keep
				Fail Keep
				ZFail Keep
			}
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 117458

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma geometry geom
			#pragma target 4.0


			float3 _WorldSpaceCameraPos;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixVP;

			static float4 vertex_uniform_buffer_0[5];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float4 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float2 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float4 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TANGENT; // TANGENT
				float3 vertex_output_3 : NORMAL; // NORMAL
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				precise float vertex_unnamed_49 = vertex_input_0.y * vertex_uniform_buffer_1[1u].x;
				precise float vertex_unnamed_50 = vertex_input_0.y * vertex_uniform_buffer_1[1u].y;
				precise float vertex_unnamed_51 = vertex_input_0.y * vertex_uniform_buffer_1[1u].z;
				precise float vertex_unnamed_52 = vertex_input_0.y * vertex_uniform_buffer_1[1u].w;
				precise float vertex_unnamed_86 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_0.x, vertex_unnamed_49)) + vertex_uniform_buffer_1[3u].x;
				precise float vertex_unnamed_87 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_0.x, vertex_unnamed_50)) + vertex_uniform_buffer_1[3u].y;
				precise float vertex_unnamed_88 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_0.x, vertex_unnamed_51)) + vertex_uniform_buffer_1[3u].z;
				precise float vertex_unnamed_89 = mad(vertex_uniform_buffer_1[2u].w, vertex_input_0.z, mad(vertex_uniform_buffer_1[0u].w, vertex_input_0.x, vertex_unnamed_52)) + vertex_uniform_buffer_1[3u].w;
				precise float vertex_unnamed_97 = vertex_unnamed_87 * vertex_uniform_buffer_2[18u].x;
				precise float vertex_unnamed_98 = vertex_unnamed_87 * vertex_uniform_buffer_2[18u].y;
				precise float vertex_unnamed_99 = vertex_unnamed_87 * vertex_uniform_buffer_2[18u].z;
				precise float vertex_unnamed_100 = vertex_unnamed_87 * vertex_uniform_buffer_2[18u].w;
				gl_Position.x = mad(vertex_uniform_buffer_2[20u].x, vertex_unnamed_89, mad(vertex_uniform_buffer_2[19u].x, vertex_unnamed_88, mad(vertex_uniform_buffer_2[17u].x, vertex_unnamed_86, vertex_unnamed_97)));
				gl_Position.y = mad(vertex_uniform_buffer_2[20u].y, vertex_unnamed_89, mad(vertex_uniform_buffer_2[19u].y, vertex_unnamed_88, mad(vertex_uniform_buffer_2[17u].y, vertex_unnamed_86, vertex_unnamed_98)));
				gl_Position.z = mad(vertex_uniform_buffer_2[20u].z, vertex_unnamed_89, mad(vertex_uniform_buffer_2[19u].z, vertex_unnamed_88, mad(vertex_uniform_buffer_2[17u].z, vertex_unnamed_86, vertex_unnamed_99)));
				gl_Position.w = mad(vertex_uniform_buffer_2[20u].w, vertex_unnamed_89, mad(vertex_uniform_buffer_2[19u].w, vertex_unnamed_88, mad(vertex_uniform_buffer_2[17u].w, vertex_unnamed_86, vertex_unnamed_100)));
				vertex_output_1.x = vertex_input_2.x;
				vertex_output_1.y = vertex_input_2.y;
				precise float vertex_unnamed_154 = vertex_uniform_buffer_0[4u].y * vertex_uniform_buffer_1[5u].x;
				precise float vertex_unnamed_155 = vertex_uniform_buffer_0[4u].y * vertex_uniform_buffer_1[5u].y;
				precise float vertex_unnamed_156 = vertex_uniform_buffer_0[4u].y * vertex_uniform_buffer_1[5u].z;
				precise float vertex_unnamed_186 = mad(vertex_uniform_buffer_1[6u].x, vertex_uniform_buffer_0[4u].z, mad(vertex_uniform_buffer_1[4u].x, vertex_uniform_buffer_0[4u].x, vertex_unnamed_154)) + vertex_uniform_buffer_1[7u].x;
				precise float vertex_unnamed_187 = mad(vertex_uniform_buffer_1[6u].y, vertex_uniform_buffer_0[4u].z, mad(vertex_uniform_buffer_1[4u].y, vertex_uniform_buffer_0[4u].x, vertex_unnamed_155)) + vertex_uniform_buffer_1[7u].y;
				precise float vertex_unnamed_188 = mad(vertex_uniform_buffer_1[6u].z, vertex_uniform_buffer_0[4u].z, mad(vertex_uniform_buffer_1[4u].z, vertex_uniform_buffer_0[4u].x, vertex_unnamed_156)) + vertex_uniform_buffer_1[7u].z;
				precise float vertex_unnamed_191 = (-0.0f) - vertex_input_0.x;
				precise float vertex_unnamed_195 = (-0.0f) - vertex_input_0.y;
				precise float vertex_unnamed_198 = (-0.0f) - vertex_input_0.z;
				precise float vertex_unnamed_199 = vertex_unnamed_186 + vertex_unnamed_191;
				precise float vertex_unnamed_200 = vertex_unnamed_187 + vertex_unnamed_195;
				precise float vertex_unnamed_201 = vertex_unnamed_188 + vertex_unnamed_198;
				vertex_output_2.x = vertex_unnamed_199;
				vertex_output_2.y = vertex_unnamed_200;
				vertex_output_2.z = vertex_unnamed_201;
				vertex_output_3.x = vertex_input_1.x;
				vertex_output_3.y = vertex_input_1.y;
				vertex_output_3.z = vertex_input_1.z;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[4] = float4(_WorldSpaceCameraPos[0], _WorldSpaceCameraPos[1], _WorldSpaceCameraPos[2], vertex_uniform_buffer_0[4][3]);

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
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				return stage_output;
			}


			float4 _Color;

			static float4 fragment_uniform_buffer_0[3];
			static float2 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TANGENT; // TANGENT
				float3 fragment_input_3 : NORMAL; // NORMAL
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				fragment_output_0.x = fragment_uniform_buffer_0[2u].x;
				fragment_output_0.y = fragment_uniform_buffer_0[2u].y;
				fragment_output_0.z = fragment_uniform_buffer_0[2u].z;
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[2] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			// Unsupported builtin in HLSL.


			ENDHLSL
		}
	}
	FallBack "Diffuse"
}
