// Scene Scripts
//  placeholder: Scene Script is triggered when
//  use SceneObject with SceneTarget

  /*
     st_so_uid   uid of scene object to trigger SceneScript
     st_scr_id   id of SceneScript
     st_scr_msg  msg displayed when object used on target,
                 prior to trigger SceneScript
  */


U0 TargetOverlay(Bool bg_layer, CDC *dc, CDC *s_mask, I64 bgs_x, I64 uid)
{
  switch (uid)
  {
    case 0x02:
      // individual device contexts for now, but ugly,
      // need to merge into one, blah.
      //   test adding destination mask, teleport to store
      s_mask->color=6;
      GrRect(s_mask,454,284,154,80);
      if (bg_layer)
      {    
        GrBlot(dc,bgs_x+454,284,to_01);
      }
      else {
        s_mask->color=6;
        GrRect(dc,bgs_x+454,284,154,80);
      };
      break;
    default:
      break;
  };
}

U0 SceneScript(I64 script, GameState *gs, I64 *st_so_uid, I64 *st_scr_id, I64 target)
{
  switch (script)
  {

    case ACT_OPEN:
      if (gs->s_tgt_uid[target]==1)
      {
        gs->s_tgt_uid[target]=2;
        st_so_uid[2]=ACT_CLOSE;
        st_scr_id[2]=ACT_CLOSE;
      };
      break;

    case ACT_CLOSE:
      if (gs->s_tgt_uid[target]==2)
      { 
        gs->s_tgt_uid[target]=1;
        st_so_uid[1]=ACT_OPEN;
        st_scr_id[1]=ACT_OPEN;
      };
      break;

    case 0x10:
      // Unlock Garage Door /w Gold Key
      st_so_uid[gs->s_tgt_uid[target]]=ACT_OPEN;
      st_scr_id[gs->s_tgt_uid[target]]=ACT_OPEN;
      break;

    default:
      break;
  };
};
