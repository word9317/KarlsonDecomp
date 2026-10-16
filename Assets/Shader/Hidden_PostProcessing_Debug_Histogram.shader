Shader "Hidden/PostProcessing/Debug/Histogram"
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
			GpuProgramID 13664

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


			float2 _Params;

			static float4 vertex_uniform_buffer_0[29];
			Buffer<uint4> T0;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float2 vertex_output_1;
			static float vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				float vertex_output_1 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				uint vertex_unnamed_119 = max(T0.Load(22u).x, max(T0.Load(21u).x, max(T0.Load(20u).x, max(T0.Load(19u).x, max(T0.Load(18u).x, max(T0.Load(17u).x, max(T0.Load(16u).x, max(T0.Load(15u).x, max(T0.Load(14u).x, max(T0.Load(13u).x, max(T0.Load(12u).x, max(T0.Load(11u).x, max(T0.Load(10u).x, max(T0.Load(9u).x, max(T0.Load(8u).x, max(T0.Load(7u).x, max(T0.Load(6u).x, max(T0.Load(5u).x, max(T0.Load(4u).x, max(T0.Load(3u).x, max(T0.Load(2u).x, max(T0.Load(1u).x, T0.Load(0u).x))))))))))))))))))))));
				uint vertex_unnamed_210 = max(T0.Load(45u).x, max(T0.Load(44u).x, max(T0.Load(43u).x, max(T0.Load(42u).x, max(T0.Load(41u).x, max(T0.Load(40u).x, max(T0.Load(39u).x, max(T0.Load(38u).x, max(T0.Load(37u).x, max(T0.Load(36u).x, max(T0.Load(35u).x, max(T0.Load(34u).x, max(T0.Load(33u).x, max(T0.Load(32u).x, max(T0.Load(31u).x, max(T0.Load(30u).x, max(T0.Load(29u).x, max(T0.Load(28u).x, max(T0.Load(27u).x, max(T0.Load(26u).x, max(T0.Load(25u).x, max(T0.Load(24u).x, max(T0.Load(23u).x, vertex_unnamed_119)))))))))))))))))))))));
				uint vertex_unnamed_302 = max(T0.Load(68u).x, max(T0.Load(67u).x, max(T0.Load(66u).x, max(T0.Load(65u).x, max(T0.Load(64u).x, max(T0.Load(63u).x, max(T0.Load(62u).x, max(T0.Load(61u).x, max(T0.Load(60u).x, max(T0.Load(59u).x, max(T0.Load(58u).x, max(T0.Load(57u).x, max(T0.Load(56u).x, max(T0.Load(55u).x, max(T0.Load(54u).x, max(T0.Load(53u).x, max(T0.Load(52u).x, max(T0.Load(51u).x, max(T0.Load(50u).x, max(T0.Load(49u).x, max(T0.Load(48u).x, max(T0.Load(47u).x, max(T0.Load(46u).x, vertex_unnamed_210)))))))))))))))))))))));
				uint vertex_unnamed_394 = max(T0.Load(91u).x, max(T0.Load(90u).x, max(T0.Load(89u).x, max(T0.Load(88u).x, max(T0.Load(87u).x, max(T0.Load(86u).x, max(T0.Load(85u).x, max(T0.Load(84u).x, max(T0.Load(83u).x, max(T0.Load(82u).x, max(T0.Load(81u).x, max(T0.Load(80u).x, max(T0.Load(79u).x, max(T0.Load(78u).x, max(T0.Load(77u).x, max(T0.Load(76u).x, max(T0.Load(75u).x, max(T0.Load(74u).x, max(T0.Load(73u).x, max(T0.Load(72u).x, max(T0.Load(71u).x, max(T0.Load(70u).x, max(T0.Load(69u).x, vertex_unnamed_302)))))))))))))))))))))));
				uint vertex_unnamed_486 = max(T0.Load(114u).x, max(T0.Load(113u).x, max(T0.Load(112u).x, max(T0.Load(111u).x, max(T0.Load(110u).x, max(T0.Load(109u).x, max(T0.Load(108u).x, max(T0.Load(107u).x, max(T0.Load(106u).x, max(T0.Load(105u).x, max(T0.Load(104u).x, max(T0.Load(103u).x, max(T0.Load(102u).x, max(T0.Load(101u).x, max(T0.Load(100u).x, max(T0.Load(99u).x, max(T0.Load(98u).x, max(T0.Load(97u).x, max(T0.Load(96u).x, max(T0.Load(95u).x, max(T0.Load(94u).x, max(T0.Load(93u).x, max(T0.Load(92u).x, vertex_unnamed_394)))))))))))))))))))))));
				gl_Position.x = vertex_input_0.x;
				gl_Position.y = vertex_input_0.y;
				gl_Position.z = 0.0f;
				gl_Position.w = 1.0f;
				uint vertex_unnamed_589 = max(T0.Load(137u).x, max(T0.Load(136u).x, max(T0.Load(135u).x, max(T0.Load(134u).x, max(T0.Load(133u).x, max(T0.Load(132u).x, max(T0.Load(131u).x, max(T0.Load(130u).x, max(T0.Load(129u).x, max(T0.Load(128u).x, max(T0.Load(127u).x, max(T0.Load(126u).x, max(T0.Load(125u).x, max(T0.Load(124u).x, max(T0.Load(123u).x, max(T0.Load(122u).x, max(T0.Load(121u).x, max(T0.Load(120u).x, max(T0.Load(119u).x, max(T0.Load(118u).x, max(T0.Load(117u).x, max(T0.Load(116u).x, max(T0.Load(115u).x, vertex_unnamed_486)))))))))))))))))))))));
				uint vertex_unnamed_681 = max(T0.Load(160u).x, max(T0.Load(159u).x, max(T0.Load(158u).x, max(T0.Load(157u).x, max(T0.Load(156u).x, max(T0.Load(155u).x, max(T0.Load(154u).x, max(T0.Load(153u).x, max(T0.Load(152u).x, max(T0.Load(151u).x, max(T0.Load(150u).x, max(T0.Load(149u).x, max(T0.Load(148u).x, max(T0.Load(147u).x, max(T0.Load(146u).x, max(T0.Load(145u).x, max(T0.Load(144u).x, max(T0.Load(143u).x, max(T0.Load(142u).x, max(T0.Load(141u).x, max(T0.Load(140u).x, max(T0.Load(139u).x, max(T0.Load(138u).x, vertex_unnamed_589)))))))))))))))))))))));
				uint vertex_unnamed_773 = max(T0.Load(183u).x, max(T0.Load(182u).x, max(T0.Load(181u).x, max(T0.Load(180u).x, max(T0.Load(179u).x, max(T0.Load(178u).x, max(T0.Load(177u).x, max(T0.Load(176u).x, max(T0.Load(175u).x, max(T0.Load(174u).x, max(T0.Load(173u).x, max(T0.Load(172u).x, max(T0.Load(171u).x, max(T0.Load(170u).x, max(T0.Load(169u).x, max(T0.Load(168u).x, max(T0.Load(167u).x, max(T0.Load(166u).x, max(T0.Load(165u).x, max(T0.Load(164u).x, max(T0.Load(163u).x, max(T0.Load(162u).x, max(T0.Load(161u).x, vertex_unnamed_681)))))))))))))))))))))));
				uint vertex_unnamed_865 = max(T0.Load(206u).x, max(T0.Load(205u).x, max(T0.Load(204u).x, max(T0.Load(203u).x, max(T0.Load(202u).x, max(T0.Load(201u).x, max(T0.Load(200u).x, max(T0.Load(199u).x, max(T0.Load(198u).x, max(T0.Load(197u).x, max(T0.Load(196u).x, max(T0.Load(195u).x, max(T0.Load(194u).x, max(T0.Load(193u).x, max(T0.Load(192u).x, max(T0.Load(191u).x, max(T0.Load(190u).x, max(T0.Load(189u).x, max(T0.Load(188u).x, max(T0.Load(187u).x, max(T0.Load(186u).x, max(T0.Load(185u).x, max(T0.Load(184u).x, vertex_unnamed_773)))))))))))))))))))))));
				uint vertex_unnamed_957 = max(T0.Load(229u).x, max(T0.Load(228u).x, max(T0.Load(227u).x, max(T0.Load(226u).x, max(T0.Load(225u).x, max(T0.Load(224u).x, max(T0.Load(223u).x, max(T0.Load(222u).x, max(T0.Load(221u).x, max(T0.Load(220u).x, max(T0.Load(219u).x, max(T0.Load(218u).x, max(T0.Load(217u).x, max(T0.Load(216u).x, max(T0.Load(215u).x, max(T0.Load(214u).x, max(T0.Load(213u).x, max(T0.Load(212u).x, max(T0.Load(211u).x, max(T0.Load(210u).x, max(T0.Load(209u).x, max(T0.Load(208u).x, max(T0.Load(207u).x, vertex_unnamed_865)))))))))))))))))))))));
				uint vertex_unnamed_1049 = max(T0.Load(252u).x, max(T0.Load(251u).x, max(T0.Load(250u).x, max(T0.Load(249u).x, max(T0.Load(248u).x, max(T0.Load(247u).x, max(T0.Load(246u).x, max(T0.Load(245u).x, max(T0.Load(244u).x, max(T0.Load(243u).x, max(T0.Load(242u).x, max(T0.Load(241u).x, max(T0.Load(240u).x, max(T0.Load(239u).x, max(T0.Load(238u).x, max(T0.Load(237u).x, max(T0.Load(236u).x, max(T0.Load(235u).x, max(T0.Load(234u).x, max(T0.Load(233u).x, max(T0.Load(232u).x, max(T0.Load(231u).x, max(T0.Load(230u).x, vertex_unnamed_957)))))))))))))))))))))));
				vertex_output_1 = vertex_uniform_buffer_0[28u].y / float(max(T0.Load(255u).x, max(T0.Load(254u).x, max(T0.Load(253u).x, vertex_unnamed_1049))));
				vertex_output_1.x = mad(vertex_input_0.x + 1.0f, 0.5f, 0.0f);
				vertex_output_1.y = mad(vertex_input_0.y + 1.0f, -0.5f, 1.0f);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[28] = float4(_Params[0], _Params[1], vertex_uniform_buffer_0[28][2], vertex_uniform_buffer_0[28][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float2 _Params;

			static float4 fragment_uniform_buffer_0[29];
			Buffer<uint4> T0;

			static float2 fragment_input_1;
			static float fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				float fragment_input_1 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_29 = fragment_input_1.x * 255.0f;
				float fragment_unnamed_33 = frac(fragment_unnamed_29);
				uint fragment_unnamed_34 = uint(floor(fragment_unnamed_29));
				uint fragment_unnamed_70 = (mad(float(T0.Load(fragment_unnamed_34).x) * fragment_input_1, ((-0.0f) - fragment_unnamed_33) + 1.0f, fragment_unnamed_33 * (float(T0.Load(uint(min(float(fragment_unnamed_34 + 1u), 255.0f))).x) * fragment_input_1)) >= float(uint(round(fragment_input_1.y * fragment_uniform_buffer_0[28u].y)))) ? 4294967295u : 0u;
				fragment_output_0.x = asfloat(fragment_unnamed_70 & 1065353216u);
				fragment_output_0.y = asfloat(fragment_unnamed_70 & 1065353216u);
				fragment_output_0.z = asfloat(fragment_unnamed_70 & 1065353216u);
				fragment_output_0.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_Params[0], _Params[1], fragment_uniform_buffer_0[28][2], fragment_uniform_buffer_0[28][3]);

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
