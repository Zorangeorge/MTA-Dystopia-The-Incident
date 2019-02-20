texture screenSource;

float blurStrength = 0;
float colorFadeValue = 0;

sampler ScreenSourceSampler = sampler_state
{
    Texture = (screenSource);
	MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    AddressU = Mirror;
    AddressV = Mirror;
};

const float2 offsets[24] = {
   -0.326212, -0.405805,
   -0.840144, -0.073580,
   -0.695914,  0.457137,
   -0.203345,  0.620716,
    0.962340, -0.194983,
    0.473434, -0.480026,
    0.519456,  0.767022,
    0.185461, -0.893124,
    0.507431,  0.064425,
    0.896420,  0.412458,
   -0.321940, -0.932615,
   -0.791559, -0.597705,
   -0.426212, -0.305805,
   -0.740144, -0.173580,
   -0.595914,  0.357137,
   -0.103345,  0.520716,
    0.762340, -0.294983,
    0.273434, -0.380026,
    0.319456,  0.667022,
    0.085461, -0.793124,
    0.407431,  0.164425,
    0.796420,  0.312458,
   -0.221940, -0.832615,
   -0.691559, -0.497705,
};

float4 BlurPixelShader(float2 texCoord : TEXCOORD) : COLOR0
{
	float4 mainColor = tex2D(ScreenSourceSampler, texCoord);

	for (int i = 0; i < 24; i++){
		mainColor += tex2D(ScreenSourceSampler, texCoord + (blurStrength / 1000) * offsets[i]);
	}
	
	mainColor /= 25;
	
	float4 bwColor = mainColor;
	float bwValue = (bwColor.r + bwColor.g + bwColor.b) / 3;
	bwColor.r = bwValue;
	bwColor.g = bwValue;
	bwColor.b = bwValue;
	
	float4 color = (bwColor * colorFadeValue) + (mainColor * (1 - colorFadeValue));
	color.rgb -= colorFadeValue / 16;
	
	return color;
}

technique BlurVH
{
    pass p0
    {
		AlphaBlendEnable = False;
        PixelShader = compile ps_2_0 BlurPixelShader();
    }
}

// Fallback
technique Fallback
{
    pass P0
    {
        // Just draw normally
    }
}