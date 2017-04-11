// Terrys Temple Quest

// scene_objects
//   unique_id (if 0, next free)
//   scene_id (if -1, inventory)
//   obj_x
//   obj_y

#define S_MAX_OBJ 512

class GameState {
  I64 scene_id;
  I64 player_x;
  I64 player_y;
  I64 walkto_x;
  I64 walkto_y;
  I64 walk_fdir;
  I64 walk_fseq;
  I64 bgscroll_x;
  I64 walk_dir;
  I64 s_obj_uid[S_MAX_OBJ];
  I64 s_obj_sid[S_MAX_OBJ];
  I64 s_obj_x[S_MAX_OBJ];
  I64 s_obj_y[S_MAX_OBJ];
};

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
  U8 song[512];
};

CDC *dc=DCNew(640,480);

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
  StrCpy(sc_new->song,"R");
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

U0 PlaySceneSong(U8 *song)
{
  while (TRUE)
  {
    Play(song);
  };
}

U0 LoadGameState(GameState *gs, U8 *state_file)
{
  // Load game state from GAME.STATE.Z
  I64 *state_load=FileRead(state_file);
  I64 so_ctr=0;
  I64 so_idx=9;
  gs->scene_id = state_load[0];
  gs->player_x = state_load[1];
  gs->player_y = state_load[2];
  gs->walkto_x = state_load[3];
  gs->walkto_y = state_load[4];
  gs->walk_fdir = state_load[5];
  gs->walk_fseq = state_load[6];
  gs->bgscroll_x = state_load[7];
  gs->walk_dir = state_load[8];
  while (so_ctr<S_MAX_OBJ)
  {
    gs->s_obj_uid[so_ctr] = state_load[so_idx];
    so_idx++; 
    gs->s_obj_sid[so_ctr] = state_load[so_idx];
    so_idx++; 
    gs->s_obj_x[so_ctr] = state_load[so_idx];
    so_idx++; 
    gs->s_obj_y[so_ctr] = state_load[so_idx];
    so_idx++; 
    so_ctr++;
  };
  Free(state_load);
}

U0 SaveGameState(U8 *state_file, GameState *gs)
{
  // Save game state to GAME.STATE.Z
  I64 *save_state=CAlloc(sizeof(GameState));
  I64 so_ctr=0;
  I64 so_idx=9;
  save_state[0]= gs->scene_id;
  save_state[1]= gs->player_x;
  save_state[2]= gs->player_y;
  save_state[3]= gs->walkto_x;
  save_state[4]= gs->walkto_y;
  save_state[5]= gs->walk_fdir;
  save_state[6]= gs->walk_fseq;
  save_state[7]= gs->bgscroll_x;
  save_state[8]= gs->walk_dir;
  while (so_ctr<S_MAX_OBJ)
  {
    save_state[so_idx]= gs->s_obj_uid[so_ctr];
    so_idx++; 
    save_state[so_idx]= gs->s_obj_sid[so_ctr];
    so_idx++; 
    save_state[so_idx]= gs->s_obj_x[so_ctr];
    so_idx++; 
    save_state[so_idx]= gs->s_obj_y[so_ctr];
    so_idx++; 
    so_ctr++;
  };
  FileWrite(state_file,save_state,sizeof(GameState));
  Free(save_state);
}

U0 DrawIt(CTask *task,CDC *tdc)
{
  task=task; //Suppress unused var warning
  GrBlot(tdc,0,0,dc);
}

U0 Run(I64 sfx_cpu=0,Bool load_state=FALSE)
{
  sfx_cpu=sfx_cpu; // Suppress unused var warning
  SettingsPush;
  U8 *doc=DocSave(DocPut);
  DocClear;
  WinBorder;
  WinMax;
  I64 so_ctr=0;

  GameState *gs=CAlloc(sizeof(GameState));

  if (load_state)
  {
    LoadGameState(gs,"GAME.STATE.Z");
  }
  else
  {
    gs->scene_id=0;
    gs->player_x=320;
    gs->player_y=240;
    gs->walkto_x=gs->player_x;
    gs->walkto_y=gs->player_y;
    gs->walk_dir=0;
    so_ctr=0;
    while (so_ctr<S_MAX_OBJ)
    {
      gs->s_obj_uid[so_ctr]=0;
      gs->s_obj_sid[so_ctr]=0;
      gs->s_obj_x[so_ctr]=0;
      gs->s_obj_y[so_ctr]=0;
      so_ctr++;
    };
  };

  #define ACT_WALK_TO	0x10
  #define ACT_PICK_UP	0x11
  #define ACT_TALK_TO	0x12
  #define ACT_INVENTORY	0x13
  #define ACT_OPEN	0x14
  #define ACT_CLOSE	0x15
  #define ACT_PUSH	0x16
  #define ACT_PULL	0x17

  #define WALK_SPEED 2

  Bool bg_layer=TRUE;

  I64 bnd_x1y1=0;
  I64 bnd_x2y2=0;
  I64 h_tc=0;
  I64 hud_row=0;
  I64 left_action=ACT_WALK_TO;
  I64 msg_code;
  I64 prev_bgx=0;
  I64 prev_px=0;
  I64 prev_py=0;
  I64 prev_timer=0;
  I64 scan_code=0;
  I64 scene_ctr=0;
  I64 snd_toggle=TRUE;

  CTask *SongTask=0;
  
  #include "Scenes";

  U8 f_charset[0x7F];

  StrCpy(f_charset," !\"#$$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~");
  GameFont *font_swash=LoadFont("Fonts/Swash.FONT.GR",12,9,52,83,19,f_charset);

  StrCpy(f_charset,"ABCDEFGHIJKLMNOPQRSTUVWXYZ    abcdefghijklmnopqrstuvwxyz '  0123456789  $$ !?#%&()\"*@");
  GameFont *font_berk=LoadFont("Fonts/Berkelium.FONT.GR",6,13,25,26,12,f_charset);

  s_ptr=*scenes;
  scene_ctr=0;
  while(scene_ctr<gs->scene_id)
  {
    s_ptr=s_ptr->next;
    scene_ctr++;
  };
  if (SongTask) { Kill(SongTask); };
  SndRst;
  if (snd_toggle) { SongTask=Spawn(&PlaySceneSong,s_ptr->song); }

  if (!load_state)
  {
    gs->bgscroll_x=s_ptr->init_x;
  };

  Fs->draw_it=&DrawIt;

  while (scan_code!=1)
  {
    scan_code=InU8(0x60);


    if (scan_code==0x26)
    { 
      LoadGameState(gs,"GAME.STATE.Z");
      s_ptr=*scenes;
      scene_ctr=0;
      while(scene_ctr<gs->scene_id)
      {
        s_ptr=s_ptr->next;
        scene_ctr++;
      };
      if (SongTask) { Kill(SongTask); };
      SndRst;
      if (snd_toggle) { SongTask=Spawn(&PlaySceneSong,s_ptr->song); }
    };

    // Debug: ENTER=toggle bg_layer
    if (scan_code==0x23) { bg_layer=!bg_layer; };


    // Toggle music and sound effects
    if (scan_code==0x32)
    { 
      snd_toggle=!snd_toggle;
      if (SongTask) { Kill(SongTask); };
      SndRst;
      if (snd_toggle) { SongTask=Spawn(&PlaySceneSong,s_ptr->song); }
    };

    // Arrow keys move player
    if (scan_code==0x4B) { gs->walkto_x= gs->player_x-WALK_SPEED*2; };
    if (scan_code==0x4D) { gs->walkto_x= gs->player_x+WALK_SPEED*2; };
    if (scan_code==0x48) { gs->walkto_y= gs->player_y-WALK_SPEED*2; };
    if (scan_code==0x50) { gs->walkto_y= gs->player_y+WALK_SPEED*2; };

    msg_code=ScanMsg(,,1<<MSG_MS_L_UP+1<<MSG_MS_R_UP);
    if (msg_code==MSG_MS_L_UP)
    {
      if (ms.pos.y>103)
      {
        if (left_action==ACT_WALK_TO)
        { 
          gs->walkto_x=(ms.pos.x-24)/WALK_SPEED*WALK_SPEED;
          gs->walkto_y=(ms.pos.y-24)/WALK_SPEED*WALK_SPEED;      
        };
      }
      else
      {
        if (ms.pos.y>57 && ms.pos.y<71)
        {
          if (ms.pos.x>237 && ms.pos.x<321)
          {
            left_action=ACT_WALK_TO;
          };
          if (ms.pos.x>346 && ms.pos.x<431)
          {
            left_action=ACT_TALK_TO;
          };
          if (ms.pos.x>479 && ms.pos.x<526)
          {
            left_action=ACT_OPEN;
          };
          if (ms.pos.x>563 && ms.pos.x<611)
          {
            left_action=ACT_PUSH;
          };
        };
        if (ms.pos.y>80 && ms.pos.y<95)
        {
          if (ms.pos.x>238 && ms.pos.x<321)
          {
            left_action=ACT_PICK_UP;
          };
          if (ms.pos.x>347 && ms.pos.x<454)
          {
            left_action=ACT_INVENTORY;
          };
          if (ms.pos.x>480 && ms.pos.x<538)
          {
            left_action=ACT_CLOSE;
          };
          if (ms.pos.x>561 && ms.pos.x<606)
          {
            left_action=ACT_PULL;
          };
        };
      }
    };

    prev_timer=SysTimerRead;    

    if (bg_layer)
    {
      GrBlot(dc,gs->bgscroll_x,0,s_ptr->bg);
    }
    else
    {
      GrBlot(dc,gs->bgscroll_x,0,s_ptr->mask);
      // Draw Walking BoundingBox
      dc->color=GREEN;
      GrRect(dc,gs->player_x+16,gs->player_y+132,40,16);
    };
  
    // HUD
    dc->color=BLUE;
    GrRect(dc,0,0,640,96);
    FontText(dc,font_swash,"Terry's Temple Quest",220,-24,LTCYAN,BLACK);

    if (left_action==ACT_WALK_TO)
    {
      h_tc=YELLOW;
    }
    else
    {
      h_tc=WHITE;
      if (ms.pos.y>57 && ms.pos.y<71)
      {
        if (ms.pos.x>237 && ms.pos.x<321)
        {
          h_tc=LTGREEN;
        };
      };
    };
    FontText(dc,font_berk,"Walk To",224+8,48,h_tc);

    if (left_action==ACT_PICK_UP)
    {
      h_tc=YELLOW;
    }
    else
    {
      h_tc=WHITE;
      if (ms.pos.y>80 && ms.pos.y<95)
      {
        if (ms.pos.x>238 && ms.pos.x<321)
        {
          h_tc=LTGREEN;
        };
      };
    };
    FontText(dc,font_berk,"Pick Up",224+8,70,h_tc);

    if (left_action==ACT_TALK_TO)
    {
      h_tc=YELLOW;
    }
    else
    {
      h_tc=WHITE;
      if (ms.pos.y>57 && ms.pos.y<71)
      {
        if (ms.pos.x>346 && ms.pos.x<431)
        {
          h_tc=LTGREEN;
        };
      };
    };
    FontText(dc,font_berk,"Talk To",332+8,48,h_tc);


    if (left_action==ACT_INVENTORY)
    {
      h_tc=YELLOW;
    }
    else
    {
      h_tc=WHITE;
      if (ms.pos.y>80 && ms.pos.y<95)
      {
        if (ms.pos.x>347 && ms.pos.x<454)
        {
          h_tc=LTGREEN;
        };
      };
    };
    FontText(dc,font_berk,"Inventory",332+8,70,h_tc);


    if (left_action==ACT_OPEN)
    {
      h_tc=YELLOW;
    }
    else
    {
      h_tc=WHITE;
      if (ms.pos.y>57 && ms.pos.y<71)
      {
        if (ms.pos.x>479 && ms.pos.x<526)
        {
          h_tc=LTGREEN;
        };
      };
    };
    FontText(dc,font_berk,"Open",464+8,48,h_tc);

    if (left_action==ACT_CLOSE)
    {
      h_tc=YELLOW;
    }
    else
    {
      h_tc=WHITE;
      if (ms.pos.y>80 && ms.pos.y<95)
      {
        if (ms.pos.x>480 && ms.pos.x<538)
        {
          h_tc=LTGREEN;
        };
      };
    };
    FontText(dc,font_berk,"Close",464+8,70,h_tc);

    if (left_action==ACT_PUSH)
    {
      h_tc=YELLOW;
    }
    else
    {
      h_tc=WHITE;
      if (ms.pos.y>57 && ms.pos.y<71)
      {
        if (ms.pos.x>563 && ms.pos.x<611)
        {
          h_tc=LTGREEN;
        };
      };
    };
    FontText(dc,font_berk,"Push",548+8,48,h_tc);

    if (left_action==ACT_PULL)
    {
      h_tc=YELLOW;
    }
    else
    {
      h_tc=WHITE;
      if (ms.pos.y>80 && ms.pos.y<95)
      {
        if (ms.pos.x>561 && ms.pos.x<606)
        {
          h_tc=LTGREEN;
        };
      };
    };
    FontText(dc,font_berk,"Pull",548+8,70,h_tc);

    dc->color=WHITE;
    GrPrint(dc,24,0,"旼컴컴컴컴컴컴컴컴컴컴커");
    hud_row=0;
    while (hud_row<10)
    {
      GrPrint(dc,24,8+(8*hud_row),"�");
      GrPrint(dc,208,8+(8*hud_row),"�");
      hud_row++;
    };
    GrPrint(dc,24,88,"읕컴컴컴컴컴컴컴컴컴컴켸");

    GrPrint(dc,30,8," Terry's Temple Quest");    

    GrPrint(dc,24+(8*1),32+(8*1), "S");
    GrPrint(dc,24+(8*1),32+(8*2), "h");
    GrPrint(dc,24+(8*1),32+(8*3), "a");
    GrPrint(dc,24+(8*1),32+(8*4), "s");
    GrPrint(dc,24+(8*1),32+(8*5), "t");
    GrPrint(dc,24+(8*1),32+(8*6), "a");
    GR96Blot(dc,14,-8,s_Terry,3,1,0);

    StrCpy(Fs->task_title,s_ptr->loc);
    GrPrint(dc,24+(8*8),32+(8*5),s_ptr->loc);

    //Debug
    GrPrint(dc,24+(8*6),32+(8*1),"ms.X1Y1: %d %d", -gs->bgscroll_x+ms.pos.x, ms.pos.y);

    GrPrint(dc,24+(8*8),32+(8*2),"BX: %d", gs->bgscroll_x);
    GrPrint(dc,24+(8*8),32+(8*3),"X1 Y1: %d %d", -gs->bgscroll_x+gs->player_x+16, gs->player_y+132);
    GrPrint(dc,24+(8*8),32+(8*4),"X2 Y2: %d %d", -gs->bgscroll_x+gs->player_x+16+39, gs->player_y+132+15);

    // Terry 
    GR96Blot(dc,gs->player_x,gs->player_y+52,s_Terry,gs->walk_fseq,0,gs->walk_dir);
    GR96Blot(dc,gs->player_x,gs->player_y,s_Terry,2,2,!gs->walk_dir);

    // Test Dianna Thumbnail Overlay
    GrBlot(dc,0,360,th_Dianna);

    bnd_x1y1 = GrPeek(s_ptr->mask, -gs->bgscroll_x+gs->player_x+16, gs->player_y+132);
    bnd_x2y2 = GrPeek(s_ptr->mask, -gs->bgscroll_x+gs->player_x+16+39, gs->player_y+132+15);

    if (gs->walkto_x != gs->player_x || gs->walkto_y != gs->player_y)
    {

      if (bnd_x1y1>0 && bnd_x2y2>0) 
      {
        if (bnd_x1y1>1 && bnd_x2y2>1)
        {
          gs->bgscroll_x=s_ptr->st_bx[bnd_x1y1];
          gs->player_x=s_ptr->st_nx[bnd_x1y1];
          gs->player_y=s_ptr->st_ny[bnd_x1y1];
          gs->scene_id=s_ptr->st_id[bnd_x1y1];
          gs->walkto_x=gs->player_x;
          gs->walkto_y=gs->player_y;
          prev_px=gs->player_x;
          prev_py=gs->player_y;
          prev_bgx=gs->bgscroll_x;
          s_ptr=*scenes;
          scene_ctr=0;
          while(scene_ctr<gs->scene_id)
          {
            s_ptr=s_ptr->next;
            scene_ctr++;
          };
          if (SongTask) { Kill(SongTask); };
          SndRst;
          if (snd_toggle) { SongTask=Spawn(&PlaySceneSong,s_ptr->song); }
        }
        else
        {
          prev_px=gs->player_x;
          prev_py=gs->player_y;
          prev_bgx=gs->bgscroll_x;

          if (gs->walkto_x < gs->player_x) { gs->walk_dir=1; gs->bgscroll_x+=2; gs->walkto_x+=2; };
          if (gs->walkto_x > gs->player_x) { gs->walk_dir=0; gs->bgscroll_x-=2; gs->walkto_x-=2; };

          if (gs->bgscroll_x>0) { gs->bgscroll_x=0; };
          if (640-gs->bgscroll_x>s_ptr->bg->width) { gs->bgscroll_x= (640-s_ptr->bg->width); };

          if (gs->walkto_x < gs->player_x) { gs->player_x -= WALK_SPEED; };
          if (gs->walkto_x > gs->player_x) { gs->player_x += WALK_SPEED; };
          if (gs->walkto_y < gs->player_y) { gs->player_y -= WALK_SPEED; };
          if (gs->walkto_y > gs->player_y) { gs->player_y += WALK_SPEED; };

          if (gs->walk_fdir==0) { gs->walk_fseq++; };
          if (gs->walk_fdir==1) { gs->walk_fseq--; };
        };
      } 
      else {
        gs->player_x=prev_px;
        gs->player_y=prev_py;
        gs->bgscroll_x=prev_bgx;
 
        gs->walkto_x=gs->player_x;
        gs->walkto_y=gs->player_y;  
      };
    };

    if (gs->walk_fseq>3) { gs->walk_fdir=1; };
    if (gs->walk_fseq<1) { gs->walk_fdir=0; };    

    while (SysTimerRead<prev_timer+(30000)) { Sleep(1); };
  };

  if (SongTask) { Kill(SongTask); };
  SndRst;

  SaveGameState("GAME.STATE.Z",gs);
  Free(gs);

  ScenesDel(scenes);
  Fs->draw_it=0;
  FreeFont(font_berk);
  FreeFont(font_swash);
  FreeChars;
  DCDel(dc);
  DocLoad(DocPut,doc,sizeof(doc));
  Free(doc);
  SettingsPop;
}
