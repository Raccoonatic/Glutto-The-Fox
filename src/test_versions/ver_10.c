/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ver_10.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 14:30:57 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../inc/solong.h"

/*Experimented further with the sin and cos to create color shifting spirals. The
spiral's parameters can be changed during execution with WASD and the arrow keys.
You may also hit the space bar to clear the window.*/

typedef struct	s_data 
{
	void	*img;
	char	*addr;
	void	*mlx;
	void	*mlx_win;
	int		bits_per_pixel;
	int		bytes_per_row;
	int		endian;
	double o_increment;
	double t_increment;
	double radius_increment;
	double t_t_increment;
}				t_data;

void clear(t_data *data)
{
	char	*dst;
	char	*end;
	
	dst = data->addr;
	end = data->addr + (1080 * data->bytes_per_row);
	
	while (dst != end)
		*(unsigned int*)dst++ = 0;
	mlx_put_image_to_window(data->mlx, data->mlx_win, data->img, 0, 0);
}

int handle_keypress(int keycode, t_data *data)
{
	if (keycode == 65307)
	{
		mlx_destroy_window(data->mlx, data->mlx_win);
		exit (0);
	}
	if (keycode == 32)
		clear(data);
	if (keycode == 100) 
	{
		data->t_increment += 0.00001;
		printf("🦝 Increasing Time Increment: %f\n", data->t_increment);
	}
	if (keycode == 65363)
	{
		data->radius_increment += 0.01; 
		printf("🦝 Increasing Radius Increment: %f\n", data->radius_increment);
      	}
	if (keycode == 97 && data->t_increment > 0.00001)
	{
		data->t_increment -= 0.00001; 
		printf("🦝 Decreasing Time Increment: %f\n", data->t_increment);
	}
	if (keycode == 65361 && data->radius_increment > 0.01)
	{
		data->radius_increment -= 0.01; 
		printf("🦝 Decreasing Radius Increment: %f\n", data->radius_increment);
	}
	if (keycode == 65364 && data->o_increment > 0.0001)
	{
		data->o_increment -= 0.0001; 
		printf("🦝 Decreasing Offset Increment: %f\n", data->o_increment);
	}
	if (keycode == 65362)
	{
		data->o_increment += 0.0001; 
		printf("🦝 Increasing Offset Increment: %f\n", data->o_increment);
	}
	if (keycode == 119)
	{
		data->t_t_increment += 0.0001; 
		printf("🦝 Increasing Color Speed: %f\n", data->t_t_increment);
	}
	if (keycode == 115 && data->t_t_increment > 0.00001)
	{
		data->t_t_increment -= 0.00001; 
		printf("🦝 Decreasing Color Speed: %f\n", data->t_t_increment);
	}
	return (0);
}

void	my_mlx_pixel_put(t_data *data, int x, int y, int color)
{
	char	*dst;

	dst = data->addr + (y * data->bytes_per_row + x * (data->bits_per_pixel / 8));
	*(unsigned int*)dst = color;
}

int render_spiral(t_data *img)
{
	int x = 0;
	int y = 0;
	double radius = 0;
	double t = 0;
	static double o = 0;
	static double t_t = 0;
	int r, g, b;
	int color;

	r = (int)(sin(t_t) * 127 + 128);
	g = (int)(sin(t_t + 2.094) * 127 + 128);
	b = (int)(sin(t_t + 4.188) * 127 + 128);

	color = (r << 16) | (g << 8) | b;

	t_t += img->t_t_increment;
	
	if (t_t > 2 * M_PI)
		t_t -= 2 * M_PI;

        while (y < 1080 && y >= 0 && x < 1920 && x >= 0)
        {
        	x = (int)(sin(t + o) * radius + 960);
        	y = (int)(cos(t + o) * radius + 540);
        	if (y < 1080 && y >= 0 && x < 1920 && x >= 0)
                        my_mlx_pixel_put(img, x, y, color);
		t += img->t_increment;
		radius += img->radius_increment;
	}
	o += img->o_increment;
	mlx_put_image_to_window(img->mlx, img->mlx_win, img->img, 0, 0);
	return (0);
}

int	main(void)
{
        t_data img;

	img.mlx = mlx_init();
	img.mlx_win = mlx_new_window(img.mlx, 1920, 1080, "Mapache's Spiral of Sorrows");
	img.img = mlx_new_image(img.mlx, 1920, 1080);
	img.addr = mlx_get_data_addr(img.img, &img.bits_per_pixel, &img.bytes_per_row, &img.endian);
	
	img.o_increment = 0.0001;
	img.t_increment = 0.00001;
	img.t_t_increment = 0.00001;
	img.radius_increment = 0.01;
	
	mlx_hook(img.mlx_win, 2, 1L<<0, handle_keypress, &img);
	mlx_loop_hook(img.mlx, render_spiral, &img);
	mlx_loop(img.mlx);
}
