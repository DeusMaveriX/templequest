/*
  Scenes are defined here.
  A Scene is a backdrop with a mask.
  Mask contains rects,
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
m_ptr=SceneAdd(-120, 320, 240, "Terry's House", "Scenes/00.SCENE.GR", scenes);
StrCpy(m_ptr->song, "5qD4A5G4G5E4BeG5D4G5E5qD4A5G4G5E4BeG5D4G5E5q4AetB5E4Gq5CeEEsCECEqDetG4B5DE4G5C5q4AetB5E4Gq5CeEEsCECEqDetG4B5DE4G5C");

m_ptr->mask->color=1;
GrRect(m_ptr->mask,0,350,144,96);
GrRect(m_ptr->mask,453,350,144,96);
GrRect(m_ptr->mask,0,416,m_ptr->mask->width-1,62);

m_ptr->mask->color=2;
GrRect(m_ptr->mask,77,306,76,68);
m_ptr->st_id[2]=1;
m_ptr->st_bx[2]=-544;
m_ptr->st_nx[2]=480;
m_ptr->st_ny[2]=320;

// 01
m_ptr=SceneAdd(0, 0, 300, "Asteroid Way", "Scenes/01.SCENE.GR", scenes);
StrCpy(m_ptr->song, "5M6/8q4Get5EDDG4GGqGeA5GsD4G5D4G5M6/8q4Get5EDDG4GGqGeA5GsD4G5D4G5qFs4B5C4B5CqGet4A5FDe4B5Cet4AG5CqC4B5qFs4B5C4B5CqGet4A5FDe4B5Cet4AG5CqC4B");

m_ptr->mask->color=1;
GrRect(m_ptr->mask,0,436,m_ptr->mask->width-1,62);

m_ptr->mask->color=2;
GrRect(m_ptr->mask,0,416,114,48);
m_ptr->st_id[2]=2;
//m_ptr->st_bx[2]=-544;
m_ptr->st_bx[2]=-1024;
m_ptr->st_nx[2]=480;
m_ptr->st_ny[2]=320;

m_ptr->mask->color=3;
GrRect(m_ptr->mask,1164,416,76,48);
m_ptr->st_id[3]=0;
m_ptr->st_bx[3]=0;
m_ptr->st_nx[3]=70;
m_ptr->st_ny[3]=270;

// 02
//m_ptr=SceneAdd(0, 0, 300, "Vegas Blvd", "Scenes/02.SCENE.GR", scenes);
m_ptr=SceneAdd(0, 0, 300, "Green Valley Grocery", "Scenes/05.SCENE.GR", scenes);

StrCpy(m_ptr->song, "6M6/8qGetF5GBe.Bs6Cq5BAetG6C5B6M6/8qGetF5GBe.Bs6Cq5BAetG6C5B6eGGCCet5BGAe6GDqDs5B6D5B6DqGsCFCF6eGGCCet5BGAe6GDqDs5B6D5B6DqGsCFCF");

m_ptr->mask->color=1;
GrRect(m_ptr->mask,0,436,m_ptr->mask->width-1,62);
GrLine(m_ptr->mask,574,440,1143,312);
GrLine(m_ptr->mask,1061,335,1147,311);
GrLine(m_ptr->mask,1147,311,1299,310);
GrLine(m_ptr->mask,1299,310,1589,440);
GrFloodFill(m_ptr->mask,1123,332,TRUE);


m_ptr->mask->color=2;
GrRect(m_ptr->mask,881,331,80,32);

//GrLine(m_ptr->mask,1143,312,1143,450);
//GrRect(m_ptr->mask,960,430,240,96);
//m_ptr->mask->color=3;
//GrRect(m_ptr->mask,1164,416,76,48);

m_ptr->st_id[3]=1;
m_ptr->st_bx[3]=0;
m_ptr->st_nx[3]=80;
m_ptr->st_ny[3]=290;

s_ptr=*scenes;
