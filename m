Received: from mx1.redhat.com ([209.132.183.28]:41754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753202AbdCJEgT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 9 Mar 2017 23:36:19 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C3923B708
        for <fstests@vger.kernel.org>; Fri, 10 Mar 2017 04:36:14 +0000 (UTC)
Date: Fri, 10 Mar 2017 12:36:12 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfstests: test orphan inode recovery on RO mount
Message-ID: <20170310043612.GL14226@eguan.usersys.redhat.com>
References: <517ceead-de32-1fdb-f002-ce9d7acdf330@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <517ceead-de32-1fdb-f002-ce9d7acdf330@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 09, 2017 at 03:31:43PM -0600, Eric Sandeen wrote:
> There's a bug in xfs where the orphan inode list
> is not processed on a readonly mount, and is still not
> processed even if it gets mounted rw.  This test exercises
> that, and makes sure that the unlinked list is empty after
> a transition to rw and an unmount.
> 
> While we're at it, sanity check the same thing for pure ro
> and rw unmounts.
> 
> Now that shutdown is generic, we can test other filesystems
> as well, so this is in the generic group.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/tests/generic/416 b/tests/generic/416
> new file mode 100755
> index 0000000..b4a3b6e
> --- /dev/null
> +++ b/tests/generic/416
> @@ -0,0 +1,118 @@
> +#! /bin/bash
> +# FS QA Test 416
> +#
> +# Test orphan inode / unlinked list processing on RO mount & RW transition
> +#
> +# A filesystem that crashes with open but unlinked inodes should
> +# be consistent after a ro, ro->rw, or rw mount cycle.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
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
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_fs generic

duplicated _supported_fs :)

> +_supported_os Linux
> +_require_scratch
> +_require_scratch_shutdown

Need a "_require_metadata_journaling $SCRATCH_DEV", otherwise ext2 will
fail fsck when driven by ext4 driver.

> +
> +function create_dirty_orphans() {
> +
> +	_scratch_mount
> +
> +	num_files=200
> +	num_eas=1
> +	ea_val_size=1024
> +
> +	# sleep for ages and we will kill this pid when we are ready
> +	delay=100
> +
> +	echo "open and unlink $num_files files with EAs"
> +	src/multi_open_unlink -f $SCRATCH_MNT/test_file \
> +		-n $num_files -s $delay -e $num_eas -v $ea_val_size &
> +	pid=$!
> +
> +	# time to create and unlink all the files
> +	sleep 10

Do we really need 10s? That seems a bit long to me, and I tested with
sleep 3, it also reproduced on XFS (4.11-rc1).

Otherwise look good to me. I can fix them all at commit time if you're
OK with "sleep 3".

Thanks,
Eryu
