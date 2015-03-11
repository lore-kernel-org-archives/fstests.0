Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:34149 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753604AbbCKOsU (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 11 Mar 2015 10:48:20 -0400
Message-ID: <550055B2.3040308@sandeen.net>
Date: Wed, 11 Mar 2015 10:48:18 -0400
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] common: append -d option to XFS_COPY_PROG when testing
 v5 xfs
References: <1426072534-12246-1-git-send-email-eguan@redhat.com> <1426072534-12246-4-git-send-email-eguan@redhat.com>
In-Reply-To: <1426072534-12246-4-git-send-email-eguan@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 3/11/15 7:15 AM, Eryu Guan wrote:
> xfs_copy doesn't work on v5 xfs without -d option, this fails xfs/073
> when testing xfs with MKFS_OPTIONS="-m crc=1" set.

Neat, I did not know about the "=~" trick ;)

Test xfs/073 adds -d already, but two -d's are accepted...

... but the xfs/073 fails due to the fallback to nouuid, forced by
the duplicate ID which is found:

@@ -17,6 +17,7 @@
 All copies completed.
 checking new image
 mounting new image on loopback
+retrying mount with nouuid option

Also:

* This will only work until crcs are made default
* If $TEST_DEV was made with CRCs then "crc=1" might not be in MKFS_OPTIONS,
  but xfs_copy of $TEST_DEV would still fail

But we only ever use it on $SCRATCH_DEV in tests today, and if/when
crcs are made default we can figure out how to test for that later...

Still, need some solution that doesn't fail the existing test.

We could just _notrun this test with crcs ... talking with hch, I wonder
if we even have a use for xfs_copy anymore.   A changed-uuid xfs_copy
will be very hard to do w/ v5 filesystems.

-Eric

> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  common/rc | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 1ed9df5..ad87a18 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2926,6 +2926,11 @@ init_rc()
>  	# Figure out if we need to add -F ("foreign", deprecated) option to xfs_io
>  	xfs_io -c stat $TEST_DIR 2>&1 | grep -q "is not on an XFS filesystem" && \
>  	export XFS_IO_PROG="$XFS_IO_PROG -F"
> +
> +	# xfs_copy doesn't work on v5 xfs yet without -d option
> +	if [ "$FSTYP" == "xfs" ] && [[ $MKFS_OPTIONS =~ crc=1 ]]; then
> +		export XFS_COPY_PROG="$XFS_COPY_PROG -d"
> +	fi
>  }
>  
>  # get real device path name by following link
> 

