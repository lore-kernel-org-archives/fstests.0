Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AF1C433E0
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Mar 2021 13:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1797619A0
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Mar 2021 13:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCVNqH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 Mar 2021 09:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230203AbhCVNpn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 22 Mar 2021 09:45:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88CB76198D;
        Mon, 22 Mar 2021 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616420743;
        bh=6R7cDeHN0UUpApjcBuUxubHci1q98RsQVtu/HvILAZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LZeD8HrUOaUKsjXFYZQD/XQNc79Paxc2MSWrncPBNBiGRFeLU9lAY/hIlaUWFc1tL
         moqZf1GzpfODNrHEjbYwHbytzZVQV6VB1BpW5Flgvu2PLLVrNKKVWMVTCAffQLwgyD
         +LY0Tx/e+rLXP6S/IvWH/6Ypy7Dsg2xeHfIWY3qlnrN64N9qzs8jj7M7sVtymaJZxn
         oP9BLtswv+ObAxc1bR9bMnYsm9LC+FY8g6dkvYyIgMYjKhqheO45VMR1PO7mLKj3KB
         HERBIzh7Tra7F1iDmH4B5bP4UAXmcu4/K0OGb/Zc1skqaFQTOUsALjlkIOxKFyCELV
         NXDc+qQ4s/qZA==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v10 3/6] common/rc: add _scratch_{u}mount_idmapped() helpers
Date:   Mon, 22 Mar 2021 14:45:19 +0100
Message-Id: <20210322134522.916512-4-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210322134522.916512-1-brauner@kernel.org>
References: <20210322134522.916512-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=0tBoWLwhZNa+tipA2iRvU4W45a+5ynswiuHs0HRDIhQ=; m=6Vb20E8gcJEA5o4NwNERTGWL1KgKXo25uFGgA6DLiA4=; p=gH9k1c18+xPi93uNkw7qSPSyE8wDyMo30s9SeF03sm0=; g=759d18e74edde0113c314bab892641d4ca66b868
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYFifaAAKCRCRxhvAZXjcoimIAP9Q3yt ld0JY2Jsf30ooj+C34csexZbljIzVwzbJ118z9AD/cjHcLt58HcXdha2tGP3KU8botLcW5HTPT7FY xT3A9QI=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

They will be used in follow-up patches for xfs quota tests but might be
useful for other tests in the future.

Cc: Eryu Guan <guan@eryu.me>
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: fstests@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 common/rc | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/common/rc b/common/rc
index a8b375a2..351996fc 100644
--- a/common/rc
+++ b/common/rc
@@ -342,6 +342,36 @@ _scratch_mount()
 	_try_scratch_mount $* || _fail "mount failed"
 }
 
+_scratch_mount_idmapped()
+{
+	local type="$1"
+	local id="$2"
+
+	if [ "$type" = "u" ]; then
+		# This means root will be able to create files as uid %id in
+		# the underlying filesystem by going through the idmapped mount.
+		$here/src/idmapped-mounts/mount-idmapped --map-mount u:0:$id:1 \
+							 --map-mount u:$id:0:1 \
+							 --map-mount g:0:0:1 \
+							 "$SCRATCH_MNT" "$SCRATCH_MNT" || _fail "mount-idmapped failed"
+	elif [ "$type" = "g" ]; then
+		# This means root will be able to create files as gid %id in
+		# the underlying filesystem by going through the idmapped mount.
+		$here/src/idmapped-mounts/mount-idmapped --map-mount g:0:$id:1 \
+							 --map-mount g:$id:0:1 \
+							 --map-mount u:0:0:1 \
+							 "$SCRATCH_MNT" "$SCRATCH_MNT" || _fail "mount-idmapped failed"
+	elif [ "$type" = "b" ]; then
+		# This means root will be able to create files as uid and gid
+		# %id in the underlying filesystem by going through the idmapped mount.
+		$here/src/idmapped-mounts/mount-idmapped --map-mount b:0:$id:1 \
+							 --map-mount b:$id:0:1 \
+							 "$SCRATCH_MNT" "$SCRATCH_MNT" || _fail "mount-idmapped failed"
+	else
+		_fail "usage: either \"u\" (uid), \"g\" (gid), or \"b\" (uid and gid) must be specified "
+	fi
+}
+
 _scratch_unmount()
 {
 	case "$FSTYP" in
@@ -357,6 +387,11 @@ _scratch_unmount()
 	esac
 }
 
+_scratch_umount_idmapped()
+{
+	$UMOUNT_PROG $SCRATCH_MNT
+}
+
 _scratch_remount()
 {
     local opts="$1"
-- 
2.27.0

