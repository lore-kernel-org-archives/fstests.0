Date: Sun, 25 Mar 2018 00:16:02 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH V2] xfstests: add a simple cgroup2 writeback test
Message-ID: <20180324161602.GA30836@localhost.localdomain>
References: <f58e67c9a4ec8cb4e0c4e96865e3a44aebaf46a2.1521752027.git.shli@fb.com>
 <20180323135621.GC22357@bfoster.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323135621.GC22357@bfoster.bfoster>
To: Brian Foster <bfoster@redhat.com>
Cc: Shaohua Li <shli@kernel.org>, fstests@vger.kernel.org, darrick.wong@oracle.com, Kernel-team@fb.com, Shaohua Li <shli@fb.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 23, 2018 at 09:56:21AM -0400, Brian Foster wrote:
> On Thu, Mar 22, 2018 at 02:13:23PM -0700, Shaohua Li wrote:
> > From: Shaohua Li <shli@fb.com>
> > 
> > If filesystem supports cgroup2 writeback, the writeback IO should belong
> > to the cgroup which writes the file. To verify this, we set a write
> > bandwidth limit for a cgroup using block-throttling, the writeback IO
> > should be throttled according to the write bandwidth.
> > 
> > Thanks Dave Chinner's idea to use syncfs to wait for writeback
> > completion.
> > 
> > Cc: Eryu Guan <eguan@redhat.com>
> > Signed-off-by: Shaohua Li <shli@fb.com>
> > ---
> 
> Thanks for sending this. Firstly, this test isn't passing for me on
> ext4. It should, right? I'm running 4.16.0-0.rc6.git2.1.fc29.x86_64 with
> cgroup_no_v1=all, set CGROUP2_PATH=/sys/fs/cgroup/unified and my scratch
> device is an LVM volume.
> 
> # diff -u tests/generic/482.out
> # /root/xfstests-dev/results//generic/482.out.bad
> --- tests/generic/482.out       2018-03-23 08:54:51.321808466 -0400
> +++ /root/xfstests-dev/results//generic/482.out.bad     2018-03-23
> 09:25:55.359769041 -0400
> @@ -1,3 +1,4 @@
>  QA output created by 482
>  Disk speed is ok, start throttled writeback test
> -Throttled writeback runtime is in range
> +Throttled writeback runtime has value of 11
> +Throttled writeback runtime is NOT in range 90 .. 110
> 
> A few more comments...
> 
> >  common/cgroup2        | 15 +++++++++++
> >  common/rc             | 14 ++++++++--
> >  tests/generic/482     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/482.out |  3 +++
> >  tests/generic/group   |  1 +
> >  5 files changed, 104 insertions(+), 2 deletions(-)
> >  create mode 100644 common/cgroup2
> >  create mode 100755 tests/generic/482
> >  create mode 100644 tests/generic/482.out
> > 
> > diff --git a/common/cgroup2 b/common/cgroup2
> > new file mode 100644
> > index 00000000..f89825e2
> > --- /dev/null
> > +++ b/common/cgroup2
> > @@ -0,0 +1,15 @@
> > +# cgroup2 specific common functions
> > +
> > +export CGROUP2_PATH="${CGROUP2_PATH:-/sys/fs/cgroup}"
> > +
> > +_require_cgroup2()
> > +{
> > +	if [ ! -f "${CGROUP2_PATH}/cgroup.subtree_control" ]; then
> > +		_notrun "Test requires cgroup2 enabled"
> > +	fi
> > +	if [[ ! $(cat ${CGROUP2_PATH}/cgroup.controllers) =~ $1 ]]; then
> > +		_notrun "Cgroup2 doesn't support $1 controller $1"
> > +	fi
> > +}
> > +
> > +/bin/true
> > diff --git a/common/rc b/common/rc
> > index 93176749..e93674f9 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3613,14 +3613,24 @@ _short_dev()
> >  	echo `basename $(_real_dev $1)`
> >  }
> >  
> > -_sysfs_dev()
> > +#blk-throttling requires minor is 0
> 
> Why (more on this below)?
> 
> > +_get_dev_devt()
> >  {
> >  	local _dev=`_real_dev $1`
> >  	local _maj=$(stat -c%t $_dev | tr [:lower:] [:upper:])
> >  	local _min=$(stat -c%T $_dev | tr [:lower:] [:upper:])
> >  	_maj=$(echo "ibase=16; $_maj" | bc)
> >  	_min=$(echo "ibase=16; $_min" | bc)
> > -	echo /sys/dev/block/$_maj:$_min
> > +	if [ $2 ]; then
> > +		echo $_maj:0
> > +	else
> > +		echo $_maj:$_min
> > +	fi
> > +}
> > +
> > +_sysfs_dev()
> > +{
> > +	echo /sys/dev/block/$(_get_dev_devt $1 false)
> >  }
> >  
> >  # Get the minimum block size of a file.  Usually this is the
> > diff --git a/tests/generic/482 b/tests/generic/482
> > new file mode 100755
> > index 00000000..1f3cbc97
> > --- /dev/null
> > +++ b/tests/generic/482
> > @@ -0,0 +1,73 @@
> > +#! /bin/bash
> > +
> 
> The test should have a header with license and a brief description of
> what it's doing. The description helps give somebody an idea of what's
> wrong if the test fails and we have to refer to this years down the
> road. For example, this should explain that this is explicitly testing
> cgroup aware writeback support. That means that it requires specific
> filesystem support, block I/O throttling is not enough, etc.

Agreed.

> 
> That also begs the question of how to handle filesystems that do not
> implement cgroup aware writeback. XFS doesn't atm (though hopefully that
> changes with your kernel patch), and I'm not sure that should
> necessarily result in a test failure. I don't believe we have any

Agreed, it should not be a test failure if the filesystem doesn't
support cgroup aware writeback.

> specific way to check at runtime..? Perhaps we should just opt-in to
> specific fs' once they support it and do a _notrun for anything else..?

IMHO, if there's really nothing can be probed from userspace, the only
way I can think of is to move the test to shared dir, and list supported
fs explicitly in _supported_fs.

> 
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +. ./common/cgroup2
> > +
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +cgname=`mktemp -du ${CGROUP2_PATH}/test.XXXXXX`
> > +_cleanup()
> > +{
> > +	cd /
> > +	sync
> > +	rmdir $cgname
> > +}
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_scratch
> > +_require_cgroup2 io
> > +_require_xfs_io_command syncfs
> > +
> > +# Setup Filesystem
> > +_scratch_mkfs >/dev/null 2>&1 || _fail "mkfs failed"
> > +
> > +_scratch_mount || _fail "mount failed"
> > +
> > +test_speed()
> > +{
> > +	start=$(date +%s)
> > +	$XFS_IO_PROG -f -d -c "pwrite -b 1m 0 500m" "$SCRATCH_MNT/image" \
> > +		> /dev/null 2>&1
> > +	echo $(($(date +%s) - $start))
> > +}
> > +time=$(test_speed)
> > +
> > +if [ $time -gt 25 ]; then
> > +	_notrun "Disk is too slow, make sure disk can do 20MB/s at least"
> > +fi
> > +
> > +echo "Disk speed is ok, start throttled writeback test"
> > +
> 
> Could use some comments..
> 
> # create a cgroup with a 5MB/s I/O limit
> 
> > +echo +io > ${CGROUP2_PATH}/cgroup.subtree_control
> > +mkdir $cgname
> > +echo "$(_get_dev_devt $SCRATCH_DEV true) wbps=$((5*1024*1024))" > $cgname/io.max
> 
> FWIW, the test passes on ext4 for me if I hardcode this to use 253:3 for
> my scratch device (rather than 253:0). What device were you using that
> required a minor of 0?
> 
> > +
> > +run_writeback()
> > +{
> > +    start=$(date +%s)
> > +    $XFS_IO_PROG -f -c "pwrite 0 500m" -c "syncfs" "$SCRATCH_MNT/image2" \
> > +        > /dev/null 2>&1
> 
> Comment with the reason this needs to be syncfs?
> 
> > +    echo $(($(date +%s) - $start))
> > +}
> 
> It's cleaner and more consistent to define helper functions all in one
> place above. That makes it easier to follow the actual test logic. I'd
> also suggest to rename this to test_writeback().
> 
> > +time=$(
> > +echo $BASHPID > $cgname/cgroup.procs;
> 
> Is it necessary to include the above line within the $()? If so, please
> document it with a comment. Otherwise it might be cleaner to run it
> separately.
> 
> Also could use another comment before this hunk:
> 
> # perform buffered writes charged to the cgroup and verify writeback
> # honors the I/O throttle
> 
> > +run_writeback
> > +)
> > +_within_tolerance "Throttled writeback runtime" $time 100 10% -v
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/482.out b/tests/generic/482.out
> > new file mode 100644
> > index 00000000..4d1b40a8
> > --- /dev/null
> > +++ b/tests/generic/482.out
> > @@ -0,0 +1,3 @@
> > +QA output created by 482
> > +Disk speed is ok, start throttled writeback test
> > +Throttled writeback runtime is in range
> > diff --git a/tests/generic/group b/tests/generic/group
> > index e8676062..f707838c 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -484,3 +484,4 @@
> >  479 auto quick metadata
> >  480 auto quick metadata
> >  481 auto quick log metadata
> > +482 auto cgroup writeback
> 
> cgroup makes sense, but I'm not sure about writeback. It seems like
> duplication at least since both groups are new. Use the rw group
> perhaps? Eh, I'll defer to Eryu's opinion on what group(s) are most
> appropriate.

I slightly prefer dropping 'writeback' group, 'cgroup' alone should be
fine.

Thanks
Eryu
