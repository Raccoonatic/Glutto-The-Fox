/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_animation.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/21 14:20:55 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 12:05:48 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "solong.h"

void		sl_ani_init(t_game *g, t_imgdata *i, int f_w);
static void sl_move_enemy(t_game *g, char **m, t_emy **gang);
static void sl_march(t_emy *en, int *nxtx, int *nxty, int guide);
static void sl_change_enemy_direction(char **m, t_emy *e, int *nxtx, int *nxty);

int	sl_animate(t_game *g)
{
	sl_count_tiles(g -> map, g, 'C');
	if (g -> coins == 0)
		g -> victory = 1;
	if (g -> enmy)
		sl_is_player_dead(g, g -> enmy, g -> plyr.y, g -> plyr.x);
	if ((sl_now() - g -> time_stamp) > 120)
	{
		if (g -> enmy && ((sl_now() - g -> ene_mv) > 800))
			sl_move_enemy(g, g -> map, g -> enmy);
		g -> time_stamp = sl_now();
		sl_clear_buffer(g -> buf.main, g -> h);
		sl_grounded_check(g -> map, &g -> plyr, g -> plyr.y, g -> plyr.x);
		ls_get_c_frm_idx(&g -> ci);
		sl_main_render(g, ls_get_pst(g, g -> plyr.grounded, &g -> plyr.state));
	}
	return (0);
}

static void sl_march(t_emy *en, int *nxtx, int *nxty, int guide)
{
	if (++(en -> march) > ((sl_now() + *nxtx + *nxty + guide) % 5))
	{
		en -> march = 0;
		en -> dir = (sl_now() + *nxtx + *nxty + guide) % 4;
	}
	if (en -> dir == UP)
		(*nxty)--;
	else if (en -> dir == DO)
		(*nxty)++;
	else if (en -> dir == RT)
		(*nxtx)++;
	else if (en -> dir == LT)
		(*nxtx)--;
	return ;
}

static void sl_move_enemy(t_game *g, char **m, t_emy **gang)
{
	int			guide;
	int			nxtx;
	int			nxty;

	g -> ene_mv = sl_now();
	guide = 0;
	while(gang[guide])
	{
		nxtx = gang[guide] -> x;
		nxty = gang[guide] -> y;
		sl_march(gang[guide], &nxtx, &nxty, guide);
		if (m[nxty][nxtx] == '1')
		{
			nxtx = gang[guide] -> x;
			nxty = gang[guide] -> y;
			sl_change_enemy_direction(m, gang[guide], &nxtx, &nxty);
		}
		gang[guide] -> x = nxtx;
		gang[guide] -> y = nxty;
		guide++;
	}
	return ;
}

static void	sl_change_enemy_direction(char **m, t_emy *e, int *nxtx, int *nxty)
{
	int		tries;
	t_dir	direction;

	tries = 0;
	direction = e -> dir;
	while (tries < 4)
	{
		if (direction == UP && m[(*nxty) - 1][*nxtx] != '1')
			(*nxty)--;
		else if (direction == DO && m[(*nxty) + 1][*nxtx] != '1')
			(*nxty)++;
		else if (direction == RT && m[*nxty][(*nxtx) + 1] != '1')
			(*nxtx)++;
		else if (direction == LT && m[*nxty][(*nxtx) - 1] != '1')
			(*nxtx)--;
		else
		{
			direction = (sl_now() + e -> x + e -> y) % 4;
			tries++;
			continue;
		}
		break ;
	}
	e -> dir = direction;
	return ;
}

void	sl_ani_init(t_game *g, t_imgdata *i, int f_w)
{
	int frm_num;

	i -> addr = mlx_get_data_addr(i -> main, &i -> bpx, &i -> bpr, &i -> e);
	frm_num = i -> w / f_w;
	sl_ani_strip_alloc(g, frm_num, &i -> frm, &i -> frad);
	sl_strip_split(g, i, frm_num, f_w);
	i -> mx_index = frm_num;
	return ;
}
