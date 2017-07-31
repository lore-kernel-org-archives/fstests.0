Received: from mx1.redhat.com ([209.132.183.28]:58860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751596AbdGaB6A (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 30 Jul 2017 21:58:00 -0400
Date: Mon, 31 Jul 2017 09:57:58 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH, V2] xfstests: fail test if it causes a kernel taint
Message-ID: <20170731015758.GG9167@eguan.usersys.redhat.com>
References: <51916146.80308@redhat.com>
 <519E3A20.7060102@sandeen.net>
 <af8df1f2-dd68-b412-2276-5f6e89d28507@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af8df1f2-dd68-b412-2276-5f6e89d28507@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Hi Eric,

On Fri, Jul 28, 2017 at 11:43:40AM -0500, Eric Sandeen wrote:
> This one got lost in the mists of time, seems like maybe still a good idea?

I took a look and tried this patch (with some tweaks to make it apply),
then realized that _check_dmesg could do most of the work now, please
see below. Please correct me if I missed anything :)

> 
> On 5/23/13 10:47 AM, Eric Sandeen wrote:
> > This modification will fail a test if it introduces one of
> > a handful of "serious" kernel taints.  I mask on a few taint
> > values because using an out of tree module or a non-GPL module
> > should never fail a test, for example.
> > 
> > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> > ---
> > 
> > Tested by modifying tests/generic/001 to modprobe a "staging"
> > driver, and adding the staging taint bit (1024) to the mask.
> > 
> > V2: fail test by modifying the test output so the golden
> > output check will fail, per dchinner's suggestion.
> > 
> > diff --git a/check b/check
> > index a79747e..7ba6696 100755
> > --- a/check
> > +++ b/check
> > @@ -446,6 +446,11 @@ do
> >  	fi
> >  	rm -f core $seqres.notrun
> >  
> > +	if [ "$HOSTOS" == "Linux" ]; then
> > +		tainted=`sysctl -n kernel.tainted`
> > +		let "tainted &= $TAINT_FAIL"
> > +	fi
> > +
> >  	start=`_wallclock`
> >  	$timestamp && echo -n "	["`date "+%T"`"]"
> >  	[ ! -x $seq ] && chmod u+x $seq # ensure we can run it
> > @@ -458,6 +463,19 @@ do
> >  	_fix_malloc <$tmp.rawout >$tmp.out
> >  	rm -f $tmp.rawout
> >  
> > +	# See if this run tainted the kernel due to oops, etc
> > +	# If so, break the test via the golden output file
> > +	if [ "$HOSTOS" == "Linux" ]
> > +	then
> > +		tainted2=`sysctl -n kernel.tainted`
> > +		let "tainted2 &= $TAINT_FAIL"
> > +		if [ "$tainted" != "$tainted2" ]
> > +		then
> > +			echo " Kernel taint changed from $tainted to $tainted2." >> $tmp.out
> > +			echo " See dmesg for details." >> $tmp.out
> > +		fi
> > +	fi
> > +
> >  	if [ -f core ]
> >  	then
> >  	    echo -n " [dumped core]"
> > diff --git a/common/config b/common/config
> > index 67c1498..6483ded 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -82,6 +82,15 @@ export PWD=`pwd`
> >  export MALLOCLIB=${MALLOCLIB:=/usr/lib/libefence.a}
> >  export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
> >  
> > +# kernel taint values on Linux (from kernel.taint sysctl)
> > +TAINT_MACHINE_CHECK=16

_check_dmesg couldn't detect machine check exception now, but I think
this can be done easily by adding "Machine Check Exception" to
_check_dmesg check list.

> > +TAINT_BAD_PAGE=32

Bad page message goes with a "BUG:" prefix, so _check_dmesg could find
this error.

> > +TAINT_DIED=128

'D' means "if the kernel has died recently, i.e. there was an OOPS or
BUG.", _check_dmesg could find these messages too.

> > +TAINT_WARNING=512

_check_dmesg could detect WARNING too, also it has the advantage that
test won't fail if the warning is expected or filtered out
intentionally, e.g. the warnings triggered by generic/095 on XFS because
of mixed direct and buffered I/O.

Thanks,
Eryu

> > +# If a test introduces one of these taints we consider it to have failed
> > +let "TAINT_FAIL=( $TAINT_MACHINE_CHECK | $TAINT_BAD_PAGE | $TAINT_DIED | $TAINT_WARNING )"
> > +export TAINT_FAIL
> > +
> >  # $1 = prog to look for, $2* = default pathnames if not found in $PATH
> >  set_prog_path()
> >  {
> > 
> > _______________________________________________
> > xfs mailing list
> > xfs@oss.sgi.com
> > http://oss.sgi.com/mailman/listinfo/xfs
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
