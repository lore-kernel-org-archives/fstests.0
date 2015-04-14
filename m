Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:17708 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932100AbbDNVNY (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 14 Apr 2015 17:13:24 -0400
Date: Wed, 15 Apr 2015 07:13:08 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] Fix caller's argument for _require_command()
Message-ID: <20150414211308.GQ13731@dastard>
References: <188af9eed150e2f7efb04b5d634a14ca50fdd694.1428899527.git.zhaolei@cn.fujitsu.com>
 <20150413055709.GQ16808@dhcp-13-216.nay.redhat.com>
 <02ac01d075b4$a36e9200$ea4bb600$@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02ac01d075b4$a36e9200$ea4bb600$@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Zhao Lei <zhaolei@cn.fujitsu.com>
Cc: 'Eryu Guan' <eguan@redhat.com>, fstests@vger.kernel.org, =?utf-8?B?J0x1a8OhxaE=?= Czerner' <lczerner@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 13, 2015 at 02:39:48PM +0800, Zhao Lei wrote:
> > From: Eryu Guan [mailto:eguan@redhat.com]
> > Sent: Monday, April 13, 2015 1:57 PM
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
.....
> > > diff --git a/common/rc b/common/rc
> > > index c1a50f2..02ac02a 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -2923,9 +2923,6 @@ init_rc()
> > >  		$DF_PROG $TEST_DEV
> > >  		exit 1
> > >  	fi
> > > -	# Figure out if we need to add -F ("foreign", deprecated) option to xfs_io
> > > -	xfs_io -c stat $TEST_DIR 2>&1 | grep -q "is not on an XFS filesystem" && \
> > > -	export XFS_IO_PROG="$XFS_IO_PROG -F"
> > 
> > I think we should keep the "-F" option, as xfs_io comes with distrobutions like
> > RHEL6 still needs "-F" to proceed on non-xfs fs.
> > 
> > [root@dhcp-66-86-3 xfstests]# xfs_io -f -c "pwrite 0 1k" testfile
> > xfs_io: specified file ["testfile"] is not on an XFS filesystem
> > 
> I keep -F in v1, and v2 deleted above -F support by suggestion of
> Lukáš Czerner <lczerner@redhat.com>, who is also author of
> these code block.
> 
> CC: Lukáš Czerner <lczerner@redhat.com>
> 
> If we suppose xfstests always runs in, and test newest kernel and user tools,
> we can remove obsoleted commands.

No, absolutely not. xfstests needs to run on all sorts of different
kernels and systems, including old vendor kernels. That means
dropping compatibility support for them is not an option until their
QA departments are no longer testing those distros. IOWs, it's going
to be many years before we can drop the "-F" option....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
