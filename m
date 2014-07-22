Return-Path: <fstests-owner@vger.kernel.org>
Received: from g9t1613g.houston.hp.com ([15.240.0.71]:44865 "EHLO
	g9t1613g.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932092AbaGVVWy (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 22 Jul 2014 17:22:54 -0400
Received: from g6t1525.atlanta.hp.com (g6t1525.atlanta.hp.com [15.193.200.68])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hp.com (Postfix) with ESMTPS id 40954618D1
	for <fstests@vger.kernel.org>; Tue, 22 Jul 2014 21:22:36 +0000 (UTC)
Date: Tue, 22 Jul 2014 16:20:42 -0500
From: scameron@beardog.cce.hp.com
Subject: Re: Problem building xfsprogs
Message-ID: <20140722212042.GF14599@beardog.cce.hp.com>
References: <20140722160641.GU17967@beardog.cce.hp.com> <20140722205605.GJ20518@dastard> <CAK2EqxR93J8441Ajj8no7_Pu1WSDLaVsKG=_FLMYvTnOUEzKGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK2EqxR93J8441Ajj8no7_Pu1WSDLaVsKG=_FLMYvTnOUEzKGQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Martin Furuhjelm <martin.furuhjelm@seagate.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, xfs@oss.sgi.com, scameron@beardog.cce.hp.com
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 22, 2014 at 03:14:42PM -0600, Martin Furuhjelm wrote:
> I have just recently gone through the process of attempting to build and
> run xfstests based on the current sources from oss.sgi.com.
> Not having exactly the correct packages and kernel version creates
> problems. The build on FEDORA fails complaining about too many symlinks, I
> was successful on SUSE V 13 updated to kernel v3.15 and adding the
> following packages before attempting git and the build:
> 
> git gcc libtool automake make gettext-tools libattr-devel libacl-devel
> libuuid-devel ncurses-devel quota indent libcap-progs btrfsprogs
> 
> I then git and built xfsprogs followed by xfsdump and finally xfstests
> 
> After adding the fsgqa group and user the appropriate definitions of
> TEST_DEV and SCRATCH_DEV the quick test (./check -g quick)
> runs with 5 errors on xfs and one error on ext4.
> 
> If you just want xfstest to run - you may want to start with SUSE and the
> procedure above.

Thanks,

Actually I want to run it with 3.16.0-rc5+ which is to say, with
Christoph Hellwig's scsi-mq.4 tree along with ~150 patches to the
hpsa driver applied on top of that.  Basically, I'm trying to
gain confidence in a fairly massive set of driver changes by testing
with xfstests (among other things, of course). 

-- steve

> 
> Martin Furuhjlem
> 
> On Tue, Jul 22, 2014 at 2:56 PM, Dave Chinner <david@fromorbit.com> wrote:
> 
> > [cc xfs@oss.sgi.com - list for XFS issues]
> >
> > On Tue, Jul 22, 2014 at 11:06:41AM -0500, scameron@beardog.cce.hp.com
> > wrote:
> > >
> > > I'm trying to build xfsprogs (in order to run xfstests), and I'm running
> > into this:
> > >
> > > [scameron@localhost xfsprogs]$ git log --oneline | head -1
> > > ba24eb7 logprint: Fix printing of AGF and AGI buffers
> > > [scameron@localhost xfsprogs]$ git pull
> > > Already up-to-date.
> > > [scameron@localhost xfsprogs]$ git diff
> > > [scameron@localhost xfsprogs]$ ./configure
> > > checking build system type... x86_64-unknown-linux-gnu
> > > checking host system type... x86_64-unknown-linux-gnu
> > > checking for gcc... gcc
> > > checking for C compiler default output file name... a.out
> > >
> > > [...snip...]
> > >
> > > checking for library containing blkid_probe_all... -lblkid
> > > checking for blkid_probe_get_topology... yes
> > > checking for readdir... yes
> > > checking size of long... 8
> > > checking size of char *... 8
> > > checking for __psint_t ... no
> > > checking for __psunsigned_t ... no
> > > checking for __u32 ... yes
> > > checking for umode_t... yes
> > > configure: creating ./config.status
> > > config.status: creating include/builddefs
> > > config.status: creating include/platform_defs.h
> > > config.status: include/platform_defs.h is unchanged
> > > config.status: executing libtool commands
> > > [scameron@localhost xfsprogs]$ make
> > > Building include
> >
> > Nothing built in the include directory - is this a clean build area?
> >
> > > Building libxfs
> > > gmake[2]: *** No rule to make target `.ltdep', needed by `ltdepend'.
> >  Stop.
> > > gmake[1]: *** [libxfs] Error 2
> > > make: *** [default] Error 2
> > >
> > > Any ideas what's wrong here?
> >
> > The automatic dependency generation failed to generate the .ltdep
> > file. But it can't be a clean build area, because the libxfs build
> > rule is:
> >
> > default: crc32selftest ltdepend $(LTLIBRARY)
> >
> > and I don't see the crc32selftest rule being executed before the
> > dependencies are generated. It shoul dlook something like:
> >
> > $ make
> > ....
> > configure: creating ./config.status
> > config.status: creating include/builddefs
> > config.status: creating include/platform_defs.h
> > config.status: executing libtool commands
> > Building include
> >     [LN]     xfs
> >     [LN]     disk
> > Building libxfs
> >     [CC]     gen_crc32table
> >     [GENERATE] crc32table.h
> >     [TEST]    CRC32
> > CRC_LE_BITS = 32
> > crc32: tests passed, 225944 bytes in 131 usec
> > crc32c: tests passed, 225944 bytes in 131 usec
> >     [CC]     cache.lo
> > ....
> >
> > So the first thing I'd do is run 'make realclean; make' to restart
> > the build for a clean workarea first. If that doesn't fix the
> > problem, then I'll need to know versions of libtool, gcc, etc that
> > you are using and you'll need to post the output of "make realclean;
> > make Q=" so we can see the command line that is actually failing.
> >
> > Cheers,
> >
> > Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at
> > https://urldefense.proofpoint.com/v1/url?u=http://vger.kernel.org/majordomo-info.html&k=2a4Akkj3oY%2FOkjwft1MTMw%3D%3D%0A&r=jY8ozfSdJMiFQxJbqMIFvF4Q5MYg6nOaolSGt082e48%3D%0A&m=bI0%2F1zZckAg2ytRBSMleHvthTKGuNDtYaUYrC%2BGOuV4%3D%0A&s=7e28774591d3b095daa0b053b597ecb5e73203b4a403132664165f44ac3aaa49
> >
