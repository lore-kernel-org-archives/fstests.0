Received: from mail-pf1-f195.google.com ([209.85.210.195]:43296 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbeGUSVA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 21 Jul 2018 14:21:00 -0400
Date: Sun, 22 Jul 2018 01:27:27 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] fstests: add generic/499, a cgroup io.latency test
Message-ID: <20180721172505.GA2791@desktop>
References: <20180629192124.22505-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629192124.22505-1-josef@toxicpanda.com>
Sender: fstests-owner@vger.kernel.org
To: Josef Bacik <josef@toxicpanda.com>
Cc: fstests@vger.kernel.org, kernel-team@fb.com, Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

[My apoligy for the late review, I finally got some time to look into
this new feature and test]

On Fri, Jun 29, 2018 at 03:21:24PM -0400, Josef Bacik wrote:
> The infrastructure is fairly straightforward, just some helpers to
> verify cgroup2 is mounted and to setup a cgroup for our test.  The fio
> json script just uses the existing library to print out a value for a
> given key in a fio json output file.
> 
> The test itself runs a fio job outside of a cgroup by itself to
> establish the baseline performance of the job.  Then we setup two
> cgroups, one protected with io.latency and one that is not, and run the
> same job with 2 threads doing the same workload, one in the protected
> group and one in the unprotected group.  We are trying to verify that
> io.latency does the protection properly.
> 
> I tested this with my kernel that has io.latency enabled, as well as
> with and without all the various features turned off so hopefully it
> fails gracefully for people who don't have the pre-requisites.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

First of all, I'm wondering if it should be added to blktests instead of
fstests, as it's a pure new feature in block layer. Adding linux-block
list and Omar Sandoval to cc list.

Some comments inline from fstests' perspective anyway.

> ---
> NOTE: You need io.latency, which can only be found in my blk-iolatency branches
> in my btrfs-next tree on kernel.org.  You also need the fio master branch
> because I had to fix fio to work with cgroup2 and spit out the right numbers for
> us to verify.
> 
>  common/cgroup             |  42 +++++++++++++
>  common/config             |   1 +
>  common/perf               |  10 +++
>  src/perf/fio-key-value.py |  28 +++++++++
>  tests/generic/499         | 151 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/499.out     |   2 +
>  tests/generic/group       |   1 +
>  7 files changed, 235 insertions(+)
>  create mode 100644 common/cgroup
>  create mode 100644 src/perf/fio-key-value.py
>  create mode 100644 tests/generic/499
>  create mode 100644 tests/generic/499.out
> 
> diff --git a/common/cgroup b/common/cgroup
> new file mode 100644
> index 000000000000..d74d402976a7
> --- /dev/null
> +++ b/common/cgroup
> @@ -0,0 +1,42 @@
> +##/bin/bash
> +# SPDX-License-Identifier: GPL-2.0

All the new files added by this patch have only license but not
copyright information.

> +#
> +# common functions for setting up cgroups for tasks
> +
> +_cgroup2_base_dir()
> +{
> +	grep cgroup2 /proc/mounts | awk '{ print $2 }'
> +}

I think this could be done by defining a CGROUP2_BASE_DIR variable in
common/config, and _require_cgroup2 could check if $CGROUP2_BASE_DIR is
empty.

> +
> +_cleanup_cgroup2()
> +{
> +	_dir=$(_cgroup2_base_dir)/xfstest

'xfstest' is hardcoded in common/cgroup and in the test, I think it
should be an argument provided by caller.

Also, please declare local variables as 'local', e.g.

	local dir=....

> +	for i in $(find ${_dir} -type d | tac)
> +	do
> +		rmdir $i
> +	done
> +}
> +
> +_require_cgroup2()
> +{
> +	grep -q 'cgroup2' /proc/mounts || _notrun "This test requires cgroup2"
> +}
> +
> +_require_cgroup2_controller_file()
> +{
> +	_require_cgroup2
> +
> +	_controller=$1
> +	_file=$2
> +	_dir=$(_cgroup2_base_dir)
> +
> +	grep -q ${_controller} ${_dir}/cgroup.controllers || \
> +		_notrun "No support for ${_controller} cgroup controller"
> +
> +	mkdir ${_dir}/xfstest

We could create a test subdir to check if $_file is there and remove the
dir after the check. The caller should not depend on this _require rule
to create the subdir used in test, i.e. 'xfstest' here.

> +	echo "+${_controller}" > ${_dir}/cgroup.subtree_control
> +	if [ ! -f ${_dir}/xfstest/${_file} ]; then
> +		_cleanup_cgroup2
> +		_notrun "Cgroup file ${_file} doesn't exist"
> +	fi
> +}
> diff --git a/common/config b/common/config
> index a127e98fba2d..d9284ccdf4c7 100644
> --- a/common/config
> +++ b/common/config
> @@ -192,6 +192,7 @@ export SETCAP_PROG="$(type -P setcap)"
>  export GETCAP_PROG="$(type -P getcap)"
>  export CHECKBASHISMS_PROG="$(type -P checkbashisms)"
>  export XFS_INFO_PROG="$(type -P xfs_info)"
> +export TIME_PROG="$(type -P time)"

Seems not used by the new test.

>  
>  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>  # newer systems have udevadm command but older systems like RHEL5 don't.
> diff --git a/common/perf b/common/perf
> index 8b4c9bef8a8d..56034b00a410 100644
> --- a/common/perf
> +++ b/common/perf
> @@ -38,3 +38,13 @@ _fio_results_compare()
>  		-c $PERF_CONFIGNAME -d $RESULT_BASE/fio-results.db \
>  		-n $_testname $_resultfile
>  }
> +
> +_fio_results_key()
> +{
> +	_job=$1
> +	_key=$2
> +	_resultfile=$3
> +
> +	$PYTHON2_PROG $here/src/perf/fio-key-value.py -k $_key -j $_job \
> +		$_resultfile
> +}
> diff --git a/src/perf/fio-key-value.py b/src/perf/fio-key-value.py
> new file mode 100644
> index 000000000000..208e9a453a19
> --- /dev/null
> +++ b/src/perf/fio-key-value.py
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import FioResultDecoder
> +import json
> +import argparse
> +import sys
> +import platform
> +
> +parser = argparse.ArgumentParser()
> +parser.add_argument('-j', '--jobname', type=str,
> +                    help="The jobname we want our key from.",
> +                    required=True)
> +parser.add_argument('-k', '--key', type=str,
> +                    help="The key we want the value of", required=True)
> +parser.add_argument('result', type=str,
> +                    help="The result file read")
> +args = parser.parse_args()
> +
> +json_data = open(args.result)
> +data = json.load(json_data, cls=FioResultDecoder.FioResultDecoder)
> +
> +for job in data['jobs']:
> +    if job['jobname'] == args.jobname:
> +        if args.key not in job:
> +            print('')
> +        else:
> +            print("{}".format(job[args.key]))
> +        break
> diff --git a/tests/generic/499 b/tests/generic/499
> new file mode 100644
> index 000000000000..c50fe3c8db36
> --- /dev/null
> +++ b/tests/generic/499
> @@ -0,0 +1,151 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 499
> +#
> +# Test that verifies the io.latency controller is doing something resembling
> +# what it's supposed to be doing.
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +tmp=/tmp/$$
> +fio_config_single=$tmp-single.fio
> +fio_config_double=$tmp-double.fio

$tmp.single.fio and $tmp.double.fio, otherwise these files won't be
cleaned up by "rm -f $tmp.*" in _cleanup.

> +fio_results=$tmp.json
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	_cleanup_cgroup2
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +_cgroup_run()

Local functions don't need the leading underscore.

> +{
> +	$FIO_PROG --output-format=json --output=$2 $3
> +	echo "$1 finished" >> $seqres.full
> +	cat /sys/fs/cgroup/xfstest/fast/io.stat >> $seqres.full
> +	cat /sys/fs/cgroup/xfstest/slow/io.stat >> $seqres.full
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/cgroup
> +. ./common/perf
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_cgroup2_controller_file io io.latency
> +_require_fio_results

Hmm, this requires PERF_CONFIGNAME to be set, but this is not a perf
test, test would run as long as we have python2 and fio support.

> +
> +rm -f $seqres.full
> +
> +# This is the basic test so we have a baseline for this box
> +cat >$fio_config_single << EOF
> +[fast]
> +directory=${SCRATCH_MNT}
> +direct=1
> +allrandrepeat=1
> +readwrite=randrw
> +size=4G
> +ioengine=libaio
> +iodepth=1024
> +fallocate=none
> +EOF
> +
> +# This runs one thread in a high priority group, another in a low priority
> +# group.
> +cat >$fio_config_double << EOF
> +[global]
> +directory=${SCRATCH_MNT}
> +direct=1
> +allrandrepeat=1
> +readwrite=randrw
> +size=4G
> +ioengine=libaio
> +iodepth=1024
> +fallocate=none
> +
> +[fast]
> +cgroup=xfstest/fast
> +
> +[slow]
> +cgroup=xfstest/slow
> +EOF
> +
> +_require_fio $fio_config_double
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +# We want to make sure the scratch device is large enough that we don't incur
> +# ENOSPC related slowdowns
> +_size=$((16 * 4 * 1024 * 1024))

Why 64G space? I guess > 8G should be enough?

> +_require_fs_space $SCRATCH_MNT $_size
> +
> +# We run the test once so we have an idea of how fast this workload will go with
> +# nobody else doing IO on the device.
> +$FIO_PROG --output-format=json --output=${fio_results} $fio_config_single
> +
> +_scratch_unmount

What's the purpose of this umount?

> +
> +# Grab the time the job took
> +_time_taken=$(_fio_results_key fast job_runtime $fio_results)
> +[ "${_time_taken}" = "" ] && _notrun "fio doesn't report job_runtime"

The $fio_config_single run is usually slow, if fio doesn't support
reporting job_runtime and test _notrun, it's just wasting test time.

I'd like to run a quick and simple fio job to see if it reports
job_runtime and _notrun quickly if it doesn't.

> +
> +echo "normal time taken ${_time_taken}" >> $seqres.full
> +
> +# File system internals are going to affect us a bit here, so we need to be a
> +# little fuzzy about our thresholds.  First we need to make sure our fast group
> +# isn't affected too much, and 15% gives us a little bit of wiggle room.  But if
> +# we just so happen to be pretty fast and 2 tasks running at the same time with
> +# equal weight happens to finish in this threshold we need to have a second
> +# higher threshold to make sure that the slow task was indeed throttled.  So set
> +# a 50% threshold that the slow group must exceed to make sure we did actually
> +# throttle the slow group
> +_fast_thresh=$((${_time_taken} + ${_time_taken} * 15 / 100))
> +_slow_thresh=$((${_time_taken} + ${_time_taken} * 50 / 100))
> +echo "fast threshold time is ${_fast_thresh}" >> $seqres.full
> +echo "slow threshold time is ${_slow_thresh}" >> $seqres.full
> +
> +# Create the cgroup files
> +_dir=$(_cgroup2_base_dir)/xfstest
> +echo "+io" > ${_dir}/cgroup.subtree_control
> +mkdir ${_dir}/fast
> +mkdir ${_dir}/slow
> +
> +# We set the target to 1usec because we could have a fast device that is capable
> +# of remarkable IO latencies that would skew the test.  It needs to be low
> +# enough that we do actually throttle the slow group, otherwise this test will
> +# make no sense.
> +_major=$((0x$(stat -c "%t" ${SCRATCH_DEV})))
> +_minor=$((0x$(stat -c "%T" ${SCRATCH_DEV})))

If $SCRATCH_DEV is a symlink, e.g. an LVM partition, both major and minor are "0".

> +echo "${_major}:${_minor} target=1" > ${_dir}/fast/io.latency

And this echo fails with "No such device".

> +[ $? -ne 0 ] && _fatal "Failed to set our latency target"

Use _fail instead of _fatal.

> +
> +# Start from a clean slate
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +$FIO_PROG --output-format=json --output=${fio_results} ${fio_config_double}
> +
> +_scratch_unmount
> +
> +# Pull the times for both jobs
> +_fast_time=$(_fio_results_key fast job_runtime $fio_results)
> +echo "Fast time ${_fast_time}" >> $seqres.full
> +_slow_time=$(_fio_results_key slow job_runtime $fio_results)
> +echo "Slow time ${_slow_time}" >> $seqres.full
> +
> +[ ${_fast_thresh} -lt ${_fast_time} ] && \
> +	_fatal "Too much of a performance drop for the protected workload"

Hmm, I see both xfs and ext4 fail this check. e.g. with ext4, .full
shows:

normal time taken 912
fast threshold time is 1048
slow threshold time is 1368
...
Fast time 1221
Slow time 1197

"Fast time" is not within threshold and "Fast" is slower than "Slow".
I'm testing with for-4.19/block branch from block tree[1], which should
have iolatency support. I'm testing in a Fedora 28 kvm guest with 2
vcpus and 8G memory.

Thanks,
Eryu

[1] git://git.kernel.dk/linux-block.git

> +[ ${_slow_thresh} -gt ${_slow_time} ] && \
> +	_fatal "The slow group does not appear to have been throttled"
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/499.out b/tests/generic/499.out
> new file mode 100644
> index 000000000000..c363e6848f82
> --- /dev/null
> +++ b/tests/generic/499.out
> @@ -0,0 +1,2 @@
> +QA output created by 499
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 83a6fdab7880..c685c3e65c18 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -501,3 +501,4 @@
>  496 auto quick swap
>  497 auto quick swap collapse
>  498 auto quick log
> +499 auto
> -- 
> 2.14.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
