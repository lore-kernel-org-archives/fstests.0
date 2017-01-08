Received: from mx1.redhat.com ([209.132.183.28]:35004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937208AbdAHJ4S (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 8 Jan 2017 04:56:18 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCD2CC049D5B
        for <fstests@vger.kernel.org>; Sun,  8 Jan 2017 09:56:17 +0000 (UTC)
Received: from localhost (vpn1-4-190.pek2.redhat.com [10.72.4.190])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v089uGfk011036
        for <fstests@vger.kernel.org>; Sun, 8 Jan 2017 04:56:17 -0500
Message-Id: <201701080956.v089uGfk011036@int-mx09.intmail.prod.int.phx2.redhat.com>
Date: Sun, 08 Jan 2017 17:56:14 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [ANNOUNCE] fstests: master branch updated to 1300cbc873b1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mpCHC1hmxoCh"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--mpCHC1hmxoCh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. The main change in this update is the support of
include/exclude of sub groups from Amir, examples from the commit log:

    ./check -n -g xfs/quick
    ./check -n -g stress -x xfs/stress
    ./check -n -g xfs/punch -x dangerous_fuzzers

There're also new overlay regression test and generic test for y2038 problem
(which currently won't be run because of lack of kernel and xfs_io support), as
well as some small fixes.

Thanks,
Eryu

The new head of the master branch is commit:

1300cbc873b1 generic/158,304: filter dedupe error message

New commits:

Amir Goldstein (3):
      [d0ad5cc76a05] check: factor out get_sub_group_list() helper
      [5d801985113e] check: support include/exclude of sub groups
      [3abf189ff235] check: document tests include/exclude options

Deepa Dinamani (1):
      [fbe236d6a955] generic: Add tests for inode timestamp policy

Eryu Guan (1):
      [1300cbc873b1] generic/158,304: filter dedupe error message

Su Yue (1):
      [5858c3eb39aa] btrfs/006: Fix false alert due to output change

Xiong Zhou (1):
      [a1d861da98f3] overlay: copy up and remove from another namespace


Code Diffstat:

 check                 |  60 ++++++++++++++--
 common/filter         |   2 +-
 common/rc             |  48 +++++++++++++
 common/reflink        |   6 ++
 tests/btrfs/006       |  16 +++--
 tests/btrfs/006.out   |  24 +++----
 tests/generic/158     |  30 +++++---
 tests/generic/158.out |  16 ++---
 tests/generic/304     |  21 ++++--
 tests/generic/304.out |  12 ++--
 tests/generic/402     | 188 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/402.out |   2 +
 tests/generic/group   |   1 +
 tests/overlay/020     |  70 +++++++++++++++++++
 tests/overlay/020.out |   2 +
 tests/overlay/group   |   1 +
 16 files changed, 443 insertions(+), 56 deletions(-)
--
Eryu Guan
eguan@redhat.com

--mpCHC1hmxoCh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJYcgpGAAoJECZSqilcj+djFtwQANbqQxhbyS1aqew9LG+ayvx7
M4NNb09VkTYCJ7P2Ie+UGA+u00SQa2c0m5EpzQ3KEtpOSc2vCHohgThdFgdTV0Ks
8PZJxPJrgxHLoGg2hulW2gjz43ZNz17y7OQveBuVqApt77ppRI/LE9mKEKDh5Glt
cfe6WnJrDtExx+JhldDfRZv0iOqyutKh6LtVkfzHjQD36SpRlGX+oN7dklDgC+RI
IQ/+iZEEtZM97QJMvhPR8ZqCfULmOL9QV4wRJS0599ynV58fX83lSiRVdlbIY8hj
9XVyDSoengPIjOtpO3zWM2eaeRELI4qeIHi0nfrorjyDqQvNiQ59a2587pxMxkia
o6k/yk+dv0hKgIpKvjoclyrddAIB+Yyf5lTJuE69Ip1GJKfAXSH41yuxCjXFwCSQ
1Z8DtLPUsMM4fGImL5hqE6F+D9u+7Q6+5KaIxDAQD/Qx6AqpROhv1c0PpN1mfIgC
MbggfS8ELk7UWLQ1KSjDvnomQdQ1y9xZB/RxcEW+/tGVkJuYmtPIirIN+inY7HQe
LrfPmxERVUPm3l/DTZ4K4sGk4vVUZ8OSWziHh0MrcD1XAnoah1Y2042C91s7TTOK
KJAIwCUtmWzXk8NAcnlXJGpm4L5Q104IeUorQs/0OSys61IrWecPpYWSR7k42nh5
tkG/YvI7X7k5c+dLjC1P
=Ji4F
-----END PGP SIGNATURE-----

--mpCHC1hmxoCh--
