Received: from imap.thunk.org ([74.207.234.97]:53364 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753595AbdBDFYX (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 4 Feb 2017 00:24:23 -0500
Date: Sat, 4 Feb 2017 00:24:19 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] generic: add shutdown group
Message-ID: <20170204052419.3m4stq3p6ch2rmoo@thunk.org>
References: <20170203230137.25941-1-tytso@mit.edu>
 <20170204034752.GD1859@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170204034752.GD1859@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Feb 04, 2017 at 11:47:52AM +0800, Eryu Guan wrote:
> On Fri, Feb 03, 2017 at 06:01:37PM -0500, Theodore Ts'o wrote:
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > ---
> >  tests/generic/group | 30 +++++++++++++++---------------
> >  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> I notice that there're also some xfs tests are doing shutdown, I think
> they belong to shutdown group too, e.g.
> 
> xfs/051
> xfs/079
> xfs/121
> xfs/181
> xfs/212
> 
> I can update the patch at commit time if you think it's ok.

Sure.  I should have checked the xfs tests as well, thanks.

      	       	 	     	     	 - Ted
