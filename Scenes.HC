/*
  Scenes are defined here.
  A Scene is a backdrop with a mask.
  Mask contains rects,
    Bounds clipped at color < 1
    color == 1 : Terry can walk here
    color > 1  : scene transition
                   _id : # of Scene
                   _bx : Scroll backdrop to -x
                   _nx : Terry X (on viewport)
                   _ny : Terry Y (on viewport)
*/

Scene *s_ptr;
Scene *m_ptr;
Scene *scenes=CAlloc(sizeof(Scene));

// 00
m_ptr=SceneAdd(-120, 320, 240, "Outside Terry's House", "Scenes/00.SCENE.GR", scenes);
StrCpy(m_ptr->song, "5qD4A5G4G5E4BeG5D4G5E5qD4A5G4G5E4BeG5D4G5E5q4AetB5E4Gq5CeEEsCECEqDetG4B5DE4G5C5q4AetB5E4Gq5CeEEsCECEqDetG4B5DE4G5C");

m_ptr->path->color=1;
GrRect(m_ptr->path,0,350,144,96);
GrRect(m_ptr->path,453,350,144,96);
GrRect(m_ptr->path,0,416,m_ptr->path->width-1,62);

m_ptr->path->color=2;
GrRect(m_ptr->path,77,306,76,68);
m_ptr->st_id[2]=1;
m_ptr->st_bx[2]=-544;
m_ptr->st_nx[2]=480;
m_ptr->st_ny[2]=320;

// test for open garage
m_ptr->st_id[6]=3;
//m_ptr->st_bx[2]=-544;
m_ptr->st_bx[6]=-160;
m_ptr->st_nx[6]=320;
m_ptr->st_ny[6]=300;


// 01
m_ptr=SceneAdd(0, 0, 300, "Asteroid Way", "Scenes/01.SCENE.GR", scenes);
StrCpy(m_ptr->song, "5M6/8q4Get5EDDG4GGqGeA5GsD4G5D4G5M6/8q4Get5EDDG4GGqGeA5GsD4G5D4G5qFs4B5C4B5CqGet4A5FDe4B5Cet4AG5CqC4B5qFs4B5C4B5CqGet4A5FDe4B5Cet4AG5CqC4B");

m_ptr->path->color=1;
GrRect(m_ptr->path,0,436,m_ptr->path->width-1,62);

m_ptr->path->color=2;
GrRect(m_ptr->path,0,416,114,48);
m_ptr->st_id[2]=2;
//m_ptr->st_bx[2]=-544;
m_ptr->st_bx[2]=-1024;
m_ptr->st_nx[2]=480;
m_ptr->st_ny[2]=320;

m_ptr->path->color=3;
GrRect(m_ptr->path,1164,416,76,48);
m_ptr->st_id[3]=0;
m_ptr->st_bx[3]=0;
m_ptr->st_nx[3]=70;
m_ptr->st_ny[3]=270;

// 02
//m_ptr=SceneAdd(0, 0, 300, "Vegas Blvd", "Scenes/02.SCENE.GR", scenes);
m_ptr=SceneAdd(0, 0, 300, "Green Valley Grocery", "Scenes/05.SCENE.GR", scenes);

StrCpy(m_ptr->song, "6M6/8qGetF5GBe.Bs6Cq5BAetG6C5B6M6/8qGetF5GBe.Bs6Cq5BAetG6C5B6eGGCCet5BGAe6GDqDs5B6D5B6DqGsCFCF6eGGCCet5BGAe6GDqDs5B6D5B6DqGsCFCF");

m_ptr->path->color=1;
GrRect(m_ptr->path,0,436,m_ptr->path->width-1,62);
GrLine(m_ptr->path,574,440,1143,312);
GrLine(m_ptr->path,1061,335,1147,311);
GrLine(m_ptr->path,1147,311,1299,310);
GrLine(m_ptr->path,1299,310,1589,440);
GrFloodFill(m_ptr->path,1123,332,TRUE);


m_ptr->path->color=2;
GrRect(m_ptr->path,881,331,80,32);

//GrLine(m_ptr->path,1143,312,1143,450);
//GrRect(m_ptr->path,960,430,240,96);
//m_ptr->path->color=3;
//GrRect(m_ptr->path,1164,416,76,48);

m_ptr->st_id[2]=0;
m_ptr->st_bx[2]=0;
m_ptr->st_nx[2]=70;
m_ptr->st_ny[2]=270;

// 03
m_ptr=SceneAdd(0,0, 300, "Terry'sGarage", "Scenes/06.SCENE.GR", scenes);
StrCpy(m_ptr->song, "2qGeEEs1B2E1B2EetCCRq1B2FCet1BAB2qGeEEs1B2E1B2EetCCRq1B2FCet1BAB2sDFDF1BBBBe2F1G2EDqE1AB2E2sDFDF1BBBBe2F1G2EDqE1AB2E");
m_ptr->path->color=1;
GrRect(m_ptr->path,0,430,960,96);
GrLine(m_ptr->path,92,435,170,389);
GrLine(m_ptr->path,170,389,170,356);
GrLine(m_ptr->path,170,356,238,317);
GrLine(m_ptr->path,238,317,350,311);
GrLine(m_ptr->path,350,311,435,306);
GrLine(m_ptr->path,435,306,518,305);
GrLine(m_ptr->path,518,305,521,280);
GrLine(m_ptr->path,521,280,547,282);
GrLine(m_ptr->path,547,282,550,253);
GrLine(m_ptr->path,550,253,630,258);
GrLine(m_ptr->path,630,258,633,278);
GrLine(m_ptr->path,633,278,665,283);
GrLine(m_ptr->path,665,283,671,300);
GrLine(m_ptr->path,671,300,702,304);
GrLine(m_ptr->path,702,304,727,320);
GrLine(m_ptr->path,727,320,753,310);
GrLine(m_ptr->path,753,310,827,349);
GrLine(m_ptr->path,827,349,831,368);
GrLine(m_ptr->path,831,368,959,420);
GrFloodFill(m_ptr->path,522,332,TRUE);

m_ptr->path->color=2;
GrRect(m_ptr->path,0,446,960,96);

m_ptr->st_id[2]=0;
m_ptr->st_bx[2]=-200;
m_ptr->st_nx[2]=320;
m_ptr->st_ny[2]=240;

// test for open kitchen door
m_ptr->st_id[6]=4;
//m_ptr->st_bx[2]=-544;
m_ptr->st_bx[6]=0;
m_ptr->st_nx[6]=320;
m_ptr->st_ny[6]=300;

// 04
m_ptr=SceneAdd(0,0, 300, "Terry's Giant Kitchen", "Scenes/07.SCENE.GR", scenes);
//StrCpy(m_ptr->song, "2qGeEEs1B2E1B2EetCCRq1B2FCet1BAB2qGeEEs1B2E1B2EetCCRq1B2FCet1BAB2sDFDF1BBBBe2F1G2EDqE1AB2E2sDFDF1BBBBe2F1G2EDqE1AB2E");
m_ptr->path->color=1;
GrRect(m_ptr->path,0,430,960,96);

m_ptr->path->color=2;
GrRect(m_ptr->path,0,446,960,96);

m_ptr->st_id[2]=3;
m_ptr->st_bx[2]=-220;
m_ptr->st_nx[2]=346;
m_ptr->st_ny[2]=146;


s_ptr=*scenes;
