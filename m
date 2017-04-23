Received: from mail-it0-f65.google.com ([209.85.214.65]:36536 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162180AbdDWRH0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Apr 2017 13:07:26 -0400
Received: by mail-it0-f65.google.com with SMTP id x188so9877587itb.3
        for <fstests@vger.kernel.org>; Sun, 23 Apr 2017 10:07:26 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id a190sm26346664pgc.60.2017.04.23.10.07.23
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Apr 2017 10:07:24 -0700 (PDT)
Message-ID: <58fcdf4c.c766630a.413e0.d45f@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Mon, 24 Apr 2017 01:07:19 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 3501b86c9db5
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lH0Eu5iSZv8j"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--lH0Eu5iSZv8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is relatively a small update, which contains a new
file handle test and a few minor improvements. There should be no new failures
introduced by this update.

Thanks,
Eryu

The new head of the master branch is commit:

3501b86c9db5 xfs/293: make test more robust

New commits:

Amir Goldstein (4):
      [bc2568f994cd] fstests: remove IRIX test program open_unlink
      [b34b3785669e] src/open_by_handle: program to exercise open_by_handle_at() syscall
      [52107267320f] src/open_by_handle: flexible usage options
      [62c42440ee55] fstests: add generic test for file handles

Eric Sandeen (1):
      [3501b86c9db5] xfs/293: make test more robust

Gwendal Grignou (1):
      [796a4734629e] generic: fix statx definition for non-x86 architecture


Code Diffstat:

 .gitignore                   |   1 +
 aclocal.m4                   |  15 +++
 common/rc                    |  10 ++
 configure.ac                 |   1 +
 doc/auxiliary-programs.txt   |  16 ++-
 doc/requirement-checking.txt |   7 ++
 include/builddefs.in         |   1 +
 src/Makefile                 |   7 +-
 src/open_by_handle.c         | 261 +++++++++++++++++++++++++++++++++++++++++++
 src/open_unlink.c            | 147 ------------------------
 src/statx.h                  |   8 +-
 tests/generic/426            |  77 +++++++++++++
 tests/generic/426.out        |   2 +
 tests/generic/group          |   1 +
 tests/xfs/293                |  13 ++-
 15 files changed, 410 insertions(+), 157 deletions(-)
--
Eryu Guan
eguan@redhat.com

--lH0Eu5iSZv8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJY/N5zAAoJECZSqilcj+djxIYQALN2yMI5Ewa6QtKM0JHVFNJJ
wC43UvRGStVH7fPUW/4uGvuZ3DhQatEO8jlQFsdIw7iG+FSShq/SIY9RoLCfsrbA
LISTkDXj6PuICXAE8GLRJqfvgDgx1INv/OnZsuYcWKv1ieTqtQPZUTF+D4VcYsLH
Oid9LXBIPDXGG0valY+ALFO1OaUyQMbGmPNAuxAnggV9jv060LdY+akWhBN5djQZ
sApZvQ5Y5RbqCZoulacgdQCYYCsaDcCqNNEj4iRIHY/T1wWjcuaMMLqO+N0jax+5
dJC3tw/OIBdpEid+EeqwpVkZfzxRoAAsHVhID5lx7KIhLwFhACJGwH5zQVEt3+li
B//61z+No/4n2V7PyKo5D5adBpWw134rEfW45J0i3KCTlDFzruw2KlInMAuS4Ugn
jmw0a3QPKMc84ER6M6jCrZlOqu+7M+OZcbB/ndMF7YcjYH8MYIIZre8y2dc4nZTK
yokX2S0FotsrSUJE32l+R0hVJgVHgYbmN2JeoEQvwHjBrqQo3K7Pk3UI1CQn2MoX
kkrlS8sWEYHgHKh04rO2u6iaI3/ibLLSlC05o1qAT8j1V6kxmtJ9AG4bW2M03yFF
uMi8Rk+lNhHY8tsou3KZBiSyagbafqM6BYWM2NBxPKRVvziTmny5R8YPoJdJoIRD
7YlgVybxkjmZlDkIPyoj
=he9R
-----END PGP SIGNATURE-----

--lH0Eu5iSZv8j--
