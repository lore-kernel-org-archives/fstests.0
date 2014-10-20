Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:56174 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751647AbaJTBsZ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 19 Oct 2014 21:48:25 -0400
Date: Mon, 20 Oct 2014 12:47:50 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Can't build RPM of xfstests
Message-ID: <20141020014750.GL7169@dastard>
References: <648473255763364B961A02AC3BE1060D03C7940C13@MX19A.corp.emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <648473255763364B961A02AC3BE1060D03C7940C13@MX19A.corp.emc.com>
Sender: fstests-owner@vger.kernel.org
To: "Kaul, Yaniv" <Yaniv.Kaul@emc.com>
Cc: "xfs@oss.sgi.com" <xfs@oss.sgi.com>, fstests@vger.kernel.org, esandeen@redhat.com
List-ID: <fstests@vger.kernel.org>

[ cc fstests@vger.kernel.org ]

On Sun, Oct 12, 2014 at 02:58:50AM -0400, Kaul, Yaniv wrote:
> I'm getting the sources from https://kernel.googlesource.com/pub/scm/fs/xfs/xfstests-dev (as I can't use git directly, only over HTTP(s) due to company policy)
> I'm trying to compile the RPM on either CentOS 6.5 or 7, both fail identically. Log snippets:
> 
> == dist, log is Logs/dist
> make: Entering directory `/var/jenkins/workspace/xfstests-build/build'
> /bin/tar: xfstests-1.1.1/m4/general_headers.m4: Cannot stat: No such file or directory
> /bin/tar: Exiting with failure status due to previous errors
> Wrote: /var/jenkins/workspace/xfstests-build/build/xfstests-1.1.1.src.tar.gz
> === install ===
> gmake[1]: Entering directory `/var/jenkins/workspace/xfstests-build'
> Building include
> Building lib
> Building ltp
> Building src
> Building aio-dio-regress
> Building m4
> Building common
> Building tests
> /usr/bin/gmake --no-print-directory Q=@ -C include install
> ...
> gmake[1]: Leaving directory `/var/jenkins/workspace/xfstests-build'
> === tar ===
> Wrote: /var/jenkins/workspace/xfstests-build/build/tar/xfstests-1.1.1.tar.gz
> === rpm ===
> /bin/sed -e's|@pkg_name@|xfstests|g' \
> 	    -e's|@pkg_version@|1.1.1|g' \
> 	    -e's|@pkg_release@|1|g' \
> 	    -e's|@pkg_distribution@|Linux|g' \
> 	    -e's|@build_root@|/tmp/34943|g' \
> 	    -e'/^BuildRoot: *$/d' \
> 	    -e's|@make@|/usr/bin/gmake|g' < xfstests.spec.in > xfstests.spec
> /usr/bin/rpmbuild -ba --rcfile ./rpm-4.rc xfstests.spec
> error: File /root/rpmbuild/SOURCES/xfstests-1.1.1.src.tar.gz: No such file or directory
> gmake[1]: *** [dist] Error 1

I've never tried to build xfstests packages, so I'd make the
assumption that the package build infrastructure is broken and needs
fixing.  That's looking for the tarball in the wrong place. My naive
reading of that is rpmbuild is expecting to run as root, not as a
jenkins user....

Eric, you're the local RPM expert - any ideas?

FWIW, I'll take whatever patches you guys come up with that make it
build rpms properly. ;)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
