Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38355 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730555AbfC2W5F (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Mar 2019 18:57:05 -0400
Date: Fri, 29 Mar 2019 18:56:52 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: testsuite for ACLs
Message-ID: <20190329225652.GB15757@mit.edu>
References: <CA+jMu4RO1mNKmwof8z0rU4Lcr76mPRo04a5sFrs0Saz735ez1w@mail.gmail.com>
 <20190326014337.GI26298@dastard>
 <CA+jMu4QNB+v-r6KmkUfEh-q5r=m=tCxkLkfrLXA+Ajt12g1SQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+jMu4QNB+v-r6KmkUfEh-q5r=m=tCxkLkfrLXA+Ajt12g1SQA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Rishabh Dave <ridave@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 29, 2019 at 09:29:43PM +0530, Rishabh Dave wrote:
> 
> Is tests/generic/group a list of titles of testcases? If so, I don't
> understand them.

No.  In each of the various tests folders, e.g., test/generic,
tests/ext4, tests/xfs, tests/btrfs, etc. there is a file named group.
This file tells the xfstests infrastructure which tests belong to
which groups.  The line:

026 acl quick auto

Says that the test generic/026 is in three groups, "acl", "quick", and
"auto".  The "acl" group is for tests that tests acl.  The "quick"
group is for a set of tests than run quickly, for people who want to
be able to do a quick validation that the file system is O.K.  The
"auto" group is for tests that should be used as part of an automated
regression testing which is much more comprehensive than just running
the "quick" tests.

The generic/077 test also tests acl's.  It also tests extended
attributes, and what happens when the disk fills up (enospc):

077 acl attr auto enospc


> I see there are few tests for ACLs in tests/generic/099. I couldn't
> find them before since the tests use chacl and I was looking for
> setfacl and getfacl. I'll compare my testsuite to tests/generic/099,
> create a list of testcases not covered in xfstests-dev and start
> rewriting.

You need to look at a lot more tests than just tests/generic/099.  You
need at all of the tests that belong to group "acl".  Which you can
find from looking at the files named group in the subdirectory under
the tests directory.

Cheers,

					- Ted
