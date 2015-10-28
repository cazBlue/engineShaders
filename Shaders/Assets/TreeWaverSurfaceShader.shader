Shader "CallanW/Vertical Waver" {
SubShader {
    Pass {
        Fog { Mode Off }
        CGPROGRAM

        #pragma vertex vert
        #pragma fragment frag

		//TODO
		/// pass in variable to create wind directions
		//http://answers.unity3d.com/questions/132908/passing-a-float-from-script-to-shader.html


        // vertex input: position, UV
        struct appdata {
            float4 vertex : POSITION;
            float4 texcoord : TEXCOORD0;
        };

        struct v2f {
            float4 pos : SV_POSITION;
            float4 uv : TEXCOORD0;
        };
        
        v2f vert (appdata v) {
            v2f o;                                                         
            
            v.vertex.x += pow(clamp((v.texcoord.y - .2), 0, 1), 2) * (sin(_Time * 40) / 28);            
            
            o.pos = mul( UNITY_MATRIX_MVP, v.vertex );
            o.uv = float4( 0, v.texcoord.y, 0, 0 ); //used to check incoming UV                      
            
            return o;
        }
        
        half4 frag( v2f i ) : SV_Target {
            half4 c = frac( i.uv );
            if (any(saturate(i.uv) - i.uv))
                c.b = 0.5;
            return c;
        }
        
        ENDCG
    }
}
}