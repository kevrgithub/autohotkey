IsInRange(value1, value2, range)
{
    If ((value1 >= (value2 - range)) && (value1 <= (value2 + range)))
    {
        Return, True
    }
    Else
    {
        Return, False
    }
}