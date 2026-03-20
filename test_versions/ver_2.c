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

/*Figured out how to display a pixel*/

typedef struct	s_data 
{
	void	*img;
	char	*addr;
	void	*mlx;
	void	*mlx_win;
	int		bits_per_pixel;
	int		line_length;
	int		endian;
}				t_data;

/* This section is solely for demonstration purposes: */ int handle_keypress(int keycode, t_data *data){if(keycode==65307){mlx_destroy_window(data->mlx, data->mlx_win);exit(0);}return (0);}

void	my_mlx_pixel_put(t_data *data, int x, int y, int color)
{
	char	*dst;

	dst = data->addr + (y * data->line_length + x * (data->bits_per_pixel / 8));
	*(unsigned int*)dst = color;
}

int	main(void)
{
	void	*mlx;
	void	*mlx_win;
	t_data	img;

	mlx = mlx_init();

	mlx = mlx_init();
	mlx_win = mlx_new_window(mlx, 1920, 1080, "Hello world!");
	
	img.img = mlx_new_image(mlx, 1920, 1080);
	img.mlx = mlx;
	img.mlx_win = mlx_win;
	img.addr = mlx_get_data_addr(img.img, &img.bits_per_pixel, &img.line_length, &img.endian);

	my_mlx_pixel_put(&img, 960, 540, 0xFF37FA85);
	mlx_put_image_to_window(img.mlx, img.mlx_win, img.img, 0, 0);

/* This section is solely for demonstration purposes: */ mlx_hook(img.mlx_win, 2, 1L<<0, handle_keypress, &img);	
	
	mlx_loop(mlx);
}
