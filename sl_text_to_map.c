/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_text_to_map.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/12 18:59:02 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/15 22:17:56 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "solong.h"

static char	**sl_map_populate(char **map, int fd, int rows);
static int	sl_count_lines(char *map_path);

char	**sl_text_to_map(char *map_path)
{
	char	**map;
	int		rows;
	int		fd;

	if (ft_strlen(map_path) <= 4)
		sl_fail(1, 2, "Map name incomplete. "NEOR"Is empty or without .ber");
	if (ft_strncmp(map_path + (ft_strlen(map_path) - 4), ".ber", 4))
		sl_fail(1, 2, "Map extension must be "LIME".ber");
	rows = sl_count_lines(map_path);
	if (rows < 3)
		sl_fail(1, 2, "Map is too tiny."BABY" File has less than 3 rows");
	fd = open(map_path, O_RDONLY);
	if (fd < 3)
		sl_fail(1, 2, "Failed to "BABY"open "PURP"map file on "B_WI"READ");
	map = ft_calloc((rows + 1), sizeof(char *));
	if (!map)
		sl_fail(1, 2, "Memory allocation failed on "B_WI" conversion");
	return (sl_map_populate(map, fd, rows));
}

static char	**sl_map_populate(char **map, int fd, int rows)
{
	int	guide;

	guide = 0;
	while (guide < rows)
		map[guide++] = get_next_line(fd);
	map[guide] = NULL;
	close(fd);
	while (rows >= 0)
	{
		guide = 0;
		if (map[rows])
		{
			while (map[rows][guide])
			{
				if (map[rows][guide] == '\n')
					map[rows][guide] = '\0';
				guide++;
			}
		}
		rows--;
	}
	return (map);
}

static int	sl_count_lines(char *map_path)
{
	char	*line;
	int		count;
	int		fd;

	fd = open(map_path, O_RDONLY);
	if (fd < 3)
		sl_fail(1, 2, "Failed to "BABY"f_open "PURP"map file on "B_WI"COUNT");
	count = 0;
	line = get_next_line(fd);
	while (line)
	{
		count++;
		free(line);
		line = get_next_line(fd);
	}
	close(fd);
	return (count);
}
