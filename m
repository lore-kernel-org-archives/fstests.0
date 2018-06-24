Received: from mail-pl0-f41.google.com ([209.85.160.41]:33391 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeFXL4F (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Jun 2018 07:56:05 -0400
Received: by mail-pl0-f41.google.com with SMTP id 6-v6so5514473plb.0
        for <fstests@vger.kernel.org>; Sun, 24 Jun 2018 04:56:05 -0700 (PDT)
Message-ID: <5b2f86d4.1c69fb81.dde99.652f@mx.google.com>
Date: Sun, 24 Jun 2018 19:55:59 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 6ab53c6c6825
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Gp9iO2GWpJtv"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--Gp9iO2GWpJtv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly contains the second part of spdx
license conversion from Dave, which converts the C code of the tests. Also
there're 4 other bug-fixes/cleanups patches, so there should be no new failures
introduced.

Thanks,
Eryu

The new head of the master branch is commit:

6ab53c6c6825 ltp/: spdx license conversion

New commits:

Dave Chinner (6):
      [a3b48623c361] dmapi: spdx license conversion
      [fa993e51300f] include/: spdx license conversion
      [f65752b73e99] lib/: spdx license conversion
      [09faacc1291d] src/aio-dio-regress/: spdx license conversion
      [c432589da355] src/: spdx license conversion
      [6ab53c6c6825] ltp/: spdx license conversion

Lu Fengqi (1):
      [8865de330fcd] btrfs: replace btrfs-debug-tree with btrfs inspect-internal dump-tree

Marco Benatto (1):
      [f5cc57328134] common/xfs: Add _scratch_get_sfdir_prefix function

Ross Zwisler (1):
      [424cdb8c0a7c] src: fix up mmap() error checking

Xiao Yang (1):
      [ec91652eb6fe] src/t_stripealign.c: Fix complier error


Code Diffstat:

 common/config                                      |  1 -
 common/xfs                                         | 15 +++++++++
 dmapi/Makefile                                     | 16 +---------
 dmapi/src/Makefile                                 | 16 +---------
 dmapi/src/common/Makefile                          | 16 +---------
 dmapi/src/common/cmd/Makefile                      | 16 +---------
 dmapi/src/common/cmd/read_invis.c                  | 14 +--------
 dmapi/src/common/cmd/set_region.c                  | 14 +--------
 dmapi/src/common/cmd/set_return_on_destroy.c       | 14 +--------
 dmapi/src/common/cmd/write_invis.c                 | 14 +--------
 dmapi/src/common/lib/Makefile                      | 16 +---------
 dmapi/src/common/lib/dmport.h                      | 14 +--------
 dmapi/src/common/lib/find_session.c                | 14 +--------
 dmapi/src/common/lib/print.c                       | 14 +--------
 dmapi/src/common/lib/stubs.c                       | 14 +--------
 dmapi/src/sample_hsm/Makefile                      | 16 +---------
 dmapi/src/simple/Makefile                          | 16 +---------
 dmapi/src/simple/dm_create_session.c               | 14 +--------
 dmapi/src/simple/dm_destroy_session.c              | 14 +--------
 dmapi/src/simple/dm_find_eventmsg.c                | 14 +--------
 dmapi/src/simple/dm_getall_sessions.c              | 14 +--------
 dmapi/src/simple/dm_getall_tokens.c                | 14 +--------
 dmapi/src/simple/dm_query_session.c                | 14 +--------
 dmapi/src/suite1/Makefile                          | 16 +---------
 dmapi/src/suite1/cmd/Makefile                      | 16 +---------
 dmapi/src/suite1/cmd/create_userevent.c            | 14 +--------
 dmapi/src/suite1/cmd/dm_handle.c                   | 14 +--------
 dmapi/src/suite1/cmd/downgrade_right.c             | 14 +--------
 dmapi/src/suite1/cmd/fd_to_handle.c                | 14 +--------
 dmapi/src/suite1/cmd/get_allocinfo.c               | 14 +--------
 dmapi/src/suite1/cmd/get_config_events.c           | 14 +--------
 dmapi/src/suite1/cmd/get_dirattrs.c                | 14 +--------
 dmapi/src/suite1/cmd/get_dmattr.c                  | 14 +--------
 dmapi/src/suite1/cmd/get_eventlist.c               | 14 +--------
 dmapi/src/suite1/cmd/get_events.c                  | 14 +--------
 dmapi/src/suite1/cmd/get_fileattr.c                | 14 +--------
 dmapi/src/suite1/cmd/get_mountinfo.c               | 14 +--------
 dmapi/src/suite1/cmd/get_region.c                  | 14 +--------
 dmapi/src/suite1/cmd/getall_disp.c                 | 14 +--------
 dmapi/src/suite1/cmd/getall_dmattr.c               | 14 +--------
 dmapi/src/suite1/cmd/handle_to_fshandle.c          | 14 +--------
 dmapi/src/suite1/cmd/handle_to_path.c              | 14 +--------
 dmapi/src/suite1/cmd/init_service.c                | 14 +--------
 dmapi/src/suite1/cmd/link_test.c                   | 14 +--------
 dmapi/src/suite1/cmd/make_rt_sparse.c              | 14 +--------
 dmapi/src/suite1/cmd/make_sparse.c                 | 14 +--------
 dmapi/src/suite1/cmd/obj_ref_hold.c                | 14 +--------
 dmapi/src/suite1/cmd/obj_ref_query.c               | 14 +--------
 dmapi/src/suite1/cmd/obj_ref_rele.c                | 14 +--------
 dmapi/src/suite1/cmd/path_to_fshandle.c            | 14 +--------
 dmapi/src/suite1/cmd/path_to_handle.c              | 14 +--------
 dmapi/src/suite1/cmd/pending.c                     | 14 +--------
 dmapi/src/suite1/cmd/print_fshandle.c              | 14 +--------
 dmapi/src/suite1/cmd/probe_hole.c                  | 14 +--------
 dmapi/src/suite1/cmd/probe_punch_xfsctl_hole.c     | 14 +--------
 dmapi/src/suite1/cmd/punch_hole.c                  | 14 +--------
 dmapi/src/suite1/cmd/query_right.c                 | 14 +--------
 dmapi/src/suite1/cmd/randomize_file.c              | 14 +--------
 dmapi/src/suite1/cmd/release_right.c               | 14 +--------
 dmapi/src/suite1/cmd/remove_dmattr.c               | 14 +--------
 dmapi/src/suite1/cmd/request_right.c               | 14 +--------
 dmapi/src/suite1/cmd/respond_event.c               | 14 +--------
 dmapi/src/suite1/cmd/rwt.c                         | 14 +--------
 dmapi/src/suite1/cmd/security_hole.c               | 14 +--------
 dmapi/src/suite1/cmd/security_hole2.c              | 14 +--------
 dmapi/src/suite1/cmd/set_disp.c                    | 14 +--------
 dmapi/src/suite1/cmd/set_dmattr.c                  | 14 +--------
 dmapi/src/suite1/cmd/set_eventlist.c               | 14 +--------
 dmapi/src/suite1/cmd/set_fileattr.c                | 14 +--------
 dmapi/src/suite1/cmd/struct_test.c                 | 14 +--------
 dmapi/src/suite1/cmd/sync_by_handle.c              | 14 +--------
 dmapi/src/suite1/cmd/test_assumption.c             | 14 +--------
 dmapi/src/suite1/cmd/upgrade_right.c               | 14 +--------
 dmapi/src/suite2/Makefile                          | 16 +---------
 dmapi/src/suite2/lib/errtest.h                     | 14 +--------
 dmapi/src/suite2/src/Makefile                      | 16 +---------
 dmapi/src/suite2/src/check_dmapi.c                 | 14 +--------
 dmapi/src/suite2/src/invis_test.c                  | 14 +--------
 dmapi/src/suite2/src/mm_fill.c                     | 14 +--------
 dmapi/src/suite2/src/mmap.c                        | 14 +--------
 dmapi/src/suite2/src/mmap_cp.c                     | 14 +--------
 dmapi/src/suite2/src/region_test.c                 | 14 +--------
 dmapi/src/suite2/src/send_msg.c                    | 14 +--------
 dmapi/src/suite2/src/test_dmattr.c                 | 14 +--------
 dmapi/src/suite2/src/test_efault.c                 | 14 +--------
 dmapi/src/suite2/src/test_eventlist.c              | 14 +--------
 dmapi/src/suite2/src/test_fileattr.c               | 14 +--------
 dmapi/src/suite2/src/test_hole.c                   | 14 +--------
 dmapi/src/suite2/src/test_invis.c                  | 14 +--------
 dmapi/src/suite2/src/test_region.c                 | 14 +--------
 dmapi/src/suite2/src/test_rights.c                 | 14 +--------
 include/Makefile                                   |  2 +-
 include/builddefs.in                               |  2 +-
 include/buildmacros                                |  2 +-
 include/buildrules                                 |  2 +-
 include/dataascii.h                                | 14 +--------
 include/file_lock.h                                | 14 +--------
 include/forker.h                                   | 14 +--------
 include/install-sh                                 |  1 +
 include/open_flags.h                               | 14 +--------
 include/pattern.h                                  | 14 +--------
 include/random_range.h                             | 14 +--------
 include/str_to_bytes.h                             | 14 +--------
 include/string_to_tokens.h                         | 14 +--------
 include/tlibio.h                                   | 14 +--------
 include/write_log.h                                | 14 +--------
 lib/Makefile                                       |  2 +-
 lib/dataascii.c                                    | 14 +--------
 lib/databin.c                                      | 14 +--------
 lib/datapid.c                                      | 14 +--------
 lib/file_lock.c                                    | 14 +--------
 lib/forker.c                                       | 14 +--------
 lib/open_flags.c                                   | 14 +--------
 lib/pattern.c                                      | 14 +--------
 lib/random.c                                       | 22 ++-----------
 lib/random_range.c                                 | 14 +--------
 lib/str_to_bytes.c                                 | 14 +--------
 lib/string_to_tokens.c                             | 14 +--------
 lib/tlibio.c                                       | 14 +--------
 lib/write_log.c                                    | 14 +--------
 ltp/Makefile                                       |  2 +-
 ltp/aio-stress.c                                   | 25 +++------------
 ltp/doio.c                                         | 14 +--------
 ltp/doio.h                                         | 14 +--------
 ltp/fsstress.c                                     | 14 +--------
 ltp/growfiles.c                                    | 14 +--------
 ltp/iogen.c                                        | 14 +--------
 src/Makefile                                       |  1 +
 src/af_unix.c                                      |  7 +----
 src/aio-dio-regress/Makefile                       |  2 ++
 .../aio-dio-append-write-read-race.c               | 16 +---------
 src/aio-dio-regress/aio-dio-cow-race.c             | 14 +--------
 src/aio-dio-regress/aio-dio-cycle-write.c          | 20 ++----------
 src/aio-dio-regress/aio-dio-eof-race.c             | 19 ++----------
 src/aio-dio-regress/aio-dio-extend-stat.c          | 19 ++----------
 src/aio-dio-regress/aio-dio-fcntl-race.c           | 19 ++----------
 src/aio-dio-regress/aio-dio-hole-filling-race.c    | 19 ++----------
 src/aio-dio-regress/aio-dio-invalidate-failure.c   | 19 ++----------
 src/aio-dio-regress/aio-dio-invalidate-readahead.c | 19 ++----------
 src/aio-dio-regress/aio-dio-subblock-eof-read.c    | 22 +++----------
 .../aio-free-ring-with-bogus-nr-pages.c            | 25 ++++-----------
 ...aio-io-setup-with-nonwritable-context-pointer.c | 25 +++------------
 src/aio-dio-regress/aio-last-ref-held-by-io.c      | 21 +++----------
 src/aio-dio-regress/aiocp.c                        | 36 ++++++----------------
 src/alloc.c                                        | 14 +--------
 src/attr-list-by-handle-cursor-test.c              | 16 +---------
 src/bstat.c                                        | 14 +--------
 src/cloner.c                                       | 16 +---------
 src/dbtest.c                                       | 14 +--------
 src/devzero.c                                      | 14 +--------
 src/dio-invalidate-cache.c                         | 14 +--------
 src/dirhash_collide.c                              | 14 +--------
 src/dirperf.c                                      | 14 +--------
 src/dirstress.c                                    | 14 +--------
 src/dmerror                                        | 16 +---------
 src/dmiperf.c                                      | 14 +--------
 src/fault.c                                        | 14 +--------
 src/feature.c                                      | 14 +--------
 src/fiemap-tester.c                                | 14 +--------
 src/fill.c                                         | 14 +--------
 src/fill2.c                                        | 14 +--------
 src/fs_perms.c                                     | 16 +---------
 src/fssum.c                                        | 15 +--------
 src/fstest.c                                       |  2 +-
 src/ftrunc.c                                       | 14 +--------
 src/getdevicesize.c                                | 14 +--------
 src/global.h                                       | 14 +--------
 src/godown.c                                       | 14 +--------
 src/holes.c                                        | 14 +--------
 src/holetest.c                                     | 15 +--------
 src/iopat.c                                        | 14 +--------
 src/listxattr.c                                    | 14 +--------
 src/locktest.c                                     | 14 +--------
 src/log-writes/Makefile                            |  2 ++
 src/loggen.c                                       | 14 +--------
 src/looptest.c                                     | 14 +--------
 src/lstat64.c                                      | 14 +--------
 src/makeextents.c                                  | 14 +--------
 src/metaperf.c                                     | 14 +--------
 src/multi_open_unlink.c                            | 14 +--------
 src/nametest.c                                     | 14 +--------
 src/nsexec.c                                       | 17 +++++-----
 src/open_by_handle.c                               | 23 +++-----------
 src/perf/FioCompare.py                             |  2 ++
 src/perf/FioResultDecoder.py                       |  2 ++
 src/perf/Makefile                                  |  2 ++
 src/perf/ResultData.py                             |  2 ++
 src/perf/fio-insert-and-compare.py                 |  2 ++
 src/perf/generate-schema.py                        |  2 ++
 src/permname.c                                     | 14 +--------
 src/pwrite_mmap_blocked.c                          | 14 +--------
 src/randholes.c                                    | 14 +--------
 src/resvtest.c                                     | 18 +----------
 src/runas.c                                        | 14 +--------
 src/scaleread.c                                    | 14 +--------
 src/seek_copy_test.c                               | 15 +--------
 src/seek_sanity_test.c                             | 15 +--------
 src/stale_handle.c                                 | 16 +---------
 src/stat_test.c                                    |  7 +----
 src/t_dir_offset2.c                                | 14 +--------
 src/t_dir_type.c                                   | 14 +--------
 src/t_encrypted_d_revalidate.c                     | 23 +++-----------
 src/t_ext4_dax_inline_corruption.c                 |  4 +--
 src/t_ext4_dax_journal_corruption.c                |  4 +--
 src/t_futimens.c                                   |  7 +----
 src/t_holes.c                                      | 14 +--------
 src/t_immutable.c                                  | 16 +---------
 src/t_mmap_stale_pmd.c                             |  2 ++
 src/t_mmap_writev.c                                | 29 +++++------------
 src/t_stripealign.c                                | 12 +++-----
 src/t_truncate_cmtime.c                            | 15 +--------
 src/test-nextquota.c                               | 14 +--------
 src/trunc.c                                        | 14 +--------
 src/truncfile.c                                    | 14 +--------
 src/usemem.c                                       | 14 +--------
 src/writemod.c                                     | 14 +--------
 src/writev_on_pagefault.c                          | 16 +---------
 src/xfsctl.c                                       | 14 +--------
 tests/btrfs/085                                    |  4 +--
 tests/xfs/278                                      | 16 +---------
 220 files changed, 312 insertions(+), 2684 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--Gp9iO2GWpJtv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbL4Z7AAoJECZSqilcj+djDksP/3kGPCy+ldtkC2LmhemolN82
b0ZvCTRr7+izKOZ2A9DXQGmIb93stlB+/IJt3hNy3Yhd81OEvXDiRC6KW14+4s7Y
jKZl1BbjSOGR/Mo9dxr0twgOeHu6K5m7v3dLbfkzUwdd2l+AYFONSy8WGwoEyPnV
5fq41qMlem6WRtrNueOMwtDdba1RQ1WdF2Zen5T0epL5deBYPD5fhIdyohIe/O/o
PPKffZUP9ADALsiqgN/zczULV4JDePC1p/Qjuu/l3O7Ftu8TsCPtlQFSYr+9YAFf
JDzrWekmXk6u1Jzq41xi+YTA4jfBqJ+30TpxmBydCHvWKd5DW+rQVCtk1NmhJ3VO
AWK6EhtAdnbmge47/Ra2Mf/JufARcpemsm72nRJEqlTCDDmUQaWwumTWTT7tnmGL
f6IfyiA8Zwve6hkQfpQeNSJq8g+8iyXWlhG3vK9Y2OBc/hM+XtqTahJ17Dp1Rvvl
Ly+7G5u0g9Q5XHMdedCxBkMDOl4yBoBadz7fEuoqdZsLsyxqw8UNhwjdmCp5jna1
ooud5F6aOIvNnMkpCKnhdlMefcibrvD398Ia9Gmor01XaW2Ug+M669LczfwjtBeC
X++xROe34cBKOTam9WgHzdhNHa6VSnxUiAqsWQQ59T5TxwmAMFUnOhHCP+BFWkbU
Ijyk+284dVdeObaRse6Q
=m/uO
-----END PGP SIGNATURE-----

--Gp9iO2GWpJtv--
