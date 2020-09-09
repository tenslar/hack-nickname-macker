use function Facebook\FBExpect\expect;
use type Facebook\HackTest\{DataProvider, HackTest};
use type APIClient\Twitter\TwitterAPIClient;

final class TwitterAPIClientTest extends HackTest {
    const string TEST_CSV_PATH = 'tests/wordpool/adapter/testwords.csv';
    const string EXPECT_WORD = '愛煙家';

    public function provideConfig(): vec<(dict<string, string>, string)>
    {
        return vec[
            tuple(dict[
                'aaa' => 'aaa',
            ], 'sample'),
        ];
    }

    <<DataProvider('provideConfig')>>
    public function testCreateInstanceWithConfig(dict<string, string> $config): void
    {
        expect(new TwitterAPIClient($config))->toBeInstanceOf(TwitterAPIClient::class);
    }

    public function testTweet(): void
    {
        $config = dict[];
        $client = new TwitterAPIClient($config);
        expect($client->tweet('konitiha!'))->toBeTrue();
    }
}
