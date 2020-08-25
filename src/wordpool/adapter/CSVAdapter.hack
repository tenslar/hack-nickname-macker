namespace WordPool\Adapter;

use type WordPool\Adapter;
use type WordPool\Adapter\Exception\DataEmptyException;

class CSVAdapter implements Adapter {
    private vec<vec<string>> $data = vec[];
    private int $record_num = 0;
    const int COL_WORD = 0;

    public function __construct(string $filepath): void {
        $this->data = $this->readAll($filepath);
        $this->record_num = \count($this->data);
        if ($this->record_num <= 0) {
            throw new DataEmptyException(
                \sprintf('CSV file `%s` is empty.', $filepath),
            );
        }
    }

    public function takeAtRandom(): string {
        $last_record_index = $this->record_num - 1;
        $selectable_record_limit = \min($last_record_index, \PHP_INT_MAX);
        $selected_record = \random_int(0, $selectable_record_limit);
        return $this->data[$selected_record][self::COL_WORD];
    }

    private function readAll(string $filepath): vec<vec<string>> {
        $fp = \fopen($filepath, 'r');
        $read_data = vec[];

        while (!\feof($fp)) {
            $line = \fgets($fp);

            // arrived EOL or happened fgets error
            if ($line === false) {
                break;
            }

            // line to record.
            // e.g.) 'hoge,  fuga  ' -> ['hoge', 'fuga']
            // e.g.) '' -> ['']
            $record = \array_map(
                ($column) ==> {
                    return \trim($column);
                },
                \explode(',', $line),
            );

            // validate `['']`
            if (\count($record) === 1 && $record[0] === '') {
                continue;
            }

            // convert to vec<string>
            $vec_record = vec[];
            foreach ($record as $value) {
                $vec_record[] = (string)$value;
            }

            $read_data[] = $vec_record;
        }
        \fclose($fp);

        return $read_data;
    }
}
