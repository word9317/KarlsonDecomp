Shader "Hidden/PostProcessing/Bloom"
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
			GpuProgramID 63068

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
			float4 _Threshold;
			float4 _Params;

			static float4 fragment_uniform_buffer_0[33];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _AutoExposureTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_AutoExposureTex;

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
				precise float fragment_unnamed_63 = clamp(mad(fragment_uniform_buffer_0[28u].x, -0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_64 = clamp(mad(fragment_uniform_buffer_0[28u].y, -0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_65 = clamp(mad(fragment_uniform_buffer_0[28u].x, 0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_66 = clamp(mad(fragment_uniform_buffer_0[28u].y, -0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_69 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_63, fragment_unnamed_64));
				float4 fragment_unnamed_75 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_65, fragment_unnamed_66));
				precise float fragment_unnamed_81 = fragment_unnamed_75.x + fragment_unnamed_69.x;
				precise float fragment_unnamed_82 = fragment_unnamed_75.y + fragment_unnamed_69.y;
				precise float fragment_unnamed_83 = fragment_unnamed_75.z + fragment_unnamed_69.z;
				precise float fragment_unnamed_84 = fragment_unnamed_75.w + fragment_unnamed_69.w;
				precise float fragment_unnamed_104 = clamp(mad(fragment_uniform_buffer_0[28u].x, -0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_105 = clamp(mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_106 = clamp(mad(fragment_uniform_buffer_0[28u].x, 0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_107 = clamp(mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_108 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_104, fragment_unnamed_105));
				float4 fragment_unnamed_114 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_106, fragment_unnamed_107));
				precise float fragment_unnamed_120 = fragment_unnamed_81 + fragment_unnamed_108.x;
				precise float fragment_unnamed_121 = fragment_unnamed_82 + fragment_unnamed_108.y;
				precise float fragment_unnamed_122 = fragment_unnamed_83 + fragment_unnamed_108.z;
				precise float fragment_unnamed_123 = fragment_unnamed_84 + fragment_unnamed_108.w;
				precise float fragment_unnamed_124 = fragment_unnamed_114.x + fragment_unnamed_120;
				precise float fragment_unnamed_125 = fragment_unnamed_114.y + fragment_unnamed_121;
				precise float fragment_unnamed_126 = fragment_unnamed_114.z + fragment_unnamed_122;
				precise float fragment_unnamed_127 = fragment_unnamed_114.w + fragment_unnamed_123;
				precise float fragment_unnamed_135 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_138 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_139 = fragment_input_1.x + fragment_unnamed_135;
				precise float fragment_unnamed_140 = fragment_input_1.y + fragment_unnamed_138;
				precise float fragment_unnamed_146 = clamp(fragment_unnamed_139, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_147 = clamp(fragment_unnamed_140, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_148 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_146, fragment_unnamed_147));
				precise float fragment_unnamed_174 = clamp(mad(fragment_uniform_buffer_0[28u].x, 0.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_175 = clamp(mad(fragment_uniform_buffer_0[28u].y, -1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_176 = clamp(mad(fragment_uniform_buffer_0[28u].x, 1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_177 = clamp(mad(fragment_uniform_buffer_0[28u].y, -1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_178 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_174, fragment_unnamed_175));
				float fragment_unnamed_180 = fragment_unnamed_178.x;
				float fragment_unnamed_181 = fragment_unnamed_178.y;
				float fragment_unnamed_182 = fragment_unnamed_178.z;
				float fragment_unnamed_183 = fragment_unnamed_178.w;
				float4 fragment_unnamed_184 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_176, fragment_unnamed_177));
				precise float fragment_unnamed_190 = fragment_unnamed_184.x + fragment_unnamed_180;
				precise float fragment_unnamed_191 = fragment_unnamed_184.y + fragment_unnamed_181;
				precise float fragment_unnamed_192 = fragment_unnamed_184.z + fragment_unnamed_182;
				precise float fragment_unnamed_193 = fragment_unnamed_184.w + fragment_unnamed_183;
				precise float fragment_unnamed_194 = fragment_unnamed_148.x + fragment_unnamed_180;
				precise float fragment_unnamed_195 = fragment_unnamed_148.y + fragment_unnamed_181;
				precise float fragment_unnamed_196 = fragment_unnamed_148.z + fragment_unnamed_182;
				precise float fragment_unnamed_197 = fragment_unnamed_148.w + fragment_unnamed_183;
				precise float fragment_unnamed_207 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_208 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_209 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_207, fragment_unnamed_208));
				float fragment_unnamed_211 = fragment_unnamed_209.x;
				float fragment_unnamed_212 = fragment_unnamed_209.y;
				float fragment_unnamed_213 = fragment_unnamed_209.z;
				float fragment_unnamed_214 = fragment_unnamed_209.w;
				precise float fragment_unnamed_215 = fragment_unnamed_194 + fragment_unnamed_211;
				precise float fragment_unnamed_216 = fragment_unnamed_195 + fragment_unnamed_212;
				precise float fragment_unnamed_217 = fragment_unnamed_196 + fragment_unnamed_213;
				precise float fragment_unnamed_218 = fragment_unnamed_197 + fragment_unnamed_214;
				precise float fragment_unnamed_238 = clamp(mad(fragment_uniform_buffer_0[28u].x, -1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_239 = clamp(mad(fragment_uniform_buffer_0[28u].y, 0.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_240 = clamp(mad(fragment_uniform_buffer_0[28u].x, 1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_241 = clamp(mad(fragment_uniform_buffer_0[28u].y, 0.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_242 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_238, fragment_unnamed_239));
				float fragment_unnamed_244 = fragment_unnamed_242.x;
				float fragment_unnamed_245 = fragment_unnamed_242.y;
				float fragment_unnamed_246 = fragment_unnamed_242.z;
				float fragment_unnamed_247 = fragment_unnamed_242.w;
				float4 fragment_unnamed_248 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_240, fragment_unnamed_241));
				float fragment_unnamed_250 = fragment_unnamed_248.x;
				float fragment_unnamed_251 = fragment_unnamed_248.y;
				float fragment_unnamed_252 = fragment_unnamed_248.z;
				float fragment_unnamed_253 = fragment_unnamed_248.w;
				precise float fragment_unnamed_254 = fragment_unnamed_215 + fragment_unnamed_244;
				precise float fragment_unnamed_255 = fragment_unnamed_216 + fragment_unnamed_245;
				precise float fragment_unnamed_256 = fragment_unnamed_217 + fragment_unnamed_246;
				precise float fragment_unnamed_257 = fragment_unnamed_218 + fragment_unnamed_247;
				precise float fragment_unnamed_258 = fragment_unnamed_211 + fragment_unnamed_244;
				precise float fragment_unnamed_259 = fragment_unnamed_212 + fragment_unnamed_245;
				precise float fragment_unnamed_260 = fragment_unnamed_213 + fragment_unnamed_246;
				precise float fragment_unnamed_261 = fragment_unnamed_214 + fragment_unnamed_247;
				precise float fragment_unnamed_262 = fragment_unnamed_254 * 0.03125f;
				precise float fragment_unnamed_264 = fragment_unnamed_255 * 0.03125f;
				precise float fragment_unnamed_265 = fragment_unnamed_256 * 0.03125f;
				precise float fragment_unnamed_266 = fragment_unnamed_257 * 0.03125f;
				precise float fragment_unnamed_272 = fragment_unnamed_190 + fragment_unnamed_250;
				precise float fragment_unnamed_273 = fragment_unnamed_191 + fragment_unnamed_251;
				precise float fragment_unnamed_274 = fragment_unnamed_192 + fragment_unnamed_252;
				precise float fragment_unnamed_275 = fragment_unnamed_193 + fragment_unnamed_253;
				precise float fragment_unnamed_276 = fragment_unnamed_211 + fragment_unnamed_250;
				precise float fragment_unnamed_277 = fragment_unnamed_212 + fragment_unnamed_251;
				precise float fragment_unnamed_278 = fragment_unnamed_213 + fragment_unnamed_252;
				precise float fragment_unnamed_279 = fragment_unnamed_214 + fragment_unnamed_253;
				precise float fragment_unnamed_280 = fragment_unnamed_211 + fragment_unnamed_272;
				precise float fragment_unnamed_281 = fragment_unnamed_212 + fragment_unnamed_273;
				precise float fragment_unnamed_282 = fragment_unnamed_213 + fragment_unnamed_274;
				precise float fragment_unnamed_283 = fragment_unnamed_214 + fragment_unnamed_275;
				precise float fragment_unnamed_307 = clamp(mad(fragment_uniform_buffer_0[28u].x, -1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_308 = clamp(mad(fragment_uniform_buffer_0[28u].y, 1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_309 = clamp(mad(fragment_uniform_buffer_0[28u].x, 0.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_310 = clamp(mad(fragment_uniform_buffer_0[28u].y, 1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_311 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_309, fragment_unnamed_310));
				float fragment_unnamed_313 = fragment_unnamed_311.x;
				float fragment_unnamed_314 = fragment_unnamed_311.y;
				float fragment_unnamed_315 = fragment_unnamed_311.z;
				float fragment_unnamed_316 = fragment_unnamed_311.w;
				float4 fragment_unnamed_317 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_307, fragment_unnamed_308));
				precise float fragment_unnamed_323 = fragment_unnamed_313 + fragment_unnamed_258;
				precise float fragment_unnamed_324 = fragment_unnamed_314 + fragment_unnamed_259;
				precise float fragment_unnamed_325 = fragment_unnamed_315 + fragment_unnamed_260;
				precise float fragment_unnamed_326 = fragment_unnamed_316 + fragment_unnamed_261;
				precise float fragment_unnamed_327 = fragment_unnamed_317.x + fragment_unnamed_323;
				precise float fragment_unnamed_328 = fragment_unnamed_317.y + fragment_unnamed_324;
				precise float fragment_unnamed_329 = fragment_unnamed_317.z + fragment_unnamed_325;
				precise float fragment_unnamed_330 = fragment_unnamed_317.w + fragment_unnamed_326;
				precise float fragment_unnamed_343 = fragment_input_1.x + fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_344 = fragment_input_1.y + fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_350 = clamp(fragment_unnamed_343, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_351 = clamp(fragment_unnamed_344, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_352 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_350, fragment_unnamed_351));
				precise float fragment_unnamed_358 = fragment_unnamed_352.x + fragment_unnamed_276;
				precise float fragment_unnamed_359 = fragment_unnamed_352.y + fragment_unnamed_277;
				precise float fragment_unnamed_360 = fragment_unnamed_352.z + fragment_unnamed_278;
				precise float fragment_unnamed_361 = fragment_unnamed_352.w + fragment_unnamed_279;
				precise float fragment_unnamed_362 = fragment_unnamed_313 + fragment_unnamed_358;
				precise float fragment_unnamed_363 = fragment_unnamed_314 + fragment_unnamed_359;
				precise float fragment_unnamed_364 = fragment_unnamed_315 + fragment_unnamed_360;
				precise float fragment_unnamed_365 = fragment_unnamed_316 + fragment_unnamed_361;
				float4 fragment_unnamed_380 = _AutoExposureTex.Sample(sampler_AutoExposureTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_382 = fragment_unnamed_380.x;
				precise float fragment_unnamed_383 = min(mad(fragment_unnamed_362, 0.03125f, mad(fragment_unnamed_327, 0.03125f, mad(fragment_unnamed_280, 0.03125f, mad(fragment_unnamed_124, 0.125f, fragment_unnamed_262)))), 65504.0f) * fragment_unnamed_382;
				precise float fragment_unnamed_384 = min(mad(fragment_unnamed_363, 0.03125f, mad(fragment_unnamed_328, 0.03125f, mad(fragment_unnamed_281, 0.03125f, mad(fragment_unnamed_125, 0.125f, fragment_unnamed_264)))), 65504.0f) * fragment_unnamed_382;
				precise float fragment_unnamed_385 = min(mad(fragment_unnamed_364, 0.03125f, mad(fragment_unnamed_329, 0.03125f, mad(fragment_unnamed_282, 0.03125f, mad(fragment_unnamed_126, 0.125f, fragment_unnamed_265)))), 65504.0f) * fragment_unnamed_382;
				precise float fragment_unnamed_386 = min(mad(fragment_unnamed_365, 0.03125f, mad(fragment_unnamed_330, 0.03125f, mad(fragment_unnamed_283, 0.03125f, mad(fragment_unnamed_127, 0.125f, fragment_unnamed_266)))), 65504.0f) * fragment_unnamed_382;
				float fragment_unnamed_391 = min(fragment_unnamed_383, fragment_uniform_buffer_0[32u].x);
				float fragment_unnamed_392 = min(fragment_unnamed_384, fragment_uniform_buffer_0[32u].x);
				float fragment_unnamed_393 = min(fragment_unnamed_385, fragment_uniform_buffer_0[32u].x);
				float fragment_unnamed_396 = max(fragment_unnamed_393, max(fragment_unnamed_392, fragment_unnamed_391));
				precise float fragment_unnamed_401 = (-0.0f) - fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_403 = (-0.0f) - fragment_uniform_buffer_0[31u].x;
				precise float fragment_unnamed_404 = fragment_unnamed_396 + fragment_unnamed_401;
				precise float fragment_unnamed_405 = fragment_unnamed_396 + fragment_unnamed_403;
				float fragment_unnamed_412 = min(max(fragment_unnamed_404, 0.0f), fragment_uniform_buffer_0[31u].z);
				precise float fragment_unnamed_416 = fragment_unnamed_412 * fragment_uniform_buffer_0[31u].w;
				precise float fragment_unnamed_417 = fragment_unnamed_412 * fragment_unnamed_416;
				precise float fragment_unnamed_419 = max(fragment_unnamed_405, fragment_unnamed_417) / max(fragment_unnamed_396, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_420 = fragment_unnamed_391 * fragment_unnamed_419;
				precise float fragment_unnamed_421 = fragment_unnamed_392 * fragment_unnamed_419;
				precise float fragment_unnamed_422 = fragment_unnamed_393 * fragment_unnamed_419;
				precise float fragment_unnamed_423 = min(fragment_unnamed_386, fragment_uniform_buffer_0[32u].x) * fragment_unnamed_419;
				fragment_output_0.x = fragment_unnamed_420;
				fragment_output_0.y = fragment_unnamed_421;
				fragment_output_0.z = fragment_unnamed_422;
				fragment_output_0.w = fragment_unnamed_423;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[31] = float4(_Threshold[0], _Threshold[1], _Threshold[2], _Threshold[3]);

				fragment_uniform_buffer_0[32] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

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
			GpuProgramID 123788

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
			float4 _Threshold;
			float4 _Params;

			static float4 fragment_uniform_buffer_0[33];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _AutoExposureTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_AutoExposureTex;

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
				precise float fragment_unnamed_62 = clamp(mad(fragment_uniform_buffer_0[28u].x, -1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_63 = clamp(mad(fragment_uniform_buffer_0[28u].y, -1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_64 = clamp(mad(fragment_uniform_buffer_0[28u].x, 1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_65 = clamp(mad(fragment_uniform_buffer_0[28u].y, -1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_68 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_62, fragment_unnamed_63));
				float4 fragment_unnamed_74 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_64, fragment_unnamed_65));
				precise float fragment_unnamed_80 = fragment_unnamed_74.x + fragment_unnamed_68.x;
				precise float fragment_unnamed_81 = fragment_unnamed_74.y + fragment_unnamed_68.y;
				precise float fragment_unnamed_82 = fragment_unnamed_74.z + fragment_unnamed_68.z;
				precise float fragment_unnamed_83 = fragment_unnamed_74.w + fragment_unnamed_68.w;
				precise float fragment_unnamed_103 = clamp(mad(fragment_uniform_buffer_0[28u].x, -1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_104 = clamp(mad(fragment_uniform_buffer_0[28u].y, 1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_105 = clamp(mad(fragment_uniform_buffer_0[28u].x, 1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_106 = clamp(mad(fragment_uniform_buffer_0[28u].y, 1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_107 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_103, fragment_unnamed_104));
				float4 fragment_unnamed_113 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_105, fragment_unnamed_106));
				precise float fragment_unnamed_119 = fragment_unnamed_80 + fragment_unnamed_107.x;
				precise float fragment_unnamed_120 = fragment_unnamed_81 + fragment_unnamed_107.y;
				precise float fragment_unnamed_121 = fragment_unnamed_82 + fragment_unnamed_107.z;
				precise float fragment_unnamed_122 = fragment_unnamed_83 + fragment_unnamed_107.w;
				precise float fragment_unnamed_123 = fragment_unnamed_113.x + fragment_unnamed_119;
				precise float fragment_unnamed_124 = fragment_unnamed_113.y + fragment_unnamed_120;
				precise float fragment_unnamed_125 = fragment_unnamed_113.z + fragment_unnamed_121;
				precise float fragment_unnamed_126 = fragment_unnamed_113.w + fragment_unnamed_122;
				precise float fragment_unnamed_127 = fragment_unnamed_123 * 0.25f;
				precise float fragment_unnamed_129 = fragment_unnamed_124 * 0.25f;
				precise float fragment_unnamed_130 = fragment_unnamed_125 * 0.25f;
				precise float fragment_unnamed_131 = fragment_unnamed_126 * 0.25f;
				float4 fragment_unnamed_142 = _AutoExposureTex.Sample(sampler_AutoExposureTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_144 = fragment_unnamed_142.x;
				precise float fragment_unnamed_145 = min(fragment_unnamed_127, 65504.0f) * fragment_unnamed_144;
				precise float fragment_unnamed_146 = min(fragment_unnamed_129, 65504.0f) * fragment_unnamed_144;
				precise float fragment_unnamed_147 = min(fragment_unnamed_130, 65504.0f) * fragment_unnamed_144;
				precise float fragment_unnamed_148 = min(fragment_unnamed_131, 65504.0f) * fragment_unnamed_144;
				float fragment_unnamed_153 = min(fragment_unnamed_145, fragment_uniform_buffer_0[32u].x);
				float fragment_unnamed_154 = min(fragment_unnamed_146, fragment_uniform_buffer_0[32u].x);
				float fragment_unnamed_155 = min(fragment_unnamed_147, fragment_uniform_buffer_0[32u].x);
				float fragment_unnamed_158 = max(fragment_unnamed_155, max(fragment_unnamed_154, fragment_unnamed_153));
				precise float fragment_unnamed_163 = (-0.0f) - fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_166 = (-0.0f) - fragment_uniform_buffer_0[31u].x;
				precise float fragment_unnamed_167 = fragment_unnamed_158 + fragment_unnamed_163;
				precise float fragment_unnamed_168 = fragment_unnamed_158 + fragment_unnamed_166;
				float fragment_unnamed_175 = min(max(fragment_unnamed_167, 0.0f), fragment_uniform_buffer_0[31u].z);
				precise float fragment_unnamed_179 = fragment_unnamed_175 * fragment_uniform_buffer_0[31u].w;
				precise float fragment_unnamed_180 = fragment_unnamed_175 * fragment_unnamed_179;
				precise float fragment_unnamed_182 = max(fragment_unnamed_168, fragment_unnamed_180) / max(fragment_unnamed_158, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_183 = fragment_unnamed_153 * fragment_unnamed_182;
				precise float fragment_unnamed_184 = fragment_unnamed_154 * fragment_unnamed_182;
				precise float fragment_unnamed_185 = fragment_unnamed_155 * fragment_unnamed_182;
				precise float fragment_unnamed_186 = min(fragment_unnamed_148, fragment_uniform_buffer_0[32u].x) * fragment_unnamed_182;
				fragment_output_0.x = fragment_unnamed_183;
				fragment_output_0.y = fragment_unnamed_184;
				fragment_output_0.z = fragment_unnamed_185;
				fragment_output_0.w = fragment_unnamed_186;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[31] = float4(_Threshold[0], _Threshold[1], _Threshold[2], _Threshold[3]);

				fragment_uniform_buffer_0[32] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

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
			GpuProgramID 174891

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
				precise float fragment_unnamed_59 = clamp(mad(fragment_uniform_buffer_0[28u].x, -0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_60 = clamp(mad(fragment_uniform_buffer_0[28u].y, -0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_61 = clamp(mad(fragment_uniform_buffer_0[28u].x, 0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_62 = clamp(mad(fragment_uniform_buffer_0[28u].y, -0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_65 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_59, fragment_unnamed_60));
				float4 fragment_unnamed_71 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_61, fragment_unnamed_62));
				precise float fragment_unnamed_77 = fragment_unnamed_71.x + fragment_unnamed_65.x;
				precise float fragment_unnamed_78 = fragment_unnamed_71.y + fragment_unnamed_65.y;
				precise float fragment_unnamed_79 = fragment_unnamed_71.z + fragment_unnamed_65.z;
				precise float fragment_unnamed_80 = fragment_unnamed_71.w + fragment_unnamed_65.w;
				precise float fragment_unnamed_100 = clamp(mad(fragment_uniform_buffer_0[28u].x, -0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_101 = clamp(mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_102 = clamp(mad(fragment_uniform_buffer_0[28u].x, 0.5f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_103 = clamp(mad(fragment_uniform_buffer_0[28u].y, 0.5f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_104 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_100, fragment_unnamed_101));
				float4 fragment_unnamed_110 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_102, fragment_unnamed_103));
				precise float fragment_unnamed_116 = fragment_unnamed_77 + fragment_unnamed_104.x;
				precise float fragment_unnamed_117 = fragment_unnamed_78 + fragment_unnamed_104.y;
				precise float fragment_unnamed_118 = fragment_unnamed_79 + fragment_unnamed_104.z;
				precise float fragment_unnamed_119 = fragment_unnamed_80 + fragment_unnamed_104.w;
				precise float fragment_unnamed_120 = fragment_unnamed_110.x + fragment_unnamed_116;
				precise float fragment_unnamed_121 = fragment_unnamed_110.y + fragment_unnamed_117;
				precise float fragment_unnamed_122 = fragment_unnamed_110.z + fragment_unnamed_118;
				precise float fragment_unnamed_123 = fragment_unnamed_110.w + fragment_unnamed_119;
				precise float fragment_unnamed_131 = (-0.0f) - fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_134 = (-0.0f) - fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_135 = fragment_input_1.x + fragment_unnamed_131;
				precise float fragment_unnamed_136 = fragment_input_1.y + fragment_unnamed_134;
				precise float fragment_unnamed_142 = clamp(fragment_unnamed_135, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_143 = clamp(fragment_unnamed_136, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_144 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_142, fragment_unnamed_143));
				precise float fragment_unnamed_170 = clamp(mad(fragment_uniform_buffer_0[28u].x, 0.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_171 = clamp(mad(fragment_uniform_buffer_0[28u].y, -1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_172 = clamp(mad(fragment_uniform_buffer_0[28u].x, 1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_173 = clamp(mad(fragment_uniform_buffer_0[28u].y, -1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_174 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_170, fragment_unnamed_171));
				float fragment_unnamed_176 = fragment_unnamed_174.x;
				float fragment_unnamed_177 = fragment_unnamed_174.y;
				float fragment_unnamed_178 = fragment_unnamed_174.z;
				float fragment_unnamed_179 = fragment_unnamed_174.w;
				float4 fragment_unnamed_180 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_172, fragment_unnamed_173));
				precise float fragment_unnamed_186 = fragment_unnamed_180.x + fragment_unnamed_176;
				precise float fragment_unnamed_187 = fragment_unnamed_180.y + fragment_unnamed_177;
				precise float fragment_unnamed_188 = fragment_unnamed_180.z + fragment_unnamed_178;
				precise float fragment_unnamed_189 = fragment_unnamed_180.w + fragment_unnamed_179;
				precise float fragment_unnamed_190 = fragment_unnamed_144.x + fragment_unnamed_176;
				precise float fragment_unnamed_191 = fragment_unnamed_144.y + fragment_unnamed_177;
				precise float fragment_unnamed_192 = fragment_unnamed_144.z + fragment_unnamed_178;
				precise float fragment_unnamed_193 = fragment_unnamed_144.w + fragment_unnamed_179;
				precise float fragment_unnamed_203 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_204 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_205 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_203, fragment_unnamed_204));
				float fragment_unnamed_207 = fragment_unnamed_205.x;
				float fragment_unnamed_208 = fragment_unnamed_205.y;
				float fragment_unnamed_209 = fragment_unnamed_205.z;
				float fragment_unnamed_210 = fragment_unnamed_205.w;
				precise float fragment_unnamed_211 = fragment_unnamed_190 + fragment_unnamed_207;
				precise float fragment_unnamed_212 = fragment_unnamed_191 + fragment_unnamed_208;
				precise float fragment_unnamed_213 = fragment_unnamed_192 + fragment_unnamed_209;
				precise float fragment_unnamed_214 = fragment_unnamed_193 + fragment_unnamed_210;
				precise float fragment_unnamed_234 = clamp(mad(fragment_uniform_buffer_0[28u].x, -1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_235 = clamp(mad(fragment_uniform_buffer_0[28u].y, 0.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_236 = clamp(mad(fragment_uniform_buffer_0[28u].x, 1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_237 = clamp(mad(fragment_uniform_buffer_0[28u].y, 0.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_238 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_234, fragment_unnamed_235));
				float fragment_unnamed_240 = fragment_unnamed_238.x;
				float fragment_unnamed_241 = fragment_unnamed_238.y;
				float fragment_unnamed_242 = fragment_unnamed_238.z;
				float fragment_unnamed_243 = fragment_unnamed_238.w;
				float4 fragment_unnamed_244 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_236, fragment_unnamed_237));
				float fragment_unnamed_246 = fragment_unnamed_244.x;
				float fragment_unnamed_247 = fragment_unnamed_244.y;
				float fragment_unnamed_248 = fragment_unnamed_244.z;
				float fragment_unnamed_249 = fragment_unnamed_244.w;
				precise float fragment_unnamed_250 = fragment_unnamed_211 + fragment_unnamed_240;
				precise float fragment_unnamed_251 = fragment_unnamed_212 + fragment_unnamed_241;
				precise float fragment_unnamed_252 = fragment_unnamed_213 + fragment_unnamed_242;
				precise float fragment_unnamed_253 = fragment_unnamed_214 + fragment_unnamed_243;
				precise float fragment_unnamed_254 = fragment_unnamed_207 + fragment_unnamed_240;
				precise float fragment_unnamed_255 = fragment_unnamed_208 + fragment_unnamed_241;
				precise float fragment_unnamed_256 = fragment_unnamed_209 + fragment_unnamed_242;
				precise float fragment_unnamed_257 = fragment_unnamed_210 + fragment_unnamed_243;
				precise float fragment_unnamed_258 = fragment_unnamed_250 * 0.03125f;
				precise float fragment_unnamed_260 = fragment_unnamed_251 * 0.03125f;
				precise float fragment_unnamed_261 = fragment_unnamed_252 * 0.03125f;
				precise float fragment_unnamed_262 = fragment_unnamed_253 * 0.03125f;
				precise float fragment_unnamed_268 = fragment_unnamed_186 + fragment_unnamed_246;
				precise float fragment_unnamed_269 = fragment_unnamed_187 + fragment_unnamed_247;
				precise float fragment_unnamed_270 = fragment_unnamed_188 + fragment_unnamed_248;
				precise float fragment_unnamed_271 = fragment_unnamed_189 + fragment_unnamed_249;
				precise float fragment_unnamed_272 = fragment_unnamed_207 + fragment_unnamed_246;
				precise float fragment_unnamed_273 = fragment_unnamed_208 + fragment_unnamed_247;
				precise float fragment_unnamed_274 = fragment_unnamed_209 + fragment_unnamed_248;
				precise float fragment_unnamed_275 = fragment_unnamed_210 + fragment_unnamed_249;
				precise float fragment_unnamed_276 = fragment_unnamed_207 + fragment_unnamed_268;
				precise float fragment_unnamed_277 = fragment_unnamed_208 + fragment_unnamed_269;
				precise float fragment_unnamed_278 = fragment_unnamed_209 + fragment_unnamed_270;
				precise float fragment_unnamed_279 = fragment_unnamed_210 + fragment_unnamed_271;
				precise float fragment_unnamed_303 = clamp(mad(fragment_uniform_buffer_0[28u].x, -1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_304 = clamp(mad(fragment_uniform_buffer_0[28u].y, 1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_305 = clamp(mad(fragment_uniform_buffer_0[28u].x, 0.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_306 = clamp(mad(fragment_uniform_buffer_0[28u].y, 1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_307 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_305, fragment_unnamed_306));
				float fragment_unnamed_309 = fragment_unnamed_307.x;
				float fragment_unnamed_310 = fragment_unnamed_307.y;
				float fragment_unnamed_311 = fragment_unnamed_307.z;
				float fragment_unnamed_312 = fragment_unnamed_307.w;
				float4 fragment_unnamed_313 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_303, fragment_unnamed_304));
				precise float fragment_unnamed_319 = fragment_unnamed_309 + fragment_unnamed_254;
				precise float fragment_unnamed_320 = fragment_unnamed_310 + fragment_unnamed_255;
				precise float fragment_unnamed_321 = fragment_unnamed_311 + fragment_unnamed_256;
				precise float fragment_unnamed_322 = fragment_unnamed_312 + fragment_unnamed_257;
				precise float fragment_unnamed_323 = fragment_unnamed_313.x + fragment_unnamed_319;
				precise float fragment_unnamed_324 = fragment_unnamed_313.y + fragment_unnamed_320;
				precise float fragment_unnamed_325 = fragment_unnamed_313.z + fragment_unnamed_321;
				precise float fragment_unnamed_326 = fragment_unnamed_313.w + fragment_unnamed_322;
				precise float fragment_unnamed_339 = fragment_input_1.x + fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_340 = fragment_input_1.y + fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_346 = clamp(fragment_unnamed_339, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_347 = clamp(fragment_unnamed_340, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_348 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_346, fragment_unnamed_347));
				precise float fragment_unnamed_354 = fragment_unnamed_348.x + fragment_unnamed_272;
				precise float fragment_unnamed_355 = fragment_unnamed_348.y + fragment_unnamed_273;
				precise float fragment_unnamed_356 = fragment_unnamed_348.z + fragment_unnamed_274;
				precise float fragment_unnamed_357 = fragment_unnamed_348.w + fragment_unnamed_275;
				precise float fragment_unnamed_358 = fragment_unnamed_309 + fragment_unnamed_354;
				precise float fragment_unnamed_359 = fragment_unnamed_310 + fragment_unnamed_355;
				precise float fragment_unnamed_360 = fragment_unnamed_311 + fragment_unnamed_356;
				precise float fragment_unnamed_361 = fragment_unnamed_312 + fragment_unnamed_357;
				fragment_output_0.x = mad(fragment_unnamed_358, 0.03125f, mad(fragment_unnamed_323, 0.03125f, mad(fragment_unnamed_276, 0.03125f, mad(fragment_unnamed_120, 0.125f, fragment_unnamed_258))));
				fragment_output_0.y = mad(fragment_unnamed_359, 0.03125f, mad(fragment_unnamed_324, 0.03125f, mad(fragment_unnamed_277, 0.03125f, mad(fragment_unnamed_121, 0.125f, fragment_unnamed_260))));
				fragment_output_0.z = mad(fragment_unnamed_360, 0.03125f, mad(fragment_unnamed_325, 0.03125f, mad(fragment_unnamed_278, 0.03125f, mad(fragment_unnamed_122, 0.125f, fragment_unnamed_261))));
				fragment_output_0.w = mad(fragment_unnamed_361, 0.03125f, mad(fragment_unnamed_326, 0.03125f, mad(fragment_unnamed_279, 0.03125f, mad(fragment_unnamed_123, 0.125f, fragment_unnamed_262))));
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

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
			GpuProgramID 261858

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
				precise float fragment_unnamed_58 = clamp(mad(fragment_uniform_buffer_0[28u].x, -1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_59 = clamp(mad(fragment_uniform_buffer_0[28u].y, -1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_60 = clamp(mad(fragment_uniform_buffer_0[28u].x, 1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_61 = clamp(mad(fragment_uniform_buffer_0[28u].y, -1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_64 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_58, fragment_unnamed_59));
				float4 fragment_unnamed_70 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_60, fragment_unnamed_61));
				precise float fragment_unnamed_76 = fragment_unnamed_70.x + fragment_unnamed_64.x;
				precise float fragment_unnamed_77 = fragment_unnamed_70.y + fragment_unnamed_64.y;
				precise float fragment_unnamed_78 = fragment_unnamed_70.z + fragment_unnamed_64.z;
				precise float fragment_unnamed_79 = fragment_unnamed_70.w + fragment_unnamed_64.w;
				precise float fragment_unnamed_99 = clamp(mad(fragment_uniform_buffer_0[28u].x, -1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_100 = clamp(mad(fragment_uniform_buffer_0[28u].y, 1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_101 = clamp(mad(fragment_uniform_buffer_0[28u].x, 1.0f, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_102 = clamp(mad(fragment_uniform_buffer_0[28u].y, 1.0f, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_103 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_99, fragment_unnamed_100));
				float4 fragment_unnamed_109 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_101, fragment_unnamed_102));
				precise float fragment_unnamed_115 = fragment_unnamed_76 + fragment_unnamed_103.x;
				precise float fragment_unnamed_116 = fragment_unnamed_77 + fragment_unnamed_103.y;
				precise float fragment_unnamed_117 = fragment_unnamed_78 + fragment_unnamed_103.z;
				precise float fragment_unnamed_118 = fragment_unnamed_79 + fragment_unnamed_103.w;
				precise float fragment_unnamed_119 = fragment_unnamed_109.x + fragment_unnamed_115;
				precise float fragment_unnamed_120 = fragment_unnamed_109.y + fragment_unnamed_116;
				precise float fragment_unnamed_121 = fragment_unnamed_109.z + fragment_unnamed_117;
				precise float fragment_unnamed_122 = fragment_unnamed_109.w + fragment_unnamed_118;
				precise float fragment_unnamed_123 = fragment_unnamed_119 * 0.25f;
				precise float fragment_unnamed_125 = fragment_unnamed_120 * 0.25f;
				precise float fragment_unnamed_126 = fragment_unnamed_121 * 0.25f;
				precise float fragment_unnamed_127 = fragment_unnamed_122 * 0.25f;
				fragment_output_0.x = fragment_unnamed_123;
				fragment_output_0.y = fragment_unnamed_125;
				fragment_output_0.z = fragment_unnamed_126;
				fragment_output_0.w = fragment_unnamed_127;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

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
			GpuProgramID 278575

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
			float _SampleScale;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _BloomTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_BloomTex;

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
				float4 fragment_unnamed_54 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_50, fragment_unnamed_51));
				float fragment_unnamed_60 = asfloat(1065353216u);
				float fragment_unnamed_68 = asfloat(asuint(fragment_uniform_buffer_0[29u]).x);
				precise float fragment_unnamed_74 = fragment_unnamed_60 * fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_75 = fragment_unnamed_60 * fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_76 = fragment_unnamed_68 * fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_77 = fragment_unnamed_68 * fragment_uniform_buffer_0[28u].y;
				float fragment_unnamed_78 = asfloat(3212836864u);
				float fragment_unnamed_80 = asfloat(0u);
				float fragment_unnamed_85 = asfloat(asuint(fragment_uniform_buffer_0[29u]).x);
				precise float fragment_unnamed_86 = (-0.0f) - fragment_unnamed_74;
				precise float fragment_unnamed_88 = (-0.0f) - fragment_unnamed_75;
				precise float fragment_unnamed_89 = (-0.0f) - fragment_unnamed_77;
				precise float fragment_unnamed_105 = clamp(mad(fragment_unnamed_86, fragment_unnamed_85, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_106 = clamp(mad(fragment_unnamed_88, fragment_unnamed_85, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_107 = clamp(mad(fragment_unnamed_89, fragment_unnamed_80, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_108 = clamp(mad(fragment_unnamed_88, fragment_unnamed_85, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_109 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_105, fragment_unnamed_106));
				float4 fragment_unnamed_115 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_107, fragment_unnamed_108));
				precise float fragment_unnamed_126 = (-0.0f) - fragment_unnamed_76;
				precise float fragment_unnamed_127 = (-0.0f) - fragment_unnamed_75;
				precise float fragment_unnamed_139 = clamp(mad(fragment_unnamed_126, fragment_unnamed_78, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_140 = clamp(mad(fragment_unnamed_127, fragment_unnamed_85, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_141 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_139, fragment_unnamed_140));
				precise float fragment_unnamed_147 = mad(fragment_unnamed_115.x, 2.0f, fragment_unnamed_109.x) + fragment_unnamed_141.x;
				precise float fragment_unnamed_148 = mad(fragment_unnamed_115.y, 2.0f, fragment_unnamed_109.y) + fragment_unnamed_141.y;
				precise float fragment_unnamed_149 = mad(fragment_unnamed_115.z, 2.0f, fragment_unnamed_109.z) + fragment_unnamed_141.z;
				precise float fragment_unnamed_150 = mad(fragment_unnamed_115.w, 2.0f, fragment_unnamed_109.w) + fragment_unnamed_141.w;
				precise float fragment_unnamed_186 = clamp(mad(fragment_unnamed_74, fragment_unnamed_85, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_187 = clamp(mad(fragment_unnamed_75, fragment_unnamed_85, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_188 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_186, fragment_unnamed_187));
				precise float fragment_unnamed_197 = clamp(mad(fragment_unnamed_76, fragment_unnamed_78, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_198 = clamp(mad(fragment_unnamed_75, fragment_unnamed_85, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_199 = clamp(mad(fragment_unnamed_77, fragment_unnamed_80, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_200 = clamp(mad(fragment_unnamed_75, fragment_unnamed_85, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_204 = clamp(mad(fragment_unnamed_76, fragment_unnamed_78, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_205 = clamp(mad(fragment_unnamed_77, fragment_unnamed_80, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_206 = clamp(mad(fragment_unnamed_74, fragment_unnamed_85, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_207 = clamp(mad(fragment_unnamed_77, fragment_unnamed_80, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_208 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_204, fragment_unnamed_205));
				float4 fragment_unnamed_214 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_206, fragment_unnamed_207));
				float4 fragment_unnamed_233 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_197, fragment_unnamed_198));
				float4 fragment_unnamed_239 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_199, fragment_unnamed_200));
				precise float fragment_unnamed_245 = mad(fragment_unnamed_214.x, 2.0f, mad(fragment_unnamed_54.x, 4.0f, mad(fragment_unnamed_208.x, 2.0f, fragment_unnamed_147))) + fragment_unnamed_233.x;
				precise float fragment_unnamed_246 = mad(fragment_unnamed_214.y, 2.0f, mad(fragment_unnamed_54.y, 4.0f, mad(fragment_unnamed_208.y, 2.0f, fragment_unnamed_148))) + fragment_unnamed_233.y;
				precise float fragment_unnamed_247 = mad(fragment_unnamed_214.z, 2.0f, mad(fragment_unnamed_54.z, 4.0f, mad(fragment_unnamed_208.z, 2.0f, fragment_unnamed_149))) + fragment_unnamed_233.z;
				precise float fragment_unnamed_248 = mad(fragment_unnamed_214.w, 2.0f, mad(fragment_unnamed_54.w, 4.0f, mad(fragment_unnamed_208.w, 2.0f, fragment_unnamed_150))) + fragment_unnamed_233.w;
				precise float fragment_unnamed_253 = fragment_unnamed_188.x + mad(fragment_unnamed_239.x, 2.0f, fragment_unnamed_245);
				precise float fragment_unnamed_254 = fragment_unnamed_188.y + mad(fragment_unnamed_239.y, 2.0f, fragment_unnamed_246);
				precise float fragment_unnamed_255 = fragment_unnamed_188.z + mad(fragment_unnamed_239.z, 2.0f, fragment_unnamed_247);
				precise float fragment_unnamed_256 = fragment_unnamed_188.w + mad(fragment_unnamed_239.w, 2.0f, fragment_unnamed_248);
				float4 fragment_unnamed_262 = _BloomTex.Sample(sampler_BloomTex, float2(fragment_input_1.x, fragment_input_1.y));
				fragment_output_0.x = mad(fragment_unnamed_253, 0.0625f, fragment_unnamed_262.x);
				fragment_output_0.y = mad(fragment_unnamed_254, 0.0625f, fragment_unnamed_262.y);
				fragment_output_0.z = mad(fragment_unnamed_255, 0.0625f, fragment_unnamed_262.z);
				fragment_output_0.w = mad(fragment_unnamed_256, 0.0625f, fragment_unnamed_262.w);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[29] = float4(_SampleScale, fragment_uniform_buffer_0[29][1], fragment_uniform_buffer_0[29][2], fragment_uniform_buffer_0[29][3]);

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
			GpuProgramID 332011

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
			float _SampleScale;

			static float4 fragment_uniform_buffer_0[30];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _BloomTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_BloomTex;

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
				precise float fragment_unnamed_40 = fragment_uniform_buffer_0[28u].x * (-1.0f);
				precise float fragment_unnamed_42 = fragment_uniform_buffer_0[28u].y * (-1.0f);
				precise float fragment_unnamed_43 = fragment_uniform_buffer_0[28u].x * 1.0f;
				precise float fragment_unnamed_45 = fragment_uniform_buffer_0[28u].y * 1.0f;
				precise float fragment_unnamed_50 = fragment_uniform_buffer_0[29u].x * 0.5f;
				precise float fragment_unnamed_84 = clamp(mad(fragment_unnamed_40, fragment_unnamed_50, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_85 = clamp(mad(fragment_unnamed_45, fragment_unnamed_50, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_86 = clamp(mad(fragment_unnamed_43, fragment_unnamed_50, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_87 = clamp(mad(fragment_unnamed_45, fragment_unnamed_50, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_91 = clamp(mad(fragment_unnamed_40, fragment_unnamed_50, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_92 = clamp(mad(fragment_unnamed_42, fragment_unnamed_50, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_93 = clamp(mad(fragment_unnamed_43, fragment_unnamed_50, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_94 = clamp(mad(fragment_unnamed_42, fragment_unnamed_50, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_97 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_91, fragment_unnamed_92));
				float4 fragment_unnamed_103 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_93, fragment_unnamed_94));
				precise float fragment_unnamed_109 = fragment_unnamed_103.x + fragment_unnamed_97.x;
				precise float fragment_unnamed_110 = fragment_unnamed_103.y + fragment_unnamed_97.y;
				precise float fragment_unnamed_111 = fragment_unnamed_103.z + fragment_unnamed_97.z;
				precise float fragment_unnamed_112 = fragment_unnamed_103.w + fragment_unnamed_97.w;
				float4 fragment_unnamed_113 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_84, fragment_unnamed_85));
				float4 fragment_unnamed_119 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_86, fragment_unnamed_87));
				precise float fragment_unnamed_125 = fragment_unnamed_109 + fragment_unnamed_113.x;
				precise float fragment_unnamed_126 = fragment_unnamed_110 + fragment_unnamed_113.y;
				precise float fragment_unnamed_127 = fragment_unnamed_111 + fragment_unnamed_113.z;
				precise float fragment_unnamed_128 = fragment_unnamed_112 + fragment_unnamed_113.w;
				precise float fragment_unnamed_129 = fragment_unnamed_119.x + fragment_unnamed_125;
				precise float fragment_unnamed_130 = fragment_unnamed_119.y + fragment_unnamed_126;
				precise float fragment_unnamed_131 = fragment_unnamed_119.z + fragment_unnamed_127;
				precise float fragment_unnamed_132 = fragment_unnamed_119.w + fragment_unnamed_128;
				float4 fragment_unnamed_138 = _BloomTex.Sample(sampler_BloomTex, float2(fragment_input_1.x, fragment_input_1.y));
				fragment_output_0.x = mad(fragment_unnamed_129, 0.25f, fragment_unnamed_138.x);
				fragment_output_0.y = mad(fragment_unnamed_130, 0.25f, fragment_unnamed_138.y);
				fragment_output_0.z = mad(fragment_unnamed_131, 0.25f, fragment_unnamed_138.z);
				fragment_output_0.w = mad(fragment_unnamed_132, 0.25f, fragment_unnamed_138.w);
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[29] = float4(_SampleScale, fragment_uniform_buffer_0[29][1], fragment_uniform_buffer_0[29][2], fragment_uniform_buffer_0[29][3]);

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
			GpuProgramID 431202

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


			float4 _Threshold;
			float4 _Params;

			static float4 fragment_uniform_buffer_0[33];
			Texture2D<float4> _MainTex;
			Texture2D<float4> _AutoExposureTex;
			SamplerState sampler_MainTex;
			SamplerState sampler_AutoExposureTex;

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
				float4 fragment_unnamed_43 = _MainTex.Sample(sampler_MainTex, float2(fragment_input_1.x, fragment_input_1.y));
				float4 fragment_unnamed_58 = _AutoExposureTex.Sample(sampler_AutoExposureTex, float2(fragment_input_1.x, fragment_input_1.y));
				float fragment_unnamed_60 = fragment_unnamed_58.x;
				precise float fragment_unnamed_61 = min(fragment_unnamed_43.x, 65504.0f) * fragment_unnamed_60;
				precise float fragment_unnamed_62 = min(fragment_unnamed_43.y, 65504.0f) * fragment_unnamed_60;
				precise float fragment_unnamed_63 = min(fragment_unnamed_43.z, 65504.0f) * fragment_unnamed_60;
				float fragment_unnamed_69 = min(fragment_unnamed_61, fragment_uniform_buffer_0[32u].x);
				float fragment_unnamed_70 = min(fragment_unnamed_62, fragment_uniform_buffer_0[32u].x);
				float fragment_unnamed_71 = min(fragment_unnamed_63, fragment_uniform_buffer_0[32u].x);
				float fragment_unnamed_73 = max(fragment_unnamed_71, max(fragment_unnamed_70, fragment_unnamed_69));
				precise float fragment_unnamed_78 = (-0.0f) - fragment_uniform_buffer_0[31u].y;
				precise float fragment_unnamed_81 = (-0.0f) - fragment_uniform_buffer_0[31u].x;
				precise float fragment_unnamed_82 = fragment_unnamed_73 + fragment_unnamed_78;
				precise float fragment_unnamed_83 = fragment_unnamed_73 + fragment_unnamed_81;
				float fragment_unnamed_90 = min(max(fragment_unnamed_82, 0.0f), fragment_uniform_buffer_0[31u].z);
				precise float fragment_unnamed_94 = fragment_unnamed_90 * fragment_uniform_buffer_0[31u].w;
				precise float fragment_unnamed_95 = fragment_unnamed_90 * fragment_unnamed_94;
				precise float fragment_unnamed_97 = max(fragment_unnamed_83, fragment_unnamed_95) / max(fragment_unnamed_73, 9.9999997473787516355514526367188e-05f);
				precise float fragment_unnamed_98 = fragment_unnamed_97 * fragment_unnamed_69;
				precise float fragment_unnamed_99 = fragment_unnamed_97 * fragment_unnamed_70;
				precise float fragment_unnamed_100 = fragment_unnamed_97 * fragment_unnamed_71;
				fragment_output_0.x = fragment_unnamed_98;
				fragment_output_0.y = fragment_unnamed_99;
				fragment_output_0.z = fragment_unnamed_100;
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[31] = float4(_Threshold[0], _Threshold[1], _Threshold[2], _Threshold[3]);

				fragment_uniform_buffer_0[32] = float4(_Params[0], _Params[1], _Params[2], _Params[3]);

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
			GpuProgramID 484084

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
			float _SampleScale;
			float4 _ColorIntensity;

			static float4 fragment_uniform_buffer_0[31];
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
				precise float fragment_unnamed_46 = clamp(fragment_input_1.x, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_47 = clamp(fragment_input_1.y, 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_50 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_46, fragment_unnamed_47));
				float fragment_unnamed_55 = asfloat(1065353216u);
				float fragment_unnamed_63 = asfloat(asuint(fragment_uniform_buffer_0[29u]).x);
				precise float fragment_unnamed_69 = fragment_unnamed_55 * fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_70 = fragment_unnamed_55 * fragment_uniform_buffer_0[28u].y;
				precise float fragment_unnamed_71 = fragment_unnamed_63 * fragment_uniform_buffer_0[28u].x;
				precise float fragment_unnamed_72 = fragment_unnamed_63 * fragment_uniform_buffer_0[28u].y;
				float fragment_unnamed_73 = asfloat(3212836864u);
				float fragment_unnamed_75 = asfloat(0u);
				float fragment_unnamed_80 = asfloat(asuint(fragment_uniform_buffer_0[29u]).x);
				precise float fragment_unnamed_81 = (-0.0f) - fragment_unnamed_69;
				precise float fragment_unnamed_83 = (-0.0f) - fragment_unnamed_70;
				precise float fragment_unnamed_84 = (-0.0f) - fragment_unnamed_72;
				precise float fragment_unnamed_100 = clamp(mad(fragment_unnamed_81, fragment_unnamed_80, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_101 = clamp(mad(fragment_unnamed_83, fragment_unnamed_80, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_102 = clamp(mad(fragment_unnamed_84, fragment_unnamed_75, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_103 = clamp(mad(fragment_unnamed_83, fragment_unnamed_80, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_104 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_100, fragment_unnamed_101));
				float4 fragment_unnamed_109 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_102, fragment_unnamed_103));
				precise float fragment_unnamed_118 = (-0.0f) - fragment_unnamed_71;
				precise float fragment_unnamed_119 = (-0.0f) - fragment_unnamed_70;
				precise float fragment_unnamed_131 = clamp(mad(fragment_unnamed_118, fragment_unnamed_73, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_132 = clamp(mad(fragment_unnamed_119, fragment_unnamed_80, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_133 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_131, fragment_unnamed_132));
				precise float fragment_unnamed_138 = mad(fragment_unnamed_109.x, 2.0f, fragment_unnamed_104.x) + fragment_unnamed_133.x;
				precise float fragment_unnamed_139 = mad(fragment_unnamed_109.y, 2.0f, fragment_unnamed_104.y) + fragment_unnamed_133.y;
				precise float fragment_unnamed_140 = mad(fragment_unnamed_109.z, 2.0f, fragment_unnamed_104.z) + fragment_unnamed_133.z;
				precise float fragment_unnamed_176 = clamp(mad(fragment_unnamed_69, fragment_unnamed_80, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_177 = clamp(mad(fragment_unnamed_70, fragment_unnamed_80, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_178 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_176, fragment_unnamed_177));
				precise float fragment_unnamed_186 = clamp(mad(fragment_unnamed_71, fragment_unnamed_73, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_187 = clamp(mad(fragment_unnamed_70, fragment_unnamed_80, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_188 = clamp(mad(fragment_unnamed_72, fragment_unnamed_75, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_189 = clamp(mad(fragment_unnamed_70, fragment_unnamed_80, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_193 = clamp(mad(fragment_unnamed_71, fragment_unnamed_73, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_194 = clamp(mad(fragment_unnamed_72, fragment_unnamed_75, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_195 = clamp(mad(fragment_unnamed_69, fragment_unnamed_80, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_196 = clamp(mad(fragment_unnamed_72, fragment_unnamed_75, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_197 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_193, fragment_unnamed_194));
				float4 fragment_unnamed_202 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_195, fragment_unnamed_196));
				float4 fragment_unnamed_217 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_186, fragment_unnamed_187));
				float4 fragment_unnamed_222 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_188, fragment_unnamed_189));
				precise float fragment_unnamed_227 = mad(fragment_unnamed_202.x, 2.0f, mad(fragment_unnamed_50.x, 4.0f, mad(fragment_unnamed_197.x, 2.0f, fragment_unnamed_138))) + fragment_unnamed_217.x;
				precise float fragment_unnamed_228 = mad(fragment_unnamed_202.y, 2.0f, mad(fragment_unnamed_50.y, 4.0f, mad(fragment_unnamed_197.y, 2.0f, fragment_unnamed_139))) + fragment_unnamed_217.y;
				precise float fragment_unnamed_229 = mad(fragment_unnamed_202.z, 2.0f, mad(fragment_unnamed_50.z, 4.0f, mad(fragment_unnamed_197.z, 2.0f, fragment_unnamed_140))) + fragment_unnamed_217.z;
				precise float fragment_unnamed_233 = fragment_unnamed_178.x + mad(fragment_unnamed_222.x, 2.0f, fragment_unnamed_227);
				precise float fragment_unnamed_234 = fragment_unnamed_178.y + mad(fragment_unnamed_222.y, 2.0f, fragment_unnamed_228);
				precise float fragment_unnamed_235 = fragment_unnamed_178.z + mad(fragment_unnamed_222.z, 2.0f, fragment_unnamed_229);
				precise float fragment_unnamed_236 = fragment_unnamed_233 * 0.0625f;
				precise float fragment_unnamed_238 = fragment_unnamed_234 * 0.0625f;
				precise float fragment_unnamed_239 = fragment_unnamed_235 * 0.0625f;
				precise float fragment_unnamed_244 = fragment_unnamed_236 * fragment_uniform_buffer_0[30u].w;
				precise float fragment_unnamed_245 = fragment_unnamed_238 * fragment_uniform_buffer_0[30u].w;
				precise float fragment_unnamed_246 = fragment_unnamed_239 * fragment_uniform_buffer_0[30u].w;
				precise float fragment_unnamed_252 = fragment_unnamed_244 * fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_253 = fragment_unnamed_245 * fragment_uniform_buffer_0[30u].y;
				precise float fragment_unnamed_254 = fragment_unnamed_246 * fragment_uniform_buffer_0[30u].z;
				fragment_output_0.x = fragment_unnamed_252;
				fragment_output_0.y = fragment_unnamed_253;
				fragment_output_0.z = fragment_unnamed_254;
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[29] = float4(_SampleScale, fragment_uniform_buffer_0[29][1], fragment_uniform_buffer_0[29][2], fragment_uniform_buffer_0[29][3]);

				fragment_uniform_buffer_0[30] = float4(_ColorIntensity[0], _ColorIntensity[1], _ColorIntensity[2], _ColorIntensity[3]);

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
			GpuProgramID 539531

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
			float _SampleScale;
			float4 _ColorIntensity;

			static float4 fragment_uniform_buffer_0[31];
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
				precise float fragment_unnamed_36 = fragment_uniform_buffer_0[28u].x * (-1.0f);
				precise float fragment_unnamed_38 = fragment_uniform_buffer_0[28u].y * (-1.0f);
				precise float fragment_unnamed_39 = fragment_uniform_buffer_0[28u].x * 1.0f;
				precise float fragment_unnamed_41 = fragment_uniform_buffer_0[28u].y * 1.0f;
				precise float fragment_unnamed_46 = fragment_uniform_buffer_0[29u].x * 0.5f;
				precise float fragment_unnamed_80 = clamp(mad(fragment_unnamed_36, fragment_unnamed_46, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_81 = clamp(mad(fragment_unnamed_41, fragment_unnamed_46, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_82 = clamp(mad(fragment_unnamed_39, fragment_unnamed_46, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_83 = clamp(mad(fragment_unnamed_41, fragment_unnamed_46, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_87 = clamp(mad(fragment_unnamed_36, fragment_unnamed_46, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_88 = clamp(mad(fragment_unnamed_38, fragment_unnamed_46, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_89 = clamp(mad(fragment_unnamed_39, fragment_unnamed_46, fragment_input_1.x), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				precise float fragment_unnamed_90 = clamp(mad(fragment_unnamed_38, fragment_unnamed_46, fragment_input_1.y), 0.0f, 1.0f) * fragment_uniform_buffer_0[26u].x;
				float4 fragment_unnamed_93 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_87, fragment_unnamed_88));
				float4 fragment_unnamed_98 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_89, fragment_unnamed_90));
				precise float fragment_unnamed_103 = fragment_unnamed_98.x + fragment_unnamed_93.x;
				precise float fragment_unnamed_104 = fragment_unnamed_98.y + fragment_unnamed_93.y;
				precise float fragment_unnamed_105 = fragment_unnamed_98.z + fragment_unnamed_93.z;
				float4 fragment_unnamed_106 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_80, fragment_unnamed_81));
				float4 fragment_unnamed_111 = _MainTex.Sample(sampler_MainTex, float2(fragment_unnamed_82, fragment_unnamed_83));
				precise float fragment_unnamed_116 = fragment_unnamed_103 + fragment_unnamed_106.x;
				precise float fragment_unnamed_117 = fragment_unnamed_104 + fragment_unnamed_106.y;
				precise float fragment_unnamed_118 = fragment_unnamed_105 + fragment_unnamed_106.z;
				precise float fragment_unnamed_119 = fragment_unnamed_111.x + fragment_unnamed_116;
				precise float fragment_unnamed_120 = fragment_unnamed_111.y + fragment_unnamed_117;
				precise float fragment_unnamed_121 = fragment_unnamed_111.z + fragment_unnamed_118;
				precise float fragment_unnamed_122 = fragment_unnamed_119 * 0.25f;
				precise float fragment_unnamed_124 = fragment_unnamed_120 * 0.25f;
				precise float fragment_unnamed_125 = fragment_unnamed_121 * 0.25f;
				precise float fragment_unnamed_130 = fragment_unnamed_122 * fragment_uniform_buffer_0[30u].w;
				precise float fragment_unnamed_131 = fragment_unnamed_124 * fragment_uniform_buffer_0[30u].w;
				precise float fragment_unnamed_132 = fragment_unnamed_125 * fragment_uniform_buffer_0[30u].w;
				precise float fragment_unnamed_138 = fragment_unnamed_130 * fragment_uniform_buffer_0[30u].x;
				precise float fragment_unnamed_139 = fragment_unnamed_131 * fragment_uniform_buffer_0[30u].y;
				precise float fragment_unnamed_140 = fragment_unnamed_132 * fragment_uniform_buffer_0[30u].z;
				fragment_output_0.x = fragment_unnamed_138;
				fragment_output_0.y = fragment_unnamed_139;
				fragment_output_0.z = fragment_unnamed_140;
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[26] = float4(_RenderViewportScaleFactor, fragment_uniform_buffer_0[26][1], fragment_uniform_buffer_0[26][2], fragment_uniform_buffer_0[26][3]);

				fragment_uniform_buffer_0[28] = float4(_MainTex_TexelSize[0], _MainTex_TexelSize[1], _MainTex_TexelSize[2], _MainTex_TexelSize[3]);

				fragment_uniform_buffer_0[29] = float4(_SampleScale, fragment_uniform_buffer_0[29][1], fragment_uniform_buffer_0[29][2], fragment_uniform_buffer_0[29][3]);

				fragment_uniform_buffer_0[30] = float4(_ColorIntensity[0], _ColorIntensity[1], _ColorIntensity[2], _ColorIntensity[3]);

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
