/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_check_map_bonus.c                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/13 19:50:51 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 13:50:44 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../inc/solong_bonus.h"

static int	sl_perimeter_check(char **map);
static int	sl_shape_check(char **map, t_game *game);
static int	sl_char_check(char **map, char *allowed);
static int	sl_mandatory_tile_count(char **map, char *tiles);

char	**sl_check_map(char **map_file, t_game *game)
{
	int	char_analysis;

	if (!sl_shape_check(map_file, game))
	{
		sl_free_matrix(map_file);
		sl_fail(1, 1, "Map file is "NEOR"Not Rectangular");
	}
	char_analysis = sl_char_check(map_file, "0X1PCE");
	if (char_analysis > 0)
		sl_free_matrix(map_file);
	if (char_analysis == 1)
		sl_fail(1, 1, "Map file invalid. "NEOR"Unknown Tile");
	if (char_analysis == 2)
		sl_fail(1, 1, "Map file invalid. "NEOR"Mandatory_Tile Missing");
	if (char_analysis == 3)
		sl_fail(1, 1, "Map file invalid. "NEOR"Wrong Mandatory_Tile count");
	if (!sl_perimeter_check(map_file))
	{
		sl_free_matrix(map_file);
		sl_fail(1, 1, "Map file is "NEOR"Not Surrounded by Walls");
	}
	return (sl_path_check(map_file, game));
}

static int	sl_perimeter_check(char **map)
{
	int	row;
	int	column;

	row = 0;
	while (map[row])
	{
		column = 0;
		if (map[row + 1] == NULL || row == 0)
		{
			while (map[row][column])
			{
				if (map[row][column++] != '1')
					return (0);
			}
			row++;
			continue ;
		}
		if ((map[row][column] != '1') || (sl_flast_char(map[row]) != '1'))
			return (0);
		row++;
	}
	return (1);
}

static int	sl_char_check(char **map, char *allowed)
{
	int	row;
	int	column;

	row = 0;
	while (map[row])
	{
		column = 0;
		while (map[row][column])
		{
			if (!ft_strchr(allowed, map[row][column]))
				return (1);
			column++;
		}
		row++;
	}
	return (sl_mandatory_tile_count(map, allowed += 2));
}

static int	sl_mandatory_tile_count(char **map, char *tiles)
{
	int	count;

	while (*tiles)
	{
		count = sl_count_tiles(map, NULL, *tiles);
		if (count == 0)
			return (2);
		if ((*tiles == '1' && count < 12) || (*tiles == 'C' && count < 1))
			return (3);
		if (count != 1 && (*tiles == 'P' || *tiles == 'E'))
			return (3);
		tiles++;
	}
	return (0);
}

static int	sl_shape_check(char **map, t_game *game)
{
	int	rows;
	int	first_column;

	rows = 0;
	first_column = 0;
	while (map[rows])
	{
		if (first_column == 0)
		{
			first_column = ft_strlen(map[rows]);
			if (first_column == 0)
				return (0);
			rows++;
			continue ;
		}
		if ((size_t)first_column != ft_strlen(map[rows]))
			return (0);
		rows++;
	}
	game -> h = rows * TSZ;
	game -> w = first_column * TSZ;
	return (1);
}
