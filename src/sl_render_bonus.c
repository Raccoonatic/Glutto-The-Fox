/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_render_bonus.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/16 17:29:23 by lde-san-          #+#    #+#             */
/*   Updated: 2026/04/09 21:00:18 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../inc/solong_bonus.h"

void		sl_clear_buffer(t_imgdata *img, int h);
void		sl_push_bkgrnd_to_frame(t_imgdata *d, t_imgdata *s);
void		sl_push_tile_to_frame(char *dst, char *src, t_cord c, char facing);
static void	sl_apply_camera_lens(t_game *g);
static int	sl_check_for_winner(t_game *g, t_cord *door, t_cord *floor);
static void	sl_get_render_coords(t_game *g, t_cord *floor, t_cord *plyr, t_cord *door);

void	sl_main_render(t_game *g, t_imgdata *pst)
{
	t_cord	floor;
	t_cord	door;
	t_cord	plyr;

	sl_push_bkgrnd_to_frame(&g -> buf, &g -> bgr);
	sl_get_render_coords(g, &floor, &plyr, &door);
	if (sl_check_for_winner(g, &door, &floor))
		sl_render_coins(g, &g -> ci, g -> ci.crnt_frm);
	sl_push_tile_to_frame(g -> buf.addr, pst -> frad[pst -> crnt_frm], plyr, g->plyr.facing);
	sl_render_enmy(g, g -> enmy);
	sl_push_tile_to_frame(g -> buf.addr, g -> gr.addr, floor, 'R');
	sl_apply_camera_lens(g);
	sl_apply_hud(g);
	mlx_put_image_to_window(g -> mlx, g -> win, g -> cam.pov, 0, 0);
	if (g->enmy)
		sl_is_player_dead(g, g -> enmy, g -> plyr.render_y, g -> plyr.render_x);
	mlx_do_sync(g -> mlx);
	return ;
}

static int	sl_check_for_winner(t_game *g, t_cord *door, t_cord *floor)
{
	if (g -> victory == 1)
	{
		sl_push_tile_to_frame(g -> buf.addr, g -> d.addr, *door, 'R');
		sl_push_tile_to_frame(g -> buf.addr, g -> gr.addr, *floor, 'R');
		if ((int)(g->plyr.render_x + 60) < (g->exit_x * TSZ) + (DSZ - 15)
			&& (g->exit_x * TSZ) + 15 < (int)(g->plyr.render_x + (PSZ - 60))
			&& (int)(g->plyr.render_y + 15) < (g->exit_y * TSZ) + (DSZ - 15)
			&& (g->exit_y * TSZ) + 15 < (int)(g->plyr.render_y + (TSZ - 15)))
			sl_win(g);
	}
	return (1);
}

static void	sl_get_render_coords(t_game *g, t_cord *floor, t_cord *plyr, t_cord *door)
{
	if (g -> victory == 1)
		sl_coordinate(door, 4, g, 0);
	sl_coordinate(floor, 2, g, 0);
	sl_coordinate(plyr, 3, g, 0);
	return ;
}

static void	sl_apply_camera_lens(t_game *g)
{
    char *src;
    char *dst;
	int offset;
    int y;

    g->cam.x = g->plyr.render_x - (g_camw / 2) + (TSZ / 2);
    g->cam.y = g->plyr.render_y - (g_camh / 2) + (TSZ / 2);
    if (g->cam.x < 0)
		g->cam.x = 0;
    if (g->cam.y < 0)
		g->cam.y = 0;
    if (g->cam.x > (g->w - g_camw))
		g->cam.x = (g->w - g_camw);
    if (g->cam.y > (g->h - g_camh))
		g->cam.y = (g->h - g_camh);
    y = 0;
    while (y < g_camh)
    {
		offset = ((g->cam.y + y) * g->buf.bpr) + (g->cam.x * (g->buf.bpx / 8));
        src = g->buf.addr + offset;
        dst = g->cam.addr + (y * g->cam.bpr);
        ft_memcpy(dst, src, g_camw * (g->cam.bpx / 8));
        y++;
    }
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

void	sl_push_tile_to_frame(char *dst, char *src, t_cord c, char facing)
{
	int		x;
	int		y;
	char	*d_ptr;
	char	*s_ptr;
	int     fliped_x;

	y = 0;
	if (!dst || !src)
		return ;
	while (y < c.th)
	{
		x = 0;
		while (x < c.tw)
		{
			fliped_x = (c.tw - 1) - x;
			if(facing == 'L')
				s_ptr = src + (((y * c.tw) + fliped_x) * 4);
			else
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
