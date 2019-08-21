# Referential Integrity checks for foreign keys in Text related tables
# @see Acts.bats

# PrimarySource
@test "check person foreign keys in PrimarySource.author" {
  result=$(mlr --csv join -j author --np --ul -f data/PrimarySource.csv then cut -f author then uniq -a data/Person.csv | grep -ow -c "P[0-9]+" || true)
  [ "$result" -eq 0 ]
}

@test "check groups foreign keys in PrimarySource.author" {
  result=$(mlr --csv join -j author --np --ul -f data/PrimarySource.csv then cut -f author then uniq -a data/Institution.csv | grep -ow -c "I[0-9]+" || true)
  [ "$result" -eq 0 ]
}

@test "check genre foreign keys in PrimarySource.genre" {
  run mlr --csv join -j genre -r genre_id --np --ul -f data/PrimarySource.csv then cut -f genre then uniq -a -n data/Genre.csv
  [ "$status" -eq 0 ]
  [ "${lines[1]}" -eq 0 ]
}

@test "check place foreign keys in PrimarySource.publication_place" {
  run mlr --csv join -j publication_place -r place_id --np --ul -f data/PrimarySource.csv then cut -f publication_place then uniq -a -n data/Place.csv
  [ "$status" -eq 0 ]
  # NULL empty unkown
  [ "${lines[1]}" -eq 3 ]
}

# SecondarySource
@test "check person foreign keys in SecondarySource.author" {
  result=$(mlr --csv join -j author --np --ul -f data/SecondarySource.csv then cut -f author then uniq -a data/Person.csv | grep -ow -c "P[0-9]+" || true)
  [ "$result" -eq 0 ]
}

@test "check groups foreign keys in SecondarySource.author" {
  result=$(mlr --csv join -j author --np --ul -f data/SecondarySource.csv then cut -f author then uniq -a data/Institution.csv | grep -ow -c "I[0-9]+" || true)
  [ "$result" -eq 0 ]
}

@test "check genre foreign keys in SecondarySource.genre" {
  run mlr --csv join -j genre -r genre_id --np --ul -f data/SecondarySource.csv then cut -f genre then uniq -a -n data/Genre.csv
  [ "$status" -eq 0 ]
  [ "${lines[1]}" -eq 0 ]
}

@test "check place foreign keys in SecondarySource.publication_place" {
  run mlr --csv join -j publication_place -r place_id --np --ul -f data/SecondarySource.csv then cut -f publication_place then uniq -a -n data/Place.csv
  [ "$status" -eq 0 ]
  # empty
  [ "${lines[1]}" -eq 1 ]
}

# Quotation
@test "check primary source foreign keys in Quotation.source" {
  result=$(mlr --csv join -j source --np --ul -f data/Quotation.csv then cut -f source then uniq -a data/PrimarySource.csv | grep -ow -c "PS[0-9]+" || true)
  [ "$result" -eq 0 ]
}

@test "check secondary source foreign keys in Quotation.source_id" {
  result=$(mlr --csv join -j source --np --ul -f data/Quotation.csv then cut -f source then uniq -a data/SecondarySource.csv | grep -ow -c "SS[0-9]+" || true)
  [ "$result" -eq 0 ]
}
