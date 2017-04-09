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
m_ptr=SceneAdd(-120, 320, 240, "Terry's House", "Scenes/00.SCENE.GR", scenes);

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
m_ptr->mask->color=1;
GrRect(m_ptr->mask,0,436,m_ptr->mask->width-1,62);

m_ptr->mask->color=2;
GrRect(m_ptr->mask,0,416,114,48);
m_ptr->st_id[2]=2;
m_ptr->st_bx[2]=-544;
m_ptr->st_nx[2]=480;
m_ptr->st_ny[2]=320;

m_ptr->mask->color=3;
GrRect(m_ptr->mask,1164,416,76,48);
m_ptr->st_id[3]=0;
m_ptr->st_bx[3]=0;
m_ptr->st_nx[3]=70;
m_ptr->st_ny[3]=270;

// 02
m_ptr=SceneAdd(0, 0, 300, "Vegas Blvd", "Scenes/02.SCENE.GR", scenes);
m_ptr->mask->color=1;
GrRect(m_ptr->mask,0,436,m_ptr->mask->width-1,62);

m_ptr->mask->color=3;
GrRect(m_ptr->mask,1164,416,76,48);
m_ptr->st_id[3]=1;
m_ptr->st_bx[3]=0;
m_ptr->st_nx[3]=80;
m_ptr->st_ny[3]=290;

s_ptr=*scenes;
