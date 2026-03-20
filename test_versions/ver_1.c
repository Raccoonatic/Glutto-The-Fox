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

/*Figured out what's needed to initialize an instance of the graphics engine
(an mlx) and created my first window!*/

/* This section is solely for demonstration purposes: */ typedef struct	s_data {void *mlx; void *mlx_win;} t_data; int handle_keypress(int keycode, t_data *data){if(keycode==65307){mlx_destroy_window(data->mlx, data->mlx_win);exit(0);}return (0);}

int	main(void)
{
	void	*mlx;
	void	*mlx_win;
        t_data  safe_exit;

	mlx = mlx_init();
	mlx_win = mlx_new_window(mlx, 1920, 1080, "Hello world!");
	
/* This section is solely for demonstration purposes: */ safe_exit.mlx = mlx; safe_exit.mlx_win = mlx_win; mlx_hook(safe_exit.mlx_win, 2, 1L<<0, handle_keypress, &safe_exit);
	
	mlx_loop(mlx);
}
