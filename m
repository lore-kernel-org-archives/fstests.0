Received: from mail-pl0-f44.google.com ([209.85.160.44]:42613 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388264AbeGKQog (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Jul 2018 12:44:36 -0400
Received: by mail-pl0-f44.google.com with SMTP id f4-v6so5202703plb.9
        for <fstests@vger.kernel.org>; Wed, 11 Jul 2018 09:39:27 -0700 (PDT)
Date: Thu, 12 Jul 2018 00:39:21 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: xfstests can't be installed by running make install
Message-ID: <20180711163921.GI2780@desktop>
References: <20180711143314.GD4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180711143314.GD4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 11, 2018 at 10:33:14PM +0800, Zorro Lang wrote:
> Hi,
>=20
> xfstests can't be installed now, if I run "make install", it fails as [1].
> I don't what has been changed, and I'm not really so familar with these
> building things ... Is there anyone knows what's wrong with it? I tested
> on Fedora 28 with GNU Make 4.2.1.
>=20
> Thanks,
> Zorro
>=20
> [1]
> # git pull
> Already up to date.
> # make
> # make install
> Building include
> Building lib
> Building ltp
> Building src
> Building log-writes
> Building perf
> Building aio-dio-regress
> Building m4
> Building common                               =20
> Building tests
> /usr/bin/gmake --no-print-directory Q=3D@ -C include install
> gmake[1]: Nothing to be done for 'install'.
> /usr/bin/gmake --no-print-directory Q=3D@ -C lib install
> gmake[1]: Nothing to be done for 'install'.
> /usr/bin/gmake --no-print-directory Q=3D@ -C ltp install
> ../install-sh -o root -g root -m 755 -d /var/lib/xfstests/ltp
> /bin/sh ../libtool --quiet --mode=3Dinstall ../install-sh -o root -g root=
 -m 755 doio fsstress fsx growfiles iogen aio-stress /var/lib/xfstests/ltp
> ../install-sh -o root -g root -m 755 rwtest.sh /var/lib/xfstests/ltp
> /usr/bin/gmake --no-print-directory Q=3D@ -C src install                 =
         =20
> Building log-writes
> Building perf
> Building aio-dio-regress
> /usr/bin/gmake -C log-writes install
> ../../install-sh -o root -g root -m 755 -d /var/lib/xfstests/src/log-writ=
es
> ../../install-sh -o root -g root -m 755 replay-log /var/lib/xfstests/src/=
log-writes
> /usr/bin/gmake -C perf install
> ../../install-sh -o root -g root -m 755 -d /var/lib/xfstests/src/perf
> ../../install-sh -o root -g root -m 755 ResultData.py fio-insert-and-comp=
are.py FioResultDecoder.py FioCompare.py generate-schema.py fio-results.sql=
 /var/lib/xfstests/src/perf
> /usr/bin/gmake -C aio-dio-regress install
> ../../install-sh -o root -g root -m 755 -d /var/lib/xfstests/src/aio-dio-=
regress
> ../../install-sh -o root -g root -m 755 aio-dio-fcntl-race aio-dio-subblo=
ck-eof-read aio-dio-append-write-read-race aio-dio-invalidate-readahead aio=
-dio-hole-filling-race aio-free-ring-with-bogus-nr-pages aio-last-ref-held-=
by-io aio-dio-cycle-write aio-dio-extend-stat aio-io-setup-with-nonwritable=
-context-pointer aio-dio-invalidate-failure aiodio_sparse2 aiocp aio-dio-co=
w-race aio-dio-eof-race /var/lib/xfstests/src/aio-dio-regress
> ../install-sh -o root -g root -m 755 -d /var/lib/xfstests/src
> /bin/sh ../libtool --quiet --mode=3Dinstall ../install-sh -o root -g root=
 -m 755 dirstress fill fill2 getpagesize holes lstat64 nametest permname ra=
ndholes runas truncfile usemem mmapcat append_reader append_writer dirperf =
metaperf devzero feature alloc fault fstest t_access_root godown resvtest w=
ritemod writev_on_pagefault makeextents itrash rename multi_open_unlink dmi=
perf unwritten_sync genhashnames t_holes t_mmap_writev t_truncate_cmtime di=
rhash_collide t_rename_overwrite holetest t_truncate_self t_mmap_dio af_uni=
x t_mmap_stale_pmd t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_=
ro t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption t_ofd_locks t=
_locks_execve xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader p=
reallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest locktest unwr=
itten_mmap bulkstat_unlink_test bulkstat_unlink_test_modified t_dir_offset =
t_futimens t_immutable stale_handle pwrite_mmap_blocked t_dir_offset2 seek_=
sanity_test seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec clon=
er renameat2 t_getcwd e4compact test-nextquota punch-alternating attr-list-=
by-handle-cursor-test listxattr dio-interleaved t_dir_type dio-invalidate-c=
ache stat_test t_encrypted_d_revalidate attr_replace_test swapon mkswap fie=
map-tester t_stripealign open_by_handle dbtest fssum /var/lib/xfstests/src
> /bin/sh ../libtool --quiet --mode=3Dinstall ../install-sh -o root -g root=
 -m 755 dmerror fill2attr fill2fs fill2fs_check scaleread.sh /var/lib/xfste=
sts/src
> /bin/sh ../libtool --quiet --mode=3Dinstall ../install-sh -o root -g root=
 -m 644 dumpfile /var/lib/xfstests/src
> /usr/bin/gmake --no-print-directory Q=3D@ -C m4 install
> gmake[1]: Nothing to be done for 'install'.
> /usr/bin/gmake --no-print-directory Q=3D@ -C common install
> ../install-sh -o root -g root -m 755 -d /var/lib/xfstests/common
> ../install-sh -o root -g root -m 644 * /var/lib/xfstests/common
> /usr/bin/gmake --no-print-directory Q=3D@ -C tests install
> /usr/bin/gmake --no-print-directory Q=3D@ -C /home/git/xfstests-dev/tests=
/ install
> /usr/bin/gmake --no-print-directory Q=3D@ -C /home/git/xfstests-dev/tests=
/ install
> /usr/bin/gmake --no-print-directory Q=3D@ -C /home/git/xfstests-dev/tests=
/ install
> /usr/bin/gmake --no-print-directory Q=3D@ -C /home/git/xfstests-dev/tests=
/ install
> /usr/bin/gmake --no-print-directory Q=3D@ -C /home/git/xfstests-dev/tests=
/ install
> /usr/bin/gmake --no-print-directory Q=3D@ -C /home/git/xfstests-dev/tests=
/ install
> ......
> ......
> (again and again and again ....)

This looks like a bug of make to me.

TESTS_SUBDIRS =3D $(sort $(dir $(wildcard $(CURDIR)/[a-z]*/)))

The "wildcard" part is supposed to find all subdirs in tests dir, e.g.
"tests/ext4 tests/generic tests/xfs ...", files shouldn't be included.
So we get subdir list and go into each subdir and do install there.

But the same "wildcard" expression returns files too on fedora 28, e.g.
"tests/Makefile tests/ext4 tests/generic tests/xfs ...", as a result,
"tests/" is included in subdirs again, and we go to "tests/" to do
install there again and enter a infinite loop.

I can workaround the problem by appending a dot, i.e.

- TESTS_SUBDIRS =3D $(sort $(dir $(wildcard $(CURDIR)/[a-z]*/)))
+ TESTS_SUBDIRS =3D $(sort $(dir $(wildcard $(CURDIR)/[a-z]*/.)))

So we make sure only dirs are returned.

Thanks,
Eryu

> ......
> ......
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
