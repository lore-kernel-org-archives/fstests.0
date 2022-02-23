Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAABC433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Feb 2022 00:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiBWAab (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Feb 2022 19:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiBWAaa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Feb 2022 19:30:30 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A38E5575A
        for <fstests@vger.kernel.org>; Tue, 22 Feb 2022 16:30:02 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 0E8C752F9B5;
        Wed, 23 Feb 2022 11:30:00 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nMfXc-00FGgQ-2D; Wed, 23 Feb 2022 11:30:00 +1100
Date:   Wed, 23 Feb 2022 11:30:00 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/1] README: restructure & format building manual
Message-ID: <20220223003000.GG3061737@dread.disaster.area>
References: <20220221202558.603994-1-aalbersh@redhat.com>
 <20220221202558.603994-2-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221202558.603994-2-aalbersh@redhat.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62158009
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8
        a=vTr9H3xdAAAA:8 a=hGzw-44bAAAA:8 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8
        a=XI6ZBbncAAAA:8 a=7-415B0cAAAA:8 a=dVbSc9bDpDzDWR2kXlMA:9
        a=CjuIK1q_8ugA:10 a=hY9Ej0bsfq0A:10 a=EIbBafSlPRUA:10 a=xaeOsHv00zUA:10
        a=7PCjnrUJ-F5voXmZD6jJ:22 a=HvKuF1_PTVFglORKqfwH:22
        a=_FVE-zBwftR9WsbkzFJk:22 a=AjGcO6oz07-iQ99wixmX:22
        a=bJRTwYA_2JcLx6dil-nV:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Andrey,

This is a good start, but I think it can be improved further.

On Mon, Feb 21, 2022 at 09:25:58PM +0100, Andrey Albershteyn wrote:
> The commands for package managers for both Ubuntu and RHEL weren't
> up-to-date. A few packages doesn't exist anymore or missing from the
> latest repositories (e.g. liburing-devel, btrfs-progs-devel). Ubuntu's
> list missed a few packages listed in RHEL's list. There are a few repeating
> steps. The indent of avaliable environment variables is not clear.

A couple of housekeeping notes first.

Commit messages should be line wrapped at 68-72 columns so that they
can easily be cut/paste/quoted into email which typically wraps at
68-72 columns.

If you use vim, you can set up a column marker and text wrapping to
do this automatically with .vimrc rules like this:

" default text width is 80 columns
set	textwidth=80

" set the textwidth to 68 characters for guilt commit messages
 au BufNewFile,BufRead guilt.msg.*,.gitsendemail.*,git.*,*/.git/*  set tw=68

And you set the textwidth highlight with:

" highlight textwidth
set cc=+1

You'll want to highlight whitespace damage, too.

" highlight whitespace damage
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/

Also, if you use mutt for email, then add this to your .muttrc:

set editor="vim -c 'set ft=mail tw=68'"

And all it will set up the defaults for 68 column mail editting by
default.

IOWs, the textwidth the editor defaults to will now change
automatically depending on whether you are writing email, editting
code or git commit messages...

> This patch:
> - Update package dependencies for Ubuntu/Debian/RHEL/CentOS/Fedora
> - Unify list of packages between Ubuntu/Debian and RHEL/CentOS/Fedora
> - Add list of tool packages for other FS
> - Add links to tools not in the standard repository for RHEL/CentOS
> - Drop xfsprogs-qa-devel reference for old systems
> - Replace note about EPEL with installation step with link to Fedora
>   manual
> - Add configuration examples in 'Setup Environment'
> - Small clarification details, such as size of the partition and
>   KCONFIG_PATH description
> - Removal of repeating steps (install administrative tools, partitions
>   content)
> - Restructuring and formatting of "BUILDING THE FSQA SUITE" section
> - Drop IRIXDEV references in variable set up

Normally we ask for one change per patch so that we can see the
individual changes in isolation. For a documentation update like
this it isn't really necessary, but it can still help.

> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  README | 342 ++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 205 insertions(+), 137 deletions(-)
> 
> diff --git a/README b/README
> index e9284b22..99d102df 100644
> --- a/README
> +++ b/README
> @@ -2,148 +2,216 @@ _______________________
>  BUILDING THE FSQA SUITE
>  _______________________
>  
> -- cd into the xfstests directory
> -- install prerequisite packages
> -  For example, for Ubuntu:
> -	sudo apt-get install xfslibs-dev uuid-dev libtool-bin \
> -	e2fsprogs automake gcc libuuid1 quota attr make \
> -	libacl1-dev libaio-dev xfsprogs libgdbm-dev gawk fio dbench \
> -	uuid-runtime python sqlite3 liburing-dev libcap-dev
> -  For Fedora, RHEL, or CentOS:
> -	yum install acl attr automake bc dbench dump e2fsprogs fio \
> -	gawk gcc indent libtool lvm2 make psmisc quota sed \
> -	xfsdump xfsprogs \
> -	libacl-devel libaio-devel libuuid-devel \
> -	xfsprogs-devel btrfs-progs-devel python sqlite liburing-devel \
> -	libcap-devel
> -	(Older distributions may require xfsprogs-qa-devel as well.)
> -	(Note that for RHEL and CentOS, you may need the EPEL repo.)
> -- run make
> -- run make install
> -- create fsgqa test user ("sudo useradd -m fsgqa")
> -- create fsgqa group ("sudo groupadd fsgqa")
> -- create 123456-fsgqa test user ("sudo useradd 123456-fsgqa")
> -  this 2nd user creation step can be safely skipped if your system
> -  doesn't support names starting with digits, only a handful of tests
> -  require it.
> -- create fsgqa2 test user ("sudo useradd fsgqa2")
> +Ubuntu, or Debian
> +-----------------

No trailing comma before and/or.

> +
> +1. Make sure that package list is up-to-date and install all necessary packages:

Line over 80 columns in width.

> +
> +   $ sudo apt-get update
> +   $ sudo apt-get install \
> +           acl attr automake bc dbench fio gawk gcc git indent libtool lvm2 \
> +           make psmisc python3 quota sed \
> +           dump e2fsprogs \
> +           xfsdump xfsprogs \
> +           libacl1-dev libaio-dev libcap-dev libgdbm-dev libtool-bin \
> +           liburing-dev libuuid1 uuid-dev uuid-runtime \
> +           linux-headers-$(uname -r) sqlite3 xfslibs-dev

I'd pack this list rather than having it broken up into random
length lines. Also, rather than include a couple of filesystem
specific packages here, I'd list all the packages that are needed
regardless of the fs being tested. This would mean e2fsprogs and
xfsprogs will be in the above list, but xfsdump and xfslibs-dev
shouldn't be. They would get listed in #2:

> +2. (Optional) For udf, exfat, f2fs, ocfs2 install:

"2. Install pacakages for the filesystem(s) being tested:"

> +
> +   $ sudo apt-get install \
> +       udftools \
> +       exfatprogs \
> +       f2fs-tools \
> +       ocfs2-tools
> +
> +   For OverlayFS install:
> +    - see https://github.com/hisilicon/overlayfs-progs
> +
> +Fedora, RHEL, or CentOS
> +-----------------------

Fedora, RHEL or CentOS

> +
> +0. For RHEL and CentOS, enable EPEL repository:
> +    - see https://docs.fedoraproject.org/en-US/epel/#How_can_I_use_these_extra_packages.3F
> +
> +1. Install all packages which are available from standard repository:
> +
> +   $ sudo yum install \
> +        acl attr automake bc dbench fio indent gawk gcc git libtool lvm2 \
> +        make psmisc python3 quota sed \
> +        dump e2fsprogs \
> +        xfsdump xfsprogs \
> +        libcap-devel gdbm-devel kernel-devel libacl-devel libaio-devel \
> +        libuuid-devel sqlite udftools xfsprogs-devel
> +
> +   Or, EPEL packages could be compiled from sources, see:
> +    - https://dbench.samba.org/web/download.html
> +    - https://www.gnu.org/software/indent/
> +
> +3. For Fedora, install also:
> +
> +    $ sudo yum install liburing-devel
> +
> +   For RHEL and CentOS:
> +    - see https://github.com/axboe/liburing.
> +
> +4. (Optional) Install tools for particular filesystems:
> +
> +   For BTRFS on Fedora:
> +    $ sudo yum install btrfs-progs
> +
> +   For exfat on Fedora, RHEL, or CentOS:
> +    $ sudo yum install exfatprogs
> +
> +   For f2fs on Fedora install:
> +    $ sudo yum install f2fs-tools
> +   For f2fs on RHEL, or CentOS install:
> +    - see https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/about/
> +
> +   For ocfs2 on Fedora install:
> +    $ sudo yum install ocfs2-tools
> +   For ocfs2 on RHEL or CentOS install:
> +    - see https://github.com/markfasheh/ocfs2-tools
> +
> +   For OverlayFS install:
> +    - see https://github.com/hisilicon/overlayfs-progs

THis seems like it might be better to separate Fedora from
RHEL/CentOS - only step 1 has any commonality between these distros.

> +Build and install test, libs and utils
> +--------------------------------------
> +
> +$ git clone git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> +$ cd xfstests-dev
> +$ make
> +$ sudo make install
> +
> +Setup Environment
> +-----------------
> +
> +1. Compile XFS/EXT4/BTRFS/etc. into your kernel or load as module. For example,
> +   for XFS, enable XFS_FS in your kernel configuration, or compile it as a
> +   module and load it with 'sudo modprobe xfs'. Most of the distributions will
> +   have these filesystems already in the kernel/as module.
> +
> +2. Create one or two partitions (at least 10G each) to use for testing
> +    - TEST partition - format as XFS, mount & optionally populate with
> +      NON-IMPORTANT stuff

Separate test/scratch/scratch-pool devices into three separate steps.

2. Create TEST device.
	- format as the filesystem type you wish to test.
	- optionally populate with destroyable data.
	- should be at least 10GB in size.
	- device contents may be destroyed.

> +    - SCRATCH partition (optional) - leave empty and expect this partition to be
> +      clobbered by some tests. If this is not provided, many tests will not be
> +      run. Note that SCRATCH and TEST must be two DIFFERENT partitions.

3. (optional) Create SCRATCH device.
	- should be at least 10GB in size.
	- device contents will be destroyed.
	- many tests depend on the SCRATCH device existing.
	- Must be different to TEST device.

> +    - BTRFS only: some btrfs test cases will need 3 or more independent SCRATCH
> +      disks which should be set using SCRATCH_DEV_POOL (e.g.
> +      SCRATCH_DEV_POOL="/dev/sda /dev/sdb /dev/sdc") with which SCRATCH_DEV
> +      should be unused by the tester, and for the legacy support SCRATCH_DEV
> +      will be set to the first disk of the SCRATCH_DEV_POOL by xfstests script.
> +      Note that these partitions should not have anything usefull, as it will be
> +      clobbered by tests.

4. (optional) Create SCRATCH device pool
	- needed for BTRFS testing
	- specifies 3 or more independent SCRATCH devices via the
	  SCRATCH_DEV_POOL variable.
	- device contents will be destroyed.
	- e.g SCRATCH_DEV_POOL="/dev/sda /dev/sdb /dev/sdc"
	- SCRATCH device should be left unset, it will be overridden
	  by the SCRATCH_DEV_POOL implementation.

> +
> +   For example, to run the tests with loopback partitions:
> +   # dd if=/dev/zero of=./test.img bs=1M count=10000
> +   # dd if=/dev/zero of=./scratch.img bs=1M count=10000

Faster to just preallocate the image files:

xfs_io -f -c "fallocate 0 10g" test.img
xfs_io -f -c "fallocate 0 10g" scratch.img

> +   # mkfs.xfs test.img
> +   # mkfs.xfs scratch.img

No need to mkfs the scratch device - tests always do this before
they use it.

> +   # losetup /dev/loop0 ./test.img
> +   # losetup /dev/loop1 ./scratch.img
> +   # mkdir -p /mnt/test && mount /dev/loop0 /mnt/test
> +   # mkdir -p /mnt/scratch && mount /dev/loop1 /mnt/scratch
> +
> +3. Copy local.config.example to local.config and edit as needed. The TEST_DEV
> +   and TEST_DIR are required.
> +
> +   For example, the config for the setup above is:
> +   $ cat local.config
> +   export TEST_DEV=/dev/loop0
> +   export TEST_DIR=/mnt/test
> +   export SCRATCH_DEV=/dev/loop1
> +   export SCRATCH_MNT=/mnt/scratch
> +
> +From this point you can run some basic tests, see 'USING THE FSQA SUITE' below.
> +
> +Additional Setup
> +----------------
> +
> +Some tests require additional configuration of the system and in your
> +local.config. Add these variables to a local.config and keep that file in your
> +workarea. Or add a case to the switch in common/config assigning these variables
> +based on the hostname of your test machine. Or use 'setenv' to set them.
> +
> + - Create fsgqa test users and groups:
> +
> +   $ sudo useradd -m fsgqa
> +   $ sudo useradd 123456-fsgqa
> +   $ sudo useradd fsgqa2
> +   $ sudo groupadd fsgqa
> +
> +   The "123456-fsgqa" user creation step can be safely skipped if your system
> +   doesn't support names starting with digits, only a handful of tests require
> +   it.
> + - If you wish to run the udf components of the suite install mkudffs. Also
> +   download and build the Philips UDF Verification Software from
> +   https://www.lscdweb.com/registered/udf_verifier.html, then copy the udf_test
> +   binary to xfstests/src/.

Hmmm - shouldn't that be in the initial setup information?

> + - If you wish to disable UDF verification test set the environment variable
> +   DISABLE_UDF_TEST to 1.
> + - Set TAPE_DEV to "tape device for testing xfsdump". Note that if testing
> +   xfsdump, make sure the tape devices have a tape which can be overwritten.
> + - Set RMT_TAPE_DEV to "remote tape device for testing xfsdump"
> + - Set SCRATCH_LOGDEV to "device for scratch-fs external log"
> + - Set SCRATCH_RTDEV to "device for scratch-fs realtime data"
> + - Set TEST_LOGDEV to "device for test-fs external log"
> + - Set TEST_RTDEV to "device for test-fs realtime data"
> + - If TEST_LOGDEV and/or TEST_RTDEV, these will always be used.
> + - If SCRATCH_LOGDEV and/or SCRATCH_RTDEV, the USE_EXTERNAL environment
> +   variable set to "yes" will enable their use.
> + - Set DIFF_LENGTH to "number of diff lines to print from a failed test",
> +   by default 10, set to 0 to print the full diff
> + - Set FSTYP to "the filesystem you want to test", the filesystem type is
> +   devised from the TEST_DEV device, but you may want to override it; if
> +   unset, the default is 'xfs'
> + - Set FSSTRESS_AVOID and/or FSX_AVOID, which contain options added to
> +   the end of fsstresss and fsx invocations, respectively, in case you wish
> +   to exclude certain operational modes from these tests.
> + - Set TEST_XFS_REPAIR_REBUILD=1 to have _check_xfs_filesystem run
> +   xfs_repair -n to check the filesystem; xfs_repair to rebuild metadata
> +   indexes; and xfs_repair -n (a third time) to check the results of the
> +   rebuilding.
> + - xfs_scrub, if present, will always check the test and scratch
> +   filesystems if they are still online at the end of the test. It is no
> +   longer necessary to set TEST_XFS_SCRUB.
> + - Set LOGWRITES_DEV to a block device to use for power fail testing.
> + - Set PERF_CONFIGNAME to a arbitrary string to be used for identifying
> +   the test setup for running perf tests. This should be different for
> +   each type of performance test you wish to run so that relevant results
> +   are compared. For example 'spinningrust' for configurations that use
> +   spinning disks and 'nvme' for tests using nvme drives.
> + - Set USE_KMEMLEAK=yes to scan for memory leaks in the kernel after every
> +   test, if the kernel supports kmemleak.
> + - Set KEEP_DMESG=yes to keep dmesg log after test
> + - Set TEST_FS_MODULE_RELOAD=1 to unload the module and reload it between
> +   test invocations. This assumes that the name of the module is the same
> +   as FSTYP.
> + - Set DUMP_CORRUPT_FS=1 to record metadata dumps of XFS or ext*
> +   filesystems if a filesystem check fails.
> + - Set DUMP_COMPRESSOR to a compression program to compress metadumps of
> +   filesystems. This program must accept '-f' and the name of a file to
> +   compress; and it must accept '-d -f -k' and the name of a file to
> +   decompress. In other words, it must emulate gzip.
> + - Set MIN_FSSIZE to specify the minimal size (bytes) of a filesystem we
> +   can create. Setting this parameter will skip the tests creating a
> +   filesystem less than MIN_FSSIZE.
> + - Set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS to specify the amount of time we
> +   should try a patient module remove. The default is 50 seconds. Set this
> +   to "forever" and we'll wait forever until the module is gone.
> + - Set FORCE_XFS_CHECK_PROG=yes to have _check_xfs_filesystem run xfs_check
> +   to check the filesystem. As of August 2021, xfs_repair finds all
> +   filesystem corruptions found by xfs_check, and more, which means that
> +   xfs_check is no longer run by default.
> + - Set KCONFIG_PATH to specify your preferred location of kernel config
> +   file. The config is used by tests to check if kernel feature is enabled.

I find this harder to read that the previous list - it much denser
text with less whitespace, so individual rules/notes are harder to
separate. I would separate this out into multiple groups that are
blank line separated. e.g:

- Extra TEST device specifications:
	- Set TEST_LOGDEV to "device for test-fs external log"
	- Set TEST_RTDEV to "device for test-fs realtime data"
	- If TEST_LOGDEV and/or TEST_RTDEV, these will always be used.

- Extra SCRATCH device specifications
	- Set SCRATCH_LOGDEV to "device for scratch-fs external log"
	- Set SCRATCH_RTDEV to "device for scratch-fs realtime data"
	- If SCRATCH_LOGDEV and/or SCRATCH_RTDEV, the USE_EXTERNAL
	  environment variable set to "yes" will enable their use.

- Tape device specification for xfsdump testing:
	- Set TAPE_DEV to "tape device for testing xfsdump". Note
	  that if testing xfsdump, make sure the tape devices have a
	  tape which can be overwritten.
	- Set RMT_TAPE_DEV to "remote tape device for testing
	  xfsdump"

(group xfs repair/check configs together)
(group dump configs together)
(etc)

This makes it easier to read and to find different options that
someone might want to use.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
