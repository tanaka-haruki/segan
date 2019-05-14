#!/bin/csh

### csh command | option, dl : download, uz : unzip, ds : downsampling
# $ csh downsampling_dataset.sh -dl -uz -ds
###
# before data structure
# DS_10283_1942
#  |- downsampling_dataset.sh
##
# after data structure
# DS_10283_1942
#  |- downsampling_dataset.sh
#  |
#  |- clean_trainset_wav.zip
#  |- noisy_trainset_wav.zip
#  |- clean_testset_wav.zip
#  |- noisy_testset_wav.zip
#  |
#  |- clean_trainset_wav
#  |- noisy_trainset_wav
#  |- clean_testset_wav
#  |- noisy_testset_wav
#  |
#  |- data
#      |- clean_trainset_wav_16k
#      |- noisy_trainset_wav_16k
#      |- clean_testset_wav_16k
#      |- noisy_testset_wav_16k
###

mkdir -p data

if ( "$#argv" >= 1 && "$#argv" <= 3 ) then
  foreach arg ( $* )
    # train set
    if ( ! -d data/clean_trainset_wav_16k ) then
      if ( "$arg" == "-dl" ) then
        if ( ! -f clean_trainset_wav.zip ) then
          echo 'DOWNLOADING CLEAN TRAINSET...'
          wget http://datashare.is.ed.ac.uk/bitstream/handle/10283/1942/clean_trainset_wav.zip
        endif
      endif

      if ( "$arg" == "-uz") then
        if ( ! -d clean_trainset_wav ) then
          echo 'INFLATING CLEAN TRAINSET ZIP...'
          unzip -q clean_trainset_wav.zip -d clean_trainset_wav
        endif
      endif

      if ( "$arg" == "-ds") then
        echo 'CONVERTING TRAIN CLEAN WAVS TO 16K...'
        mkdir -p data/clean_trainset_wav_16k
        pushd clean_trainset_wav
        foreach name ( `ls *.wav` )
          echo $name -r 16k ../data/clean_trainset_wav_16k/$name
          sox $name -r 16k ../data/clean_trainset_wav_16k/$name
        end
        popd
      endif
    endif

    if ( ! -d data/noisy_trainset_wav_16k ) then
      if ( "$arg" == "-dl" ) then
        if ( ! -f noisy_trainset_wav.zip ) then
          echo 'DOWNLOADING NOISY TRAINSET...'
          wget http://datashare.is.ed.ac.uk/bitstream/handle/10283/1942/noisy_trainset_wav.zip
        endif
      endif

      if ( "$arg" == "-uz" ) then
        if ( ! -d noisy_trainset_wav ) then
          echo 'INFLATING NOISY TRAINSET ZIP...'
          unzip -q noisy_trainset_wav.zip -d noisy_trainset_wav
        endif
      endif

      if ( "$arg" == "-ds") then
        echo 'CONVERTING TRAIN NOISY WAVS TO 16K...'
        mkdir -p data/noisy_trainset_wav_16k
        pushd noisy_trainset_wav
        foreach name ( `ls *.wav` )
          echo $name -r 16k ../data/noisy_trainset_wav_16k/$name
          sox $name -r 16k ../data/noisy_trainset_wav_16k/$name
        end
        popd
      endif
    endif

    # test set
    if ( ! -d data/clean_testset_wav_16k ) then
      if ( "$arg" == "-dl" ) then
        if ( ! -f clean_testset_wav.zip ) then
          echo 'DOWNLOADING CLEAN TESTSET...'
          wget https://datashare.is.ed.ac.uk/bitstream/handle/10283/1942/clean_testset_wav.zip
        endif
      endif

      if ( "$arg" == "-uz" ) then
        if ( ! -d clean_testset_wav ) then
          echo 'INFLATING CLEAN TESTSET ZIP...'
          unzip -q clean_testset_wav.zip
        endif
      endif

      if ( "$arg" == "-ds") then
        echo 'CONVERTING TEST CLEAN WAVS TO 16K...'
        mkdir -p data/clean_testset_wav_16k
        pushd clean_testset_wav
        foreach name ( `ls *.wav` )
          echo $name -r 16k ../data/clean_testset_wav_16k/$name
          sox $name -r 16k ../data/clean_testset_wav_16k/$name
        end
        # popd
        popd
      endif
    endif

    if ( ! -d data/noisy_testset_wav_16k ) then
      if ( "$arg" == "-dl" ) then
        if ( ! -f noisy_testset_wav.zip ) then
          echo 'DOWNLOADING NOISY TESTSET...'
          wget https://datashare.is.ed.ac.uk/bitstream/handle/10283/1942/noisy_testset_wav.zip
        endif
      endif

      if ( "$arg" == "-uz" ) then
        if ( ! -d noisy_testset_wav ) then
          echo 'INFLATING NOISY TESTSET ZIP...'
          unzip -q noisy_testset_wav.zip
        endif
      endif

      if ( "$arg" == "-ds") then
        echo 'CONVERTING TEST NOISY WAVS TO 16K...'
        mkdir -p data/noisy_testset_wav_16k
        pushd noisy_testset_wav
        foreach name ( `ls *.wav` )
          echo $name -r 16k ../data/noisy_testset_wav_16k/$name
          sox $name -r 16k ../data/noisy_testset_wav_16k/$name
        end
        popd
      endif
    endif
  end
endif
echo Finish!