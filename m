Received: from ipmail02.adl2.internode.on.net ([150.101.137.139]:11394 "EHLO
        ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965157AbeEYBXj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 24 May 2018 21:23:39 -0400
Date: Fri, 25 May 2018 11:23:36 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Widespread test setup template problems (was Re: [PATCH]
 generic: fix cleanup function for test 490)
Message-ID: <20180525012335.GC10363@dastard>
References: <20180520184517.8826-1-tytso@mit.edu>
 <20180521024144.GO10363@dastard>
 <20180521025400.GJ29080@desktop.hz.ali.com>
 <20180525002914.GA10363@dastard>
 <20180525005940.GB10363@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525005940.GB10363@dastard>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org, jack@suse.cz
List-ID: <fstests@vger.kernel.org>

On Fri, May 25, 2018 at 10:59:40AM +1000, Dave Chinner wrote:
> On Fri, May 25, 2018 at 10:29:14AM +1000, Dave Chinner wrote:
> > On Mon, May 21, 2018 at 10:54:00AM +0800, Eryu Guan wrote:
> > > On Mon, May 21, 2018 at 12:41:44PM +1000, Dave Chinner wrote:
> > > > On Sun, May 20, 2018 at 02:45:17PM -0400, Theodore Ts'o wrote:
> > > > > generic/490 fails because cleanup tries to delete . and .. since $tmp
> > > > > is left unset, and so "rm -f $tmp.*" does nothing useful.  Instead
> > > > > delete temp files created by seek_sanity_test.
> > > > > 
> > > > > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > > > > ---
> > > > >  tests/generic/490 | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/tests/generic/490 b/tests/generic/490
> > > > > index b5042c2e..c0335ca0 100755
> > > > > --- a/tests/generic/490
> > > > > +++ b/tests/generic/490
> > > > > @@ -49,7 +49,7 @@ _require_test_program "seek_sanity_test"
> > > > >  _cleanup()
> > > > >  {
> > > > >  	cd /
> > > > > -	rm -f $tmp.*
> > > > > +	rm -f $base_test_file*
> > > > >  }
> > > > >  
> > > > >  $here/src/seek_sanity_test -s 19 -e 20 $base_test_file > $seqres.full 2>&1 ||
> > > > 
> > > > This is wrong. $tmp must always be set in a test, as the
> > > > infrastructure uses it. Failing to set $tmp will result in stray
> > > > files being spewed around the place by the test and not cleaned up.
> > > > Hence the "rm -f $tmp.*" line must stay, the normal tmp=/tmp/$$ line
> > > > added to the test preamble, and then you can remove the base test
> > > > file...
> > > 
> > > Yeah, I wanted to point that out too. So always using the './new' script
> > > is the recommended way to write new test, it already puts all the common
> > > setups (including the 'tmp=/tmp/$$' definition and 'rm -f $tmp.*'
> > > cleanup) in the test template.
> > 
> > Is there a fix committed for this yet? This bug causes the test to
> > run rm -f .* in the root directory of the machine....
> 
> BTW, in looking at what was missing from the test setup template in
> this test, I noticed that it was also missing the setup of $here,
> removal of $seqres.full, etc
> 
> SO I checked on how many tests fail to set $here, which is used in
> the common/rc test infrastructure:
> 
> $ git grep -l 'here=`pwd`' tests/ > t.t
> $ ls -1 tests/*/*[0-9] |grep -v out > tt.t
> $ diff -u t.t tt.t |grep ^+ |wc -l
> 137
> $
> 
> And, well, this is potentially very dangerous:
> 
> $ git grep -l 'tmp=/tmp/\$\$' tests/ > t.t
> $ ls -1 tests/*/*[0-9] |grep -v out > tt.t
> $ diff -u t.t tt.t |grep ^+ |wc -l
> 49
> $
> 
> A bunch of test use different tmp setups (e.g. mktemp -d, some put
> them in $TEST_DIR) but many omit it completely. They really all
> should use the same base location.
> 
> IOWs there's 137 tests that have $here incorrectly/not set up, and
> 49 tests that don't initialise $tmp like they are supposed to. A
> large number of these are relatively new tests, and the setup of
> this variable is done by the "new" test script.
> 
> So why are so many new tests missing stuff that the 'new' template
> sets up? Do we have a copy-n-paste process problem?  Should we
> abstract out this test setup preamble so people don't keep screwing
> it up?

Abstracting it out would look like the patch below. That, and moving
to SPDX tags for the licensing text, will greatly clean up the test
setup preamble. It will also draw a line in the sand for new tests -
if they don't match the new setup preamble, they don't pass
review...

Thoughts?

-Dave.
-- 
Dave Chinner
david@fromorbit.com


fstests: generic test setup preamble

From: Dave Chinner <dchinner@redhat.com>

So many tests chop random bits out of the mandaotry test setup
preamble which leads to subtle problems and stray files being dumped
all over the place. Create a common test preamble with hooks for
local cleanup functions so we can prevent this in future.

Signed-off-by: Dave Chinner <dchinner@redhat.com>

---
 common/setup_test | 22 ++++++++++++++++++++++
 new               | 24 ++++--------------------
 tests/generic/001 | 19 +++++++------------
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/common/setup_test b/common/setup_test
new file mode 100644
index 000000000000..6359ab53a8d9
--- /dev/null
+++ b/common/setup_test
@@ -0,0 +1,22 @@
+# common test setup preamble
+# test specific cleanup is done via the local_cleanup() function now.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+    local_cleanup
+    cd /
+    rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
diff --git a/new b/new
index 4eacccd3bf8b..5e7f6a3c4198 100755
--- a/new
+++ b/new
@@ -181,31 +181,15 @@ cat <<End-of-File >$tdir/$id
 #-----------------------------------------------------------------------
 #
 
-seq=\`basename \$0\`
-seqres=\$RESULT_DIR/\$seq
-echo "QA output created by \$seq"
+. common/setup_test
 
-here=\`pwd\`
-tmp=/tmp/\$\$
-status=1	# failure is the default!
-trap "_cleanup; exit \\\$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f \$tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# test exit cleanup goes here
+local_cleanup() { true }
 
 # remove previous \$seqres.full before test
 rm -f \$seqres.full
 
-# real QA test starts here
-
-# Modify as appropriate.
+# include test specific environments here
 _supported_fs generic
 _supported_os Linux
 _require_test
diff --git a/tests/generic/001 b/tests/generic/001
index 0edd41f1e2cc..e1dd2e3202e3 100755
--- a/tests/generic/001
+++ b/tests/generic/001
@@ -31,25 +31,20 @@
 #-----------------------------------------------------------------------
 #
 
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# test exit cleanup goes here
+local_cleanup() { true }
 
-tmp=/tmp/$$
-here=`pwd`
-status=1
-done_cleanup=false
-trap "_cleanup; rm -f $tmp.*; exit \$status" 0 1 2 3 15
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs generic
 _supported_os Linux
 _require_test
 
+done_cleanup=false
 verbose=true
 verify=$here/verify_fill
 
