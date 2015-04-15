Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:33479 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751424AbbDONQJ convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 15 Apr 2015 09:16:09 -0400
From: Zhao Lei <zhaolei@cn.fujitsu.com>
References: <188af9eed150e2f7efb04b5d634a14ca50fdd694.1428899527.git.zhaolei@cn.fujitsu.com> <20150414214512.GR13731@dastard> <04b901d07777$a92c2300$fb846900$@cn.fujitsu.com> <20150415130008.GS13731@dastard>
In-Reply-To: <20150415130008.GS13731@dastard>
Subject: RE: [PATCH v2] Fix caller's argument for _require_command()
Date: Wed, 15 Apr 2015 21:15:58 +0800
Message-ID: <04ba01d0777e$4ff2ef10$efd8cd30$@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: zh-cn
Sender: fstests-owner@vger.kernel.org
To: 'Dave Chinner' <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Dave Chinner

> -----Original Message-----
> From: Dave Chinner [mailto:david@fromorbit.com]
> Sent: Wednesday, April 15, 2015 9:00 PM
> To: Zhao Lei
> Cc: fstests@vger.kernel.org
> Subject: Re: [PATCH v2] Fix caller's argument for _require_command()
> 
> On Wed, Apr 15, 2015 at 08:28:21PM +0800, Zhao Lei wrote:
> > Hi, Dave Chinner
> >
> > > -----Original Message-----
> > > From: Dave Chinner [mailto:david@fromorbit.com]
> > > Sent: Wednesday, April 15, 2015 5:45 AM
> > > To: Zhaolei
> > > Cc: fstests@vger.kernel.org
> > > Subject: Re: [PATCH v2] Fix caller's argument for _require_command()
> > >
> > > On Mon, Apr 13, 2015 at 12:32:43PM +0800, Zhaolei wrote:
> > > > From: Zhao Lei <zhaolei@cn.fujitsu.com>
> > > >
> > > > _require_command() only accept 2 arguments, first one is pure
> > > > command, and second one is name for error message.
> > > >
> > > > But some caller misused this function, for example,
> > > >   DEFRAG_PROG="$BTRFS_UTIL_PROG filesystem defragment"
> > > >   _require_command $DEFRAG_PROG defragment In above code,
> > > > _require_command get 4 arguments, the caller's second argument is
> > > > never used, and the second field of first argument is treat as
> > > > "error message" in _require_command.
> > > >
> > > > We fixed above case by adding quotes to _require_command()'s
> > > > arguments, it fixed most test case, but introduced a new bug, in
> > > > above case, "btrfs filesystem defragment" is not a command, and
> > > > always failed in _require_command(), it caused some testcase not
> > > > work, as btrfs/005.
> > > >
> > > > This patch fixed above caller.
> > > >
> > > > Changelog v1->v2:
> > > > 1: Add detail description, suggested by:
> > > >    Lukáš Czerner <lczerner@redhat.com>
> > > > 2: Add missed Reported-by.
> > > > 3: Make $XFSDUMP_PROG always be a pure command, to avoid special
> > > >    handling for it.
> > >
> > > Having to change xfsdump checks means this is still the wrong fix.
> > >
> > > _require_command should simply handle multi-part command strings.
> > >
> > > Does the following patch fix your problems?
> > >
> > This patch can deal with current code, only can't deal with program with
> blank in filename.
> > But this is rarely happened, so we need not care about it.
> 
> It will work just fine with a minor tweak:
> 
> $ [ -x /bin/true ] && echo foo
> foo
> $ [ -x "" ] && echo foo
> $
> 
> i.e. the -x check fails as expected when passed an empty command.
> 
> > > +	if [ ! -x $command ]; then
> 
> i.e this needs changing to [ ! -x "$command" ]....
> 
I means this command:
[root@ZLLINUX ~]# cp /bin/cp ./"c    p"
[root@ZLLINUX ~]# ./"c    p" --verion
cp (GNU coreutils) 8.4
...

Above file of "c    p" is a command, but can not work with
_require_command.
Not real problem, please forgot it and apply your patch:)

Thanks
Zhaolei

> Cheers,
> 
> Dave.
> --
> Dave Chinner
> david@fromorbit.com


