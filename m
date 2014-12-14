Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:55632 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023AbaLNWMY (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 14 Dec 2014 17:12:24 -0500
Date: Sun, 14 Dec 2014 17:12:21 -0500
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3] generic/299: various fixes
Message-ID: <20141214221221.GP29787@thunk.org>
References: <1418295529-20565-1-git-send-email-eguan@redhat.com>
 <1418359401-8240-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1418359401-8240-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 12, 2014 at 12:43:21PM +0800, Eryu Guan wrote:
> @@ -136,7 +138,7 @@ _workout()
>  	    done
>  	    # Following like will check that pid is still run.
>  	    # Once fio exit we can stop fallocate/truncate loop
> -	    kill -0 $pid > /dev/null 2>&1 || break
> +	    pgrep fio > /dev/null 2>&1 || break
>  	done
>  	wait $pid

This patch is causing generic/299 to loop forever for me.  The problem
is that "fio" is too easy to match:

root@kvm-xfstests:~# pgrep fio
1407
root@kvm-xfstests:~# ps augxww | grep 1407
root      1407  0.0  0.0      0     0 ?        S<   16:52   0:00 [dm_bufio_cache]
root      8386  0.0  0.0   2704   492 ttyS1    S+   17:06   0:00 grep 1407

I'm currently a testing a patch which uses "pgrep -f $XFS_IO_PROG"
instead, but I'm a bit surprised no once else noticed this, I guess
people aren't building their xfstests test kernels with DM_SNAPSHOP or
DM_VERITY configured (either of which will seleect DM_BUFIO)?

	  	     	     	      	   - Ted
