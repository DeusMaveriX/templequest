// Scene Scripts
//  placeholder: Scene Script is triggered when
//  use SceneObject with SceneTarget

  /*
     st_so_uid   uid of scene object to trigger SceneScript
     st_scr_id   id of SceneScript
     st_scr_msg  msg displayed when object used on target,
                 prior to trigger SceneScript
  */

U0 SceneScript(I64 script, GameState *gs)
{
  switch (script)
  {
    case 0x01:

      // Test script placement Scene Object (nuggies)
      gs->s_obj_uid[20]=5;
      gs->s_obj_sid[20]=0;
      gs->s_obj_x[20]=451;
      gs->s_obj_y[20]=312;
      
      break;
    default:
      break;
  }

};
