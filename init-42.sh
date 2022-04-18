

#!/bin/bash 




# create 2 directories in current directory
# store first argument in variable "project_name"

# check if argument is empty 

# take input from user 

echo "Enter project name: "
read project_name
echo "Enter origin url: "
read origin_url
echo "are u using libft: "
read libft
echo "are u using gnl: "
read gnl
echo "are u using ft_printf: "
read ft_printf


PROJECT_NAME= $project_name
ORIGIN_URL= $origin_url

# print project_name

mkdir $PROJECT_NAME 
touch $PROJECT_NAME/Makefile
mkdir $PROJECT_NAME/mandatory $PROJECT_NAME/bonus $PROJECT_NAME/tests 
mkdir $PROJECT_NAME/mandatory/srcs $PROJECT_NAME/mandatory/includes $PROJECT_NAME/mandatory/utils
mkdir $PROJECT_NAME/bonus/srcs $PROJECT_NAME/bonus/includes $PROJECT_NAME/bonus/utils
mkdir $PROJECT_NAME/tests/srcs $PROJECT_NAME/tests/includes $PROJECT_NAME/tests/utils
touch $PROJECT_NAME/mandatory/srcs/main.c  $PROJECT_NAME/bonus/srcs/main_bonus.c $PROJECT_NAME/tests/srcs/main.c
cd $PROJECT_NAME && git init
if ($ORIGIN_URL)
then
    cd $PROJECT_NAME && git remote add origin $ORIGIN_URL
fi

if (( $libft == "y" | $libft == "yes" ))
then
    cd $PROJECT_NAME/mandatory/utils && git clone "$origin_url/libft.git"
fi
if (( $gnl == "y" | $gnl == "yes" ))
then
    cd $PROJECT_NAME/mandatory/utils && git clone "$origin_url/get_next_line.git"
fi
if (( $ft_printf == "y" | $ft_printf == "yes" ))
then
    cd $PROJECT_NAME/mandatory/utils && git clone "$origin_url/ft_printf.git"
fi
git add .
git commit -m "initial commit"
git branch dev 
git checkout dev

# adda a boilerplate makefile 
printf "

    NAME_MANDATORY = $PROJECT_NAME
    NAME_BONUS = ${PROJECT_NAME}_bonus

    CFLAGS = -Wall -Wextra -Werror


    SRCS_MANDATORY = main.c \
        # add here all the mandatory sources
    SRCS_BONUS = main_bonus.c \
        # add here all the bonus sources
    SRCS_TESTS = main.c \
        # add here all the tests sources
    INCLUDES_MANDATORY = -I./mandatory/includes -I./mandatory/utils \
        # add here all the mandatory includes
    INCLUDES_BONUS = -I./bonus/includes -I./bonus/utils \
        # add here all the bonus includes
    INCLUDES_TESTS = -I./tests/includes -I./tests/utils \
        # add here all the tests includes


    OBJS_MANDATORY = \$(SRCS_MANDATORY:.c=.o)
    OBJS_BONUS = \$(SRCS_BONUS:.c=.o)
    OBJS_TESTS = \$(SRCS_TESTS:.c=.o)

    %.o: %.c
        cc -c $< -o $@ \$(CFLAGS)
    
    all: \$(NAME_MANDATORY)
    \$(NAME_MANDATORY): \$(OBJS_MANDATORY) \$(INCLUDES_MANDATORY)

        cc -o $@ \$^ \$(INCLUDES_MANDATORY)
    bonus: \$(OBJS_BONUS) \$(INCLUDES_BONUS)
        cc -o $@ \$^ \$(INCLUDES_BONUS)

    tests: \$(OBJS_TESTS) \$(INCLUDES_TESTS)
        cc -o $@ \$^ \$(INCLUDES_TESTS)

    clean:
        rm -rf \$(OBJS_MANDATORY) \$(OBJS_BONUS) \$(OBJS_TESTS)
    
    fclean:
        rm -rf \$(NAME_MANDATORY) \$(NAME_BONUS) \$(NAME_TESTS)
    
    re: fclean all

    .PHONY: all bonus clean fclean re
" >> Makefile 

