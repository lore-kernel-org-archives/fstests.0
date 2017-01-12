Received: from mx1.redhat.com ([209.132.183.28]:41078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbdALDv0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 11 Jan 2017 22:51:26 -0500
Date: Thu, 12 Jan 2017 11:51:24 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] common: use xfs_io to obtain the xfsprogs version
Message-ID: <20170112035124.GU1859@eguan.usersys.redhat.com>
References: <20170111104820.7367-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170111104820.7367-1-ddiss@suse.de>
Sender: fstests-owner@vger.kernel.org
To: David Disseldorp <ddiss@suse.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 11, 2017 at 11:48:20AM +0100, David Disseldorp wrote:
> xfs_db is currently used for this, but is otherwise only used for XFS
> specific tests. This change allows for the generic tests to be run on a
> system without the xfs_db binary.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  common/config | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/common/config b/common/config
> index 6cce7ce..1604aa9 100644
> --- a/common/config
> +++ b/common/config
> @@ -226,11 +226,11 @@ export UDEV_SETTLE_PROG
>  # Generate a comparable xfsprogs version number in the form of
>  # major * 10000 + minor * 100 + release
>  #
> -# $ xfs_db -V
> -# xfs_db version 2.9.7
> +# $ xfs_io -V
> +# xfs_io version 2.9.7
>  #
>  # so, 2.9.7 = 20907
> -_version=`$XFS_DB_PROG -V | $AWK_PROG '
> +_version=`$XFS_IO_PROG -V | $AWK_PROG '

I noticed that this $_version is only assigned to XFSPROGS_VERSION, and
the only user of $XFSPROGS_VERSION is xfs/188.

if [ $XFSPROGS_VERSION -lt 21000 ]; then
    _notrun "this test requires case-insensitive support"
fi

That's a test added in 2008, now we avoid skipping tests by checking on
some version number, we tend to add new _require rules to actually test
for the requirements. e.g. for xfs/188, I think we can have:

in common/xfs:
# this test requires mkfs.xfs have case-insensitive naming support
_require_xfs_mkfs_ciname()
{
	_scratch_mkfs_xfs_supported -n version=ci >/dev/null 2>&1 \
		|| _notrun "need case-insensitive naming support in mkfs.xfs"
}

And remove all the version detection & checking code from common/config
and xfs/188, and call the new _require rule in the test.

Thanks,
Eryu
