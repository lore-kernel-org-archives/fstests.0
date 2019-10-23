Return-Path: <SRS0=nbej=YQ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149A9CA9EB9
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Oct 2019 22:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53E12084C
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Oct 2019 22:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gy8K32Gh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405980AbfJWWEI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Oct 2019 18:04:08 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:36825 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405661AbfJWWEI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Oct 2019 18:04:08 -0400
Received: by mail-pg1-f182.google.com with SMTP id 23so12942533pgk.3
        for <fstests@vger.kernel.org>; Wed, 23 Oct 2019 15:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=291A7E82qorD2QD8WyfmrbE3vGNQDNUrJ59T/COB6mY=;
        b=Gy8K32GhHm+v23NND0OecUOvaPIQV/Z3bxKodSnm8jgOJ6bUTQugtifBkw/AM1z1ou
         E6j1EJQudqN3aO4ZjlpfYKbp4vv/3U7xFqLecKljLdploi5nRDq+Z1ChAfmumA0X/u2l
         GBr8vRUQMkLACYemcZloxwsj/yV8JRQr+bVnX4Kzfvq7+T/mPAWp5SMEK1JvunZJVEoI
         zBmEHTWtWSTjfTb7g8//dbUXiFHQbdZb85TcM0SF0p0CfpXCus59g4Q55uUvDnW4JDvX
         7EfieNwycF1Jn4UDFXe0pHN3CZcSAd85yQaGfvw2m4UknLKenxzZwQN1zXNEdS/lI+yW
         uZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=291A7E82qorD2QD8WyfmrbE3vGNQDNUrJ59T/COB6mY=;
        b=VznhvRl9let8RrTwxi1oUY58eZmEbinH3KnubzW1vEedXa3KFhsTUz7129fbO2kztm
         XGNUhnlKx9JyGFeH/UVvCHbxawUp6nrS5emuvu2NmtgiAtZJpFrWqgC5+N+hX3mhcYYE
         D5YLygS4Rk3QaGZviJszMRFHXygMGa6P5vGMqO6hXkjSKgtpA2xQXkRaMwVQUXH0ot5A
         X3KZwuPLrzfVNu/EmgsUtQq1uwlXxs1E4gxMEE4cTQ/2kHlcSF4ZeflH3ifX3p5adJNE
         8Itmn85SNgJu7QKU1BtHDA7F6ZYNQaFOdXmj9KXdRil0M+CkhFbF3JEPWOFDn18WrJlf
         8XdQ==
X-Gm-Message-State: APjAAAWSFKPcTo6h9j+SMZZyb8G9AhZdIMMA3dOtHeYou5r3oAQsOsgD
        KW/ewIVjaq7OfyhhienIgWIPn0vZ
X-Google-Smtp-Source: APXvYqyilsU5Wolx6TuWv3R4DSjfNE/B8vReo0SxoXn15GO4+yrXeMNgGVRAZCnbN8hb35wk2TeN5g==
X-Received: by 2002:a63:8148:: with SMTP id t69mr455881pgd.160.1571868247270;
        Wed, 23 Oct 2019 15:04:07 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id h14sm23948467pfo.15.2019.10.23.15.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 15:04:06 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     fstests@vger.kernel.org, guaneryu@gmail.com
Cc:     arnd@arndb.de, deepa.kernel@gmail.com, y2038@lists.linaro.org
Subject: [PATCH] generic/402: update test script style
Date:   Wed, 23 Oct 2019 15:04:01 -0700
Message-Id: <20191023220401.12335-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Removed test result checking, as test result already depends on
output diff comparison with the golden output.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 tests/generic/402     | 33 +++++++--------------------------
 tests/generic/402.out |  2 +-
 2 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/tests/generic/402 b/tests/generic/402
index dd136ec2..0392c258 100755
--- a/tests/generic/402
+++ b/tests/generic/402
@@ -44,14 +44,11 @@ check_stat()
 	prev_timestamp="$timestamp;$timestamp"
 	if [ $prev_timestamp != $stat_timestamp ]; then
 		echo "$prev_timestamp != $stat_timestamp" | tee -a $seqres.full
-		return 1
 	fi
-	return 0
 }
 
 run_test_individual()
 {
-	fail=0
 	file=$1
 	timestamp=$2
 	update_time=$3
@@ -62,33 +59,24 @@ run_test_individual()
 		$XFS_IO_PROG -f -c "utimes $timestamp 0 $timestamp 0" $file
 		if [ $? -ne 0 ]; then
 			echo "Failed to update times on $file" | tee -a $seqres.full
-			fail=1
 		fi
 	fi
 
 	tsclamp=$((timestamp<tsmin?tsmin:timestamp>tsmax?tsmax:timestamp))
 	echo "Checking file: $file Updated timestamp is $tsclamp"  >> $seqres.full
-	if ! check_stat $file $tsclamp; then
-		fail=1
-	fi
-	return $fail
+	check_stat $file $tsclamp
 }
 
 run_test()
 {
-	fail=0
 	update_time=$1
 
 	n=1
 
 	for TIME in "${TIMESTAMPS[@]}"; do
-		if ! run_test_individual ${SCRATCH_MNT}/test_$n $TIME $update_time; then
-			fail=1
-		fi
+		run_test_individual ${SCRATCH_MNT}/test_$n $TIME $update_time
 		((n++))
 	done
-
-	return $fail
 }
 
 _scratch_mkfs &>> $seqres.full 2>&1 || _fail "mkfs failed"
@@ -108,8 +96,7 @@ declare -a TIMESTAMPS=(
 	$((tsmax+1))
 )
 
-_scratch_mount
-result=$?
+_scratch_mount || _fail "scratch mount failed"
 
 status=0
 
@@ -119,9 +106,7 @@ echo "In memory timestamps update test start" >> $seqres.full
 # update time on the file
 update_time=1
 
-if ! run_test $update_time; then
-	status=1
-fi
+run_test $update_time
 
 echo "In memory timestamps update complete" >> $seqres.full
 
@@ -140,13 +125,9 @@ update_time=0
 echo "On disk timestamps update test start" >> $seqres.full
 
 # Re-run test
-if ! run_test $update_time; then
-	status=1
-fi
+run_test $update_time
 
 echo "On disk timestamps update test complete" >> $seqres.full
 
-echo "inode timestamp tests completed status $status"
-
-# success, all done
-exit $status
+echo Silence is golden
+exit
diff --git a/tests/generic/402.out b/tests/generic/402.out
index 4500e6c7..28e1501c 100644
--- a/tests/generic/402.out
+++ b/tests/generic/402.out
@@ -1,2 +1,2 @@
 QA output created by 402
-inode timestamp tests completed status 0
+Silence is golden
-- 
2.17.1

