use function Facebook\FBExpect\expect;
use type Facebook\HackTest\{DataProvider, HackTest};
use type WordPool\Adapter\Exception\DataEmptyException;

final class CSVAdapterTest extends HackTest
{
    const string TEST_CSV_PATH = 'tests/wordpool/adapter/testwords.csv';
    const string EXPECT_WORD = '愛煙家';

    public function provideCSVLines(): vec<(string, vec<vec<string>>, string)> {
        return vec[
            tuple("aa,bb,cc\ndd,ee,ff", vec[vec['aa', 'bb', 'cc'],vec['dd', 'ee', 'ff']], 'normal csv'),
            tuple("aa,bb  ,  cc  \n  \n  dd, ee,ff", vec[vec['aa', 'bb', 'cc'],vec['dd', 'ee', 'ff']], 'whitespace trim'),
            tuple(',bb,cc', vec[vec['', 'bb', 'cc']], 'part of empty'),
            tuple(',', vec[vec['', '']], 'empty columns'),
        ];
    }

    <<DataProvider('provideCSVLines')>>
    public function testCreateInstanceWithCSV(string $line, vec<vec<string>> $expect, string $message): void
    {
        \file_put_contents(self::TEST_CSV_PATH, $line);

        $adapter = new WordPool\Adapter\CSVAdapter(self::TEST_CSV_PATH);

        $reflect = new \ReflectionClass($adapter);
        $property = $reflect->getProperty('data');
        $property->setAccessible(true);

        expect($property->getValue($adapter))->toBeSame($expect, $message);

        \file_put_contents(self::TEST_CSV_PATH,'');
    }

    public function provideEmptyCSVLines(): vec<(string, string)> {
        return vec[
            tuple('', 'file empty'),
            tuple('   ', 'whitespace'),
            tuple(\PHP_EOL, 'EOL only'),
            tuple(sprintf('  %s  ', \PHP_EOL), 'whitespace and EOL'),
        ];
    }

    <<DataProvider('provideEmptyCSVLines')>>
    public function testCreateInstanceWithEmptyCSV(string $unreadableCSVLine, string $message): void
    {
        \file_put_contents(self::TEST_CSV_PATH, $unreadableCSVLine);

        expect(() ==> {
            new WordPool\Adapter\CSVAdapter(self::TEST_CSV_PATH);
        })->toThrow(DataEmptyException::class, \sprintf('CSV file `%s` is empty.', self::TEST_CSV_PATH), $message);

        \file_put_contents(self::TEST_CSV_PATH,'');
    }

    public function testTakeWordAtRandomInCSV(): void
    {
        \file_put_contents(self::TEST_CSV_PATH, self::EXPECT_WORD.',あいえんか,名詞\n');

        $adapter = new WordPool\Adapter\CSVAdapter(self::TEST_CSV_PATH);

        $word = $adapter->takeAtRandom();
        expect($word)->toBeSame(self::EXPECT_WORD, 'Take a word.');

        \file_put_contents(self::TEST_CSV_PATH,'');
    }
}
