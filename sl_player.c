/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_player.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/21 20:58:45 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 12:27:31 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "solong.h"

void				sl_grounded_check(char **map, t_plyr *p, int y, int x);
void				sl_is_player_dead(t_game *g, t_emy **en, int py, int px);
static t_imgdata    *ls_get_pidx(t_game *g, t_state state);
t_imgdata			*ls_get_pst(t_game *g, int grnd, t_state *state);

void	sl_move_plyr(t_game *g, char **m, char ax, int mv)
{
	t_plyr	*p;
	char	swap;
	int		og_x;
	int		og_y;

	p = &g -> plyr;
	og_x = p -> x;
	og_y = p -> y;
	swap = '0';
	if (p -> on_e == 1)
		swap = 'E';
	if(ax == 'y' && m[p -> y + mv][p -> x] != '1')
		p -> y += mv;
	else if (ax == 'x' && m[p -> y][p -> x + mv] != '1')
		p -> x += mv;
	m[og_y][og_x] = swap;
	if (m[p -> y][p -> x] == 'E')
		p -> on_e = 1;
	else
		p -> on_e = 0;
	m[p -> y][p -> x] = 'P';
	if((ax == 'y' && m[og_y + mv][og_x] != '1')
		|| (ax == 'x' && m[og_y][og_x + mv] != '1'))
		racc_print(1, BABY"Moves:"MINT" %d \n", ++g -> moves);
	return ;	
}

t_imgdata   *ls_get_pst(t_game *g, int grnd, t_state *state)
{
	if(grnd && (((*state) == FLY || (*state) == JUMP) || ((*state) == LAND
		&& g -> pj.crnt_frm < 10)))
		*state = LAND;
	else if (grnd || g -> pj.crnt_frm >= 10)
		*state = IDLE;
	else if (!grnd && (((*state) != FLY && (*state) != JUMP)
		|| g -> pj.crnt_frm <= 2 || g -> pj.crnt_frm > 5))
		*state = JUMP;
	else
		*state = FLY;
	return (ls_get_pidx(g, *state));
}

static t_imgdata	*ls_get_pidx(t_game *g, t_state state)
{
	if (state == IDLE)
	{
		g -> pj.crnt_frm = 0;
		g -> pi.crnt_frm++;
		if (g -> pi.crnt_frm >= g -> pi.mx_index)
			g -> pi.crnt_frm = 0;
		return (&g -> pi);
	}
	g -> pj.crnt_frm++;
	if (state == FLY && g -> pj.crnt_frm > 5)
		g -> pj.crnt_frm = 3;
	return (&g -> pj);
}

void	sl_grounded_check(char **map, t_plyr *p, int y, int x)
{
	if (!map || !map[y])
		return ;
	if (map[y + 1][x] != '1')
		p -> grounded = 0;
	else 
		p -> grounded = 1;
	return ;
}

void	sl_is_player_dead(t_game *g, t_emy **en, int py, int px)
{
	int	guide;

	guide = 0;
	while(en[guide])
	{
		if (en[guide] -> x == px && en[guide] -> y == py)
			sl_kill_the_game(g, 1, 0, 0);
		guide++;
	}
	return ;
}
