Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:65450 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751357AbaLOX1y (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 15 Dec 2014 18:27:54 -0500
Date: Tue, 16 Dec 2014 10:27:39 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] check: treat _check_{test,scratch}_fs failures as
 test failures
Message-ID: <20141215232739.GC2152@dastard>
References: <1418663367-18755-1-git-send-email-eguan@redhat.com>
 <1418663367-18755-2-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1418663367-18755-2-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Dec 16, 2014 at 01:09:27AM +0800, Eryu Guan wrote:
> Currently if _check_test_fs and/or _check_scratch_fs find corruption,
> the test itself is still reported as pass, like
> 
> 	[root@hp-dl388eg8-01 xfstests]# ./check xfs/071 xfs/072
> 	FSTYP         -- xfs (non-debug)
> 	PLATFORM      -- Linux/x86_64 hp-dl388eg8-01 3.18.0-rc7+
> 	MKFS_OPTIONS  -- -f -bsize=4096 /dev/sda6
> 	MOUNT_OPTIONS -- -o context=system_u:object_r:nfs_t:s0 /dev/sda6 /mnt/testarea/scratch
> 
> 	xfs/071  2s
> 	_check_xfs_filesystem: filesystem on /dev/sda6 is inconsistent (r) (see /root/xfstests/results//xfs/071.full)
> 	xfs/072  1s
> 	Ran: xfs/071 xfs/072
> 	Passed all 2 tests
> 
> 	[root@hp-dl388eg8-01 xfstests]# echo $?
> 	0
> 
> Usually it's not a problem, but it does confuse scripts that depend on
> return value of check. Update check to treat _check_{test,scratch}_fs
> failures as test failures too, new test output is like
> 
> 	[root@hp-dl388eg8-01 xfstests]# ./check xfs/071 xfs/072
> 	FSTYP         -- xfs (non-debug)
> 	PLATFORM      -- Linux/x86_64 hp-dl388eg8-01 3.18.0-rc7+
> 	MKFS_OPTIONS  -- -f -bsize=4096 /dev/sda6
> 	MOUNT_OPTIONS -- -o context=system_u:object_r:nfs_t:s0 /dev/sda6 /mnt/testarea/scratch
> 
> 	xfs/071 2s ... 2s
> 	_check_xfs_filesystem: filesystem on /dev/sda6 is inconsistent (r) (see /root/xfstests/results//xfs/071.full)
> 	xfs/072 1s ... 1s
> 	Ran: xfs/071 xfs/072
> 	Failures: xfs/071
> 	Failed 1 of 2 tests
> 
> 	[root@hp-dl388eg8-01 xfstests]# echo $?
> 	1
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
> 
> Note that the xfs/071 corruption issue is an xfs_repair bug,
> Eric has sent a patch to fix it, see
> 
> http://www.spinics.net/lists/xfs/msg31018.html
> 
>  check | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/check b/check
> index 42a1ac2..4cf7070 100755
> --- a/check
> +++ b/check
> @@ -611,6 +611,16 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  			    err=true
>  			fi
>  		    fi
> +		    try="$try $seqnum"
> +		    n_try=`expr $n_try + 1`
> +		    if [ -f ${RESULT_DIR}/require_test ]; then
> +			_check_test_fs || err=true
> +			rm -f ${RESULT_DIR}/require_test
> +		    fi
> +		    if [ -f ${RESULT_DIR}/require_scratch ]; then
> +			_check_scratch_fs || err=true
> +			rm -f ${RESULT_DIR}/require_scratch
> +		    fi
>  		fi
>  
>  	    fi
> @@ -623,15 +633,6 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  		n_bad=`expr $n_bad + 1`
>  		quick=false
>  	    fi
> -	    if [ ! -f $seqres.notrun ]
> -	    then
> -		try="$try $seqnum"
> -		n_try=`expr $n_try + 1`
> -		test -f ${RESULT_DIR}/require_test && _check_test_fs
> -		rm -f ${RESULT_DIR}/require_test
> -		test -f ${RESULT_DIR}/require_scratch && _check_scratch_fs
> -		rm -f ${RESULT_DIR}/require_scratch
> -	    fi
>  
>  	    seq="after_$seqnum"

Looks fine as is, but in the interest of slowly cleaning up check,
can you factor this out into a helper function such as
"check_filesystems" using 8 space tabs?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
