Received: from mx1.redhat.com ([209.132.183.28]:44210 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752379AbcD0PEi (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 27 Apr 2016 11:04:38 -0400
Date: Wed, 27 Apr 2016 11:04:35 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 2/5] generic/343: Test races between mmap and normal
 writes
Message-ID: <20160427150434.GB44975@bfoster.bfoster>
References: <1461007955-7921-1-git-send-email-jack@suse.cz>
 <1461007955-7921-3-git-send-email-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1461007955-7921-3-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 18, 2016 at 09:32:32PM +0200, Jan Kara wrote:
> Add test which spawns two threads one writing to file via normal write
> and one via mmap and checks the result. This is mainly interesting to
> uncover races between DAX fault handling and write path.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  src/holetest.c        | 68 ++++++++++++++++++++++++++++++++++++---------------
>  tests/generic/341     |  4 ---
>  tests/generic/343     | 58 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/343.out | 55 +++++++++++++++++++++++++++++++++++++++++
>  tests/generic/group   |  1 +
>  5 files changed, 162 insertions(+), 24 deletions(-)
>  create mode 100644 tests/generic/343
>  create mode 100644 tests/generic/343.out
> 
...
> diff --git a/tests/generic/341 b/tests/generic/341
> index 1fde346adc85..05bd86707592 100644
> --- a/tests/generic/341
> +++ b/tests/generic/341
> @@ -51,10 +51,6 @@ _supported_os Linux
>  _require_scratch
>  _require_dm_target flakey
>  _require_metadata_journaling $SCRATCH_DEV
> -
> -rm -f $seqres.full
> -
> -_scratch_mkfs >>$seqres.full 2>&1
>  _init_flakey
>  _mount_flakey
>  

What's this hunk about? FWIW, the rest of the series looks fine to me.

Brian

> diff --git a/tests/generic/343 b/tests/generic/343
> new file mode 100644
> index 000000000000..8e624507fea9
> --- /dev/null
> +++ b/tests/generic/343
> @@ -0,0 +1,58 @@
> +#! /bin/bash
> +# FSQA Test No. 343
> +#
> +# Test races between mmap and normal writes from racing threads
> +#
> +#-----------------------------------------------------------------------
> +#
> +# Copyright (C) 2016 SUSE Linux Products GmbH. All Rights Reserved.
> +# Author: Jan Kara <jack@suse.cz>
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
> +# get standard environment and checks
> +. ./common/rc
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_test_program "holetest"
> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +src/holetest -f -w $SCRATCH_MNT/testfile 1
> +src/holetest -f -w $SCRATCH_MNT/testfile 16
> +src/holetest -f -w $SCRATCH_MNT/testfile 256
> +
> +status=0
> +exit
> diff --git a/tests/generic/343.out b/tests/generic/343.out
> new file mode 100644
> index 000000000000..495c8a84eaa2
> --- /dev/null
> +++ b/tests/generic/343.out
> @@ -0,0 +1,55 @@
> +QA output created by 343
> +
> +INFO: zero-filled test...
> +INFO: sz = 1048576
> +INFO: thread 0 created
> +INFO: thread 1 created
> +INFO: 0 error(s) detected
> +
> +INFO: posix_fallocate test...
> +INFO: sz = 1048576
> +INFO: thread 0 created
> +INFO: thread 1 created
> +INFO: 0 error(s) detected
> +
> +INFO: ftruncate test...
> +INFO: sz = 1048576
> +INFO: thread 0 created
> +INFO: thread 1 created
> +INFO: 0 error(s) detected
> +
> +INFO: zero-filled test...
> +INFO: sz = 16777216
> +INFO: thread 0 created
> +INFO: thread 1 created
> +INFO: 0 error(s) detected
> +
> +INFO: posix_fallocate test...
> +INFO: sz = 16777216
> +INFO: thread 0 created
> +INFO: thread 1 created
> +INFO: 0 error(s) detected
> +
> +INFO: ftruncate test...
> +INFO: sz = 16777216
> +INFO: thread 0 created
> +INFO: thread 1 created
> +INFO: 0 error(s) detected
> +
> +INFO: zero-filled test...
> +INFO: sz = 268435456
> +INFO: thread 0 created
> +INFO: thread 1 created
> +INFO: 0 error(s) detected
> +
> +INFO: posix_fallocate test...
> +INFO: sz = 268435456
> +INFO: thread 0 created
> +INFO: thread 1 created
> +INFO: 0 error(s) detected
> +
> +INFO: ftruncate test...
> +INFO: sz = 268435456
> +INFO: thread 0 created
> +INFO: thread 1 created
> +INFO: 0 error(s) detected
> diff --git a/tests/generic/group b/tests/generic/group
> index ef1a423495a7..05b0448d64f4 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -345,3 +345,4 @@
>  340 auto
>  341 auto quick metadata
>  342 auto quick metadata
> +343 auto
> -- 
> 2.6.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
