# Level #4
**Level #4:** Compression :3

## Check Guidelines
- Solve the level. 
- Run `check.sh` to get the key

## Level Description
1. Create a compressed version (using bzip2) of the two files inside `Price`. Keep the original files as well.
```
Price
├── 1
├── 1.bz2
├── Hello_To_My_Place
└── Hello_To_My_Place.bz2
```
2. Compress the `Elio` directory using `zip` to a file named `Elio.zip`.
3. Uncompress `Bryan.gz`, keeping the original compressed file.
4. Your folder should now look like this:
```
├── Bryan
├── Bryan.gz
├── Elio
│   └── notice
├── Elio.zip
├── Price
│   ├── 1
│   ├── 1.gz
│   ├── Hello_To_My_Place
│   └── Hello_To_My_Place.gz
└── Price.zip
```
