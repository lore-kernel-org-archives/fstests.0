Received: from mail-pf0-f173.google.com ([209.85.192.173]:34673 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbdFRM5j (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Jun 2017 08:57:39 -0400
Received: by mail-pf0-f173.google.com with SMTP id s66so42186743pfs.1
        for <fstests@vger.kernel.org>; Sun, 18 Jun 2017 05:57:38 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id h123sm14546412pgc.36.2017.06.18.05.57.36
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Jun 2017 05:57:37 -0700 (PDT)
Message-ID: <594678c1.816c630a.b0b23.ee2f@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 18 Jun 2017 20:57:32 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 9bcb266cd778
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nNlsyQDAz5Vs"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--nNlsyQDAz5Vs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a relatively small update, which has new tests
for fscrypt and btrfs, and minor fixes for UDF.

New failure I've noticed in this update:
- btrfs/145 fails with latest 4.12-rc5 Linus tree

Thanks,
Eryu

The new head of the master branch is commit:

9bcb266cd778 generic/397: be compatible with ignored SIGPIPE

New commits:

Eric Biggers (2):
      [7e442cf0cf95] generic: test for buggy fscrypt context consistency check
      [9bcb266cd778] generic/397: be compatible with ignored SIGPIPE

Filipe Manana (1):
      [31e424c4aa3c] btrfs: incremental send after renaming a file and a directory

Jan Kara (2):
      [0a2d8332195a] generic/360: Create symlink with valid path
      [fabaef26ad59] common: UDF does not support journalling


Code Diffstat:

 common/rc             |   2 +-
 tests/btrfs/145       | 130 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/145.out   |   6 +++
 tests/btrfs/group     |   1 +
 tests/generic/360     |   4 +-
 tests/generic/360.out |   2 +-
 tests/generic/397     |   2 +-
 tests/generic/440     | 114 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/440.out |  13 +++++
 tests/generic/group   |   1 +
 10 files changed, 271 insertions(+), 4 deletions(-)
--
Eryu Guan
eguan@redhat.com

--nNlsyQDAz5Vs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZRngVAAoJECZSqilcj+djzdEP/jYUKQ5I2g6ZizGTuVKXsh+u
2i5Zw3vj+trEOcoGj1pIG5g9laRj+hzqT3WbDKMdrmNAQKLtjwtq/k61WmvAqDjw
EY8ZfAonNglJqVR3hFMy4CQjzejuCmSKHMNmRMA4noqDNYIMNrVSQ5rxDNHVC/TT
vM3E5aqmZq4+QJ9C11Doe/50V9Z4QvwrJwpfz9tjCKnRUPLe5omQJujI6iwbQXkR
g5H22Cd7LTS2zPu6ZEM5aONrGc/rXmkZ/+AVrFl+6BieFHIxh5rCJwbgYt9ykgmO
t+SCTGviBNG/tomt8UJWbA2Eh4YBkrubwb4kJL4jNXWx6os1KlIGpe6f7HqBLCmJ
rowYKexgC/yJzPAW2orArilgD88eIHr8WBSkOvh/dNXjeG6Mpo8KJwlcBT7zzv/Z
wan1f3xQPEEbQ6quEKMcClxG/RLlGRZTVfrPj25GzOggW54pNRILaOt2Ar4sPtn5
l2Tncb9Lu321iMO9I4DP5Xy0lvrQrrbl7AFQASr9ECEyVuVwz5VRv7I9nsxstGYE
SVjVBVbtLgJKeL26QlaOsF2tWvrccaFItOVat1QMl3pv8C+dif5h+eah1Me7i9/V
YR8I0TNpJOFjx5ytDjVR388nv/BbmH3Du21+CQRgIhpCqjIT/GMslTLTPUSXuqd5
RoJ20lPDRA7lumTaPAOQ
=cug+
-----END PGP SIGNATURE-----

--nNlsyQDAz5Vs--
