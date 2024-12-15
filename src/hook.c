/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   hook.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: pnaessen <pnaessen@student.42lyon.fr>      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/12/15 11:47:09 by pnaessen          #+#    #+#             */
/*   Updated: 2024/12/15 12:31:59 by pnaessen         ###   ########lyon.fr   */
/*                                                                            */
/* ************************************************************************** */

#include "fdf.h"

int	mouse_hook(int button, int x, int y, t_data *data)
{
	(void)y;
	(void)x;
	if (button == ZOOM_IN)
		data->scale *= 1.1;
	else if (button == ZOOM_OUT)
		data->scale /= 1.1;
	mlx_clear_window(data->mlx_ptr, data->win_ptr);
	ft_memset(data->addr, 0, WinWidth * WinHeight * (data->bits_per_pixel / 8));
	draw_map(data, data->map);
	return (0);
}

int	key_hook(int keycode, t_data *data)
{
	key_mouv(keycode, data);
	if (keycode == ESC_KEY)
	{
		free_map(data->map);
		mlx_destroy_image(data->mlx_ptr, data->img);
		mlx_destroy_window(data->mlx_ptr, data->win_ptr);
		mlx_destroy_display(data->mlx_ptr);
		free(data->mlx_ptr);
		exit(0);
	}
	if (keycode == A || keycode == D)
	{
		if (keycode == A)
			data->angle = 0;
		if (keycode == D)
			data->angle = Angle;
		mlx_clear_window(data->mlx_ptr, data->win_ptr);
		ft_memset(data->addr, 0, WinWidth * WinHeight * (data->bits_per_pixel
				/ 8));
		draw_map(data, data->map);
		return (0);
	}
	return (0);
}

int	key_mouv(int keycode, t_data *data)
{
	if (keycode == DOWN)
		data->cam_y -= 50;
	if (keycode == UP)
		data->cam_y += 50;
	if (keycode == LEFT)
		data->cam_x += 50;
	if (keycode == RIGHT)
		data->cam_x -= 50;
	mlx_clear_window(data->mlx_ptr, data->win_ptr);
	ft_memset(data->addr, 0, WinWidth * WinHeight * (data->bits_per_pixel / 8));
	draw_map(data, data->map);
	return (0);
}