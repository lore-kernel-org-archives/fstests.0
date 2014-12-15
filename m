Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38749 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbaLODwX (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 14 Dec 2014 22:52:23 -0500
Date: Mon, 15 Dec 2014 11:52:17 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3] generic/299: various fixes
Message-ID: <20141215035217.GU15495@dhcp-13-216.nay.redhat.com>
References: <1418295529-20565-1-git-send-email-eguan@redhat.com>
 <1418359401-8240-1-git-send-email-eguan@redhat.com>
 <20141214221221.GP29787@thunk.org>
 <20141214221713.GQ29787@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141214221713.GQ29787@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Dec 14, 2014 at 05:17:13PM -0500, Theodore Ts'o wrote:
> On Sun, Dec 14, 2014 at 05:12:21PM -0500, Theodore Ts'o wrote:
> > I'm currently a testing a patch which uses "pgrep -f $XFS_IO_PROG"
> > instead, but I'm a bit surprised no once else noticed this, I guess
> > people aren't building their xfstests test kernels with DM_SNAPSHOP or
> > DM_VERITY configured (either of which will seleect DM_BUFIO)?
> 
> Ah, right, this hasn't gone upstream yet; I had just pulled it in
> because I was seeing the problem with the umount hanging and killing
> my test runs.
> 
> Anyway, Eryu, I'd suggest you resend your patch with the following
> change, which seems to fix things up for me.
> 
> And with this patch included, feel free to add:
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> 
> 	      	       	   	     	 - Ted
> 
> diff --git a/tests/generic/299 b/tests/generic/299
> index e5de45b..9b99a66 100755
> --- a/tests/generic/299
> +++ b/tests/generic/299
> @@ -138,7 +138,7 @@ _workout()
>  	    done
>  	    # Following like will check that pid is still run.
>  	    # Once fio exit we can stop fallocate/truncate loop
> -	    pgrep fio > /dev/null 2>&1 || break
> +	    pgrep -f $XFS_IO_PROG > /dev/null 2>&1 || break

I assume you mean $FIO_PROG here :)

Yes, pgrep -f is doing the job and is much better than pgrep, thanks!

I didn't use $FIO_PROG at the first place because I was afraid that
$FIO_PROG contains some arguments like XFS_IO_PROG does (xfs_io -F).

But pgrep -f "$FIO_PROG" just works fine, I'll resend with this change.

Thanks!

Eryu
