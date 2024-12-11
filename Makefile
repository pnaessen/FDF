# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pnaessen <pnaessen@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/02 10:42:01 by pnaessen          #+#    #+#              #
#    Updated: 2024/12/11 16:24:10 by pnaessen         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

NAME := FDF

CC := gcc
CCFLAGS := -Wextra -Wall -Werror 
SRC_DIR := src/
INCLUDES:= include/
SRC := $(addprefix $(SRC_DIR), main.c parse.c algo.c dots.c)

OBJ_DIR := .obj/
OBJ := $(SRC:$(SRC_DIR)%.c=$(OBJ_DIR)%.o)

MLX_DIR := minilibx-linux/
MLX := $(MLX_DIR)libmlx_Linux.a
MLX_FLAG := -L $(MLX_DIR) -lmlx_Linux -L/usr/lib -I $(MLX_DIR) -lX11 -lm -lz -lXext $(MLX)

LIBFT_DIR := Libft/
LIBFT := $(LIBFT_DIR)libft.a 
LIBFT_FLAG := -L $(LIBFT_DIR) $(LIBFT)

HEADERS:= -I $(INCLUDES) -I $(MLX_DIR) -I $(LIBFT_DIR)

# Colors

DEF_COLOR = \033[0;39m
GRAY = \033[0;90m
RED = \033[0;91m
GREEN = \033[0;92m
YELLOW = \033[0;93m
BLUE = \033[0;94m
MAGENTA = \033[0;95m
CYAN = \033[0;96m
WHITE = \033[0;97m

$(NAME): $(OBJ)
	$(MAKE) -C $(MLX_DIR)
	$(MAKE) -C $(LIBFT_DIR)
	@$(CC) $(CCFLAGS) $(OBJ)  $(MLX_FLAG) $(LIBFT_FLAG) -o $(NAME)
	@echo "👉 $(BLUE)$(CC) $(CCFLAGS) $(OBJ)  $(MLX_FLAG) $(LIBFT_FLAG) -o $(NAME)$(DEF_COLOR)"
	@echo "$(GREEN)✨✨✨✨✨✨✨✨ FDF compiled!✨✨✨✨✨✨✨✨✨✨✨✨✨🐷$(DEF_COLOR)"

all: $(NAME)

$(OBJ_DIR)%.o: $(SRC_DIR)%.c
	@mkdir -p $(OBJ_DIR)
	@echo "🍩 $(MAGENTA)Compiling: $< $(DEF_COLOR)"
	$(CC) $(CCFLAGS) $(HEADERS) -c $< -o $@

clean:
	rm -rf $(OBJ_DIR)

fclean: clean
	$(MAKE) fclean -C $(LIBFT_DIR)
	$(MAKE) clean -C $(MLX_DIR)
	@echo "$(RED)🧨💥🧨💥🧨🧨🧨🧨🧨🧨🧨🧨🧨 FDF removed! 🧨💥🧨💥🧨🧨🧨🧨🧨🧨🧨🧨🧨$(DEF_COLOR)"
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re