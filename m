Received: from mail-pg1-f196.google.com ([209.85.215.196]:39179 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbeLUFNr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 21 Dec 2018 00:13:47 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so1948905pgl.6
        for <fstests@vger.kernel.org>; Thu, 20 Dec 2018 21:13:47 -0800 (PST)
Date: Fri, 21 Dec 2018 13:13:40 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] common/rc: create $RESULT_BASE before dumping kmemleak
 leaks
Message-ID: <20181221051340.GB21777@desktop>
References: <20181220125222.12041-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220125222.12041-1-jthumshirn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: fstests@vger.kernel.org
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

Hmm, hiding the $RESULT_BASE creation here seems odd to me. I'd suggest
create $RESULT_BASE just after setting the default value in
common/config (in get_next_config()), which is sourced by common/rc then
by check, so we get all the environment setup before calling
_init_kmemleak().

Thanks,
Eryu

>  		touch ${RESULT_BASE}/check_kmemleak
>  	fi
>  }
> -- 
> 2.16.4
> 
