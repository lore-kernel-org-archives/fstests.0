Received: from mail-pf1-f176.google.com ([209.85.210.176]:40845 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeIPU1N (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 Sep 2018 16:27:13 -0400
Received: by mail-pf1-f176.google.com with SMTP id s13-v6so6378886pfi.7
        for <fstests@vger.kernel.org>; Sun, 16 Sep 2018 08:03:59 -0700 (PDT)
Message-ID: <5b9e70de.1c69fb81.ca27f.2bde@mx.google.com>
Date: Sun, 16 Sep 2018 23:03:51 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to cc8831f9a5e5
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HtAphsm8LNpY"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--HtAphsm8LNpY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're only two minor bug fixes in this update, and
should be no new failures.

And we're having some patches to make tests work with 64k block size
filesystems pending in the list, as I don't have access to hardware that
supports 64K blocksize filesystems, I really appreciate if someone could help
test and review the patches. Thanks a lot!

Thanks,
Eryu

The new head of the master branch is commit:

cc8831f9a5e5 btrfs/149: make it sectorsize independent

New commits:

Anand Jain (1):
      [cc8831f9a5e5] btrfs/149: make it sectorsize independent

Zorro Lang (1):
      [29b2f63b3ee7] shared/010: avoid dedupe testing blocked on large fs


Code Diffstat:

 common/btrfs        |  7 +++++++
 common/filter       |  5 +++++
 tests/btrfs/149     | 46 ++++++++++++++++++++++++++++++----------------
 tests/btrfs/149.out | 11 ++++-------
 tests/shared/010    |  6 ++++--
 5 files changed, 50 insertions(+), 25 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--HtAphsm8LNpY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbnnBfAAoJECZSqilcj+djtT8QANyqFjLi6tfBio7Pkzjw52lQ
JoS2/WbCm4AzfbH4F+5kYZSCFe7VAjHnyXsMau2B6atTxbFvZgKKfGtVyQjPtISK
svxt1bHU3irUhehecXPuYNhrmX9BdtBLl1GjRXaP9q32hqlgQ794Xh1QPGHSShWq
8yhy9fTnLBZBP6WTqHmroHaj7Wx9QZ5/u13mEXkO/7zJB/xQusMxOsuijdHui0fM
zt5raKXvutgm+JRsOAs1Nv1+mZ9aO9foUapzfTGnHGgX3EVGpw4DEBHaMtD2clsU
o0zprqjczyYkj6jNAYp5rn80M4GDuQzp2mT+W+BW2yO0NmAlJbnXGJLcmMIVO9+U
qtHNAC5PaepfFwEyqs7i0ZEFb5gGjsF2MvrsF9/gdQ3C7eccWQr4DwuGnoyuzIgl
DmnqSz72VQ6/AuIcsKHaypwcLAlOtMD+Rbo2n59BLAnRsenTrH3UCffptwrs5xaf
6N3j0wAuk2waZIpnroh/MzrNyl3xXcnpo0uQYyydCcfknuZZnqaeAN7LlM71BeRS
iMGypGrQ/Hw+36/fwQkz5I1HLhbVXlfcD6YD1svGOGB/xqZhRHwfzNQV3QzSRgjx
LPk9HRzEppbVbuAf7L5/365IqxHh0deioC5FzCZmKE9abaexqq+X2bj0glH0JTdj
lVYvaXkHf9XeCb846js3
=WEmL
-----END PGP SIGNATURE-----

--HtAphsm8LNpY--
