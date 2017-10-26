Received: from mx1.redhat.com ([209.132.183.28]:46734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932206AbdJZJ6W (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 26 Oct 2017 05:58:22 -0400
Date: Thu, 26 Oct 2017 17:58:20 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2][v3] fstests: add fio perf results support
Message-ID: <20171026095820.GN3235@eguan.usersys.redhat.com>
References: <1508360332-12033-1-git-send-email-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508360332-12033-1-git-send-email-josef@toxicpanda.com>
Sender: fstests-owner@vger.kernel.org
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, david@fromorbit.com, fstests@vger.kernel.org, tytso@mit.edu, darrick.wong@oracle.com, Josef Bacik <jbacik@fb.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Oct 18, 2017 at 04:58:51PM -0400, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> This patch does the nuts and bolts of grabbing fio results and storing
> them in a database in order to check against for future runs.  This
> works by storing the results in resuts/fio-results.db as a sqlite
> database.  The src/perf directory has all the supporting python code for
> parsing the fio json results, storing it in the database, and loading
> previous results from the database to compare with the current results.
> 
> This also adds a PERF_CONFIGNAME option that must be set for this to
> work.  Since we all have various ways we run fstests it doesn't make
> sense to compare different configurations with each other (unless
> specifically desired).  The PERF_CONFIGNAME will allow us to separate
> out results for different test run configurations to make sure we're
> comparing results correctly.
> 
> Currently we only check against the last perf result.  In the future I
> will flesh this out to compare against the average of N number of runs
> to be a little more complete, and hopefully that will allow us to also
> watch latencies as well.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>
> ---
> v2->v3:
> - fixed FioResultDecoder.py so it would translate from older versions of fio
>   properly
> - fixed FioCompare.py to be a bit more verbose so we know things are working or
>   what goes wrong when it isn't.
> - fixed fio-insert-and-compare.py so it grabbed the last resulte _before_ we
>   insert a new result.
> - fixed generate-schema.py to generate an updated schema, including not using
>   NOT NULL for all of the fields in case we have some missing fields from older
>   versions of fio that we don't care about.
> - updated fio-results.sql with the new schema.

v3 works fine now (after I deleted the old $RESULT_BASE/fio-result.db
file), thanks!

> 
> v1->v2:
> - moved helpers into common/perf
> - changed the python stuff to specifically use python2 since that's the lowest
>   common demoninator
> 
>  .gitignore                         |   1 +
>  common/config                      |   2 +
>  common/perf                        |  41 ++++++++++++++
>  src/perf/FioCompare.py             | 112 +++++++++++++++++++++++++++++++++++++
>  src/perf/FioResultDecoder.py       |  62 ++++++++++++++++++++
>  src/perf/ResultData.py             |  43 ++++++++++++++
>  src/perf/fio-insert-and-compare.py |  35 ++++++++++++
>  src/perf/fio-results.sql           |  94 +++++++++++++++++++++++++++++++
>  src/perf/generate-schema.py        |  55 ++++++++++++++++++
>  9 files changed, 445 insertions(+)
>  create mode 100644 common/perf
>  create mode 100644 src/perf/FioCompare.py
>  create mode 100644 src/perf/FioResultDecoder.py
>  create mode 100644 src/perf/ResultData.py
>  create mode 100644 src/perf/fio-insert-and-compare.py
>  create mode 100644 src/perf/fio-results.sql
>  create mode 100644 src/perf/generate-schema.py
> 
> diff --git a/.gitignore b/.gitignore
> index ae7ef87ab384..986a6f7ff0ad 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -156,6 +156,7 @@
>  /src/aio-dio-regress/aiocp
>  /src/aio-dio-regress/aiodio_sparse2
>  /src/log-writes/replay-log
> +/src/perf/*.pyc
>  
>  # dmapi/ binaries
>  /dmapi/src/common/cmd/read_invis
> diff --git a/common/config b/common/config
> index 71798f0adb1e..f6226d85bc10 100644
> --- a/common/config
> +++ b/common/config
> @@ -195,6 +195,8 @@ export MAN_PROG="`set_prog_path man`"
>  export NFS4_SETFACL_PROG="`set_prog_path nfs4_setfacl`"
>  export NFS4_GETFACL_PROG="`set_prog_path nfs4_getfacl`"
>  export UBIUPDATEVOL_PROG="`set_prog_path ubiupdatevol`"
> +export PYTHON2_PROG="`set_prog_path python2`"
> +export SQLITE3_PROG="`set_prog_path sqlite3`"

Can you please add a document file in doc dir to describe this new
framework? And maybe update README file as well for the new prerequisite
packages.

>  
>  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>  # newer systems have udevadm command but older systems like RHEL5 don't.
> diff --git a/common/perf b/common/perf
> new file mode 100644
> index 000000000000..b9b4f79c5edc
> --- /dev/null
> +++ b/common/perf
> @@ -0,0 +1,41 @@
> +#
> +# Common perf specific functions
> +#
> +
> +
> +_require_fio_results()
> +{
> +	if [ -z "$PERF_CONFIGNAME" ]
> +	then
> +		_notrun "this test requires \$PERF_CONFIGNAME to be set"
> +	fi
> +	_require_command $PYTHON2_PROG python2
> +
> +	$PYTHON2_PROG -c "import sqlite3" >/dev/null 2>&1
> +	[ $? -ne 0 ] && _notrun "this test requires python sqlite support"
> +
> +	$PYTHON2_PROG -c "import json" >/dev/null 2>&1
> +	[ $? -ne 0 ] && _notrun "this test requires python json support"
> +
> +	_require_command $SQLITE3_PROG sqlite3
> +}
> +
> +_fio_results_init()
> +{
> +	cat $here/src/perf/fio-results.sql | \
> +		$SQLITE3_PROG $RESULT_BASE/fio-results.db
> +	[ $? -ne 0 ] && _fail "failed to create results database"
> +	[ ! -e $RESULT_BASE/fio-results.db ] && \
> +		_fail "failed to create results database"
> +}
> +
> +_fio_results_compare()
> +{
> +	_testname=$1
> +	_resultfile=$2
> +
> +	run_check $PYTHON2_PROG $here/src/perf/fio-insert-and-compare.py \
> +		-c $PERF_CONFIGNAME -d $RESULT_BASE/fio-results.db \
> +		-n $_testname $_resultfile

Hmm, please avoid using run_check, it makes reviewing result harder

+failed: '/usr/bin/python2 /root/workspace/xfstests/src/perf/fio-insert-and-compare.py -c test -d /root/workspace/xfstests/results//fio-results.db -n 001 /tmp/7002.json'
+(see /root/workspace/xfstests/results//xfs_4k_crc/perf/001.full for details)

then I need to open 001.full to see why test failed.

I'd prefer just dumping the fio-insert-and-compare.py output to stdout
so that breaks golden image, and we can see the failure reason from the
diff output directly.

+read_iops is a-ok 0.0 0.0
+    write_iops improved: old 25097.55864 new 30469.460103 21.4040797356%
+trim_iops is a-ok 0.0 0.0
+read_io_bytes is a-ok 0 0
+write_io_bytes is a-ok 2097152 2097152
+trim_io_bytes is a-ok 0 0
+read_bw is a-ok 0 0
+    write_bw improved: old 100390 new 121877 21.4035262476%
+trim_bw is a-ok 0 0
+    sys_cpu regressed: old 56.795443 new 65.384168 15.122207956%
+    elapsed improved: old 22 new 18 -18.1818181818%

So I know test failed because "sys_cpu regressed", if I want more
details I can look at perf/001.full file.

(skipped the shining python code :)

Thanks,
Eryu
