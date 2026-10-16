Shader "Hidden/PostProcessing/SubpixelMorphologicalAntialiasing"
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
			GpuProgramID 58262

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float4 _MainTex_TexelSize;

			static float4 vertex_uniform_buffer_0[29];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_44 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_45 = vertex_input_0.y + 1.0f;
				float vertex_unnamed_47 = mad(vertex_unnamed_44, 0.5f, 0.0f);
				float vertex_unnamed_49 = mad(vertex_unnamed_45, -0.5f, 1.0f);
				vertex_output_1.x = vertex_unnamed_47;
				vertex_output_1.y = vertex_unnamed_49;
				vertex_output_2.x = mad(vertex_uniform_buffer_0[28u].x, -1.0f, vertex_unnamed_47);
				vertex_output_2.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_49);
				vertex_output_2.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_47);
				vertex_output_2.w = mad(vertex_uniform_buffer_0[28u].y, -1.0f, vertex_unnamed_49);
				vertex_output_3.x = mad(vertex_uniform_buffer_0[28u].x, 1.0f, vertex_unnamed_47);
				vertex_output_3.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_49);
				vertex_output_3.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_47);
				vertex_output_3.w = mad(vertex_uniform_buffer_0[28u].y, 1.0f, vertex_unnamed_49);
				vertex_output_4.x = mad(vertex_uniform_buffer_0[28u].x, -2.0f, vertex_unnamed_47);
				vertex_output_4.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_49);
				vertex_output_4.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_47);
				vertex_output_4.w = mad(vertex_uniform_buffer_0[28u].y, -2.0f, vertex_unnamed_49);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}


			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float4 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_210)
			{
				if (fragment_unnamed_210)
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
				float4 fragment_unnamed_36 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_38 = fragment_unnamed_36.x;
				float fragment_unnamed_39 = fragment_unnamed_36.y;
				float fragment_unnamed_40 = fragment_unnamed_36.z;
				float4 fragment_unnamed_45 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_47 = fragment_unnamed_45.x;
				float fragment_unnamed_48 = fragment_unnamed_45.y;
				float fragment_unnamed_49 = fragment_unnamed_45.z;
				precise float fragment_unnamed_50 = (-0.0f) - fragment_unnamed_47;
				precise float fragment_unnamed_52 = (-0.0f) - fragment_unnamed_48;
				precise float fragment_unnamed_53 = (-0.0f) - fragment_unnamed_49;
				precise float fragment_unnamed_54 = fragment_unnamed_38 + fragment_unnamed_50;
				precise float fragment_unnamed_55 = fragment_unnamed_39 + fragment_unnamed_52;
				precise float fragment_unnamed_56 = fragment_unnamed_40 + fragment_unnamed_53;
				float fragment_unnamed_62 = max(abs(fragment_unnamed_56), max(abs(fragment_unnamed_55), abs(fragment_unnamed_54)));
				float4 fragment_unnamed_69 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.z, fragment_input_2.w));
				float fragment_unnamed_71 = fragment_unnamed_69.x;
				float fragment_unnamed_72 = fragment_unnamed_69.y;
				float fragment_unnamed_73 = fragment_unnamed_69.z;
				precise float fragment_unnamed_74 = (-0.0f) - fragment_unnamed_71;
				precise float fragment_unnamed_75 = (-0.0f) - fragment_unnamed_72;
				precise float fragment_unnamed_76 = (-0.0f) - fragment_unnamed_73;
				precise float fragment_unnamed_77 = fragment_unnamed_38 + fragment_unnamed_74;
				precise float fragment_unnamed_78 = fragment_unnamed_39 + fragment_unnamed_75;
				precise float fragment_unnamed_79 = fragment_unnamed_40 + fragment_unnamed_76;
				float fragment_unnamed_84 = max(abs(fragment_unnamed_79), max(abs(fragment_unnamed_78), abs(fragment_unnamed_77)));
				float fragment_unnamed_94 = asfloat(((fragment_unnamed_62 >= 0.1500000059604644775390625f) ? 4294967295u : 0u) & 1065353216u);
				uint fragment_unnamed_95 = ((fragment_unnamed_84 >= 0.1500000059604644775390625f) ? 4294967295u : 0u) & 1065353216u;
				discard_cond(dot(float2(fragment_unnamed_94, asfloat(fragment_unnamed_95)), 1.0f.xx) == 0.0f);
				float4 fragment_unnamed_109 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_3.x, fragment_input_3.y));
				precise float fragment_unnamed_114 = (-0.0f) - fragment_unnamed_109.x;
				precise float fragment_unnamed_115 = (-0.0f) - fragment_unnamed_109.y;
				precise float fragment_unnamed_116 = (-0.0f) - fragment_unnamed_109.z;
				precise float fragment_unnamed_117 = fragment_unnamed_38 + fragment_unnamed_114;
				precise float fragment_unnamed_118 = fragment_unnamed_39 + fragment_unnamed_115;
				precise float fragment_unnamed_119 = fragment_unnamed_40 + fragment_unnamed_116;
				float4 fragment_unnamed_129 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_3.z, fragment_input_3.w));
				precise float fragment_unnamed_134 = (-0.0f) - fragment_unnamed_129.x;
				precise float fragment_unnamed_135 = (-0.0f) - fragment_unnamed_129.y;
				precise float fragment_unnamed_136 = (-0.0f) - fragment_unnamed_129.z;
				precise float fragment_unnamed_137 = fragment_unnamed_38 + fragment_unnamed_134;
				precise float fragment_unnamed_138 = fragment_unnamed_39 + fragment_unnamed_135;
				precise float fragment_unnamed_139 = fragment_unnamed_40 + fragment_unnamed_136;
				float4 fragment_unnamed_151 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_4.x, fragment_input_4.y));
				precise float fragment_unnamed_156 = (-0.0f) - fragment_unnamed_151.x;
				precise float fragment_unnamed_157 = (-0.0f) - fragment_unnamed_151.y;
				precise float fragment_unnamed_158 = (-0.0f) - fragment_unnamed_151.z;
				precise float fragment_unnamed_159 = fragment_unnamed_47 + fragment_unnamed_156;
				precise float fragment_unnamed_160 = fragment_unnamed_48 + fragment_unnamed_157;
				precise float fragment_unnamed_161 = fragment_unnamed_49 + fragment_unnamed_158;
				float4 fragment_unnamed_171 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_4.z, fragment_input_4.w));
				precise float fragment_unnamed_176 = (-0.0f) - fragment_unnamed_171.x;
				precise float fragment_unnamed_177 = (-0.0f) - fragment_unnamed_171.y;
				precise float fragment_unnamed_178 = (-0.0f) - fragment_unnamed_171.z;
				precise float fragment_unnamed_179 = fragment_unnamed_71 + fragment_unnamed_176;
				precise float fragment_unnamed_180 = fragment_unnamed_72 + fragment_unnamed_177;
				precise float fragment_unnamed_181 = fragment_unnamed_73 + fragment_unnamed_178;
				float fragment_unnamed_189 = max(max(max(fragment_unnamed_84, max(abs(fragment_unnamed_139), max(abs(fragment_unnamed_138), abs(fragment_unnamed_137)))), max(abs(fragment_unnamed_181), max(abs(fragment_unnamed_180), abs(fragment_unnamed_179)))), max(max(fragment_unnamed_62, max(abs(fragment_unnamed_119), max(abs(fragment_unnamed_118), abs(fragment_unnamed_117)))), max(abs(fragment_unnamed_161), max(abs(fragment_unnamed_160), abs(fragment_unnamed_159)))));
				precise float fragment_unnamed_190 = fragment_unnamed_62 + fragment_unnamed_62;
				precise float fragment_unnamed_191 = fragment_unnamed_84 + fragment_unnamed_84;
				precise float fragment_unnamed_201 = asfloat(((fragment_unnamed_190 >= fragment_unnamed_189) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_94;
				precise float fragment_unnamed_202 = asfloat(((fragment_unnamed_191 >= fragment_unnamed_189) ? 4294967295u : 0u) & 1065353216u) * asfloat(fragment_unnamed_95);
				fragment_output_0.x = fragment_unnamed_201;
				fragment_output_0.y = fragment_unnamed_202;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
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
			GpuProgramID 122362

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float4 _MainTex_TexelSize;

			static float4 vertex_uniform_buffer_0[29];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_44 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_45 = vertex_input_0.y + 1.0f;
				float vertex_unnamed_47 = mad(vertex_unnamed_44, 0.5f, 0.0f);
				float vertex_unnamed_49 = mad(vertex_unnamed_45, -0.5f, 1.0f);
				vertex_output_1.x = vertex_unnamed_47;
				vertex_output_1.y = vertex_unnamed_49;
				vertex_output_2.x = mad(vertex_uniform_buffer_0[28u].x, -1.0f, vertex_unnamed_47);
				vertex_output_2.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_49);
				vertex_output_2.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_47);
				vertex_output_2.w = mad(vertex_uniform_buffer_0[28u].y, -1.0f, vertex_unnamed_49);
				vertex_output_3.x = mad(vertex_uniform_buffer_0[28u].x, 1.0f, vertex_unnamed_47);
				vertex_output_3.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_49);
				vertex_output_3.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_47);
				vertex_output_3.w = mad(vertex_uniform_buffer_0[28u].y, 1.0f, vertex_unnamed_49);
				vertex_output_4.x = mad(vertex_uniform_buffer_0[28u].x, -2.0f, vertex_unnamed_47);
				vertex_output_4.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_49);
				vertex_output_4.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_47);
				vertex_output_4.w = mad(vertex_uniform_buffer_0[28u].y, -2.0f, vertex_unnamed_49);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}


			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float4 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_210)
			{
				if (fragment_unnamed_210)
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
				float4 fragment_unnamed_36 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_38 = fragment_unnamed_36.x;
				float fragment_unnamed_39 = fragment_unnamed_36.y;
				float fragment_unnamed_40 = fragment_unnamed_36.z;
				float4 fragment_unnamed_45 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_47 = fragment_unnamed_45.x;
				float fragment_unnamed_48 = fragment_unnamed_45.y;
				float fragment_unnamed_49 = fragment_unnamed_45.z;
				precise float fragment_unnamed_50 = (-0.0f) - fragment_unnamed_47;
				precise float fragment_unnamed_52 = (-0.0f) - fragment_unnamed_48;
				precise float fragment_unnamed_53 = (-0.0f) - fragment_unnamed_49;
				precise float fragment_unnamed_54 = fragment_unnamed_38 + fragment_unnamed_50;
				precise float fragment_unnamed_55 = fragment_unnamed_39 + fragment_unnamed_52;
				precise float fragment_unnamed_56 = fragment_unnamed_40 + fragment_unnamed_53;
				float fragment_unnamed_62 = max(abs(fragment_unnamed_56), max(abs(fragment_unnamed_55), abs(fragment_unnamed_54)));
				float4 fragment_unnamed_69 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.z, fragment_input_2.w));
				float fragment_unnamed_71 = fragment_unnamed_69.x;
				float fragment_unnamed_72 = fragment_unnamed_69.y;
				float fragment_unnamed_73 = fragment_unnamed_69.z;
				precise float fragment_unnamed_74 = (-0.0f) - fragment_unnamed_71;
				precise float fragment_unnamed_75 = (-0.0f) - fragment_unnamed_72;
				precise float fragment_unnamed_76 = (-0.0f) - fragment_unnamed_73;
				precise float fragment_unnamed_77 = fragment_unnamed_38 + fragment_unnamed_74;
				precise float fragment_unnamed_78 = fragment_unnamed_39 + fragment_unnamed_75;
				precise float fragment_unnamed_79 = fragment_unnamed_40 + fragment_unnamed_76;
				float fragment_unnamed_84 = max(abs(fragment_unnamed_79), max(abs(fragment_unnamed_78), abs(fragment_unnamed_77)));
				float fragment_unnamed_94 = asfloat(((fragment_unnamed_62 >= 0.100000001490116119384765625f) ? 4294967295u : 0u) & 1065353216u);
				uint fragment_unnamed_95 = ((fragment_unnamed_84 >= 0.100000001490116119384765625f) ? 4294967295u : 0u) & 1065353216u;
				discard_cond(dot(float2(fragment_unnamed_94, asfloat(fragment_unnamed_95)), 1.0f.xx) == 0.0f);
				float4 fragment_unnamed_109 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_3.x, fragment_input_3.y));
				precise float fragment_unnamed_114 = (-0.0f) - fragment_unnamed_109.x;
				precise float fragment_unnamed_115 = (-0.0f) - fragment_unnamed_109.y;
				precise float fragment_unnamed_116 = (-0.0f) - fragment_unnamed_109.z;
				precise float fragment_unnamed_117 = fragment_unnamed_38 + fragment_unnamed_114;
				precise float fragment_unnamed_118 = fragment_unnamed_39 + fragment_unnamed_115;
				precise float fragment_unnamed_119 = fragment_unnamed_40 + fragment_unnamed_116;
				float4 fragment_unnamed_129 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_3.z, fragment_input_3.w));
				precise float fragment_unnamed_134 = (-0.0f) - fragment_unnamed_129.x;
				precise float fragment_unnamed_135 = (-0.0f) - fragment_unnamed_129.y;
				precise float fragment_unnamed_136 = (-0.0f) - fragment_unnamed_129.z;
				precise float fragment_unnamed_137 = fragment_unnamed_38 + fragment_unnamed_134;
				precise float fragment_unnamed_138 = fragment_unnamed_39 + fragment_unnamed_135;
				precise float fragment_unnamed_139 = fragment_unnamed_40 + fragment_unnamed_136;
				float4 fragment_unnamed_151 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_4.x, fragment_input_4.y));
				precise float fragment_unnamed_156 = (-0.0f) - fragment_unnamed_151.x;
				precise float fragment_unnamed_157 = (-0.0f) - fragment_unnamed_151.y;
				precise float fragment_unnamed_158 = (-0.0f) - fragment_unnamed_151.z;
				precise float fragment_unnamed_159 = fragment_unnamed_47 + fragment_unnamed_156;
				precise float fragment_unnamed_160 = fragment_unnamed_48 + fragment_unnamed_157;
				precise float fragment_unnamed_161 = fragment_unnamed_49 + fragment_unnamed_158;
				float4 fragment_unnamed_171 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_4.z, fragment_input_4.w));
				precise float fragment_unnamed_176 = (-0.0f) - fragment_unnamed_171.x;
				precise float fragment_unnamed_177 = (-0.0f) - fragment_unnamed_171.y;
				precise float fragment_unnamed_178 = (-0.0f) - fragment_unnamed_171.z;
				precise float fragment_unnamed_179 = fragment_unnamed_71 + fragment_unnamed_176;
				precise float fragment_unnamed_180 = fragment_unnamed_72 + fragment_unnamed_177;
				precise float fragment_unnamed_181 = fragment_unnamed_73 + fragment_unnamed_178;
				float fragment_unnamed_189 = max(max(max(fragment_unnamed_84, max(abs(fragment_unnamed_139), max(abs(fragment_unnamed_138), abs(fragment_unnamed_137)))), max(abs(fragment_unnamed_181), max(abs(fragment_unnamed_180), abs(fragment_unnamed_179)))), max(max(fragment_unnamed_62, max(abs(fragment_unnamed_119), max(abs(fragment_unnamed_118), abs(fragment_unnamed_117)))), max(abs(fragment_unnamed_161), max(abs(fragment_unnamed_160), abs(fragment_unnamed_159)))));
				precise float fragment_unnamed_190 = fragment_unnamed_62 + fragment_unnamed_62;
				precise float fragment_unnamed_191 = fragment_unnamed_84 + fragment_unnamed_84;
				precise float fragment_unnamed_201 = asfloat(((fragment_unnamed_190 >= fragment_unnamed_189) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_94;
				precise float fragment_unnamed_202 = asfloat(((fragment_unnamed_191 >= fragment_unnamed_189) ? 4294967295u : 0u) & 1065353216u) * asfloat(fragment_unnamed_95);
				fragment_output_0.x = fragment_unnamed_201;
				fragment_output_0.y = fragment_unnamed_202;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
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
			GpuProgramID 185718

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float4 _MainTex_TexelSize;

			static float4 vertex_uniform_buffer_0[29];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				precise float vertex_unnamed_44 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_45 = vertex_input_0.y + 1.0f;
				float vertex_unnamed_47 = mad(vertex_unnamed_44, 0.5f, 0.0f);
				float vertex_unnamed_49 = mad(vertex_unnamed_45, -0.5f, 1.0f);
				vertex_output_1.x = vertex_unnamed_47;
				vertex_output_1.y = vertex_unnamed_49;
				vertex_output_2.x = mad(vertex_uniform_buffer_0[28u].x, -1.0f, vertex_unnamed_47);
				vertex_output_2.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_49);
				vertex_output_2.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_47);
				vertex_output_2.w = mad(vertex_uniform_buffer_0[28u].y, -1.0f, vertex_unnamed_49);
				vertex_output_3.x = mad(vertex_uniform_buffer_0[28u].x, 1.0f, vertex_unnamed_47);
				vertex_output_3.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_49);
				vertex_output_3.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_47);
				vertex_output_3.w = mad(vertex_uniform_buffer_0[28u].y, 1.0f, vertex_unnamed_49);
				vertex_output_4.x = mad(vertex_uniform_buffer_0[28u].x, -2.0f, vertex_unnamed_47);
				vertex_output_4.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_49);
				vertex_output_4.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_47);
				vertex_output_4.w = mad(vertex_uniform_buffer_0[28u].y, -2.0f, vertex_unnamed_49);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}


			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float4 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_210)
			{
				if (fragment_unnamed_210)
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
				float4 fragment_unnamed_36 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_38 = fragment_unnamed_36.x;
				float fragment_unnamed_39 = fragment_unnamed_36.y;
				float fragment_unnamed_40 = fragment_unnamed_36.z;
				float4 fragment_unnamed_45 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_47 = fragment_unnamed_45.x;
				float fragment_unnamed_48 = fragment_unnamed_45.y;
				float fragment_unnamed_49 = fragment_unnamed_45.z;
				precise float fragment_unnamed_50 = (-0.0f) - fragment_unnamed_47;
				precise float fragment_unnamed_52 = (-0.0f) - fragment_unnamed_48;
				precise float fragment_unnamed_53 = (-0.0f) - fragment_unnamed_49;
				precise float fragment_unnamed_54 = fragment_unnamed_38 + fragment_unnamed_50;
				precise float fragment_unnamed_55 = fragment_unnamed_39 + fragment_unnamed_52;
				precise float fragment_unnamed_56 = fragment_unnamed_40 + fragment_unnamed_53;
				float fragment_unnamed_62 = max(abs(fragment_unnamed_56), max(abs(fragment_unnamed_55), abs(fragment_unnamed_54)));
				float4 fragment_unnamed_69 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_2.z, fragment_input_2.w));
				float fragment_unnamed_71 = fragment_unnamed_69.x;
				float fragment_unnamed_72 = fragment_unnamed_69.y;
				float fragment_unnamed_73 = fragment_unnamed_69.z;
				precise float fragment_unnamed_74 = (-0.0f) - fragment_unnamed_71;
				precise float fragment_unnamed_75 = (-0.0f) - fragment_unnamed_72;
				precise float fragment_unnamed_76 = (-0.0f) - fragment_unnamed_73;
				precise float fragment_unnamed_77 = fragment_unnamed_38 + fragment_unnamed_74;
				precise float fragment_unnamed_78 = fragment_unnamed_39 + fragment_unnamed_75;
				precise float fragment_unnamed_79 = fragment_unnamed_40 + fragment_unnamed_76;
				float fragment_unnamed_84 = max(abs(fragment_unnamed_79), max(abs(fragment_unnamed_78), abs(fragment_unnamed_77)));
				float fragment_unnamed_94 = asfloat(((fragment_unnamed_62 >= 0.100000001490116119384765625f) ? 4294967295u : 0u) & 1065353216u);
				uint fragment_unnamed_95 = ((fragment_unnamed_84 >= 0.100000001490116119384765625f) ? 4294967295u : 0u) & 1065353216u;
				discard_cond(dot(float2(fragment_unnamed_94, asfloat(fragment_unnamed_95)), 1.0f.xx) == 0.0f);
				float4 fragment_unnamed_109 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_3.x, fragment_input_3.y));
				precise float fragment_unnamed_114 = (-0.0f) - fragment_unnamed_109.x;
				precise float fragment_unnamed_115 = (-0.0f) - fragment_unnamed_109.y;
				precise float fragment_unnamed_116 = (-0.0f) - fragment_unnamed_109.z;
				precise float fragment_unnamed_117 = fragment_unnamed_38 + fragment_unnamed_114;
				precise float fragment_unnamed_118 = fragment_unnamed_39 + fragment_unnamed_115;
				precise float fragment_unnamed_119 = fragment_unnamed_40 + fragment_unnamed_116;
				float4 fragment_unnamed_129 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_3.z, fragment_input_3.w));
				precise float fragment_unnamed_134 = (-0.0f) - fragment_unnamed_129.x;
				precise float fragment_unnamed_135 = (-0.0f) - fragment_unnamed_129.y;
				precise float fragment_unnamed_136 = (-0.0f) - fragment_unnamed_129.z;
				precise float fragment_unnamed_137 = fragment_unnamed_38 + fragment_unnamed_134;
				precise float fragment_unnamed_138 = fragment_unnamed_39 + fragment_unnamed_135;
				precise float fragment_unnamed_139 = fragment_unnamed_40 + fragment_unnamed_136;
				float4 fragment_unnamed_151 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_4.x, fragment_input_4.y));
				precise float fragment_unnamed_156 = (-0.0f) - fragment_unnamed_151.x;
				precise float fragment_unnamed_157 = (-0.0f) - fragment_unnamed_151.y;
				precise float fragment_unnamed_158 = (-0.0f) - fragment_unnamed_151.z;
				precise float fragment_unnamed_159 = fragment_unnamed_47 + fragment_unnamed_156;
				precise float fragment_unnamed_160 = fragment_unnamed_48 + fragment_unnamed_157;
				precise float fragment_unnamed_161 = fragment_unnamed_49 + fragment_unnamed_158;
				float4 fragment_unnamed_171 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_4.z, fragment_input_4.w));
				precise float fragment_unnamed_176 = (-0.0f) - fragment_unnamed_171.x;
				precise float fragment_unnamed_177 = (-0.0f) - fragment_unnamed_171.y;
				precise float fragment_unnamed_178 = (-0.0f) - fragment_unnamed_171.z;
				precise float fragment_unnamed_179 = fragment_unnamed_71 + fragment_unnamed_176;
				precise float fragment_unnamed_180 = fragment_unnamed_72 + fragment_unnamed_177;
				precise float fragment_unnamed_181 = fragment_unnamed_73 + fragment_unnamed_178;
				float fragment_unnamed_189 = max(max(max(fragment_unnamed_84, max(abs(fragment_unnamed_139), max(abs(fragment_unnamed_138), abs(fragment_unnamed_137)))), max(abs(fragment_unnamed_181), max(abs(fragment_unnamed_180), abs(fragment_unnamed_179)))), max(max(fragment_unnamed_62, max(abs(fragment_unnamed_119), max(abs(fragment_unnamed_118), abs(fragment_unnamed_117)))), max(abs(fragment_unnamed_161), max(abs(fragment_unnamed_160), abs(fragment_unnamed_159)))));
				precise float fragment_unnamed_190 = fragment_unnamed_62 + fragment_unnamed_62;
				precise float fragment_unnamed_191 = fragment_unnamed_84 + fragment_unnamed_84;
				precise float fragment_unnamed_201 = asfloat(((fragment_unnamed_190 >= fragment_unnamed_189) ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_94;
				precise float fragment_unnamed_202 = asfloat(((fragment_unnamed_191 >= fragment_unnamed_189) ? 4294967295u : 0u) & 1065353216u) * asfloat(fragment_unnamed_95);
				fragment_output_0.x = fragment_unnamed_201;
				fragment_output_0.y = fragment_unnamed_202;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
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
			GpuProgramID 210173

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float4 _MainTex_TexelSize;

			static float4 vertex_uniform_buffer_0[29];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_2 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_3 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_4 : TEXCOORD4; // TEXCOORD_4
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
				precise float vertex_unnamed_56 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_57 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_58 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_59 = vertex_input_0.y + 1.0f;
				float vertex_unnamed_62 = mad(vertex_unnamed_58, 0.5f, 0.0f);
				float vertex_unnamed_63 = mad(vertex_unnamed_59, -0.5f, 1.0f);
				precise float vertex_unnamed_70 = vertex_unnamed_62 * vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_71 = vertex_unnamed_63 * vertex_uniform_buffer_0[28u].w;
				vertex_output_1.x = vertex_unnamed_70;
				vertex_output_1.y = vertex_unnamed_71;
				float vertex_unnamed_78 = mad(vertex_uniform_buffer_0[28u].x, -0.25f, vertex_unnamed_62);
				float vertex_unnamed_80 = mad(vertex_uniform_buffer_0[28u].x, 1.25f, vertex_unnamed_62);
				float vertex_unnamed_90 = mad(vertex_uniform_buffer_0[28u].y, -0.25f, mad(vertex_unnamed_57, -0.5f, 1.0f));
				float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[28u].y, 1.25f, vertex_unnamed_63);
				vertex_output_2.x = vertex_unnamed_78;
				vertex_output_2.y = mad(vertex_uniform_buffer_0[28u].y, -0.125f, vertex_unnamed_63);
				vertex_output_2.z = vertex_unnamed_80;
				vertex_output_2.w = mad(vertex_uniform_buffer_0[28u].y, -0.125f, vertex_unnamed_63);
				vertex_output_3.x = mad(vertex_uniform_buffer_0[28u].x, -0.125f, mad(vertex_unnamed_56, 0.5f, 0.0f));
				vertex_output_3.y = vertex_unnamed_90;
				vertex_output_3.z = mad(vertex_uniform_buffer_0[28u].x, -0.125f, vertex_unnamed_62);
				vertex_output_3.w = vertex_unnamed_92;
				vertex_output_4.x = mad(vertex_uniform_buffer_0[28u].x, -8.0f, vertex_unnamed_78);
				vertex_output_4.y = mad(vertex_uniform_buffer_0[28u].x, 8.0f, vertex_unnamed_80);
				vertex_output_4.z = mad(vertex_uniform_buffer_0[28u].y, -8.0f, vertex_unnamed_90);
				vertex_output_4.w = mad(vertex_uniform_buffer_0[28u].y, 8.0f, vertex_unnamed_92);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}


			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[29];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _AreaTex;
			Texture2D<float4> _SearchTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_2 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_3 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_4 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_46 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				if (0.0f < fragment_unnamed_46.y)
				{
					float fragment_unnamed_63;
					float fragment_unnamed_67;
					float fragment_unnamed_69;
					fragment_unnamed_63 = fragment_input_2.x;
					fragment_unnamed_67 = asfloat(1065353216u);
					fragment_unnamed_69 = asfloat(0u);
					float4 fragment_unnamed_119;
					float2 fragment_unnamed_120;
					for (float fragment_unnamed_65 = fragment_input_2.y; !((((fragment_unnamed_69 == 0.0f) ? 4294967295u : 0u) & (((0.828100025653839111328125f < fragment_unnamed_67) ? 4294967295u : 0u) & ((fragment_input_4.x < fragment_unnamed_63) ? 4294967295u : 0u))) == 0u); fragment_unnamed_120 = float2(fragment_unnamed_63, fragment_unnamed_65), fragment_unnamed_119 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_120, 0.0f), fragment_unnamed_63 = mad(fragment_uniform_buffer_0[28u].x, -2.0f, fragment_unnamed_63), fragment_unnamed_65 = mad(fragment_uniform_buffer_0[28u].y, -0.0f, fragment_unnamed_65), fragment_unnamed_67 = fragment_unnamed_119.y, fragment_unnamed_69 = fragment_unnamed_119.x)
					{
					}
					float fragment_unnamed_103 = mad(fragment_uniform_buffer_0[28u].x, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_69, 0.5f, 0.0078125f), mad(fragment_unnamed_67, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_63);
					float fragment_unnamed_134;
					float fragment_unnamed_138;
					float fragment_unnamed_140;
					fragment_unnamed_134 = fragment_input_2.z;
					fragment_unnamed_138 = asfloat(1065353216u);
					fragment_unnamed_140 = asfloat(0u);
					float4 fragment_unnamed_230;
					float2 fragment_unnamed_231;
					for (float fragment_unnamed_136 = fragment_input_2.w; !((((fragment_unnamed_140 == 0.0f) ? 4294967295u : 0u) & (((0.828100025653839111328125f < fragment_unnamed_138) ? 4294967295u : 0u) & ((fragment_unnamed_134 < fragment_input_4.y) ? 4294967295u : 0u))) == 0u); fragment_unnamed_231 = float2(fragment_unnamed_134, fragment_unnamed_136), fragment_unnamed_230 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_231, 0.0f), fragment_unnamed_134 = mad(fragment_uniform_buffer_0[28u].x, 2.0f, fragment_unnamed_134), fragment_unnamed_136 = mad(fragment_uniform_buffer_0[28u].y, 0.0f, fragment_unnamed_136), fragment_unnamed_138 = fragment_unnamed_230.y, fragment_unnamed_140 = fragment_unnamed_230.x)
					{
					}
					precise float fragment_unnamed_183 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
					float fragment_unnamed_184 = mad(fragment_unnamed_183, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_140, 0.5f, 0.5234375f), mad(fragment_unnamed_138, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_134);
					precise float fragment_unnamed_190 = (-0.0f) - fragment_input_1.x;
					precise float fragment_unnamed_208 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_103, fragment_input_3.y), 0.0f).x * 4.0f;
					precise float fragment_unnamed_210 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_184, fragment_input_3.y), 0.0f, int2(1, 0)).x * 4.0f;
					float4 fragment_unnamed_223 = _AreaTex.SampleLevel(sampler_MainTex, float2(mad(mad(round(fragment_unnamed_208), 16.0f, sqrt(abs(round(mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_103, fragment_unnamed_190))))), 0.0062500000931322574615478515625f, 0.00312500004656612873077392578125f), mad(mad(round(fragment_unnamed_210), 16.0f, sqrt(abs(round(mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_184, fragment_unnamed_190))))), 0.001785714295692741870880126953125f, 0.0008928571478463709354400634765625f)), 0.0f);
					fragment_output_0.x = fragment_unnamed_223.x;
					fragment_output_0.y = fragment_unnamed_223.y;
				}
				else
				{
					fragment_output_0.x = 0.0f;
					fragment_output_0.y = 0.0f;
				}
				if (0.0f < fragment_unnamed_46.x)
				{
					float fragment_unnamed_153;
					float fragment_unnamed_155;
					float fragment_unnamed_157;
					fragment_unnamed_153 = fragment_input_3.y;
					fragment_unnamed_155 = asfloat(1065353216u);
					fragment_unnamed_157 = asfloat(0u);
					float4 fragment_unnamed_261;
					float2 fragment_unnamed_262;
					for (float fragment_unnamed_159 = fragment_input_3.x; !(((((fragment_input_4.z < fragment_unnamed_153) ? 4294967295u : 0u) & ((0.828100025653839111328125f < fragment_unnamed_155) ? 4294967295u : 0u)) & ((fragment_unnamed_157 == 0.0f) ? 4294967295u : 0u)) == 0u); fragment_unnamed_262 = float2(fragment_unnamed_159, fragment_unnamed_153), fragment_unnamed_261 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_262, 0.0f), fragment_unnamed_153 = mad(fragment_uniform_buffer_0[28u].y, -2.0f, fragment_unnamed_153), fragment_unnamed_155 = fragment_unnamed_261.x, fragment_unnamed_157 = fragment_unnamed_261.y, fragment_unnamed_159 = mad(fragment_uniform_buffer_0[28u].x, -0.0f, fragment_unnamed_159))
					{
					}
					float fragment_unnamed_247 = mad(fragment_uniform_buffer_0[28u].y, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_157, 0.5f, 0.0078125f), mad(fragment_unnamed_155, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_153);
					float fragment_unnamed_269;
					float fragment_unnamed_271;
					float fragment_unnamed_273;
					fragment_unnamed_269 = fragment_input_3.w;
					fragment_unnamed_271 = asfloat(1065353216u);
					fragment_unnamed_273 = asfloat(0u);
					float4 fragment_unnamed_333;
					float2 fragment_unnamed_334;
					for (float fragment_unnamed_267 = fragment_input_3.z; !(((((fragment_unnamed_269 < fragment_input_4.w) ? 4294967295u : 0u) & ((0.828100025653839111328125f < fragment_unnamed_271) ? 4294967295u : 0u)) & ((fragment_unnamed_273 == 0.0f) ? 4294967295u : 0u)) == 0u); fragment_unnamed_334 = float2(fragment_unnamed_267, fragment_unnamed_269), fragment_unnamed_333 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_334, 0.0f), fragment_unnamed_267 = mad(fragment_uniform_buffer_0[28u].x, 0.0f, fragment_unnamed_267), fragment_unnamed_269 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_269), fragment_unnamed_271 = fragment_unnamed_333.x, fragment_unnamed_273 = fragment_unnamed_333.y)
					{
					}
					precise float fragment_unnamed_296 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
					float fragment_unnamed_297 = mad(fragment_unnamed_296, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_273, 0.5f, 0.5234375f), mad(fragment_unnamed_271, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_269);
					precise float fragment_unnamed_303 = (-0.0f) - fragment_input_1.y;
					precise float fragment_unnamed_317 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_2.x, fragment_unnamed_247), 0.0f).y * 4.0f;
					precise float fragment_unnamed_318 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_2.x, fragment_unnamed_297), 0.0f, int2(0, 1)).y * 4.0f;
					float4 fragment_unnamed_326 = _AreaTex.SampleLevel(sampler_MainTex, float2(mad(mad(round(fragment_unnamed_317), 16.0f, sqrt(abs(round(mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_247, fragment_unnamed_303))))), 0.0062500000931322574615478515625f, 0.00312500004656612873077392578125f), mad(mad(round(fragment_unnamed_318), 16.0f, sqrt(abs(round(mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_297, fragment_unnamed_303))))), 0.001785714295692741870880126953125f, 0.0008928571478463709354400634765625f)), 0.0f);
					fragment_output_0.z = fragment_unnamed_326.x;
					fragment_output_0.w = fragment_unnamed_326.y;
				}
				else
				{
					fragment_output_0.z = 0.0f;
					fragment_output_0.w = 0.0f;
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
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
			GpuProgramID 266226

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float4 _MainTex_TexelSize;

			static float4 vertex_uniform_buffer_0[29];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_2 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_3 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_4 : TEXCOORD4; // TEXCOORD_4
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
				precise float vertex_unnamed_56 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_57 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_58 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_59 = vertex_input_0.y + 1.0f;
				float vertex_unnamed_62 = mad(vertex_unnamed_58, 0.5f, 0.0f);
				float vertex_unnamed_63 = mad(vertex_unnamed_59, -0.5f, 1.0f);
				precise float vertex_unnamed_70 = vertex_unnamed_62 * vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_71 = vertex_unnamed_63 * vertex_uniform_buffer_0[28u].w;
				vertex_output_1.x = vertex_unnamed_70;
				vertex_output_1.y = vertex_unnamed_71;
				float vertex_unnamed_78 = mad(vertex_uniform_buffer_0[28u].x, -0.25f, vertex_unnamed_62);
				float vertex_unnamed_80 = mad(vertex_uniform_buffer_0[28u].x, 1.25f, vertex_unnamed_62);
				float vertex_unnamed_90 = mad(vertex_uniform_buffer_0[28u].y, -0.25f, mad(vertex_unnamed_57, -0.5f, 1.0f));
				float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[28u].y, 1.25f, vertex_unnamed_63);
				vertex_output_2.x = vertex_unnamed_78;
				vertex_output_2.y = mad(vertex_uniform_buffer_0[28u].y, -0.125f, vertex_unnamed_63);
				vertex_output_2.z = vertex_unnamed_80;
				vertex_output_2.w = mad(vertex_uniform_buffer_0[28u].y, -0.125f, vertex_unnamed_63);
				vertex_output_3.x = mad(vertex_uniform_buffer_0[28u].x, -0.125f, mad(vertex_unnamed_56, 0.5f, 0.0f));
				vertex_output_3.y = vertex_unnamed_90;
				vertex_output_3.z = mad(vertex_uniform_buffer_0[28u].x, -0.125f, vertex_unnamed_62);
				vertex_output_3.w = vertex_unnamed_92;
				vertex_output_4.x = mad(vertex_uniform_buffer_0[28u].x, -16.0f, vertex_unnamed_78);
				vertex_output_4.y = mad(vertex_uniform_buffer_0[28u].x, 16.0f, vertex_unnamed_80);
				vertex_output_4.z = mad(vertex_uniform_buffer_0[28u].y, -16.0f, vertex_unnamed_90);
				vertex_output_4.w = mad(vertex_uniform_buffer_0[28u].y, 16.0f, vertex_unnamed_92);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}


			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[29];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _AreaTex;
			Texture2D<float4> _SearchTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_2 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_3 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_4 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_46 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				if (0.0f < fragment_unnamed_46.y)
				{
					float fragment_unnamed_63;
					float fragment_unnamed_67;
					float fragment_unnamed_69;
					fragment_unnamed_63 = fragment_input_2.x;
					fragment_unnamed_67 = asfloat(1065353216u);
					fragment_unnamed_69 = asfloat(0u);
					float4 fragment_unnamed_119;
					float2 fragment_unnamed_120;
					for (float fragment_unnamed_65 = fragment_input_2.y; !((((fragment_unnamed_69 == 0.0f) ? 4294967295u : 0u) & (((0.828100025653839111328125f < fragment_unnamed_67) ? 4294967295u : 0u) & ((fragment_input_4.x < fragment_unnamed_63) ? 4294967295u : 0u))) == 0u); fragment_unnamed_120 = float2(fragment_unnamed_63, fragment_unnamed_65), fragment_unnamed_119 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_120, 0.0f), fragment_unnamed_63 = mad(fragment_uniform_buffer_0[28u].x, -2.0f, fragment_unnamed_63), fragment_unnamed_65 = mad(fragment_uniform_buffer_0[28u].y, -0.0f, fragment_unnamed_65), fragment_unnamed_67 = fragment_unnamed_119.y, fragment_unnamed_69 = fragment_unnamed_119.x)
					{
					}
					float fragment_unnamed_103 = mad(fragment_uniform_buffer_0[28u].x, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_69, 0.5f, 0.0078125f), mad(fragment_unnamed_67, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_63);
					float fragment_unnamed_134;
					float fragment_unnamed_138;
					float fragment_unnamed_140;
					fragment_unnamed_134 = fragment_input_2.z;
					fragment_unnamed_138 = asfloat(1065353216u);
					fragment_unnamed_140 = asfloat(0u);
					float4 fragment_unnamed_230;
					float2 fragment_unnamed_231;
					for (float fragment_unnamed_136 = fragment_input_2.w; !((((fragment_unnamed_140 == 0.0f) ? 4294967295u : 0u) & (((0.828100025653839111328125f < fragment_unnamed_138) ? 4294967295u : 0u) & ((fragment_unnamed_134 < fragment_input_4.y) ? 4294967295u : 0u))) == 0u); fragment_unnamed_231 = float2(fragment_unnamed_134, fragment_unnamed_136), fragment_unnamed_230 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_231, 0.0f), fragment_unnamed_134 = mad(fragment_uniform_buffer_0[28u].x, 2.0f, fragment_unnamed_134), fragment_unnamed_136 = mad(fragment_uniform_buffer_0[28u].y, 0.0f, fragment_unnamed_136), fragment_unnamed_138 = fragment_unnamed_230.y, fragment_unnamed_140 = fragment_unnamed_230.x)
					{
					}
					precise float fragment_unnamed_183 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
					float fragment_unnamed_184 = mad(fragment_unnamed_183, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_140, 0.5f, 0.5234375f), mad(fragment_unnamed_138, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_134);
					precise float fragment_unnamed_190 = (-0.0f) - fragment_input_1.x;
					precise float fragment_unnamed_208 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_103, fragment_input_3.y), 0.0f).x * 4.0f;
					precise float fragment_unnamed_210 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_184, fragment_input_3.y), 0.0f, int2(1, 0)).x * 4.0f;
					float4 fragment_unnamed_223 = _AreaTex.SampleLevel(sampler_MainTex, float2(mad(mad(round(fragment_unnamed_208), 16.0f, sqrt(abs(round(mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_103, fragment_unnamed_190))))), 0.0062500000931322574615478515625f, 0.00312500004656612873077392578125f), mad(mad(round(fragment_unnamed_210), 16.0f, sqrt(abs(round(mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_184, fragment_unnamed_190))))), 0.001785714295692741870880126953125f, 0.0008928571478463709354400634765625f)), 0.0f);
					fragment_output_0.x = fragment_unnamed_223.x;
					fragment_output_0.y = fragment_unnamed_223.y;
				}
				else
				{
					fragment_output_0.x = 0.0f;
					fragment_output_0.y = 0.0f;
				}
				if (0.0f < fragment_unnamed_46.x)
				{
					float fragment_unnamed_153;
					float fragment_unnamed_155;
					float fragment_unnamed_157;
					fragment_unnamed_153 = fragment_input_3.y;
					fragment_unnamed_155 = asfloat(1065353216u);
					fragment_unnamed_157 = asfloat(0u);
					float4 fragment_unnamed_261;
					float2 fragment_unnamed_262;
					for (float fragment_unnamed_159 = fragment_input_3.x; !(((((fragment_input_4.z < fragment_unnamed_153) ? 4294967295u : 0u) & ((0.828100025653839111328125f < fragment_unnamed_155) ? 4294967295u : 0u)) & ((fragment_unnamed_157 == 0.0f) ? 4294967295u : 0u)) == 0u); fragment_unnamed_262 = float2(fragment_unnamed_159, fragment_unnamed_153), fragment_unnamed_261 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_262, 0.0f), fragment_unnamed_153 = mad(fragment_uniform_buffer_0[28u].y, -2.0f, fragment_unnamed_153), fragment_unnamed_155 = fragment_unnamed_261.x, fragment_unnamed_157 = fragment_unnamed_261.y, fragment_unnamed_159 = mad(fragment_uniform_buffer_0[28u].x, -0.0f, fragment_unnamed_159))
					{
					}
					float fragment_unnamed_247 = mad(fragment_uniform_buffer_0[28u].y, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_157, 0.5f, 0.0078125f), mad(fragment_unnamed_155, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_153);
					float fragment_unnamed_269;
					float fragment_unnamed_271;
					float fragment_unnamed_273;
					fragment_unnamed_269 = fragment_input_3.w;
					fragment_unnamed_271 = asfloat(1065353216u);
					fragment_unnamed_273 = asfloat(0u);
					float4 fragment_unnamed_333;
					float2 fragment_unnamed_334;
					for (float fragment_unnamed_267 = fragment_input_3.z; !(((((fragment_unnamed_269 < fragment_input_4.w) ? 4294967295u : 0u) & ((0.828100025653839111328125f < fragment_unnamed_271) ? 4294967295u : 0u)) & ((fragment_unnamed_273 == 0.0f) ? 4294967295u : 0u)) == 0u); fragment_unnamed_334 = float2(fragment_unnamed_267, fragment_unnamed_269), fragment_unnamed_333 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_334, 0.0f), fragment_unnamed_267 = mad(fragment_uniform_buffer_0[28u].x, 0.0f, fragment_unnamed_267), fragment_unnamed_269 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_269), fragment_unnamed_271 = fragment_unnamed_333.x, fragment_unnamed_273 = fragment_unnamed_333.y)
					{
					}
					precise float fragment_unnamed_296 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
					float fragment_unnamed_297 = mad(fragment_unnamed_296, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_273, 0.5f, 0.5234375f), mad(fragment_unnamed_271, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_269);
					precise float fragment_unnamed_303 = (-0.0f) - fragment_input_1.y;
					precise float fragment_unnamed_317 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_2.x, fragment_unnamed_247), 0.0f).y * 4.0f;
					precise float fragment_unnamed_318 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_2.x, fragment_unnamed_297), 0.0f, int2(0, 1)).y * 4.0f;
					float4 fragment_unnamed_326 = _AreaTex.SampleLevel(sampler_MainTex, float2(mad(mad(round(fragment_unnamed_317), 16.0f, sqrt(abs(round(mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_247, fragment_unnamed_303))))), 0.0062500000931322574615478515625f, 0.00312500004656612873077392578125f), mad(mad(round(fragment_unnamed_318), 16.0f, sqrt(abs(round(mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_297, fragment_unnamed_303))))), 0.001785714295692741870880126953125f, 0.0008928571478463709354400634765625f)), 0.0f);
					fragment_output_0.z = fragment_unnamed_326.x;
					fragment_output_0.w = fragment_unnamed_326.y;
				}
				else
				{
					fragment_output_0.z = 0.0f;
					fragment_output_0.w = 0.0f;
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
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
			GpuProgramID 328378

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float4 _MainTex_TexelSize;

			static float4 vertex_uniform_buffer_0[29];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float2 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float2 vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_2 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_output_3 : TEXCOORD3; // TEXCOORD_3
				float4 vertex_output_4 : TEXCOORD4; // TEXCOORD_4
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
				precise float vertex_unnamed_56 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_57 = vertex_input_0.y + 1.0f;
				precise float vertex_unnamed_58 = vertex_input_0.x + 1.0f;
				precise float vertex_unnamed_59 = vertex_input_0.y + 1.0f;
				float vertex_unnamed_62 = mad(vertex_unnamed_58, 0.5f, 0.0f);
				float vertex_unnamed_63 = mad(vertex_unnamed_59, -0.5f, 1.0f);
				precise float vertex_unnamed_70 = vertex_unnamed_62 * vertex_uniform_buffer_0[28u].z;
				precise float vertex_unnamed_71 = vertex_unnamed_63 * vertex_uniform_buffer_0[28u].w;
				vertex_output_1.x = vertex_unnamed_70;
				vertex_output_1.y = vertex_unnamed_71;
				float vertex_unnamed_78 = mad(vertex_uniform_buffer_0[28u].x, -0.25f, vertex_unnamed_62);
				float vertex_unnamed_80 = mad(vertex_uniform_buffer_0[28u].x, 1.25f, vertex_unnamed_62);
				float vertex_unnamed_90 = mad(vertex_uniform_buffer_0[28u].y, -0.25f, mad(vertex_unnamed_57, -0.5f, 1.0f));
				float vertex_unnamed_92 = mad(vertex_uniform_buffer_0[28u].y, 1.25f, vertex_unnamed_63);
				vertex_output_2.x = vertex_unnamed_78;
				vertex_output_2.y = mad(vertex_uniform_buffer_0[28u].y, -0.125f, vertex_unnamed_63);
				vertex_output_2.z = vertex_unnamed_80;
				vertex_output_2.w = mad(vertex_uniform_buffer_0[28u].y, -0.125f, vertex_unnamed_63);
				vertex_output_3.x = mad(vertex_uniform_buffer_0[28u].x, -0.125f, mad(vertex_unnamed_56, 0.5f, 0.0f));
				vertex_output_3.y = vertex_unnamed_90;
				vertex_output_3.z = mad(vertex_uniform_buffer_0[28u].x, -0.125f, vertex_unnamed_62);
				vertex_output_3.w = vertex_unnamed_92;
				vertex_output_4.x = mad(vertex_uniform_buffer_0[28u].x, -32.0f, vertex_unnamed_78);
				vertex_output_4.y = mad(vertex_uniform_buffer_0[28u].x, 32.0f, vertex_unnamed_80);
				vertex_output_4.z = mad(vertex_uniform_buffer_0[28u].y, -32.0f, vertex_unnamed_90);
				vertex_output_4.w = mad(vertex_uniform_buffer_0[28u].y, 32.0f, vertex_unnamed_92);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}


			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[29];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _AreaTex;
			Texture2D<float4> _SearchTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float2 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float2 fragment_input_1 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_2 : TEXCOORD2; // TEXCOORD_2
				float4 fragment_input_3 : TEXCOORD3; // TEXCOORD_3
				float4 fragment_input_4 : TEXCOORD4; // TEXCOORD_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_46 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_48 = fragment_unnamed_46.x;
				float fragment_unnamed_78;
				if (0.0f < fragment_unnamed_46.y)
				{
					float fragment_unnamed_100;
					float fragment_unnamed_102;
					if (0.0f < fragment_unnamed_48)
					{
						precise float fragment_unnamed_62 = fragment_uniform_buffer_0[28u].x * (-1.0f);
						precise float fragment_unnamed_64 = fragment_uniform_buffer_0[28u].y * 1.0f;
						float fragment_unnamed_66 = asfloat(1065353216u);
						float fragment_unnamed_85;
						float fragment_unnamed_87;
						float fragment_unnamed_89;
						fragment_unnamed_85 = asfloat(0u);
						fragment_unnamed_87 = asfloat(3212836864u);
						fragment_unnamed_89 = asfloat(1065353216u);
						precise float fragment_unnamed_82;
						precise float fragment_unnamed_84;
						precise float fragment_unnamed_88;
						float4 fragment_unnamed_131;
						for (float fragment_unnamed_81 = fragment_input_1.x, fragment_unnamed_83 = fragment_input_1.y; !((((0.89999997615814208984375f < fragment_unnamed_89) ? 4294967295u : 0u) & ((fragment_unnamed_87 < 7.0f) ? 4294967295u : 0u)) == 0u); fragment_unnamed_82 = fragment_unnamed_62 + fragment_unnamed_81, fragment_unnamed_84 = fragment_unnamed_64 + fragment_unnamed_83, fragment_unnamed_88 = fragment_unnamed_66 + fragment_unnamed_87, fragment_unnamed_131 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_82, fragment_unnamed_84), 0.0f), fragment_unnamed_81 = fragment_unnamed_82, fragment_unnamed_83 = fragment_unnamed_84, fragment_unnamed_85 = fragment_unnamed_131.y, fragment_unnamed_87 = fragment_unnamed_88, fragment_unnamed_89 = dot(float2(fragment_unnamed_131.xy), 0.5f.xx))
						{
						}
						precise float fragment_unnamed_101 = asfloat(((0.89999997615814208984375f < fragment_unnamed_85) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_87;
						fragment_unnamed_100 = fragment_unnamed_101;
						fragment_unnamed_102 = fragment_unnamed_89;
					}
					else
					{
						fragment_unnamed_100 = asfloat(0u);
						fragment_unnamed_102 = asfloat(0u);
					}
					precise float fragment_unnamed_107 = fragment_uniform_buffer_0[28u].x * 1.0f;
					precise float fragment_unnamed_108 = fragment_uniform_buffer_0[28u].y * (-1.0f);
					float fragment_unnamed_109 = asfloat(1065353216u);
					float fragment_unnamed_137;
					float fragment_unnamed_143;
					fragment_unnamed_137 = asfloat(3212836864u);
					fragment_unnamed_143 = asfloat(1065353216u);
					precise float fragment_unnamed_138;
					precise float fragment_unnamed_140;
					precise float fragment_unnamed_142;
					for (float fragment_unnamed_139 = fragment_input_1.x, fragment_unnamed_141 = fragment_input_1.y; !((((0.89999997615814208984375f < fragment_unnamed_143) ? 4294967295u : 0u) & ((fragment_unnamed_137 < 7.0f) ? 4294967295u : 0u)) == 0u); fragment_unnamed_138 = fragment_unnamed_109 + fragment_unnamed_137, fragment_unnamed_140 = fragment_unnamed_107 + fragment_unnamed_139, fragment_unnamed_142 = fragment_unnamed_108 + fragment_unnamed_141, fragment_unnamed_137 = fragment_unnamed_138, fragment_unnamed_139 = fragment_unnamed_140, fragment_unnamed_141 = fragment_unnamed_142, fragment_unnamed_143 = dot(float2(_MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_140, fragment_unnamed_142), 0.0f).xy), 0.5f.xx))
					{
					}
					precise float fragment_unnamed_171 = fragment_unnamed_100 + fragment_unnamed_137;
					float fragment_unnamed_309;
					float fragment_unnamed_310;
					if (2.0f < fragment_unnamed_171)
					{
						precise float fragment_unnamed_218 = (-0.0f) - fragment_unnamed_100;
						precise float fragment_unnamed_219 = fragment_unnamed_218 + 0.25f;
						float fragment_unnamed_221 = mad(fragment_unnamed_137, 1.0f, 0.0f);
						float4 fragment_unnamed_240 = _MainTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_219, fragment_uniform_buffer_0[28u].x, fragment_input_1.x), mad(fragment_unnamed_100, fragment_uniform_buffer_0[28u].y, fragment_input_1.y)), 0.0f, int2(-1, 0));
						float fragment_unnamed_244 = fragment_unnamed_240.x;
						float4 fragment_unnamed_247 = _MainTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_221, fragment_uniform_buffer_0[28u].x, fragment_input_1.x), mad(mad(fragment_unnamed_137, -1.0f, -0.25f), fragment_uniform_buffer_0[28u].y, fragment_input_1.y)), 0.0f, int2(1, 0));
						float fragment_unnamed_250 = fragment_unnamed_247.x;
						precise float fragment_unnamed_258 = abs(mad(fragment_unnamed_244, 5.0f, -3.75f)) * fragment_unnamed_244;
						precise float fragment_unnamed_259 = abs(mad(fragment_unnamed_250, 5.0f, -3.75f)) * fragment_unnamed_250;
						float4 fragment_unnamed_284 = _AreaTex.SampleLevel(sampler_MainTex, float2(mad(mad(asfloat((fragment_unnamed_102 >= 0.89999997615814208984375f) ? 0u : asuint(mad(round(fragment_unnamed_240.y), 2.0f, round(fragment_unnamed_258)))), 20.0f, fragment_unnamed_100), 0.0062500000931322574615478515625f, 0.503125011920928955078125f), mad(mad(asfloat((fragment_unnamed_143 >= 0.89999997615814208984375f) ? 0u : asuint(mad(round(fragment_unnamed_247.y), 2.0f, round(fragment_unnamed_259)))), 20.0f, fragment_unnamed_221), 0.001785714295692741870880126953125f, 0.0008928571478463709354400634765625f)), 0.0f);
						fragment_unnamed_309 = fragment_unnamed_284.x;
						fragment_unnamed_310 = fragment_unnamed_284.y;
					}
					else
					{
						fragment_unnamed_309 = asfloat(0u);
						fragment_unnamed_310 = asfloat(0u);
					}
					float fragment_unnamed_316 = mad(fragment_uniform_buffer_0[28u].x, 0.25f, fragment_input_1.x);
					precise float fragment_unnamed_320 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
					precise float fragment_unnamed_322 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
					float fragment_unnamed_323 = asfloat(1065353216u);
					float fragment_unnamed_445;
					float fragment_unnamed_451;
					fragment_unnamed_445 = asfloat(1065353216u);
					fragment_unnamed_451 = asfloat(3212836864u);
					precise float fragment_unnamed_448;
					precise float fragment_unnamed_450;
					precise float fragment_unnamed_452;
					float4 fragment_unnamed_469;
					float fragment_unnamed_471;
					precise float fragment_unnamed_475;
					for (float fragment_unnamed_447 = fragment_unnamed_316, fragment_unnamed_449 = fragment_input_1.y; !((((0.89999997615814208984375f < fragment_unnamed_445) ? 4294967295u : 0u) & ((fragment_unnamed_451 < 7.0f) ? 4294967295u : 0u)) == 0u); fragment_unnamed_448 = fragment_unnamed_320 + fragment_unnamed_447, fragment_unnamed_450 = fragment_unnamed_322 + fragment_unnamed_449, fragment_unnamed_452 = fragment_unnamed_323 + fragment_unnamed_451, fragment_unnamed_469 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_448, fragment_unnamed_450), 0.0f), fragment_unnamed_471 = fragment_unnamed_469.x, fragment_unnamed_475 = abs(mad(fragment_unnamed_471, 5.0f, -3.75f)) * fragment_unnamed_471, fragment_unnamed_445 = dot(float2(round(fragment_unnamed_475), round(fragment_unnamed_469.y)), 0.5f.xx), fragment_unnamed_447 = fragment_unnamed_448, fragment_unnamed_449 = fragment_unnamed_450, fragment_unnamed_451 = fragment_unnamed_452)
					{
					}
					float fragment_unnamed_512;
					float fragment_unnamed_514;
					if (0.0f < _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y), 0.0f, int2(1, 0)).x)
					{
						uint4 fragment_unnamed_483 = asuint(fragment_uniform_buffer_0[28u]);
						float fragment_unnamed_485 = asfloat(fragment_unnamed_483.x);
						float fragment_unnamed_487 = asfloat(fragment_unnamed_483.y);
						float fragment_unnamed_488 = asfloat(1065353216u);
						float fragment_unnamed_496;
						float fragment_unnamed_498;
						float fragment_unnamed_504;
						fragment_unnamed_496 = asfloat(0u);
						fragment_unnamed_498 = asfloat(1065353216u);
						fragment_unnamed_504 = asfloat(3212836864u);
						float fragment_unnamed_497;
						precise float fragment_unnamed_501;
						precise float fragment_unnamed_503;
						precise float fragment_unnamed_505;
						float4 fragment_unnamed_522;
						float fragment_unnamed_524;
						precise float fragment_unnamed_528;
						for (float fragment_unnamed_500 = fragment_unnamed_316, fragment_unnamed_502 = fragment_input_1.y; !((((0.89999997615814208984375f < fragment_unnamed_498) ? 4294967295u : 0u) & ((fragment_unnamed_504 < 7.0f) ? 4294967295u : 0u)) == 0u); fragment_unnamed_501 = fragment_unnamed_485 + fragment_unnamed_500, fragment_unnamed_503 = fragment_unnamed_487 + fragment_unnamed_502, fragment_unnamed_505 = fragment_unnamed_488 + fragment_unnamed_504, fragment_unnamed_522 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_501, fragment_unnamed_503), 0.0f), fragment_unnamed_524 = fragment_unnamed_522.x, fragment_unnamed_528 = abs(mad(fragment_unnamed_524, 5.0f, -3.75f)) * fragment_unnamed_524, fragment_unnamed_497 = round(fragment_unnamed_522.y), fragment_unnamed_496 = fragment_unnamed_497, fragment_unnamed_498 = dot(float2(round(fragment_unnamed_528), fragment_unnamed_497), 0.5f.xx), fragment_unnamed_500 = fragment_unnamed_501, fragment_unnamed_502 = fragment_unnamed_503, fragment_unnamed_504 = fragment_unnamed_505)
						{
						}
						precise float fragment_unnamed_513 = asfloat(((0.89999997615814208984375f < fragment_unnamed_496) ? 4294967295u : 0u) & 1065353216u) + fragment_unnamed_504;
						fragment_unnamed_512 = fragment_unnamed_513;
						fragment_unnamed_514 = fragment_unnamed_498;
					}
					else
					{
						fragment_unnamed_512 = asfloat(0u);
						fragment_unnamed_514 = asfloat(0u);
					}
					precise float fragment_unnamed_515 = fragment_unnamed_512 + fragment_unnamed_451;
					float fragment_unnamed_578;
					float fragment_unnamed_579;
					if (2.0f < fragment_unnamed_515)
					{
						precise float fragment_unnamed_532 = (-0.0f) - fragment_unnamed_451;
						float fragment_unnamed_541 = mad(fragment_unnamed_532, fragment_uniform_buffer_0[28u].x, fragment_input_1.x);
						float fragment_unnamed_542 = mad(fragment_unnamed_532, fragment_uniform_buffer_0[28u].y, fragment_input_1.y);
						float4 fragment_unnamed_553 = _MainTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_512, fragment_uniform_buffer_0[28u].x, fragment_input_1.x), mad(fragment_unnamed_512, fragment_uniform_buffer_0[28u].y, fragment_input_1.y)), 0.0f, int2(1, 0));
						float4 fragment_unnamed_572 = _AreaTex.SampleLevel(sampler_MainTex, float2(mad(mad(asfloat((fragment_unnamed_445 >= 0.89999997615814208984375f) ? 0u : asuint(mad(_MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_541, fragment_unnamed_542), 0.0f, int2(-1, 0)).y, 2.0f, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_541, fragment_unnamed_542), 0.0f, int2(0, -1)).x))), 20.0f, fragment_unnamed_451), 0.0062500000931322574615478515625f, 0.503125011920928955078125f), mad(mad(asfloat((fragment_unnamed_514 >= 0.89999997615814208984375f) ? 0u : asuint(mad(fragment_unnamed_553.y, 2.0f, fragment_unnamed_553.x))), 20.0f, fragment_unnamed_512), 0.001785714295692741870880126953125f, 0.0008928571478463709354400634765625f)), 0.0f);
						precise float fragment_unnamed_576 = fragment_unnamed_309 + fragment_unnamed_572.y;
						precise float fragment_unnamed_577 = fragment_unnamed_310 + fragment_unnamed_572.x;
						fragment_unnamed_578 = fragment_unnamed_576;
						fragment_unnamed_579 = fragment_unnamed_577;
					}
					else
					{
						fragment_unnamed_578 = fragment_unnamed_309;
						fragment_unnamed_579 = fragment_unnamed_310;
					}
					precise float fragment_unnamed_580 = (-0.0f) - fragment_unnamed_579;
					float fragment_unnamed_79;
					if (fragment_unnamed_580 == fragment_unnamed_578)
					{
						float fragment_unnamed_591;
						float fragment_unnamed_595;
						float fragment_unnamed_597;
						fragment_unnamed_591 = fragment_input_2.x;
						fragment_unnamed_595 = asfloat(0u);
						fragment_unnamed_597 = asfloat(1065353216u);
						float4 fragment_unnamed_634;
						float2 fragment_unnamed_635;
						for (float fragment_unnamed_593 = fragment_input_2.y; !((((fragment_unnamed_595 == 0.0f) ? 4294967295u : 0u) & (((0.828100025653839111328125f < fragment_unnamed_597) ? 4294967295u : 0u) & ((fragment_input_4.x < fragment_unnamed_591) ? 4294967295u : 0u))) == 0u); fragment_unnamed_635 = float2(fragment_unnamed_591, fragment_unnamed_593), fragment_unnamed_634 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_635, 0.0f), fragment_unnamed_591 = mad(fragment_uniform_buffer_0[28u].x, -2.0f, fragment_unnamed_591), fragment_unnamed_593 = mad(fragment_uniform_buffer_0[28u].y, -0.0f, fragment_unnamed_593), fragment_unnamed_595 = fragment_unnamed_634.x, fragment_unnamed_597 = fragment_unnamed_634.y)
						{
						}
						float fragment_unnamed_620 = mad(fragment_uniform_buffer_0[28u].x, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_595, 0.5f, 0.0078125f), mad(fragment_unnamed_597, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_591);
						float fragment_unnamed_640;
						float fragment_unnamed_644;
						float fragment_unnamed_646;
						fragment_unnamed_640 = fragment_input_2.z;
						fragment_unnamed_644 = asfloat(1065353216u);
						fragment_unnamed_646 = asfloat(0u);
						float4 fragment_unnamed_762;
						float2 fragment_unnamed_763;
						for (float fragment_unnamed_642 = fragment_input_2.w; !((((fragment_unnamed_646 == 0.0f) ? 4294967295u : 0u) & (((0.828100025653839111328125f < fragment_unnamed_644) ? 4294967295u : 0u) & ((fragment_unnamed_640 < fragment_input_4.y) ? 4294967295u : 0u))) == 0u); fragment_unnamed_763 = float2(fragment_unnamed_640, fragment_unnamed_642), fragment_unnamed_762 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_763, 0.0f), fragment_unnamed_640 = mad(fragment_uniform_buffer_0[28u].x, 2.0f, fragment_unnamed_640), fragment_unnamed_642 = mad(fragment_uniform_buffer_0[28u].y, 0.0f, fragment_unnamed_642), fragment_unnamed_644 = fragment_unnamed_762.y, fragment_unnamed_646 = fragment_unnamed_762.x)
						{
						}
						precise float fragment_unnamed_669 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
						float fragment_unnamed_670 = mad(fragment_unnamed_669, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_646, 0.5f, 0.5234375f), mad(fragment_unnamed_644, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_640);
						precise float fragment_unnamed_676 = (-0.0f) - fragment_input_1.x;
						float fragment_unnamed_683 = round(mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_670, fragment_unnamed_676));
						float fragment_unnamed_684 = round(mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_620, fragment_unnamed_676));
						precise float fragment_unnamed_693 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_620, fragment_input_3.y), 0.0f).x * 4.0f;
						precise float fragment_unnamed_694 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_670, fragment_input_3.y), 0.0f, int2(1, 0)).x * 4.0f;
						float4 fragment_unnamed_702 = _AreaTex.SampleLevel(sampler_MainTex, float2(mad(mad(round(fragment_unnamed_693), 16.0f, sqrt(abs(fragment_unnamed_684))), 0.0062500000931322574615478515625f, 0.00312500004656612873077392578125f), mad(mad(round(fragment_unnamed_694), 16.0f, sqrt(abs(fragment_unnamed_683))), 0.001785714295692741870880126953125f, 0.0008928571478463709354400634765625f)), 0.0f);
						float fragment_unnamed_710 = abs(fragment_unnamed_684);
						float fragment_unnamed_711 = abs(fragment_unnamed_683);
						precise float fragment_unnamed_728 = asfloat(((abs(round(mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_620, fragment_unnamed_676))) >= fragment_unnamed_711) ? 4294967295u : 0u) & 1065353216u) + asfloat(((abs(round(mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_670, fragment_unnamed_676))) >= fragment_unnamed_710) ? 4294967295u : 0u) & 1065353216u);
						precise float fragment_unnamed_729 = asfloat(((abs(fragment_unnamed_683) >= fragment_unnamed_710) ? 4294967295u : 0u) & 1061158912u) / fragment_unnamed_728;
						precise float fragment_unnamed_730 = asfloat(((abs(fragment_unnamed_684) >= fragment_unnamed_711) ? 4294967295u : 0u) & 1061158912u) / fragment_unnamed_728;
						precise float fragment_unnamed_736 = (-0.0f) - fragment_unnamed_729;
						precise float fragment_unnamed_741 = (-0.0f) - fragment_unnamed_730;
						precise float fragment_unnamed_748 = (-0.0f) - fragment_unnamed_729;
						precise float fragment_unnamed_754 = (-0.0f) - fragment_unnamed_730;
						precise float fragment_unnamed_757 = fragment_unnamed_702.x * clamp(mad(fragment_unnamed_741, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_670, fragment_input_1.y), 0.0f, int2(1, 1)).x, mad(fragment_unnamed_736, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_620, fragment_input_1.y), 0.0f, int2(0, 1)).x, 1.0f)), 0.0f, 1.0f);
						precise float fragment_unnamed_758 = fragment_unnamed_702.y * clamp(mad(fragment_unnamed_754, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_670, fragment_input_1.y), 0.0f, int2(1, -2)).x, mad(fragment_unnamed_748, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_unnamed_620, fragment_input_1.y), 0.0f, int2(0, -2)).x, 1.0f)), 0.0f, 1.0f);
						fragment_output_0.x = fragment_unnamed_757;
						fragment_output_0.y = fragment_unnamed_758;
						fragment_unnamed_79 = fragment_unnamed_48;
					}
					else
					{
						fragment_output_0.x = fragment_unnamed_578;
						fragment_output_0.y = fragment_unnamed_579;
						fragment_unnamed_79 = asfloat(0u);
					}
					fragment_unnamed_78 = fragment_unnamed_79;
				}
				else
				{
					fragment_output_0.x = 0.0f;
					fragment_output_0.y = 0.0f;
					fragment_unnamed_78 = fragment_unnamed_48;
				}
				if (0.0f < fragment_unnamed_78)
				{
					float fragment_unnamed_153;
					float fragment_unnamed_155;
					float fragment_unnamed_157;
					fragment_unnamed_153 = fragment_input_3.y;
					fragment_unnamed_155 = asfloat(1065353216u);
					fragment_unnamed_157 = asfloat(0u);
					float4 fragment_unnamed_211;
					float2 fragment_unnamed_212;
					for (float fragment_unnamed_151 = fragment_input_3.x; !(((((fragment_input_4.z < fragment_unnamed_153) ? 4294967295u : 0u) & ((0.828100025653839111328125f < fragment_unnamed_155) ? 4294967295u : 0u)) & ((fragment_unnamed_157 == 0.0f) ? 4294967295u : 0u)) == 0u); fragment_unnamed_212 = float2(fragment_unnamed_151, fragment_unnamed_153), fragment_unnamed_211 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_212, 0.0f), fragment_unnamed_151 = mad(fragment_uniform_buffer_0[28u].x, -0.0f, fragment_unnamed_151), fragment_unnamed_153 = mad(fragment_uniform_buffer_0[28u].y, -2.0f, fragment_unnamed_153), fragment_unnamed_155 = fragment_unnamed_211.x, fragment_unnamed_157 = fragment_unnamed_211.y)
					{
					}
					float fragment_unnamed_197 = mad(fragment_uniform_buffer_0[28u].y, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_157, 0.5f, 0.0078125f), mad(fragment_unnamed_155, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_153);
					float fragment_unnamed_292;
					float fragment_unnamed_294;
					float fragment_unnamed_296;
					fragment_unnamed_292 = fragment_input_3.w;
					fragment_unnamed_294 = asfloat(0u);
					fragment_unnamed_296 = asfloat(1065353216u);
					float4 fragment_unnamed_439;
					float2 fragment_unnamed_440;
					for (float fragment_unnamed_290 = fragment_input_3.z; !((((fragment_unnamed_294 == 0.0f) ? 4294967295u : 0u) & (((0.828100025653839111328125f < fragment_unnamed_296) ? 4294967295u : 0u) & ((fragment_unnamed_292 < fragment_input_4.w) ? 4294967295u : 0u))) == 0u); fragment_unnamed_440 = float2(fragment_unnamed_290, fragment_unnamed_292), fragment_unnamed_439 = _MainTex.SampleLevel(sampler_MainTex, fragment_unnamed_440, 0.0f), fragment_unnamed_290 = mad(fragment_uniform_buffer_0[28u].x, 0.0f, fragment_unnamed_290), fragment_unnamed_292 = mad(fragment_uniform_buffer_0[28u].y, 2.0f, fragment_unnamed_292), fragment_unnamed_294 = fragment_unnamed_439.y, fragment_unnamed_296 = fragment_unnamed_439.x)
					{
					}
					precise float fragment_unnamed_339 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
					float fragment_unnamed_340 = mad(fragment_unnamed_339, mad(_SearchTex.SampleLevel(sampler_MainTex, float2(mad(fragment_unnamed_294, 0.5f, 0.5234375f), mad(fragment_unnamed_296, -2.0f, 2.03125f)), 0.0f).w, -2.007874011993408203125f, 3.25f), fragment_unnamed_292);
					precise float fragment_unnamed_346 = (-0.0f) - fragment_input_1.y;
					float fragment_unnamed_353 = round(mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_340, fragment_unnamed_346));
					float fragment_unnamed_354 = round(mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_197, fragment_unnamed_346));
					precise float fragment_unnamed_364 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_2.x, fragment_unnamed_197), 0.0f).y * 4.0f;
					precise float fragment_unnamed_366 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_2.x, fragment_unnamed_340), 0.0f, int2(0, 1)).y * 4.0f;
					float4 fragment_unnamed_376 = _AreaTex.SampleLevel(sampler_MainTex, float2(mad(mad(round(fragment_unnamed_364), 16.0f, sqrt(abs(fragment_unnamed_354))), 0.0062500000931322574615478515625f, 0.00312500004656612873077392578125f), mad(mad(round(fragment_unnamed_366), 16.0f, sqrt(abs(fragment_unnamed_353))), 0.001785714295692741870880126953125f, 0.0008928571478463709354400634765625f)), 0.0f);
					float fragment_unnamed_384 = abs(fragment_unnamed_354);
					float fragment_unnamed_385 = abs(fragment_unnamed_353);
					precise float fragment_unnamed_403 = asfloat(((abs(round(mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_197, fragment_unnamed_346))) >= fragment_unnamed_385) ? 4294967295u : 0u) & 1065353216u) + asfloat(((abs(round(mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_340, fragment_unnamed_346))) >= fragment_unnamed_384) ? 4294967295u : 0u) & 1065353216u);
					precise float fragment_unnamed_404 = asfloat(((abs(fragment_unnamed_353) >= fragment_unnamed_384) ? 4294967295u : 0u) & 1061158912u) / fragment_unnamed_403;
					precise float fragment_unnamed_405 = asfloat(((abs(fragment_unnamed_354) >= fragment_unnamed_385) ? 4294967295u : 0u) & 1061158912u) / fragment_unnamed_403;
					precise float fragment_unnamed_411 = (-0.0f) - fragment_unnamed_404;
					precise float fragment_unnamed_417 = (-0.0f) - fragment_unnamed_405;
					precise float fragment_unnamed_425 = (-0.0f) - fragment_unnamed_404;
					precise float fragment_unnamed_431 = (-0.0f) - fragment_unnamed_405;
					precise float fragment_unnamed_434 = fragment_unnamed_376.x * clamp(mad(fragment_unnamed_417, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_1.x, fragment_unnamed_340), 0.0f, int2(1, 1)).y, mad(fragment_unnamed_411, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_1.x, fragment_unnamed_197), 0.0f, int2(1, 0)).y, 1.0f)), 0.0f, 1.0f);
					precise float fragment_unnamed_435 = fragment_unnamed_376.y * clamp(mad(fragment_unnamed_431, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_1.x, fragment_unnamed_340), 0.0f, int2(-2, 1)).y, mad(fragment_unnamed_425, _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_1.x, fragment_unnamed_197), 0.0f, int2(-2, 0)).y, 1.0f)), 0.0f, 1.0f);
					fragment_output_0.z = fragment_unnamed_434;
					fragment_output_0.w = fragment_unnamed_435;
				}
				else
				{
					fragment_output_0.z = 0.0f;
					fragment_output_0.w = 0.0f;
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
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
			GpuProgramID 450130

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0


			float4 _MainTex_TexelSize;

			static float4 vertex_uniform_buffer_0[29];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float4 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float4 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
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
				float vertex_unnamed_45 = mad(vertex_unnamed_42, 0.5f, 0.0f);
				float vertex_unnamed_47 = mad(vertex_unnamed_43, -0.5f, 1.0f);
				vertex_output_1.x = vertex_unnamed_45;
				vertex_output_1.y = vertex_unnamed_47;
				vertex_output_2.x = mad(vertex_uniform_buffer_0[28u].x, 1.0f, vertex_unnamed_45);
				vertex_output_2.y = mad(vertex_uniform_buffer_0[28u].y, 0.0f, vertex_unnamed_47);
				vertex_output_2.z = mad(vertex_uniform_buffer_0[28u].x, 0.0f, vertex_unnamed_45);
				vertex_output_2.w = mad(vertex_uniform_buffer_0[28u].y, 1.0f, vertex_unnamed_47);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}


			float4 _MainTex_TexelSize;

			static float4 fragment_uniform_buffer_0[29];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _BlendTex;
			SamplerState sampler_MainTex;

			static float2 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float4 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_41 = _BlendTex.Sample(sampler_MainTex, float2(fragment_input_2.x, fragment_input_2.y));
				float fragment_unnamed_43 = fragment_unnamed_41.w;
				uint fragment_unnamed_44 = asuint(fragment_unnamed_43);
				float4 fragment_unnamed_51 = _BlendTex.Sample(sampler_MainTex, float2(fragment_input_2.z, fragment_input_2.w));
				float fragment_unnamed_53 = fragment_unnamed_51.y;
				float4 fragment_unnamed_58 = _BlendTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_60 = fragment_unnamed_58.z;
				float fragment_unnamed_61 = fragment_unnamed_58.x;
				if (dot(float4(fragment_unnamed_43, fragment_unnamed_53, fragment_unnamed_60, fragment_unnamed_61), 1.0f.xxxx) < 9.9999997473787516355514526367188e-06f)
				{
					float4 fragment_unnamed_74 = _MainTex.SampleLevel(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y), 0.0f);
					fragment_output_0.x = fragment_unnamed_74.x;
					fragment_output_0.y = fragment_unnamed_74.y;
					fragment_output_0.z = fragment_unnamed_74.z;
					fragment_output_0.w = fragment_unnamed_74.w;
				}
				else
				{
					bool fragment_unnamed_88 = max(fragment_unnamed_61, fragment_unnamed_53) < max(fragment_unnamed_43, fragment_unnamed_60);
					uint fragment_unnamed_90 = fragment_unnamed_88 ? 4294967295u : 0u;
					float fragment_unnamed_104 = asfloat(fragment_unnamed_88 ? fragment_unnamed_44 : asuint(fragment_unnamed_53));
					float fragment_unnamed_108 = asfloat(fragment_unnamed_88 ? asuint(fragment_unnamed_60) : asuint(fragment_unnamed_61));
					float fragment_unnamed_109 = dot(float2(fragment_unnamed_104, fragment_unnamed_108), 1.0f.xx);
					precise float fragment_unnamed_112 = fragment_unnamed_104 / fragment_unnamed_109;
					precise float fragment_unnamed_113 = fragment_unnamed_108 / fragment_unnamed_109;
					precise float fragment_unnamed_120 = fragment_uniform_buffer_0[28u].x * 1.0f;
					precise float fragment_unnamed_121 = fragment_uniform_buffer_0[28u].y * 1.0f;
					precise float fragment_unnamed_122 = fragment_uniform_buffer_0[28u].x * (-1.0f);
					precise float fragment_unnamed_124 = fragment_uniform_buffer_0[28u].y * (-1.0f);
					float4 fragment_unnamed_134 = _MainTex.SampleLevel(sampler_MainTex, float2(mad(asfloat(fragment_unnamed_44 & fragment_unnamed_90), fragment_unnamed_120, fragment_input_1.x), mad(asfloat(fragment_unnamed_88 ? 0u : asuint(fragment_unnamed_53)), fragment_unnamed_121, fragment_input_1.y)), 0.0f);
					float4 fragment_unnamed_140 = _MainTex.SampleLevel(sampler_MainTex, float2(mad(asfloat(asuint(fragment_unnamed_60) & fragment_unnamed_90), fragment_unnamed_122, fragment_input_1.x), mad(asfloat(fragment_unnamed_88 ? 0u : asuint(fragment_unnamed_61)), fragment_unnamed_124, fragment_input_1.y)), 0.0f);
					precise float fragment_unnamed_146 = fragment_unnamed_113 * fragment_unnamed_140.x;
					precise float fragment_unnamed_147 = fragment_unnamed_113 * fragment_unnamed_140.y;
					precise float fragment_unnamed_148 = fragment_unnamed_113 * fragment_unnamed_140.z;
					precise float fragment_unnamed_149 = fragment_unnamed_113 * fragment_unnamed_140.w;
					fragment_output_0.x = mad(fragment_unnamed_112, fragment_unnamed_134.x, fragment_unnamed_146);
					fragment_output_0.y = mad(fragment_unnamed_112, fragment_unnamed_134.y, fragment_unnamed_147);
					fragment_output_0.z = mad(fragment_unnamed_112, fragment_unnamed_134.z, fragment_unnamed_148);
					fragment_output_0.w = mad(fragment_unnamed_112, fragment_unnamed_134.w, fragment_unnamed_149);
				}
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
	}
}
