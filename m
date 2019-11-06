Return-Path: <SRS0=RANT=Y6=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5DDC5DF62
	for <linux-fstests@archiver.kernel.org>; Wed,  6 Nov 2019 07:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF6C2173E
	for <linux-fstests@archiver.kernel.org>; Wed,  6 Nov 2019 07:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mykernel.net header.i=cgxu519@mykernel.net header.b="URkhd/6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfKFHkt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 6 Nov 2019 02:40:49 -0500
Received: from sender3-of-o52.zoho.com.cn ([124.251.121.247]:21989 "EHLO
        sender2.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728291AbfKFHkt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Nov 2019 02:40:49 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573025998; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=FVvLE6Vc5gd3Y0ub+DjSAkf6iSL/99QE/lnoA0kf1fXbTCGIX30kztD4XH2h7xUUvOEBKbCA/1iXOLHXwcSD7bcBU8lGZ8p3n4Ds4h2zXfOPge2F9S1ajNSRj3UbvDq+vg4rKbH6uOrX/LX+XoqjIZeRVDt+nJ3q9+C6SVSeqRY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1573025998; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=R9Hf7roTfMHuYLJTnHGHKwMOegSeHMTWk6NNdy10h7w=; 
        b=KFx0wSZ8Ohs+CVe/HKcT54Vp0iJ02eyNcprXudUs5rWbovhTYAZrTW2uSNvJMND3jBsli8KO1g1ckcMNvkgl6AN1lewKfiO+9xcxT4PeIrhYqZBb4iqNSDr65hYiqy/3/8vBAQooeDL0t3V0yAk6GjQPuKGRnU4tg5HhKERGku4=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1573025998;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=7294; bh=R9Hf7roTfMHuYLJTnHGHKwMOegSeHMTWk6NNdy10h7w=;
        b=URkhd/6OAU8R93+HfNoLemx/F0+DN+vjCsROtRMzfL4HPOoYAF5/zEeRac80RtV6
        5EiPa5rtaoiNYr2FqJA0jBlru4zVAXLJXRllGiegk4l7fa9thqkf4Mc0ozc3iXuigm6
        mvcTiNPisjg+Tkiy/2QG1/0+Kqe46k1ayQjU0iC0=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1573025997119821.0076372834623; Wed, 6 Nov 2019 15:39:57 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     fstests@vger.kernel.org, linux-unionfs@vger.kernel.org
Cc:     guaneryu@gmail.com, amir73il@gmail.com, miklos@szeredi.hu,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191106073945.12015-1-cgxu519@mykernel.net>
Subject: [PATCH v3] overlay/066: adjust test file size && add more test patterns
Date:   Wed,  6 Nov 2019 15:39:45 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Making many small holes in 10M test file seems not very
helpful for test coverage and it takes too much time on
creating test files. In order to improve test speed we
adjust test file size to (10 * iosize) for iosize aligned
hole files and meanwhile add more test patterns for small
random holes and small empty file.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
v1->v2:
- Check result in one diff command.
- Print more information(file layout) to full log when test failed.
- Truncate test file name.

v2->v3:
- Print diff result to golden output.
- Record xfs_io command to full log.
- Set initial pos and max_pos using calculation for random hole file.

 tests/overlay/066 | 120 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 83 insertions(+), 37 deletions(-)

diff --git a/tests/overlay/066 b/tests/overlay/066
index 285a5aff..95f6576c 100755
--- a/tests/overlay/066
+++ b/tests/overlay/066
@@ -40,90 +40,136 @@ _require_scratch
 # Remove all files from previous tests
 _scratch_mkfs
=20
-# We have totally 14 test files in this test.
+# We have totally 16 test files in this test.
 # The detail as below:
-# 1 empty file(10M) + 2^0(K)..2^11(K) hole size files(each 10M) + 1 random=
 hole size file(100M).
+# 1 small empty file 4K
+# 1 big empty file 4M
+# 1 small random hole file 10M
+# 1 big random hole file 100M
+#
+# 12 files with variant iosize aligned holes.
+# 2^0(K)..2^11(K) hole size files(file size =3D 10 * iosize)
 #
 # Considering both upper and lower fs will fill zero when copy-up
 # hole area in the file, this test at least requires double disk
 # space of the sum of above test files' size.
=20
-_require_fs_space $OVL_BASE_SCRATCH_MNT $(((10*1024*13 + 100*1024*1) * 2))
+_require_fs_space $OVL_BASE_SCRATCH_MNT $((((4) + (4096) + (10 * 1024) \
+=09=09 + (100 * 1024) + (10 * (1 + 2048) * 12 / 2)) * 2))
+
+do_cmd()
+{
+=09echo $@ >>$seqres.full
+=09eval $@ >>$seqres.full
+}
=20
 lowerdir=3D$OVL_BASE_SCRATCH_MNT/$OVL_LOWER
 upperdir=3D$OVL_BASE_SCRATCH_MNT/$OVL_UPPER
 testfile=3D"copyup_sparse_test"
=20
-# Create a completely empty hole file(10M).
-file_size=3D10240
-$XFS_IO_PROG -fc "truncate ${file_size}K" "${lowerdir}/${testfile}_empty_h=
olefile" \
-=09=09 >>$seqres.full
+# Create a small completely empty hole file(4K).
+file_size=3D4
+do_cmd $XFS_IO_PROG -fc "\"truncate ${file_size}K\"" \
+=09=09=09"${lowerdir}/${testfile}_empty_small"
=20
-# Create 2^0(K)..2^11(K) hole size test files(each 10M).
+# Create a big completely empty hole file(4M).
+file_size=3D4096
+do_cmd $XFS_IO_PROG -fc "\"truncate ${file_size}K\"" \
+=09=09=09"${lowerdir}/${testfile}_empty_big"
+
+# Create 2^0(K)..2^11(K) hole size test files(file size =3D 10 * iosize).
 #
 # The pattern is like below, both hole and data are equal to
 # iosize except last hole.
 #
 # |-- hole --|-- data --| ... |-- data --|-- hole --|
=20
-iosize=3D1
+min_iosize=3D1
 max_iosize=3D2048
-file_size=3D10240
-max_pos=3D`expr $file_size - $max_iosize`
+iosize=3D$min_iosize
=20
 while [ $iosize -le $max_iosize ]; do
+=09file_size=3D$(($iosize * 10))
+=09max_pos=3D$(($file_size - $iosize))
 =09pos=3D$iosize
-=09$XFS_IO_PROG -fc "truncate ${file_size}K" \
-=09=09"${lowerdir}/${testfile}_iosize${iosize}K_holefile" >>$seqres.full
+=09do_cmd $XFS_IO_PROG -fc "\"truncate ${file_size}K\"" \
+=09=09=09=09"${lowerdir}/${testfile}_iosize${iosize}K"
+=09echo -e "\niosize=3D${iosize}K hole test write scenarios ---\n" >>$seqr=
es.full
 =09while [ $pos -lt $max_pos ]; do
-=09=09$XFS_IO_PROG -fc "pwrite ${pos}K ${iosize}K" \
-=09=09"${lowerdir}/${testfile}_iosize${iosize}K_holefile" >>$seqres.full
-=09=09pos=3D`expr $pos + $iosize + $iosize`
+=09=09do_cmd $XFS_IO_PROG -fc "\"pwrite ${pos}K ${iosize}K\"" \
+=09=09=09=09=09"${lowerdir}/${testfile}_iosize${iosize}K"
+=09=09pos=3D$(($pos + $iosize * 2))
 =09done
-=09iosize=3D`expr $iosize + $iosize`
+=09iosize=3D$(($iosize * 2))
+done
+echo >>$seqres.full
+
+# Create test file with many random small holes(hole size is between 4K an=
d 512K),
+# total file size is 10M.
+
+file_size=3D10240
+min_hole=3D4
+max_hole=3D512
+pos=3D$min_hole
+max_pos=3D$(($file_size - 2*$max_hole))
+
+do_cmd $XFS_IO_PROG -fc "\"truncate ${file_size}K\"" \
+=09=09=09"${lowerdir}/${testfile}_random_small"
+
+echo -e "\nSmall random hole test write scenarios ---\n" >>$seqres.full
+while [ $pos -le $max_pos ]; do
+=09iosize=3D$(($RANDOM % ($max_hole - $min_hole) + $min_hole))
+=09do_cmd $XFS_IO_PROG -fc "\"pwrite ${pos}K ${iosize}K\"" \
+=09=09"${lowerdir}/${testfile}_random_small"
+=09pos=3D$(($pos + $iosize * 2))
 done
+echo >>$seqres.full
+
=20
 # Create test file with many random holes(hole size is between 1M and 5M),
 # total file size is 100M.
=20
-pos=3D2048
-max_pos=3D81920
 file_size=3D102400
 min_hole=3D1024
 max_hole=3D5120
+pos=3D$min_hole
+max_hole=3D$(($file_size - 2*$max_hole))
=20
-$XFS_IO_PROG -fc "truncate ${file_size}K" "${lowerdir}/${testfile}_random_=
holefile" \
-=09=09>>$seqres.full
+do_cmd $XFS_IO_PROG -fc "\"truncate ${file_size}K\"" \
+=09=09=09"${lowerdir}/${testfile}_random_big"
=20
+echo -e "\nBig random hole test write scenarios ---\n" >>$seqres.full
 while [ $pos -le $max_pos ]; do
 =09iosize=3D$(($RANDOM % ($max_hole - $min_hole) + $min_hole))
-=09$XFS_IO_PROG -fc "pwrite ${pos}K ${iosize}K" \
-=09=09"${lowerdir}/${testfile}_random_holefile" >>$seqres.full
-=09pos=3D`expr $pos + $iosize + $iosize`
+=09do_cmd $XFS_IO_PROG -fc "\"pwrite ${pos}K ${iosize}K\"" \
+=09=09=09=09"${lowerdir}/${testfile}_random_big"
+=09pos=3D$(($pos + $iosize * 2))
 done
+echo >>$seqres.full
=20
 _scratch_mount
=20
 # Open the test files, no errors are expected.
+echo -e "\nDoing copy-up...\n" >>$seqres.full
 for f in $SCRATCH_MNT/*; do
-=09$XFS_IO_PROG -c "open" $f >>$seqres.full
+=09do_cmd $XFS_IO_PROG -c "open" $f
 done
=20
 echo "Silence is golden"
=20
 # Check all copy-up files in upper layer.
-iosize=3D1
-while [ $iosize -le 2048 ]; do
-=09diff "${lowerdir}/${testfile}_iosize${iosize}K_holefile" \
-=09=09"${upperdir}/${testfile}_iosize${iosize}K_holefile" >>$seqres.full |=
|\
-=09=09echo "${upperdir}/${testfile}_iosize${iosize}K_holefile" copy up fai=
led!
-=09iosize=3D`expr $iosize + $iosize`
-done
-
-diff "${lowerdir}/${testfile}_empty_holefile"  "${upperdir}/${testfile}_em=
pty_holefile"  \
-=09>>$seqres.full || echo "${upperdir}/${testfile}_empty_holefile" copy up=
 failed!
-diff "${lowerdir}/${testfile}_random_holefile" "${upperdir}/${testfile}_ra=
ndom_holefile" \
-=09>>$seqres.full || echo "${upperdir}/${testfile}_random_holefile" copy u=
p failed!
+diff -qr ${upperdir} ${lowerdir} | tee -a $seqres.full
+if [ $? -ne 0 ]; then
+=09echo "Copy-up failed!!!"
+
+=09echo "\n----------------------------------------" >>$seqres.full
+=09echo -e "The layout of files in lowerdir\n" >>$seqres.full
+=09do_cmd $FILEFRAG_PROG -k -e $lowerdir/*
+=09echo "\n----------------------------------------" >>$seqres.full
+=09echo -e "The layer of files in upperdir\n" >>$seqres.full
+=09do_cmd $FILEFRAG_PROG -k -e $upperdir/*
+
+fi
=20
 # success, all done
 status=3D0
--=20
2.20.1



