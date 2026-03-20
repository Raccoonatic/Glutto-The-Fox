/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_win.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/22 19:30:27 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 14:24:34 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../inc/solong.h"

static void	sl_win_loop(t_game *g, t_imgdata *img, int x, long long rec);

void	sl_win(t_game *g)
{
	char		*thanks;
	t_imgdata	*i;
	int			x;
	long long	rec;

	i = &g -> thnks;
	thanks = THXS;
	i -> main = mlx_xpm_file_to_image(g -> mlx, thanks, &i -> w, &i -> h);
	if (!i -> main)
		sl_kill_the_game(g, 1, 0, 0);
	i -> addr = mlx_get_data_addr(i -> main, &i -> bpx, &i -> bpr, &i -> e);
	x = (g -> w / 2) - (i -> w / 2);
	rec = sl_now();
	sl_win_loop(g, i, x, rec);
	sl_kill_the_game(g, 1, 0, 0);
}

static void	sl_win_loop(t_game *g, t_imgdata *img, int x, long long rec)
{
	int		middle_top;

	middle_top = (g -> h / 2) - (img -> h / 2);
	mlx_put_image_to_window(g -> mlx, g -> win, g -> buf.main, 0, 0);
	mlx_put_image_to_window(g -> mlx, g -> win, img -> main, x, middle_top);
	mlx_do_sync(g -> mlx);
	while (sl_now() - rec < 3000)
		continue ;
	return ;
}
