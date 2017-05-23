Received: from mx1.redhat.com ([209.132.183.28]:54126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936587AbdEWOcn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 23 May 2017 10:32:43 -0400
Date: Tue, 23 May 2017 22:32:41 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] xfs: Make 'man' hard requirement for xfs/293
Message-ID: <20170523143241.GE7250@eguan.usersys.redhat.com>
References: <20170523140156.GD7250@eguan.usersys.redhat.com>
 <1495549000-30608-1-git-send-email-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495549000-30608-1-git-send-email-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Nikolay Borisov <nborisov@suse.com>
Cc: fstests@vger.kernel.org, Nikolay Borisov <nborsiov@suse.com>
List-ID: <fstests@vger.kernel.org>

On Tue, May 23, 2017 at 05:16:40PM +0300, Nikolay Borisov wrote:
> From: Nikolay Borisov <nborsiov@suse.com>
> 
> If xfs/293 is run on a system which doesn't have 'man' installed
> it will hang the due to $CAT waiting for input indefinitely. Also
> create an entry for $MAN_PROG and use the cached $MANPAGE instead
> of repeatedy calling $MAN_PROG --page

Thanks for the update! I did minor modifications and queued it for next
fstests update.

> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  common/config | 1 +
>  tests/xfs/293 | 7 +++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/common/config b/common/config
> index 8211356c..eb5b36b0 100644
> --- a/common/config
> +++ b/common/config
> @@ -196,6 +196,7 @@ export XZ_PROG="`set_prog_path xz`"
>  export FLOCK_PROG="`set_prog_path flock`"
>  export LDD_PROG="`set_prog_path ldd`"
>  export TIMEOUT_PROG="`set_prog_path timeout`"
> +export MAN_PROG="`set_prog_path man`"
>  
>  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>  # newer systems have udevadm command but older systems like RHEL5 don't.
> diff --git a/tests/xfs/293 b/tests/xfs/293
> index df44e98e..24b0a992 100755
> --- a/tests/xfs/293
> +++ b/tests/xfs/293
> @@ -40,15 +40,18 @@ _cleanup()
>  . ./common/rc
>  . ./common/filter
>  
> +

Removed this extra new line.

>  # real QA test starts here
>  
>  # Modify as appropriate.
>  _supported_fs xfs
>  _supported_os IRIX Linux
>  
> +_require_command man man

_require_command "$MAN_PROG" man, otherwise test _notrun

xfs/293  [not run] man utility required, skipped this test

Thanks,
Eryu

> +
>  echo "Silence is golden"
>  
> -MANPAGE=`man --path xfs_io`
> +MANPAGE=`$MAN_PROG --path xfs_io`
>  
>  case "$MANPAGE" in
>  *.gz|*.z\|*.Z)	CAT=zcat;;
> @@ -60,7 +63,7 @@ esac
>  _require_command `which $CAT` $CAT
>  
>  for COMMAND in `$XFS_IO_PROG -c help | awk '{print $1}' | grep -v "^Use"`; do
> -  $CAT `man --path xfs_io` | egrep -q "^\.B.*$COMMAND" || \
> +  $CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
>  	echo "$COMMAND not documented in the xfs_io manpage"
>  done
>  
> -- 
> 2.12.3
> 
