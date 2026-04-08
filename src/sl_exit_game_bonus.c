/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_exit_game_bonus.c                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/12 19:17:21 by lde-san-          #+#    #+#             */
/*   Updated: 2026/04/07 15:01:04 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../inc/solong_bonus.h"

void	sl_kill_the_game(t_game *game, int good, int err_code, int exit_code);

void	sl_fail(int err_code, int exit_code, char *err_msg)
{
	if (err_code != 0)
		racc_print(2, BLOD"Error\n"RSET);
	if (err_code == 1)
		racc_print(2, PURP"%e %s\n"RSET, "racc", err_msg);
	if (err_code == 5)
		if(racc_print(2, PURP"%e %s\n"RSET, "racc", err_msg))
			racc_print(2, MINT"Format Hint"RSET": "NEOR"Width"BABY"x"NEOR"Height\n"RSET);
	if (err_code == 2)
	{
		racc_print(2, PURP"%e %s\n"RSET, "racc", err_msg);
		racc_print(1, BABY"Usage: "MINT"./so_long "NEOR"map_path"LIME".ber\n"RSET);
	}
	if (err_code == 0)
		racc_print(2, LIME"%e Gluttony's your friend! %s\n"RSET, "racc", err_msg);
	racc_print(1, RSET);
	exit(exit_code);
}

void	sl_kill_the_game(t_game *game, int good, int err_cd, int exit_cd)
{
	if (!game -> mlx)
		sl_fail(1, exit_cd, "Game didn't load. "NEOR"mlx failed"RSET);
	if (game -> win)
		mlx_destroy_window(game -> mlx, game -> win);
	sl_frink(game);
	mlx_destroy_display(game->mlx);
	free(game -> mlx);
	sl_free_matrix(game -> map);
	if (good == 1 && err_cd == 69)
		sl_fail(0, 69, BLOD"Game Over. "NEOR"You is dead boy"RSET);
	if (good == 1 && err_cd == 42 && game -> victory == 1)
	{
		racc_print(1, BABY"Total Moves:"MINT" %d \n"RSET, game -> moves);
		racc_print(1, LIME"Victory!. "RSET);
		sl_fail(0, 42, MINT"Thank you for playing my game <3\n"RSET);
	}
	if (good == 0)
	{
		if (err_cd == 3)
			sl_fail(1, exit_cd, "Game didn't load. "NEOR"Theme Path Invalid"RSET);
		if (err_cd == 4)
			sl_fail(1, exit_cd, "Game didn't load. "NEOR"mlx failed"RSET);
	}
	sl_fail(1, exit_cd, "Memory allocation error"RSET);
	return ;
}
