/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   so_long.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/13 17:52:48 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/24 12:46:10 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "solong.h"

static int	handle_keypress(int keycode, t_game *data);
static int	handle_close(t_game *data);
static void	sl_game_init(t_game *game);

int	main(int arc, char *wordy[])
{
	t_game	game;

	if (arc < 2 || arc > 3)
		sl_fail(2, 2, "Incorrect argument count.");
	game.theme = BKND;
	if (arc == 3)
		game.theme = wordy[2];
	sl_zeroing(&game);
	game.map = sl_check_map(sl_text_to_map(wordy[1]), &game);
	sl_game_init(&game);
	mlx_hook(game.win, 17, 1L << 0, handle_close, &game);
	mlx_hook(game.win, 2, 1L << 0, handle_keypress, &game);
	mlx_loop_hook(game.mlx, sl_animate, &game);
	mlx_loop(game.mlx);
	return (0);
}

static void	sl_game_init(t_game *game)
{
	int	h;
	int	w;

	h = game -> h;
	w = game -> w;
	game -> mlx = mlx_init();
	if (!game -> mlx)
		sl_kill_the_game(game, 0, 0, 1);
	game -> win = mlx_new_window(game -> mlx, w, h, "Glutto The Fox");
	if (!game -> win)
		sl_kill_the_game(game, 0, 4, 1);
	sl_layer_init(game, &game -> buf.bpx, &game -> buf.bpr, &game -> buf.e);
}

static int	handle_keypress(int keycode, t_game *data)
{
	if (keycode == K_ESC)
		sl_kill_the_game(data, 1, 0, 0);
	if (keycode == K_W || keycode == K_UP)
		sl_move_plyr(data, data -> map, 'y', -1);
	if (keycode == K_S || keycode == K_DOW)
		sl_move_plyr(data, data -> map, 'y', 1);
	if (keycode == K_D || keycode == K_RGT)
		sl_move_plyr(data, data -> map, 'x', 1);
	if (keycode == K_A || keycode == K_LFT)
		sl_move_plyr(data, data -> map, 'x', -1);
	return (0);
}

static int	handle_close(t_game *data)
{
	sl_kill_the_game(data, 1, 0, 0);
	return (0);
}
