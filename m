Received: from mail-pf1-f195.google.com ([209.85.210.195]:35530 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfA0PIB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 27 Jan 2019 10:08:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so6860936pfi.2
        for <fstests@vger.kernel.org>; Sun, 27 Jan 2019 07:08:01 -0800 (PST)
Message-ID: <5c4dc94f.1c69fb81.935c2.306e@mx.google.com>
Date: Sun, 27 Jan 2019 23:07:53 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 2065ab00791f
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FuA9lEB3MtNx"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--FuA9lEB3MtNx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. The update adds splice(2) support to fsstress and
contains various bug fixes for btrfs tests. There should be no new failures
after this update.

My apology for being absent from some of the discussions and the late review,
I've been busy with other tasks, and probably the review process will be slow
in next two weeks due to the public holiday. So many thanks to Filipe, Dave and
Amir for reviewing patches.

Thanks,
Eryu

The new head of the master branch is commit:

2065ab00791f btrfs/131: require support for free-space-tree

New commits:

Filipe Manana (2):
      [2223d8fe1822] btrfs/081: declare local variables as local
      [a1c91630a374] btrfs/081: fix killing of reader loop subshell

Jeff Mahoney (4):
      [5b1a503aba5f] btrfs/010: don't run without /sys/fs/btrfs
      [c38ce3551695] btrfs: require feature raid56 for raid56 tests
      [33cd745db03e] btrfs/023: skip trying to test raid56 without kernel support
      [2065ab00791f] btrfs/131: require support for free-space-tree

Zorro Lang (2):
      [544624ac14de] fsstress: add splice support
      [04b405fa1f8d] common/dump: disable splice from FSSTRESS_AVOID


Code Diffstat:

 common/btrfs    |   8 +++
 common/dump     |   3 +
 ltp/fsstress.c  | 173 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/010 |   1 +
 tests/btrfs/023 |  10 ++--
 tests/btrfs/081 |  14 +++--
 tests/btrfs/125 |   1 +
 tests/btrfs/131 |   1 +
 tests/btrfs/148 |   1 +
 tests/btrfs/157 |   1 +
 tests/btrfs/158 |   1 +
 11 files changed, 206 insertions(+), 8 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--FuA9lEB3MtNx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJcTcjsAAoJECZSqilcj+dj/vkP/RtiuiL9+29BdLV4l2RDJWEc
UrLdTcE2G6tgMn+hDVyKvAq9PAhaYzeCtB0P6DTrDlOxJtYW6QANRDRGuiZ9JBEl
LFjBELLfrw/JLmw+C8I4gmRGjDqN9bxh4zK6S+dsk5iHEDJ7xlQjnPFovacK5vaI
Rs+T5OPAuo4V0HrThS1RG2mE8gCFOsOOhMeRhbxdPVt2NZmz06VVVtCm7LtbzFet
IUw27WGEYH/iT9FaAk6dX/MP+JmJahg6vYF80AS+gUC7/07DV669enblIU6sMT7v
3OKMqTGbHx5+f+XLI2E4HF27QkX3KMt0Vv55FHIHlgOy8JyISK2OJA6/xalFC/E6
JhXD4ruL8bGixOAUsTPrDjci/wwXoPwVuk6lA+5Q4ig11O1/k5rwGB3hPCTWU90h
XifjOnm04CVuMBeU9qYvfZW1naePwoVB1YwDasfN/EAM18p/DssQnMaNStN9VTFu
ntcx8P2/X6NNEVID6RuFKGEvnlwCDwDv+oZ3qPJZIuxXpAuh6RsEd1NLpcfVg9wd
PQdzUiNIo/KqO5iP8OlzYKX6SdtmwigprHv7KqzdcQ+sUOvOtvdeYuIVVNCQEjGr
7YYxpgZlBuxEGEsyAsdy1rsHR3BRfpaumrUrLKNkTWuL69NnuID1ImQYzvyOfhmh
jmuIgxT7niz2ZKFMPZ9q
=Rrrv
-----END PGP SIGNATURE-----

--FuA9lEB3MtNx--
