#!/usr/bin/env hhvm
namespace NicknameMacker\Bin\TwitterPost;
use type WordPool\Adapter\CSVAdapter;

<<__EntryPoint>>
function twitter_post_main(): void {
    require_once(__DIR__.'/../vendor/autoload.hack');
    \Facebook\AutoloadMap\initialize();

    $word_pool = new CSVAdapter('src/words.csv');
    $nickname = make_nickname($word_pool);
    twitter_post($nickname);
}

function make_nickname(CSVAdapter $wordPool): string {
    // Fetch 3 times for WordPools.
    $taking_num = 3;
    $words = vec[];

    for ($i = 0; $i < $taking_num; $i++) {
        $words[] = $wordPool->takeAtRandom();
    }

    // Concat some words.

    return \implode('', $words);
}

function twitter_post(string $word): void {
    \printf("Tweet posted! msg: %s \n", $word);
}
