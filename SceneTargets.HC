// Scene Targets
//  placeholder: use SceneObject with SceneTarget


// open/close target: uid=-2/-3?

#define ST_OPEN   -2
#define ST_CLOSE  -3


st_width[1]=142; st_height[1]=58;
st_charx[1]=0; st_chary[1]=0;

if (gs->st_so_uid[1]==0)
{
  gs->st_so_uid[1]=4; gs->st_scr_id[1]=0x10;
};
// garage door locked
StrCpy(st_desc+(1*SO_MAX_DESC), "Garage Door");
StrCpy(st_scr_msg+(1*SO_MAX_SMSG),"You use the Gold Key on the\nGarage Door, and it unlocks.");

st_width[2]=142; st_height[2]=58;
st_charx[2]=0; st_chary[2]=0;
if (gs->st_so_uid[2]==0)
{
  gs->st_so_uid[2]=0; gs->st_scr_id[2]=0;
};
// garage door unlocked
StrCpy(st_desc+(2*SO_MAX_DESC), "Garage Door");
StrCpy(st_scr_msg+(2*SO_MAX_SMSG),"");

