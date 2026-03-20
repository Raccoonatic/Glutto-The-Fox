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

/*Experimented with keycodes and events to create movement on the square. It can
now move freely in and out the window with WASD and the arrow keys. If the mouse
is on the screen it will follow it, and the ESC key can be used to close the 
window.*/

typedef struct	s_data 
{
	void	*img;
	char	*addr;
	void	*mlx;
	void	*mlx_win;
	int		bits_per_pixel;
	int		line_length;
	int		endian;
	int	x;
	int	y;
}				t_data;

int handle_keypress(int keycode, t_data *data)
{
	if (keycode == 65307)
	{
		mlx_destroy_window(data->mlx, data->mlx_win);
		exit (0);
	}
	if (keycode == 100 || keycode == 65363)
		data->x += 20;
	if (keycode == 97 || keycode == 65361)
		data->x -= 20;
	if (keycode == 115 || keycode == 65364)
		data->y += 20;
	if (keycode == 119 || keycode == 65362)
		data->y -= 20;
	racc_print(1, "%e %d, %d, %d %e\n", "racc", keycode, data->x, data->y, "racc");
	return (0);
}

int handle_mouse(int x, int y, t_data *data)
{
	while(x-50 < data->x)
		data->x--;
	while(x-50 > data->x)
		data->x++;
	while(y-50 < data->y)
		data->y--;
	while(y-50 > data->y)
		data->y++;
	return (0);
}

void	my_mlx_pixel_put(t_data *data, int x, int y, int color)
{
	char	*dst;

	dst = data->addr + (y * data->line_length + x * (data->bits_per_pixel / 8));
	*(unsigned int*)dst = color;
}

int render(t_data *img) 
{ 
	static int x = 0;
	static int y = 0; 

	my_mlx_pixel_put(img, x, y, 0xFF37FA85);
	mlx_put_image_to_window(img->mlx, img->mlx_win, img->img, img->x, img->y);
	if (x < 100 && y == 0)
	{ 
		x++;
		return(0);
	} 
	else if (y < 100 && x == 100)
	{
		y++;
		return(0);
	}
	else if (x > 0)
	{
		x--;
		return(0);
	}
	else if (y > 0)
	{
		y--;
		return(0);
	}
	return (0);
}

int	main(void)
{
	void	*mlx;
	void	*mlx_win;
	t_data	img;

	mlx = mlx_init();

	mlx = mlx_init();
	mlx_win = mlx_new_window(mlx, 1920, 1080, "Hello world!");
	img.img = mlx_new_image(mlx, 101, 101);
	img.mlx = mlx;
	img.mlx_win = mlx_win;
	img.x = 910;
	img.y = 500;
	img.addr = mlx_get_data_addr(img.img, &img.bits_per_pixel, &img.line_length, &img.endian);
	mlx_hook(img.mlx_win, 2, 1L<<0, handle_keypress, &img);
	mlx_hook(img.mlx_win, 6, 1L<<6, handle_mouse, &img);
	mlx_loop_hook(img.mlx, render, &img);
	mlx_loop(mlx);
}
