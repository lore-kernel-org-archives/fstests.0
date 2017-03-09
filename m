Received: from mx1.redhat.com ([209.132.183.28]:38188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750781AbdCIEeE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 8 Mar 2017 23:34:04 -0500
Date: Thu, 9 Mar 2017 12:26:41 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] fstests: add the missing _supported_fs to tests
Message-ID: <20170309042641.GH14226@eguan.usersys.redhat.com>
References: <20170308115410.11346-1-eguan@redhat.com>
 <20170308174257.11425-1-eguan@redhat.com>
 <20170309021050.ulpsfpznr6ajd6e5@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170309021050.ulpsfpznr6ajd6e5@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 08, 2017 at 09:10:50PM -0500, Theodore Ts'o wrote:
> On Thu, Mar 09, 2017 at 01:42:57AM +0800, Eryu Guan wrote:
> > There're many tests that are missing _supported_fs check. I first
> > noticed this by running ext4/308 under an XFS test config by
> > accident then realized that there might be more tests missing
> > supported fs type check.
> 
> Stupid question --- I had assumed that all tests in xfs/* were
> implicitly xfs-only and all tests in btrfs/* were implicitly
> btrfs/only, and so on.  Is that not true?

Yes, that's true if you're not specifying tests on ./check command line.
But ./check still tries to run the tests given on command line. e.g.

	./check -s xfs ext4/308

This rarely happens so it's not a big issue. I just happened to hit it
and thought it'd be better to fix it :)

[Off topic] BTW, does the following patch look OK to you?

[PATCH] generic: require journal in shutdown tests

It skips shutdown tests on fs without journal, e.g. ext2 driving by ext4

Thanks,
Eryu
