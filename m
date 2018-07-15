Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:18800 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbeGOGFF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 15 Jul 2018 02:05:05 -0400
Date: Sun, 15 Jul 2018 15:43:20 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: xfstests can't be installed by running make install
Message-ID: <20180715054320.GZ2234@dastard>
References: <20180711143314.GD4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <20180711163921.GI2780@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180711163921.GI2780@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 12, 2018 at 12:39:21AM +0800, Eryu Guan wrote:
> On Wed, Jul 11, 2018 at 10:33:14PM +0800, Zorro Lang wrote:
> > Hi,
> > 
> > xfstests can't be installed now, if I run "make install", it fails as [1].
> > I don't what has been changed, and I'm not really so familar with these
> > building things ... Is there anyone knows what's wrong with it? I tested
> > on Fedora 28 with GNU Make 4.2.1.
> > 
> > Thanks,
> > Zorro
> > 
> > [1]
> > # git pull
> > Already up to date.
> > # make
> > # make install
> > Building include
> > Building lib
> > Building ltp
> > Building src
> > Building log-writes
> > Building perf
> > Building aio-dio-regress
> > Building m4
> > Building common                                
> > Building tests
> > /usr/bin/gmake --no-print-directory Q=@ -C include install
> > gmake[1]: Nothing to be done for 'install'.
> > /usr/bin/gmake --no-print-directory Q=@ -C lib install
> > gmake[1]: Nothing to be done for 'install'.
> > /usr/bin/gmake --no-print-directory Q=@ -C ltp install
> > ../install-sh -o root -g root -m 755 -d /var/lib/xfstests/ltp
> > /bin/sh ../libtool --quiet --mode=install ../install-sh -o root -g root -m 755 doio fsstress fsx growfiles iogen aio-stress /var/lib/xfstests/ltp
> > ../install-sh -o root -g root -m 755 rwtest.sh /var/lib/xfstests/ltp
> > /usr/bin/gmake --no-print-directory Q=@ -C src install                           
> > Building log-writes
> > Building perf
> > Building aio-dio-regress
> > /usr/bin/gmake -C log-writes install
> > ../../install-sh -o root -g root -m 755 -d /var/lib/xfstests/src/log-writes
> > ../../install-sh -o root -g root -m 755 replay-log /var/lib/xfstests/src/log-writes
> > /usr/bin/gmake -C perf install
> > ../../install-sh -o root -g root -m 755 -d /var/lib/xfstests/src/perf
> > ../../install-sh -o root -g root -m 755 ResultData.py fio-insert-and-compare.py FioResultDecoder.py FioCompare.py generate-schema.py fio-results.sql /var/lib/xfstests/src/perf
> > /usr/bin/gmake -C aio-dio-regress install
> > ../../install-sh -o root -g root -m 755 -d /var/lib/xfstests/src/aio-dio-regress
> > ../../install-sh -o root -g root -m 755 aio-dio-fcntl-race aio-dio-subblock-eof-read aio-dio-append-write-read-race aio-dio-invalidate-readahead aio-dio-hole-filling-race aio-free-ring-with-bogus-nr-pages aio-last-ref-held-by-io aio-dio-cycle-write aio-dio-extend-stat aio-io-setup-with-nonwritable-context-pointer aio-dio-invalidate-failure aiodio_sparse2 aiocp aio-dio-cow-race aio-dio-eof-race /var/lib/xfstests/src/aio-dio-regress
> > ../install-sh -o root -g root -m 755 -d /var/lib/xfstests/src
> > /bin/sh ../libtool --quiet --mode=install ../install-sh -o root -g root -m 755 dirstress fill fill2 getpagesize holes lstat64 nametest permname randholes runas truncfile usemem mmapcat append_reader append_writer dirperf metaperf devzero feature alloc fault fstest t_access_root godown resvtest writemod writev_on_pagefault makeextents itrash rename multi_open_unlink dmiperf unwritten_sync genhashnames t_holes t_mmap_writev t_truncate_cmtime dirhash_collide t_rename_overwrite holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption t_ofd_locks t_locks_execve xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest locktest unwritten_mmap bulkstat_unlink_test bulkstat_unlink_test_modified t_dir_offset t_futimens t_immutable stale_handle pwrite_mmap_blocked t_dir_offset2 seek_sanity_test se!
 ek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec cloner renameat2 t_getcwd e4compact test-nextquota punch-alternating attr-list-by-handle-cursor-test listxattr dio-interleaved t_dir_type dio-invalidate-cache stat_test t_encrypted_d_revalidate attr_replace_test swapon mkswap fiemap-tester t_stripealign open_by_handle dbtest fssum /var/lib/xfstests/src
> > /bin/sh ../libtool --quiet --mode=install ../install-sh -o root -g root -m 755 dmerror fill2attr fill2fs fill2fs_check scaleread.sh /var/lib/xfstests/src
> > /bin/sh ../libtool --quiet --mode=install ../install-sh -o root -g root -m 644 dumpfile /var/lib/xfstests/src
> > /usr/bin/gmake --no-print-directory Q=@ -C m4 install
> > gmake[1]: Nothing to be done for 'install'.
> > /usr/bin/gmake --no-print-directory Q=@ -C common install
> > ../install-sh -o root -g root -m 755 -d /var/lib/xfstests/common
> > ../install-sh -o root -g root -m 644 * /var/lib/xfstests/common
> > /usr/bin/gmake --no-print-directory Q=@ -C tests install
> > /usr/bin/gmake --no-print-directory Q=@ -C /home/git/xfstests-dev/tests/ install
> > /usr/bin/gmake --no-print-directory Q=@ -C /home/git/xfstests-dev/tests/ install
> > /usr/bin/gmake --no-print-directory Q=@ -C /home/git/xfstests-dev/tests/ install
> > /usr/bin/gmake --no-print-directory Q=@ -C /home/git/xfstests-dev/tests/ install
> > /usr/bin/gmake --no-print-directory Q=@ -C /home/git/xfstests-dev/tests/ install
> > /usr/bin/gmake --no-print-directory Q=@ -C /home/git/xfstests-dev/tests/ install
> > ......
> > ......
> > (again and again and again ....)
> 
> This looks like a bug of make to me.
> 
> TESTS_SUBDIRS = $(sort $(dir $(wildcard $(CURDIR)/[a-z]*/)))

Is this a regression because of commit 103258a566b4 ("build: fix
install target using sudo")?

> The "wildcard" part is supposed to find all subdirs in tests dir, e.g.
> "tests/ext4 tests/generic tests/xfs ...", files shouldn't be included.
> So we get subdir list and go into each subdir and do install there.
> 
> But the same "wildcard" expression returns files too on fedora 28, e.g.
> "tests/Makefile tests/ext4 tests/generic tests/xfs ...", as a result,

Should *never* return tests/Makefile, because that does not match
the [a-z]* regex - it's a lowercase first character match, not
uppercase. And the *only* things that should be in tests/ is the
Makefile and all the test subdirs, so it shouldn't be matching the
wrong thing. i.e. how are we getting tests/ as a result in the
TESTS_SUBDIRS set?

> "tests/" is included in subdirs again, and we go to "tests/" to do
> install there again and enter a infinite loop.

Again, is this a regression? If so, we need to understand why using
$(CURDIR) is returning different results from $(PWD)/$(TESTS_DIR)/

> I can workaround the problem by appending a dot, i.e.

At this point, this seems more like hacking a bandaid over whatever
problem is occurring rather than trying to solve/understand why this
is now happening.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
