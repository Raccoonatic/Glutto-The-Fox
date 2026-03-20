/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_map_init_utils.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/14 20:08:46 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 13:54:57 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../inc/solong.h"

int		sl_count_rows(char **map);
int		sl_count_tiles(char **map, t_game *game, char tile);

char	sl_flast_char(char *str)
{
	int	guide;

	guide = 0;
	if (ft_strlen(str) > 1)
	{
		while (str[guide + 1])
			guide++;
	}
	return (str[guide]);
}

int	sl_count_tiles(char **map, t_game *game, char tile)
{
	int	y;
	int	x;
	int	count;

	y = 0;
	count = 0;
	while (map[y])
	{
		x = 0;
		while (map[y][x])
		{
			if (map[y][x] == tile)
				count++;
			x++;
		}
		y++;
	}
	if (game)
		game -> coins = count;
	return (count);
}

int	sl_count_rows(char **map)
{
	int	guide;

	guide = 0;
	while (map[guide])
		guide++;
	return (guide);
}
