Received: from mail-pf0-f176.google.com ([209.85.192.176]:42508 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753033AbeD2Mo0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 Apr 2018 08:44:26 -0400
Received: by mail-pf0-f176.google.com with SMTP id a11so4741502pfn.9
        for <fstests@vger.kernel.org>; Sun, 29 Apr 2018 05:44:26 -0700 (PDT)
Message-ID: <5ae5be28.8900620a.fc088.abaf@mx.google.com>
Date: Sun, 29 Apr 2018 20:44:19 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 7bc26faa6b52
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HjaAx8CcFJHP"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--HjaAx8CcFJHP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a normal update that contains two new tests and
some cleanups for overlay and btrfs.

And I've gone through all the review backlogs in the last few days, but I might
miss patches, so if you still have patches posted for more than 5 days and got
no reviews, please just resend.

New failures I've noticed in this update:
- generic/484 fails with latest Linus tree (v4.17-rc2) on all filesystems, the
  fix is still in review

Thanks,
Eryu

The new head of the master branch is commit:

7bc26faa6b52 generic: test record locks across execve in multithread process

New commits:

Amir Goldstein (3):
      [e9f768ef0ebb] overlay/041: fix call to _overlay_check_scratch_dirs
      [e97ef0145ce0] overlay/043: require and enable redirect_dir
      [9b1ff558f734] overlay/04{1,3,4}: enable xino feature

Anand Jain (3):
      [7c8651be0a1e] btrfs/130: fix Invalid argument
      [e46a9aa0bef7] btrfs/130: make it workable on small systems
      [a6f6336df750] btrfs/011: cleanup the functions

Brian Foster (1):
      [91481af94986] xfs: filestream allocator inode use-after-free test

Misono Tomohiro (1):
      [d3977ca35aaf] common/rc: move rm out from if block to always delete kmemleak temp file

Xiong Zhou (1):
      [7bc26faa6b52] generic: test record locks across execve in multithread process


Code Diffstat:

 .gitignore            |   1 +
 common/rc             |  12 ++-
 src/Makefile          |   2 +-
 src/t_locks_execve.c  |  77 ++++++++++++++++++++
 tests/btrfs/011       | 197 ++++++++++++++++----------------------------------
 tests/btrfs/130       |   9 ++-
 tests/generic/484     |  65 +++++++++++++++++
 tests/generic/484.out |   2 +
 tests/generic/group   |   1 +
 tests/overlay/041     |  20 +++--
 tests/overlay/043     |  16 +++-
 tests/overlay/044     |  15 +++-
 tests/xfs/445         | 109 ++++++++++++++++++++++++++++
 tests/xfs/445.out     |   2 +
 tests/xfs/group       |   1 +
 15 files changed, 375 insertions(+), 154 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--HjaAx8CcFJHP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJa5b4CAAoJECZSqilcj+djTgYP/jTjB2LEQPb3T87Vl9wFf2kJ
j7fbSgXW+Mi3qy2v7IN1ggfY6CR+oSMZMfdS7GGDAjm94nfoBusay3Y9DIdgOPUk
5Wbb3xCdhEROwE8/9+0VVFHuLfkW6BqKViCg+tl0JFtQy7dEvxfyVMihK8qIpLuu
tIeN6+ITMCDbv4d5W6NmDywoMo93pT2DmREyQWdIsyzSyiv1HlKTKUiwHdyzw6Hi
V4uWSiJCNscUDQkHgKIz3AWsrOqAvEP0N0wFo2FQkllf9QNR3t+MsIz0NkB++ZwM
9dpEvHTuK+SqhcGZgiOJMpf5Vziza+TE7MzG0K/dPI/2TffaN5eZTeQ4Ld2l1Yxb
uKQOi1gi2grGh4OJOsEzrS/8scTLe3IqP+iUFB9nY5ve9GnVIIYlUhJeNkfayvAZ
YpoKgCRRWfmzYZeNvUbk3B1D/chB3QSw+2lrBh14AU9GphpUW+5tHIxdbB6SXK1B
MkNxXG0oLPH3pd7YIdHZR7I7YYiCPLsAgU8Qi8Inob84+Gel3f/4z6FFth8MwKkT
bYURjGD85EG3k7A2UKoRcV5p5KXC5UIC6xbPpLLzgdcP4PxdiebMT7K/iqO4nH2k
JWNUnJZGVf5peK4RD0oECJDMm7LXvTtbGwCS+iHDi+nKwesd3CNzDPY7k7euPgxb
GYtsPc/LlYkb5hRkXrwf
=gMsc
-----END PGP SIGNATURE-----

--HjaAx8CcFJHP--
