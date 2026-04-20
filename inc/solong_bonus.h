/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   solong_bonus.h                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/04 17:21:23 by lde-san-          #+#    #+#             */
/*   Updated: 2026/04/20 14:08:17 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef SOLONG_BONUS_H
# define SOLONG_BONUS_H

// Includes:
# include "./libft/includes/get_next_line_bonus.h"
# include "./libft/includes/libft.h"
# include "./mlx_linux/mlx.h"
# include <sys/time.h>
# include <unistd.h>
# include <stdlib.h>
# include <string.h>
# include <fcntl.h>
# include <stdio.h>
# include <math.h>

// Text Color:
# define RSET	"\033[0m" 
# define B_WI	"\033[1;37m"
# define LIME	"\033[38;2;0;255;0m"
# define BABY	"\033[1;38;2;0;255;247m"
# define BLOD	"\033[1;38;2;255;0;0m"
# define PURP	"\033[1;38;2;174;5;252m"
# define MINT	"\033[1;38;2;55;250;133m"
# define NEOR	"\033[3m\033[1;38;2;255;153;51m"

// Tile size definition:
# define TSZ	96
# define PSZ	168
# define CSZ	48
# define DSZ	108
# define FSZ	49

// Textures Path:
# ifndef BKND
#  define BKND	"./textures/Herculy.xpm"
# endif
# define HUDF	"./textures/HUD/hud.xpm"
# define FONT	"./textures/HUD/fonts.xpm"
# define THXS	"./textures/Thanks.xpm"
# define GRND	"./textures/floor.xpm"
# define PLYI	"./textures/fox_idle.xpm"
# define PLYJ   "./textures/fox_jump.xpm"
# define COIN	"./textures/coin.xpm"
# define DOOR	"./textures/door.xpm"
# define ENMY	"./textures/enemy_fly.xpm"

extern int	g_camw;
extern int	g_camh;

// Data type definitions
typedef enum e_keys
{
	K_W = 119,
	K_A = 97,
	K_S = 115,
	K_D = 100,
	K_ESC = 65307,
	K_LFT = 65361,
	K_RGT = 65363,
	K_UP = 65362,
	K_DOW = 65364
}	t_keys;

typedef enum e_dir
{
	UP,
	RT,
	DO,
	LT
}	t_dir;

typedef enum e_state
{
	IDLE,
	JUMP,
	FLY,
	LAND
}	t_state;

typedef struct s_plyr
{
	int		y;
	int		x;
	int		grounded;
	int		on_e;
	char	facing;
	double	render_x;
	double	render_y;
	t_state	state;
}	t_plyr;

typedef struct s_cord
{
	int	fh;
	int	fw;
	int	th;
	int	tw;
	int	x;
	int	y;
}	t_cord;

typedef struct s_cam
{
	void	*pov;
	char    *addr;
	int     bpx;
	int     bpr;
	int     e;
	int     x;
	int     y;
} 	t_cam;

typedef struct s_imgdata
{
	void	*main;
	char	*addr;
	int		bpx;
	int		bpr;
	int		e;
	int		h;
	int		w;
	void	**frm;
	char	**frad;
	int		fbpx;
	int		fbpr;
	int		fe;
	int		mx_index;
	int		crnt_frm;
}	t_imgdata;

typedef struct s_emy
{
	t_imgdata	en;
	t_dir		dir;
	int			march;
	int			y;
	int			x;
	char		facing;
	double		render_x;
	double      render_y;
}	t_emy;

typedef struct s_game
{
	void		*mlx;
	void		*win;
	char		*theme;
	char		**map;
	int			h;
	int			w;
	int			coins;
	int			victory;
	int			exit_y;
	int			exit_x;
	int			moves;
	t_cam		cam;
	t_imgdata	buf;
	t_imgdata	bgr;
	t_imgdata	pi;
	t_imgdata	pj;
	t_imgdata	ci;
	t_imgdata	d;
	t_imgdata	gr;
	t_imgdata	thnks;
	t_imgdata	hud;
	t_imgdata	font;
	t_plyr		plyr;
	t_emy		**enmy;
	long long	time_stamp;
	long long	ene_mv;
}	t_game;

//			Function Prototypes:
// -- -- #	sl_flood_fill_bonus.c			# -- -- //
char		**sl_path_check(char **map, t_game *game);
// -- -- #	sl_map_init_utils_bonus.c		# -- -- //
char		sl_flast_char(char *str);
int			sl_count_rows(char **map);
int			sl_count_tiles(char **map, t_game *game, char tile);
// -- -- #	sl_text_to_map_bonus.c		# -- -- //
char		**sl_text_to_map(char *map_path);
// -- -- #	sl_layer_init_bonus.c			# -- -- //
void		sl_layer_init(t_game *g, int *bpx, int *bpr, int *e);
// -- -- #	sl_exit_game_bonus.c			# -- -- //
void		sl_fail(int err_code, int exit_code, char *err_msg);
void		sl_kill_the_game(t_game *game, int good, int err_cd, int exit_cd);
// -- -- #	sl_check_map_bonus.c			# -- -- //
char		**sl_check_map(char **map_file, t_game *game);
// -- -- #	sl_render_bonus.c				# -- -- //
void		sl_clear_buffer(t_imgdata *img, int h);
void		sl_apply_camera_lens(t_game *g);
void		sl_main_render(t_game *game, t_imgdata *pst);
void		sl_push_bkgrnd_to_frame(t_imgdata *d, t_imgdata *s);
void		sl_push_tile_to_frame(char *dst, char *src, t_cord c, char facing);
// -- -- #	sl_terrain_bonus.c			# -- -- //
void		sl_build_terrain(t_game *g, char **map, t_imgdata *t);
void		sl_blackpink(t_imgdata *img, int h);
// -- -- #	sl_zeroing_bonus.c			# -- -- //
void		sl_zeroing(t_game *game);
void		sl_null_ptrs(t_imgdata *i);
void		sl_zero_ints(t_imgdata *i, int e);
// -- -- #	sl_sprite_handling_bonus.c	# -- -- //
void		sl_strip_split(t_game *g, t_imgdata *i, int f_num, int f_w, int f_h);
void		sl_ani_strip_alloc(t_game *g, int f_num, void ***img, char ***addr);
// -- -- #	sl_coordinate_bonus.c			# -- -- //
void		sl_coordinate(t_cord *vessel, int c_unit, t_game *g, int ctrl);
// -- -- #	sl_destroy_bonus.c			# -- -- //
void		sl_frink(t_game *g);
void		sl_free_matrix(char **matrix);
// -- -- #	sl_door_bonus.c				# -- -- //
void		sl_get_door_pos(char **map, int *y, int *x);
// -- -- #  sl_coin_bonus.c               # -- -- //
void		sl_render_coins(t_game *g, t_imgdata *coin, int index);
void		ls_get_c_frm_idx(t_imgdata *c);
// -- -- #  sl_player_bonus.c				# -- -- //
void		sl_move_plyr(t_game *g, char **m, char ax, int mv);
void		sl_grounded_check(char **map, t_plyr *p, int y, int x);
void		sl_is_player_dead(t_game *g, t_emy **en, double py, double px);
t_imgdata	*ls_get_pst(t_game *g, int grnd, t_state *state);
// -- -- #  sl_time_bonus.c				# -- -- //
long long	sl_now(void);
// -- -- #  sl_animation_bonus.c			# -- -- //
int			sl_animate(t_game *g);
void		sl_ani_init(t_game *g, t_imgdata *i, int f_w, int f_h);
// -- -- #  sl_enemy_bonus.c				# -- -- //
t_emy		**sl_get_enemys(t_game *g, char **m);
void		sl_render_enmy(t_game *g, t_emy **e);
// -- -- #  sl_win_bonus.c				# -- -- //
void		sl_win(t_game *g);
// -- -- #	sl_hud_bonus.c              # -- -- //
void		sl_apply_hud(t_game *game);
#endif
