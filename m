Received: from imap.thunk.org ([74.207.234.97]:51956 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751525AbdCIF7C (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 9 Mar 2017 00:59:02 -0500
Date: Thu, 9 Mar 2017 00:58:59 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2] fstests: add the missing _supported_fs to tests
Message-ID: <20170309055859.ilytxmonuxm2ffem@thunk.org>
References: <20170308115410.11346-1-eguan@redhat.com>
 <20170308174257.11425-1-eguan@redhat.com>
 <20170309021050.ulpsfpznr6ajd6e5@thunk.org>
 <20170309042641.GH14226@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170309042641.GH14226@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 09, 2017 at 12:26:41PM +0800, Eryu Guan wrote:
> On Wed, Mar 08, 2017 at 09:10:50PM -0500, Theodore Ts'o wrote:
> > On Thu, Mar 09, 2017 at 01:42:57AM +0800, Eryu Guan wrote:
> > > There're many tests that are missing _supported_fs check. I first
> > > noticed this by running ext4/308 under an XFS test config by
> > > accident then realized that there might be more tests missing
> > > supported fs type check.
> > 
> > Stupid question --- I had assumed that all tests in xfs/* were
> > implicitly xfs-only and all tests in btrfs/* were implicitly
> > btrfs/only, and so on.  Is that not true?
> 
> Yes, that's true if you're not specifying tests on ./check command line.
> But ./check still tries to run the tests given on command line. e.g.
> 
> 	./check -s xfs ext4/308
> 
> This rarely happens so it's not a big issue. I just happened to hit it
> and thought it'd be better to fix it :)

If you think it's better having explicit _supported_fs lines for all
tests, I don't have any strong objections; I just wonder if it's
necessary.

Today "_supported_fs generic" is a no-op.  And I wonder if we could
just simply encoding an explicit check for FSTYP must equal the test
directory name if the directory name is not "generic" or "shared" in
the check script?

> [Off topic] BTW, does the following patch look OK to you?
> 
> [PATCH] generic: require journal in shutdown tests
> 
> It skips shutdown tests on fs without journal, e.g. ext2 driving by ext4

It looks great, thanks for sending it out.  I've sent a reviewed by
under separate cover.

					- Ted
