Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:41073 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751422AbbDONAL (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 15 Apr 2015 09:00:11 -0400
Date: Wed, 15 Apr 2015 23:00:08 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] Fix caller's argument for _require_command()
Message-ID: <20150415130008.GS13731@dastard>
References: <188af9eed150e2f7efb04b5d634a14ca50fdd694.1428899527.git.zhaolei@cn.fujitsu.com>
 <20150414214512.GR13731@dastard>
 <04b901d07777$a92c2300$fb846900$@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04b901d07777$a92c2300$fb846900$@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Zhao Lei <zhaolei@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 15, 2015 at 08:28:21PM +0800, Zhao Lei wrote:
> Hi, Dave Chinner
> 
> > -----Original Message-----
> > From: Dave Chinner [mailto:david@fromorbit.com]
> > Sent: Wednesday, April 15, 2015 5:45 AM
> > To: Zhaolei
> > Cc: fstests@vger.kernel.org
> > Subject: Re: [PATCH v2] Fix caller's argument for _require_command()
> > 
> > On Mon, Apr 13, 2015 at 12:32:43PM +0800, Zhaolei wrote:
> > > From: Zhao Lei <zhaolei@cn.fujitsu.com>
> > >
> > > _require_command() only accept 2 arguments, first one is pure command,
> > > and second one is name for error message.
> > >
> > > But some caller misused this function, for example,
> > >   DEFRAG_PROG="$BTRFS_UTIL_PROG filesystem defragment"
> > >   _require_command $DEFRAG_PROG defragment In above code,
> > > _require_command get 4 arguments, the caller's second argument is
> > > never used, and the second field of first argument is treat as "error
> > > message" in _require_command.
> > >
> > > We fixed above case by adding quotes to _require_command()'s
> > > arguments, it fixed most test case, but introduced a new bug, in above
> > > case, "btrfs filesystem defragment" is not a command, and always
> > > failed in _require_command(), it caused some testcase not work, as
> > > btrfs/005.
> > >
> > > This patch fixed above caller.
> > >
> > > Changelog v1->v2:
> > > 1: Add detail description, suggested by:
> > >    Lukáš Czerner <lczerner@redhat.com>
> > > 2: Add missed Reported-by.
> > > 3: Make $XFSDUMP_PROG always be a pure command, to avoid special
> > >    handling for it.
> > 
> > Having to change xfsdump checks means this is still the wrong fix.
> > 
> > _require_command should simply handle multi-part command strings.
> > 
> > Does the following patch fix your problems?
> > 
> This patch can deal with current code, only can't deal with program with blank in filename.
> But this is rarely happened, so we need not care about it.

It will work just fine with a minor tweak:

$ [ -x /bin/true ] && echo foo
foo
$ [ -x "" ] && echo foo
$

i.e. the -x check fails as expected when passed an empty command.

> > +	if [ ! -x $command ]; then

i.e this needs changing to [ ! -x "$command" ]....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
