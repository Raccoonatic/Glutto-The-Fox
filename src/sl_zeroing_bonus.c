/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_zeroing_bonus.c                                 :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/19 20:21:05 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 15:17:56 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../inc/solong_bonus.h"

static void	sl_zero_img(t_game *game);
void		sl_null_ptrs(t_imgdata *i);
void		sl_zero_ints(t_imgdata *i, int e);

void	sl_zeroing(t_game *game)
{
	game -> mlx = NULL;
	game -> win = NULL;
	game -> map = NULL;
	game -> coins = 0;
	game -> victory = 0;
	game -> exit_y = 0;
	game -> exit_x = 0;
	game -> moves = 0;
	game -> plyr.grounded = 0;
	game -> plyr.on_e = 0;
	game -> plyr.state = IDLE;
	game -> time_stamp = sl_now();
	game -> ene_mv = sl_now();
	game -> enmy = NULL;
	sl_zero_img(game);
	return ;
}

static void	sl_zero_img(t_game *game)
{
	sl_null_ptrs(&game -> buf);
	sl_null_ptrs(&game -> bgr);
	sl_null_ptrs(&game -> pi);
	sl_null_ptrs(&game -> pj);
	sl_null_ptrs(&game -> ci);
	sl_null_ptrs(&game -> d);
	sl_null_ptrs(&game -> gr);
	sl_null_ptrs(&game -> thnks);
	sl_zero_ints(&game -> buf, 0);
	sl_zero_ints(&game -> bgr, 0);
	sl_zero_ints(&game -> pi, 0);
	sl_zero_ints(&game -> pj, 0);
	sl_zero_ints(&game -> ci, 0);
	sl_zero_ints(&game -> d, 0);
	sl_zero_ints(&game -> gr, 0);
	sl_zero_ints(&game -> thnks, 0);
	return ;
}

void	sl_null_ptrs(t_imgdata *i)
{
	i -> main = NULL;
	i -> addr = NULL;
	i -> frm = NULL;
	i -> frad = NULL;
	return ;
}

void	sl_zero_ints(t_imgdata *i, int e)
{
	i -> bpx = 0;
	i -> bpr = 0;
	i -> e = 0;
	i -> h = 0;
	i -> w = 0;
	i -> fbpx = 0;
	i -> fbpr = 0;
	i -> fe = 0;
	i -> mx_index = 0;
	i -> crnt_frm = 0;
	if (e == 1)
		i -> crnt_frm = sl_now() % 6;
	return ;
}
