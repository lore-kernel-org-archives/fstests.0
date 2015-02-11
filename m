Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:50677 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753126AbbBKQu5 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 11 Feb 2015 11:50:57 -0500
Message-ID: <54DB886D.9060201@sandeen.net>
Date: Wed, 11 Feb 2015 10:50:53 -0600
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: shared/032 is broken on Fedora
References: <54DB35F0.1010203@plexistor.com>
In-Reply-To: <54DB35F0.1010203@plexistor.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Boaz Harrosh <boaz@plexistor.com>, Dave Chinner <david@fromorbit.com>, xfs@oss.sgi.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

(cc: fstests list) 

On 2/11/15 4:58 AM, Boaz Harrosh wrote:
> 
> This is not the proper patch just to show a working version for Fedora. But I think
> it now breaks the other ARCHs.
> 
> What happens is that the output of ${MKFS_PROG}.* is:
> 	/usr/sbin/mkfs.bfs /usr/sbin/mkfs.btrfs /usr/sbin/mkfs.cramfs /usr/sbin/mkfs.ext2 /usr/sbin/mkfs.ext3 /usr/sbin/mkfs.ext4 ...
> 
> So in Fedora sbin has moved to /usr/... and therefor the sed below fails.
> My sed foo is not good enough. How to support both places for sbin?

All we really want is the mkfs filesystem type, i.e. the ${FS} in mkfs.${FS}

So 

sed -e 's/.*mkfs.//g'

should work,

awk -F . '{print $NF}' would work too

$ cat mkfses 
/usr/sbin/mkfs.ext4
/sbin/mkfs.ext4

$ cat mkfses | awk -F . '{print $NF}'
ext4
ext4

$ cat mkfses | sed -e 's/.*mkfs.//g'
ext4
ext4

> Also why the "_supported_fs xfs btrfs"? So if all those other mkfs.* that are destructive to
> foreign filesystem, should the test not fail instead of skipped?

mkfs.xfs & mkfs.btrfs are the only filesystems I know of which check for
an existing format before proceeding, so they are the only ones
tested.  Any other fs is skipped, because they are not designed to
do what this test is... testing for.

> Maybe if the maintainers of all these filesystems day in and day out running xfstests and
> see shared/032 failing, they might decide to fix their evil ways. Instead of skipping the
> test and the said maintainer just ignores it?

I think it's just a design decision.  There's no actual requirement to warn about overwriting
a format, so not doing so is not a failure or a bug, IMHO.

-Eric

> Thanks
> Boaz
> 
> ---
> diff --git a/tests/shared/032 b/tests/shared/032
> index a410003..726e6b4 100755
> --- a/tests/shared/032
> +++ b/tests/shared/032
> @@ -37,8 +37,8 @@ rm -f $seqres.full
>  . ./common/filter
>  
>  # real QA test starts here
> -_supported_fs xfs btrfs
> +# _supported_fs xfs btrfs
>  _supported_os Linux
>  
>  _require_scratch_nocheck
>  _require_no_large_scratch_dev
> @@ -49,8 +49,7 @@ if [ "$FSTYP" == "btrfs" ]; then
>  		_notrun "Installed mkfs.btrfs does not support -f option"
>  fi
>  
> -echo "Silence is golden."
> -for fs in `echo ${MKFS_PROG}.* | sed -e 's/.sbin.mkfs.//g'`
> +for fs in `echo ${MKFS_PROG}.* | sed -e 's/.usr\/sbin.mkfs.//g'`
>  do
>  	preop=""	# for special input needs
>  	preargs=""	# for any special pre-device options
> 
> _______________________________________________
> xfs mailing list
> xfs@oss.sgi.com
> http://oss.sgi.com/mailman/listinfo/xfs
> 

