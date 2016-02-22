Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:56336 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755494AbcBVV6E (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 22 Feb 2016 16:58:04 -0500
Date: Tue, 23 Feb 2016 08:58:01 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: xfstests configure error with xfsprogs v4.5-rc1
Message-ID: <20160222215801.GG14668@dastard>
References: <20160222030304.GV11419@eguan.usersys.redhat.com>
 <20160222032450.GF14668@dastard>
 <20160222101648.GX11419@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160222101648.GX11419@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 22, 2016 at 06:16:48PM +0800, Eryu Guan wrote:
> On Mon, Feb 22, 2016 at 02:24:50PM +1100, Dave Chinner wrote:
> > On Mon, Feb 22, 2016 at 11:03:04AM +0800, Eryu Guan wrote:
> > > Hi,
> > > 
> > > After upgrading to xfsprogs v4.5-rc1 version, xfstests failed to built
> > > because of configure error:
> > > 
> > >     checking xfs/xfs.h usability... no
> > >     checking xfs/xfs.h presence... yes
> > >     configure: WARNING: xfs/xfs.h: present but cannot be compiled
> > >     configure: WARNING: xfs/xfs.h:     check for missing prerequisite headers?
> > >     configure: WARNING: xfs/xfs.h: see the Autoconf documentation
> > >     configure: WARNING: xfs/xfs.h:     section "Present But Cannot Be Compiled"
> > >     configure: WARNING: xfs/xfs.h: proceeding with the compiler's result
> > >     checking for xfs/xfs.h... no
> > >     
> > >     FATAL ERROR: cannot find a valid <xfs/xfs.h> header file.
> > >     Run "make install-qa" from the xfsprogs source.
> > > 
> > > and config.log showed:
> > > 
> > >     configure:4543: checking xfs/xfs.h usability
> > >     configure:4543: ccache gcc -c -g -O2  conftest.c >&5
> > >     In file included from /usr/include/xfs/xfs.h:37:0,
> > >     		 from conftest.c:73:
> > >     /usr/include/xfs/linux.h:145:1: error: unknown type name 'off64_t'
> > >      typedef off64_t  xfs_off_t;
> > >      ^
> > >     configure:4543: $? = 1
> > 
> > That would seem like a system library problem in that it doesn't
> > define off64_t through stdio.h. What distro are you compiling on?
> > Also,  if you set _GNU_SOURCE, does it then compile? e.g. see
> > m4/package_libcdev.m4 for how to test whether code compiles under
> > certain defines.
> > 
> > If it does compile with _GNU_SOURCE being set, then all that needs
> > to be is to update the autoconf rule.
> 
> Yes, it compiles with _GNU_SOURCE being set. And it turns out that not
> only the check for xfs.h needs _GNU_SOURCE, many other checks need it
> too, like libxfs.h, xfs_log_format.h, xlog_assign_lsn, xqm.h and xfsctl.
> 
> Attached file is updates I made to autoconf rules, as I'm not familiar
> with autotools, I'm not sure if it's a proper fix, but it does work for
> me, with both old and new version of xfsprogs.

Yup, works here too, and is cleaner than the hack I did late
yesterday afternoon. Thanks, Eryu!

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
