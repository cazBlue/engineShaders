Shader "CallanW/Display VertColour" {
    SubShader {
        Pass {

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"			            
			
            struct v2f {
                float4 pos : SV_POSITION;
                fixed3 color : COLOR0;
            };
			

				
            v2f vert (appdata_full v)
            {
                v2f o;
                o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
                
                float4 light = float4(1.0, 1.0, 1.0, 1.0);
                
                light = normalize(light);
                                  
                // local normals converted to world : http://forum.unity3d.com/threads/rotating-normal-to-world-space.162056/           
                //built in values ref: http://docs.unity3d.com/462/Documentation/Manual/SL-BuiltinValues.html
                // _Object2World	~	float4x4	~	Current model matrix.
                                                        
                float lightDotVertNormal = dot(light, mul( _Object2World, float4(v.normal, 0.0)));
                
                
                  
                float atten = 10;
                
                o.color = v.color * clamp((lightDotVertNormal * atten), .6, atten); //clamp allows a minimum brightness
                
                //o.color = v.color;
                               
                
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return fixed4 (i.color, 1);
            }
            ENDCG			
        }
    }
}