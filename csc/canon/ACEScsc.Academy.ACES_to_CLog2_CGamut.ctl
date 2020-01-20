
// <ACEStransformID>ACEScsc.ACES_to_CLog2_CGamut.a1.v1</ACEStransformID>
// <ACESuserName>ACES2065-1 to CLog2 CGamut</ACESuserName>

//
// ACES Color Space Conversion - ACES to CLog2 CGamut
//
// converts ACES2065-1 (AP0 w/ linear encoding) to 
//          Canon Log 2, Cinema Gamut
//



const float AP0_2_CGamut_MAT[3][3] = {
  { 1.310079315, -0.198398113, -0.111681202},
  {-0.003385627,  0.920234663,  0.083150964},
  { 0.009436126,  0.162159018,  0.828404856}
};



float lin_to_CLog2( input varying float in)
{
    float out;
    if ( in < 0 )
    {
        out = -0.24136077 * log10(1 - 87.099375 * in) + 0.092864125;
    }
    else
    {
        out = 0.24136077 * log10(87.099375 * in + 1) + 0.092864125;
    }
    return out;
}



void main
(   input varying float rIn,
    input varying float gIn,
    input varying float bIn,
    input varying float aIn,
    output varying float rOut,
    output varying float gOut,
    output varying float bOut,
    output varying float aOut
)
{
    float ACES[3] = { rIn, gIn, bIn};

    float lin_CGamut[3] = mult_f3_f33( ACES, AP0_2_CGamut_MAT);

    rOut = lin_to_CLog2( lin_CGamut[0] / 0.9);
    gOut = lin_to_CLog2( lin_CGamut[1] / 0.9);
    bOut = lin_to_CLog2( lin_CGamut[2] / 0.9);
    aOut = aIn;
}
