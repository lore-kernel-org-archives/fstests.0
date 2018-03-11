Received: from mail-pg0-f42.google.com ([74.125.83.42]:40886 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbeCKH4i (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Mar 2018 03:56:38 -0400
Received: by mail-pg0-f42.google.com with SMTP id g8so5248364pgv.7
        for <fstests@vger.kernel.org>; Sat, 10 Mar 2018 23:56:38 -0800 (PST)
Message-ID: <5aa4e135.4661650a.80f89.0f70@mx.google.com>
Date: Sun, 11 Mar 2018 15:56:31 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 640e4f6d7ae3
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pCAEBjHLK8ZD"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--pCAEBjHLK8ZD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update only contains two minor fixes for btrfs
cases, thanks to Lu Fengqi's patches and Filipe Manana's review!

Thanks,
Eryu

The new head of the master branch is commit:

640e4f6d7ae3 btrfs/146: make sure hit all stripes in the case of compression

New commits:

Lu Fengqi (2):
      [34369fb21cc2] btrfs/004: increase the buffer size of logical-resolve to the maximum value 64K
      [640e4f6d7ae3] btrfs/146: make sure hit all stripes in the case of compression


Code Diffstat:

 tests/btrfs/004 | 2 +-
 tests/btrfs/146 | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--pCAEBjHLK8ZD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJapN9hAAoJECZSqilcj+djwd0P/ikejAUYHUo4y+7L4tNR2TY6
Tx0R7qn6OC9Q1Lifn1mmiXSKzNi8m0+UCyE2rnNu2L1h/3C8Dskdjgc0n5FruyN5
/kiaME7tiQDTkaO7l8WZR4mrkd+O5k3pr/mwBmiIIqkiDPvM/v/ofBIjR2iUM4ni
9pUtw6wJv5XdBBgzkS3XxZ5conS/IO7y90pgxD1pn27UFm1BWimim9PijpxzgSio
2prvcrtzxf137KRXZ7i4fMj30wcnpub7dbfsQr/8hW/zrQoXgoloZJde44Slb5d8
fkJS9ojRJzOnQXhfW44kmv/vvFUn5ZhbOpNRdxJICpXPrNEMji1/xDiq/Qfj77M5
huLYg6K6F2NJAS/Nk7qZfK+VICCO+tgfRJ+lUPdH5k93bkUDUn4Zgcsv5cRxz+Xd
TZAYs0f9+lDSzgu8ufdQMNas7kF2WFHTP5DtmY1XF837iYvTraFOgumDVXFDxyE9
UeFWAUJb/+baJOPPlFu7WUvLbWovN7/TZMpoalCPm8x58iNwJaVBL0hMCerFVdqi
puswntTV3vQaovRok/N3LhQ0tHKYnYWiSE4zqnxSpLP47kv8XqrNBbXbs65QFHFl
dDCtTlzXzIvoHxDJaq8FXpT2/52QL91lqGV8touUn8BrcmxUTg7YxIlb/WhmCtRH
HzikkuYDNB8FphwnHB3O
=uPFO
-----END PGP SIGNATURE-----

--pCAEBjHLK8ZD--
