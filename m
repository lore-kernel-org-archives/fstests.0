Received: from userp2130.oracle.com ([156.151.31.86]:58486 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbeLTQaw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Dec 2018 11:30:52 -0500
Date: Thu, 20 Dec 2018 08:30:43 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] common/rc: create $RESULT_BASE before dumping kmemleak
 leaks
Message-ID: <20181220163043.GE3306@magnolia>
References: <20181220125222.12041-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220125222.12041-1-jthumshirn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 20, 2018 at 01:52:22PM +0100, Johannes Thumshirn wrote:
> In _init_kmemleak() we're touching a check_kmemleak file in ${RESULT_BASE}
> if ${DEBUGFS_MNT/kmemleak} exists as a marker that we have to check for
> kmemleak output after running a test.
> 
> In 'check' we're calling _init_kmemleak() at around 60% of the file, but
> ${RESULT_BASE} is created later at around 62% of the file, causing the
> 'touch' in _init_kmemleak() to fail.
> 
> The workaround to this is creating ${RESULT_BASE} before touching
> ${RESULT_BASE}/check_kmemleak to always have the marker.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Looks reasonable to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  common/rc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/common/rc b/common/rc
> index e5da648466eb..5565b63e07ed 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3528,6 +3528,7 @@ _init_kmemleak()
>  	# then dump all the leaks recorded so far.
>  	if echo "scan=off" > "$kern_knob" 2>/dev/null; then
>  		_capture_kmemleak /dev/null
> +		mkdir -p ${RESULT_BASE}
>  		touch ${RESULT_BASE}/check_kmemleak
>  	fi
>  }
> -- 
> 2.16.4
> 
