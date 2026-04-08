/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_win_bonus.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/22 19:30:27 by lde-san-          #+#    #+#             */
/*   Updated: 2026/04/07 23:25:31 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../inc/solong_bonus.h"

static void	sl_win_loop(t_game *g, t_imgdata *img, int x);

void	sl_win(t_game *g)
{
	char		*thanks;
	t_imgdata	*i;
	int			x;

	i = &g -> thnks;
	thanks = THXS;
	i -> main = mlx_xpm_file_to_image(g -> mlx, thanks, &i -> w, &i -> h);
	if (!i -> main)
		sl_kill_the_game(g, 1, 0, 0);
	i -> addr = mlx_get_data_addr(i -> main, &i -> bpx, &i -> bpr, &i -> e);
	x = (g_camw / 2) - (i -> w / 2);
	sl_win_loop(g, i, x);
	sl_kill_the_game(g, 1, 42, 0);
}

static void	sl_win_loop(t_game *g, t_imgdata *img, int x)
{
	int		middle_top;
	double	y;

	middle_top = (g_camh / 2) - (img -> h / 2);
	y = g -> h + 1;
	while (y > middle_top)
	{
		mlx_put_image_to_window(g -> mlx, g -> win, g -> buf.main, 0, 0);
		mlx_put_image_to_window(g -> mlx, g -> win, img -> main, x, (int)y);
		mlx_do_sync(g -> mlx);
		y -= 1.2;
	}
	usleep(1500000);
	return ;
}
