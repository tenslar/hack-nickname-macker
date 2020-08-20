#!/usr/bin/env hhvm
use type NickNameMaker\WordPool;

<<__EntryPoint>>
function main(): void {
    require_once(__DIR__.'/../vendor/autoload.hack');
    \Facebook\AutoloadMap\initialize();

    $word_pool = new WordPool('src/words.csv');
    $nickname = make_nickname($word_pool);
    display_word($nickname);
}

function make_nickname(WordPool $wordPool): string {
    // Fetch 3 times for WordPools.
    $taking_num = 3;
    $words = vec[];

    for ($i = 0; $i < $taking_num; $i++) {
        $words[] = $wordPool->takeAtRandom();
    }

    // Concat some words.

    return \implode('', $words);
}

function display_word(string $word): void {
    printf("Your name is `%s` !\n", $word);
}
