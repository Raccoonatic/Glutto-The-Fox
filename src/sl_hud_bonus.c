/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_hud_bonus.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/04/09 10:28:52 by lde-san-          #+#    #+#             */
/*   Updated: 2026/04/09 20:40:41 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../inc/solong_bonus.h"

static void	sl_counter_update(t_game *g, char *mov, char *arp, t_cord *c);

void	sl_apply_hud(t_game *game)
{
	t_cord	hud_frame;
	t_cord	counter;
	char	*moves;
	char	*arepas;

	sl_coordinate(&hud_frame, 7, game, 2);
	sl_push_tile_to_frame(game->cam.addr, game->hud.addr, hud_frame, 'R');
	moves = ft_itoa(game->moves);
	if (!moves)
		sl_kill_the_game(game, 0, 0, 2);
	arepas = ft_itoa(game->coins);
	if (!arepas)
	{
		free(moves);
		sl_kill_the_game(game, 0, 0, 2);
	}
	sl_counter_update(game, moves, arepas, &counter);
	free(moves);
	free(arepas);
	return;
}

static void	sl_counter_update(t_game *g, char *mov, char *arp, t_cord *c)
{
	static double	frame = 0.0;
	char			**faddr;
	int				guide;
	int				offy;
	
	guide = 0;
	faddr = g->font.frad;
	while(*mov || *arp)
	{
		offy = (int)(sin((frame) - (guide * 2.3)) * 4);
		if (*mov)
		{
			if (g->moves < 100)
				c->x = (guide * (FSZ + 3)) + 10;
			if (g->moves > 99)
				c->x = (guide * (FSZ + 4)) + 12;
			if (g->moves > 999)
				c->x = guide * (FSZ - 6);
			sl_coordinate(c, 8, g, offy);
			sl_push_tile_to_frame(g->cam.addr, faddr[(int)(*mov) - 48], *c, 'R');
			mov++;
		}
		if (*arp)
		{
			if (g->coins < 100)
				c->x = (guide * (FSZ + 3)) + 10;
			if (g->coins > 99)
				c->x = guide * (FSZ - 5);
			sl_coordinate(c, 9, g, offy);
			sl_push_tile_to_frame(g->cam.addr, faddr[(int)(*arp) - 38], *c, 'R');
			arp++;
		}
		guide++;
	}
	frame += 0.5;
	if (frame >= (2 * M_PI))
		frame -= (2 * M_PI);
	return ;
}
