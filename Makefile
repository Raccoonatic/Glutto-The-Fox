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

evolution: ./inc/mlx_linux/libmlx_Linux.a
	@printf "$(MINT)\n\t🦝 Hope you are ready for a trip down memory lane! 🦝\n\n"
	@sleep 2
	@printf "\t\t\t     Let's go!\n\n"
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_1$(RSET)\n\n"
	@sleep 2
	@open src/test_versions/ver_1.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=src/test_versions/ver_1.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"	
	@printf "\n\nMaking Version_2$(RSET)\n\n"
	@sleep 2
	@open src/test_versions/ver_2.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=src/test_versions/ver_2.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_3$(RSET)\n\n"
	@sleep 2
	@open src/test_versions/ver_3.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=src/test_versions/ver_3.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_4$(RSET)\n\n"
	@sleep 2
	@open src/test_versions/ver_4.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=src/test_versions/ver_4.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_5$(RSET)\n\n"
	@sleep 2
	@open src/test_versions/ver_5.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=src/test_versions/ver_5.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_6$(RSET)\n\n"
	@sleep 2
	@open src/test_versions/ver_6.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=src/test_versions/ver_6.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_7$(RSET)\n\n"
	@sleep 2
	@open src/test_versions/ver_7.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=src/test_versions/ver_7.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_8$(RSET)\n\n"
	@sleep 2
	@open src/test_versions/ver_8.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=src/test_versions/ver_8.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_9$(RSET)\n\n"
	@sleep 2
	@open src/test_versions/ver_9.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=src/test_versions/ver_9.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_10$(RSET)\n\n"
	@sleep 2
	@open src/test_versions/ver_10.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=src/test_versions/ver_10.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_11$(RSET)\n\n"
	@sleep 2
	@open src/test_versions/ver_11.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=src/test_versions/ver_11.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_12$(RSET)\n\n"
	@sleep 2
	@open src/test_versions/ver_12.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=src/test_versions/ver_12.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)

.PHONY: all clean fclean re open mlx_dependencies evolution
