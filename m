Received: from userp1040.oracle.com ([156.151.31.81]:29699 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbdCCRXE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Mar 2017 12:23:04 -0500
Date: Fri, 3 Mar 2017 09:21:57 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [RFC PATCH] check: try to fix the test device if it gets
 corrupted
Message-ID: <20170303172157.GA5070@birch.djwong.org>
References: <20170302232050.31125-1-tytso@mit.edu>
 <20170303090332.GP14226@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170303090332.GP14226@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 03, 2017 at 05:03:32PM +0800, Eryu Guan wrote:
> On Thu, Mar 02, 2017 at 06:20:50PM -0500, Theodore Ts'o wrote:
> > If the test device gets corrupted all subsequent tests will fail.  To
> > prevent this from causing all subsequent tests to be useless, try
> > repair the file system on TEST_DEV if possible.  We don't need to do
> > this with the scratch device since that file system gets recreated
> > each time anyway.
> > 
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > ---
> > 
> > This is a quick hack that I needed while debubgging some research
> > code[1].  It turns out that when the grad student is up against a
> > paper deadline is an, this becomes amazing evolutionary process which
> > creates file system modifications which are optimized for running
> > postmark and file bench --- and falls over very easily otherwise.  So
> > when TEST_DEV is getting corrupted very frequently, it's nice to be
> > able to continue running other tests in the quick or auto group.
> > 
> > So please consider this a proof-concept-patch; would people consider
> > it worthwhile to have this in xfstests upstream?
> 
> This idea looks reasonable to me, and TEST_DEV is supposed to be aging,
> perhaps being currupted & repaired is kind of aging too :)

<shrug> The test device isn't supposed to get corrupted, since it (at
least in theory) should be an old filesystem.  That said, I suppose
there's little point in banging around with a corrupt test fs.  Maybe we
could go further and stop running if there's unfixable corruption?

--D

> 
> Thanks,
> Eryu
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
