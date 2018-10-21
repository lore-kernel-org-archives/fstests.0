Received: from imap.thunk.org ([74.207.234.97]:42634 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbeJVGhI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 22 Oct 2018 02:37:08 -0400
Date: Sun, 21 Oct 2018 18:21:11 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: Submitting patches to xfstests based on OSDI '18 paper
 (CrashMonkey)
Message-ID: <20181021222111.GH1617@thunk.org>
References: <CA+EzBbDZ5QZPqbgicY6Ar=uroM9a0-7b8PyUBdwYGMwXgBEanw@mail.gmail.com>
 <20181021104525.GS17817@desktop>
 <CA+EzBbCd2zZ9sNW-dgyPyR5FH-HK5LArG6y+bPOCJ3Wqyp5=Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+EzBbCd2zZ9sNW-dgyPyR5FH-HK5LArG6y+bPOCJ3Wqyp5=Ug@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Jayashree Mohan <jayashree2912@gmail.com>
Cc: Eryu Guan <guaneryu@gmail.com>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sun, Oct 21, 2018 at 10:48:56AM -0500, Jayashree Mohan wrote:
> Hi Eryu,
>=20
> Thanks for the response! Will follow the template you suggested for wri=
ting
>  test cases.
>=20
> CrashMonkey generates 300 test cases, which we=E2=80=99ll convert to xf=
stest.
> Should we submit each test case as a different patch, or say 10 test ca=
ses
> per patch, or all of them in a single patch ? Let us know if there=E2=80=
=99s a
> preference.

How long does each test case take to run?  And note, by the way, that
by default we automatically run fsck on the test device after each
test.  So number one, if you use the test device, you don't need to
worry about running fsck explicitly; the xfstests check script will do
that, and fail the test if the file system is corrupted --- and number
two, this will influence whether which groups each test should be
assigned.

See the file xfstests-dev/tests/generic/group to see how groups get
assigned to tests.  I suppose all of the crashmonkey tests should be
assigned to a new group, say, "crashmonkey".  Whether or not they
should get assigned to the "auto" or "quick" group is a different
question.  Note that if running these tests will signicantly increase
the test run time of smoke tests and even the full "automatic"
regression tests, there may be some resistence in adding all of these
tests to the "auto" or "quick" groups.  Or even if you do, many file
system developers may choose to exclude all tests from the
"crashmonkey" group because if a 15 minute smoke test suddenly gets
extended to take 6 hours, developers are wont to get.... cranky.  :-)

						- Ted
