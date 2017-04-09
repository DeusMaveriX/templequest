// Terrys Temple Quest

#include "Chars";

class Scene {
  Scene *next;
  I64 init_x;
  I64 t_x;
  I64 t_y;
  U8 loc[24];
  I64 st_id[16];
  I64 st_bx[16];
  I64 st_nx[16];
  I64 st_ny[16];
  CDC *bg;
  CDC *mask;
};

Scene *SceneAdd(I64 init_x, I64 t_x, I64 t_y, U8 *loc, U8 *bg_file, Scene *sc_head)
{
  I64 scx=0;
  Scene *sc_new = CAlloc(sizeof(Scene));
  sc_new->init_x=init_x;
  sc_new->t_x=t_x;
  sc_new->t_y=t_y;
  while (scx<16)
  {
    sc_new->st_id[scx]=0;
    sc_new->st_bx[scx]=0;
    sc_new->st_nx[scx]=0;
    sc_new->st_ny[scx]=0;
    scx++;
  };
  StrCpy(sc_new->loc,loc);
  sc_new->bg=GRRead(bg_file);
  sc_new->mask=DCNew(sc_new->bg->width,sc_new->bg->height);
  DCFill(sc_new->mask,0);
  sc_new->next=0;
  if (sc_head->next==0)
  { 
    sc_head->next=sc_new;
  } else
  {
    Scene *sc_cur=sc_head;
    while (TRUE) {
      if (sc_cur->next==0)
      {
        sc_cur->next=sc_new;
        break;
      };
      sc_cur=sc_cur->next;
    };
  };
  return sc_new;
}

U0 ScenesDel(Scene *_lst)
{
  Scene *tmps;
  while(_lst->next)
  {
    tmps=_lst;
    DCDel(_lst->mask);
    DCDel(_lst->bg);
    Free(_lst);
    _lst=tmps->next;
  };
  DCDel(_lst->mask);
  DCDel(_lst->bg);
  Free(_lst);
}

U0 Run()
{
  SettingsPush;
  WinBorder;
  WinMax;
  CDC *dc=DCAlias();
  I64 f=0;
  I64 fd=0;
  I64 hud_row=0;
  I64 r=0;
  I64 sc=0;
  I64 tr=0;

  I64 s_ctr=0;
  I64 t_id=0;
  I64 nx=320;
  I64 ny=240;
  I64 cx=nx;
  I64 cy=ny;
  I64 pb=0;
  I64 px=0;
  I64 py=0;
  Bool bg_layer=TRUE;

  I64 bnd_x1y1;
  I64 bnd_x2y2;
  I64 bx;
  I64 msg_code;

  #include "Scenes";

  bx=s_ptr->init_x;

  while (sc!=1)
  {
    sc=InU8(0x60);

    if (sc==0x1C) { bg_layer=!bg_layer; };

    msg_code=ScanMsg(,,1<<MSG_MS_L_UP+1<<MSG_MS_R_UP);
    if (msg_code==MSG_MS_L_UP)
    {
      cx=ms.pos.x-24;
      cy=ms.pos.y-24;      
    };

    tr=SysTimerRead;    

    if (bg_layer)
    {
      GrBlot(dc,bx,0,s_ptr->bg);
    }
    else
    {
      GrBlot(dc,bx,0,s_ptr->mask);
      // Draw Walking BoundingBox
      dc->color=GREEN;
      GrRect(dc,nx+16,ny+132,40,16);
    };
  
    // HUD
    dc->color=BLUE;
    GrRect(dc,24,24,96*2,96);
    dc->color=WHITE;
    GrPrint(dc,24,24,"旼컴컴컴컴컴컴컴컴컴컴커");
    hud_row=0;
    while (hud_row<10)
    {
      GrPrint(dc,24,32+(8*hud_row),"�");
      GrPrint(dc,208,32+(8*hud_row),"�");
      hud_row++;
    };
    GrPrint(dc,24,112,"읕컴컴컴컴컴컴컴컴컴컴켸");

    GrPrint(dc,30,32," Terry's Temple Quest");    

    GrPrint(dc,24+(8*1),32+(8*4), "S");
    GrPrint(dc,24+(8*1),32+(8*5), "h");
    GrPrint(dc,24+(8*1),32+(8*6), "a");
    GrPrint(dc,24+(8*1),32+(8*7), "s");
    GrPrint(dc,24+(8*1),32+(8*8), "t");
    GrPrint(dc,24+(8*1),32+(8*9), "a");
    GR96Blot(dc,14,16,s_Terry,3,1,0);

    StrCpy(Fs->task_title,s_ptr->loc);
    GrPrint(dc,24+(8*8),32+(8*9),s_ptr->loc);

    // Terry 
    //GrPrint(dc,24+(8*8),32+(8*6),"BX: %d", bx);
    //GrPrint(dc,24+(8*8),32+(8*7),"X1 Y1: %d %d", -bx+nx+16, ny+132);
    //GrPrint(dc,24+(8*8),32+(8*8),"X2 Y2: %d %d", -bx+nx+16+39, ny+132+15);

    GR96Blot(dc,nx,ny+52,s_Terry,f,0,r);
    GR96Blot(dc,nx,ny,s_Terry,2,2,!r);

    bnd_x1y1 = GrPeek(s_ptr->mask, -bx+nx+16, ny+132);
    bnd_x2y2 = GrPeek(s_ptr->mask, -bx+nx+16+39, ny+132+15);

    while (SysTimerRead<tr+(30000)) { Sleep(1); };

    if (cx != nx || cy != ny)
    {

      if (bnd_x1y1>0 && bnd_x2y2>0) 
      {
        if (bnd_x1y1>1 && bnd_x2y2>1)
        {
          bx=s_ptr->st_bx[bnd_x1y1];
          nx=s_ptr->st_nx[bnd_x1y1];
          ny=s_ptr->st_ny[bnd_x1y1];
          t_id=s_ptr->st_id[bnd_x1y1];
          cx=nx;
          cy=ny;
          px=nx;
          py=ny;
          pb=bx;
          s_ptr=*scenes;
          s_ctr=0;
          while(s_ctr<t_id)
          {
            s_ptr=s_ptr->next;
            s_ctr++;
          };
        }
        else
        {
          px=nx;
          py=ny;
          pb=bx;

          if (cx < nx) { r=1; bx+=2; cx+=2; };
          if (cx > nx) { r=0; bx-=2; cx-=2; };

          if (bx>0) { bx=0; };
          if (640-bx>s_ptr->bg->width) { bx= (640-s_ptr->bg->width); };

          if (cx < nx) { nx--; };
          if (cx > nx) { nx++; };
          if (cy < ny) { ny--; };
          if (cy > ny) { ny++; };

          if (fd==0) { f++; };
          if (fd==1) { f--; };
        };
      } 
      else {
        nx=px;
        ny=py;
        bx=pb;
 
        cx=nx;
        cy=ny;  
      };
    };

    if (f>3) { fd=1; };
    if (f<1) { fd=0; };    

  };

  ScenesDel(scenes);
  DCFill(dc,TRANSPARENT);
  FreeChars;
  DCDel(dc);
  SettingsPop;
}
