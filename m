Received: from mx1.redhat.com ([209.132.183.28]:40114 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbbHCD2X (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 2 Aug 2015 23:28:23 -0400
Date: Mon, 3 Aug 2015 11:28:20 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 4/5] xfstest: introduce subtestset for ubifs
Message-ID: <20150803032820.GQ17933@dhcp-13-216.nay.redhat.com>
References: <1438236417-24612-1-git-send-email-yangds.fnst@cn.fujitsu.com>
 <1438236417-24612-5-git-send-email-yangds.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438236417-24612-5-git-send-email-yangds.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, dedekind1@gmail.com, richard.weinberger@gmail.com, linux-mtd@lists.infradead.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 30, 2015 at 02:06:56PM +0800, Dongsheng Yang wrote:
> This commit creat a subdir in tests named as ubifs for
> ubifs specified tests. And introduce the ubifs/001 to
> it.

I know nothing about ubifs, so I can only comment from the fstests's
point of view, better to have someone from ubifs community to review
too. The same is true to patch 1/5 and 5/5 (they both look fine to me).

> 
> Signed-off-by: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
> ---
>  tests/ubifs/001     | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ubifs/001.out |  1 +
>  tests/ubifs/group   |  6 +++++
>  3 files changed, 78 insertions(+)
>  create mode 100755 tests/ubifs/001
>  create mode 100644 tests/ubifs/001.out
>  create mode 100644 tests/ubifs/group
> 
> diff --git a/tests/ubifs/001 b/tests/ubifs/001
> new file mode 100755
> index 0000000..9107915
> --- /dev/null
> +++ b/tests/ubifs/001
> @@ -0,0 +1,71 @@
> +#! /bin/bash
> +# FS QA Test 001
> +#
> +# This is a test for mkfs.ubifs, mkfs.ubifs accept a -r option
> +# to build a file system from a directory. This case is testing
> +# this option and check the result of it.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2015 Dongsheng Yang <yangds.fnst@cn.fujitsu.com>.  All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=`mktemp -d`

Please follow the template created by 'new', tmp=/tmp/$$, because $tmp
is widely used by internal functions from common/rc and check.

> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -rf $tmp

rm -f $tmp.*

This will clean all tmp files used by this test, including the ones from
common/rc and check.

> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs ubifs
> +_supported_os Linux
> +_require_test
> +_require_scratch
> +_require_fssum
> +_need_to_be_root
> +
> +rm -f $seqres.full
> +
> +rootdir=$tmp/root

Usually we create tmp mount point in $TEST_DIR, e.g.

rootdir=$TEST_DIR/$seq.mnt

not sure if this is doable for ubifs

> +mkdir $rootdir

echo "Silence is golden"

to indicate this test expects no output

> +
> +for i in $(seq 1 10); do
> +	dd if=/dev/urandom of=$rootdir/$i bs=1M count=1 >> $seqres.full 2>&1 || _fail "dd failed"
> +done
> +
> +run_check $FSSUM_PROG -A -f -w $tmp/fssum $rootdir
> +
> +_scratch_mkfs "-r $rootdir" >/dev/null 2>&1

dump the stdout and stderr to $seqres.full too?

Thanks,
Eryu
> +_scratch_mount
> +
> +run_check $FSSUM_PROG -r $tmp/fssum $SCRATCH_MNT 2>> $seqres.full
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ubifs/001.out b/tests/ubifs/001.out
> new file mode 100644
> index 0000000..097d046
> --- /dev/null
> +++ b/tests/ubifs/001.out
> @@ -0,0 +1 @@
> +QA output created by 001
> diff --git a/tests/ubifs/group b/tests/ubifs/group
> new file mode 100644
> index 0000000..45516bc
> --- /dev/null
> +++ b/tests/ubifs/group
> @@ -0,0 +1,6 @@
> +# QA groups control
> +#
> +# define groups and default group owners
> +# do not start group name with a digit
> +#
> +001 auto quick mkfs
> -- 
> 1.8.4.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
