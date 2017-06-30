Received: from mx1.redhat.com ([209.132.183.28]:39936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbdF3ESJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 30 Jun 2017 00:18:09 -0400
Date: Fri, 30 Jun 2017 12:18:06 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] common: remove tmp.mkfs[err/std] files by name
Message-ID: <20170630041806.GY23360@eguan.usersys.redhat.com>
References: <20170626134017.2741-1-ddiss@suse.de>
 <20170626134017.2741-2-ddiss@suse.de>
 <20170627043304.GW23360@eguan.usersys.redhat.com>
 <20170627115522.0259323d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170627115522.0259323d@suse.de>
Sender: fstests-owner@vger.kernel.org
To: David Disseldorp <ddiss@suse.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 27, 2017 at 11:55:22AM +0200, David Disseldorp wrote:
> On Tue, 27 Jun 2017 12:33:04 +0800, Eryu Guan wrote:
> 
> > I posted a patch back in Jan. to cleanup tmp files and other leftover
> > files after test, I switched from mktemp to a normal "tmp=/tmp/$$._mkfs"
> > assignment so it could avoid this problem you want to fix too. But my
> > patch got no review.
> > 
> > I'm going to send new version of my patch and will fix _scratch_do_mkfs
> > too, I really appreciate if you could help review and provide
> > Reviewed-by tag.
> 
> Thanks for the feedback, Eryu. My preference would be to continue to use
> mktemp. I know it's test code, but I'd still like to avoid any potential
> symlink races.
> 
> Cheers, David

mktemp doesn't really help in this case. What we do in _scratch_do_mkfs
is like:

	local tmp=`mktemp`
	....
	eval "$mkfs_cmd ..." > $tmp.mkfsstd

$tmp is not used directly as a tmp file, it just serves as a common
prefix, $tmp._any_suffix_ can be a symlink too. (BTW, remove only
$tmp.mkfsstd and $tmp.mkfserr leaves $tmp itself in /tmp).

And I don't think it's that necessary to avoid potential symlink races
in fstests, the "tmp=/tmp/$$ then write to $tmp.file" usage is almost
everywhere in fstests. I agree it'd be great to avoid symlink races, but
IMHO it's not worth the effort to make whole fstests symlink-race-free.

Thanks,
Eryu
