# NicknameMacker: A nickname making script

NicknameMacker is a simple [Hack](https://hacklang.org/)-based nickname making script. It make nice japanese nickname concat some words and recommend.

## Demo

```sh
$ bin/main.hack
Your name is `本当は埋める足首` !
$ bin/main.hack
Your name is `面接夢中出社` !
$ bin/main.hack
Your name is `白っぽいもったいないすべて` !
$ bin/main.hack
Your name is `年寄り段落はがす` !
$ bin/main.hack
Your name is `セールスマン距離屋台` !
$ bin/main.hack
Your name is `断る国語桃色` !
```

## Feature

- Only making nice nickname!

## Requirements

- [HHVM execution environment](https://docs.hhvm.com/hhvm/installation/introduction#prebuilt-packages)
- [Composer](https://getcomposer.org/)
- The appropriate version of PHP

## Installation

Install [HHVM](https://docs.hhvm.com/hhvm/installation/introduction#prebuilt-packages).

Clone this repository, And Composer install.
```sh
$ git clone git@github.com:tenslar/hack-nickname-macker.git
$ composer install
```

## Usage

Add execute permision to `bin/main.hack`.
```sh
$ chmod +x bin/main.hack
```

And execute script.
```sh
$ bin/main.hack
Your name is `断る国語桃色` !
```
