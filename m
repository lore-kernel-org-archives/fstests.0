Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:36041 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756996AbaGVV47 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 22 Jul 2014 17:56:59 -0400
Date: Wed, 23 Jul 2014 07:56:57 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Problem building xfsprogs
Message-ID: <20140722215656.GQ4453@dastard>
References: <20140722160641.GU17967@beardog.cce.hp.com>
 <20140722205605.GJ20518@dastard>
 <CAK2EqxR93J8441Ajj8no7_Pu1WSDLaVsKG=_FLMYvTnOUEzKGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK2EqxR93J8441Ajj8no7_Pu1WSDLaVsKG=_FLMYvTnOUEzKGQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Martin Furuhjelm <martin.furuhjelm@seagate.com>
Cc: scameron@beardog.cce.hp.com, fstests@vger.kernel.org, xfs@oss.sgi.com
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

Perhaps it would be good to document that in the INSTALL file? Can
you write a patch to do that, please?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
