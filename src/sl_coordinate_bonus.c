/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_coordinate_bonus.c                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/18 21:41:33 by lde-san-          #+#    #+#             */
/*   Updated: 2026/04/09 20:38:08 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../inc/solong_bonus.h"

static void	sl_coordinate_beta(t_cord *vessel, int c_unit, t_game *g, int ctrl);

void	sl_coordinate(t_cord *vessel, int c_unit, t_game *g, int ctrl)
{
	if (c_unit == 1)
	{
		vessel -> fw = g -> w;
		vessel -> th = TSZ;
		vessel -> tw = TSZ;
		vessel -> x = ctrl;
	}
	else if (c_unit == 2)
	{
		vessel -> fw = g -> w;
		vessel -> th = g -> h;
		vessel -> tw = g -> w;
		vessel -> x = ctrl;
		vessel -> y = ctrl;
	}
	else if (c_unit == 6)
	{
		vessel -> fw = g -> w;
		vessel -> th = TSZ;
		vessel -> tw = TSZ;
	}
	sl_coordinate_beta(vessel, c_unit, g, ctrl);
	return ;
}

static void	sl_coordinate_beta(t_cord *vessel, int c_unit, t_game *g, int ctrl)
{
	if (c_unit == 3)
	{
		g->plyr.render_x += (((g->plyr.x * TSZ) - 40) - g->plyr.render_x) * 0.6;
		g->plyr.render_y += ((g->plyr.y * TSZ) - g->plyr.render_y) * 0.6;
		vessel -> fw = g -> w;
		vessel -> th = TSZ;
		vessel -> tw = PSZ;
		vessel -> x = (int)g -> plyr.render_x;
		vessel -> y = (int)g -> plyr.render_y;
	}
	else if (c_unit == 4)
	{
		vessel -> fw = g -> w;
		vessel -> th = DSZ;
		vessel -> tw = DSZ;
		vessel -> x = g -> exit_x * TSZ;
		vessel -> y = g -> exit_y * TSZ;
	}
	else if (c_unit == 5)
	{
		vessel -> fw = g -> w;
		vessel -> th = TSZ;
		vessel -> tw = CSZ;
		vessel -> x = ctrl + (CSZ / 2);
	}
	else if (c_unit == 7)
	{
		vessel -> fw = g_camw;
		vessel -> fh = g_camh;
		vessel -> tw = 307;
		vessel -> th = 178;
		vessel -> x = ctrl;
		vessel -> y = ctrl;
	}
	else if (c_unit == 8)
	{
		vessel -> fw = g_camw;
		vessel -> fh = g_camh;
		vessel -> tw = FSZ;
		vessel -> th = FSZ;
		vessel -> x += 102;
		vessel -> y = 33;
		vessel -> y -= ctrl;
	}
	else if (c_unit == 9)
	{
		vessel -> fw = g_camw;
		vessel -> fh = g_camh;
		vessel -> tw = FSZ;
		vessel -> th = FSZ;
		vessel -> x += 102;
		vessel -> y = 90;
		vessel -> y -= ctrl;
	}
	return ;
}
