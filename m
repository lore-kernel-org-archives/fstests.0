Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:9232 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750976AbaLPUxh (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 16 Dec 2014 15:53:37 -0500
Date: Wed, 17 Dec 2014 07:53:19 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: e2fsprogs, xfstests git trees pushed
Message-ID: <20141216205319.GW24183@dastard>
References: <20141215193139.GA14298@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141215193139.GA14298@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

[cc fstests@vger.kernel.org]

On Mon, Dec 15, 2014 at 02:31:39PM -0500, Theodore Ts'o wrote:
> Per our concall today, I've pushed out an updated version of e2fsprogs
> to git.kernel.org.  Darrick, feel free to go ahead and rebase your
> patchbomb against the next branch.
> 
> Also, I've pushed out to github
> (https://github.com/tytso/xfstests.git) what I plan to be using for
> testing ext4 for this development cycle.  It has the latest changes
> which Dave Chinner pushed out to git.kernel.org, plus three commits
> which have all been sent to the mailing list for review:
> 
> Eryu Guan (1):
>       generic/299: various fixes
> 
> Theodore Ts'o (2):
>       common: use mke2fs -F instead of piping in yes
>       ext4/308,generic/324: require fallocate support

And now pushed upstream, so your tree needs rebasing again.

Perhaps it would be better for kvm-xfstests to follow the upstream
tree directly and work out some method of tagging the upstream tree
that gives you a defined "release point" for your image builds.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
