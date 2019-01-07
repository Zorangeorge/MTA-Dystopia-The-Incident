// ped_wall.fx v0.1 Author Ren712

float4 sColorizePed = float4(1,1,1,1);
float sSpecularPower = 2;

//--------------------------------------------------------------------------------------
// Include some common stuff
//--------------------------------------------------------------------------------------
#include "mta-helper.fx"

//--------------------------------------------------------------------------------------
// Sampler Inputs
//--------------------------------------------------------------------------------------

sampler ColorSampler = sampler_state
{
    Texture = (gTexture0);
};


//---------------------------------------------------------------------
// Structure of data sent to the vertex shader
//---------------------------------------------------------------------
struct VSInput
{
    float4 Position : POSITION0;
    float3 Normal : NORMAL0;
    float2 TexCoord : TEXCOORD0;
};

//---------------------------------------------------------------------
// Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------
struct PSInput
{
    float4 Position : POSITION0;
    float2 TexCoord : TEXCOORD0;
    float SpecLighting : TEXCOORD1;
};

//------------------------------------------------------------------------------------------
// VertexShaderFunction
//------------------------------------------------------------------------------------------
PSInput VertexShaderFunction(VSInput VS)
{
    PSInput PS = (PSInput)0;
    float4 worldPosition = mul(float4(VS.Position.xyz, 1.0),gWorld);
    float4 worldViewPosition = mul(worldPosition,gView);
	
    worldViewPosition.xyz*= 0.075;
	
    PS.Position = mul(worldViewPosition,gProjection);
	
    // Pass through tex coords
    PS.TexCoord = VS.TexCoord;
	
    // Calc Specular
    float4 worldPos = mul(VS.Position, gWorld);
    float3 WorldNormal = MTACalcWorldNormal( VS.Normal ); 
    float3 h = normalize(normalize(gCameraPosition - worldPos.xyz) - normalize(gCameraDirection));
    PS.SpecLighting = saturate(pow(saturate(dot(WorldNormal,h)), sSpecularPower));

    return PS;
}

//------------------------------------------------------------------------------------------
// PixelShaderFunction
//------------------------------------------------------------------------------------------
float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    float4 color = sColorizePed;
	color.a*= tex2D(ColorSampler,PS.TexCoord).a;
    color*= saturate(1-PS.SpecLighting*2);
    if (color.a>0) {color.rgb = sColorizePed;}
       
    return color;
}

//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------
technique tec0
{
    pass P0
    {
        AlphaBlendEnable = TRUE;
        AlphaRef = 1;
        DepthBias = -0.0005;
        VertexShader = compile vs_2_0 VertexShaderFunction();
        PixelShader  = compile ps_2_0 PixelShaderFunction();
    }
}

// Fallback
technique fallback
{
    pass P0
    {
        // Just draw normally
    }
}
