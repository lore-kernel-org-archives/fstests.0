Received: from mail-pf0-f196.google.com ([209.85.192.196]:41258 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeGOHdL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 15 Jul 2018 03:33:11 -0400
Received: by mail-pf0-f196.google.com with SMTP id c21-v6so20165393pfn.8
        for <fstests@vger.kernel.org>; Sun, 15 Jul 2018 00:11:16 -0700 (PDT)
Date: Sun, 15 Jul 2018 15:11:10 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: xfstests can't be installed by running make install
Message-ID: <20180715071110.GH2830@desktop>
References: <20180711143314.GD4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <20180711163921.GI2780@desktop>
 <20180715054320.GZ2234@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180715054320.GZ2234@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Jul 15, 2018 at 03:43:20PM +1000, Dave Chinner wrote:
> On Thu, Jul 12, 2018 at 12:39:21AM +0800, Eryu Guan wrote:
> > On Wed, Jul 11, 2018 at 10:33:14PM +0800, Zorro Lang wrote:
> > > Hi,
> > >=20
> > > xfstests can't be installed now, if I run "make install", it fails as=
 [1].
> > > I don't what has been changed, and I'm not really so familar with the=
se
> > > building things ... Is there anyone knows what's wrong with it? I tes=
ted
> > > on Fedora 28 with GNU Make 4.2.1.
> > >=20
> > > Thanks,
> > > Zorro
> > >=20
> > > [1]
> > > # git pull
> > > Already up to date.
> > > # make
> > > # make install
> > > Building include
> > > Building lib
> > > Building ltp
> > > Building src
> > > Building log-writes
> > > Building perf
> > > Building aio-dio-regress
> > > Building m4
> > > Building common                               =20
> > > Building tests
> > > /usr/bin/gmake --no-print-directory Q=3D@ -C include install
> > > gmake[1]: Nothing to be done for 'install'.
> > > /usr/bin/gmake --no-print-directory Q=3D@ -C lib install
> > > gmake[1]: Nothing to be done for 'install'.
> > > /usr/bin/gmake --no-print-directory Q=3D@ -C ltp install
> > > ../install-sh -o root -g root -m 755 -d /var/lib/xfstests/ltp
> > > /bin/sh ../libtool --quiet --mode=3Dinstall ../install-sh -o root -g =
root -m 755 doio fsstress fsx growfiles iogen aio-stress /var/lib/xfstests/=
ltp
> > > ../install-sh -o root -g root -m 755 rwtest.sh /var/lib/xfstests/ltp
> > > /usr/bin/gmake --no-print-directory Q=3D@ -C src install             =
             =20
> > > Building log-writes
> > > Building perf
> > > Building aio-dio-regress
> > > /usr/bin/gmake -C log-writes install
> > > ../../install-sh -o root -g root -m 755 -d /var/lib/xfstests/src/log-=
writes
> > > ../../install-sh -o root -g root -m 755 replay-log /var/lib/xfstests/=
src/log-writes
> > > /usr/bin/gmake -C perf install
> > > ../../install-sh -o root -g root -m 755 -d /var/lib/xfstests/src/perf
> > > ../../install-sh -o root -g root -m 755 ResultData.py fio-insert-and-=
compare.py FioResultDecoder.py FioCompare.py generate-schema.py fio-results=
=2Esql /var/lib/xfstests/src/perf
> > > /usr/bin/gmake -C aio-dio-regress install
> > > ../../install-sh -o root -g root -m 755 -d /var/lib/xfstests/src/aio-=
dio-regress
> > > ../../install-sh -o root -g root -m 755 aio-dio-fcntl-race aio-dio-su=
bblock-eof-read aio-dio-append-write-read-race aio-dio-invalidate-readahead=
 aio-dio-hole-filling-race aio-free-ring-with-bogus-nr-pages aio-last-ref-h=
eld-by-io aio-dio-cycle-write aio-dio-extend-stat aio-io-setup-with-nonwrit=
able-context-pointer aio-dio-invalidate-failure aiodio_sparse2 aiocp aio-di=
o-cow-race aio-dio-eof-race /var/lib/xfstests/src/aio-dio-regress
> > > ../install-sh -o root -g root -m 755 -d /var/lib/xfstests/src
> > > /bin/sh ../libtool --quiet --mode=3Dinstall ../install-sh -o root -g =
root -m 755 dirstress fill fill2 getpagesize holes lstat64 nametest permnam=
e randholes runas truncfile usemem mmapcat append_reader append_writer dirp=
erf metaperf devzero feature alloc fault fstest t_access_root godown resvte=
st writemod writev_on_pagefault makeextents itrash rename multi_open_unlink=
 dmiperf unwritten_sync genhashnames t_holes t_mmap_writev t_truncate_cmtim=
e dirhash_collide t_rename_overwrite holetest t_truncate_self t_mmap_dio af=
_unix t_mmap_stale_pmd t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_wr=
ite_ro t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption t_ofd_loc=
ks t_locks_execve xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_read=
er preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest locktest =
unwritten_mmap bulkstat_unlink_test bulkstat_unlink_test_modified t_dir_off=
set t_futimens t_immutable stale_handle pwrite_mmap_blocked t_dir_offset2 s=
eek_sanity_test seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec =
cloner renameat2 t_getcwd e4compact test-nextquota punch-alternating attr-l=
ist-by-handle-cursor-test listxattr dio-interleaved t_dir_type dio-invalida=
te-cache stat_test t_encrypted_d_revalidate attr_replace_test swapon mkswap=
 fiemap-tester t_stripealign open_by_handle dbtest fssum /var/lib/xfstests/=
src
> > > /bin/sh ../libtool --quiet --mode=3Dinstall ../install-sh -o root -g =
root -m 755 dmerror fill2attr fill2fs fill2fs_check scaleread.sh /var/lib/x=
fstests/src
> > > /bin/sh ../libtool --quiet --mode=3Dinstall ../install-sh -o root -g =
root -m 644 dumpfile /var/lib/xfstests/src
> > > /usr/bin/gmake --no-print-directory Q=3D@ -C m4 install
> > > gmake[1]: Nothing to be done for 'install'.
> > > /usr/bin/gmake --no-print-directory Q=3D@ -C common install
> > > ../install-sh -o root -g root -m 755 -d /var/lib/xfstests/common
> > > ../install-sh -o root -g root -m 644 * /var/lib/xfstests/common
> > > /usr/bin/gmake --no-print-directory Q=3D@ -C tests install
> > > /usr/bin/gmake --no-print-directory Q=3D@ -C /home/git/xfstests-dev/t=
ests/ install
> > > /usr/bin/gmake --no-print-directory Q=3D@ -C /home/git/xfstests-dev/t=
ests/ install
> > > /usr/bin/gmake --no-print-directory Q=3D@ -C /home/git/xfstests-dev/t=
ests/ install
> > > /usr/bin/gmake --no-print-directory Q=3D@ -C /home/git/xfstests-dev/t=
ests/ install
> > > /usr/bin/gmake --no-print-directory Q=3D@ -C /home/git/xfstests-dev/t=
ests/ install
> > > /usr/bin/gmake --no-print-directory Q=3D@ -C /home/git/xfstests-dev/t=
ests/ install
> > > ......
> > > ......
> > > (again and again and again ....)
> >=20
> > This looks like a bug of make to me.
> >=20
> > TESTS_SUBDIRS =3D $(sort $(dir $(wildcard $(CURDIR)/[a-z]*/)))
>=20
> Is this a regression because of commit 103258a566b4 ("build: fix
> install target using sudo")?

No, it fails even with that commit reverted.

>=20
> > The "wildcard" part is supposed to find all subdirs in tests dir, e.g.
> > "tests/ext4 tests/generic tests/xfs ...", files shouldn't be included.
> > So we get subdir list and go into each subdir and do install there.
> >=20
> > But the same "wildcard" expression returns files too on fedora 28, e.g.
> > "tests/Makefile tests/ext4 tests/generic tests/xfs ...", as a result,
>=20
> Should *never* return tests/Makefile, because that does not match
> the [a-z]* regex - it's a lowercase first character match, not
> uppercase. And the *only* things that should be in tests/ is the
> Makefile and all the test subdirs, so it shouldn't be matching the
> wrong thing. i.e. how are we getting tests/ as a result in the
> TESTS_SUBDIRS set?

That's why I think it's a bug of make. I did the following test on
Fedora 28 with make-4.2.1-6.fc28.x86_64.

[root@fedoravm tmp]# rpm -q make
make-4.2.1-6.fc28.x86_64
[root@fedoravm tmp]# pwd
/root/tmp
[root@fedoravm tmp]# ls -l
total 4
-rw-r--r--. 1 root root 206 Jul 15 14:58 Makefile
drwxr-xr-x. 1 root root   0 Jul 15 14:59 testdir
[root@fedoravm tmp]# cat Makefile=20
STRING1 =3D $(wildcard $(CURDIR)/[a-z]*/)
STRING2 =3D $(wildcard ./[a-z]*/)
default:
        @echo STRING1=3D"$(STRING1)"
        @echo STRING2=3D"$(STRING2)"
[root@fedoravm tmp]# make
STRING1=3D/root/tmp/testdir/ /root/tmp/Makefile
STRING2=3D./testdir/ ./Makefile
[root@fedoravm tmp]#

So 'Makefile' is matched and returned (and the usa ofCURDIR doesn't
matter), and that explains why we have "tests/" in TESTS_SUBDIRS.

The same test on RHEL7.4 works all as expected, 'Makefile' didn't match
the pattern.

>=20
> > "tests/" is included in subdirs again, and we go to "tests/" to do
> > install there again and enter a infinite loop.
>=20
> Again, is this a regression? If so, we need to understand why using
> $(CURDIR) is returning different results from $(PWD)/$(TESTS_DIR)/
>=20
> > I can workaround the problem by appending a dot, i.e.
>=20
> At this point, this seems more like hacking a bandaid over whatever
> problem is occurring rather than trying to solve/understand why this
> is now happening.

Agreed, I just expressed the fact that adding an ending dot could change
the behavior, I didn't think it's a proper fix until we know exactly
what causes it.

Thanks,
Eryu
