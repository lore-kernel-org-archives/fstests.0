Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:9005 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727412AbfCZBnm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Mar 2019 21:43:42 -0400
Date: Tue, 26 Mar 2019 12:43:37 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: testsuite for ACLs
Message-ID: <20190326014337.GI26298@dastard>
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

There's no support for python in fstests. The test itself still
needs the bash script to run it, set up the test environment, clean
up after the test, etc. So writing the test in python really means
"writing a test wrapper to execute a python script".

So the first question is how many of those 22 tests are already
covered by ACL tests in fstests? We've got a few tests that cover
ACLs already:

$ git grep -w acl tests/*/group
tests/generic/group:026 acl quick auto
tests/generic/group:053 acl repair auto quick
tests/generic/group:077 acl attr auto enospc
tests/generic/group:079 acl attr ioctl metadata auto quick
tests/generic/group:099 acl auto quick
tests/generic/group:105 acl auto quick
tests/generic/group:237 auto quick acl
tests/generic/group:307 auto quick acl
tests/generic/group:318 acl attr auto quick
tests/generic/group:319 acl auto quick
tests/generic/group:375 auto quick acl
tests/generic/group:389 auto quick acl
tests/generic/group:444 auto quick acl
tests/generic/group:449 auto quick acl enospc
tests/nfs/group:001 auto quick nfs4_acl acl
tests/xfs/group:053 attr acl repair quick auto
tests/xfs/group:067 acl attr auto quick

So some of the things in your test are probably already covered.

FWIW, looking at that python test script, it's jsut basically
running things like ls, touch, chown, chmod, setfacl, etc.  It's not
using python to modify and test ACLs, it's using python to run CLI
programs that modify and test acls.

eg:

   def test_acl_for_file_owner(self):
        self.setup()
        self.mount_a.run_as_root('chown %s:%s %s' % (self.currentuser, self.currentgroup, self.testdir1))
        self.mount_a.run_shell('chmod u-rwx %s' % (self.testdir1))

        # preliminary test
        self.assert_dirs_are_inaccessible(self.testdir1)

        self.mount_a.run_as_root(['setfacl', '-m', self.fo_acl, self.testdir1])
        self.assert_acls_are_present(self.fo_acl, self.testdir1)
        self.assert_dirs_are_accessible(self.testdir1)

which is basically:

fo_acl="user::rwx"
testdir1="$TEST_DIR/$seq.1"

test_acl_for_file_owner()
{
	chown $user:$group $testdir1
	_runas -u $user chmod u-rwx $testdir1
	check_inaccessible $user $testdir

	setfacl -m $fo_acl $testdir1
	check_acl $fo_acl $testdir1
	check_accessible $user $testdir1
}

It seems to me that this is much more suited to being written as a
shell script rather than in python where running CLI programs is
kinda gross. Certainly from a fstests maintenance point of view it
would be better as a bash script like everything else....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
