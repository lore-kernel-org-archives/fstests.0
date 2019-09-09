Received: from mga03.intel.com ([134.134.136.65]:6149 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfIIPda (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 9 Sep 2019 11:33:30 -0400
Date: Mon, 9 Sep 2019 08:33:29 -0700
From: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH V2 2/2] generic: Add Lease testing
Message-ID: <20190909153328.GA11186@iweiny-DESK2.sc.intel.com>
References: <20190905173026.28114-1-ira.weiny@intel.com>
 <20190905173026.28114-3-ira.weiny@intel.com>
 <20190908143257.GI2622@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908143257.GI2622@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Jeff Layton <jlayton@kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sun, Sep 08, 2019 at 10:33:12PM +0800, Eryu Guan wrote:
> On Thu, Sep 05, 2019 at 10:30:26AM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Now that we have a leasetest executable add in a lease test script.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> The new test could be merged with patch 1.

Ok, I was not sure how best to submit this.  Now I know.
> 
> > ---
> >  tests/generic/567     | 100 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/567.out |   2 +
> >  tests/generic/group   |   1 +
> >  3 files changed, 103 insertions(+)
> >  create mode 100755 tests/generic/567
> >  create mode 100644 tests/generic/567.out
> > 
> > diff --git a/tests/generic/567 b/tests/generic/567
> > new file mode 100755
> > index 000000000000..3ef99c66b207
> > --- /dev/null
> > +++ b/tests/generic/567
> > @@ -0,0 +1,100 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2019 Intel Corp.  All Rights Reserved.
> > +#
> > +# FS QA Test 567
> > +#
> > +# Test Leases
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +#debug="-d -d -d"
> > +debug=""
> 
> No need to define 'debug', if you need debug output, make 'debug' the
> default and dump all debug output to $seqres.full file.

I'll check this out.  I'm new to the harness so I was not sure what got output
where.

FWIW I think that means we can simplify leasetest even more then.  Remove all
the "debug" flags and leave stderr for error condition details.

Anyway, your comment WRT leasetest is that you would like to see locktest
"modernized" to include lease testing?  Is that correct?  If so, would you like
me to make these script modifications to 131?  Or would you like to see 2
"modes" of locktest?

I'm not convinced that overloading the parameters of the test array in locktest
is a good idea.  There are already a number of confusing overloads there.  And
leasetest is going to get some of its own which will further complicate things.
(I have added truncate tests to lease testing as well.)

> 
> > +
> > +TESTFILE=$TEST_DIR/lease_file
> > +
> > +_cleanup()
> > +{
> > +	kill $leasetest_pid2 > /dev/null 2>&1
> > +	kill $leasetest_pid1 > /dev/null 2>&1
> > +	rm -f $TESTFILE
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_test
> > +_require_test_fcntl_advisory_locks
> > +
> > +# set up log files
> > +SERVER_LOG=$TEST_DIR/server.out
> > +CLIENT_LOG=$TEST_DIR/client.out
> > +rm -f $SERVER_LOG
> > +touch $SERVER_LOG
> > +rm -f $CLIENT_LOG
> > +touch $CLIENT_LOG
> > +
> > +if [ "$debug" != "" ]; then
> > +	echo "Test directory : $TEST_DIR"
> > +	echo "Result directory : $RESULT_DIR"
> > +	echo "Client log : $CLIENT_LOG"
> > +	echo "Server log : $SERVER_LOG"
> > +fi
> > +
> > +touch $TESTFILE
> > +
> > +# Start the server
> > +src/leasetest $debug $TESTFILE 2>&1 > $SERVER_LOG &
> > +leasetest_pid1=$!
> > +
> > +timeout=30
> > +while [ $timeout -gt 0 ]; do
> > +	sleep 1
> > +
> > +	PORT=$(cat $SERVER_LOG | grep "^server port: " | awk '{print $3}')
> > +	if [ -n "$PORT" ]; then
> > +		break
> > +	fi
> > +
> > +	# check the existence of server process
> > +	if ! kill -s 0 $leasetest_pid1 >/dev/null 2>&1; then
> > +		echo "Server died abnormally"
> > +		exit 1
> > +	fi
> > +
> > +	let timeout=timeout-1
> > +done
> > +
> > +if [ -z "$PORT" ]; then
> > +	echo "Could not get server port"
> > +	exit 1
> > +fi
> 
> The whole "discovering server port" part in generic/131 has been patched
> several times in the past to fix corner cases here and there, we'd
> better to refactor this hunk into a common helper, instead of
> duplicating the code.

You mean refactor this to be common between this and the generic/131
(locktest)?

But see my comment above.

> 
> > +
> > +# Start the client
> > +src/leasetest $debug -p $PORT -h localhost $TESTFILE 2>&1 > $CLIENT_LOG
> > +leasetest_pid2=$!
> > +result=$?
> > +if [ $result -eq 0 ]; then
> > +	echo success!
> > +	status=0
> > +else
> > +	echo "Client reported failure ($result)"
> > +	cat $TEST_DIR/*.out
> > +fi
> > +
> > +if [ "$debug" != "" ]; then
> > +	echo "End file details"
> > +	ls -la $TESTFILE
> > +fi
> > +
> > +exit
> 
> echo "Silence is golden"
> src/leasetest ...
> leasetest_pid2=$!
> result=$?
> if [ $result -ne 0 ]; then
> 	echo "Server log" >> $seqres.full
> 	cat $SERVER_LOG >> $seqres.full
> 	echo "Client log" >> $seqres.full
> 	cat $CLIENT_LOG >> $seqres.full
> 	_fail "Client reported failure ($result)"
> fi
> status=0
> exit
> 
> _fail will output the failure message, which breaks the golden output,
> and prompt user to check $seqres.full file for details.

Ah ok I see.  Sorry I was not aware of $seqres.full  My bad...

I'll see if I can clean up what is really "debugging" vs not as well within
leasetest.

Thanks,
Ira

> 
> Thanks,
> Eryu
> 
> > diff --git a/tests/generic/567.out b/tests/generic/567.out
> > new file mode 100644
> > index 000000000000..dada957258fc
> > --- /dev/null
> > +++ b/tests/generic/567.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 567
> > +success!
> > diff --git a/tests/generic/group b/tests/generic/group
> > index d26c080fde30..1a48c93ff3bb 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -569,3 +569,4 @@
> >  564 auto quick copy_range
> >  565 auto quick copy_range
> >  566 auto quick quota metadata
> > +567 auto quick locks
> > -- 
> > 2.20.1
> > 
