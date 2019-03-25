Received: from userp2130.oracle.com ([156.151.31.86]:36966 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfCYUVA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Mar 2019 16:21:00 -0400
Date: Mon, 25 Mar 2019 13:20:53 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: testsuite for ACLs
Message-ID: <20190325202053.GB6537@magnolia>
References: <CA+jMu4RO1mNKmwof8z0rU4Lcr76mPRo04a5sFrs0Saz735ez1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+jMu4RO1mNKmwof8z0rU4Lcr76mPRo04a5sFrs0Saz735ez1w@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Rishabh Dave <ridave@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 25, 2019 at 06:48:18PM +0530, Rishabh Dave wrote:
> Hi,
> 
> I've been writing a testsuite for ACLs for CephFS[1] for some time.
> Since the testcases are written from a generic POV, reviewers asked me
> to try and get these tests merged with xfstests-dev so that it could
> benefit other projects as well.
> 
> So far, I've got around 22 testcases. To give a brief summary, the
> testsuite has 5 categories of tests: tests for nondefault nonmask
> ACLs[2], for nondefault mask ACLs[3], for default nonmask ACLs[4], for
> default mask ACLs[5] and, finally, the rest of testcases that don't
> fall into previous categories[6] (e.g. testing effect of '-k' and '-b'
> option of setfacl). The second last category is neither complete nor
> tested, but that shouldn't be a hurdle.
> 
> One important issue to address is that my testsuite is written in
> Python and xfstests-dev doesn't have any tests in Python. Although I
> don't see any guidelines in the repository instructing to not to use
> anything other than bash (and since I've never contributed to
> xfstest-dev), I think it's best to ask this explicitly: is sending a
> patch for tests in Python acceptable for xfstests-dev?

Which version of python?  mount.py in your ceph blob repo sort of
implies python 2.x ("print os.stat(...)"), which goes EOL in 9 months.

--D

> - Rishabh
> 
> [1] https://github.com/ceph/ceph/pull/26477
> [2] https://github.com/rishabh-d-dave/ceph/blob/enable-acls-by-default/qa/tasks/cephfs/test_acls.py#L270
> [3] https://github.com/rishabh-d-dave/ceph/blob/enable-acls-by-default/qa/tasks/cephfs/test_acls.py#L391
> [4] https://github.com/rishabh-d-dave/ceph/blob/enable-acls-by-default/qa/tasks/cephfs/test_acls.py#L457
> [5] https://github.com/rishabh-d-dave/ceph/blob/enable-acls-by-default/qa/tasks/cephfs/test_acls.py#L549
> [6] https://github.com/rishabh-d-dave/ceph/blob/enable-acls-by-default/qa/tasks/cephfs/test_acls.py#L609
