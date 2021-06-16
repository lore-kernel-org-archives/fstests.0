Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D82CC48BE5
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Jun 2021 12:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4138960C41
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Jun 2021 12:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhFPM3A (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Jun 2021 08:29:00 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:11040 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhFPM24 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Jun 2021 08:28:56 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G4kr90T3rzZdsx;
        Wed, 16 Jun 2021 20:23:53 +0800 (CST)
Received: from dggema759-chm.china.huawei.com (10.1.198.201) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 20:26:48 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 dggema759-chm.china.huawei.com (10.1.198.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 16 Jun 2021 20:26:47 +0800
From:   Sun Ke <sunke32@huawei.com>
Subject: [Question] generic/064 fail on f2fs
To:     <fstests@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
Message-ID: <75f8ed6b-ed20-febf-1257-adcb7aed9e86@huawei.com>
Date:   Wed, 16 Jun 2021 20:26:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema759-chm.china.huawei.com (10.1.198.201)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

I run generic/064 on f2fs:

[root@localhost xfstests-dev]# ./check tests/generic/064
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 localhost 5.12.0-rc5-next-20210330 #8 SMP 
Tue Jun 8 11:09:37 CST 2021
MKFS_OPTIONS  -- /dev/sdb
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sdb /tmp/scratch

generic/064 - output mismatch (see 
/root/work/xfstests-dev/results//generic/064.out.bad)
     --- tests/generic/064.out   2021-05-31 15:37:40.000000000 +0800
     +++ /root/work/xfstests-dev/results//generic/064.out.bad 
2021-06-10 17:19:09.469000000 +0800
     @@ -1,2 +1,3 @@
      QA output created by 064
      Extent count after inserts is in range
     +extents mismatched before = 1 after = 50
     ...
     (Run 'diff -u /root/work/xfstests-dev/tests/generic/064.out 
/root/work/xfstests-dev/results//generic/064.out.bad'  to see the entire 
diff)
Ran: generic/064
Failures: generic/064
Failed 1 of 1 tests


***

I added some test code and  tried on xfs and ext4:

root@localhost xfstests-dev]# git diff
diff --git a/tests/generic/064 b/tests/generic/064
index 7098fcd3..1baacb06 100755
--- a/tests/generic/064
+++ b/tests/generic/064
@@ -45,6 +45,8 @@ length=$(($BLOCKS * $BSIZE))
  _do "$XFS_IO_PROG -f -c \"pwrite 0 $length\" -c fsync $src"
  cp $src $dest
  extent_before=`_count_extents $dest`
+echo "extent_before: ${extent_before}" > log.txt
+echo "filesize: $(du -sh $dest)" >> log.txt

  # Insert alternate blocks
  for (( j=0; j < $(($BLOCKS/2)); j++ )); do
@@ -55,6 +57,8 @@ done
  # Check if 50 extents are present, allowing some slop for file systems
  # that don't have ideal allocation behavior
  num_extents=`_count_extents $dest`
+echo "num_extents: ${num_extents}" >> log.txt
+echo "filesize: $(du -sh $dest)" >> log.txt
  _within_tolerance "Extent count after inserts" $num_extents 50 0 6% -v

  _check_scratch_fs
@@ -70,6 +74,8 @@ for (( j=0; j < $(($BLOCKS/2)); j++ )); do
  done

  extent_after=`_count_extents $dest`
+echo "extent_after: ${extent_after}" >> log.txt
+echo "filesize: $(du -sh $dest)" >> log.txt
  if [ $extent_before -ne $extent_after ]; then
         echo "extents mismatched before = $extent_before after = 
$extent_after"
  fi


ext4:

extent_before: 1
filesize: 400K  /tmp/scratch/testfile.dest
num_extents: 50
filesize: 404K  /tmp/scratch/testfile.dest
extent_after: 1
filesize: 404K  /tmp/scratch/testfile.dest

xfs:

extent_before: 1
filesize: 400K  /tmp/scratch/testfile.dest
num_extents: 50
filesize: 404K  /tmp/scratch/testfile.dest 
 

extent_after: 1
filesize: 400K  /tmp/scratch/testfile.dest


f2fs:

extent_before: 1
filesize: 400K  /tmp/scratch/testfile.dest
num_extents: 50
filesize: 400K  /tmp/scratch/testfile.dest
extent_after: 50
filesize: 400K  /tmp/scratch/testfile.dest


***
The filesize is always 400K and extent_after is still 50. Is it a bug in 
f2fs or I need adjust the case for f2fs?

I also wondering that why after insert 50 holes, the filesize is 404K? 
I think it should be 400K + 4K * 50 = 600K.

The fallocate(2) manual page say: Inserting a hole inside a file 
increases the file size by len bytes.

BLOCKS=100
BSIZE=4096

for (( j=0; j < $(($BLOCKS/2)); j++ )); do
     offset=$((($j*$BSIZE)*2))
     _do "$XFS_IO_PROG -c \"finsert $offset $BSIZE\" $dest"
done
