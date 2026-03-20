/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/04 17:33:08 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "solong.h"

/*Learned about mlx_do_sync, and implemented it for alleged "better" rendering. 
Looked into the better version "mlx_sync" but it somehow seems to be a myth.
Since the mouse can move the character, added functionality to mlx_mouse_hide, 
if the mouse enters the game window area.*/

typedef struct	s_data 
{
	void	*img;
	char	*addr;
	void	*mlx;
	void	*mlx_win;
	int		bits_per_pixel;
	int		bytes_per_row;
	int		endian;
	int	img_width;
	int	img_height;
	int	x;
	int	y;
}				t_data;

typedef struct	s_datapack
{
	t_data  bkgrn;
	t_data  game;
}				t_datapack;

int	handle_enter(t_data *data)
{
    racc_print(1,"Entered\n");
    mlx_mouse_hide(data->mlx, data->mlx_win);
    return (0);
}

int	handle_keypress(int keycode, t_data *data)
{	
	if (keycode == 65307)
	{
		mlx_destroy_window(data->mlx, data->mlx_win);
		exit (0);
	}

	if (keycode == 100 || keycode == 65363)
	{
		data->x += 20;
		if (data->x >= data->img_width + 100)
			data->x -= data->img_width;
	}
	if (keycode == 97 || keycode == 65361)
	{
		data->x -= 20;
		if (data->x < data->img_width - 100)
			data->x += data->img_width;
	}
	if (keycode == 115 || keycode == 65364)
	{
		data->y += 20;
		if (data->y >= data->img_height + 100)
			data->y -= data->img_height;
	}
	if (keycode == 119 || keycode == 65362)
	{
		data->y -= 20;
		if (data->y < data->img_height - 100)
			data->y += data->img_height;
	}
	racc_print(1, "%e %d, %d, %d %e\n", "racc", keycode, data->x, data->y, "racc");
	return (0);
}

int	handle_mouse(int x, int y, t_data *data)
{
	while(x < data->x)
		data->x--;
	while(x > data->x)
		data->x++;
	while(y < data->y)
		data->y--;
	while(y > data->y)
		data->y++;
	return (0);
}

int	handle_close(t_data *data)
{
	mlx_destroy_window(data->mlx, data->mlx_win);
	exit(0);
	return (0);
}

void	my_mlx_pixel_put(t_data *data, int x, int y, int color)
{
	char	*dst;

	if (x < 0)
		x += data->img_width;
	else if (x >= data->img_width)
		x -= data->img_width;
	if (y < 0)
		y += data->img_height;
	else if (y >= data->img_height)
		y -= data->img_height;

	dst = data->addr + (y * data->bytes_per_row + x * (data->bits_per_pixel / 8));
	*(unsigned int*)dst = color;
}

int render_character(t_data *img)
{
	int radius = 50;
	double t = 0.001;
	static double t_t = 0;
	int r, g, b;
	int color;
	int cx;
	int cy;

	r = (int)(sin(t_t) * 127 + 128);
	g = (int)(sin(t_t + 2.094) * 127 + 128);
	b = (int)(sin(t_t + 4.188) * 127 + 128);

	color = (r << 16) | (g << 8) | b;

        while (radius-- > 16)
	{
		while (t < 2 * M_PI)
		{
			cx = (int)(cos(t) * radius + img->x);
			cy = (int)(sin(t) * radius + img->y);
			if (radius > 46 || radius < 20)
			{
                                my_mlx_pixel_put(img, cx, cy, 0x000000);
			}
			else
			        my_mlx_pixel_put(img, cx, cy, color);
			t += 0.01;
		}
		t -= 2 * M_PI;
	}
	t_t += 0.05;
	if (t_t > 2 * M_PI)
		t_t -= 2 * M_PI;
	return (0);
}

int render(t_datapack *lyrs)
{
	lyrs->game.addr = ft_memcpy(lyrs->game.addr, lyrs->bkgrn.addr, lyrs->bkgrn.img_height * lyrs->bkgrn.bytes_per_row);
	render_character(&lyrs->game);
	mlx_put_image_to_window(lyrs->game.mlx, lyrs->game.mlx_win, lyrs->game.img, 0, 0);
	mlx_do_sync(lyrs->game.mlx);
	return(0);
}


int	main(void)
{
	t_datapack lyrs;
	char	*relative_path = "assets/background/Seventy.xpm";

	lyrs.game.mlx = mlx_init();
	lyrs.bkgrn.mlx = lyrs.game.mlx;

	lyrs.bkgrn.img = mlx_xpm_file_to_image(lyrs.bkgrn.mlx, relative_path, &lyrs.bkgrn.img_width, &lyrs.bkgrn.img_height);
	lyrs.game.img_width = lyrs.bkgrn.img_width;
	lyrs.game.img_height = lyrs.bkgrn.img_height;
	lyrs.game.img = mlx_new_image(lyrs.game.mlx, lyrs.game.img_width, lyrs.game.img_height);

	lyrs.game.mlx_win = mlx_new_window(lyrs.game.mlx, lyrs.game.img_width, lyrs.game.img_height, "Mapache's box'o fun");
	lyrs.bkgrn.mlx_win = lyrs.game.mlx_win;
	lyrs.game.addr = mlx_get_data_addr(lyrs.game.img, &lyrs.game.bits_per_pixel, &lyrs.game.bytes_per_row, &lyrs.game.endian);
	lyrs.bkgrn.addr = mlx_get_data_addr(lyrs.bkgrn.img, &lyrs.bkgrn.bits_per_pixel, &lyrs.bkgrn.bytes_per_row, &lyrs.bkgrn.endian);

	lyrs.game.x = 1200;
	lyrs.game.y = 600;

	mlx_hook(lyrs.game.mlx_win, 17, 1L<<0, handle_close, &lyrs.game);
	mlx_hook(lyrs.game.mlx_win, 2, 1L<<0, handle_keypress, &lyrs.game);
	mlx_hook(lyrs.game.mlx_win, 6, 1L<<6, handle_mouse, &lyrs.game);
	mlx_hook(lyrs.game.mlx_win, 7, 1L<<4, handle_enter, &lyrs.game);
	
	mlx_loop_hook(lyrs.game.mlx, render, &lyrs);
	mlx_loop(lyrs.game.mlx);
	return(0);
}
