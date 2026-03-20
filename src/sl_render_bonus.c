/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_render_bonus.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/16 17:29:23 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 15:13:17 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../inc/solong_bonus.h"

void		sl_clear_buffer(t_imgdata *img, int h);
void		sl_push_bkgrnd_to_frame(t_imgdata *d, t_imgdata *s);
void		sl_push_tile_to_frame(char *dst, char *src, t_cord c);
static void	sl_render_moves(t_game *g, char *prefix, int moves);

void	sl_main_render(t_game *g, t_imgdata *pst)
{
	t_cord	floor;
	t_cord	door;
	t_cord	plyr;

	sl_push_bkgrnd_to_frame(&g -> buf, &g -> bgr);
	sl_coordinate(&floor, 2, g, 0);
	if (g -> victory == 1)
	{
		sl_coordinate(&door, 4, g, 0);
		sl_push_tile_to_frame(g -> buf.addr, g -> d.addr, door);
		sl_push_tile_to_frame(g -> buf.addr, g -> gr.addr, floor);
		if (g -> plyr.x == g -> exit_x && g -> plyr.y == g -> exit_y)
			sl_win(g);
	}
	else
		sl_render_coins(g, &g -> ci, g -> ci.crnt_frm);
	sl_coordinate(&plyr, 3, g, 0);
	sl_push_tile_to_frame(g -> buf.addr, pst -> frad[pst -> crnt_frm], plyr);
	sl_render_enmy(g, g -> enmy);
	sl_push_tile_to_frame(g -> buf.addr, g -> gr.addr, floor);
	mlx_put_image_to_window(g -> mlx, g -> win, g -> buf.main, 0, 0);
	sl_render_moves(g, "Moves: ", g -> moves);
	mlx_do_sync(g -> mlx);
	return ;
}

void	sl_clear_buffer(t_imgdata *img, int h)
{
	char	*end;
	char	*start;

	start = img -> addr;
	end = (img -> addr) + (img -> bpr * h);
	while (start < end)
	{
		*(unsigned int *)start = 0x00000000;
		start += (img -> bpx / 8);
	}
	return ;
}

void	sl_push_tile_to_frame(char *dst, char *src, t_cord c)
{
	int		x;
	int		y;
	char	*d_ptr;
	char	*s_ptr;

	y = 0;
	if (!dst || !src)
		return ;
	while (y < c.th)
	{
		x = 0;
		while (x < c.tw)
		{
			s_ptr = src + (((y * c.tw) + x) * 4);
			d_ptr = dst + (((c.y + y) * c.fw + (c.x + x)) * 4);
			if (*(unsigned int *)s_ptr != 0x00FF00FF)
				*(unsigned int *)d_ptr = *(unsigned int *)s_ptr;
			x++;
		}
		y++;
	}
	return ;
}

static void	sl_render_moves(t_game *g, char *prefix, int moves)
{
	char	*num_char;
	char	*f_mssg;

	num_char = ft_itoa(moves);
	if (!num_char)
		return ;
	f_mssg = ft_strjoin(prefix, num_char);
	if (!f_mssg)
	{
		free(num_char);
		return ;
	}
	mlx_string_put(g -> mlx, g -> win, 10, 25, 0x37FA85, f_mssg);
	free(num_char);
	free(f_mssg);
	return ;
}

void	sl_push_bkgrnd_to_frame(t_imgdata *d, t_imgdata *s)
{
	int		max_w;
	int		max_h;
	char	*d_ptr;
	char	*s_ptr;

	max_h = d -> h;
	if (d -> h > s -> h)
		max_h = s -> h;
	max_h--;
	while (max_h >= 0)
	{
		max_w = d -> w;
		if (d -> w > s -> w)
			max_w = s -> w;
		max_w--;
		while (max_w >= 0)
		{
			d_ptr = d -> addr + (max_h * d -> bpr) + (max_w * (d -> bpx / 8));
			s_ptr = s -> addr + (max_h * s -> bpr) + (max_w * (s -> bpx / 8));
			*(unsigned int *)d_ptr = *(unsigned int *)s_ptr;
			max_w--;
		}
		max_h--;
	}
}
