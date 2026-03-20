/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ver_9.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 14:32:28 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../inc/solong.h"

/*Experimenting with sin & cos in order to make the character into a circle*/

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
	char	*dst;
	char	*end;
	static double t = 0; // time counter
	int r, g, b;
	int color;

	// smooth looping RGB values
	r = (int)(sin(t) * 127 + 128);
	g = (int)(sin(t + 2.094) * 127 + 128);  // +120° phase shift (≈ 2π/3)
	b = (int)(sin(t + 4.188) * 127 + 128);  // +240° phase shift (≈ 4π/3)

	color = (r << 16) | (g << 8) | b;

	end = img->addr + (1080 * img->bytes_per_row);
	dst = img->addr;

	while (dst < end)
	{
		*(unsigned int*)dst = color;
		dst += (img->bits_per_pixel / 8);
	}
	t += 0.005; // controls animation speed
	if (t > 2 * M_PI)
		t -= 2 * M_PI; // reset loop (optional)

	return (0);
}

int render_character(t_data *img)
{
	int x;
	int y;
	int radius = 50;
	double t = 0.001;
	static double t_t = 0;
	char	*dst;
	char	*end;
	int r, g, b;
	int color;

	r = (int)(sin(t_t) * 127 + 128);
	g = (int)(sin(t_t + 2.094) * 127 + 128);
	b = (int)(sin(t_t + 4.188) * 127 + 128);

	color = (r << 16) | (g << 8) | b;

	end = img->addr + (101 * img->bytes_per_row);
	dst = img->addr;

	while (dst < end)
	{
		*(unsigned int*)dst = color;
		dst += (img->bits_per_pixel / 8);
	}

	t_t += 0.005;
	if (t_t > 2 * M_PI)
		t_t -= 2 * M_PI;
        while (radius-- > 16)
	{
		while (t < 2 * M_PI)
		{
			x = (int)(cos(t) * radius + 50);
			y = (int)(sin(t) * radius + 50);
			if (radius > 46 || radius < 20)
			{
                                my_mlx_pixel_put(img, x, y, 0x000000);
			}
			else
			        my_mlx_pixel_put(img, x, y, 0xFF37FA85);
			t += 0.001;
		}
		t -= 2 * M_PI;
	}
	return (0);
}

int render(t_datapack *layers)
{
	render_bkgrnd(&layers->bkgrnd);
	render_character(&layers->chara);
	mlx_put_image_to_window(layers->bkgrnd.mlx, layers->bkgrnd.mlx_win, layers->bkgrnd.img, layers->bkgrnd.x, layers->bkgrnd.y);
	mlx_put_image_to_window(layers->chara.mlx, layers->chara.mlx_win, layers->chara.img, layers->chara.x, layers->chara.y);
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

