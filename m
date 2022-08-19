Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FB9C3F6B0
	for <linux-fstests@archiver.kernel.org>; Fri, 19 Aug 2022 11:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348061AbiHSLxs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 19 Aug 2022 07:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348694AbiHSLxq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 19 Aug 2022 07:53:46 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAF832BAD
        for <fstests@vger.kernel.org>; Fri, 19 Aug 2022 04:53:44 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220819115340euoutp02028c4b675b378a979d23a8d90609ba4f~MvN0ip5-l2964229642euoutp02k
        for <fstests@vger.kernel.org>; Fri, 19 Aug 2022 11:53:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220819115340euoutp02028c4b675b378a979d23a8d90609ba4f~MvN0ip5-l2964229642euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660910020;
        bh=W6eaEdO3HavTo+5bedHpzJyzViWVnEcx34c/LA3XghQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=T1toZKsIGcwSX8osj74uI1WZfJTjX8WOfgBpeBuZUzTwL1WvavdOKpTMH8fttP/AY
         vVmgOMzRN3tItWArnng+WvapLIzeGJss6YF7xXCy0juA2mEvK5XTjSQjNxBY76voyk
         paQ92KdUIgq0Z6lbvnmJDy02fXDQ4D2gMThHlPqw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220819115339eucas1p1681bb9e4d83d4f512d08da280d88a2ca~MvNzIvq7N1396313963eucas1p1G;
        Fri, 19 Aug 2022 11:53:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 57.9A.10067.2C97FF26; Fri, 19
        Aug 2022 12:53:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220819115338eucas1p11b916296213572e97a03241ebdc399d0~MvNygipyW1733517335eucas1p1N;
        Fri, 19 Aug 2022 11:53:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220819115338eusmtrp1fd7db32b4a479edeb1eae79e4b058361~MvNyfze_u0147601476eusmtrp1R;
        Fri, 19 Aug 2022 11:53:38 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-6b-62ff79c20aa4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 13.73.09038.2C97FF26; Fri, 19
        Aug 2022 12:53:38 +0100 (BST)
Received: from localhost (unknown [106.210.248.74]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220819115337eusmtip13c919f3c4a158ce9d5e22ac2402e5ab2~MvNyJo8GB1960919609eusmtip1T;
        Fri, 19 Aug 2022 11:53:37 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     fstests@vger.kernel.org
Cc:     Johannes.Thumshirn@wdc.com, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, naohiro.aota@wdc.com, gost.dev@samsung.com,
        mcgrof@kernel.org, dsterba@suse.cz,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 0/1] adapting btrfs/237 to work with the new reclaim algorithm
Date:   Fri, 19 Aug 2022 13:53:36 +0200
Message-Id: <20220819115337.35681-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjt3b3brtbGbRY+aZQMDDLSVQY3+jAh4VZGJdiPJGvaxS3nrLuW
        VhRlK21aW42w1iChj9n8ZJq4oIj1YeZM8aPNMk2aVlJBaS11as27qH/nOc85nPO8vAQmucWP
        IJTqwwyrlqukglC84dlY23Ln0ekMWaFvDTXR2oZRNyd8ONWieyCkeh45eNSkvo9HeYyDiLrU
        VMenRm7rhFRlzyC+MYR2mN8KabvtvIB2nO3n0xfrbYh2lT0R0iP2RXTho2LeDuHu0HX7GZXy
        CMPGbdgXqvCbx/kHn0Tke+0/8VPIOF+PQggg4+Fb1SdMj0IJCVmOoNpXFhxGEXiqq4QBlYQc
        QWB1Z/11vKvoFXAiK4I7lSbEDR8RuFx+nh4RhICMgdPnZ8zzyEj4buibMWBkG4LGp24ssAgj
        k6G7vpMfwDgZDZbXtXgAi8g18KJunM+lLYZrHT4hx8+F5mveGQ32hz9z7/pMVSDbCXh8tV3A
        GTaBvc+EcTgMhpvqhRxeCC2mEpzDx2HQMxE06xAYHDWCQGsg18JFlyoAMXIp1NyP4+SJ0N3r
        xDiFGDxf5nIVxHC5oTRIi6DonIRTS8Ex5g2GAnQWWIKhNFyeLgy+5x4YL58UGFGU+b/DzP8d
        Zv7XoQxhNhTOaDU5WYxmpZrJi9XIczRadVZsZm6OHf35SC1TTaONyDr8LdaJeARyIiAw6TyR
        p9efIRHtlx89xrC5e1mtitE4USSBS8NFmcpauYTMkh9mshnmIMP+3fKIkIhTvD1dZT8av2i3
        rmYXH0uOr2Wj3uyTllCy9dtTTg7E541hVQMFE/mvjBLjkLdfl1BwICynW3ujdlXd9i4X7l7X
        PJqesSiuY5nWUpF6c/XPVgP9MtmWeOiKFfe/cdZM+cIMsLOhc3ZpUqtOm+xqmpM9kP859t7x
        JAW6qnzpEamKcs0HNiiKqhdMN6enZhwpZ59fkD3c7FCkXIiwWfyseNLuFnfqioe0UbOm2967
        ukzehY7l7bIO5bAt/ZXenjA0db80k79l8lnMbesWkWKJe+BuxZWUUVxQ0r8r6W6ewbRCbAmP
        NvxKTfiaRjc7o9N6rifKtrVKb0V+sKqzT2ws7pHiGoV8RQzGauS/AaSYJ0u3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsVy+t/xu7qHKv8nGbSf47P4ffY8s8Xi399Z
        LE637GW3uHlgJ5PF3657TBY3JjxltJh4fDOrxeelLewWa24+ZXHg9Ng56y67x6ZVnWweO1vv
        s3r0bVnF6HFmwRF2j8+b5DzaD3QzBbBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqb
        x1oZmSrp29mkpOZklqUW6dsl6GX8mfWLteCIVMWTTd9YGhgniHYxcnJICJhIPFh9h62LkYtD
        SGApo8TjjtmMEAkJidsLm6BsYYk/17qgip4xSlx5vom1i5GDg01AS6Kxkx2kRkRAWuJT/z2w
        GmaBm4wSC4/PAUsIC/hIXN1ymRXEZhFQlZhzawMLiM0rYClxavMvVogF8hIzL31nB5nJLKAp
        sX6XPkSJoMTJmU/AypmBSpq3zmaewMg/C6FqFpKqWUiqFjAyr2IUSS0tzk3PLTbSK07MLS7N
        S9dLzs/dxAiMnG3Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeG/c+ZMkxJuSWFmVWpQfX1Sak1p8
        iNEU6OqJzFKiyfnA2M0riTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCU
        amBiZo/UiCqrvi0j//mHq2repdP/Aq9NZr3iypJQplwoviqcYeef5BPfQ49xcjvG6bId9o7x
        LAkQTL0q/n/WsRfXezK073jfmfiGIX3/o1Uf+BjNRFXfpwo2sn7wnyy1OKFBcP3N00HHNu1l
        knz4tbTuyc9Itvf+FeETz7zSqHjp5fleqZ7b9NnULU627CJGxYvW6pry9Ojfrw9L5eU+FSO2
        h/v0iVm3N/ZKWbayZEzcn6q1rC23xV6rNnXy6tUTczdbrZA/u4RHZcJ+4VUPF7yYEczUaXFd
        8nH4w5OXLdu7pQWPKr3J2+dff+5d0Ir5TMtu7dFLZfr0lTlLmG/qdcNpfRtl2i7u/ZnrZfXR
        20GJpTgj0VCLuag4EQALQcjZJQMAAA==
X-CMS-MailID: 20220819115338eucas1p11b916296213572e97a03241ebdc399d0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220819115338eucas1p11b916296213572e97a03241ebdc399d0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220819115338eucas1p11b916296213572e97a03241ebdc399d0
References: <CGME20220819115338eucas1p11b916296213572e97a03241ebdc399d0@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi ,
Since 3687fcb0752a ("btrfs: zoned: make auto-reclaim less aggressive")
commit, reclaim algorithm has been changed to trigger auto-reclaim once
the fs used size is more than a certain threshold. This change breaks
237 test.

I tried to adapt the test by doing the following:
- Write a small file first
- Write a big file that increases the disk usage to be more than the
  reclaim threshold
- Delete the big file to trigger threshold
- Ensure the small file is relocated and the space used by the big file
  is reclaimed.

My test case works properly for small ZNS drives but not for bigger
sized drives in QEMU. When I use a drive with a size of 100G, not all
zones that were used by the big file are correctly reclaimed.
Either I am not setting up the test correctly or there is something
wrong on how reclaim works for zoned devices.

I created a simple script to reproduce the scenario instead of running
the test. Please adapt the $DEV and $big_file_size based on the drive
size. As I am setting the bg_reclaim_threshold to be 51, $big_file_size
should be at least 51% of the drive size.

```
DEV=nvme0n3
DEV_PATH=/dev/$DEV
big_file_size=2500M

echo "mq-deadline" > /sys/block/$DEV/queue/scheduler
umount /mnt/scratch
blkzone reset $DEV_PATH
mkfs.btrfs -f -d single -m single $DEV_PATH > /dev/null;  mount -t btrfs $DEV_PATH \
	/mnt/scratch
uuid=$(btrfs fi show $DEV_PATH | grep 'uuid' | awk '{print $NF}')

echo "51" > /sys/fs/btrfs/$uuid/bg_reclaim_threshold

fio --filename=/mnt/scratch/test2 --size=1M --rw=write --bs=4k \
	--name=btrfs_zoned > /dev/null
btrfs fi sync /mnt/scratch

echo "Open zones before big file trasfer:"
blkzone report $DEV_PATH | grep -v -e em -e nw | wc -l

fio --filename=/mnt/scratch/test1 --size=$big_file_size --rw=write --bs=4k \
	--ioengine=io_uring --name=btrfs_zoned > /dev/null
btrfs fi sync /mnt/scratch

echo "Open zones before removing the file:"
blkzone report $DEV_PATH | grep -v -e em -e nw | wc -l
rm /mnt/scratch/test1
btrfs fi sync /mnt/scratch

echo "Going to sleep. Removed the file"
sleep 30

echo "Open zones after reclaim:"
blkzone report $DEV_PATH | grep -v -e em -e nw | wc -l
```

I am getting the following output in QEMU:

- 5GB ZNS drive with 128MB zone size (and cap) and it is working as
  expected:

```
Open zones before big file trasfer:
4
Open zones before removing the file:
23
Going to sleep. Removed the file
Open zones after reclaim:
4
```

- 100GB ZNS drive with 128MB zone size (and cap) and it is **not
  working** as expected:

```
Open zones before big file trasfer:
4
Open zones before removing the file:
455
Going to sleep. Removed the file
Open zones after reclaim:
411
```

Only partial reclaim is happening for bigger sized drives. The issue
with that is, if I do another FIO transfer, the drive spits out ENOSPC
before its actual capacity is reached as most of the zones have not been
reclaimed back and are basically in an unusable state.

Is there a limit on how many bgs can be reclaimed?

Let me know if I am doing something wrong in the test or if it is an
actual issue.

Pankaj Raghav (1):
  btrfs/237: adapt the test to work with the new reclaim algorithm

 tests/btrfs/237 | 80 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 23 deletions(-)

-- 
2.25.1

