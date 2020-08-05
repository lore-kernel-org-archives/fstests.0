Return-Path: <SRS0=/czi=BP=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E66FC433E0
	for <linux-fstests@archiver.kernel.org>; Wed,  5 Aug 2020 20:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46BD322CA1
	for <linux-fstests@archiver.kernel.org>; Wed,  5 Aug 2020 20:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596658518;
	bh=yTX3/mOOTuG4J9Rqbs7yW/RnrHtMPaNNM1+AYvJ7gq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MZW2X32Udq+nJdTNosBHIeGlRZRMuF+w/VrBfhET85d3Os2yZ4jT++ejfh2L8rfhU
	 CrPnyATIvzuHLOEE/5dx1CJE/KbiZRdXOwrOV93NfUZiM0xLNsKUbNA3DgbBkknbXy
	 UqYC/CiXQTCWGvPvfv3GO6qF7IeOhSp9YJzpu6pM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgHEUPR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbgHEQUR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 5 Aug 2020 12:20:17 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D89F22075D;
        Wed,  5 Aug 2020 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596635591;
        bh=yTX3/mOOTuG4J9Rqbs7yW/RnrHtMPaNNM1+AYvJ7gq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=esUaKTMSYzL+34FUR5zw/ItvdO8uIFXxoqg4a+dC4qla8TyJhMEwN7tLvJhpJC4in
         fROfaN+iqwZNAuQl7WVRv/bUiWgXk86JNhnVlPVBeLOJO7nSbFRQQOCoDVygUuBaqA
         PP6sJLOvuMIKxJChgLsTaIwlN2i3/dM06sVGT6hQ=
From:   Jeff Layton <jlayton@kernel.org>
To:     fstests@vger.kernel.org
Cc:     Eryu Guan <guaneryu@gmail.com>
Subject: [PATCH RESEND 2/2] generic/062: use more restrictive filter when querying for attributes
Date:   Wed,  5 Aug 2020 09:53:08 -0400
Message-Id: <20200805135308.14540-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200805135308.14540-1-jlayton@kernel.org>
References: <20200805135308.14540-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Sometimes we can end up with unexpected xattrs showing up on an inode.
For instance, on an SELinux-enabled host security.selinux may be set and
show up in a listing even though we've never set it.

generic/062 lists out all of the xattrs on an inode in some cases, but
it can't easily account for these "automatic" xattrs being set. Change
it to use a more restrictive regex when filtering attributes, so that we
just get the namespaces we're interested in.

Cc: Zorro Lang <zlang@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 tests/generic/062 | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/generic/062 b/tests/generic/062
index d2a0ac9a9a21..cab4b4faac7c 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -77,8 +77,10 @@ invalid_attribute_filter() {
 
 if [ "$USE_ATTR_SECURE" = yes ]; then
     ATTR_MODES="user security trusted"
+    ATTR_FILTER="^(user|security|trusted)"
 else
     ATTR_MODES="user trusted"
+    ATTR_FILTER="^(user|trusted)"
 fi
 for nsp in $ATTR_MODES; do
 	for inode in reg dir lnk dev/b dev/c dev/p; do
@@ -121,7 +123,7 @@ for nsp in $ATTR_MODES; do
 		getfattr -m $nsp -e hex -n $nsp.name2 $SCRATCH_MNT/$inode 2>&1 | invalid_attribute_filter
 
 		echo "*** final list (strings, type=$inode, nsp=$nsp)"
-		getfattr -m '.' -e hex $SCRATCH_MNT/$inode
+		getfattr -m $ATTR_FILTER -e hex $SCRATCH_MNT/$inode
 	
 	done
 done
@@ -151,11 +153,11 @@ _extend_test_bed
 
 echo
 echo "*** directory descent with us following symlinks"
-getfattr -h -L -R -m '.' -e hex $SCRATCH_MNT | _sort_getfattr_output
+getfattr -h -L -R -m "$ATTR_FILTER" -e hex $SCRATCH_MNT | _sort_getfattr_output
 
 echo
 echo "*** directory descent without following symlinks"
-getfattr -h -P -R -m '.' -e hex $SCRATCH_MNT | _sort_getfattr_output
+getfattr -h -P -R -m "$ATTR_FILTER" -e hex $SCRATCH_MNT | _sort_getfattr_output
 
 # 
 # Test the backup/restore code
@@ -168,7 +170,7 @@ _backup()
 	# we *do* sort the output by path, since it otherwise would depend on
 	# readdir order, which on some filesystems may change after re-creating
 	# the files.
-	_getfattr --absolute-names -dh -R -m '.' $SCRATCH_MNT | _sort_getfattr_output >$1
+	_getfattr --absolute-names -dh -R -m $ATTR_FILTER $SCRATCH_MNT | _sort_getfattr_output >$1
 	echo BACKUP $1 >>$seqres.full
 	cat $1 >> $seqres.full
 	[ ! -s $1 ] && echo "warning: $1 (backup file) is empty"
-- 
2.26.2

