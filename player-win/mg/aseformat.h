#ifndef ASEFORMAT
#define ASEFORMAT

#define ASE_FILE_MAGIC                      0xA5E0
#define ASE_FILE_FRAME_MAGIC                0xF1FA

#define ASE_FILE_FLAG_LAYER_WITH_OPACITY    1

#define ASE_FILE_CHUNK_FLI_COLOR2           4
#define ASE_FILE_CHUNK_FLI_COLOR            11
#define ASE_FILE_CHUNK_LAYER                0x2004
#define ASE_FILE_CHUNK_CEL                  0x2005
#define ASE_FILE_CHUNK_CEL_EXTRA            0x2006
#define ASE_FILE_CHUNK_COLOR_PROFILE        0x2007
#define ASE_FILE_CHUNK_EXTERNAL_FILE        0x2008
#define ASE_FILE_CHUNK_MASK                 0x2016
#define ASE_FILE_CHUNK_PATH                 0x2017
#define ASE_FILE_CHUNK_TAGS                 0x2018
#define ASE_FILE_CHUNK_PALETTE              0x2019
#define ASE_FILE_CHUNK_USER_DATA            0x2020
#define ASE_FILE_CHUNK_SLICES               0x2021 // Deprecated chunk (used on dev versions only between v1.2-beta7 and v1.2-beta8)
#define ASE_FILE_CHUNK_SLICE                0x2022
#define ASE_FILE_CHUNK_TILESET              0x2023

#define ASE_FILE_LAYER_IMAGE                0
#define ASE_FILE_LAYER_GROUP                1
#define ASE_FILE_LAYER_TILEMAP              2

#define ASE_FILE_RAW_CEL                    0
#define ASE_FILE_LINK_CEL                   1
#define ASE_FILE_COMPRESSED_CEL             2
#define ASE_FILE_COMPRESSED_TILEMAP         3

#define ASE_FILE_NO_COLOR_PROFILE           0
#define ASE_FILE_SRGB_COLOR_PROFILE         1
#define ASE_FILE_ICC_COLOR_PROFILE          2

#define ASE_COLOR_PROFILE_FLAG_GAMMA        1

#define ASE_PALETTE_FLAG_HAS_NAME           1

#define ASE_USER_DATA_FLAG_HAS_TEXT         1
#define ASE_USER_DATA_FLAG_HAS_COLOR        2
#define ASE_USER_DATA_FLAG_HAS_PROPERTIES   4

#define ASE_CEL_EXTRA_FLAG_PRECISE_BOUNDS   1

#define ASE_SLICE_FLAG_HAS_CENTER_BOUNDS    1
#define ASE_SLICE_FLAG_HAS_PIVOT_POINT      2

#define ASE_TILESET_FLAG_EXTERNAL_FILE      1
#define ASE_TILESET_FLAG_EMBEDDED           2
#define ASE_TILESET_FLAG_ZERO_IS_NOTILE     4

#define ASE_EXTERNAL_FILE_PALETTE           0
#define ASE_EXTERNAL_FILE_TILESET           1
#define ASE_EXTERNAL_FILE_EXTENSION         2
#define ASE_EXTERNAL_FILE_TILE_MANAGEMENT   3
#define ASE_EXTERNAL_FILE_TYPES             4

 
#define ASE_FILE_MAGIC                      0xA5E0
#define ASE_FILE_FRAME_MAGIC                0xF1FA
 
#define ASE_FILE_FLAG_LAYER_WITH_OPACITY     1
 
#define ASE_FILE_CHUNK_FLI_COLOR2           4
#define ASE_FILE_CHUNK_FLI_COLOR            11
#define ASE_FILE_CHUNK_LAYER                0x2004
#define ASE_FILE_CHUNK_CEL                  0x2005
#define ASE_FILE_CHUNK_MASK                 0x2016
#define ASE_FILE_CHUNK_PATH                 0x2017
#define ASE_FILE_CHUNK_FRAME_TAGS           0x2018
#define ASE_FILE_CHUNK_PALETTE              0x2019
#define ASE_FILE_CHUNK_USER_DATA            0x2020
 
#define ASE_FILE_RAW_CEL                    0
#define ASE_FILE_LINK_CEL                   1
#define ASE_FILE_COMPRESSED_CEL             2
 
#define ASE_LAYER_FLAG_VISIBLE              1
#define ASE_LAYER_FLAG_EDITABLE             2
#define ASE_LAYER_FLAG_LOCK_MOVEMENT        4
#define ASE_LAYER_FLAG_BACKGROUND           8
#define ASE_LAYER_FLAG_PREFER_LINKED_CELS   16
 
#define ASE_PALETTE_FLAG_HAS_NAME           1
 
#define ASE_USER_DATA_FLAG_HAS_TEXT         1
#define ASE_USER_DATA_FLAG_HAS_COLOR        2

typedef unsigned int uint32_t;
typedef unsigned short uint16_t;
typedef short int16_t;
typedef unsigned char uint8_t;

#pragma pack(1)
struct AsepriteHeader {
  //long pos;                 // TODO used by the encoder in app project

  uint32_t size;
  uint16_t magic;
  uint16_t frames;
  uint16_t width;
  uint16_t height;
  uint16_t depth;
  uint32_t flags;
  uint16_t speed;       // Deprecated, use "duration" of AsepriteFrameHeader
  uint32_t next;
  uint32_t frit;
  uint8_t transparent_index;
  uint8_t ignore[3];
  uint16_t ncolors;
  uint8_t pixel_width;
  uint8_t pixel_height;
  int16_t grid_x;
  int16_t grid_y;
  uint16_t grid_width;
  uint16_t grid_height;
};

struct AsepriteFrameHeader {
  uint32_t size;
  uint16_t magic;
  uint16_t chunks;
  uint16_t duration;
  uint8_t  future[2];
  uint32_t nchunks;
};

struct AsepriteChunk {
  uint32_t size;
  uint16_t type;
};

typedef struct {
uint16_t        Layer_index;// (see NOTE.2)
int16_t       X_position;//
int16_t       Y_position;//
uint8_t        Opacity_level;//
uint16_t        Cel_type;//
uint8_t     For_future[7];// (set to zero)
//+ For cel type = 0 (Raw Cel)
  uint16_t      Width_in_pixels;
  uint16_t      Height_in_pixels;
  //BYTE*     pixels;  
}ASE_CelChunk;

typedef struct{
uint16_t        Flags;
              /*1 = Visible
              2 = Editable
              4 = Lock movement
              8 = Background
              16 = Prefer linked cels
              32 = The layer group should be displayed collapsed
              64 = The layer is a reference layer*/
uint16_t        Layer_type;
              /*0 = Normal (image) layer
              1 = Group*/
uint16_t        Layer_child_level;// (see NOTE.1)
uint16_t        Default_layer_width_in_pixels;// (ignored)
uint16_t        Default_layer_height_in_pixels;// (ignored)
uint16_t        Blend_mode;/* (always 0 for layer set)
              Normal         = 0
              Multiply       = 1
              Screen         = 2
              Overlay        = 3
              Darken         = 4
              Lighten        = 5
              Color Dodge    = 6
              Color Burn     = 7
              Hard Light     = 8
              Soft Light     = 9
              Difference     = 10
              Exclusion      = 11
              Hue            = 12
              Saturation     = 13
              Color          = 14
              Luminosity     = 15
              Addition       = 16
              Subtract       = 17
              Divide         = 18*/
uint8_t        Opacity;
              //Note: valid only if file header flags field has bit 1 set
uint8_t        For_future[3];// (set to zero)
//char*       Layer_name;
}ASE_LayerChunk;

#pragma pack()

#endif