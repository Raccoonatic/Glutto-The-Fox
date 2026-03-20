/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_coin_bonus.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/21 18:33:52 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 15:08:46 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../inc/solong_bonus.h"

void	ls_get_c_frm_idx(t_imgdata *c);

void	sl_render_coins(t_game *g, t_imgdata *coin, int index)
{
	char	**map;
	t_cord	c;
	int		y;
	int		x;

	map = g -> map;
	y = 0;
	while (map[y])
	{
		x = 0;
		while (map[y][x])
		{
			if (map[y][x] == 'C')
			{
				sl_coordinate(&c, 5, g, x * TSZ);
				c.y = y * TSZ;
				sl_push_tile_to_frame(g -> buf.addr, coin -> frad[index], c);
			}
			x++;
		}
		y++;
	}
	return ;
}

void	ls_get_c_frm_idx(t_imgdata *c)
{
	c -> crnt_frm++;
	if (c -> crnt_frm >= c -> mx_index)
		c -> crnt_frm = 0;
	return ;
}
