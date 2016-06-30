Received: from mx1.redhat.com ([209.132.183.28]:55712 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbcF3HBG (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 30 Jun 2016 03:01:06 -0400
Date: Thu, 30 Jun 2016 14:54:59 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] xfstests: update xfs/096 for new behaviour
Message-ID: <20160630065459.GW23649@eguan.usersys.redhat.com>
References: <1464858659-610-1-git-send-email-jtulak@redhat.com>
 <1467195535-32147-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467195535-32147-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 29, 2016 at 12:18:55PM +0200, Jan Tulak wrote:
> Because we recently changed how mkfs behaves when it gets incorrect/invalid
> values, update the expected output to reflect the current status.
> However, keep also compatibility with the old version.
> 
> Signed-off-by: Jan Tulak <jtulak@redhat.com>
> ---
> CHANGE: added compatibility for the old xfsprogs.

Sorry for the late response, because I was lost on this :)

Hi Dave - what's the rule/policy of maintaining the backword
compatibility in fstests? I know that efforts have been made to make
sure new changes don't break old binaries, but is that a must or a
best-to-have? And what do you think about the xfsprogs version
comparing? (I'm OK with it :-))

Thanks!

Eryu

> 
> ---
>  tests/xfs/096                     | 26 ++++++++++++++---
>  tests/xfs/096.out.external.pre460 | 50 ++++++++++++++++++++++++++++++++
>  tests/xfs/096.out.internal        | 60 +++++++++++++++++++++++++++++++++------
>  tests/xfs/096.out.internal.pre460 | 51 +++++++++++++++++++++++++++++++++
>  4 files changed, 175 insertions(+), 12 deletions(-)
>  create mode 100644 tests/xfs/096.out.external.pre460
>  create mode 100644 tests/xfs/096.out.internal.pre460
> 
> diff --git a/tests/xfs/096 b/tests/xfs/096
> index f949e83..fe3d58c 100755
> --- a/tests/xfs/096
> +++ b/tests/xfs/096
> @@ -39,6 +39,14 @@ _cleanup()
>      rm -f $tmp.*
>  }
>  
> +# Get xfsprogs version as a number (4.7.0 => 470)
> +xfsprogs_ver()
> +{
> +	$MKFS_XFS_PROG -V | \
> +	grep -o "[0-9]\+\.[0-9]\+\.[0-9]\+" | \
> +	sed "s/\.//g"
> +}
> +
>  # get standard environment, filters and checks
>  . ./common/rc
>  . ./common/filter
> @@ -106,12 +114,22 @@ _supported_os IRIX Linux
>  _require_scratch
>  _require_v2log
>  
> -# choose .out file based on internal/external log
> +# Skip on old versions of xfsprogs
> +# and choose .out file based on internal/external log
>  rm -f $seqfull.out
> -if [ "$USE_EXTERNAL" = yes ]; then
> -	ln -s $seq.out.external $seqfull.out
> +version=$(xfsprogs_ver)
> +if [ $version -ge 460 ]; then
> +	if [ "$USE_EXTERNAL" = yes ]; then
> +		ln -s $seq.out.external $seqfull.out
> +	else
> +		ln -s $seq.out.internal $seqfull.out
> +	fi
>  else
> -	ln -s $seq.out.internal $seqfull.out
> +	if [ "$USE_EXTERNAL" = yes ]; then
> +		ln -s $seq.out.external.pre460 $seqfull.out
> +	else
> +		ln -s $seq.out.internal.pre460 $seqfull.out
> +	fi
>  fi
>  
>  # maximum log record size
> diff --git a/tests/xfs/096.out.external.pre460 b/tests/xfs/096.out.external.pre460
> new file mode 100644
> index 0000000..3122330
> --- /dev/null
> +++ b/tests/xfs/096.out.external.pre460
> @@ -0,0 +1,50 @@
> +QA output created by 096
> +
> +# su too big but must be a multiple of fs block size too
> +--- mkfs=-l version=2,su=262656 ---
> +log stripe unit (262656) must be a multiple of the block size (4096)
> +
> +
> +# test log stripe greater than LR size
> +--- mkfs=-l version=2,su=266240 ---
> +meta-data=DEV isize=N      agcount=N, agsize=N blks
> +data     =                       bsize=4096   blocks=N, imaxpct=N
> +         =                       sunit=0      swidth=0 blks, unwritten=1
> +naming   =version 2              bsize=4096
> +log      =LOG                    bsize=4096   blocks=N, version=N
> +realtime =REALTIME               extsz=N, blocks=N, rtextents=N
> +
> +
> +# same test but get log stripe from data stripe
> +--- mkfs=-l version=2 -d su=266240,sw=1 ---
> +meta-data=DEV isize=N      agcount=N, agsize=N blks
> +data     =                       bsize=4096   blocks=N, imaxpct=N
> +         =                       sunit=65     swidth=65 blks, unwritten=1
> +naming   =version 2              bsize=4096
> +log      =LOG                    bsize=4096   blocks=N, version=N
> +         =                       sunit=N blks
> +realtime =REALTIME               extsz=N, blocks=N, rtextents=N
> +
> +
> +# test out data stripe
> +--- mkfs=-m crc=0 -l version=1 -d su=266240,sw=1 ---
> +meta-data=DEV isize=N      agcount=N, agsize=N blks
> +data     =                       bsize=4096   blocks=N, imaxpct=N
> +         =                       sunit=65     swidth=65 blks, unwritten=1
> +naming   =version 2              bsize=4096
> +log      =LOG                    bsize=4096   blocks=N, version=N
> +         =                       sunit=N blks
> +realtime =REALTIME               extsz=N, blocks=N, rtextents=N
> +
> +
> +# test out data stripe the same but using sunit & swidth
> +--- mkfs=-m crc=0 -l version=1 -d sunit=520,swidth=520 ---
> +meta-data=DEV isize=N      agcount=N, agsize=N blks
> +data     =                       bsize=4096   blocks=N, imaxpct=N
> +         =                       sunit=65     swidth=65 blks, unwritten=1
> +naming   =version 2              bsize=4096
> +log      =LOG                    bsize=4096   blocks=N, version=N
> +         =                       sunit=N blks
> +realtime =REALTIME               extsz=N, blocks=N, rtextents=N
> +
> +
> diff --git a/tests/xfs/096.out.internal b/tests/xfs/096.out.internal
> index 80201d2..82c2043 100644
> --- a/tests/xfs/096.out.internal
> +++ b/tests/xfs/096.out.internal
> @@ -2,18 +2,62 @@ QA output created by 096
>  
>  # su too big but must be a multiple of fs block size too
>  --- mkfs=-l version=2,su=262656 ---
> -log stripe unit (262656) must be a multiple of the block size (4096)
> +Illegal value 262656 for -l su option. value is too large
> +Usage: mkfs.xfs
> +/* blocksize */		[-b log=n|size=num]
> +/* data subvol */	[-d agcount=n,agsize=n,file,name=xxx,size=num,
> +			    (sunit=value,swidth=value|su=num,sw=num|noalign),
> +			    sectlog=n|sectsize=num
> +/* force overwrite */	[-f]
> +/* inode size */	[-i log=n|perblock=n|size=num,maxpct=n,attr=0|1|2,
> +			    projid32bit=0|1,sparse=0|1]
> +/* no discard */	[-K]
> +/* log subvol */	[-l agnum=n,internal,size=num,logdev=xxx,version=n
> +			    sunit=value|su=num,sectlog=n|sectsize=num,
> +			    lazy-count=0|1]
> +/* label */		[-L label (maximum 12 characters)]
> +/* naming */		[-n log=n|size=num,version=N|ci,ftype=0|1]
> +/* no-op info only */	[-N]
> +/* prototype file */	[-p fname]
> +/* quiet */		[-q]
> +/* realtime subvol */	[-r extsize=num,size=num,rtdev=xxx]
> +/* sectorsize */	[-s log=n|size=num]
> +/* version */		[-V]
> +			devicename
> +<devicename> is required unless -d name=xxx is given.
> +<num> is xxx (bytes), xxxs (sectors), xxxb (fs blocks), xxxk (xxx KiB),
> +      xxxm (xxx MiB), xxxg (xxx GiB), xxxt (xxx TiB) or xxxp (xxx PiB).
> +<value> is xxx (512 byte blocks).
>  
>  
>  # test log stripe greater than LR size
>  --- mkfs=-l version=2,su=266240 ---
> -meta-data=DEV isize=N    agcount=N, agsize=N blks
> -data     =                       bsize=4096   blocks=N, imaxpct=N
> -         =                       sunit=0      swidth=0 blks, unwritten=1
> -naming   =version 2              bsize=4096
> -log      =LOG                    bsize=4096   blocks=N, version=N
> -         =                       sunit=N blks
> -realtime =REALTIME               extsz=N, blocks=N, rtextents=N
> +Illegal value 266240 for -l su option. value is too large
> +Usage: mkfs.xfs
> +/* blocksize */		[-b log=n|size=num]
> +/* data subvol */	[-d agcount=n,agsize=n,file,name=xxx,size=num,
> +			    (sunit=value,swidth=value|su=num,sw=num|noalign),
> +			    sectlog=n|sectsize=num
> +/* force overwrite */	[-f]
> +/* inode size */	[-i log=n|perblock=n|size=num,maxpct=n,attr=0|1|2,
> +			    projid32bit=0|1,sparse=0|1]
> +/* no discard */	[-K]
> +/* log subvol */	[-l agnum=n,internal,size=num,logdev=xxx,version=n
> +			    sunit=value|su=num,sectlog=n|sectsize=num,
> +			    lazy-count=0|1]
> +/* label */		[-L label (maximum 12 characters)]
> +/* naming */		[-n log=n|size=num,version=N|ci,ftype=0|1]
> +/* no-op info only */	[-N]
> +/* prototype file */	[-p fname]
> +/* quiet */		[-q]
> +/* realtime subvol */	[-r extsize=num,size=num,rtdev=xxx]
> +/* sectorsize */	[-s log=n|size=num]
> +/* version */		[-V]
> +			devicename
> +<devicename> is required unless -d name=xxx is given.
> +<num> is xxx (bytes), xxxs (sectors), xxxb (fs blocks), xxxk (xxx KiB),
> +      xxxm (xxx MiB), xxxg (xxx GiB), xxxt (xxx TiB) or xxxp (xxx PiB).
> +<value> is xxx (512 byte blocks).
>  
>  
>  # same test but get log stripe from data stripe
> diff --git a/tests/xfs/096.out.internal.pre460 b/tests/xfs/096.out.internal.pre460
> new file mode 100644
> index 0000000..80201d2
> --- /dev/null
> +++ b/tests/xfs/096.out.internal.pre460
> @@ -0,0 +1,51 @@
> +QA output created by 096
> +
> +# su too big but must be a multiple of fs block size too
> +--- mkfs=-l version=2,su=262656 ---
> +log stripe unit (262656) must be a multiple of the block size (4096)
> +
> +
> +# test log stripe greater than LR size
> +--- mkfs=-l version=2,su=266240 ---
> +meta-data=DEV isize=N    agcount=N, agsize=N blks
> +data     =                       bsize=4096   blocks=N, imaxpct=N
> +         =                       sunit=0      swidth=0 blks, unwritten=1
> +naming   =version 2              bsize=4096
> +log      =LOG                    bsize=4096   blocks=N, version=N
> +         =                       sunit=N blks
> +realtime =REALTIME               extsz=N, blocks=N, rtextents=N
> +
> +
> +# same test but get log stripe from data stripe
> +--- mkfs=-l version=2 -d su=266240,sw=1 ---
> +meta-data=DEV isize=N    agcount=N, agsize=N blks
> +data     =                       bsize=4096   blocks=N, imaxpct=N
> +         =                       sunit=65     swidth=65 blks, unwritten=1
> +naming   =version 2              bsize=4096
> +log      =LOG                    bsize=4096   blocks=N, version=N
> +         =                       sunit=N blks
> +realtime =REALTIME               extsz=N, blocks=N, rtextents=N
> +
> +
> +# test out data stripe
> +--- mkfs=-m crc=0 -l version=1 -d su=266240,sw=1 ---
> +meta-data=DEV isize=N    agcount=N, agsize=N blks
> +data     =                       bsize=4096   blocks=N, imaxpct=N
> +         =                       sunit=65     swidth=65 blks, unwritten=1
> +naming   =version 2              bsize=4096
> +log      =LOG                    bsize=4096   blocks=N, version=N
> +         =                       sunit=N blks
> +realtime =REALTIME               extsz=N, blocks=N, rtextents=N
> +
> +
> +# test out data stripe the same but using sunit & swidth
> +--- mkfs=-m crc=0 -l version=1 -d sunit=520,swidth=520 ---
> +meta-data=DEV isize=N    agcount=N, agsize=N blks
> +data     =                       bsize=4096   blocks=N, imaxpct=N
> +         =                       sunit=65     swidth=65 blks, unwritten=1
> +naming   =version 2              bsize=4096
> +log      =LOG                    bsize=4096   blocks=N, version=N
> +         =                       sunit=N blks
> +realtime =REALTIME               extsz=N, blocks=N, rtextents=N
> +
> +
> -- 
> 2.5.5
> 
