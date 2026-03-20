/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_flood_fill.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/15 09:25:23 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 13:54:39 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../inc/solong.h"

static void	sl_flood_fill(char **map, int y, int x);
static void	sl_find_player_start(char **map, t_game *game);
static char	**sl_mapdup(char **map);

char	**sl_path_check(char **map, t_game *game)
{
	char	**new_map;

	new_map = sl_mapdup(map);
	sl_find_player_start(map, game);
	sl_flood_fill(map, game -> plyr.y, game -> plyr.x);
	if ((sl_count_tiles(map, NULL, 'C') + sl_count_tiles(map, NULL, 'E')) != 0)
	{
		sl_free_matrix(map);
		sl_free_matrix(new_map);
		sl_fail(1, 1, "Map file invalid. "NEOR"Unreachable Target Tile");
	}
	sl_free_matrix(map);
	return (new_map);
}

static void	sl_flood_fill(char **map, int y, int x)
{
	if (map[y][x] == '1' || map[y][x] == 'F')
		return ;
	map[y][x] = 'F';
	sl_flood_fill(map, y, x + 1);
	sl_flood_fill(map, y, x - 1);
	sl_flood_fill(map, y + 1, x);
	sl_flood_fill(map, y - 1, x);
	return ;
}

static void	sl_find_player_start(char **map, t_game *game)
{
	int	y;
	int	x;

	y = 0;
	while (map[y])
	{
		x = 0;
		while (map[y][x])
		{
			if (map[y][x] == 'P')
			{
				game -> plyr.y = y;
				game -> plyr.x = x;
				return ;
			}
			x++;
		}
		y++;
	}
	return ;
}

static char	**sl_mapdup(char **map)
{
	char	**new_map;
	int		guide;

	new_map = ft_calloc((sl_count_rows(map) + 1), sizeof(char *));
	if (!new_map)
	{
		sl_free_matrix(map);
		sl_fail(1, 1, "Memory allocation failed on "B_WI" sl_mapdup");
	}
	guide = 0;
	while (map[guide])
	{
		new_map[guide] = ft_strdup(map[guide]);
		if (!new_map[guide])
		{
			sl_free_matrix(new_map);
			sl_free_matrix(map);
			sl_fail(1, 1, "Memory allocation failed on "B_WI" ft_strdup");
		}
		guide++;
	}
	new_map[guide] = NULL;
	return (new_map);
}
