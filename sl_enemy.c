/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_enemy.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/24 20:10:17 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 12:05:51 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "solong.h"

void			sl_render_enmy(t_game *g, t_emy **e);
static t_emy	**sl_emy_pos(t_emy **gang, char **m);
static void		sl_enemy_init(t_game *g, t_emy *en, t_imgdata *i);

t_emy	**sl_get_enemys(t_game *g, char **m)
{
	int		en_cnt;
	int		guide;
	t_emy	**gang;

	en_cnt = sl_count_tiles(m, g, 'X');
	if (!en_cnt)
		return (NULL);
	gang = ft_calloc(en_cnt + 1, sizeof(t_emy *));
	if (!gang)
		sl_kill_the_game(g, 0, 1, 1);
	gang[en_cnt] = NULL;
	guide = 0;
	while (guide < en_cnt)
	{
		gang[guide] = ft_calloc(1, sizeof(t_emy));
		if (!gang[guide])
			sl_kill_the_game(g, 0, 1, 1);
		sl_enemy_init(g, gang[guide], &gang[guide] -> en);
		guide++;
	}
	return (sl_emy_pos(gang, m));
}

void	sl_render_enmy(t_game *g, t_emy **e)
{
	int		guide;
	int		i;
	t_cord	c;

	guide = 0;
	if (!e)
		return ;
	sl_coordinate(&c, 6, g, 0);
	while (e[guide])
	{
		c.x = e[guide] -> x * TSZ;
		c.y = e[guide] -> y * TSZ;
		i = ++(e[guide] -> en.crnt_frm);
		if (i > 5)
		{
			e[guide] -> en.crnt_frm = 0;
			i = 0;
		}
		sl_push_tile_to_frame(g -> buf.addr, e[guide] -> en.frad[i], c);
		guide++;
	}
	return ;
}

static t_emy	**sl_emy_pos(t_emy **gang, char **m)
{
	int	guide;
	int	y;
	int	x;
	
	guide = 0;
	y = 0;
	while (gang[guide] && m[y])
	{
		x = 0;
		while (m[y][x])
		{
			if (m[y][x] == 'X')
			{
				gang[guide] -> x = x;
				gang[guide++] -> y = y;
				if (!gang[guide])
					return (gang);
			}
			x++;
		}
		y++;
	}
	return (gang);
}

static void	sl_enemy_init(t_game *g, t_emy *en, t_imgdata *i)
{
	sl_null_ptrs(i);
	sl_zero_ints(i, 1);
	i -> main = mlx_xpm_file_to_image(g -> mlx, ENMY, &i -> w, &i -> h);
	if (!i -> main)
		sl_kill_the_game(g, 0, 4, 1);
	sl_ani_init(g, i, TSZ);
	en -> march = sl_now() % 7;
	en -> dir = sl_now() % 4;
	return ;
}
