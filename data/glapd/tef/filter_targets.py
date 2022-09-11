import pathlib


def filter_targets():
    base_dir = pathlib.Path(__file__).parent
    dataset_path = base_dir / "dataset.fasta"

    with open(base_dir / "target_names.txt", "w+") as target_f, open(dataset_path, "r") as dataset_f:
        for line in dataset_f.readlines():
            if (line[0] == ">") and ("fagacearum" in line):
                target_f.write(line)


if __name__ == "__main__":
    filter_targets()
