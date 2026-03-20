/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sl_sprite_handling.c                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/17 18:07:19 by lde-san-          #+#    #+#             */
/*   Updated: 2025/11/21 13:05:39 by lde-san-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "solong.h"

static void	sl_push_sprite_to_frame(int ofst[], char *dst, char *src, int f_w);
void		sl_strip_split(t_game *g, t_imgdata *i, int f_num, int f_w);

void	sl_ani_strip_alloc(t_game *g, int f_num, void ***imgs, char ***addrs)
{
	*imgs = ft_calloc(f_num + 1, sizeof(void *));
	if (!imgs)
		sl_kill_the_game(g, 0, 1, 1);
	*addrs = ft_calloc(f_num + 1, sizeof(char *));
	if (!addrs)
		sl_kill_the_game(g, 0, 1, 1);
	return ;
}

void	sl_strip_split(t_game *g, t_imgdata *i, int f_num, int f_w)
{
	int	v[2];
	int	*bpx;
	int	*bpr;
	int	*e;

	bpx = &i -> fbpx;
	bpr = &i -> fbpr;
	e = &i -> fe;
	v[0] = 0;
	v[1] = i -> w;
	while (v[0] < f_num)
	{
		i -> frm[v[0]] = mlx_new_image(g -> mlx, f_w, TSZ);
		if (!i -> frm[v[0]])
			sl_kill_the_game(g, 0, 1, 1);
		i -> frad[v[0]] = mlx_get_data_addr(i -> frm[v[0]], bpx, bpr, e);
		sl_push_sprite_to_frame(v, i -> frad[v[0]], i -> addr, f_w);
		(v[0])++;
	}
	i -> frm[v[0]] = NULL;
	i -> frad[v[0]] = NULL;
	return ;
}

static void	sl_push_sprite_to_frame(int ofst[], char *dst, char *src, int f_w)
{
	char	*d_ptr;
	char	*s_ptr;
	int		y;
	int		x;

	y = 0;
	while (y < TSZ)
	{
		x = 0;
		while (x < (f_w * 4))
		{
			s_ptr = src + ((y * (ofst[1] * 4)) + (x + ((ofst[0] * f_w) * 4)));
			d_ptr = dst + (y * (f_w * 4) + x);
			*(unsigned int *)d_ptr = *(unsigned int *)s_ptr;
			x += 4;
		}
		y++;
	}
}
