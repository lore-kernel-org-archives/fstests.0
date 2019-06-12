Message-ID: <5D00F3BC.5000003@cn.fujitsu.com>
Date: Wed, 12 Jun 2019 20:44:44 +0800
From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: question about generic/473 on xfs filesystem
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
To: Eryu Guan <guaneryu@gmail.com>, darrick <darrick.wong@oracle.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Hi Eryu, Darrick

Currently, on lastest kernel, generic/473 fails ,as below:
# ./check generic/473
FSTYP         -- xfs (non-debug)
PLATFORM      -- 5.2.0-rc4+
MKFS_OPTIONS  -- -f -bsize=4096 /dev/sda11
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda11 /mnt/xfstests/scratch
generic/473 2s ... - output mismatch (see /var/lib/xfstests/results//generic/473.out.bad)
    --- tests/generic/473.out   2019-06-12 19:30:37.219753498 +0800
    +++ /var/lib/xfstests/results//generic/473.out.bad  2019-06-12 20:34:12.499984113 +0800
    @@ -6,7 +6,7 @@
     1: [256..287]: hole
     Hole + Data
     0: [0..127]: hole
     -1: [128..255]: data
     +1: [128..135]: data
     Hole + Data + Hole
     0: [0..127]: hole

I have seen previous mail[1]that mentioned "new ranged fiemap test (generic/473) fails on XFS, because there's no 
final decision on the expected behavior yet and discussion has stalled somehow.". This case has been merged in 2017.12,
but this case also fails on lastest kernel, does it have any update or I miss something? 

more question:
xfs/107 and xfs/136 also fail on lastest kernel on my machine. 

[1]https://www.spinics.net/lists/fstests/msg08426.html
