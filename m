Received: from mx1.redhat.com ([209.132.183.28]:41841 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916AbcGMJIb (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 13 Jul 2016 05:08:31 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 126B37F3E1
	for <fstests@vger.kernel.org>; Wed, 13 Jul 2016 09:08:26 +0000 (UTC)
Received: from localhost (dhcp-12-123.nay.redhat.com [10.66.12.123])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u6D98O2Z008946
	for <fstests@vger.kernel.org>; Wed, 13 Jul 2016 05:08:25 -0400
Date: Wed, 13 Jul 2016 17:08:24 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic: add _require_block_device to more tests
Message-ID: <20160713090824.GR2432@eguan.usersys.redhat.com>
References: <1467343112-26227-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467343112-26227-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 01, 2016 at 11:18:32AM +0800, Eryu Guan wrote:
> generic/067 mounts $SCRATCH_DEV directly in the test, assuming it's
> a block device. generic/299 and generic/300 query the size of
> $SCRATCH_DEV by running 'blockdev --getsz $SCRATCH_DEV'.
> 
> So add the check to make sure $SCRATCH_DEV is a real block device in
> these tests.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Ping on this as well.

Thanks,
Eryu

> ---
>  tests/generic/067 | 1 +
>  tests/generic/299 | 1 +
>  tests/generic/300 | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/tests/generic/067 b/tests/generic/067
> index 8a7a55c..8f2baf5 100755
> --- a/tests/generic/067
> +++ b/tests/generic/067
> @@ -56,6 +56,7 @@ _require_test_symlinks
>  _require_test
>  _require_scratch
>  _require_loop
> +_require_block_device $SCRATCH_DEV
>  
>  rm -f $seqres.full
>  
> diff --git a/tests/generic/299 b/tests/generic/299
> index 40265c8..c9ed0e0 100755
> --- a/tests/generic/299
> +++ b/tests/generic/299
> @@ -43,6 +43,7 @@ _supported_fs generic
>  _supported_os Linux
>  _require_scratch
>  _require_odirect
> +_require_block_device $SCRATCH_DEV
>  
>  NUM_JOBS=$((4*LOAD_FACTOR))
>  BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
> diff --git a/tests/generic/300 b/tests/generic/300
> index c187f43..181594e 100755
> --- a/tests/generic/300
> +++ b/tests/generic/300
> @@ -43,6 +43,7 @@ _supported_fs generic
>  _supported_os Linux
>  _require_scratch
>  _require_odirect
> +_require_block_device $SCRATCH_DEV
>  
>  # xfs_io is not required for this test, but it's the best way to verify
>  # the test system supports fallocate() for allocation and hole punching
> -- 
> 2.7.4
> 
