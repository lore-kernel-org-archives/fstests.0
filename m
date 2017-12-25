Received: from mga11.intel.com ([192.55.52.93]:2762 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbdLYF2y (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 25 Dec 2017 00:28:54 -0500
From: Chen Rong <rongx.a.chen@intel.com>
Subject: xfstests: generic/342 run failed in f2fs
Message-ID: <2d524305-ecb5-8600-a92a-d79b717b8d13@intel.com>
Date: Mon, 25 Dec 2017 13:28:16 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: philip.li@intel.com, rongx.a.chen@intel.comrongx.a.chen@intel.com
List-ID: <fstests@vger.kernel.org>

Hi, everyone:

the issue as below:

# ./check generic/342
FSTYP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- f2fs
PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/x86_64 node01 4.15.0-rc4
MKFS_OPTIONS=C2=A0 -- /dev/sde1
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sde1 /tmp/test1

generic/342=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - output mismatch (see=20
/home/ubuntu/git/xfstests-dev/results//generic/342.out.bad)
 =C2=A0=C2=A0=C2=A0 --- tests/generic/342.out=C2=A0=C2=A0 2017-12-13 13:4=
7:20.144000000 -0500
 =C2=A0=C2=A0=C2=A0 +++ /home/ubuntu/git/xfstests-dev/results//generic/34=
2.out.bad=20
2017-12-25 11:13:12.928000000 -0500
 =C2=A0=C2=A0=C2=A0 @@ -8,8 +8,7 @@
 =C2=A0=C2=A0=C2=A0=C2=A0 48c940ba3b8671d3d6ea74e4ccad8ca3=C2=A0 SCRATCH_=
MNT/a/bar
 =C2=A0=C2=A0=C2=A0=C2=A0 Directory a/ contents after log replay:
 =C2=A0=C2=A0=C2=A0=C2=A0 SCRATCH_MNT/a:
 =C2=A0=C2=A0=C2=A0 -bar
 =C2=A0=C2=A0=C2=A0=C2=A0 foo
 =C2=A0=C2=A0=C2=A0=C2=A0 File digests after log replay:
 =C2=A0=C2=A0=C2=A0=C2=A0 9e5d56a1f9b2c93589f9d55480f971a1=C2=A0 SCRATCH_=
MNT/a/foo
 =C2=A0=C2=A0=C2=A0 ...
 =C2=A0=C2=A0=C2=A0 (Run 'diff -u tests/generic/342.out=20
/home/ubuntu/git/xfstests-dev/results//generic/342.out.bad'=C2=A0 to see =
the=20
entire diff)
Ran: generic/342
Failures: generic/342
Failed 1 of 1 tests

Is it a problem with my computer or a already known issue with f2fs?

thanks!

