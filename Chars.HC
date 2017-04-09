CDC *s_Terry=GRRead("Chars/Terry.CHAR.GR");

U0 FreeChars()
{
  DCDel(s_Terry);
}

U0 GR96Blot(CDC *dc, I64 dc_x, I64 dc_y, 
               CDC *GR, I64 gr96_x, I64 gr96_y, Bool r)
{
  CDC *GR96=DCNew(96,96);
  DCFill(GR96, TRANSPARENT);
  GrBlot(GR96, -(gr96_x*96), -(gr96_y*96), GR);
  switch(r)
  {
    case TRUE:
      CSprite *s=DC2Sprite(GR96);
      Sprite3YB(dc, 72+dc_x, dc_y, 0, s, 179);
      Free(s);
      break;
    case FALSE:
      GrBlot(dc, dc_x, dc_y, GR96);
      break;
  };
  DCDel(GR96);
}  