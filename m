Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CB3C43219
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Apr 2022 11:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344955AbiDLL7o (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Apr 2022 07:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353061AbiDLL6h (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Apr 2022 07:58:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0775B66237
        for <fstests@vger.kernel.org>; Tue, 12 Apr 2022 03:50:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 79FE41F868;
        Tue, 12 Apr 2022 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649760606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zOF3PuejuCbueZI7YP6YKLY3P79LoK/f1dkljpD3jK0=;
        b=iNoxlRIfz42yWtFqnSyKicqIIAMK9arTeCIMBDl/yuMhIlPUQCBsiwUcoa7KESuP0156BL
        FHnEVKceEe+EX8xjW4isR4p8b3O3FqY9LYeuVnC2PbR83VdvYH6w7orqST6h9+rg0tqYBm
        GkOlSz5I//YZXFj7GRAzVRBWoHRiwwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649760606;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zOF3PuejuCbueZI7YP6YKLY3P79LoK/f1dkljpD3jK0=;
        b=5NMvbDanO0U2ODMIGlW3+zHhf/veX7K/3xvsOeEzTdxjz0G1GSR74fGJui7Dj7t2zTshJi
        PdwzAzbuig5OJwAg==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 574AEA3BAD;
        Tue, 12 Apr 2022 10:50:06 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     dchinner@redhat.com
Subject: [PATCH v2 0/3]: generic/020: fix MAX_ATTRVAL_SIZE values
Date:   Tue, 12 Apr 2022 12:49:58 +0200
Message-Id: <20220412105001.14325-1-ddiss@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

MAX_ATTRVAL_SIZE provides a per-filesystem maximum xattr value length
limit. There are a few problems with the current values:
- XFS, UDF and Btrfs are incorrectly hardcoded to use 64 bytes
  + This is a regression from the larger value used prior to fff4359d
  + Btrfs's should be calculated using nodesize and xattr name length
- NFS currently uses a 64K limit
  + This may be above the server's underlying failsystem limit, so use
    a conservative estimate instead

Cheers, David

 common/attr           | 175 ++++++++++++++++++++++++------------------
 tests/generic/020     |  10 ++-
 tests/generic/020.out |   2 +-
 3 files changed, 108 insertions(+), 79 deletions(-)

