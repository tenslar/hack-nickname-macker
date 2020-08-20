namespace NickNameMaker;

use namespace HH\Lib\C;

class WordPool
{
    private string $filepath;
    private int $poolsize;
    const BUFF_SIZE = 4096;
    public function __construct(string $filepath)
    {
        if (!\file_exists($filepath)) {
            throw new \InvalidArgumentException(\sprintf('file `%s` not exist.\n', $filepath));
        }
        $this->filepath = $filepath;
        $this->poolsize = $this->fcount();
    }

    private function fcount(): int
    {
        $fp = \fopen($this->filepath, 'r');
        $linecount = 0;

        while(!\feof($fp)) {
            $buff = \fgets($fp);
            if (\is_bool($buff)) {
                break;
            }
            $linecount = $linecount + \substr_count($buff, \PHP_EOL);
        }
        \fclose($fp);

        return $linecount;
    }

    private function fetchLineAt(int $targetLine): string
    {
        $fp = \fopen($this->filepath, 'r');
        $buff = '';

        $max = \min($targetLine, $this->poolsize);
        for($line = 0; $line < $max; $line++) {
            $buff = \fgets($fp, self::BUFF_SIZE);
        }
        \fclose($fp);
        return \trim($buff);
    }

    private function attractWord(string $lineBuff): string
    {
        $columns = \explode(',', $lineBuff);
        if (C\count($columns) > 0) {
            return \str_replace('"', '', $columns[0]);
        }
        return '';
    }

    private function randomLineNum(): int
    {
        return \random_int(1, $this->poolsize);
    }

    public function takeAtRandom():string
    {
        $target_line_num = $this->randomLineNum();
        $line = $this->fetchLineAt($target_line_num);
        return $this->attractWord($line);
    }
}
