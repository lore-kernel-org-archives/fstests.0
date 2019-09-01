Received: from mail-pg1-f196.google.com ([209.85.215.196]:38044 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfIAMbO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 Sep 2019 08:31:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id d10so1292381pgo.5
        for <fstests@vger.kernel.org>; Sun, 01 Sep 2019 05:31:13 -0700 (PDT)
Message-ID: <5d6bba10.1c69fb81.113b0.9e6c@mx.google.com>
Date: Sun, 01 Sep 2019 20:31:04 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to ed425ca92367
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d9okDeWpb8yL"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--d9okDeWpb8yL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. We have one new quota test and a casefold fix. The new
test should be passing on XFS if you're testing with latest kernel (v5.3-rc6),
otherwise the test would hang on XFS.

Thanks,
Eryu

The new head of the master branch is commit:

ed425ca92367 common/casefold: only check for the Casefold flag

New commits:

Darrick J. Wong (1):
      [3312c32e2c6d] generic: test for failure to unlock inode after chgrp fails with EDQUOT

Theodore Ts'o (1):
      [ed425ca92367] common/casefold: only check for the Casefold flag


Code Diffstat:

 common/casefold       |  6 +++++-
 tests/generic/556.out | 10 ++++-----
 tests/generic/566     | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/566.out |  2 ++
 tests/generic/group   |  1 +
 5 files changed, 71 insertions(+), 6 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--d9okDeWpb8yL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl1rt6QACgkQJlKqKVyP
52MDBhAAxYpUNd6WyPZs0zs9hdoVFGgYHtqsZ3kKzvCYL6OAkLVbg9Zl0GIAAsTg
5vcZzDGrnxXYg7LjfqzdbG88FH16ExtdMg59G6Htc5AFlHE85OzqKpje6ZG+ZzAf
+dVcqnY/Y4p4nbYjI74SfAzGqcyxmLLPszqNw8QyXZ0ZM6NE1GtsUUul6AGYOL73
XTXSfW25F31Qe63k1nq7c8wUD7fvtxDXyDS7uFFKKMwJ+wBH0oxM0L6NBN207yQa
kfTadeiMnc2txKQhVY8xrnz9d4qwfKGJwJjwnUYAcMnwczn3rLogiEt8mdVgJ7pS
AIaZuuP0Iqaz0irhfczK9lKdCMNWD4QHa67WOq8M+con4UCv9GWKBgt35BYEQFha
K0DkmjRRuiSQyCyV+kLhMI7k+0tzsJCSIMTtGStA035fvx0fsqURsn6q9TZkUSrj
dHjn5xgNnnZ9xggQI+lExEem1bKXvhHQoWnHMQFis5dGQUtoKXMq7HsiP5vWXjTd
VbgHjZ61urUmsi23USndORAYIZ1MftIuvLE08pU7dA0MXt93FB2njktGLOnzWSFN
Z8c3dwOgb7zd4SJZyFeoZZ9bXLkLO9qBCcxBO1ASPYM+6I93RKwJEeGCz3h4GbvK
d+2Myf2Zho/8lYWC81GImTkWQDq++yZSmRPUINwJAYC+cI4q2rc=
=Le/W
-----END PGP SIGNATURE-----

--d9okDeWpb8yL--
