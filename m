Received: from userp2130.oracle.com ([156.151.31.86]:50868 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbeEQObI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 May 2018 10:31:08 -0400
Date: Thu, 17 May 2018 07:30:57 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: Problems about xfstests g/475
Message-ID: <20180517143057.GC4910@magnolia>
References: <20180517090304.GB4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517090304.GB4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 17, 2018 at 05:03:04PM +0800, Zorro Lang wrote:
> Hi Darrick,
> 
> Sorry to trouble you, generic/475 rarely trigger an error[1] (test
> on 4.16 kernel)
> 
> I checked the case, from the xfstests code below:
> 
> _dmerror_load_error_table()
> {
>         suspend_opt="--nolockfs"
> 
>         if [ "$1" = "lockfs" ]; then
>                 suspend_opt=""
>         elif [ -n "$*" ]; then
>                 suspend_opt="$*"
>         fi
> 
>         $DMSETUP_PROG suspend $suspend_opt error-test
>         [ $? -ne 0 ] && _fail  "dmsetup suspend failed"
> 
>         $DMSETUP_PROG load error-test --table "$DMERROR_TABLE"
>         [ $? -ne 0 ] && _fail "dmsetup failed to load error table"
> 
>         $DMSETUP_PROG resume error-test
>         [ $? -ne 0 ] && _fail  "dmsetup resume failed"
> }
> 
> _dmerror_load_error_table() use "--nolockfs" by default. But g/475 call
> _dmerror_load_error_table without any argument, so it doesn't do the
> things as it describes on comment -- "Loading error table without --nolockfs
> option".
> 
> I'm confused, what is your expected test? Is this "--nolockfs" thing
> cause this error[1]?
> 
> Thanks,
> Zorro
> 
> 
> [1]
> meta-data=/dev/sda3              isize=512    agcount=4, agsize=1966080 blks
>          =                       sectsz=512   attr=2, projid32bit=1
>          =                       crc=1        finobt=1, sparse=0, rmapbt=0, reflink=0
> data     =                       bsize=2048   blocks=7864320, imaxpct=25
>          =                       sunit=0      swidth=0 blks
> naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
> log      =internal log           bsize=2048   blocks=5120, version=2
>          =                       sectsz=512   sunit=0 blks, lazy-count=1
> realtime =none                   extsz=4096   blocks=0, rtextents=0
> seed = 1525927899
> ...
> ...
> seed = 1525744142
> mount failed
> _check_xfs_filesystem: filesystem on /dev/sda3 has dirty log

Uh, I guess log recovery failed.  What did dmesg capture?

--D

> *** xfs_logprint -t output ***
> Log inconsistent or not a log (last==0, first!=1)
> empty log check failed
> xfs_logprint: failed to find head and tail, error: 22
> xfs_logprint:
>     data device: 0x803
>     log device: 0x803 daddr: 15728660 length: 20480
> 
> *** end xfs_logprint output
> _check_xfs_filesystem: filesystem on /dev/sda3 is inconsistent (c)
> *** xfs_check output ***
> Log inconsistent or not a log (last==0, first!=1)
> empty log check failed
> xlog_is_dirty: cannot find log head/tail (xlog_find_tail=22)
> 
> ERROR: cannot find log head/tail, run xfs_repair
> *** end xfs_check output
> _check_xfs_filesystem: filesystem on /dev/sda3 is inconsistent (r)
> *** xfs_repair -n output ***
> Phase 1 - find and verify superblock...
> Phase 2 - using internal log
>         - zero log...
> Log inconsistent or not a log (last==0, first!=1)
> empty log check failed
> zero_log: cannot find log head/tail (xlog_find_tail=22)
> *** end xfs_repair output
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
