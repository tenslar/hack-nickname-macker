use function Facebook\FBExpect\expect;
use type Facebook\HackTest\HackTest;

final class WordPoolTest extends HackTest
{
    public function testTakeSomeWords(): void
    {
        $file = 'tests/testwords.csv';
        $word_pool = new NickNameMaker\WordPool($file);

        $word = $word_pool->takeAtRandom();
        expect($word)->toBeType('string', 'Take random a word.');
    }
}
