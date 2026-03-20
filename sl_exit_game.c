/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_exit_game.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/12 19:17:21 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 12:05:55 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "solong.h"

void	sl_kill_the_game(t_game *game, int good, int err_code, int exit_code);

void	sl_fail(int err_code, int exit_code, char *err_msg)
{
	if (err_code != 0)
		racc_print(2, BLOD"Error\n"RSET);
	if (err_code == 1)
		racc_print(2, PURP"%e %s\n", "racc", err_msg);
	if (err_code == 2)
	{
		racc_print(2, PURP"%e %s\n", "racc", err_msg);
		racc_print(1, BABY"Usage: "MINT"./so_long "NEOR"map_path"LIME".ber\n");
	}
	if (err_code == 0)
		racc_print(2, LIME"%e Gluttony's your friend! %s\n", "racc", err_msg);
	racc_print(1, RSET);
	exit(exit_code);
}

void	sl_kill_the_game(t_game *game, int good, int err_code, int exit_code)
{
	if (!game -> mlx)
		sl_fail(1, exit_code, "Game didn't load. "NEOR"mlx failed");
	if (game -> win)
		mlx_destroy_window(game -> mlx, game -> win);
	sl_frink(game);
	mlx_destroy_display(game->mlx);
	free(game -> mlx);
	sl_free_matrix(game -> map);
	if (good == 1 && game -> victory == 0)
		sl_fail(err_code, exit_code, BLOD"Game Over. "NEOR"You is dead boy");
	if (good == 1 && game -> victory == 1)
	{
		racc_print(1, BABY"Total Moves:"MINT" %d \n", game -> moves);
		racc_print(1, LIME"Victory!. ");
		sl_fail(err_code, exit_code, MINT"Thank you for playing my game <3\n");
	}
	if (good == 0)
	{
		if (err_code == 3)
			sl_fail(1, exit_code, "Game didn't load. "NEOR"Theme Path Invalid");
		if (err_code == 4)
			sl_fail(1, exit_code, "Game didn't load. "NEOR"mlx failed");
	}
	sl_fail(1, exit_code, "Memory allocation error");
	return ;
}
