OnGround = true;

switch (ZoomState)
{
    // Not progressing or recovering
    case "Null":
    {
        if (AirTimer >= 0 && AirTimer <= AirTimerStart)
        {
            AirTimer = AirTimerStart;
        }
        break;
    }
    
    // Progressing / Zooming out
    case "Progress":
    {
        AirTimer = 2.5 * AirTimerStart;
        ZoomState = "Recover";
        break;
    }
    
    // Recovering / Zooming in
    case "Recover":
    {
        break;
    }
}

