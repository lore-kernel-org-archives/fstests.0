Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177F3C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Mar 2022 22:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiC1Wpy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Mar 2022 18:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiC1Wpw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Mar 2022 18:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE391EDF35
        for <fstests@vger.kernel.org>; Mon, 28 Mar 2022 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648507447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Laq7m6xP0B6AqTNrk3ykB4RR7vNoDDoVVxLCTEFofSM=;
        b=DYrh/n4RJJSZpeu90Ue4qJxksn/HCiy6Uox/Kd10rvyTIt+ZeDgnDzmD9NwK6GIXVzEwsz
        v0T0rsXdFDXyPQ5EftDeYA4jiquM7OoQ5XUBoAyHbetzHqsdim4DbBsFHeGELhG9q0yA29
        mBh4tq1XTZ1qxVaBhFQLq2B1SA+LEro=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-XRyiE-xeNhatp6evymPrCQ-1; Mon, 28 Mar 2022 18:44:05 -0400
X-MC-Unique: XRyiE-xeNhatp6evymPrCQ-1
Received: by mail-ed1-f72.google.com with SMTP id i22-20020a508716000000b0041908045af3so9716493edb.3
        for <fstests@vger.kernel.org>; Mon, 28 Mar 2022 15:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Laq7m6xP0B6AqTNrk3ykB4RR7vNoDDoVVxLCTEFofSM=;
        b=6S8wX/6wmwI44lnI0mT9LaKR/zapx9e34rJPEjMli+uV2Jit+CfHPKbuKK7zptZswV
         TCOx2lBUuopxadYKhd7Fjfg1oc384y8NyyZHg6AMyUdyVJ6y6pm0BSjnNbJk4dt9kRRM
         hyjP3moCXsVsw3MkQ/RqOB2XaVqjswYjybvp9C5UuevxpzWupR9nwy8uSupssmwFUgE7
         FqB2rgL9NSFFtzkMGXUXHMxF3aAjT0/7eg7+PWmgBul/qAw2urYKuArA5naJcgQbeKfp
         BljvM43djp9xOhxPwmXepxRwliSGwnOJ0kOx11AkjgiWUXo2qtH9EUSfTU2SHWWzbPtH
         enyA==
X-Gm-Message-State: AOAM531YahYz9uGthyQzzTBXE4mYW2MpZBB9v1uGePJwjJbBm2psRpLR
        wuE9eK21WVdqCqndxOS7aS8PaHS88JXWQ0g8shJhikaLzqOdpLDHpSH8LygDGWQ9z7vH5PVujNI
        cEtY1XYGKhwmLs1HTCnvAUETR8tj4MWBhg/Wp9DHDv2vRNLdxSVs67W5j0V6hFxFPaYki
X-Received: by 2002:a17:906:c211:b0:6ce:e221:4c21 with SMTP id d17-20020a170906c21100b006cee2214c21mr29996139ejz.691.1648507439404;
        Mon, 28 Mar 2022 15:43:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT1rz48fAnzOnez0GNERMrG2Rlhk8L/qaVKeWZpR6eJKBRzmbALRkiIRiiGNaNAG0OIdTSbQ==
X-Received: by 2002:a17:906:c211:b0:6ce:e221:4c21 with SMTP id d17-20020a170906c21100b006cee2214c21mr29996105ejz.691.1648507438906;
        Mon, 28 Mar 2022 15:43:58 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ec10-20020a0564020d4a00b0041a68df1a71sm801288edb.77.2022.03.28.15.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 15:43:58 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH] xfs/152: add tests for -L/-U parameters for dump/report
Date:   Tue, 29 Mar 2022 00:40:13 +0200
Message-Id: <20220328224013.147827-1-aalbersh@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

These parameters define ID range of users/groups/projects to show.
This patch adds more test for wider coverage (e.g. empty range, full
range, open range).

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---

The patch has trailing whitespaces. This is due to the modification of 152.out.
The output of 'xfs_quota' is not fully cleared from trailing whitespaces.

This is mainly regression test in relation to the patch [1].

[1]: https://lore.kernel.org/all/20220328222503.146496-1-aalbersh@redhat.com/

---
 tests/xfs/152     |  65 +++++++---
 tests/xfs/152.out | 300 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 346 insertions(+), 19 deletions(-)

diff --git a/tests/xfs/152 b/tests/xfs/152
index 129d9c06..936cc3fa 100755
--- a/tests/xfs/152
+++ b/tests/xfs/152
@@ -50,6 +50,9 @@ gqid=`id -g fsgqa`
 uqid2=`id -u fsgqa2`
 gqid2=`id -g fsgqa2`
 
+[ $uqid -ge $uqid2 ] &&
+	_notrun "ID of fsgqa ($uqid) expected to be lower than fsgqa3 ($uqid2)"
+
 pqid=10
 cat >$tmp.projects <<EOF
 $pqid:$SCRATCH_MNT
@@ -102,6 +105,11 @@ filter_quot()
 		| sed -e '/#[0-9]*/s/#[0-9]*/#ID/g'
 }
 
+filter_dump()
+{
+	_filter_scratch | sed -E '/^[0-9]+/s/^[0-9]+/#ID/g'
+}
+
 filter_report()
 {
 	_filter_quota | grep -v "^root \|^\#0 " \
@@ -122,6 +130,20 @@ filter_state()
 			    -e '/max warnings:/d'
 }
 
+set_quota_limit()
+{
+	local bs=$1
+	local bh=$2
+	local is=$3
+	local ih=$4
+	local user=$5
+
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "limit -$type bsoft=$bs bhard=$bh $user" \
+			-c "limit -$type isoft=$is ihard=$ih $user" \
+			$SCRATCH_MNT
+}
+
 test_quot()
 {
 	local opt="$*"
@@ -153,16 +175,9 @@ test_quota()
 
 test_limit()
 {
-	local bs=$1
-	local bh=$2
-	local is=$3
-	local ih=$4
-
-	echo "checking limit command (type=$type, bsoft=$bs, bhard=$bh, isoft=$is, ihard=$ih)"
-	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
-			-c "limit -$type bsoft=$bs bhard=$bh fsgqa" \
-			-c "limit -$type isoft=$is ihard=$ih fsgqa" \
-			$SCRATCH_MNT
+	echo "checking limit command (type=$type, bsoft=$1, bhard=$2,"\
+			"isoft=$3, ihard=$4)"
+	set_quota_limit $@
 
 	# let the timer day transition happen
 	sleep 2
@@ -217,11 +232,14 @@ test_state()
 
 test_dump()
 {
+	local opt="$*"
+
 	echo "checking dump command (type=$type)"
 	rm -f $tmp.backup 2>>/dev/null
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
-			-c "dump -$type -f $tmp.backup" \
+			-c "dump -$type $opt -f $tmp.backup" \
 			$SCRATCH_MNT | _filter_scratch
+	cat $tmp.backup | filter_dump
 }
 
 test_restore()
@@ -270,14 +288,31 @@ test_xfs_quota()
 	echo "quota remount"; qmount_idmapped
 	echo ; test_quot
 	echo ; test_timer
-	echo ; test_limit 512k 2048k 10 20
+	echo ; test_limit 512k 2048k 10 20 $id
+
+	# we need two users with quota to test -L/-U options
+	set_quota_limit 1024k 4096k 10 20 $id2
+
+	echo "dump options test"
 	echo ; test_dump
+	echo "-L option"; test_dump -L $id
+	echo "-U option"; test_dump -U $id
+	echo "-L/-U options (one element range)"; test_dump -L $id -U $id
+	echo "-L/-U options (multiple elements range)"; test_dump -L $id -U $id2
+	echo "-L/-U options (empty range)"; test_dump -L $id2 -U $id
+	echo "-L/-U options (full range)"; test_dump -L 0 -U 0
 
-	# report options test
 	echo "report options test"
 	echo ; test_report
 	echo "-N option"; test_report -N
-	echo "-L -U options"; test_report -L $id -U $id
+	echo "-L options"; test_report -L $id
+	echo "-U options"; test_report -U $id
+	echo "-L/-U options (one element range)"; test_report -L $id -U $id
+	echo "-L/-U options (multiple elements range)"; test_report -L $id -U $id2
+	echo "-L/-U options (empty range)"; test_report -L $id2 -U $id
+	echo "-L/-U options (full range)"; test_report -L 0 -U 0
+	# reset quotas for second user as we don't need them anymore
+	set_quota_limit 0 0 0 0 $id2
 	echo "-t option"; test_report -t
 	echo "-n option"; test_report -n
 	echo "-h option"; test_report -h
@@ -307,7 +342,7 @@ test_xfs_quota()
 
 	# off and remove test
 	echo "off and remove test"
-	echo ; test_limit 100m 100m 100 100
+	echo ; test_limit 100m 100m 100 100 $id
 	echo ; test_quota -N
 	echo ; test_off
 	echo ; test_state
diff --git a/tests/xfs/152.out b/tests/xfs/152.out
index b663b096..5aeed7d7 100644
--- a/tests/xfs/152.out
+++ b/tests/xfs/152.out
@@ -11,8 +11,41 @@ SCRATCH_DEV (SCRATCH_MNT) User:
 checking timer command (type=u)
 
 checking limit command (type=u, bsoft=512k, bhard=2048k, isoft=10, ihard=20)
+dump options test
 
 checking dump command (type=u)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+-L option
+checking dump command (type=u)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+-U option
+checking dump command (type=u)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+-L/-U options (one element range)
+checking dump command (type=u)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+-L/-U options (multiple element range)
+checking dump command (type=u)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+-L/-U options (empty range)
+checking dump command (type=u)
+-L/-U options (full range)
+checking dump command (type=u)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
 report options test
 
 checking report command (type=u)
@@ -21,18 +54,57 @@ User quota on SCRATCH_MNT (SCRATCH_DEV)
 User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
 ---------- -------------------------------------------------- -------------------------------------------------- 
 fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
 
 -N option
 checking report command (type=u)
 fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+-L options
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
 
--L -U options
+-U options
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-L/-U options (one element range)
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-L/-U options (multiple element range)
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+-L/-U options (empty range)
+checking report command (type=u)
+-L/-U options (full range)
 checking report command (type=u)
 User quota on SCRATCH_MNT (SCRATCH_DEV)
  Blocks Inodes 
 User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
 ---------- -------------------------------------------------- -------------------------------------------------- 
 #ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
 
 -t option
 checking report command (type=u)
@@ -151,6 +223,7 @@ checking restore command (type=u)
 
 checking report command (type=u)
 fsgqa 1024 512 2048 00 [7 days] 15 10 20 00 [7 days]
+fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
 
 
 checking state command (type=u)
@@ -174,8 +247,41 @@ SCRATCH_DEV (SCRATCH_MNT) User:
 checking timer command (type=u)
 
 checking limit command (type=u, bsoft=512k, bhard=2048k, isoft=10, ihard=20)
+dump options test
 
 checking dump command (type=u)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+-L option
+checking dump command (type=u)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+-U option
+checking dump command (type=u)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+-L/-U options (one element range)
+checking dump command (type=u)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+-L/-U options (multiple element range)
+checking dump command (type=u)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+-L/-U options (empty range)
+checking dump command (type=u)
+-L/-U options (full range)
+checking dump command (type=u)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
 report options test
 
 checking report command (type=u)
@@ -184,18 +290,57 @@ User quota on SCRATCH_MNT (SCRATCH_DEV)
 User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
 ---------- -------------------------------------------------- -------------------------------------------------- 
 fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
 
 -N option
 checking report command (type=u)
 fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+-L options
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
 
--L -U options
+-U options
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-L/-U options (one element range)
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-L/-U options (multiple element range)
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+-L/-U options (empty range)
+checking report command (type=u)
+-L/-U options (full range)
 checking report command (type=u)
 User quota on SCRATCH_MNT (SCRATCH_DEV)
  Blocks Inodes 
 User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
 ---------- -------------------------------------------------- -------------------------------------------------- 
 #ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
 
 -t option
 checking report command (type=u)
@@ -314,6 +459,7 @@ checking restore command (type=u)
 
 checking report command (type=u)
 fsgqa 1024 512 2048 00 [7 days] 15 10 20 00 [7 days]
+fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
 
 
 checking state command (type=u)
@@ -337,8 +483,41 @@ SCRATCH_DEV (SCRATCH_MNT) Group:
 checking timer command (type=g)
 
 checking limit command (type=g, bsoft=512k, bhard=2048k, isoft=10, ihard=20)
+dump options test
 
 checking dump command (type=g)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+-L option
+checking dump command (type=g)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+-U option
+checking dump command (type=g)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+-L/-U options (one element range)
+checking dump command (type=g)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+-L/-U options (multiple element range)
+checking dump command (type=g)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+-L/-U options (empty range)
+checking dump command (type=g)
+-L/-U options (full range)
+checking dump command (type=g)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
 report options test
 
 checking report command (type=g)
@@ -347,18 +526,57 @@ Group quota on SCRATCH_MNT (SCRATCH_DEV)
 Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
 ---------- -------------------------------------------------- -------------------------------------------------- 
 fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
 
 -N option
 checking report command (type=g)
 fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+-L options
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
 
--L -U options
+-U options
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-L/-U options (one element range)
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-L/-U options (multiple element range)
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+-L/-U options (empty range)
+checking report command (type=g)
+-L/-U options (full range)
 checking report command (type=g)
 Group quota on SCRATCH_MNT (SCRATCH_DEV)
  Blocks Inodes 
 Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
 ---------- -------------------------------------------------- -------------------------------------------------- 
 #ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
 
 -t option
 checking report command (type=g)
@@ -477,6 +695,7 @@ checking restore command (type=g)
 
 checking report command (type=g)
 fsgqa 1024 512 2048 00 [7 days] 15 10 20 00 [7 days]
+fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
 
 
 checking state command (type=g)
@@ -500,8 +719,41 @@ SCRATCH_DEV (SCRATCH_MNT) Group:
 checking timer command (type=g)
 
 checking limit command (type=g, bsoft=512k, bhard=2048k, isoft=10, ihard=20)
+dump options test
 
 checking dump command (type=g)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+-L option
+checking dump command (type=g)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+-U option
+checking dump command (type=g)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+-L/-U options (one element range)
+checking dump command (type=g)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+-L/-U options (multiple element range)
+checking dump command (type=g)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
+-L/-U options (empty range)
+checking dump command (type=g)
+-L/-U options (full range)
+checking dump command (type=g)
+fs = SCRATCH_DEV
+#ID          1024    4096      10      20
+fs = SCRATCH_DEV
+#ID          2048    8192      10      20
 report options test
 
 checking report command (type=g)
@@ -510,18 +762,57 @@ Group quota on SCRATCH_MNT (SCRATCH_DEV)
 Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
 ---------- -------------------------------------------------- -------------------------------------------------- 
 fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
 
 -N option
 checking report command (type=g)
 fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+-L options
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
 
--L -U options
+-U options
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-L/-U options (one element range)
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-L/-U options (multiple element range)
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
+
+-L/-U options (empty range)
+checking report command (type=g)
+-L/-U options (full range)
 checking report command (type=g)
 Group quota on SCRATCH_MNT (SCRATCH_DEV)
  Blocks Inodes 
 Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
 ---------- -------------------------------------------------- -------------------------------------------------- 
 #ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
 
 -t option
 checking report command (type=g)
@@ -640,6 +931,7 @@ checking restore command (type=g)
 
 checking report command (type=g)
 fsgqa 1024 512 2048 00 [7 days] 15 10 20 00 [7 days]
+fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
 
 
 checking state command (type=g)
-- 
2.27.0

