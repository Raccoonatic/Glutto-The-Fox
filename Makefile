# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/10/30 15:46:25 by lde-san-          #+#    #+#              #
#    Updated: 2026/03/20 20:10:47 by lde-san-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = so_long
LIBFT = ./inc/libft/libft.a

NEOR	= \033[3m\033[38;2;255;153;51m
MINT    = \033[1;38;2;55;250;133m
PURP	= \033[1;38;2;174;5;252m
BABY    = \033[38;2;0;255;247m
BLOD	= \033[1;38;2;255;0;0m
LIME    = \033[38;2;0;255;0m
BLAK	= \033[38;2;0;0;0m
B_WI    = \033[1;37m
RSET	= \033[0m

MAIN_F ?= src/so_long_bonus.c
BKGRND ?= ./textures/Herculy.xpm

SRC_DIR = src/
OBJ_DIR = obj/

BONUS = sl_win_bonus.c
BONUS += sl_coin_bonus.c
BONUS += sl_door_bonus.c
BONUS += sl_time_bonus.c
BONUS += sl_enemy_bonus.c
BONUS += sl_render_bonus.c
BONUS += sl_player_bonus.c
BONUS += sl_destroy_bonus.c
BONUS += sl_zeroing_bonus.c
BONUS += sl_terrain_bonus.c
BONUS += sl_animation_bonus.c
BONUS += sl_exit_game_bonus.c
BONUS += sl_check_map_bonus.c
BONUS += sl_coordinate_bonus.c
BONUS += sl_flood_fill_bonus.c
BONUS += sl_layer_init_bonus.c
BONUS += sl_text_to_map_bonus.c
BONUS += sl_map_init_utils_bonus.c
BONUS += sl_sprite_handling_bonus.c

SRC_BONUS = $(addprefix $(SRC_DIR),$(BONUS))
OBJ_BONUS = $(SRC_BONUS:$(SRC_DIR)%.c=$(OBJ_DIR)%.o)

.PRECIOUS: $(SRC_BONUS)

WERROR ?= -Werror 
COMPILE = cc -g -O0 -D BKND=\"$(BKGRND)\" -Wall $(WERROR)-Wextra -I./inc -I./inc/mlx_linux

all: $(NAME)

$(NAME): $(LIBFT) ./inc/mlx_linux/libmlx.a ./inc/mlx_linux/libmlx_Linux.a $(OBJ_BONUS) ./inc/solong_bonus.h
	@printf "$(BABY)"
	$(COMPILE) $(MAIN_F) $(OBJ_BONUS) $(LIBFT) -L./inc/mlx_linux -lmlx_Linux -L/usr/lib -lXext -lX11 -lm -lz -o $(NAME)
	@printf "$(MINT)"
	@ls -la
	@printf "$(RSET)"

$(OBJ_DIR)%.o: $(SRC_DIR)%.c | $(OBJ_DIR)
	@printf "$(PURP)"
	$(COMPILE) -I/usr/include -I./inc/mlx_linux -c $< -o $@
	@printf "$(RSET)"

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

open:
	@printf "$(MINT)"
	for f in $(SRC_BONUS); do xdg-open $$f; done
	@sleep 0.3
	@printf "$(LIME)"
	find . -maxdepth 2 -name "*.h" -exec xdg-open {} \;
	@printf "$(RSET)"

$(LIBFT):
	@printf "$(NEOR)"
	@make -C ./inc/libft
	@printf "$(RSET)"

clean:
	@printf "$(LIME)"
	@make -C ./inc/libft clean
	@sleep 0.3
	@printf "$(BLOD)"
	rm -rf $(OBJ_DIR)
	@rm -rf ./src/test_versions
	@sleep 0.3
	@printf "$(RSET)"

fclean: clean
	@printf "$(B_WI)"
	@make -C ./inc/libft fclean
	@sleep 0.3
	@printf "$(PURP)"
	rm -f $(NAME)
	@printf "$(MINT)"
	@sleep 0.3
	@ls -la
	@printf "$(RSET)"

re: fclean all

./inc/mlx_linux/libmlx.a:
	@make -C ./inc/mlx_linux
./inc/mlx_linux/libmlx_Linux.a:
	@make -C ./inc/mlx_linux

mlx_dependencies:
	@printf "$(MINT)\n\t\t🦝 Loading up the goodies! 🦝\n\n"
	@sleep 0.5
	@printf "$(NEOR)Upgrading current packages... \n\n"
	@sleep 1
	@printf "$(LIME)"
	@sudo apt-get update || true
	@sudo apt-get upgrade || true
	@printf "$(RSET)\n\n"
	@sleep 0.5
	@printf "$(NEOR)Installing requirements... \n\n"
	sudo apt-get install xorg || true
	sudo apt-get install libxext-dev || true
	sudo apt-get install zlib1g-dev || true
	sudo apt-get install libbsd-dev || true
	@sleep 1
	@printf "$(PURP)"
	@printf "$(RSET)\n"
	@sleep 1
	@printf "$(MINT)\t\t🦝 All requirements should be installed! 🦝\n\n"
	@printf "$(RSET)"

evolution: ./inc/mlx_linux/libmlx_Linux.a ./src/version_maker.sh
	@printf "$(MINT)\n\t🦝 Hope you are ready for a trip down memory lane! 🦝\n\n"
	@sleep 1
	@printf "\t\t\t     Let's go!\n\n"
	@sleep 0.5
	@printf "$(PURP)"
	@./src/version_maker.sh
	@rm -rf ./src/version_maker.sh
	@printf "\n\nMaking Version_1$(RSET)\n\n"
	@sleep 1
	@open src/test_versions/ver_1.c
	@rm -rf $(NAME)
	@make WERROR="" MAIN_F=src/test_versions/ver_1.c
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC on the mlx window to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 0.5
	@printf "$(PURP)"
	@printf "\n\nMaking Version_2$(RSET)\n\n"
	@sleep 1
	@open src/test_versions/ver_2.c
	@rm -rf $(NAME)
	@make WERROR="" MAIN_F=src/test_versions/ver_2.c
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC on the mlx window to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 0.5
	@printf "$(PURP)"
	@printf "\n\nMaking Version_3$(RSET)\n\n"
	@sleep 1
	@open src/test_versions/ver_3.c
	@rm -rf $(NAME)
	@make WERROR="" MAIN_F=src/test_versions/ver_3.c
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC on the mlx window to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 0.5
	@printf "$(PURP)"
	@printf "\n\nMaking Version_4$(RSET)\n\n"
	@sleep 1
	@open src/test_versions/ver_4.c
	@rm -rf $(NAME)
	@make WERROR="" MAIN_F=src/test_versions/ver_4.c
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC on the mlx window to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 0.5
	@printf "$(PURP)"
	@printf "\n\nMaking Version_5$(RSET)\n\n"
	@sleep 1
	@open src/test_versions/ver_5.c
	@rm -rf $(NAME)
	@make WERROR="" MAIN_F=src/test_versions/ver_5.c
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC on the mlx window to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 0.5
	@printf "$(PURP)"
	@printf "\n\nMaking Version_6$(RSET)\n\n"
	@sleep 1
	@open src/test_versions/ver_6.c
	@rm -rf $(NAME)
	@make WERROR="" MAIN_F=src/test_versions/ver_6.c
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC on the mlx window to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 0.5
	@printf "$(PURP)"
	@printf "\n\nMaking Version_7$(RSET)\n\n"
	@sleep 1
	@open src/test_versions/ver_7.c
	@rm -rf $(NAME)
	@make WERROR="" MAIN_F=src/test_versions/ver_7.c
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC on the mlx window to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 0.5
	@printf "$(PURP)"
	@printf "\n\nMaking Version_8$(RSET)\n\n"
	@sleep 1
	@open src/test_versions/ver_8.c
	@rm -rf $(NAME)
	@make WERROR="" MAIN_F=src/test_versions/ver_8.c
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC on the mlx window to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 0.5
	@printf "$(PURP)"
	@printf "\n\nMaking Version_9$(RSET)\n\n"
	@sleep 1
	@open src/test_versions/ver_9.c
	@rm -rf $(NAME)
	@make WERROR="" MAIN_F=src/test_versions/ver_9.c
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC on the mlx window to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 0.5
	@printf "$(PURP)"
	@printf "\n\nMaking Version_10$(RSET)\n\n"
	@sleep 1
	@open src/test_versions/ver_10.c
	@rm -rf $(NAME)
	@make WERROR="" MAIN_F=src/test_versions/ver_10.c
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC on the mlx window to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 0.5
	@printf "$(PURP)"
	@printf "\n\nMaking Version_11$(RSET)\n\n"
	@sleep 1
	@open src/test_versions/ver_11.c
	@rm -rf $(NAME)
	@make WERROR="" MAIN_F=src/test_versions/ver_11.c
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC on the mlx window to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 0.5
	@printf "$(PURP)"
	@printf "\n\nMaking Version_12$(RSET)\n\n"
	@sleep 1
	@open src/test_versions/ver_12.c
	@rm -rf $(NAME)
	@make WERROR="" MAIN_F=src/test_versions/ver_12.c
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC on the mlx window to continue... $(RSET)\n\n"
	./$(NAME)
	@make fclean

.PHONY: all clean fclean re open mlx_dependencies evolution src/version_maker.sh

./src/version_maker.sh:
	@printf "🦝 \001\033[3m\033[38;2;255;153;51m\002Building src/version_maker.sh... 🦝\\n"
	@> src/version_maker.sh
	@printf "%b%s%b\n" '\001\033[1;38;2;0;255;247m\002' '# **************************************************************************** #' '\001\033[0m\002'
	@printf "%s\n" '# **************************************************************************** #' >> src/version_maker.sh
	@printf "%b%s%b\n" '\001\033[1;38;2;0;255;247m\002' '#                                                                              #' '\001\033[0m\002'
	@printf "%s\n" '#                                                                              #' >> src/version_maker.sh
	@printf "%b%s%b\n" '\001\033[1;38;2;0;255;247m\002' '#                                                         :::      ::::::::    #' '\001\033[0m\002'
	@printf "%s\n" '#                                                         :::      ::::::::    #' >> src/version_maker.sh
	@printf "%b%s%b%s%b%s%b\n" '\001\033[1;38;2;0;255;247m\002' '#    ' '\001\033[1;38;2;55;250;133m\002' 'version_maker.sh                              ' '\001\033[1;38;2;0;255;247m\002' '     :+:      :+:    :+:    #' '\001\033[0m\002'
	@printf "%s\n" '#    version_maker.sh                                   :+:      :+:    :+:    #' >> src/version_maker.sh
	@printf "%b%s%b\n" '\001\033[1;38;2;0;255;247m\002' '#                                                     +:+ +:+         +:+      #' '\001\033[0m\002'
	@printf "%s\n" '#                                                     +:+ +:+         +:+      #' >> src/version_maker.sh
	@printf "%b%s%b%s%b%s%b\n" '\001\033[1;38;2;0;255;247m\002' '#    ' '\001\033[1;38;2;55;250;133m\002' 'By: lde-san- <lde-san-@student.42porto.co     ' '\001\033[1;38;2;0;255;247m\002' ' +#+  +:+       +#+         #' '\001\033[0m\002'
	@printf "%s\n" '#    By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+         #' >> src/version_maker.sh
	@printf "%b%s%b\n" '\001\033[1;38;2;0;255;247m\002' '#                                                 +#+#+#+#+#+   +#+            #' '\001\033[0m\002'
	@printf "%s\n" '#                                                 +#+#+#+#+#+   +#+            #' >> src/version_maker.sh
	@printf "%b%s%b%s%b%s%b\n" '\001\033[1;38;2;0;255;247m\002' '#    ' '\001\033[1;38;2;0;255;0m\002' 'Created: 2026/04/04 13:30:42 by lde-san-      ' '\001\033[1;38;2;0;255;247m\002' '    #+#    #+#              #' '\001\033[0m\002'
	@printf "%s\n" '#    Created: 2026/04/04 13:30:42 by lde-san-          #+#    #+#              #' >> src/version_maker.sh
	@printf "%b%s%b%s%b%s%b\n" '\001\033[1;38;2;0;255;247m\002' '#    ' '\001\033[1;38;2;0;255;0m\002' 'Updated: 2026/04/04 13:43:28 by lde-san-      ' '\001\033[1;38;2;0;255;247m\002' '   ###   ########.fr        #' '\001\033[0m\002'
	@printf "%s\n" '#    Updated: 2026/04/04 13:43:28 by lde-san-         ###   ########.fr        #' >> src/version_maker.sh
	@printf "%b%s%b\n" '\001\033[1;38;2;0;255;247m\002' '#                                                                              #' '\001\033[0m\002'
	@printf "%s\n" '#                                                                              #' >> src/version_maker.sh
	@printf "%b%s%b\n" '\001\033[1;38;2;0;255;247m\002' '# **************************************************************************** #' '\001\033[0m\002'
	@printf "%s\n" '# **************************************************************************** #' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '#!bin/bash' >> src/version_maker.sh
	@printf "%s\n" 'mkdir src/test_versions' >> src/version_maker.sh
	@printf "%s\n" 'cat > src/test_versions/ver_1.c << '\''EOF'\''' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                        :::      ::::::::   */' >> src/version_maker.sh
	@printf "%s\n" '/*   ver_1.c                                            :+:      :+:    :+:   */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                    +:+ +:+         +:+     */' >> src/version_maker.sh
	@printf "%s\n" '/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                +#+#+#+#+#+   +#+           */' >> src/version_maker.sh
	@printf "%s\n" '/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */' >> src/version_maker.sh
	@printf "%s\n" '/*   Updated: 2025/11/25 14:31:25 by lde-san-         ###   ########.fr       */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '#include "../../inc/solong.h"' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '/*Figured out what'\''s needed to initialize an instance of the graphics engine' >> src/version_maker.sh
	@printf "%s\n" '(an mlx) and created my first window!*/' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '/* This section is solely for demonstration purposes: */ typedef struct	s_data {void *mlx; void *mlx_win;} t_data; int handle_keypress(int keycode, t_data *data){if(keycode==65307){mlx_destroy_window(data->mlx, data->mlx_win);exit(0);}return (0);}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int	main(void)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '    t_data  safe_exit;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	mlx = mlx_init();' >> src/version_maker.sh
	@printf "%s\n" '	mlx_win = mlx_new_window(mlx, 960, 540, "Hello world!");' >> src/version_maker.sh
	@printf "%s\n" '	' >> src/version_maker.sh
	@printf "%s\n" '/* This section is solely for demonstration purposes: */ safe_exit.mlx = mlx; safe_exit.mlx_win = mlx_win; mlx_hook(safe_exit.mlx_win, 2, 1L<<0, handle_keypress, &safe_exit);' >> src/version_maker.sh
	@printf "%s\n" '	' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop(mlx);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" 'EOF' >> src/version_maker.sh
	@printf "%s\n" 'cat > src/test_versions/ver_2.c << '\''EOF'\''' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                        :::      ::::::::   */' >> src/version_maker.sh
	@printf "%s\n" '/*   ver_2.c                                            :+:      :+:    :+:   */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                    +:+ +:+         +:+     */' >> src/version_maker.sh
	@printf "%s\n" '/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                +#+#+#+#+#+   +#+           */' >> src/version_maker.sh
	@printf "%s\n" '/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */' >> src/version_maker.sh
	@printf "%s\n" '/*   Updated: 2025/11/25 14:31:31 by lde-san-         ###   ########.fr       */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '#include "../../inc/solong.h"' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '/*Figured out how to display a pixel*/' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'typedef struct	s_data ' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*img;' >> src/version_maker.sh
	@printf "%s\n" '	char	*addr;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	int		bits_per_pixel;' >> src/version_maker.sh
	@printf "%s\n" '	int		line_length;' >> src/version_maker.sh
	@printf "%s\n" '	int		endian;' >> src/version_maker.sh
	@printf "%s\n" '}				t_data;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '/* This section is solely for demonstration purposes: */ int handle_keypress(int keycode, t_data *data){if(keycode==65307){mlx_destroy_window(data->mlx, data->mlx_win);exit(0);}return (0);}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'void	my_mlx_pixel_put(t_data *data, int x, int y, int color)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	char	*dst;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	dst = data->addr + (y * data->line_length + x * (data->bits_per_pixel / 8));' >> src/version_maker.sh
	@printf "%s\n" '	*(unsigned int*)dst = color;' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int	main(void)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	t_data	img;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	mlx = mlx_init();' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	mlx = mlx_init();' >> src/version_maker.sh
	@printf "%s\n" '	mlx_win = mlx_new_window(mlx, 960, 540, "Hello world!");' >> src/version_maker.sh
	@printf "%s\n" '	' >> src/version_maker.sh
	@printf "%s\n" '	img.img = mlx_new_image(mlx, 960, 540);' >> src/version_maker.sh
	@printf "%s\n" '	img.mlx = mlx;' >> src/version_maker.sh
	@printf "%s\n" '	img.mlx_win = mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	img.addr = mlx_get_data_addr(img.img, &img.bits_per_pixel, &img.line_length, &img.endian);' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	my_mlx_pixel_put(&img, (960/2), (540/2), 0xFF37FA85);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_put_image_to_window(img.mlx, img.mlx_win, img.img, 0, 0);' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '/* This section is solely for demonstration purposes: */ mlx_hook(img.mlx_win, 2, 1L<<0, handle_keypress, &img);	' >> src/version_maker.sh
	@printf "%s\n" '	' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop(mlx);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" 'EOF' >> src/version_maker.sh
	@printf "%s\n" 'cat > src/test_versions/ver_3.c << '\''EOF'\''' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                        :::      ::::::::   */' >> src/version_maker.sh
	@printf "%s\n" '/*   ver_3.c                                            :+:      :+:    :+:   */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                    +:+ +:+         +:+     */' >> src/version_maker.sh
	@printf "%s\n" '/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                +#+#+#+#+#+   +#+           */' >> src/version_maker.sh
	@printf "%s\n" '/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */' >> src/version_maker.sh
	@printf "%s\n" '/*   Updated: 2025/11/25 14:31:37 by lde-san-         ###   ########.fr       */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '#include "../../inc/solong.h"' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '/*Figured out how to use the mlx_loop_hook function to increment the x and y' >> src/version_maker.sh
	@printf "%s\n" 'axis, displaying the point on different places in the screen to draw lines and' >> src/version_maker.sh
	@printf "%s\n" 'create the illusion of motion.*/' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'typedef struct	s_data ' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*img;' >> src/version_maker.sh
	@printf "%s\n" '	char	*addr;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	int		bits_per_pixel;' >> src/version_maker.sh
	@printf "%s\n" '	int		line_length;' >> src/version_maker.sh
	@printf "%s\n" '	int		endian;' >> src/version_maker.sh
	@printf "%s\n" '}				t_data;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '/* This section is solely for demonstration purposes: */ int handle_keypress(int keycode, t_data *data){if(keycode==65307){mlx_destroy_window(data->mlx, data->mlx_win);exit(0);}return (0);}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'void	my_mlx_pixel_put(t_data *data, int x, int y, int color)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	char	*dst;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	dst = data->addr + (y * data->line_length + x * (data->bits_per_pixel / 8));' >> src/version_maker.sh
	@printf "%s\n" '	*(unsigned int*)dst = color;' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render(t_data *img) ' >> src/version_maker.sh
	@printf "%s\n" '{ ' >> src/version_maker.sh
	@printf "%s\n" '	static int x = 0;' >> src/version_maker.sh
	@printf "%s\n" '	static int y = 0; ' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	my_mlx_pixel_put(img, x, y, 0xFF37FA85);' >> src/version_maker.sh
	@printf "%s\n" '	x++;' >> src/version_maker.sh
	@printf "%s\n" '	if (y < (1080/2))' >> src/version_maker.sh
	@printf "%s\n" '		y++;' >> src/version_maker.sh
	@printf "%s\n" '	my_mlx_pixel_put(img, x, y, 0xFF37FA85);' >> src/version_maker.sh
	@printf "%s\n" '	if (y < (1080/2))' >> src/version_maker.sh
	@printf "%s\n" '		y++;' >> src/version_maker.sh
	@printf "%s\n" '	my_mlx_pixel_put(img, x, y, 0xFF37FA85);' >> src/version_maker.sh
	@printf "%s\n" '	if (y < (1080/2))' >> src/version_maker.sh
	@printf "%s\n" '		y++;' >> src/version_maker.sh
	@printf "%s\n" '	my_mlx_pixel_put(img, x, y, 0xFF37FA85);' >> src/version_maker.sh
	@printf "%s\n" '	if (y < (1080/2))' >> src/version_maker.sh
	@printf "%s\n" '		y++;' >> src/version_maker.sh
	@printf "%s\n" '	my_mlx_pixel_put(img, x, y, 0xFF37FA85);' >> src/version_maker.sh
	@printf "%s\n" '	if (y < (1080/2))' >> src/version_maker.sh
	@printf "%s\n" '		y++;' >> src/version_maker.sh
	@printf "%s\n" '	my_mlx_pixel_put(img, x, y, 0xFF37FA85);' >> src/version_maker.sh
	@printf "%s\n" '	if (x > (1920/2))' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		x = 0;' >> src/version_maker.sh
	@printf "%s\n" '		if (y < (1080/2))' >> src/version_maker.sh
	@printf "%s\n" '			y++;' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (y == (1080/2))' >> src/version_maker.sh
	@printf "%s\n" '		y = 0;' >> src/version_maker.sh
	@printf "%s\n" '	mlx_put_image_to_window(img->mlx, img->mlx_win, img->img, 0, 0);' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int	main(void)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	t_data	img;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	mlx = mlx_init();' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	mlx = mlx_init();' >> src/version_maker.sh
	@printf "%s\n" '	mlx_win = mlx_new_window(mlx, 960, 540, "Hello world!");' >> src/version_maker.sh
	@printf "%s\n" '	img.img = mlx_new_image(mlx, 960, 540);' >> src/version_maker.sh
	@printf "%s\n" '	img.mlx = mlx;' >> src/version_maker.sh
	@printf "%s\n" '	img.mlx_win = mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	img.addr = mlx_get_data_addr(img.img, &img.bits_per_pixel, &img.line_length, &img.endian);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop_hook(img.mlx, render, &img);' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '/* This section is solely for demonstration purposes: */ mlx_hook(img.mlx_win, 2, 1L<<0, handle_keypress, &img);' >> src/version_maker.sh
	@printf "%s\n" '	' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop(mlx);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" 'EOF' >> src/version_maker.sh
	@printf "%s\n" 'cat > src/test_versions/ver_4.c << '\''EOF'\''' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                        :::      ::::::::   */' >> src/version_maker.sh
	@printf "%s\n" '/*   ver_4.c                                            :+:      :+:    :+:   */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                    +:+ +:+         +:+     */' >> src/version_maker.sh
	@printf "%s\n" '/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                +#+#+#+#+#+   +#+           */' >> src/version_maker.sh
	@printf "%s\n" '/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */' >> src/version_maker.sh
	@printf "%s\n" '/*   Updated: 2025/11/25 14:31:43 by lde-san-         ###   ########.fr       */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '#include "../../inc/solong.h"' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '/*Figured out how to use the mlx_loop_hook function to add to a different axis' >> src/version_maker.sh
	@printf "%s\n" 'every couple of frames. Making a square.*/' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'typedef struct	s_data ' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*img;' >> src/version_maker.sh
	@printf "%s\n" '	char	*addr;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	int		bits_per_pixel;' >> src/version_maker.sh
	@printf "%s\n" '	int		line_length;' >> src/version_maker.sh
	@printf "%s\n" '	int		endian;' >> src/version_maker.sh
	@printf "%s\n" '}				t_data;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '/* This section is solely for demonstration purposes: */ int handle_keypress(int keycode, t_data *data){if(keycode==65307){mlx_destroy_window(data->mlx, data->mlx_win);exit(0);}return (0);}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'void	my_mlx_pixel_put(t_data *data, int x, int y, int color)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	char	*dst;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	dst = data->addr + (y * data->line_length + x * (data->bits_per_pixel / 8));' >> src/version_maker.sh
	@printf "%s\n" '	*(unsigned int*)dst = color;' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render(t_data *img) ' >> src/version_maker.sh
	@printf "%s\n" '{ ' >> src/version_maker.sh
	@printf "%s\n" '	static int x = 0;' >> src/version_maker.sh
	@printf "%s\n" '	static int y = 0; ' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	my_mlx_pixel_put(img, x, y, 0xFF37FA85);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_put_image_to_window(img->mlx, img->mlx_win, img->img, 910/2, 500/2);' >> src/version_maker.sh
	@printf "%s\n" '	if (x < 100 && y == 0)' >> src/version_maker.sh
	@printf "%s\n" '	{ ' >> src/version_maker.sh
	@printf "%s\n" '		x++;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	} ' >> src/version_maker.sh
	@printf "%s\n" '	else if (y < 100 && x == 100)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		y++;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	else if (x > 0)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		x--;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	else if (y > 0)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		y--;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int	main(void)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	t_data	img;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	mlx = mlx_init();' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	mlx = mlx_init();' >> src/version_maker.sh
	@printf "%s\n" '	mlx_win = mlx_new_window(mlx, 1920/2, 1080/2, "Hello world!");' >> src/version_maker.sh
	@printf "%s\n" '	img.img = mlx_new_image(mlx, 1920/2, 1080/2);' >> src/version_maker.sh
	@printf "%s\n" '	img.mlx = mlx;' >> src/version_maker.sh
	@printf "%s\n" '	img.mlx_win = mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	img.addr = mlx_get_data_addr(img.img, &img.bits_per_pixel, &img.line_length, &img.endian);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop_hook(img.mlx, render, &img);' >> src/version_maker.sh
	@printf "%s\n" '	' >> src/version_maker.sh
	@printf "%s\n" '/* This section is solely for demonstration purposes: */ mlx_hook(img.mlx_win, 2, 1L<<0, handle_keypress, &img);' >> src/version_maker.sh
	@printf "%s\n" '	' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop(mlx);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" 'EOF' >> src/version_maker.sh
	@printf "%s\n" 'cat > src/test_versions/ver_5.c << '\''EOF'\''' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                        :::      ::::::::   */' >> src/version_maker.sh
	@printf "%s\n" '/*   ver_5.c                                            :+:      :+:    :+:   */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                    +:+ +:+         +:+     */' >> src/version_maker.sh
	@printf "%s\n" '/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                +#+#+#+#+#+   +#+           */' >> src/version_maker.sh
	@printf "%s\n" '/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */' >> src/version_maker.sh
	@printf "%s\n" '/*   Updated: 2025/11/25 14:31:54 by lde-san-         ###   ########.fr       */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '#include "../../inc/solong.h"' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '/*Experimented with keycodes and events to create movement on the square. It can' >> src/version_maker.sh
	@printf "%s\n" 'now move freely in and out the window with WASD and the arrow keys. If the mouse' >> src/version_maker.sh
	@printf "%s\n" 'is on the screen it will follow it, and the ESC key can be used to close the ' >> src/version_maker.sh
	@printf "%s\n" 'window.*/' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'typedef struct	s_data ' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*img;' >> src/version_maker.sh
	@printf "%s\n" '	char	*addr;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	int		bits_per_pixel;' >> src/version_maker.sh
	@printf "%s\n" '	int		line_length;' >> src/version_maker.sh
	@printf "%s\n" '	int		endian;' >> src/version_maker.sh
	@printf "%s\n" '	int	x;' >> src/version_maker.sh
	@printf "%s\n" '	int	y;' >> src/version_maker.sh
	@printf "%s\n" '}				t_data;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int handle_keypress(int keycode, t_data *data)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 65307)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		mlx_destroy_window(data->mlx, data->mlx_win);' >> src/version_maker.sh
	@printf "%s\n" '		exit (0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 100 || keycode == 65363)' >> src/version_maker.sh
	@printf "%s\n" '		data->x += 20/2;' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 97 || keycode == 65361)' >> src/version_maker.sh
	@printf "%s\n" '		data->x -= 20/2;' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 115 || keycode == 65364)' >> src/version_maker.sh
	@printf "%s\n" '		data->y += 20/2;' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 119 || keycode == 65362)' >> src/version_maker.sh
	@printf "%s\n" '		data->y -= 20/2;' >> src/version_maker.sh
	@printf "%s\n" '	racc_print(1, "%e %d, %d, %d %e\n", "racc", keycode, data->x, data->y, "racc");' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int handle_mouse(int x, int y, t_data *data)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	while(x-50/2 < data->x)' >> src/version_maker.sh
	@printf "%s\n" '		data->x--;' >> src/version_maker.sh
	@printf "%s\n" '	while(x-50/2 > data->x)' >> src/version_maker.sh
	@printf "%s\n" '		data->x++;' >> src/version_maker.sh
	@printf "%s\n" '	while(y-50/2 < data->y)' >> src/version_maker.sh
	@printf "%s\n" '		data->y--;' >> src/version_maker.sh
	@printf "%s\n" '	while(y-50/2 > data->y)' >> src/version_maker.sh
	@printf "%s\n" '		data->y++;' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'void	my_mlx_pixel_put(t_data *data, int x, int y, int color)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	char	*dst;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	dst = data->addr + (y * data->line_length + x * (data->bits_per_pixel / 8));' >> src/version_maker.sh
	@printf "%s\n" '	*(unsigned int*)dst = color;' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render(t_data *img) ' >> src/version_maker.sh
	@printf "%s\n" '{ ' >> src/version_maker.sh
	@printf "%s\n" '	static int x = 0;' >> src/version_maker.sh
	@printf "%s\n" '	static int y = 0; ' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	my_mlx_pixel_put(img, x, y, 0xFF37FA85);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_put_image_to_window(img->mlx, img->mlx_win, img->img, img->x, img->y);' >> src/version_maker.sh
	@printf "%s\n" '	if (x < 100 && y == 0)' >> src/version_maker.sh
	@printf "%s\n" '	{ ' >> src/version_maker.sh
	@printf "%s\n" '		x++;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	} ' >> src/version_maker.sh
	@printf "%s\n" '	else if (y < 100 && x == 100)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		y++;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	else if (x > 0)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		x--;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	else if (y > 0)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		y--;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int	main(void)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	t_data	img;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	mlx = mlx_init();' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	mlx = mlx_init();' >> src/version_maker.sh
	@printf "%s\n" '	mlx_win = mlx_new_window(mlx, 1920/2, 1080/2, "Hello world!");' >> src/version_maker.sh
	@printf "%s\n" '	img.img = mlx_new_image(mlx, 101, 101);' >> src/version_maker.sh
	@printf "%s\n" '	img.mlx = mlx;' >> src/version_maker.sh
	@printf "%s\n" '	img.mlx_win = mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	img.x = 910/2;' >> src/version_maker.sh
	@printf "%s\n" '	img.y = 500/2;' >> src/version_maker.sh
	@printf "%s\n" '	img.addr = mlx_get_data_addr(img.img, &img.bits_per_pixel, &img.line_length, &img.endian);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_hook(img.mlx_win, 2, 1L<<0, handle_keypress, &img);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_hook(img.mlx_win, 6, 1L<<6, handle_mouse, &img);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop_hook(img.mlx, render, &img);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop(mlx);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" 'EOF' >> src/version_maker.sh
	@printf "%s\n" 'cat > src/test_versions/ver_6.c << '\''EOF'\''' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                        :::      ::::::::   */' >> src/version_maker.sh
	@printf "%s\n" '/*   ver_6.c                                            :+:      :+:    :+:   */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                    +:+ +:+         +:+     */' >> src/version_maker.sh
	@printf "%s\n" '/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                +#+#+#+#+#+   +#+           */' >> src/version_maker.sh
	@printf "%s\n" '/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */' >> src/version_maker.sh
	@printf "%s\n" '/*   Updated: 2025/11/25 14:32:02 by lde-san-         ###   ########.fr       */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '#include "../../inc/solong.h"' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '/*Experimented with adding a background image and filling the whole screen a ' >> src/version_maker.sh
	@printf "%s\n" 'solid color by simple pointer arithmetic. Attempted to create a rainbow' >> src/version_maker.sh
	@printf "%s\n" 'background by only adding to the color value. Figured out a way around MLXs' >> src/version_maker.sh
	@printf "%s\n" 'limitations regarding having only 1 parameter in the render function, by creating' >> src/version_maker.sh
	@printf "%s\n" 'an umbrella struct that holds all image layers.*/' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'typedef struct	s_data ' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*img;' >> src/version_maker.sh
	@printf "%s\n" '	char	*addr;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	int		bits_per_pixel;' >> src/version_maker.sh
	@printf "%s\n" '	int		bytes_per_row;' >> src/version_maker.sh
	@printf "%s\n" '	int		endian;' >> src/version_maker.sh
	@printf "%s\n" '	int	x;' >> src/version_maker.sh
	@printf "%s\n" '	int	y;' >> src/version_maker.sh
	@printf "%s\n" '}				t_data;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'typedef struct	s_datapack' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	t_data	chara;' >> src/version_maker.sh
	@printf "%s\n" '	t_data	bkgrnd;' >> src/version_maker.sh
	@printf "%s\n" '}				t_datapack;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int handle_keypress(int keycode, t_data *data)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 65307)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		mlx_destroy_window(data->mlx, data->mlx_win);' >> src/version_maker.sh
	@printf "%s\n" '		exit (0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 100 || keycode == 65363)' >> src/version_maker.sh
	@printf "%s\n" '		data->x += 20/2;' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 97 || keycode == 65361)' >> src/version_maker.sh
	@printf "%s\n" '		data->x -= 20/2;' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 115 || keycode == 65364)' >> src/version_maker.sh
	@printf "%s\n" '		data->y += 20/2;' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 119 || keycode == 65362)' >> src/version_maker.sh
	@printf "%s\n" '		data->y -= 20/2;' >> src/version_maker.sh
	@printf "%s\n" '	racc_print(1, "%e %d, %d, %d %e\n", "racc", keycode, data->x, data->y, "racc");' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int handle_mouse(int x, int y, t_data *data)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	while(x-50/2 < data->x)' >> src/version_maker.sh
	@printf "%s\n" '		data->x--;' >> src/version_maker.sh
	@printf "%s\n" '	while(x-50/2 > data->x)' >> src/version_maker.sh
	@printf "%s\n" '		data->x++;' >> src/version_maker.sh
	@printf "%s\n" '	while(y-50/2 < data->y)' >> src/version_maker.sh
	@printf "%s\n" '		data->y--;' >> src/version_maker.sh
	@printf "%s\n" '	while(y-50/2 > data->y)' >> src/version_maker.sh
	@printf "%s\n" '		data->y++;' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'void	my_mlx_pixel_put(t_data *data, int x, int y, int color)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	char	*dst;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	dst = data->addr + (y * data->bytes_per_row + x * (data->bits_per_pixel / 8));' >> src/version_maker.sh
	@printf "%s\n" '	*(unsigned int*)dst = color;' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render_bkgrnd(t_data *img)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	char *dst;' >> src/version_maker.sh
	@printf "%s\n" '	static double color = 0; ' >> src/version_maker.sh
	@printf "%s\n" '	char *end;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	end = img->addr + ((1080/2) * img->bytes_per_row);' >> src/version_maker.sh
	@printf "%s\n" '	dst = img->addr;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	while (dst <= end) ' >> src/version_maker.sh
	@printf "%s\n" '	{ ' >> src/version_maker.sh
	@printf "%s\n" '		*(unsigned int*)dst = color; ' >> src/version_maker.sh
	@printf "%s\n" '		dst += (img->bits_per_pixel / 8); ' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	mlx_put_image_to_window(img->mlx, img->mlx_win, img->img, img->x, img->y); ' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	color += 0.1;' >> src/version_maker.sh
	@printf "%s\n" '	if(color == 0x00FFFFFF) ' >> src/version_maker.sh
	@printf "%s\n" '		color = 0; ' >> src/version_maker.sh
	@printf "%s\n" '	return(0); ' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render_character(t_data *img) ' >> src/version_maker.sh
	@printf "%s\n" '{ ' >> src/version_maker.sh
	@printf "%s\n" '	static int x = 0;' >> src/version_maker.sh
	@printf "%s\n" '	static int y = 0; ' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	my_mlx_pixel_put(img, x, y, 0xFF37FA85);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_put_image_to_window(img->mlx, img->mlx_win, img->img, img->x, img->y);' >> src/version_maker.sh
	@printf "%s\n" '	if (x < 100/2 && y == 0)' >> src/version_maker.sh
	@printf "%s\n" '	{ ' >> src/version_maker.sh
	@printf "%s\n" '		x++;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	} ' >> src/version_maker.sh
	@printf "%s\n" '	else if (y < 100/2 && x == 100/2)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		y++;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	else if (x > 0)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		x--;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	else if (y > 0)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		y--;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render(t_datapack *layers)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	render_bkgrnd(&layers->bkgrnd);' >> src/version_maker.sh
	@printf "%s\n" '	render_character(&layers->chara);' >> src/version_maker.sh
	@printf "%s\n" '	return(0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int	main(void)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	t_datapack layers;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	mlx = mlx_init();' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	mlx_win = mlx_new_window(mlx, 1920/2, 1080/2, "Mapache'\''s box'\''o fun");' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.img = mlx_new_image(mlx, 102/2, 102/2);' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.img = mlx_new_image(mlx, 1920/2, 1080/2);' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.mlx = mlx;' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.mlx = mlx;' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.mlx_win = mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.mlx_win = mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.addr = mlx_get_data_addr(layers.bkgrnd.img, &layers.bkgrnd.bits_per_pixel, &layers.bkgrnd.bytes_per_row, &layers.bkgrnd.endian);' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.addr = mlx_get_data_addr(layers.chara.img, &layers.chara.bits_per_pixel, &layers.chara.bytes_per_row, &layers.chara.endian);' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.x = 0;' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.y = 0;' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.x = 910/2;' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.y = 500/2;' >> src/version_maker.sh
	@printf "%s\n" '	mlx_hook(layers.chara.mlx_win, 2, 1L<<0, handle_keypress, &layers.chara);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_hook(layers.chara.mlx_win, 6, 1L<<6, handle_mouse, &layers.chara);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop_hook(layers.bkgrnd.mlx, render, &layers);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop(mlx);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'EOF' >> src/version_maker.sh
	@printf "%s\n" 'cat > src/test_versions/ver_7.c << '\''EOF'\''' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                        :::      ::::::::   */' >> src/version_maker.sh
	@printf "%s\n" '/*   ver_7.c                                            :+:      :+:    :+:   */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                    +:+ +:+         +:+     */' >> src/version_maker.sh
	@printf "%s\n" '/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                +#+#+#+#+#+   +#+           */' >> src/version_maker.sh
	@printf "%s\n" '/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */' >> src/version_maker.sh
	@printf "%s\n" '/*   Updated: 2025/11/25 14:32:08 by lde-san-         ###   ########.fr       */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '#include "../../inc/solong.h"' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '/*Fixed rainbow background by learning to work bitwise operation. More specifically' >> src/version_maker.sh
	@printf "%s\n" 'the bitwise OR (|) that merges all ON values (1) into the OFF ones (0) */' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'typedef struct	s_data ' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*img;' >> src/version_maker.sh
	@printf "%s\n" '	char	*addr;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	int		bits_per_pixel;' >> src/version_maker.sh
	@printf "%s\n" '	int		bytes_per_row;' >> src/version_maker.sh
	@printf "%s\n" '	int		endian;' >> src/version_maker.sh
	@printf "%s\n" '	int	x;' >> src/version_maker.sh
	@printf "%s\n" '	int	y;' >> src/version_maker.sh
	@printf "%s\n" '}				t_data;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'typedef struct	s_datapack' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	t_data	chara;' >> src/version_maker.sh
	@printf "%s\n" '	t_data	bkgrnd;' >> src/version_maker.sh
	@printf "%s\n" '}				t_datapack;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int handle_keypress(int keycode, t_data *data)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 65307)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		mlx_destroy_window(data->mlx, data->mlx_win);' >> src/version_maker.sh
	@printf "%s\n" '		exit (0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 100 || keycode == 65363)' >> src/version_maker.sh
	@printf "%s\n" '		data->x += 20/2;' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 97 || keycode == 65361)' >> src/version_maker.sh
	@printf "%s\n" '		data->x -= 20/2;' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 115 || keycode == 65364)' >> src/version_maker.sh
	@printf "%s\n" '		data->y += 20/2;' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 119 || keycode == 65362)' >> src/version_maker.sh
	@printf "%s\n" '		data->y -= 20/2;' >> src/version_maker.sh
	@printf "%s\n" '	racc_print(1, "%e %d, %d, %d %e\n", "racc", keycode, data->x, data->y, "racc");' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int handle_mouse(int x, int y, t_data *data)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	while(x-50/2 < data->x)' >> src/version_maker.sh
	@printf "%s\n" '		data->x--;' >> src/version_maker.sh
	@printf "%s\n" '	while(x-50/2 > data->x)' >> src/version_maker.sh
	@printf "%s\n" '		data->x++;' >> src/version_maker.sh
	@printf "%s\n" '	while(y-50/2 < data->y)' >> src/version_maker.sh
	@printf "%s\n" '		data->y--;' >> src/version_maker.sh
	@printf "%s\n" '	while(y-50/2 > data->y)' >> src/version_maker.sh
	@printf "%s\n" '		data->y++;' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'void	my_mlx_pixel_put(t_data *data, int x, int y, int color)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	char	*dst;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	dst = data->addr + (y * data->bytes_per_row + x * (data->bits_per_pixel / 8));' >> src/version_maker.sh
	@printf "%s\n" '	*(unsigned int*)dst = color;' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render_bkgrnd(t_data *img)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	char *dst; ' >> src/version_maker.sh
	@printf "%s\n" '	int color; ' >> src/version_maker.sh
	@printf "%s\n" '	char *end; ' >> src/version_maker.sh
	@printf "%s\n" '	static int r = 255; ' >> src/version_maker.sh
	@printf "%s\n" '	static int g = 0; ' >> src/version_maker.sh
	@printf "%s\n" '	static int b = 0;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	end = img->addr + (1080/2 * img->bytes_per_row);' >> src/version_maker.sh
	@printf "%s\n" '	dst = img->addr;' >> src/version_maker.sh
	@printf "%s\n" '	color = (r<<16 | g<<8 | b);' >> src/version_maker.sh
	@printf "%s\n" '	while (dst <= end) ' >> src/version_maker.sh
	@printf "%s\n" '	{ ' >> src/version_maker.sh
	@printf "%s\n" '		*(unsigned int*)dst = color; ' >> src/version_maker.sh
	@printf "%s\n" '		dst += (img->bits_per_pixel / 8); ' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	' >> src/version_maker.sh
	@printf "%s\n" '	mlx_put_image_to_window(img->mlx, img->mlx_win, img->img, img->x, img->y); ' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	if (r == 255 && g < 255 && b == 0)' >> src/version_maker.sh
	@printf "%s\n" '		g++;' >> src/version_maker.sh
	@printf "%s\n" '	else if (g == 255 && r > 0 && b == 0)' >> src/version_maker.sh
	@printf "%s\n" '		r--;' >> src/version_maker.sh
	@printf "%s\n" '	else if (g == 255 && b < 255 && r == 0)' >> src/version_maker.sh
	@printf "%s\n" '		b++;' >> src/version_maker.sh
	@printf "%s\n" '	else if (b == 255 && g > 0 && r == 0)' >> src/version_maker.sh
	@printf "%s\n" '		g--;' >> src/version_maker.sh
	@printf "%s\n" '	else if (b == 255 && r < 255 && g == 0)' >> src/version_maker.sh
	@printf "%s\n" '		r++;' >> src/version_maker.sh
	@printf "%s\n" '	else if (r == 255 && b > 0 && g == 0)' >> src/version_maker.sh
	@printf "%s\n" '		b--;' >> src/version_maker.sh
	@printf "%s\n" '	return(0); ' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render_character(t_data *img) ' >> src/version_maker.sh
	@printf "%s\n" '{ ' >> src/version_maker.sh
	@printf "%s\n" '	static int x = 0;' >> src/version_maker.sh
	@printf "%s\n" '	static int y = 0; ' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	my_mlx_pixel_put(img, x, y, 0xFF37FA85);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_put_image_to_window(img->mlx, img->mlx_win, img->img, img->x, img->y);' >> src/version_maker.sh
	@printf "%s\n" '	if (x < 100/2 && y == 0)' >> src/version_maker.sh
	@printf "%s\n" '	{ ' >> src/version_maker.sh
	@printf "%s\n" '		x++;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	} ' >> src/version_maker.sh
	@printf "%s\n" '	else if (y < 100/2 && x == 100/2)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		y++;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	else if (x > 0)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		x--;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	else if (y > 0)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		y--;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render(t_datapack *layers)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	render_bkgrnd(&layers->bkgrnd);' >> src/version_maker.sh
	@printf "%s\n" '	render_character(&layers->chara);' >> src/version_maker.sh
	@printf "%s\n" '	return(0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int	main(void)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	t_datapack layers;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	mlx = mlx_init();' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	mlx_win = mlx_new_window(mlx, 1920/2, 1080/2, "Mapache'\''s box'\''o fun");' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.img = mlx_new_image(mlx, 102/2, 102/2);' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.img = mlx_new_image(mlx, 1920/2, 1080/2);' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.mlx = mlx;' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.mlx = mlx;' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.mlx_win = mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.mlx_win = mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.addr = mlx_get_data_addr(layers.bkgrnd.img, &layers.bkgrnd.bits_per_pixel, &layers.bkgrnd.bytes_per_row, &layers.bkgrnd.endian);' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.addr = mlx_get_data_addr(layers.chara.img, &layers.chara.bits_per_pixel, &layers.chara.bytes_per_row, &layers.chara.endian);' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.x = 0;' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.y = 0;' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.x = 910/2;' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.y = 500/2;' >> src/version_maker.sh
	@printf "%s\n" '	mlx_hook(layers.chara.mlx_win, 2, 1L<<0, handle_keypress, &layers.chara);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_hook(layers.chara.mlx_win, 6, 1L<<6, handle_mouse, &layers.chara);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop_hook(layers.bkgrnd.mlx, render, &layers);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop(mlx);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'EOF' >> src/version_maker.sh
	@printf "%s\n" 'cat > src/test_versions/ver_8.c << '\''EOF'\''' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                        :::      ::::::::   */' >> src/version_maker.sh
	@printf "%s\n" '/*   ver_8.c                                            :+:      :+:    :+:   */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                    +:+ +:+         +:+     */' >> src/version_maker.sh
	@printf "%s\n" '/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                +#+#+#+#+#+   +#+           */' >> src/version_maker.sh
	@printf "%s\n" '/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */' >> src/version_maker.sh
	@printf "%s\n" '/*   Updated: 2025/11/25 14:32:17 by lde-san-         ###   ########.fr       */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '#include "../../inc/solong.h"' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '/*Experimented with sin to make the background color transition smoother, and' >> src/version_maker.sh
	@printf "%s\n" 'to be able to control its speed easily*/' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'typedef struct	s_data ' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*img;' >> src/version_maker.sh
	@printf "%s\n" '	char	*addr;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	int		bits_per_pixel;' >> src/version_maker.sh
	@printf "%s\n" '	int		bytes_per_row;' >> src/version_maker.sh
	@printf "%s\n" '	int		endian;' >> src/version_maker.sh
	@printf "%s\n" '	int	x;' >> src/version_maker.sh
	@printf "%s\n" '	int	y;' >> src/version_maker.sh
	@printf "%s\n" '	double t_increment;' >> src/version_maker.sh
	@printf "%s\n" '}				t_data;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'typedef struct	s_datapack' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	t_data	chara;' >> src/version_maker.sh
	@printf "%s\n" '	t_data	bkgrnd;' >> src/version_maker.sh
	@printf "%s\n" '}				t_datapack;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int handle_keypress(int keycode, t_datapack *data)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 65307)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		mlx_destroy_window(data->chara.mlx, data->chara.mlx_win);' >> src/version_maker.sh
	@printf "%s\n" '		exit (0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 100 || keycode == 65363)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		data->chara.x += 20/2;' >> src/version_maker.sh
	@printf "%s\n" '		data->bkgrnd.t_increment += 0.0005;' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 97 || keycode == 65361)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		data->chara.x -= 20/2;' >> src/version_maker.sh
	@printf "%s\n" '		data->bkgrnd.t_increment -= 0.0005;' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 115 || keycode == 65364)' >> src/version_maker.sh
	@printf "%s\n" '		data->chara.y += 20/2;' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 119 || keycode == 65362)' >> src/version_maker.sh
	@printf "%s\n" '		data->chara.y -= 20/2;' >> src/version_maker.sh
	@printf "%s\n" '	printf("🦝 %d, %d, %d, %f 🦝\n", keycode, data->chara.x, data->chara.y, data->bkgrnd.t_increment);' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int handle_mouse(int x, int y, t_data *data)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	while(x-50/2 < data->x)' >> src/version_maker.sh
	@printf "%s\n" '		data->x--;' >> src/version_maker.sh
	@printf "%s\n" '	while(x-50/2 > data->x)' >> src/version_maker.sh
	@printf "%s\n" '		data->x++;' >> src/version_maker.sh
	@printf "%s\n" '	while(y-50/2 < data->y)' >> src/version_maker.sh
	@printf "%s\n" '		data->y--;' >> src/version_maker.sh
	@printf "%s\n" '	while(y-50/2 > data->y)' >> src/version_maker.sh
	@printf "%s\n" '		data->y++;' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'void	my_mlx_pixel_put(t_data *data, int x, int y, int color)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	char	*dst;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	dst = data->addr + (y * data->bytes_per_row + x * (data->bits_per_pixel / 8));' >> src/version_maker.sh
	@printf "%s\n" '	*(unsigned int*)dst = color;' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render_bkgrnd(t_data *img)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	char	*dst;' >> src/version_maker.sh
	@printf "%s\n" '	char	*end;' >> src/version_maker.sh
	@printf "%s\n" '	static double t = 0;' >> src/version_maker.sh
	@printf "%s\n" '	int r, g, b;' >> src/version_maker.sh
	@printf "%s\n" '	int color;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	r = (int)(sin(t) * 127 + 128);' >> src/version_maker.sh
	@printf "%s\n" '	g = (int)(sin(t + 2.094) * 127 + 128);' >> src/version_maker.sh
	@printf "%s\n" '	b = (int)(sin(t + 4.188) * 127 + 128);' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	color = (r << 16) | (g << 8) | b;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	end = img->addr + (1080/2 * img->bytes_per_row);' >> src/version_maker.sh
	@printf "%s\n" '	dst = img->addr;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	while (dst < end)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		*(unsigned int*)dst = color;' >> src/version_maker.sh
	@printf "%s\n" '		dst += (img->bits_per_pixel / 8);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	t += img->t_increment; ' >> src/version_maker.sh
	@printf "%s\n" '	if (t > 2 * M_PI)' >> src/version_maker.sh
	@printf "%s\n" '		t -= 2 * M_PI;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render_character(t_data *img) ' >> src/version_maker.sh
	@printf "%s\n" '{ ' >> src/version_maker.sh
	@printf "%s\n" '	static int x = 0;' >> src/version_maker.sh
	@printf "%s\n" '	static int y = 0; ' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	my_mlx_pixel_put(img, x, y, 0xFF37FA85);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_put_image_to_window(img->mlx, img->mlx_win, img->img, img->x, img->y);' >> src/version_maker.sh
	@printf "%s\n" '	if (x < 100/2 && y == 0)' >> src/version_maker.sh
	@printf "%s\n" '	{ ' >> src/version_maker.sh
	@printf "%s\n" '		x++;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	} ' >> src/version_maker.sh
	@printf "%s\n" '	else if (y < 100/2 && x == 100/2)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		y++;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	else if (x > 0)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		x--;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	else if (y > 0)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		y--;' >> src/version_maker.sh
	@printf "%s\n" '		return(0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render(t_datapack *layers)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	render_bkgrnd(&layers->bkgrnd);' >> src/version_maker.sh
	@printf "%s\n" '	render_character(&layers->chara);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_put_image_to_window(layers->bkgrnd.mlx, layers->bkgrnd.mlx_win, layers->bkgrnd.img, layers->bkgrnd.x, layers->bkgrnd.y);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_put_image_to_window(layers->chara.mlx, layers->chara.mlx_win, layers->chara.img, layers->chara.x, layers->chara.y);' >> src/version_maker.sh
	@printf "%s\n" '	return(0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int	main(void)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	t_datapack layers;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	mlx = mlx_init();' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	mlx_win = mlx_new_window(mlx, 1920/2, 1080/2, "Mapache'\''s box'\''o fun");' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.img = mlx_new_image(mlx, 103/2, 103/2);' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.img = mlx_new_image(mlx, 1920/2, 1080/2);' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.mlx = mlx;' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.mlx = mlx;' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.mlx_win = mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.mlx_win = mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.addr = mlx_get_data_addr(layers.bkgrnd.img, &layers.bkgrnd.bits_per_pixel, &layers.bkgrnd.bytes_per_row, &layers.bkgrnd.endian);' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.addr = mlx_get_data_addr(layers.chara.img, &layers.chara.bits_per_pixel, &layers.chara.bytes_per_row, &layers.chara.endian);' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.x = 0;' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.y = 0;' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.x = 910/2;' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.y = 500/2;' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.t_increment = 0.001;' >> src/version_maker.sh
	@printf "%s\n" '	mlx_hook(layers.chara.mlx_win, 2, 1L<<0, handle_keypress, &layers);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_hook(layers.chara.mlx_win, 6, 1L<<6, handle_mouse, &layers.chara);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop_hook(layers.bkgrnd.mlx, render, &layers);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop(mlx);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'EOF' >> src/version_maker.sh
	@printf "%s\n" 'cat > src/test_versions/ver_9.c << '\''EOF'\''' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                        :::      ::::::::   */' >> src/version_maker.sh
	@printf "%s\n" '/*   ver_9.c                                            :+:      :+:    :+:   */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                    +:+ +:+         +:+     */' >> src/version_maker.sh
	@printf "%s\n" '/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                +#+#+#+#+#+   +#+           */' >> src/version_maker.sh
	@printf "%s\n" '/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */' >> src/version_maker.sh
	@printf "%s\n" '/*   Updated: 2025/11/25 14:32:28 by lde-san-         ###   ########.fr       */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '#include "../../inc/solong.h"' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '/*Experimenting with sin & cos in order to make the character into a circle*/' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'typedef struct	s_data ' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*img;' >> src/version_maker.sh
	@printf "%s\n" '	char	*addr;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	int		bits_per_pixel;' >> src/version_maker.sh
	@printf "%s\n" '	int		bytes_per_row;' >> src/version_maker.sh
	@printf "%s\n" '	int		endian;' >> src/version_maker.sh
	@printf "%s\n" '	int	x;' >> src/version_maker.sh
	@printf "%s\n" '	int	y;' >> src/version_maker.sh
	@printf "%s\n" '}				t_data;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'typedef struct	s_datapack' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	t_data	chara;' >> src/version_maker.sh
	@printf "%s\n" '	t_data	bkgrnd;' >> src/version_maker.sh
	@printf "%s\n" '}				t_datapack;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int handle_keypress(int keycode, t_data *data)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 65307)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		mlx_destroy_window(data->mlx, data->mlx_win);' >> src/version_maker.sh
	@printf "%s\n" '		exit (0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 100 || keycode == 65363)' >> src/version_maker.sh
	@printf "%s\n" '		data->x += 20/2;' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 97 || keycode == 65361)' >> src/version_maker.sh
	@printf "%s\n" '		data->x -= 20/2;' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 115 || keycode == 65364)' >> src/version_maker.sh
	@printf "%s\n" '		data->y += 20/2;' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 119 || keycode == 65362)' >> src/version_maker.sh
	@printf "%s\n" '		data->y -= 20/2;' >> src/version_maker.sh
	@printf "%s\n" '	racc_print(1, "%e %d, %d, %d %e\n", "racc", keycode, data->x, data->y, "racc");' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int handle_mouse(int x, int y, t_data *data)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	while(x-50/2 < data->x)' >> src/version_maker.sh
	@printf "%s\n" '		data->x--;' >> src/version_maker.sh
	@printf "%s\n" '	while(x-50/2 > data->x)' >> src/version_maker.sh
	@printf "%s\n" '		data->x++;' >> src/version_maker.sh
	@printf "%s\n" '	while(y-50/2 < data->y)' >> src/version_maker.sh
	@printf "%s\n" '		data->y--;' >> src/version_maker.sh
	@printf "%s\n" '	while(y-50/2 > data->y)' >> src/version_maker.sh
	@printf "%s\n" '		data->y++;' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'void	my_mlx_pixel_put(t_data *data, int x, int y, int color)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	char	*dst;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	dst = data->addr + (y * data->bytes_per_row + x * (data->bits_per_pixel / 8));' >> src/version_maker.sh
	@printf "%s\n" '	*(unsigned int*)dst = color;' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render_bkgrnd(t_data *img)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	char	*dst;' >> src/version_maker.sh
	@printf "%s\n" '	char	*end;' >> src/version_maker.sh
	@printf "%s\n" '	static double t = 0; // time counter' >> src/version_maker.sh
	@printf "%s\n" '	int r, g, b;' >> src/version_maker.sh
	@printf "%s\n" '	int color;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	// smooth looping RGB values' >> src/version_maker.sh
	@printf "%s\n" '	r = (int)(sin(t) * 127 + 128);' >> src/version_maker.sh
	@printf "%s\n" '	g = (int)(sin(t + 2.094) * 127 + 128);  // +120° phase shift (≈ 2π/3)' >> src/version_maker.sh
	@printf "%s\n" '	b = (int)(sin(t + 4.188) * 127 + 128);  // +240° phase shift (≈ 4π/3)' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	color = (r << 16) | (g << 8) | b;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	end = img->addr + (1080/2 * img->bytes_per_row);' >> src/version_maker.sh
	@printf "%s\n" '	dst = img->addr;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	while (dst < end)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		*(unsigned int*)dst = color;' >> src/version_maker.sh
	@printf "%s\n" '		dst += (img->bits_per_pixel / 8);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	t += 0.001; // controls animation speed' >> src/version_maker.sh
	@printf "%s\n" '	if (t > 2 * M_PI)' >> src/version_maker.sh
	@printf "%s\n" '		t -= 2 * M_PI; // reset loop ' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render_character(t_data *img)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	int x;' >> src/version_maker.sh
	@printf "%s\n" '	int y;' >> src/version_maker.sh
	@printf "%s\n" '	int radius = 50;' >> src/version_maker.sh
	@printf "%s\n" '	double t = 0.001;' >> src/version_maker.sh
	@printf "%s\n" '	static double t_t = 0;' >> src/version_maker.sh
	@printf "%s\n" '	char	*dst;' >> src/version_maker.sh
	@printf "%s\n" '	char	*end;' >> src/version_maker.sh
	@printf "%s\n" '	int r, g, b;' >> src/version_maker.sh
	@printf "%s\n" '	int color;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	r = (int)(sin(t_t) * 127 + 128);' >> src/version_maker.sh
	@printf "%s\n" '	g = (int)(sin(t_t + 2.094) * 127 + 128);' >> src/version_maker.sh
	@printf "%s\n" '	b = (int)(sin(t_t + 4.188) * 127 + 128);' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	color = (r << 16) | (g << 8) | b;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	end = img->addr + (101 * img->bytes_per_row);' >> src/version_maker.sh
	@printf "%s\n" '	dst = img->addr;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	while (dst < end)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		*(unsigned int*)dst = color;' >> src/version_maker.sh
	@printf "%s\n" '		dst += (img->bits_per_pixel / 8);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	t_t += 0.001;' >> src/version_maker.sh
	@printf "%s\n" '	if (t_t > 2 * M_PI)' >> src/version_maker.sh
	@printf "%s\n" '		t_t -= 2 * M_PI;' >> src/version_maker.sh
	@printf "%s\n" '        while (radius-- > 16)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		while (t < 2 * M_PI)' >> src/version_maker.sh
	@printf "%s\n" '		{' >> src/version_maker.sh
	@printf "%s\n" '			x = (int)(cos(t) * radius + 50);' >> src/version_maker.sh
	@printf "%s\n" '			y = (int)(sin(t) * radius + 50);' >> src/version_maker.sh
	@printf "%s\n" '			if (radius > 46 || radius < 20)' >> src/version_maker.sh
	@printf "%s\n" '			{' >> src/version_maker.sh
	@printf "%s\n" '                                my_mlx_pixel_put(img, x, y, 0x000000);' >> src/version_maker.sh
	@printf "%s\n" '			}' >> src/version_maker.sh
	@printf "%s\n" '			else' >> src/version_maker.sh
	@printf "%s\n" '			        my_mlx_pixel_put(img, x, y, 0xFF37FA85);' >> src/version_maker.sh
	@printf "%s\n" '			t += 0.001;' >> src/version_maker.sh
	@printf "%s\n" '		}' >> src/version_maker.sh
	@printf "%s\n" '		t -= 2 * M_PI;' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render(t_datapack *layers)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	render_bkgrnd(&layers->bkgrnd);' >> src/version_maker.sh
	@printf "%s\n" '	render_character(&layers->chara);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_put_image_to_window(layers->bkgrnd.mlx, layers->bkgrnd.mlx_win, layers->bkgrnd.img, layers->bkgrnd.x, layers->bkgrnd.y);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_put_image_to_window(layers->chara.mlx, layers->chara.mlx_win, layers->chara.img, layers->chara.x, layers->chara.y);' >> src/version_maker.sh
	@printf "%s\n" '	return(0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int	main(void)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	t_datapack layers;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	mlx = mlx_init();' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	mlx_win = mlx_new_window(mlx, 1920/2, 1080/2, "Mapache'\''s box'\''o fun");' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.img = mlx_new_image(mlx, 101, 101);' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.img = mlx_new_image(mlx, 1920/2, 1080/2);' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.mlx = mlx;' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.mlx = mlx;' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.mlx_win = mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.mlx_win = mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.addr = mlx_get_data_addr(layers.bkgrnd.img, &layers.bkgrnd.bits_per_pixel, &layers.bkgrnd.bytes_per_row, &layers.bkgrnd.endian);' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.addr = mlx_get_data_addr(layers.chara.img, &layers.chara.bits_per_pixel, &layers.chara.bytes_per_row, &layers.chara.endian);' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.x = 0;' >> src/version_maker.sh
	@printf "%s\n" '	layers.bkgrnd.y = 0;' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.x = 910/2;' >> src/version_maker.sh
	@printf "%s\n" '	layers.chara.y = 500/2;' >> src/version_maker.sh
	@printf "%s\n" '	mlx_hook(layers.chara.mlx_win, 2, 1L<<0, handle_keypress, &layers.chara);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_hook(layers.chara.mlx_win, 6, 1L<<6, handle_mouse, &layers.chara);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop_hook(layers.bkgrnd.mlx, render, &layers);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop(mlx);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'EOF' >> src/version_maker.sh
	@printf "%s\n" 'cat > src/test_versions/ver_10.c << '\''EOF'\''' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                        :::      ::::::::   */' >> src/version_maker.sh
	@printf "%s\n" '/*   ver_10.c                                           :+:      :+:    :+:   */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                    +:+ +:+         +:+     */' >> src/version_maker.sh
	@printf "%s\n" '/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                +#+#+#+#+#+   +#+           */' >> src/version_maker.sh
	@printf "%s\n" '/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */' >> src/version_maker.sh
	@printf "%s\n" '/*   Updated: 2025/11/25 14:30:57 by lde-san-         ###   ########.fr       */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '#include "../../inc/solong.h"' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '/*Experimented further with the sin and cos to create color shifting spirals. The' >> src/version_maker.sh
	@printf "%s\n" 'spiral'\''s parameters can be changed during execution with WASD and the arrow keys.' >> src/version_maker.sh
	@printf "%s\n" 'You may also hit the space bar to clear the window.*/' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'typedef struct	s_data ' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*img;' >> src/version_maker.sh
	@printf "%s\n" '	char	*addr;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	int		bits_per_pixel;' >> src/version_maker.sh
	@printf "%s\n" '	int		bytes_per_row;' >> src/version_maker.sh
	@printf "%s\n" '	int		endian;' >> src/version_maker.sh
	@printf "%s\n" '	double o_increment;' >> src/version_maker.sh
	@printf "%s\n" '	double t_increment;' >> src/version_maker.sh
	@printf "%s\n" '	double radius_increment;' >> src/version_maker.sh
	@printf "%s\n" '	double t_t_increment;' >> src/version_maker.sh
	@printf "%s\n" '}				t_data;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'void clear(t_data *data)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	char	*dst;' >> src/version_maker.sh
	@printf "%s\n" '	char	*end;' >> src/version_maker.sh
	@printf "%s\n" '	' >> src/version_maker.sh
	@printf "%s\n" '	dst = data->addr;' >> src/version_maker.sh
	@printf "%s\n" '	end = data->addr + (1080/2 * data->bytes_per_row);' >> src/version_maker.sh
	@printf "%s\n" '	' >> src/version_maker.sh
	@printf "%s\n" '	while (dst != end)' >> src/version_maker.sh
	@printf "%s\n" '		*(unsigned int*)dst++ = 0;' >> src/version_maker.sh
	@printf "%s\n" '	mlx_put_image_to_window(data->mlx, data->mlx_win, data->img, 0, 0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int handle_keypress(int keycode, t_data *data)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 65307)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		mlx_destroy_window(data->mlx, data->mlx_win);' >> src/version_maker.sh
	@printf "%s\n" '		exit (0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 32)' >> src/version_maker.sh
	@printf "%s\n" '		clear(data);' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 100) ' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		data->t_increment += 0.00001;' >> src/version_maker.sh
	@printf "%s\n" '		printf("🦝 Increasing Time Increment: %f\n", data->t_increment);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 65363)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		data->radius_increment += 0.01; ' >> src/version_maker.sh
	@printf "%s\n" '		printf("🦝 Increasing Radius Increment: %f\n", data->radius_increment);' >> src/version_maker.sh
	@printf "%s\n" '      	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 97 && data->t_increment > 0.00001)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		data->t_increment -= 0.00001; ' >> src/version_maker.sh
	@printf "%s\n" '		printf("🦝 Decreasing Time Increment: %f\n", data->t_increment);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 65361 && data->radius_increment > 0.01)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		data->radius_increment -= 0.01; ' >> src/version_maker.sh
	@printf "%s\n" '		printf("🦝 Decreasing Radius Increment: %f\n", data->radius_increment);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 65364 && data->o_increment > 0.0001)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		data->o_increment -= 0.0001; ' >> src/version_maker.sh
	@printf "%s\n" '		printf("🦝 Decreasing Offset Increment: %f\n", data->o_increment);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 65362)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		data->o_increment += 0.0001; ' >> src/version_maker.sh
	@printf "%s\n" '		printf("🦝 Increasing Offset Increment: %f\n", data->o_increment);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 119)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		data->t_t_increment += 0.0001; ' >> src/version_maker.sh
	@printf "%s\n" '		printf("🦝 Increasing Color Speed: %f\n", data->t_t_increment);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 115 && data->t_t_increment > 0.00001)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		data->t_t_increment -= 0.00001; ' >> src/version_maker.sh
	@printf "%s\n" '		printf("🦝 Decreasing Color Speed: %f\n", data->t_t_increment);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'void	my_mlx_pixel_put(t_data *data, int x, int y, int color)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	char	*dst;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	dst = data->addr + (y * data->bytes_per_row + x * (data->bits_per_pixel / 8));' >> src/version_maker.sh
	@printf "%s\n" '	*(unsigned int*)dst = color;' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render_spiral(t_data *img)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	int x = 0;' >> src/version_maker.sh
	@printf "%s\n" '	int y = 0;' >> src/version_maker.sh
	@printf "%s\n" '	double radius = 0;' >> src/version_maker.sh
	@printf "%s\n" '	double t = 0;' >> src/version_maker.sh
	@printf "%s\n" '	static double o = 0;' >> src/version_maker.sh
	@printf "%s\n" '	static double t_t = 0;' >> src/version_maker.sh
	@printf "%s\n" '	int r, g, b;' >> src/version_maker.sh
	@printf "%s\n" '	int color;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	r = (int)(sin(t_t) * 127 + 128);' >> src/version_maker.sh
	@printf "%s\n" '	g = (int)(sin(t_t + 2.094) * 127 + 128);' >> src/version_maker.sh
	@printf "%s\n" '	b = (int)(sin(t_t + 4.188) * 127 + 128);' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	color = (r << 16) | (g << 8) | b;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	t_t += img->t_t_increment;' >> src/version_maker.sh
	@printf "%s\n" '	' >> src/version_maker.sh
	@printf "%s\n" '	if (t_t > 2 * M_PI)' >> src/version_maker.sh
	@printf "%s\n" '		t_t -= 2 * M_PI;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '        while (y < 1080/2 && y >= 0 && x < 1920/2 && x >= 0)' >> src/version_maker.sh
	@printf "%s\n" '        {' >> src/version_maker.sh
	@printf "%s\n" '        	x = (int)(sin(t + o) * radius + 960/2);' >> src/version_maker.sh
	@printf "%s\n" '        	y = (int)(cos(t + o) * radius + 540/2);' >> src/version_maker.sh
	@printf "%s\n" '        	if (y < 1080/2 && y >= 0 && x < 1920/2 && x >= 0)' >> src/version_maker.sh
	@printf "%s\n" '                        my_mlx_pixel_put(img, x, y, color);' >> src/version_maker.sh
	@printf "%s\n" '		t += img->t_increment;' >> src/version_maker.sh
	@printf "%s\n" '		radius += img->radius_increment;' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	o += img->o_increment;' >> src/version_maker.sh
	@printf "%s\n" '	mlx_put_image_to_window(img->mlx, img->mlx_win, img->img, 0, 0);' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int	main(void)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '        t_data img;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	img.mlx = mlx_init();' >> src/version_maker.sh
	@printf "%s\n" '	img.mlx_win = mlx_new_window(img.mlx, 1920/2, 1080/2, "Mapache'\''s Spiral of Sorrows");' >> src/version_maker.sh
	@printf "%s\n" '	img.img = mlx_new_image(img.mlx, 1920/2, 1080/2);' >> src/version_maker.sh
	@printf "%s\n" '	img.addr = mlx_get_data_addr(img.img, &img.bits_per_pixel, &img.bytes_per_row, &img.endian);' >> src/version_maker.sh
	@printf "%s\n" '	' >> src/version_maker.sh
	@printf "%s\n" '	img.o_increment = 0.0001;' >> src/version_maker.sh
	@printf "%s\n" '	img.t_increment = 0.00001;' >> src/version_maker.sh
	@printf "%s\n" '	img.t_t_increment = 0.00001;' >> src/version_maker.sh
	@printf "%s\n" '	img.radius_increment = 0.01;' >> src/version_maker.sh
	@printf "%s\n" '	' >> src/version_maker.sh
	@printf "%s\n" '	mlx_hook(img.mlx_win, 2, 1L<<0, handle_keypress, &img);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop_hook(img.mlx, render_spiral, &img);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop(img.mlx);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" 'EOF' >> src/version_maker.sh
	@printf "%s\n" 'cat > src/test_versions/ver_11.c << '\''EOF'\''' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                        :::      ::::::::   */' >> src/version_maker.sh
	@printf "%s\n" '/*   ver_11.c                                           :+:      :+:    :+:   */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                    +:+ +:+         +:+     */' >> src/version_maker.sh
	@printf "%s\n" '/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                +#+#+#+#+#+   +#+           */' >> src/version_maker.sh
	@printf "%s\n" '/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */' >> src/version_maker.sh
	@printf "%s\n" '/*   Updated: 2025/11/25 14:31:08 by lde-san-         ###   ########.fr       */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '#include "../../inc/solong.h"' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '/*Began working with mlx_xpm_file_to_image. Made it so that the background can' >> src/version_maker.sh
	@printf "%s\n" 'now be a selected .xpm file, and figured out a way pass the movement logic from' >> src/version_maker.sh
	@printf "%s\n" 'the window to the character (circle) drawing logic, in order to merge them in ' >> src/version_maker.sh
	@printf "%s\n" 'one image. Also created a function that "clears" the frame, by making a copy of' >> src/version_maker.sh
	@printf "%s\n" 'the background and using the copy to overwrite the original after each frame. The' >> src/version_maker.sh
	@printf "%s\n" 'controls have been updated so that the character moves around the screen in a loop' >> src/version_maker.sh
	@printf "%s\n" 'instead of getting lost indefinitely.*/' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'typedef struct	s_data ' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*img;' >> src/version_maker.sh
	@printf "%s\n" '	char	*addr;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	int		bits_per_pixel;' >> src/version_maker.sh
	@printf "%s\n" '	int		bytes_per_row;' >> src/version_maker.sh
	@printf "%s\n" '	int		endian;' >> src/version_maker.sh
	@printf "%s\n" '	int	img_width;' >> src/version_maker.sh
	@printf "%s\n" '	int	img_height;' >> src/version_maker.sh
	@printf "%s\n" '	int	x;' >> src/version_maker.sh
	@printf "%s\n" '	int	y;' >> src/version_maker.sh
	@printf "%s\n" '}				t_data;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'typedef struct	s_datapack' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	t_data  bkgrn;' >> src/version_maker.sh
	@printf "%s\n" '	t_data  game;' >> src/version_maker.sh
	@printf "%s\n" '}				t_datapack;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int handle_keypress(int keycode, t_data *data)' >> src/version_maker.sh
	@printf "%s\n" '{	' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 65307)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		mlx_destroy_window(data->mlx, data->mlx_win);' >> src/version_maker.sh
	@printf "%s\n" '		exit (0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 100 || keycode == 65363)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		data->x += 20/2;' >> src/version_maker.sh
	@printf "%s\n" '		if (data->x >= data->img_width + 100)' >> src/version_maker.sh
	@printf "%s\n" '			data->x -= data->img_width;' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 97 || keycode == 65361)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		data->x -= 20/2;' >> src/version_maker.sh
	@printf "%s\n" '		if (data->x < data->img_width - 100)' >> src/version_maker.sh
	@printf "%s\n" '			data->x += data->img_width;' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 115 || keycode == 65364)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		data->y += 20/2;' >> src/version_maker.sh
	@printf "%s\n" '		if (data->y >= data->img_height + 100)' >> src/version_maker.sh
	@printf "%s\n" '			data->y -= data->img_height;' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 119 || keycode == 65362)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		data->y -= 20/2;' >> src/version_maker.sh
	@printf "%s\n" '		if (data->y < data->img_height - 100)' >> src/version_maker.sh
	@printf "%s\n" '			data->y += data->img_height;' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	racc_print(1, "%e %d, %d, %d %e\n", "racc", keycode, data->x, data->y, "racc");' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int	handle_mouse(int x, int y, t_data *data)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	while(x < data->x)' >> src/version_maker.sh
	@printf "%s\n" '		data->x--;' >> src/version_maker.sh
	@printf "%s\n" '	while(x > data->x)' >> src/version_maker.sh
	@printf "%s\n" '		data->x++;' >> src/version_maker.sh
	@printf "%s\n" '	while(y < data->y)' >> src/version_maker.sh
	@printf "%s\n" '		data->y--;' >> src/version_maker.sh
	@printf "%s\n" '	while(y > data->y)' >> src/version_maker.sh
	@printf "%s\n" '		data->y++;' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int	handle_close(t_data *data)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	mlx_destroy_window(data->mlx, data->mlx_win);' >> src/version_maker.sh
	@printf "%s\n" '	exit(0);' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'void	my_mlx_pixel_put(t_data *data, int x, int y, int color)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	char	*dst;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	if (x < 0)' >> src/version_maker.sh
	@printf "%s\n" '		x += data->img_width;' >> src/version_maker.sh
	@printf "%s\n" '	else if (x >= data->img_width)' >> src/version_maker.sh
	@printf "%s\n" '		x -= data->img_width;' >> src/version_maker.sh
	@printf "%s\n" '	if (y < 0)' >> src/version_maker.sh
	@printf "%s\n" '		y += data->img_height;' >> src/version_maker.sh
	@printf "%s\n" '	else if (y >= data->img_height)' >> src/version_maker.sh
	@printf "%s\n" '		y -= data->img_height;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	dst = data->addr + (y * data->bytes_per_row + x * (data->bits_per_pixel / 8));' >> src/version_maker.sh
	@printf "%s\n" '	*(unsigned int*)dst = color;' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render_character(t_data *img)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	int radius = 50;' >> src/version_maker.sh
	@printf "%s\n" '	double t = 0.001;' >> src/version_maker.sh
	@printf "%s\n" '	static double t_t = 0;' >> src/version_maker.sh
	@printf "%s\n" '	int r, g, b;' >> src/version_maker.sh
	@printf "%s\n" '	int color;' >> src/version_maker.sh
	@printf "%s\n" '	int cx;' >> src/version_maker.sh
	@printf "%s\n" '	int cy;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	r = (int)(sin(t_t) * 127 + 128);' >> src/version_maker.sh
	@printf "%s\n" '	g = (int)(sin(t_t + 2.094) * 127 + 128);' >> src/version_maker.sh
	@printf "%s\n" '	b = (int)(sin(t_t + 4.188) * 127 + 128);' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	color = (r << 16) | (g << 8) | b;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '        while (radius-- > 16)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		while (t < 2 * M_PI)' >> src/version_maker.sh
	@printf "%s\n" '		{' >> src/version_maker.sh
	@printf "%s\n" '			cx = (int)(cos(t) * radius + img->x);' >> src/version_maker.sh
	@printf "%s\n" '			cy = (int)(sin(t) * radius + img->y);' >> src/version_maker.sh
	@printf "%s\n" '			if (radius > 46 || radius < 20)' >> src/version_maker.sh
	@printf "%s\n" '			{' >> src/version_maker.sh
	@printf "%s\n" '                                my_mlx_pixel_put(img, cx, cy, 0x000000);' >> src/version_maker.sh
	@printf "%s\n" '			}' >> src/version_maker.sh
	@printf "%s\n" '			else' >> src/version_maker.sh
	@printf "%s\n" '			        my_mlx_pixel_put(img, cx, cy, color);' >> src/version_maker.sh
	@printf "%s\n" '			t += 0.01;' >> src/version_maker.sh
	@printf "%s\n" '		}' >> src/version_maker.sh
	@printf "%s\n" '		t -= 2 * M_PI;' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	t_t += 0.05;' >> src/version_maker.sh
	@printf "%s\n" '	if (t_t > 2 * M_PI)' >> src/version_maker.sh
	@printf "%s\n" '		t_t -= 2 * M_PI;' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render(t_datapack *lyrs)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	lyrs->game.addr = ft_memcpy(lyrs->game.addr, lyrs->bkgrn.addr, lyrs->bkgrn.img_height * lyrs->bkgrn.bytes_per_row);' >> src/version_maker.sh
	@printf "%s\n" '	render_character(&lyrs->game);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_put_image_to_window(lyrs->game.mlx, lyrs->game.mlx_win, lyrs->game.img, 0, 0);' >> src/version_maker.sh
	@printf "%s\n" '	return(0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int	main(void)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	t_datapack lyrs;' >> src/version_maker.sh
	@printf "%s\n" '	char	*relative_path = "./textures/Herculy.xpm";' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.game.mlx = mlx_init();' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.bkgrn.mlx = lyrs.game.mlx;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.bkgrn.img = mlx_xpm_file_to_image(lyrs.bkgrn.mlx, relative_path, &lyrs.bkgrn.img_width, &lyrs.bkgrn.img_height);' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.game.img_width = lyrs.bkgrn.img_width;' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.game.img_height = lyrs.bkgrn.img_height;' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.game.img = mlx_new_image(lyrs.game.mlx, lyrs.game.img_width, lyrs.game.img_height);' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.game.mlx_win = mlx_new_window(lyrs.game.mlx, 1920/2, 1080/2, "Mapache'\''s box'\''o fun");' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.bkgrn.mlx_win = lyrs.game.mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.game.addr = mlx_get_data_addr(lyrs.game.img, &lyrs.game.bits_per_pixel, &lyrs.game.bytes_per_row, &lyrs.game.endian);' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.bkgrn.addr = mlx_get_data_addr(lyrs.bkgrn.img, &lyrs.bkgrn.bits_per_pixel, &lyrs.bkgrn.bytes_per_row, &lyrs.bkgrn.endian);' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.game.x = 1200/2;' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.game.y = 600/2;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	mlx_hook(lyrs.game.mlx_win, 17, 1L<<0, handle_close, &lyrs.game);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_hook(lyrs.game.mlx_win, 2, 1L<<0, handle_keypress, &lyrs.game);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_hook(lyrs.game.mlx_win, 6, 1L<<6, handle_mouse, &lyrs.game);' >> src/version_maker.sh
	@printf "%s\n" '	' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop_hook(lyrs.game.mlx, render, &lyrs);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop(lyrs.game.mlx);' >> src/version_maker.sh
	@printf "%s\n" '	return(0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" 'EOF' >> src/version_maker.sh
	@printf "%s\n" 'cat > src/test_versions/ver_12.c << '\''EOF'\''' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                        :::      ::::::::   */' >> src/version_maker.sh
	@printf "%s\n" '/*   ver_12.c                                           :+:      :+:    :+:   */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                    +:+ +:+         +:+     */' >> src/version_maker.sh
	@printf "%s\n" '/*   By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+        */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                +#+#+#+#+#+   +#+           */' >> src/version_maker.sh
	@printf "%s\n" '/*   Created: 2025/11/04 17:28:07 by lde-san-          #+#    #+#             */' >> src/version_maker.sh
	@printf "%s\n" '/*   Updated: 2025/11/25 14:31:15 by lde-san-         ###   ########.fr       */' >> src/version_maker.sh
	@printf "%s\n" '/*                                                                            */' >> src/version_maker.sh
	@printf "%s\n" '/* ************************************************************************** */' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '#include "../../inc/solong.h"' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '/*Learned about mlx_do_sync, and implemented it for alleged "better" rendering. ' >> src/version_maker.sh
	@printf "%s\n" 'Looked into the better version "mlx_sync" but it somehow seems to be a myth.' >> src/version_maker.sh
	@printf "%s\n" 'Since the mouse can move the character, added functionality to mlx_mouse_hide, ' >> src/version_maker.sh
	@printf "%s\n" 'if the mouse enters the game window area.*/' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'typedef struct	s_data ' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	void	*img;' >> src/version_maker.sh
	@printf "%s\n" '	char	*addr;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx;' >> src/version_maker.sh
	@printf "%s\n" '	void	*mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	int		bits_per_pixel;' >> src/version_maker.sh
	@printf "%s\n" '	int		bytes_per_row;' >> src/version_maker.sh
	@printf "%s\n" '	int		endian;' >> src/version_maker.sh
	@printf "%s\n" '	int	img_width;' >> src/version_maker.sh
	@printf "%s\n" '	int	img_height;' >> src/version_maker.sh
	@printf "%s\n" '	int	x;' >> src/version_maker.sh
	@printf "%s\n" '	int	y;' >> src/version_maker.sh
	@printf "%s\n" '}				t_data;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'typedef struct	s_datapack' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	t_data  bkgrn;' >> src/version_maker.sh
	@printf "%s\n" '	t_data  game;' >> src/version_maker.sh
	@printf "%s\n" '}				t_datapack;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int	handle_enter(t_data *data)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '    racc_print(1,"Entered\n");' >> src/version_maker.sh
	@printf "%s\n" '    mlx_mouse_hide(data->mlx, data->mlx_win);' >> src/version_maker.sh
	@printf "%s\n" '    return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int	handle_keypress(int keycode, t_data *data)' >> src/version_maker.sh
	@printf "%s\n" '{	' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 65307)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		mlx_destroy_window(data->mlx, data->mlx_win);' >> src/version_maker.sh
	@printf "%s\n" '		exit (0);' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 100 || keycode == 65363)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		data->x += 20/2;' >> src/version_maker.sh
	@printf "%s\n" '		if (data->x >= data->img_width + 100)' >> src/version_maker.sh
	@printf "%s\n" '			data->x -= data->img_width;' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 97 || keycode == 65361)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		data->x -= 20/2;' >> src/version_maker.sh
	@printf "%s\n" '		if (data->x < data->img_width - 100)' >> src/version_maker.sh
	@printf "%s\n" '			data->x += data->img_width;' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 115 || keycode == 65364)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		data->y += 20/2;' >> src/version_maker.sh
	@printf "%s\n" '		if (data->y >= data->img_height + 100)' >> src/version_maker.sh
	@printf "%s\n" '			data->y -= data->img_height;' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	if (keycode == 119 || keycode == 65362)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		data->y -= 20/2;' >> src/version_maker.sh
	@printf "%s\n" '		if (data->y < data->img_height - 100)' >> src/version_maker.sh
	@printf "%s\n" '			data->y += data->img_height;' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	racc_print(1, "%e %d, %d, %d %e\n", "racc", keycode, data->x, data->y, "racc");' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int	handle_mouse(int x, int y, t_data *data)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	while(x < data->x)' >> src/version_maker.sh
	@printf "%s\n" '		data->x--;' >> src/version_maker.sh
	@printf "%s\n" '	while(x > data->x)' >> src/version_maker.sh
	@printf "%s\n" '		data->x++;' >> src/version_maker.sh
	@printf "%s\n" '	while(y < data->y)' >> src/version_maker.sh
	@printf "%s\n" '		data->y--;' >> src/version_maker.sh
	@printf "%s\n" '	while(y > data->y)' >> src/version_maker.sh
	@printf "%s\n" '		data->y++;' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int	handle_close(t_data *data)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	mlx_destroy_window(data->mlx, data->mlx_win);' >> src/version_maker.sh
	@printf "%s\n" '	exit(0);' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'void	my_mlx_pixel_put(t_data *data, int x, int y, int color)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	char	*dst;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	if (x < 0)' >> src/version_maker.sh
	@printf "%s\n" '		x += data->img_width;' >> src/version_maker.sh
	@printf "%s\n" '	else if (x >= data->img_width)' >> src/version_maker.sh
	@printf "%s\n" '		x -= data->img_width;' >> src/version_maker.sh
	@printf "%s\n" '	if (y < 0)' >> src/version_maker.sh
	@printf "%s\n" '		y += data->img_height;' >> src/version_maker.sh
	@printf "%s\n" '	else if (y >= data->img_height)' >> src/version_maker.sh
	@printf "%s\n" '		y -= data->img_height;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	dst = data->addr + (y * data->bytes_per_row + x * (data->bits_per_pixel / 8));' >> src/version_maker.sh
	@printf "%s\n" '	*(unsigned int*)dst = color;' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render_character(t_data *img)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	int radius = 50;' >> src/version_maker.sh
	@printf "%s\n" '	double t = 0.001;' >> src/version_maker.sh
	@printf "%s\n" '	static double t_t = 0;' >> src/version_maker.sh
	@printf "%s\n" '	int r, g, b;' >> src/version_maker.sh
	@printf "%s\n" '	int color;' >> src/version_maker.sh
	@printf "%s\n" '	int cx;' >> src/version_maker.sh
	@printf "%s\n" '	int cy;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	r = (int)(sin(t_t) * 127 + 128);' >> src/version_maker.sh
	@printf "%s\n" '	g = (int)(sin(t_t + 2.094) * 127 + 128);' >> src/version_maker.sh
	@printf "%s\n" '	b = (int)(sin(t_t + 4.188) * 127 + 128);' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	color = (r << 16) | (g << 8) | b;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '        while (radius-- > 16)' >> src/version_maker.sh
	@printf "%s\n" '	{' >> src/version_maker.sh
	@printf "%s\n" '		while (t < 2 * M_PI)' >> src/version_maker.sh
	@printf "%s\n" '		{' >> src/version_maker.sh
	@printf "%s\n" '			cx = (int)(cos(t) * radius + img->x);' >> src/version_maker.sh
	@printf "%s\n" '			cy = (int)(sin(t) * radius + img->y);' >> src/version_maker.sh
	@printf "%s\n" '			if (radius > 46 || radius < 20)' >> src/version_maker.sh
	@printf "%s\n" '			{' >> src/version_maker.sh
	@printf "%s\n" '                                my_mlx_pixel_put(img, cx, cy, 0x000000);' >> src/version_maker.sh
	@printf "%s\n" '			}' >> src/version_maker.sh
	@printf "%s\n" '			else' >> src/version_maker.sh
	@printf "%s\n" '			        my_mlx_pixel_put(img, cx, cy, color);' >> src/version_maker.sh
	@printf "%s\n" '			t += 0.01;' >> src/version_maker.sh
	@printf "%s\n" '		}' >> src/version_maker.sh
	@printf "%s\n" '		t -= 2 * M_PI;' >> src/version_maker.sh
	@printf "%s\n" '	}' >> src/version_maker.sh
	@printf "%s\n" '	t_t += 0.05;' >> src/version_maker.sh
	@printf "%s\n" '	if (t_t > 2 * M_PI)' >> src/version_maker.sh
	@printf "%s\n" '		t_t -= 2 * M_PI;' >> src/version_maker.sh
	@printf "%s\n" '	return (0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int render(t_datapack *lyrs)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	lyrs->game.addr = ft_memcpy(lyrs->game.addr, lyrs->bkgrn.addr, lyrs->bkgrn.img_height * lyrs->bkgrn.bytes_per_row);' >> src/version_maker.sh
	@printf "%s\n" '	render_character(&lyrs->game);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_put_image_to_window(lyrs->game.mlx, lyrs->game.mlx_win, lyrs->game.img, 0, 0);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_do_sync(lyrs->game.mlx);' >> src/version_maker.sh
	@printf "%s\n" '	return(0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" 'int	main(void)' >> src/version_maker.sh
	@printf "%s\n" '{' >> src/version_maker.sh
	@printf "%s\n" '	t_datapack lyrs;' >> src/version_maker.sh
	@printf "%s\n" '	char	*relative_path = "./textures/Seventy.xpm";' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.game.mlx = mlx_init();' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.bkgrn.mlx = lyrs.game.mlx;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.bkgrn.img = mlx_xpm_file_to_image(lyrs.bkgrn.mlx, relative_path, &lyrs.bkgrn.img_width, &lyrs.bkgrn.img_height);' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.game.img_width = lyrs.bkgrn.img_width;' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.game.img_height = lyrs.bkgrn.img_height;' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.game.img = mlx_new_image(lyrs.game.mlx, lyrs.game.img_width, lyrs.game.img_height);' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.game.mlx_win = mlx_new_window(lyrs.game.mlx, 1920/2, 1080/2, "Mapache'\''s box'\''o fun");' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.bkgrn.mlx_win = lyrs.game.mlx_win;' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.game.addr = mlx_get_data_addr(lyrs.game.img, &lyrs.game.bits_per_pixel, &lyrs.game.bytes_per_row, &lyrs.game.endian);' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.bkgrn.addr = mlx_get_data_addr(lyrs.bkgrn.img, &lyrs.bkgrn.bits_per_pixel, &lyrs.bkgrn.bytes_per_row, &lyrs.bkgrn.endian);' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.game.x = 1200/2;' >> src/version_maker.sh
	@printf "%s\n" '	lyrs.game.y = 600/2;' >> src/version_maker.sh
	@printf "%s\n" '' >> src/version_maker.sh
	@printf "%s\n" '	mlx_hook(lyrs.game.mlx_win, 17, 1L<<0, handle_close, &lyrs.game);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_hook(lyrs.game.mlx_win, 2, 1L<<0, handle_keypress, &lyrs.game);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_hook(lyrs.game.mlx_win, 6, 1L<<6, handle_mouse, &lyrs.game);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_hook(lyrs.game.mlx_win, 7, 1L<<4, handle_enter, &lyrs.game);' >> src/version_maker.sh
	@printf "%s\n" '	' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop_hook(lyrs.game.mlx, render, &lyrs);' >> src/version_maker.sh
	@printf "%s\n" '	mlx_loop(lyrs.game.mlx);' >> src/version_maker.sh
	@printf "%s\n" '	return(0);' >> src/version_maker.sh
	@printf "%s\n" '}' >> src/version_maker.sh
	@printf "%s\n" 'EOF' >> src/version_maker.sh
	@chmod +x src/version_maker.sh
	@printf "\033[0m\n"

