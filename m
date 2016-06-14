Received: from mx1.redhat.com ([209.132.183.28]:38962 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752287AbcFNLnV (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 14 Jun 2016 07:43:21 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 799447F6B0
	for <fstests@vger.kernel.org>; Tue, 14 Jun 2016 11:43:21 +0000 (UTC)
Date: Tue, 14 Jun 2016 07:43:19 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 1/3] generic: test symlink to very long path
Message-ID: <20160614114318.GA32443@bfoster.bfoster>
References: <1465890821-4388-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1465890821-4388-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 14, 2016 at 03:53:39PM +0800, Eryu Guan wrote:
> Test symlink to very long path, so that path could not be hold in inode,
> then check symlink file contains correct path.
> 
> There was a bug in CRC XFS, that the path in remote symlink was not
> correct, this issue is fixed by this kernel commit
> 
> 2ac56d3 xfs: fix remote symlinks on V5/CRC filesystems
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---

Looks fine to me:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  tests/generic/352     | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/352.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 66 insertions(+)
>  create mode 100755 tests/generic/352
>  create mode 100644 tests/generic/352.out
> 
> diff --git a/tests/generic/352 b/tests/generic/352
> new file mode 100755
> index 0000000..253f09d
> --- /dev/null
> +++ b/tests/generic/352
> @@ -0,0 +1,63 @@
> +#! /bin/bash
> +# FS QA Test 352
> +#
> +# Test symlink to very long path, check symlink file contains correct path.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2016 Red Hat Inc.  All Rights Reserved.
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
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +
> +linkfile=$TEST_DIR/$seq.symlink
> +rm -f $linkfile
> +
> +# Create a symlink points to a very long path, so that the path could not be
> +# hold in inode
> +ln -s `perl -e 'print "a"x1023'` $linkfile
> +
> +# Check symlink contains the correct path.
> +# 1023 chars are a bit long for golden image output, compute the md5 checksum
> +readlink $linkfile | md5sum
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/352.out b/tests/generic/352.out
> new file mode 100644
> index 0000000..01c7e87
> --- /dev/null
> +++ b/tests/generic/352.out
> @@ -0,0 +1,2 @@
> +QA output created by 352
> +cd3b0a56bc304075e28a20a4edd57068  -
> diff --git a/tests/generic/group b/tests/generic/group
> index 36fb759..4b65dcb 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -354,3 +354,4 @@
>  349 blockdev quick rw
>  350 blockdev quick rw
>  351 blockdev quick rw
> +352 auto quick metadata
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
