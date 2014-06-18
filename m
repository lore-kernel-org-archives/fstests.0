Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35287 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754601AbaFRSRI (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 18 Jun 2014 14:17:08 -0400
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [patch] add an aio test which closes the fd before destroying the ioctx
References: <x4961k97o9o.fsf@segfault.boston.devel.redhat.com>
	<20140610004911.GF4453@dastard>
Date: Wed, 18 Jun 2014 14:17:01 -0400
In-Reply-To: <20140610004911.GF4453@dastard> (Dave Chinner's message of "Tue,
	10 Jun 2014 10:49:11 +1000")
Message-ID: <x49k38eozfm.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: xfstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Matt Cross <matt.cross@gmail.com>
List-ID: <fstests@vger.kernel.org>

Dave Chinner <david@fromorbit.com> writes:

> Ok, so the xfstest never runs the "waitevent == 2" case here, so
> perhaps all that workaround demonstration code can be removed?

sure

>> +char *
>> +round_up_to_page(unsigned char *ptr)
>> +{
>> +  unsigned long buf = (unsigned long) ptr;
>> +
>> +  if (buf % 4096) {
>> +    buf += 4096 - buf%4096;
>> +  }
>> +
>> +  return (char *)buf;
>> +}
>
> Urk. Just use memalign() to allocate "page" aligned buffers and all
> this can go away.
>
> Also, can you change this code to 8 space tabs and generally clean
> it up to be the same as the kernel coding style? The mix of 2 space
> indents and tabs really screws up the indenting here...

Yeah.  I was just trying to keep things close to original.  I'll update
the coding style.

>> +  CPU_ZERO(&cpuset);
>> +  CPU_SET(mycpu, &cpuset);
>> +  if (sched_setaffinity(mytid, sizeof(cpuset), &cpuset)) {
>> +    printf("FAILED to set thread %d to run on cpu %ld\n", mytid, mycpu);
>> +  }
>
> Any reason why process layout like this is necessary? Comments are
> nice, even in test code...

I honestly don't remember the specifics, other than it gave a better
probability for reproducing the failure.  I can at least make a comment
stating that.

>> +	io_prep_pread(iocb, fd, round_up_to_page(buffer), sizeof(buffer) - 4096, i * (sizeof(buffer) - 4096));
>
> Is that really just for page alignment, or is there some other magic
> going on here?

Just page alignment.

> Ok, so this runs in an endless loop....
>
>> +  printf ("All threads spawned\n");
>> +
>> +  gettimeofday(&start, NULL);
>> +
>> +  while (delta.tv_sec < 300) {
>> +    sleep(1);
>> +    gettimeofday(&now, NULL);
>> +    timersub(&now, &start, &delta);
>> +    dprintf("%lu loops completed in %ld seconds\n", total_loop_count, delta.tv_sec);
>> +  }
>> +
>> +  return 0;
>
> And it just exits when the timer expires, with still active AIOs in
> flight. Which means that the tst harness may well finsih up and try
> to unmount the filesystem while IOs are still in flight. That will
> cause spurious test failures because the scratch filesystem can't be
> unmounted....

No, the exit path will block on outstanding I/Os.  By the time the
process exits, all I/O should be complete.

>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2014 Jeff Moyer.  All Rights Reserved.
>
> Sent from a Red Hat email address. Can you please clarify who owns
> the copyright?

The script is mine, the code is Matt's.  There are copyright headers in
both, and they attribute the copyright to the proper individual.  What
isn't clear about that?

>> +AIO_TEST=src/aio-dio-regress/aio-last-ref-in-irq-context
>> +if [ ! -x $AIO_TEST ]; then
>> +	_notrun "$AIO_TEST not built"
>> +fi
>
> _require_aiodio aio-last-ref-in-irq-context
>
> That also sets up the AIO_TEST variable.

ok

>> +
>> +_run_323() {
>> +	local testtemp=$TEST_DIR/aio-testfile
>
> testfile?

Are you suggesting that I rename aio-tesfile to testfile?  Or rename
testtempt to testfile?  Something else?

>> +	rm -f $testtemp
>> +	dd if=/dev/zero of=$testtemp bs=1M count=10
>
> Use xfs_io rather than dd:
>
> 	$XFS_IO_PROG -ftc "pwrite 0 10m" $testfile | _filter_xfs_io
>
> And the "-ft" options mean you don't need to rm the $testfile
> because it'll get truncated to empty first or created if it doesn't
> exist.

ok

>> +	$AIO_TEST 0 100 $testtemp
>> +	$AIO_TEST 1 100 $testtemp
>> +	status=$?
>> +	rm -f $testtemp
>
> no need to remove the test file - the $TEST_DIR is supposed to age
> with the tests that are run, so leaving scraps around is a good
> idea...
>
>> +	return $status
>> +}
>> +
>> +_run_323
>
> Like I said, no need for a function for such a simple test... 

I'm no bash guru.  I created a function in order to avoid creating a
global testtemp variable.  If that doesn't matter, I'm happen to flatten
things out.

>> +exit $status
>> diff --git a/tests/generic/323.out b/tests/generic/323.out
>> new file mode 100644
>> index 0000000..8405271
>> --- /dev/null
>> +++ b/tests/generic/323.out
>> @@ -0,0 +1,11 @@
>> +QA output created by 323
>> +10+0 records in
>> +10+0 records out
>> +wait_for_events: 0
>> +num_threads: 100
>> +filename: '/mnt/test/aio-testfile'
>
> This output needs to pass through _filter_testdir - so the $AIO_TEST
> executions need to be:
>
> 	$AIO_TEST 0 100 $testfile | _filter_test_dir

OK

Thanks for the review, Dave!

-Jeff
