Received: from mx1.redhat.com ([209.132.183.28]:48667 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbcFKMUa (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 11 Jun 2016 08:20:30 -0400
Date: Sat, 11 Jun 2016 20:20:26 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] common: ext4's data=journal mode doesn't support O_DIRECT
Message-ID: <20160611122026.GT5140@eguan.usersys.redhat.com>
References: <1465497762-3333-1-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1465497762-3333-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 09, 2016 at 02:42:42PM -0400, Theodore Ts'o wrote:
> Teach _require_odirect that ext4's data=journal mode doesn't support
> O_DIRECT.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  common/rc | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 069df58..791e6e5 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1932,9 +1932,13 @@ _require_xfs_db_command()
>  # check that kernel and filesystem support direct I/O
>  _require_odirect()
>  {
> -       if [ $FSTYP = "ext4" ] &&
> -	  echo "$MOUNT_OPTIONS" | grep -q "test_dummy_encryption" ; then
> -		_notrun "ext4 encryption doesn't support O_DIRECT"
> +       if [ $FSTYP = "ext4" ] ; then
> +           if echo "$MOUNT_OPTIONS" | grep -q "test_dummy_encryption" ; then
> +	       _notrun "ext4 encryption doesn't support O_DIRECT"
> +	   fi
> +           if echo "$MOUNT_OPTIONS" | grep -q "data=journal" ; then
> +	       _notrun "ext4 data=journal mode doesn't support O_DIRECT"
> +	   fi

This hunk doesn't apply, there's no detection code for ext4 encryption
in current master. And do we need to filter out ext3 journal mode as
well?

And this patch mixed space and tab for indention.

Just curious, what's the problem running direct I/O tests on journal
mode ext4? ext4 falls back to buffered I/O in this case and I don't see
any test failures caused by it. Perhaps it'd be better to add this
information to commit log too.

Thanks,
Eryu

>         fi
>         testfile=$TEST_DIR/$$.direct
>         $XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile > /dev/null 2>&1
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
