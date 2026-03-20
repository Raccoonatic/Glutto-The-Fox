/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_animation.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/21 14:20:55 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/25 13:53:15 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../inc/solong.h"

void	sl_ani_init(t_game *g, t_imgdata *i, int f_w);

int	sl_animate(t_game *g)
{
	sl_count_tiles(g -> map, g, 'C');
	if (g -> coins == 0)
		g -> victory = 1;
	if ((sl_now() - g -> time_stamp) > 120)
	{
		g -> time_stamp = sl_now();
		sl_clear_buffer(g -> buf.main, g -> h);
		sl_grounded_check(g -> map, &g -> plyr, g -> plyr.y, g -> plyr.x);
		ls_get_c_frm_idx(&g -> ci);
		sl_main_render(g, ls_get_pst(g, g -> plyr.grounded, &g -> plyr.state));
	}
	return (0);
}

void	sl_ani_init(t_game *g, t_imgdata *i, int f_w)
{
	int	frm_num;

	i -> addr = mlx_get_data_addr(i -> main, &i -> bpx, &i -> bpr, &i -> e);
	frm_num = i -> w / f_w;
	sl_ani_strip_alloc(g, frm_num, &i -> frm, &i -> frad);
	sl_strip_split(g, i, frm_num, f_w);
	i -> mx_index = frm_num;
	return ;
}
