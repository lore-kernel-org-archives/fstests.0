Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184EBEB64DA
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Jul 2023 01:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjGMBsl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 12 Jul 2023 21:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbjGMBsk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Jul 2023 21:48:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902151BF0
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2023 18:48:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C1D0619E3
        for <fstests@vger.kernel.org>; Thu, 13 Jul 2023 01:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75059C433C8;
        Thu, 13 Jul 2023 01:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689212918;
        bh=mvohRtqCzhAKTQysKvxP0SMaHwONQseiA3Qwk9ypybA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SGG/SoxiNPv1x2kBsoSIBk7Itk1MvXJ/5093mRDrzxwlX+t60b1UW3OJTF6k2M9WU
         6vW1j6MaM8PR2LXx5O/ilJFpeiBM11VbDyawz7+LjGSG55bLps8gMbiEo7RE8Stki8
         crdCK90+vBshMgBjcrdUeSDu7zb7uCa5PFLvndNKX6NovxsmeqROR5baLzGEDI3xAM
         cGvW3tCBZ8nlhBn4JctAkzcLfntuUXd9wBqb2JdrXgyFy4rnlCrxLI1wKSXph/wMO7
         WwPlcyLhxrFcS7gwBI2KFZyfmYcNB7z2sl3k968S9vUuNzveLoJDXyVcgs0bLmEZJE
         L314XJNPuZwVg==
Date:   Wed, 12 Jul 2023 18:48:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Eryu Guan <eguan@redhat.com>, Zorro Lang <zlang@kernel.org>,
        fstests@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] generic/558: limit the number of spawned subprocesses
Message-ID: <20230713014837.GG11442@frogsfrogsfrogs>
References: <2bb7705c-9a1a-6185-4554-9121e5cda710@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bb7705c-9a1a-6185-4554-9121e5cda710@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Mikulas, does this solve the forkbomb problem?

--D

diff --git a/tests/generic/558 b/tests/generic/558
index 4e22ce656b..de5c28d00d 100755
--- a/tests/generic/558
+++ b/tests/generic/558
@@ -39,15 +39,21 @@ _scratch_mkfs_sized $((1024 * 1024 * 1024)) >>$seqres.full 2>&1
 _scratch_mount
 
 i=0
-free_inode=`_get_free_inode $SCRATCH_MNT`
-file_per_dir=1000
-loop=$((free_inode / file_per_dir + 1))
+free_inodes=$(_get_free_inode $SCRATCH_MNT)
+nr_cpus=$(( $($here/src/feature -o) * 4 * LOAD_FACTOR ))
+echo "free inodes: $free_inodes nr_cpus: $nr_cpus" >> $seqres.full
+
+if ((free_inodes <= nr_cpus)); then
+	nr_cpus=1
+	files_per_dir=$free_inodes
+else
+	files_per_dir=$(( (free_inodes + nr_cpus - 1) / nr_cpus ))
+fi
 mkdir -p $SCRATCH_MNT/testdir
 
 echo "Create $((loop * file_per_dir)) files in $SCRATCH_MNT/testdir" >>$seqres.full
-while [ $i -lt $loop ]; do
-	create_file $SCRATCH_MNT/testdir $file_per_dir $i >>$seqres.full 2>&1 &
-	let i=$i+1
+for ((i = 0; i < nr_cpus; i++)); do
+	create_file $SCRATCH_MNT/testdir $files_per_dir $i >>$seqres.full 2>&1 &
 done
 wait
 
