# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    version_maker.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/04/04 13:30:42 by lde-san-          #+#    #+#              #
#    Updated: 2026/04/04 13:43:28 by lde-san-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!bin/bash
mkdir test_versions
cat > test_versions/ver_1.c << 'EOF'
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ver_1.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 14:31:25 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../inc/solong.h"

/*Figured out what's needed to initialize an instance of the graphics engine
(an mlx) and created my first window!*/

/* This section is solely for demonstration purposes: */ typedef struct	s_data {void *mlx; void *mlx_win;} t_data; int handle_keypress(int keycode, t_data *data){if(keycode==65307){mlx_destroy_window(data->mlx, data->mlx_win);exit(0);}return (0);}

int	main(void)
{
	void	*mlx;
	void	*mlx_win;
    t_data  safe_exit;

	mlx = mlx_init();
	mlx_win = mlx_new_window(mlx, 960, 540, "Hello world!");
	
/* This section is solely for demonstration purposes: */ safe_exit.mlx = mlx; safe_exit.mlx_win = mlx_win; mlx_hook(safe_exit.mlx_win, 2, 1L<<0, handle_keypress, &safe_exit);
	
	mlx_loop(mlx);
}
EOF
cat > test_versions/ver_2.c << 'EOF'
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ver_2.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 14:31:31 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../inc/solong.h"

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
	mlx_win = mlx_new_window(mlx, 960, 540, "Hello world!");
	
	img.img = mlx_new_image(mlx, 960, 540);
	img.mlx = mlx;
	img.mlx_win = mlx_win;
	img.addr = mlx_get_data_addr(img.img, &img.bits_per_pixel, &img.line_length, &img.endian);

	my_mlx_pixel_put(&img, (960/2), (540/2), 0xFF37FA85);
	mlx_put_image_to_window(img.mlx, img.mlx_win, img.img, 0, 0);

/* This section is solely for demonstration purposes: */ mlx_hook(img.mlx_win, 2, 1L<<0, handle_keypress, &img);	
	
	mlx_loop(mlx);
}
EOF
cat > test_versions/ver_3.c << 'EOF'
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ver_3.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 14:31:37 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../inc/solong.h"

/*Figured out how to use the mlx_loop_hook function to increment the x and y
axis, displaying the point on different places in the screen to draw lines and
create the illusion of motion.*/

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

int render(t_data *img) 
{ 
	static int x = 0;
	static int y = 0; 

	my_mlx_pixel_put(img, x, y, 0xFF37FA85);
	x++;
	if (y < (1080/2))
		y++;
	my_mlx_pixel_put(img, x, y, 0xFF37FA85);
	if (y < (1080/2))
		y++;
	my_mlx_pixel_put(img, x, y, 0xFF37FA85);
	if (y < (1080/2))
		y++;
	my_mlx_pixel_put(img, x, y, 0xFF37FA85);
	if (y < (1080/2))
		y++;
	my_mlx_pixel_put(img, x, y, 0xFF37FA85);
	if (y < (1080/2))
		y++;
	my_mlx_pixel_put(img, x, y, 0xFF37FA85);
	if (x > (1920/2))
	{
		x = 0;
		if (y < (1080/2))
			y++;
	}
	if (y == (1080/2))
		y = 0;
	mlx_put_image_to_window(img->mlx, img->mlx_win, img->img, 0, 0);
	return (0);
}

int	main(void)
{
	void	*mlx;
	void	*mlx_win;
	t_data	img;

	mlx = mlx_init();

	mlx = mlx_init();
	mlx_win = mlx_new_window(mlx, 960, 540, "Hello world!");
	img.img = mlx_new_image(mlx, 960, 540);
	img.mlx = mlx;
	img.mlx_win = mlx_win;
	img.addr = mlx_get_data_addr(img.img, &img.bits_per_pixel, &img.line_length, &img.endian);
	mlx_loop_hook(img.mlx, render, &img);

/* This section is solely for demonstration purposes: */ mlx_hook(img.mlx_win, 2, 1L<<0, handle_keypress, &img);
	
	mlx_loop(mlx);
}
EOF
cat > test_versions/ver_4.c << 'EOF'
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ver_4.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 14:31:43 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../inc/solong.h"

/*Figured out how to use the mlx_loop_hook function to add to a different axis
every couple of frames. Making a square.*/

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

int render(t_data *img) 
{ 
	static int x = 0;
	static int y = 0; 

	my_mlx_pixel_put(img, x, y, 0xFF37FA85);
	mlx_put_image_to_window(img->mlx, img->mlx_win, img->img, 910/2, 500/2);
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
	mlx_win = mlx_new_window(mlx, 1920/2, 1080/2, "Hello world!");
	img.img = mlx_new_image(mlx, 1920/2, 1080/2);
	img.mlx = mlx;
	img.mlx_win = mlx_win;
	img.addr = mlx_get_data_addr(img.img, &img.bits_per_pixel, &img.line_length, &img.endian);
	mlx_loop_hook(img.mlx, render, &img);
	
/* This section is solely for demonstration purposes: */ mlx_hook(img.mlx_win, 2, 1L<<0, handle_keypress, &img);
	
	mlx_loop(mlx);
}
EOF
cat > test_versions/ver_5.c << 'EOF'
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ver_5.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 14:31:54 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../inc/solong.h"

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
		data->x += 20/2;
	if (keycode == 97 || keycode == 65361)
		data->x -= 20/2;
	if (keycode == 115 || keycode == 65364)
		data->y += 20/2;
	if (keycode == 119 || keycode == 65362)
		data->y -= 20/2;
	racc_print(1, "%e %d, %d, %d %e\n", "racc", keycode, data->x, data->y, "racc");
	return (0);
}

int handle_mouse(int x, int y, t_data *data)
{
	while(x-50/2 < data->x)
		data->x--;
	while(x-50/2 > data->x)
		data->x++;
	while(y-50/2 < data->y)
		data->y--;
	while(y-50/2 > data->y)
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
	mlx_win = mlx_new_window(mlx, 1920/2, 1080/2, "Hello world!");
	img.img = mlx_new_image(mlx, 101, 101);
	img.mlx = mlx;
	img.mlx_win = mlx_win;
	img.x = 910/2;
	img.y = 500/2;
	img.addr = mlx_get_data_addr(img.img, &img.bits_per_pixel, &img.line_length, &img.endian);
	mlx_hook(img.mlx_win, 2, 1L<<0, handle_keypress, &img);
	mlx_hook(img.mlx_win, 6, 1L<<6, handle_mouse, &img);
	mlx_loop_hook(img.mlx, render, &img);
	mlx_loop(mlx);
}
EOF
cat > test_versions/ver_6.c << 'EOF'
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ver_6.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 14:32:02 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../inc/solong.h"

/*Experimented with adding a background image and filling the whole screen a 
solid color by simple pointer arithmetic. Attempted to create a rainbow
background by only adding to the color value. Figured out a way around MLXs
limitations regarding having only 1 parameter in the render function, by creating
an umbrella struct that holds all image layers.*/

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
		data->x += 20/2;
	if (keycode == 97 || keycode == 65361)
		data->x -= 20/2;
	if (keycode == 115 || keycode == 65364)
		data->y += 20/2;
	if (keycode == 119 || keycode == 65362)
		data->y -= 20/2;
	racc_print(1, "%e %d, %d, %d %e\n", "racc", keycode, data->x, data->y, "racc");
	return (0);
}

int handle_mouse(int x, int y, t_data *data)
{
	while(x-50/2 < data->x)
		data->x--;
	while(x-50/2 > data->x)
		data->x++;
	while(y-50/2 < data->y)
		data->y--;
	while(y-50/2 > data->y)
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
	static double color = 0; 
	char *end;

	end = img->addr + ((1080/2) * img->bytes_per_row);
	dst = img->addr;

	while (dst <= end) 
	{ 
		*(unsigned int*)dst = color; 
		dst += (img->bits_per_pixel / 8); 
	}
	mlx_put_image_to_window(img->mlx, img->mlx_win, img->img, img->x, img->y); 

	color += 0.1;
	if(color == 0x00FFFFFF) 
		color = 0; 
	return(0); 
}

int render_character(t_data *img) 
{ 
	static int x = 0;
	static int y = 0; 

	my_mlx_pixel_put(img, x, y, 0xFF37FA85);
	mlx_put_image_to_window(img->mlx, img->mlx_win, img->img, img->x, img->y);
	if (x < 100/2 && y == 0)
	{ 
		x++;
		return(0);
	} 
	else if (y < 100/2 && x == 100/2)
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

	mlx_win = mlx_new_window(mlx, 1920/2, 1080/2, "Mapache's box'o fun");
	layers.chara.img = mlx_new_image(mlx, 102/2, 102/2);
	layers.bkgrnd.img = mlx_new_image(mlx, 1920/2, 1080/2);
	layers.chara.mlx = mlx;
	layers.bkgrnd.mlx = mlx;
	layers.chara.mlx_win = mlx_win;
	layers.bkgrnd.mlx_win = mlx_win;
	layers.bkgrnd.addr = mlx_get_data_addr(layers.bkgrnd.img, &layers.bkgrnd.bits_per_pixel, &layers.bkgrnd.bytes_per_row, &layers.bkgrnd.endian);
	layers.chara.addr = mlx_get_data_addr(layers.chara.img, &layers.chara.bits_per_pixel, &layers.chara.bytes_per_row, &layers.chara.endian);
	layers.bkgrnd.x = 0;
	layers.bkgrnd.y = 0;
	layers.chara.x = 910/2;
	layers.chara.y = 500/2;
	mlx_hook(layers.chara.mlx_win, 2, 1L<<0, handle_keypress, &layers.chara);
	mlx_hook(layers.chara.mlx_win, 6, 1L<<6, handle_mouse, &layers.chara);
	mlx_loop_hook(layers.bkgrnd.mlx, render, &layers);
	mlx_loop(mlx);
}

EOF
cat > test_versions/ver_7.c << 'EOF'
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ver_7.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 14:32:08 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../inc/solong.h"

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
		data->x += 20/2;
	if (keycode == 97 || keycode == 65361)
		data->x -= 20/2;
	if (keycode == 115 || keycode == 65364)
		data->y += 20/2;
	if (keycode == 119 || keycode == 65362)
		data->y -= 20/2;
	racc_print(1, "%e %d, %d, %d %e\n", "racc", keycode, data->x, data->y, "racc");
	return (0);
}

int handle_mouse(int x, int y, t_data *data)
{
	while(x-50/2 < data->x)
		data->x--;
	while(x-50/2 > data->x)
		data->x++;
	while(y-50/2 < data->y)
		data->y--;
	while(y-50/2 > data->y)
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

	end = img->addr + (1080/2 * img->bytes_per_row);
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
	if (x < 100/2 && y == 0)
	{ 
		x++;
		return(0);
	} 
	else if (y < 100/2 && x == 100/2)
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

	mlx_win = mlx_new_window(mlx, 1920/2, 1080/2, "Mapache's box'o fun");
	layers.chara.img = mlx_new_image(mlx, 102/2, 102/2);
	layers.bkgrnd.img = mlx_new_image(mlx, 1920/2, 1080/2);
	layers.chara.mlx = mlx;
	layers.bkgrnd.mlx = mlx;
	layers.chara.mlx_win = mlx_win;
	layers.bkgrnd.mlx_win = mlx_win;
	layers.bkgrnd.addr = mlx_get_data_addr(layers.bkgrnd.img, &layers.bkgrnd.bits_per_pixel, &layers.bkgrnd.bytes_per_row, &layers.bkgrnd.endian);
	layers.chara.addr = mlx_get_data_addr(layers.chara.img, &layers.chara.bits_per_pixel, &layers.chara.bytes_per_row, &layers.chara.endian);
	layers.bkgrnd.x = 0;
	layers.bkgrnd.y = 0;
	layers.chara.x = 910/2;
	layers.chara.y = 500/2;
	mlx_hook(layers.chara.mlx_win, 2, 1L<<0, handle_keypress, &layers.chara);
	mlx_hook(layers.chara.mlx_win, 6, 1L<<6, handle_mouse, &layers.chara);
	mlx_loop_hook(layers.bkgrnd.mlx, render, &layers);
	mlx_loop(mlx);
}

EOF
cat > test_versions/ver_8.c << 'EOF'
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ver_8.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 14:32:17 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../inc/solong.h"

/*Experimented with sin to make the background color transition smoother, and
to be able to control its speed easily*/

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
	double t_increment;
}				t_data;

typedef struct	s_datapack
{
	t_data	chara;
	t_data	bkgrnd;
}				t_datapack;

int handle_keypress(int keycode, t_datapack *data)
{
	if (keycode == 65307)
	{
		mlx_destroy_window(data->chara.mlx, data->chara.mlx_win);
		exit (0);
	}
	if (keycode == 100 || keycode == 65363)
	{
		data->chara.x += 20/2;
		data->bkgrnd.t_increment += 0.0005;
	}
	if (keycode == 97 || keycode == 65361)
	{
		data->chara.x -= 20/2;
		data->bkgrnd.t_increment -= 0.0005;
	}
	if (keycode == 115 || keycode == 65364)
		data->chara.y += 20/2;
	if (keycode == 119 || keycode == 65362)
		data->chara.y -= 20/2;
	printf("🦝 %d, %d, %d, %f 🦝\n", keycode, data->chara.x, data->chara.y, data->bkgrnd.t_increment);
	return (0);
}

int handle_mouse(int x, int y, t_data *data)
{
	while(x-50/2 < data->x)
		data->x--;
	while(x-50/2 > data->x)
		data->x++;
	while(y-50/2 < data->y)
		data->y--;
	while(y-50/2 > data->y)
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
	static double t = 0;
	int r, g, b;
	int color;

	r = (int)(sin(t) * 127 + 128);
	g = (int)(sin(t + 2.094) * 127 + 128);
	b = (int)(sin(t + 4.188) * 127 + 128);

	color = (r << 16) | (g << 8) | b;

	end = img->addr + (1080/2 * img->bytes_per_row);
	dst = img->addr;

	while (dst < end)
	{
		*(unsigned int*)dst = color;
		dst += (img->bits_per_pixel / 8);
	}
	t += img->t_increment; 
	if (t > 2 * M_PI)
		t -= 2 * M_PI;

	return (0);
}

int render_character(t_data *img) 
{ 
	static int x = 0;
	static int y = 0; 

	my_mlx_pixel_put(img, x, y, 0xFF37FA85);
	mlx_put_image_to_window(img->mlx, img->mlx_win, img->img, img->x, img->y);
	if (x < 100/2 && y == 0)
	{ 
		x++;
		return(0);
	} 
	else if (y < 100/2 && x == 100/2)
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

	mlx_win = mlx_new_window(mlx, 1920/2, 1080/2, "Mapache's box'o fun");
	layers.chara.img = mlx_new_image(mlx, 103/2, 103/2);
	layers.bkgrnd.img = mlx_new_image(mlx, 1920/2, 1080/2);
	layers.chara.mlx = mlx;
	layers.bkgrnd.mlx = mlx;
	layers.chara.mlx_win = mlx_win;
	layers.bkgrnd.mlx_win = mlx_win;
	layers.bkgrnd.addr = mlx_get_data_addr(layers.bkgrnd.img, &layers.bkgrnd.bits_per_pixel, &layers.bkgrnd.bytes_per_row, &layers.bkgrnd.endian);
	layers.chara.addr = mlx_get_data_addr(layers.chara.img, &layers.chara.bits_per_pixel, &layers.chara.bytes_per_row, &layers.chara.endian);
	layers.bkgrnd.x = 0;
	layers.bkgrnd.y = 0;
	layers.chara.x = 910/2;
	layers.chara.y = 500/2;
	layers.bkgrnd.t_increment = 0.001;
	mlx_hook(layers.chara.mlx_win, 2, 1L<<0, handle_keypress, &layers);
	mlx_hook(layers.chara.mlx_win, 6, 1L<<6, handle_mouse, &layers.chara);
	mlx_loop_hook(layers.bkgrnd.mlx, render, &layers);
	mlx_loop(mlx);
}

EOF
cat > test_versions/ver_9.c << 'EOF'
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
		data->x += 20/2;
	if (keycode == 97 || keycode == 65361)
		data->x -= 20/2;
	if (keycode == 115 || keycode == 65364)
		data->y += 20/2;
	if (keycode == 119 || keycode == 65362)
		data->y -= 20/2;
	racc_print(1, "%e %d, %d, %d %e\n", "racc", keycode, data->x, data->y, "racc");
	return (0);
}

int handle_mouse(int x, int y, t_data *data)
{
	while(x-50/2 < data->x)
		data->x--;
	while(x-50/2 > data->x)
		data->x++;
	while(y-50/2 < data->y)
		data->y--;
	while(y-50/2 > data->y)
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

	end = img->addr + (1080/2 * img->bytes_per_row);
	dst = img->addr;

	while (dst < end)
	{
		*(unsigned int*)dst = color;
		dst += (img->bits_per_pixel / 8);
	}
	t += 0.001; // controls animation speed
	if (t > 2 * M_PI)
		t -= 2 * M_PI; // reset loop 

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

	t_t += 0.001;
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

	mlx_win = mlx_new_window(mlx, 1920/2, 1080/2, "Mapache's box'o fun");
	layers.chara.img = mlx_new_image(mlx, 101, 101);
	layers.bkgrnd.img = mlx_new_image(mlx, 1920/2, 1080/2);
	layers.chara.mlx = mlx;
	layers.bkgrnd.mlx = mlx;
	layers.chara.mlx_win = mlx_win;
	layers.bkgrnd.mlx_win = mlx_win;
	layers.bkgrnd.addr = mlx_get_data_addr(layers.bkgrnd.img, &layers.bkgrnd.bits_per_pixel, &layers.bkgrnd.bytes_per_row, &layers.bkgrnd.endian);
	layers.chara.addr = mlx_get_data_addr(layers.chara.img, &layers.chara.bits_per_pixel, &layers.chara.bytes_per_row, &layers.chara.endian);
	layers.bkgrnd.x = 0;
	layers.bkgrnd.y = 0;
	layers.chara.x = 910/2;
	layers.chara.y = 500/2;
	mlx_hook(layers.chara.mlx_win, 2, 1L<<0, handle_keypress, &layers.chara);
	mlx_hook(layers.chara.mlx_win, 6, 1L<<6, handle_mouse, &layers.chara);
	mlx_loop_hook(layers.bkgrnd.mlx, render, &layers);
	mlx_loop(mlx);
}

EOF
cat > test_versions/ver_10.c << 'EOF'
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
	end = data->addr + (1080/2 * data->bytes_per_row);
	
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

        while (y < 1080/2 && y >= 0 && x < 1920/2 && x >= 0)
        {
        	x = (int)(sin(t + o) * radius + 960/2);
        	y = (int)(cos(t + o) * radius + 540/2);
        	if (y < 1080/2 && y >= 0 && x < 1920/2 && x >= 0)
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
	img.mlx_win = mlx_new_window(img.mlx, 1920/2, 1080/2, "Mapache's Spiral of Sorrows");
	img.img = mlx_new_image(img.mlx, 1920/2, 1080/2);
	img.addr = mlx_get_data_addr(img.img, &img.bits_per_pixel, &img.bytes_per_row, &img.endian);
	
	img.o_increment = 0.0001;
	img.t_increment = 0.00001;
	img.t_t_increment = 0.00001;
	img.radius_increment = 0.01;
	
	mlx_hook(img.mlx_win, 2, 1L<<0, handle_keypress, &img);
	mlx_loop_hook(img.mlx, render_spiral, &img);
	mlx_loop(img.mlx);
}
EOF
cat > test_versions/ver_11.c << 'EOF'
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ver_11.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 14:31:08 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../inc/solong.h"

/*Began working with mlx_xpm_file_to_image. Made it so that the background can
now be a selected .xpm file, and figured out a way pass the movement logic from
the window to the character (circle) drawing logic, in order to merge them in 
one image. Also created a function that "clears" the frame, by making a copy of
the background and using the copy to overwrite the original after each frame. The
controls have been updated so that the character moves around the screen in a loop
instead of getting lost indefinitely.*/

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

int handle_keypress(int keycode, t_data *data)
{	
	if (keycode == 65307)
	{
		mlx_destroy_window(data->mlx, data->mlx_win);
		exit (0);
	}

	if (keycode == 100 || keycode == 65363)
	{
		data->x += 20/2;
		if (data->x >= data->img_width + 100)
			data->x -= data->img_width;
	}
	if (keycode == 97 || keycode == 65361)
	{
		data->x -= 20/2;
		if (data->x < data->img_width - 100)
			data->x += data->img_width;
	}
	if (keycode == 115 || keycode == 65364)
	{
		data->y += 20/2;
		if (data->y >= data->img_height + 100)
			data->y -= data->img_height;
	}
	if (keycode == 119 || keycode == 65362)
	{
		data->y -= 20/2;
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
	return(0);
}

int	main(void)
{
	t_datapack lyrs;
	char	*relative_path = "./textures/Herculy.xpm";

	lyrs.game.mlx = mlx_init();
	lyrs.bkgrn.mlx = lyrs.game.mlx;

	lyrs.bkgrn.img = mlx_xpm_file_to_image(lyrs.bkgrn.mlx, relative_path, &lyrs.bkgrn.img_width, &lyrs.bkgrn.img_height);
	lyrs.game.img_width = lyrs.bkgrn.img_width;
	lyrs.game.img_height = lyrs.bkgrn.img_height;
	lyrs.game.img = mlx_new_image(lyrs.game.mlx, lyrs.game.img_width, lyrs.game.img_height);

	lyrs.game.mlx_win = mlx_new_window(lyrs.game.mlx, 1920/2, 1080/2, "Mapache's box'o fun");
	lyrs.bkgrn.mlx_win = lyrs.game.mlx_win;
	lyrs.game.addr = mlx_get_data_addr(lyrs.game.img, &lyrs.game.bits_per_pixel, &lyrs.game.bytes_per_row, &lyrs.game.endian);
	lyrs.bkgrn.addr = mlx_get_data_addr(lyrs.bkgrn.img, &lyrs.bkgrn.bits_per_pixel, &lyrs.bkgrn.bytes_per_row, &lyrs.bkgrn.endian);

	lyrs.game.x = 1200/2;
	lyrs.game.y = 600/2;

	mlx_hook(lyrs.game.mlx_win, 17, 1L<<0, handle_close, &lyrs.game);
	mlx_hook(lyrs.game.mlx_win, 2, 1L<<0, handle_keypress, &lyrs.game);
	mlx_hook(lyrs.game.mlx_win, 6, 1L<<6, handle_mouse, &lyrs.game);
	
	mlx_loop_hook(lyrs.game.mlx, render, &lyrs);
	mlx_loop(lyrs.game.mlx);
	return(0);
}
EOF
cat > test_versions/ver_12.c << 'EOF'
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ver_12.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 14:31:15 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../inc/solong.h"

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
		data->x += 20/2;
		if (data->x >= data->img_width + 100)
			data->x -= data->img_width;
	}
	if (keycode == 97 || keycode == 65361)
	{
		data->x -= 20/2;
		if (data->x < data->img_width - 100)
			data->x += data->img_width;
	}
	if (keycode == 115 || keycode == 65364)
	{
		data->y += 20/2;
		if (data->y >= data->img_height + 100)
			data->y -= data->img_height;
	}
	if (keycode == 119 || keycode == 65362)
	{
		data->y -= 20/2;
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
	char	*relative_path = "./textures/Seventy.xpm";

	lyrs.game.mlx = mlx_init();
	lyrs.bkgrn.mlx = lyrs.game.mlx;

	lyrs.bkgrn.img = mlx_xpm_file_to_image(lyrs.bkgrn.mlx, relative_path, &lyrs.bkgrn.img_width, &lyrs.bkgrn.img_height);
	lyrs.game.img_width = lyrs.bkgrn.img_width;
	lyrs.game.img_height = lyrs.bkgrn.img_height;
	lyrs.game.img = mlx_new_image(lyrs.game.mlx, lyrs.game.img_width, lyrs.game.img_height);

	lyrs.game.mlx_win = mlx_new_window(lyrs.game.mlx, 1920/2, 1080/2, "Mapache's box'o fun");
	lyrs.bkgrn.mlx_win = lyrs.game.mlx_win;
	lyrs.game.addr = mlx_get_data_addr(lyrs.game.img, &lyrs.game.bits_per_pixel, &lyrs.game.bytes_per_row, &lyrs.game.endian);
	lyrs.bkgrn.addr = mlx_get_data_addr(lyrs.bkgrn.img, &lyrs.bkgrn.bits_per_pixel, &lyrs.bkgrn.bytes_per_row, &lyrs.bkgrn.endian);

	lyrs.game.x = 1200/2;
	lyrs.game.y = 600/2;

	mlx_hook(lyrs.game.mlx_win, 17, 1L<<0, handle_close, &lyrs.game);
	mlx_hook(lyrs.game.mlx_win, 2, 1L<<0, handle_keypress, &lyrs.game);
	mlx_hook(lyrs.game.mlx_win, 6, 1L<<6, handle_mouse, &lyrs.game);
	mlx_hook(lyrs.game.mlx_win, 7, 1L<<4, handle_enter, &lyrs.game);
	
	mlx_loop_hook(lyrs.game.mlx, render, &lyrs);
	mlx_loop(lyrs.game.mlx);
	return(0);
}
EOF
