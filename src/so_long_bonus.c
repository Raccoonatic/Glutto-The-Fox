/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   so_long_bonus.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/13 17:52:48 by lde-san-          #+#    #+#             */
/*   Updated: 2026/04/20 14:35:42 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../inc/solong_bonus.h"

int	g_camw = 480;
int g_camh = 480;

static int	handle_keypress(int keycode, t_game *data);
static int	handle_close(t_game *data);
static void	sl_game_init(t_game *game);
static void	sl_cam_size(t_game *g, char *size);

int	main(int arc, char *wordy[])
{
	t_game	game;

	if (arc < 2 || arc > 3)
		sl_fail(2, 2, "Incorrect argument count.");
	game.theme = BKND;
	sl_zeroing(&game);
	game.map = sl_check_map(sl_text_to_map(wordy[1]), &game);
	if (arc == 3)
		sl_cam_size(&game, wordy[2]);
	else
		sl_cam_size(&game, NULL);
	sl_game_init(&game);
	mlx_hook(game.win, 17, 1L << 0, handle_close, &game);
	mlx_hook(game.win, 2, 1L << 0, handle_keypress, &game);
	mlx_loop_hook(game.mlx, sl_animate, &game);
	mlx_loop(game.mlx);
	return (0);
}

static void	sl_cam_size(t_game *g, char *size)
{
	int width;
	int height;
	int guide;

	if (size)
	{
		guide = 0;
		while (size[guide] && (size[guide] != 'x' && size[guide] != 'x'))
			guide++;
		if (!size[guide])
			sl_fail(5, 2, "Invalid Camera Size");
		if (!size[guide + 1])
			sl_fail(5, 2, "Invalid Camera Size");
		size[guide] = '\0';
		width = ft_atoi(size);
		height = ft_atoi(size + (guide + 1));
		if (width < 480 || height < 480)
			racc_print(2, PURP"Cam size too small. "MINT"Setting to MIN.\n"RSET);
		else
		{
			g_camh = height;
			g_camw = width;
			if (g_camh == 1080 || g_camh == 2160)
				g_camh -= 70;
		}
	}
	if (!size || g->h < 480 || g->h < height)
		g_camh = g->h;
	if (!size || g->w < 480 || g->w < width)
		g_camw = g->w;
	return ;
}


static void	sl_game_init(t_game *game)
{
	game -> mlx = mlx_init();
	if (!game -> mlx)
		sl_kill_the_game(game, 0, 0, 1);
	game -> win = mlx_new_window(game -> mlx, g_camw, g_camh, "Glutto The Fox");
	if (!game -> win)
		sl_kill_the_game(game, 0, 4, 1);
	sl_layer_init(game, &game -> buf.bpx, &game -> buf.bpr, &game -> buf.e);
}

static int	handle_keypress(int keycode, t_game *data)
{
	if (keycode == K_ESC)
		sl_kill_the_game(data, 1, 69, 0);
	if (keycode == K_W || keycode == K_UP)
		sl_move_plyr(data, data -> map, 'y', -1);
	if (keycode == K_S || keycode == K_DOW)
		sl_move_plyr(data, data -> map, 'y', 1);
	if (keycode == K_D || keycode == K_RGT)
	{
		data->plyr.facing = 'R';
		sl_move_plyr(data, data -> map, 'x', 1);
	}
	if (keycode == K_A || keycode == K_LFT)
	{
		data->plyr.facing = 'L';
		sl_move_plyr(data, data -> map, 'x', -1);
	}
	return (0);
}

static int	handle_close(t_game *data)
{
	sl_kill_the_game(data, 1, 69, 0);
	return (0);
}
