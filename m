Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:47500 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750759AbaI0ArP (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 26 Sep 2014 20:47:15 -0400
Date: Sat, 27 Sep 2014 10:47:11 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Performance testing
Message-ID: <20140927004711.GJ4758@dastard>
References: <1410943724.31777.31.camel@jtulak>
 <20140918003628.GX4322@dastard>
 <1411657420.26791.48.camel@jtulak>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <1411657420.26791.48.camel@jtulak>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
List-ID: <fstests@vger.kernel.org>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2014 at 05:03:40PM +0200, Jan Tulak wrote:
> On Thu, 2014-09-18 at 10:36 +1000, Dave Chinner wrote:
> > On Wed, Sep 17, 2014 at 10:48:44AM +0200, Jan Tulak wrote:
> > > Hi,
> > > 
> > > I have began to work on some set of performance tests. I think it would
> > > be useful to have some standard set, because as far as I know, there is
> > > just little of performance testing and every of the few tests someone
> > > does is unique. I want to propose my ideas before I start to really
> > > write it, to fix possible complications.
> > 
> > Great idea, but I'm missing some context about your ultimate goal
> > here: how is this performance testing going to be used?
> > 
> > My focus for xfstests is mainly for it to be useful to filesystem
> > developers who are developing new features and fixing bugs, so my
> > comments come from the point of view of "will it make my life as a
> > filesystem developer easier?" rather than a "we have need a
> > performance test suites" perspective.
> 
> I think there is a place for two kinds of these tests. One is a quick
> suite that should not run for more than few minutes and can be used
> whenever sending a patch (or on daily basis...) for a quick check, to
> catch bad things as soon as possible. 
> 
> The other set would be for deeper and more complex and used rather
> between versions than single patches. This one maybe could be
> independent, but for consistency, I think it is better to keep both sets
> together.

I'm not yet convinced, but keep talking ;)

> > > From the beginning there would be some basic test cases, like sync/async
> > > read and write. Hopefully more natural cases, like a database server
> > > would be added later.
> > 
> > IMO, if we do add performance tests to xfstests, then the focus
> > would definitely need to be on performance regression tests, not
> > "performance benchmark" (aka benchmarketing) tests. If you want
> > "performance benchmarks" then openbenchmarking.org is probably a
> > better place to start as that is what it is designed for and
> > already has everything you've mentioned.
> > 
> > So I'll focus on performance regression testing. Performance
> > regression testing involves a lot more than just "run benchmark,
> > save and compare results". It's once the "compare results" phase
> > says "regression found" that the functionality of the test really
> > matters to the filesystem develper. i.e. the tests need to be useful
> > for *analysis of the regression*.
> > 
> > Hence things like "database server benchmark" don't really belong in
> > a performance regression test suite because they can't be used to
> > isolate regressions. Further, they tend to be susceptible to changes
> > in performance being caused by changes outside filesystem and
> > storage layers. Hence they lead to wild goose chases more often than
> > they point to a real filesystem or IO regression.
> > 
> This is not needed in the quick suite, but just testing simple
> read/write will not find regression appearing during some more
> complicated situations. If the only thing changed is the filesystem,
> any big difference in results can be attributed to the filesystem
> change. Right? 

No. A change in a filesystem can causing things like more context
switches to occur due to additional serialisation on a sleeping
lock. A change of context switch behaviour can expose issuing in
other subsystems, like the scheduler or even bugs in the locking
code. This happens more frequently than you think...

> I do not expect everyone will run this test suite all
> day, but it could notice us about regressions between versions of a
> filesystem.

It's rare that developers run tests directly comparing released
versions of the kernel. We'll compare "unpatched vs patched" in
back-to-back tests, so the tests we do run need to be cover a good
portion of the performance matrix in a useful fashion....

> > > For the IO testing, I want to use FIO for the
> > > specific workflow and eventually iozone for the basic synthetic tests.
> > 
> > I think that the initial focus for performance regression tests
> > would need to be more on simple micro-benchmarks (e.g. read, write,
> > create, remove, etc).  I'd much prefer to see simple, targeted
> > benchmarks that are easily understood jus tby looking at the
> > xfstests code. e.g.  a patchset made unlink go fast, but slowed down
> > file create. Or that we sped up single threaded creates, but
> > destroyed multithreaded create scalability. Or that we sped up small
> > directories at the expense of large directories.  These things
> > can all be measured individually (and quickly) and because they
> > tend to measure a single aspect of filesystem performance they
> > can be used directly for regression analysis.
> > 
> > Many of these sorts of tests can be written into the existing
> > xfstests infrastructure without needing significant external
> > dependencies - fio and fsmark cover most of the microbenchmarks that
> > would be necessary. I already have quite a few scripts that I use to
> > run fsmark tests that could easily be wrapped with xfstests
> > templates....
> 
> The initial focus should really aim at this, I agree. Creating this
> quick and small suite should not take a long time. If you have
> something, that could be useful once I will create some kind of template
> for performance tests.

I've attached an example script I use to run a file creation
micro-benchmark.

What is important here is that once the files are created, I then
run several more performance tests on the filesystem - xfs_repair
performance, bulkstat performance, find and ls -R performance, and
finally unlink performance.

So it's really 5 or 6 tests in one. We are going to need to be able
to support such "sub-test" categories so that we don't waste lots of
time having to create filesystem pre-conditions for various
micro-benchmarks. Any ideas on how we could group tests like this
so they are run sequentially as a group, but also can be run
individually and correctly invking the setup test if the filesystem
is not in the correct state?

> > > What I'm not sure is how a comparison between different versions could
> > > be done, because I don't see any infrastructure within fstests for
> > > cross-version comparison. (What would it do with regression tests
> > > anyway...) So I wonder if it should be done in this set at all. So the
> > > set would only print the measured values. Some other tool (which can be
> > > also included, but is not directly part of the performance tests set)
> > > could then be used to compare and/or plot graphs.
> > 
> > I don't think that storing results long term or comparing results is
> > something xfstests should directly care about. It is architected to
> > defer that to some external tool for post processing.  i.e. xfstests
> > is used to run the tests and generate results, not do long term
> > storage or analysis of those results.
> > 
> > I see no issues with including scripts to do result processing
> > across multiple RESULT_DIRs within xfstests itself, but the
> > infrastructure still has to be architected so it can be externally
> > controllable and usable by external test infrastructure.
> 
> I expected something like this, so it shouldn't be a big trouble. What I
> see as a good way: at first to create some small tests. Then, once they
> works as intended, I can work on the external tool for managing the
> results, rather than at first creating the tool. That will also give me
> more time to find some good solution. (What I see, there is already some
> work with autotest running xfstest, so maybe it will needs just a little
> work to add the new tests.)

Yes, that seems like the sensible approach to take.

FWIW, I'm pretty sure most developers run xfstests directly, so I'd
concentrate on making reporting work well for this case first, then
concentrate on what extra functionality external harnesses like
autotest require....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com


--2oS5YaxWCcQjTEyO
Content-Type: application/x-sh
Content-Disposition: attachment; filename="fsmark-50-test-xfs.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0AQUOTA=3D=0AMKFSOPTS=3D=0ANFILES=3D100000=0ADEV=3D/dev/vdc=
=0ALOGBSIZE=3D256k=0A=0Awhile [ $# -gt 0 ]; do=0A	case "$1" in=0A	-q)	QUOTA=
=3D"uquota,gquota,pquota" ;;=0A	-N)	NFILES=3D$2 ; shift ;;=0A	-d)	DEV=3D$2 =
; shift ;;=0A	-l)	LOGBSIZE=3D$2; shift ;;=0A	--)	shift ; break ;;=0A	esac=
=0A	shift=0Adone=0AMKFSOPTS=3D"$MKFSOPTS $*"=0A=0Aecho QUOTA=3D$QUOTA=0Aech=
o MKFSOPTS=3D$MKFSOPTS=0Aecho DEV=3D$DEV=0A=0Asudo umount /mnt/scratch > /d=
ev/null 2>&1=0A#sudo mkfs.xfs -f $MKFSOPTS -l size=3D131072b,sunit=3D8 /dev=
/vdc=0A#sudo mkfs.xfs -f $MKFSOPTS -l size=3D131072b $DEV=0Asudo mkfs.xfs -=
f $MKFSOPTS $DEV=0Asudo mount -o nobarrier,logbsize=3D$LOGBSIZE,$QUOTA $DEV=
 /mnt/scratch=0Asudo chmod 777 /mnt/scratch=0Acd /home/dave/src/fs_mark-3.3=
/=0Asudo sh -c "echo 1 > /proc/sys/fs/xfs/stats_clear"=0Atime ./fs_mark  -D=
  10000  -S0  -n  $NFILES  -s  0  -L  32 \=0A	-d  /mnt/scratch/0  -d  /mnt/=
scratch/1 \=0A	-d  /mnt/scratch/2  -d  /mnt/scratch/3 \=0A	-d  /mnt/scratch=
/4  -d  /mnt/scratch/5 \=0A	-d  /mnt/scratch/6  -d  /mnt/scratch/7 \=0A	-d =
 /mnt/scratch/8  -d  /mnt/scratch/9 \=0A	-d  /mnt/scratch/10  -d  /mnt/scra=
tch/11 \=0A	-d  /mnt/scratch/12  -d  /mnt/scratch/13 \=0A	-d  /mnt/scratch/=
14  -d  /mnt/scratch/15 \=0A	| tee >(stats --trim-outliers | tail -1 1>&2)=
=0Async=0Aecho -n "Cache hit rate: "=0Aawk '/buf/ { print $11 / ($11 + $12)=
 }' /proc/fs/xfs/stat=0Asudo sh -c "echo 1 > /proc/sys/fs/xfs/stats_clear"=
=0A=0Aecho Repair=0Asudo umount /mnt/scratch=0Atime sudo xfs_repair -v -v -=
o bhash=3D32768 -t 1 $DEV=0Atime sudo mount -o nobarrier,logbsize=3D$LOGBSI=
ZE,$QUOTA $DEV /mnt/scratch=0A=0Aecho bulkstat files=0A=0Atime (=0A	sudo ~/=
src/xfstests-dev/src/bstat -t -q /mnt/scratch 1024 > /dev/null=0A)=0Aecho -=
n "Cache hit rate: "=0Aawk '/buf/ { print $11 / ($11 + $12) }' /proc/fs/xfs=
/stat=0Asudo sh -c "echo 1 > /proc/sys/fs/xfs/stats_clear"=0A=0Aecho walkin=
g files=0A~/tests/walk-scratch.sh=0A=0Aecho removing files=0Afor f in /mnt/=
scratch/* ; do time rm -rf $f &  done=0Await=0Aecho -n "Cache hit rate: "=
=0Aawk '/buf/ { print $11 / ($11 + $12) }' /proc/fs/xfs/stat=0Asudo sh -c "=
echo 1 > /proc/sys/fs/xfs/stats_clear"=0A
--2oS5YaxWCcQjTEyO
Content-Type: application/x-sh
Content-Disposition: attachment; filename="walk-scratch.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0Asudo sh -c "echo 1 > /proc/sys/fs/xfs/stats_clear"=0Aecho =
Walking via find -ctime=0Asudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'=0A=
time (=0A        for d in /mnt/scratch/[0-9]* ; do=0A=0A                for=
 i in $d/*; do=0A                        (=0A                              =
  echo $i=0A                                find $i -ctime 1 > /dev/null=0A=
                        ) > /dev/null 2>&1=0A                done &=0A     =
   done=0A        wait=0A)=0Aecho -n "Cache hit rate: "=0Aawk '/buf/ { prin=
t $11 / ($11 + $12) }' /proc/fs/xfs/stat=0Asudo sh -c "echo 1 > /proc/sys/f=
s/xfs/stats_clear"=0A=0Aecho Walking via ls -R=0Asudo sh -c 'echo 3 > /proc=
/sys/vm/drop_caches'=0Atime (=0A        for d in /mnt/scratch/[0-9]* ; do=
=0A=0A                for i in $d/*; do=0A                        (=0A     =
                           echo $i=0A                                ls -R =
$i=0A                        ) > /dev/null 2>&1=0A                done &=0A=
        done=0A        wait=0A)=0Aecho -n "Cache hit rate: "=0Aawk '/buf/ {=
 print $11 / ($11 + $12) }' /proc/fs/xfs/stat=0Asudo sh -c "echo 1 > /proc/=
sys/fs/xfs/stats_clear"=0A=0A
--2oS5YaxWCcQjTEyO--
