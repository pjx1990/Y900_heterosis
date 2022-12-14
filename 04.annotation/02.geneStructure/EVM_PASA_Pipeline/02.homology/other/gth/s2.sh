grep -v "^#" test_gth.gff | grep -v "prime_cis_splice_site" | awk -F ";" '{print$1}'>test_gth_homo.gff
