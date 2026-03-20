# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lde-san- <lde-san-@student.42porto.co      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/10/30 15:46:25 by lde-san-          #+#    #+#              #
#    Updated: 2025/11/24 23:45:27 by lde-san-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = so_long
LIB = racc_long.a
LIBFT = libft/libft.a

NEOR	= \033[3m\033[38;2;255;153;51m
MINT    = \033[1;38;2;55;250;133m
PURP	= \033[1;38;2;174;5;252m
BABY    = \033[38;2;0;255;247m
BLOD	= \033[1;38;2;255;0;0m
LIME    = \033[38;2;0;255;0m
BLAK	= \033[38;2;0;0;0m
B_WI    = \033[1;37m
RSET	= \033[0m

MAIN_F ?= so_long.c

FILE = sl_win.c
FILE += sl_coin.c
FILE += sl_door.c
FILE += sl_time.c
FILE += sl_enemy.c
FILE += sl_render.c
FILE += sl_player.c
FILE += sl_destroy.c
FILE += sl_zeroing.c
FILE += sl_terrain.c
FILE += sl_animation.c
FILE += sl_exit_game.c
FILE += sl_check_map.c
FILE += sl_coordinate.c
FILE += sl_flood_fill.c
FILE += sl_layer_init.c
FILE += sl_text_to_map.c
FILE += sl_map_init_utils.c
FILE += sl_sprite_handling.c

OBJ = $(FILE:%.c=%.o)

WERROR ?= -Werror 
COMPILE = cc -g -O0 -Wall $(WERROR)-Wextra -I.

all: $(NAME)

$(NAME): $(LIBFT) $(OBJ) solong.h
	@printf "$(BABY)"
	$(COMPILE) $(MAIN_F) $(OBJ) $(LIBFT) -Lmlx_linux -lmlx_Linux -L/usr/lib -Imlx_linux -lXext -lX11 -lm -lz -o $(NAME)
	@printf "$(MINT)"
	@ls -la
	@printf "$(RSET)"

%.o: %.c
	@printf "$(PURP)"
	$(COMPILE) -I/usr/include -Imlx_linux -c $< -o $@
	@printf "$(RSET)"

open:
	@printf "$(MINT)"
	open Makefile
	find . -maxdepth 1 -name "*.c" -exec open {} \;
	find . -maxdepth 1 -name "*.h" -exec open {} \;
	@printf "$(RSET)"

$(LIBFT):
	@printf "$(NEOR)"
	@make -C ./libft
	@printf "$(RSET)"

clean:
	@printf "$(LIME)"
	@make -C ./libft clean
	@sleep 0.3
	@printf "$(BLOD)"
	rm -rf $(OBJ)
	@sleep 0.3
	@printf "$(RSET)"

fclean: clean
	@printf "$(B_WI)"
	@make -C ./libft fclean
	@sleep 0.3
	@printf "$(PURP)"
	rm -f $(NAME)
	@printf "$(MINT)"
	@sleep 0.3
	@ls -la
	@printf "$(RSET)"

re: fclean all


mlx_dependencies: mlx_linux
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
	@sleep 1
	@printf "$(PURP)"
	sudo apt-get install xorg || true
	sudo apt-get install libxext-dev || true
	sudo apt-get install zlib1g-dev || true
	sudo apt-get install libbsd-dev || true
	@printf "$(RSET)\n"
	@sleep 1
	@printf "$(MINT)\t\t🦝 All requirements installed! 🦝\n\n"
	@printf "$(NEOR)Don't forget to access the folder$(RSET) (cd mlx_linux)$(NEOR) and then run the ./configure file inside it\n\n"
	@printf "$(RSET)"

mlx_linux:
	@printf "$(MINT)\n\t\t🦝 Looks like you don't have the library yet... 🦝\n"
	@sleep 1
	@printf "\t\t\t\t Let's get it!\n\n"
	@sleep 0.5
	@printf "$(NEOR)  wGetting it... \n"
	@printf "$(RSET)\n"
	@printf "$(PURP)"
	wget https://cdn.intra.42.fr/document/document/40942/minilibx-linux.tgz
	@printf "$(BABY)"
	tar -xzf minilibx-linux.tgz
	@printf "$(RSET)\n"
	@ls -la
	@sleep 0.5
	@printf "$(LIME)"
	rm -rf minilibx-linux.tgz
	mv minilibx-linux mlx_linux
	@printf "$(RSET)\n\n"
	@ls -la
	@sleep 1
	@printf "$(MINT)\n\t\t  🦝 There u go handsome! 🦝\n\n"
	@printf "$(RSET)"
	@printf "$(NEOR)Don't forget to access the folder$(RSET) (cd mlx_linux)$(NEOR) and then run the ./configure file inside it\n\n"
	@sleep 2

evolution:
	@printf "$(MINT)\n\t🦝 Hope you are ready for a trip down memory lane! 🦝\n\n"
	@sleep 2
	@printf "\t\t\t     Let's go!\n\n"
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_1$(RSET)\n\n"
	@sleep 2
	@open test_versions/ver_1.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=test_versions/ver_1.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"	
	@printf "\n\nMaking Version_2$(RSET)\n\n"
	@sleep 2
	@open test_versions/ver_2.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=test_versions/ver_2.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_3$(RSET)\n\n"
	@sleep 2
	@open test_versions/ver_3.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=test_versions/ver_3.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_4$(RSET)\n\n"
	@sleep 2
	@open test_versions/ver_4.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=test_versions/ver_4.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_5$(RSET)\n\n"
	@sleep 2
	@open test_versions/ver_5.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=test_versions/ver_5.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_6$(RSET)\n\n"
	@sleep 2
	@open test_versions/ver_6.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=test_versions/ver_6.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_7$(RSET)\n\n"
	@sleep 2
	@open test_versions/ver_7.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=test_versions/ver_7.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_8$(RSET)\n\n"
	@sleep 2
	@open test_versions/ver_8.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=test_versions/ver_8.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_9$(RSET)\n\n"
	@sleep 2
	@open test_versions/ver_9.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=test_versions/ver_9.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_10$(RSET)\n\n"
	@sleep 2
	@open test_versions/ver_10.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=test_versions/ver_10.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)
	@sleep 1
	@printf "$(PURP)"
	@printf "\n\nMaking Version_11$(RSET)\n\n"
	@sleep 2
	@open test_versions/ver_11.c
	@sleep 0.3
	@make re WERROR="" MAIN_F=test_versions/ver_11.c
	@sleep 1
	@printf "$(B_WI)$(NEOR)\n\n 🦝 Press ESC to continue... $(RSET)\n\n"
	./$(NAME)

.PHONY: all clean fclean re open mlx_linux mlx_dependencies evolution
