Received: from mx1.redhat.com ([209.132.183.28]:47386 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbcF2JjX (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 29 Jun 2016 05:39:23 -0400
Date: Wed, 29 Jun 2016 17:39:21 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] common: ext4 doesn't support O_DIRECT with encryption
Message-ID: <20160629093921.GK23649@eguan.usersys.redhat.com>
References: <1467163975-11183-1-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467163975-11183-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 28, 2016 at 09:32:55PM -0400, Theodore Ts'o wrote:
> Teach _require_odirect to skip the O_DIRECT tests if the ext4 mount
> option "test_dummy_encryption" is enabled, since O_DIRECT doesen't
> make sense when file system level encryption is enabled, and several
> tests which use O_DIRECT --- ext4/301, ext4/304, generic/250 and
> generic/252 --- fail when encryption is enabled.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  common/rc | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index adda940..003400d 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1933,12 +1933,18 @@ _require_xfs_db_command()
>  # check that kernel and filesystem support direct I/O
>  _require_odirect()
>  {
> -       testfile=$TEST_DIR/$$.direct
> -       $XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile > /dev/null 2>&1
> -       if [ $? -ne 0 ]; then
> -               _notrun "O_DIRECT is not supported"
> -       fi
> -       rm -f $testfile 2>&1 > /dev/null
> +	if [ $FSTYP = "ext4" ] ; then
> +		if echo "$MOUNT_OPTIONS" | grep -q "test_dummy_encryption"
> +		then

I moved 'then' to the end of above line (if ....; then) and queued it up

Reviewed-by: Eryu Guan <eguan@redhat.com>

> +			_notrun "ext4 encryption doesn't support O_DIRECT"
> +		fi
> +	fi
> +	testfile=$TEST_DIR/$$.direct
> +	$XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile > /dev/null 2>&1
> +	if [ $? -ne 0 ]; then
> +		_notrun "O_DIRECT is not supported"
> +	fi
> +	rm -f $testfile 2>&1 > /dev/null
>  }
>  
>  # Check that a fs has enough free space (in 1024b blocks)
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
