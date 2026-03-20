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

/*Fixed rainbow background by learning to work bitwise operation. More specifically
the bitwise OR (|) that merges all ON values (1) into the OFF ones (0) */

typedef struct	s_data 
{
	void	*img;
	char	*addr;
	void	*mlx;
	void	*mlx_win;
	int		bits_per_pixel;
	int		bytes_per_row;
	int		endian;
	int	x;
	int	y;
}				t_data;

typedef struct	s_datapack
{
	t_data	chara;
	t_data	bkgrnd;
}				t_datapack;

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

	dst = data->addr + (y * data->bytes_per_row + x * (data->bits_per_pixel / 8));
	*(unsigned int*)dst = color;
}

int render_bkgrnd(t_data *img)
{
	char *dst; 
	int color; 
	char *end; 
	static int r = 255; 
	static int g = 0; 
	static int b = 0;

	end = img->addr + (1080 * img->bytes_per_row);
	dst = img->addr;
	color = (r<<16 | g<<8 | b);
	while (dst <= end) 
	{ 
		*(unsigned int*)dst = color; 
		dst += (img->bits_per_pixel / 8); 
	}
	
	mlx_put_image_to_window(img->mlx, img->mlx_win, img->img, img->x, img->y); 

	if (r == 255 && g < 255 && b == 0)
		g++;
	else if (g == 255 && r > 0 && b == 0)
		r--;
	else if (g == 255 && b < 255 && r == 0)
		b++;
	else if (b == 255 && g > 0 && r == 0)
		g--;
	else if (b == 255 && r < 255 && g == 0)
		r++;
	else if (r == 255 && b > 0 && g == 0)
		b--;
	return(0); 
}

int render_character(t_data *img) 
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

int render(t_datapack *layers)
{
	render_bkgrnd(&layers->bkgrnd);
	render_character(&layers->chara);
	return(0);
}

int	main(void)
{
	void	*mlx;
	void	*mlx_win;
	t_datapack layers;

	mlx = mlx_init();

	mlx_win = mlx_new_window(mlx, 1920, 1080, "Mapache's box'o fun");
	layers.chara.img = mlx_new_image(mlx, 101, 101);
	layers.bkgrnd.img = mlx_new_image(mlx, 1920, 1080);
	layers.chara.mlx = mlx;
	layers.bkgrnd.mlx = mlx;
	layers.chara.mlx_win = mlx_win;
	layers.bkgrnd.mlx_win = mlx_win;
	layers.bkgrnd.addr = mlx_get_data_addr(layers.bkgrnd.img, &layers.bkgrnd.bits_per_pixel, &layers.bkgrnd.bytes_per_row, &layers.bkgrnd.endian);
	layers.chara.addr = mlx_get_data_addr(layers.chara.img, &layers.chara.bits_per_pixel, &layers.chara.bytes_per_row, &layers.chara.endian);
	layers.bkgrnd.x = 0;
	layers.bkgrnd.y = 0;
	layers.chara.x = 910;
	layers.chara.y = 500;
	mlx_hook(layers.chara.mlx_win, 2, 1L<<0, handle_keypress, &layers.chara);
	mlx_hook(layers.chara.mlx_win, 6, 1L<<6, handle_mouse, &layers.chara);
	mlx_loop_hook(layers.bkgrnd.mlx, render, &layers);
	mlx_loop(mlx);
}

