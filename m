Received: from imap.thunk.org ([74.207.234.97]:35628 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753644AbdBEUKI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 5 Feb 2017 15:10:08 -0500
Date: Sun, 5 Feb 2017 15:09:54 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/3] generic: honor the FSSTRESS_AVOID environment
 variable
Message-ID: <20170205200954.wrqp6fdsvcohlcjn@thunk.org>
References: <20170205065336.14994-1-tytso@mit.edu>
 <CAOQ4uxisNW+zew4NgKtykJQs8dcC==u1rMvWVZwH=Mnp7r0SkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxisNW+zew4NgKtykJQs8dcC==u1rMvWVZwH=Mnp7r0SkA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sun, Feb 05, 2017 at 10:02:03AM +0200, Amir Goldstein wrote:
> On Sun, Feb 5, 2017 at 8:53 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> > Make sure all tests which run fsstress, and which do not have a very
> > specific custom profile of which file system operations to run,
> 
> Can you elaborate about this criteria?
> Specifically, what about overlay/019? and several other {xfs,btrfs}/* stress
> tests. Why do they not qualify?

I didn't bother looking at the tests beyond tests/generic, sorry.

The general criteria I used is that fstress invocation didn't specify
any -f options, then I would definitely add a $FSSTRESS_AVOID.  If
there was a large number of -f options, then definitely don't add
$FSSTRESS_AVOID.  If there are only 2 or 3 -f options, then I'd
probably add $FSSTRESS_AVOID but it's more of a test by test basis.

	     		     	      	   - Ted
