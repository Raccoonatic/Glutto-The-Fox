/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_terrain.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/18 20:54:30 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 13:55:21 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../inc/solong.h"

static int	sl_corner_texture(char **map, int y, int x, int border);
static int	sl_get_texture_index(char **m, int y, int x);
static int	sl_corner_check(char **map, int y, int x);

void	sl_build_terrain(t_game *g, char **map, t_imgdata *t)
{
	int		x;
	int		y;
	int		index;
	t_cord	c;

	mlx_destroy_image(g -> mlx, t -> main);
	t -> main = mlx_new_image(g -> mlx, g -> w, g -> h);
	if (!t -> main)
		sl_kill_the_game(g, 0, 4, 1);
	t -> addr = mlx_get_data_addr(t -> main, &t -> bpx, &t -> bpr, &t -> e);
	y = 0;
	while (map[y])
	{
		x = 0;
		while (map[y][x])
		{
			sl_coordinate(&c, 1, g, x * TSZ);
			c.y = y * TSZ;
			index = sl_get_texture_index(map, y, x);
			if (map[y][x] == '1')
				sl_push_tile_to_frame(t -> addr, t -> frad[index], c);
			x++;
		}
		y++;
	}
}

static int	sl_get_texture_index(char **m, int y, int x)
{
	if (y + x == 0 || (y == 0 && m[y][x + 1] == '\0')
		|| (x == 0 && !m[y + 1]) || (!m[y + 1] && m[y][x + 1] == '\0'))
		return (sl_corner_texture(m, y, x, 1));
	if (sl_corner_texture(m, y, x, 69) != 69)
		return (sl_corner_texture(m, y, x, 69));
	if (y != 0 && (!m[y + 1] || m[y + 1][x] == '1') && m[y - 1][x] != '1')
		return (1);
	if ((y == 0 || m[y - 1][x] == '1') && m[y + 1] && m[y + 1][x] != '1')
		return (4);
	if (x != 0 && y != 0 && m[y + 1] && m[y][x + 1] && ((m[y + 1][x] != 49
		&& m[y - 1][x] != 49) || (m[y][x + 1] != 49 && m[y][x - 1] != 49)))
	{
		if (m[y][x + 1] != '1' && m[y][x - 1] == '1')
			return (11);
		if (m[y][x - 1] != '1' && m[y][x + 1] == '1')
			return (9);
		return (10);
	}
	if ((!x || m[y][x - 1] == '1') && (m[y][x + 1] != '1' && m[y][x + 1] != 0))
		return (8);
	if (x && (m[y][x + 1] == 0 || m[y][x + 1] == 49) && m[y][x - 1] != 49)
		return (6);
	return (7);
}

static int	sl_corner_texture(char **map, int y, int x, int border)
{
	if (border == 1)
	{
		if (y + x == 0 && map[y + 1][x + 1] != '1')
			return (3);
		if ((y == 0 && map[y][x + 1] == '\0') && (map[y + 1][x - 1] != '1'))
			return (5);
		return (7);
	}
	if (sl_corner_check(map, y, x))
	{
		if ((map[y + 1][x] == '1') && (map[y][x + 1] == '1'))
			return (0);
		if ((map[y + 1][x] == '1') && (map[y][x - 1] == '1'))
			return (2);
		if ((map[y - 1][x] == '1') && (map[y][x + 1] == '1'))
			return (12);
		if ((map[y - 1][x] == '1') && (map[y][x - 1] == '1'))
			return (14);
	}
	return (border);
}

static int	sl_corner_check(char **map, int y, int x)
{
	if (x && y && map[y + 1] && map[y][x + 1] && ((map[y - 1][x] == '1'
		&& map[y][x - 1] == '1' && map[y + 1][x] != '1' && map[y][x + 1] != '1')
		|| (map[y - 1][x] == '1' && map[y][x + 1] == '1' && map[y + 1][x] != '1'
		&& map[y][x - 1] != '1') || (map[y + 1][x] == '1' && map[y][x - 1] == 49
		&& map[y - 1][x] != '1' && map[y][x + 1] != '1') || (map[y + 1][x] == 49
		&& map[y][x + 1] == '1' && map[y - 1][x] != 49 && map[y][x - 1] != 49)))
		return (1);
	return (0);
}

void	sl_blackpink(t_imgdata *img, int h)
{
	char	*end;
	char	*start;

	start = img -> addr;
	end = (img -> addr) + (img -> bpr * h);
	while (start < end)
	{
		if (*(unsigned int *)start == 0x00000000)
			*(unsigned int *)start = 0x00FF00FF;
		start += (img -> bpx / 8);
	}
	return ;
}
