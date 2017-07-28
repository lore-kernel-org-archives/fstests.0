Received: from sandeen.net ([63.231.237.45]:57386 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752459AbdG1Qnl (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 28 Jul 2017 12:43:41 -0400
Received: from [10.0.0.4] (liberator [10.0.0.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 8710A612521
        for <fstests@vger.kernel.org>; Fri, 28 Jul 2017 11:42:57 -0500 (CDT)
Subject: Re: [PATCH, V2] xfstests: fail test if it causes a kernel taint
References: <51916146.80308@redhat.com> <519E3A20.7060102@sandeen.net>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <af8df1f2-dd68-b412-2276-5f6e89d28507@sandeen.net>
Date: Fri, 28 Jul 2017 11:43:40 -0500
MIME-Version: 1.0
In-Reply-To: <519E3A20.7060102@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This one got lost in the mists of time, seems like maybe still a good idea?

On 5/23/13 10:47 AM, Eric Sandeen wrote:
> This modification will fail a test if it introduces one of
> a handful of "serious" kernel taints.  I mask on a few taint
> values because using an out of tree module or a non-GPL module
> should never fail a test, for example.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> Tested by modifying tests/generic/001 to modprobe a "staging"
> driver, and adding the staging taint bit (1024) to the mask.
> 
> V2: fail test by modifying the test output so the golden
> output check will fail, per dchinner's suggestion.
> 
> diff --git a/check b/check
> index a79747e..7ba6696 100755
> --- a/check
> +++ b/check
> @@ -446,6 +446,11 @@ do
>  	fi
>  	rm -f core $seqres.notrun
>  
> +	if [ "$HOSTOS" == "Linux" ]; then
> +		tainted=`sysctl -n kernel.tainted`
> +		let "tainted &= $TAINT_FAIL"
> +	fi
> +
>  	start=`_wallclock`
>  	$timestamp && echo -n "	["`date "+%T"`"]"
>  	[ ! -x $seq ] && chmod u+x $seq # ensure we can run it
> @@ -458,6 +463,19 @@ do
>  	_fix_malloc <$tmp.rawout >$tmp.out
>  	rm -f $tmp.rawout
>  
> +	# See if this run tainted the kernel due to oops, etc
> +	# If so, break the test via the golden output file
> +	if [ "$HOSTOS" == "Linux" ]
> +	then
> +		tainted2=`sysctl -n kernel.tainted`
> +		let "tainted2 &= $TAINT_FAIL"
> +		if [ "$tainted" != "$tainted2" ]
> +		then
> +			echo " Kernel taint changed from $tainted to $tainted2." >> $tmp.out
> +			echo " See dmesg for details." >> $tmp.out
> +		fi
> +	fi
> +
>  	if [ -f core ]
>  	then
>  	    echo -n " [dumped core]"
> diff --git a/common/config b/common/config
> index 67c1498..6483ded 100644
> --- a/common/config
> +++ b/common/config
> @@ -82,6 +82,15 @@ export PWD=`pwd`
>  export MALLOCLIB=${MALLOCLIB:=/usr/lib/libefence.a}
>  export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
>  
> +# kernel taint values on Linux (from kernel.taint sysctl)
> +TAINT_MACHINE_CHECK=16
> +TAINT_BAD_PAGE=32
> +TAINT_DIED=128
> +TAINT_WARNING=512
> +# If a test introduces one of these taints we consider it to have failed
> +let "TAINT_FAIL=( $TAINT_MACHINE_CHECK | $TAINT_BAD_PAGE | $TAINT_DIED | $TAINT_WARNING )"
> +export TAINT_FAIL
> +
>  # $1 = prog to look for, $2* = default pathnames if not found in $PATH
>  set_prog_path()
>  {
> 
> _______________________________________________
> xfs mailing list
> xfs@oss.sgi.com
> http://oss.sgi.com/mailman/listinfo/xfs
> 
