// Scene Scripts
//  placeholder: Scene Script is triggered when
//  use SceneObject with SceneTarget

  /*
     st_so_uid   uid of scene object to trigger SceneScript
     st_scr_id   id of SceneScript
     st_scr_msg  msg displayed when object used on target,
                 prior to trigger SceneScript
  */


U0 TargetOverlay(CDC *dc, CDC *s_mask, I64 bgs_x, I64 uid)
{
  switch (uid)
  {
    case 0x02:
      // individual device contexts for now, but ugly,
      // need to merge into one, blah.
      //   test adding destination mask, teleport to store
      GrBlot(dc,bgs_x+454,284,to_01);
      s_mask->color=6;
      GrRect(s_mask,454,284,154,80);
      break;
    default:
      break;
  };
}

U0 SceneScript(I64 script, GameState *gs, I64 target)
{
  switch (script)
  {
    case 0x01:

      // Test script placement Scene Object (nuggies)
      //gs->s_obj_uid[20]=5;
      //gs->s_obj_sid[20]=0;
      //gs->s_obj_x[20]=451;
      //gs->s_obj_y[20]=312;

      // Test SceneTarget Transition (closed/open garage)
      gs->s_tgt_uid[target]=2;
      //gs->
      
      break;
    default:
      break;
  }

};
