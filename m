Received: from mx1.redhat.com ([209.132.183.28]:37894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754040AbdEDFJ0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 May 2017 01:09:26 -0400
Date: Thu, 4 May 2017 13:09:23 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] check: catch updated suspicious RCU usage message in
 _check_dmesg()
Message-ID: <20170504050923.GJ7250@eguan.usersys.redhat.com>
References: <20170504005730.29862-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170504005730.29862-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, May 03, 2017 at 05:57:30PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> In the v4.11 kernel, the suspicious RCU usage message uses the word
> "ERR" rather than "INFO".  Update _check_dmesg to accept both versions.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks! I updated the commit log a bit to refer to kernel commit
4d4f88fa235f ("lockdep: Make RCU suspicious-access splats use pr_err")

Thanks,
Eryu

> ---
>  common/rc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 8dafd4bc..257b1903 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3285,13 +3285,13 @@ _check_dmesg()
>  	# use sed \cregexpc address type, since $seqnum contains "/"
>  	dmesg | tac | sed -ne "0,\#run fstests $seqnum at $date_time#p" | \
>  		tac | $filter >$seqres.dmesg
> -	grep -q -e "kernel BUG at" \
> +	egrep -q -e "kernel BUG at" \
>  	     -e "WARNING:" \
>  	     -e "BUG:" \
>  	     -e "Oops:" \
>  	     -e "possible recursive locking detected" \
>  	     -e "Internal error" \
> -	     -e "INFO: suspicious RCU usage" \
> +	     -e "(INFO|ERR): suspicious RCU usage" \
>  	     -e "INFO: possible circular locking dependency detected" \
>  	     -e "general protection fault:" \
>  	     $seqres.dmesg
> -- 
> 2.13.0.rc1.294.g07d810a77f-goog
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
