Received: from mail-pg1-f193.google.com ([209.85.215.193]:41872 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753567AbeGGL2f (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 Jul 2018 07:28:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id l65-v6so481840pgl.8
        for <fstests@vger.kernel.org>; Sat, 07 Jul 2018 04:28:35 -0700 (PDT)
Date: Sat, 7 Jul 2018 19:28:30 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 4/8] generic: convert some tests to new setup preamble
Message-ID: <20180707112830.GH2780@desktop>
References: <20180627082103.9662-1-david@fromorbit.com>
 <20180627082103.9662-5-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627082103.9662-5-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 27, 2018 at 06:20:59PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Small initial batch to demonstrate conversion.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/generic/001 | 49 +++++++++++++++++------------------------------
>  tests/generic/002 | 25 +++++++-----------------
>  tests/generic/003 | 30 ++++++++---------------------
>  tests/generic/004 | 32 +++++++++----------------------
>  tests/generic/005 | 44 ++++++++++++++++--------------------------
>  tests/generic/006 | 34 ++++++++++++--------------------
>  tests/generic/007 | 29 ++++++++--------------------
>  tests/generic/008 | 27 +++++++++-----------------
>  tests/generic/009 | 28 +++++++++------------------
>  9 files changed, 97 insertions(+), 201 deletions(-)
> 
> diff --git a/tests/generic/001 b/tests/generic/001
> index 046e54e374a4..58ef45ed7102 100755
> --- a/tests/generic/001
> +++ b/tests/generic/001
> @@ -15,25 +15,29 @@
>  # config has one line per file with filename and byte size, else use
>  # the default one below.
>  #
> -seq=`basename $0`
> -seqres=$RESULT_DIR/$seq
> -echo "QA output created by $seq"
> +. common/setup_test
>  
> -# get standard environment, filters and checks
> -. ./common/rc
> -. ./common/filter
> +# test exit cleanup goes here
> +cleanup() {
> +    if $done_cleanup ; then
> +	:
> +    elif [ $status -eq 0 ]; then
> +	$verbose && echo "cleanup"
> +	cd /
> +	rm -rf $TEST_DIR/$$
> +	done_cleanup=true
> +    fi
> +}
>  
> -tmp=/tmp/$$
> -here=`pwd`
> -status=1
> -done_cleanup=false
> -trap "_cleanup; rm -f $tmp.*; exit \$status" 0 1 2 3 15
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
>  
> -# real QA test starts here
> +# include test specific environments here
>  _supported_fs generic
>  _supported_os Linux
>  _require_test
>  
> +done_cleanup=false
>  verbose=true
>  verify=$here/verify_fill
>  
> @@ -260,25 +264,9 @@ _check()
>      $verbose && echo
>  }
>  
> -_cleanup()
> -{
> -    # cleanup
> -    #
> -    if $done_cleanup
> -    then
> -	:
> -    elif [ $status -eq 0 ]
> -    then
> -	$verbose && echo "cleanup"
> -	cd /
> -	rm -rf $TEST_DIR/$$
> -	done_cleanup=true
> -    fi
> -}
> -
>  rm -f $seqres.full
>  status=0
> -_cleanup
> +cleanup
>  status=1
>  done_cleanup=false
>  
> @@ -299,5 +287,4 @@ do
>      fi
>  done
>  
> -status=0
> -exit
> +_success
> diff --git a/tests/generic/002 b/tests/generic/002
> index 8242ea907c1b..9943a077fe6b 100755
> --- a/tests/generic/002
> +++ b/tests/generic/002
> @@ -6,31 +6,20 @@
>  #
>  # simple inode link count test for a regular file
>  #
> -seq=`basename $0`
> -seqres=$RESULT_DIR/$seq
> -echo "QA output created by $seq"
> +. common/setup_test
>  
> -# get standard environment, filters and checks
> -. ./common/rc
> -. ./common/filter
> +# test exit cleanup goes here
> +cleanup() { :; }
>  
> -tmp=/tmp/$$
> -here=`pwd`
> -status=0	# success is the default!
> -trap "_cleanup; exit \$status" 0 1 2 3 15
>  
> -_cleanup()
> -{
> -    rm -f $tmp.*
> -}
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
>  
> -# real QA test starts here
> +# include test specific environments here
>  _supported_fs generic
>  _supported_os Linux
>  _require_test
>  
> -rm -f $seqres.full
> -
>  echo "Silence is goodness ..."
>  
>  # ensure target directory exists
> @@ -62,4 +51,4 @@ do
>  done
>  
>  # success, all done
> -exit
> +_success
> diff --git a/tests/generic/003 b/tests/generic/003
> index 767d70593c3f..d928b9392686 100755
> --- a/tests/generic/003
> +++ b/tests/generic/003
> @@ -9,34 +9,22 @@
>  # never updated on read-only subvolumes. (Regression test for bug fixed
>  # with commit 93fd63c2f001ca6797c6b15b696a484b165b4800)
>  #
> -seq=`basename $0`
> -seqres=$RESULT_DIR/$seq
> -echo "QA output created by $seq"
> -
> -here=`pwd`
> -tmp=/tmp/$$
> -status=1	# failure is the default!
> -trap "_cleanup; exit \$status" 0 1 2 3 15
> -
> -_cleanup()
> -{
> -    cd /
> -    rm -rf $tmp.*
> -}
> +. common/setup_test
>  
> -# get standard environment, filters and checks
> -. ./common/rc
> -. ./common/filter
> +# test exit cleanup goes here
> +cleanup() { :; }
>  
> -# real QA test starts here
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
>  
> +# include test specific environments here
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
>  _require_atime
>  _require_relatime
>  
> -rm -f $seqres.full
> +echo "Silence is golden"
>  
>  _stat() {
>  	stat -c "%x;%y;%z" $1
> @@ -189,6 +177,4 @@ _compare_stat_times NNN "$file3_stat_before_ro_mount" \
>  
>  # success, all done
>  _scratch_unmount
> -echo "Silence is golden"
> -status=0
> -exit
> +_success
> diff --git a/tests/generic/004 b/tests/generic/004
> index 156d68aee19f..a4d3d5d9d32e 100755
> --- a/tests/generic/004
> +++ b/tests/generic/004
> @@ -6,35 +6,23 @@
>  #
>  # Test O_TMPFILE opens, and linking them back into the namespace.
>  #
> -seq=`basename $0`
> -seqres=$RESULT_DIR/$seq
> -echo "QA output created by $seq"
> -
> -here=`pwd`
> -tmp=/tmp/$$
> -status=1	# failure is the default!
> -trap "_cleanup; exit \$status" 0 1 2 3 15
> -
> -_cleanup()
> -{
> -    cd /
> -    rm -f ${testfile}
> +. common/setup_test
> +
> +# test exit cleanup goes here
> +cleanup() {
> +	rm -f ${testfile}
>  }
>  
> -# get standard environment, filters and checks
> -. ./common/rc
> -. ./common/filter
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
>  
> -# real QA test starts here
> +# include test specific environments here
>  _supported_fs generic
>  _supported_os Linux
> -
>  _require_test
>  _require_xfs_io_command "-T"
>  _require_xfs_io_command "flink"
>  
> -rm -f $seqres.full
> -
>  testfile="${TEST_DIR}/tst-tmpfile-flink"
>  
>  # test creating a r/w tmpfile, do I/O and link it into the namespace
> @@ -49,6 +37,4 @@ rm ${testfile}
>  # test creating a r/o tmpfile.  Should fail
>  $XFS_IO_PROG -Tr ${TEST_DIR} -c "close" 2>&1 | _filter_test_dir
>  
> -# success, all done
> -status=0
> -exit
> +_success
> diff --git a/tests/generic/005 b/tests/generic/005
> index 118fca20ed5d..ceff4117319e 100755
> --- a/tests/generic/005
> +++ b/tests/generic/005
> @@ -9,28 +9,29 @@
>  #
>  # Note: On Linux, ELOOP limit used to be 32 but changed to 8, and lately
>  # its become 5.  Who knows what it might be next.
> -# 
> +#
>  # What we are looking for here is: no panic due to blowing the stack;
>  # and that the ELOOP error code is returned at some point (the actual
>  # limit point is unimportant, just checking that we do hit it).
> -# 
> -
> -seq=`basename $0`
> -seqres=$RESULT_DIR/$seq
> -echo "QA output created by $seq"
> +#
> +. common/setup_test
>  
> -here=`pwd`
> -tmp=/tmp/$$
> -status=0	# success is the default!
> -trap "_cleanup; exit \$status" 0 1 2 3 15
> +# test exit cleanup goes here
> +cleanup() {
> +    rm -f $TEST_DIR/symlink_{0,1,2,3,4}{0,1,2,3,4,5,6,7,8,9}
> +    rm -f $TEST_DIR/symlink_self empty_file

Looked like "empty_file" was not cleaned up, but it's removed correctly
because test cd'ed into $TEST_DIR. IMHO, it's better to remove
"empty_file" with full path name as all other files, really a minor
issue though.

Thanks,
Eryu
