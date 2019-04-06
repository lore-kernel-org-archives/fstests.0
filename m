Received: from mail-pf1-f193.google.com ([209.85.210.193]:37310 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfDFMpw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 6 Apr 2019 08:45:52 -0400
Date: Sat, 6 Apr 2019 20:45:44 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2 1/2] ceph: test basic ceph.quota.max_files quota
Message-ID: <20190406124544.GJ2824@desktop>
References: <20190405145305.9574-1-lhenriques@suse.com>
 <20190405145305.9574-2-lhenriques@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405145305.9574-2-lhenriques@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: fstests@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>, Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 05, 2019 at 03:53:04PM +0100, Luis Henriques wrote:
> Simple set of checks for CephFS max_files directory quota implementation.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.com>

Just some quick/random comments inline, because I don't have a ceph env
to actually test the patches..

> ---
>  tests/ceph/001      | 86 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ceph/001.out  |  9 +++++
>  tests/ceph/Makefile | 20 +++++++++++
>  tests/ceph/group    |  1 +
>  4 files changed, 116 insertions(+)
>  create mode 100755 tests/ceph/001
>  create mode 100644 tests/ceph/001.out
>  create mode 100644 tests/ceph/Makefile
>  create mode 100644 tests/ceph/group
> 
> diff --git a/tests/ceph/001 b/tests/ceph/001
> new file mode 100755
> index 000000000000..770e952cd8dc
> --- /dev/null
> +++ b/tests/ceph/001
> @@ -0,0 +1,86 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 SUSE LLC. All Rights Reserved.
> +#
> +# FS QA Test No. 001
> +#
> +# Test basic ceph.quota.max_files quota features.
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +workdir=$TEST_DIR/$seq
> +
> +tmp=/tmp/$$
> +status=1    # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -rf $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/attr
> +
> +# real QA test starts here
> +_supported_os Linux
> +_supported_fs ceph
> +
> +_require_attrs
> +
> +set_quota()
> +{
> +	val=$1
> +	dir=$2

Declare function local variables as 'local'.

> +	$SETFATTR_PROG -n ceph.quota.max_files -v $val $dir >/dev/null 2>&1

I think it's better to dump the outputs from $SETFATTR_PROG to
$seqres.full, so we have debug logs when something went wrong. e.g.

	$SETFATTR_PROG -n ceph.quota.max_files -v $val $dir >>$seqres.full 2>&1

Also, remove $seqres.full file before test.

> +}
> +get_quota()
> +{
> +	dir=$1
> +	$GETFATTR_PROG -n ceph.quota.max_files $dir 2> /dev/null

We have a wrapper function around $GETFATTR_PROG called _getfattr(),
which is used to deal with different output formats from different
versions of getfattr tool, use the helper if possible.

And you need to filter $TEST_DIR here as well. And if you don't want the
"Removing leading '/' from absolute path names" messages, you could use
the "--absolute-names" option of getfattr, e.g.

	_getfattr -n ceph.quota.max_files --absolute-names $dir | _filter_test_dir

Thanks,
Eryu

> +}
> +
> +rm -rf $workdir
> +mkdir $workdir
> +
> +# test setting quota
> +set_quota 10 $workdir
> +get_quota $workdir
> +
> +# set quota to largest acceptable value (0x7FFFFFFFFFFFFFFF)
> +set_quota 9223372036854775807 $workdir
> +get_quota $workdir
> +
> +# test resetting quota
> +set_quota 0 $workdir
> +get_quota $workdir
> +
> +# set quota to invalid values (0x8000000000000000 and -1)
> +set_quota 9223372036854775808 $workdir
> +get_quota $workdir
> +
> +set_quota -1 $workdir
> +get_quota $workdir
> +
> +set_quota 5 $workdir
> +mkdir $workdir/0
> +touch $workdir/0/1
> +touch $workdir/0/2
> +touch $workdir/3
> +
> +touch $workdir/4 2>&1 | _filter_test_dir # should fail
> +mkdir $workdir/5 2>&1 | _filter_test_dir # should fail
> +
> +set_quota 0 $workdir
> +touch $workdir/4 # shouldn't fail
> +mkdir $workdir/5 # shouldn't fail
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ceph/001.out b/tests/ceph/001.out
> new file mode 100644
> index 000000000000..6ddb007dce22
> --- /dev/null
> +++ b/tests/ceph/001.out
> @@ -0,0 +1,9 @@
> +QA output created by 001
> +# file: mnt/test/001
> +ceph.quota.max_files="10"
> +
> +# file: mnt/test/001
> +ceph.quota.max_files="9223372036854775807"
> +
> +touch: cannot touch 'TEST_DIR/001/4': Disk quota exceeded
> +mkdir: cannot create directory 'TEST_DIR/001/5': Disk quota exceeded
> diff --git a/tests/ceph/Makefile b/tests/ceph/Makefile
> new file mode 100644
> index 000000000000..f93862af4f31
> --- /dev/null
> +++ b/tests/ceph/Makefile
> @@ -0,0 +1,20 @@
> +#
> +# Copyright (c) 2019 SUSE LLC. All Rights Reserved.
> +#
> +
> +TOPDIR = ../..
> +include $(TOPDIR)/include/builddefs
> +
> +CEPHFS_DIR = cephfs
> +TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(CEPHFS_DIR)
> +
> +include $(BUILDRULES)
> +
> +install:
> +	$(INSTALL) -m 755 -d $(TARGET_DIR)
> +	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
> +	$(INSTALL) -m 644 group $(TARGET_DIR)
> +	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
> +
> +# Nothing.
> +install-dev install-lib:
> diff --git a/tests/ceph/group b/tests/ceph/group
> new file mode 100644
> index 000000000000..e389bc6ec7ee
> --- /dev/null
> +++ b/tests/ceph/group
> @@ -0,0 +1 @@
> +001 auto quick quota
