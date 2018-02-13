Received: from userp2120.oracle.com ([156.151.31.85]:43378 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965783AbeBMXbp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Feb 2018 18:31:45 -0500
Date: Tue, 13 Feb 2018 15:31:40 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 2/2] fstests: use _scratch_mount_nocheck where
 appropriate in tests
Message-ID: <20180213233140.GA5208@magnolia>
References: <20180213091203.22909-1-eguan@redhat.com>
 <20180213091203.22909-3-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213091203.22909-3-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 13, 2018 at 05:12:03PM +0800, Eryu Guan wrote:
> Also remove redundant status checks of _scratch_mount.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---

<skipping to the generic and xfs tests>

> diff --git a/tests/generic/054 b/tests/generic/054
> index 12f471a19090..84b8271a11bd 100755
> --- a/tests/generic/054
> +++ b/tests/generic/054
> @@ -83,7 +83,7 @@ for s in sync nosync ; do
>  
>  	# mount the FS
>  	_echofull "mount"
> -	if ! _scratch_mount >>$seqres.full 2>&1; then
> +	if ! _scratch_mount_nocheck >>$seqres.full 2>&1; then
>  	    _echofull "mount failed: $MOUNT_OPTIONS"
>  	    continue
>  	fi
> @@ -118,7 +118,7 @@ for s in sync nosync ; do
>  	_print_logstate
>  
>  	_echofull "mount with replay"
> -	_scratch_mount >>$seqres.full 2>&1 \
> +	_scratch_mount_nocheck >>$seqres.full 2>&1 \
>  	    || _fail "mount failed: $MOUNT_OPTIONS"

nocheck || fail ??

I wonder if the fail message should always spit out the mount options
that were tried?

> diff --git a/tests/generic/068 b/tests/generic/068
> index bd12278cdd25..91b327866c54 100755
> --- a/tests/generic/068
> +++ b/tests/generic/068
> @@ -62,7 +62,7 @@ echo "*** MKFS ***"                         >>$seqres.full
>  echo ""                                     >>$seqres.full
>  _scratch_mkfs                               >>$seqres.full 2>&1 \
>      || _fail "mkfs failed"
> -_scratch_mount                              >>$seqres.full 2>&1 \
> +_scratch_mount_nocheck                      >>$seqres.full 2>&1 \
>      || _fail "mount failed"

Can this remain _scratch_mount, since we _fail anyway?

(There are more of these scattered throughout.)

--D
