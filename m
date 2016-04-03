Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:29486 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752266AbcDCXIm (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 3 Apr 2016 19:08:42 -0400
Date: Mon, 4 Apr 2016 09:08:38 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] common: teach _require_odirect that ext4 encryption
 doesn't support DIO
Message-ID: <20160403230838.GA11238@dastard>
References: <1459616174-31557-1-git-send-email-tytso@mit.edu>
 <1459616174-31557-2-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459616174-31557-2-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Apr 02, 2016 at 12:56:14PM -0400, Theodore Ts'o wrote:
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  common/rc | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 2ccca3b..961601b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1916,6 +1916,10 @@ _require_xfs_db_command()
>  # check that kernel and filesystem support direct I/O
>  _require_odirect()
>  {
> +       if [ $FSTYP = "ext4" ] &&
> +	  echo "$MOUNT_OPTIONS" | grep -q "test_dummy_encryption" ; then
> +		_notrun "ext4 encryption doesn't support O_DIRECT"
> +       fi
>         testfile=$TEST_DIR/$$.direct
>         $XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile > /dev/null 2>&1

Why isn't the direct IO failing here with an error sufficient to
prevent the test from running?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
