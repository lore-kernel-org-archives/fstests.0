Received: from mail-pg1-f194.google.com ([209.85.215.194]:35301 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeIVUNs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 22 Sep 2018 16:13:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id 205-v6so6352534pgd.2
        for <fstests@vger.kernel.org>; Sat, 22 Sep 2018 07:20:03 -0700 (PDT)
Date: Sat, 22 Sep 2018 22:19:49 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH][BROKEN] common/rc: fix check for disabled kmemleak
Message-ID: <20180922141949.GC17817@desktop>
References: <20180918104456.12778-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918104456.12778-1-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 18, 2018 at 01:44:56PM +0300, Amir Goldstein wrote:
> With kernel commit b353756b2b71 ("kmemleak: always register debugfs file")
> that was merged to v4.19-rc3, the kmemleak debugfs knob exists even if
> kmemleak is disabled, but returns EBUSY on write.
> 
> Suppress EBUSY errors from _check_kmemleak() by removing write permission
> from knob on failure to initialize kmemleak.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Guys,
> 
> With kernel v4.19-rc3, tests started printing noisy messages about failure
> to write to kmemleak knob.
> 
> Problem is that kmemleak was disabled on my system but the test for
> kmemleak enabled we have in place was broken by the kernel change.
> 
> I tried this patch to hack around the new kernel behavior, but something
> is broken in this patch as it doesn't suppress all errors.

I guess that's because root has writable permission even if the file has
no 'w' permission bit set, i.e the "if [ ! -w $kern_knob ]" check never
triggers even if we "chmod a-w $kern_knob".

But, on the other hand, I prefer not changing a system file's permission
in test (even if it could hack around the issue). Checking if a special
file exists would be better, like what we do in _check_dmesg and
_check_filesystems.

For example, touch $RESULT_BASE/check_kmemleak in _init_kmemleak if
kmemleak is available, remove the file otherwise. Note that we cannot
create this file in $RESULT_DIR like other similar checks because it's
not initialized at _init_kmemleak time.

Thanks,
Eryu

> For me, I prefer to have kmemleak enabled anyway, so I gave up on this
> hack and enabled kmemleak.
> 
> If someone is interested in taking over, be my guest.
> 
> FYI, to enable kmemleak on kvm-xfstests I needed to configure
> CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=5000
> # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
> 
> Thanks,
> Amir.
> 
>  common/rc | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index ec631ad9..cafc83b4 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3514,8 +3514,14 @@ _init_kmemleak()
>  
>  	# Disable the automatic scan so that we can control it completely,
>  	# then dump all the leaks recorded so far.
> -	echo "scan=off" > "$kern_knob"
> -	_capture_kmemleak /dev/null
> +	if echo "scan=off" > "$kern_knob" 2>/dev/null; then
> +		_capture_kmemleak /dev/null
> +	else
> +		# Since kernel v4.19-rc3, the knob exists even if kmemleak is
> +		# disabled, but returns EBUSY on write. Suppress EBUSY errors
> +		# from _check_kmemleak() by removing write permission from knob
> +		chmod a-w "$kern_knob"
> +	fi
>  }
>  
>  # check kmemleak log
> -- 
> 2.17.1
> 
