#!/bin/bash

set -e

mode=${1}

src_path=${2}
dst_path=${3}

# ========== 0. Check (START) ==========

if [ -z "${mode}" ]; then
    echo -e "\033[31m Error: Please check the mode !\033[0m" # red characters
    exit
fi

if [ -z "${src_path}" ]; then
    echo -e "\033[31mError: Please check the src_path !\033[0m"
    exit
fi

if [ -z "${dst_path}" ]; then
    echo -e "\033[31mError: Please check the dst_path !\033[0m"
    exit
fi

if [ ! -d ${dst_path} ]; then
    mkdir -p ${dst_path}
fi

# ========== 0. Check (END) ==========

# ========== 1. Rename (START) ==========

if [ "${mode}" = "rename" ]; then
    echo -e "\033[32m==> Rename files in ${src_path} ...\033[0m"
    name_l=`ls ${src_path}`
    n=0
    for filename in ${name_l}
    do
        n=$((n+1))
        num=`printf "%05d\n" ${n}`
        ext="${filename##*.}"
        new_name="${num}.${ext}"
        src_file="${src_path}/${filename}"
        dst_file="${dst_path}/${new_name}"

        if [ "${src_file}" = "${dst_file}" ]; then
            echo -e "\033[33mWarning: Same path !\033[0m"
            continue
        fi

        echo "${src_file} --> ${dst_file}"
        mv ${src_file} ${dst_file}
    done
fi

# ========== 1. Rename (END) ==========