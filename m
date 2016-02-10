Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:19353 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755073AbcBJGHZ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2016 01:07:25 -0500
Date: Wed, 10 Feb 2016 17:07:16 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 05/12] xfstests: do not unmount tmpfs during remount
Message-ID: <20160210060716.GV19486@dastard>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-6-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455069001-17846-6-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com, Junho Ryu <jayr@google.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 09, 2016 at 08:49:54PM -0500, Theodore Ts'o wrote:
> From: Junho Ryu <jayr@google.com>
> 
> Several tests unmount then re-mount the scratch filesystem, to check
> that the content is unchanged; but unmounting a tmpfs is designed to
> lose its content, which causes such tests to fail unnecessarily.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Junho Ryu <jayr@google.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
....
>  _scratch_remount()
>  {
> -    _scratch_unmount
> -    _scratch_mount
> +    case $FSTYP in
> +    tmpfs)
> +        OPTS="$@"
> +	if test -n "$OPTS"; then
> +	   OPTS=$(echo $OPTS | sed -e 's/-o /-o remount,/')
> +	   mount $OPTS $SCRATCH_MNT
> +	fi
> +        ;;
> +    *)
> +        _scratch_unmount
> +        _scratch_mount "$@"
> +        ;;
> +    esac
>  }

If really don't like the different definitions of "remount" being
used here, especially now that new parameters are being passed in.
i.e.

> --- a/tests/generic/003
> +++ b/tests/generic/003
> @@ -108,8 +108,7 @@ _compare_stat_times NNN "$file1_stat_after_first_access" \
>  	"$file1_stat_after_second_access" "after accessing file1 second time"
>  
>  # Remounting with nodiratime option
> -_scratch_unmount
> -_scratch_mount "-o nodiratime"
> +_scratch_remount "-o nodiratime"

This makes me go "no, that can't work, nodiratime is not an option
that we allow on remount."

So, at minimum, the name of the helper needs to get changed so that
it doesn't imply that a "-o remount" with new options is being
done...

>  _require_scratch
> -_scratch_mkfs >/dev/null 2>&1
> -
> -_umount_mount()
> -{
> -    CWD=`pwd`
> -    cd /
> -    # pipe error into /dev/null, in case not mounted (after _require_scratch)
> -    _scratch_unmount 2>/dev/null
> -    _scratch_mount
> -    cd "$CWD"
> -}
> -
> -_umount_mount
> +_scratch_mkfs >/dev/null 2>&1 || _fail "mkfs failed"
> +_scratch_mount > /dev/null 2>&1 || _fail "mount failed"

Please don't add _fail to mkfs/mount like this, especially where the
test doesn't already have them.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
