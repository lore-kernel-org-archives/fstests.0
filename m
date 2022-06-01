Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DDEC433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jun 2022 06:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349913AbiFAGhh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245291AbiFAGhh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 02:37:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5BA4D600
        for <fstests@vger.kernel.org>; Tue, 31 May 2022 23:37:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDFFDB8179D
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 06:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056F0C385A5
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 06:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654065453;
        bh=qyMzCGibD4ShcTEiXBeJTaH5izTelSjlyhsefPErvaM=;
        h=From:To:Subject:Date:From;
        b=sG9HVkP43S5rYquC61TwndUYmFs3oIiZ2BCCYdsffoIKaFvObjJ/3LnfddbWBnvYC
         1gIofkeOQ400gXCYjyRPpMBSAdyENPg+8BOaESLX+IAXRVTSg+qjEuOnmMqXOKn6+W
         2ZK9vRzpNy3KXh+2rptaeqfBrJs8hcE9SasCe3SfKJh7HqNkCO33Y5tHpxV9UspFCy
         Z3G+fnWSpEaXbQq/FXEA+I5q1nAF0Hdxi5OFZ8VBNyoW1h7/Nyq6CC0SdhMrOzjMv7
         cL5dfVUFYkqC2h2jykQ4sxKdfeOE8ftmpQM89qMJ+zFssRV2Ay5fV9HHj35w0in9vk
         wx6ONNHA3vxlw==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH v2 0/5] random fixes for fstests
Date:   Wed,  1 Jun 2022 14:37:25 +0800
Message-Id: <20220601063730.1726879-1-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

V2 did below changes:

[PATCH v2 1/5] generic/139: require 512 bytes to be the minimum dio
Improve the code change in _require_odirect()

[PATCH v2 2/5] generic/506: call _require_quota before _qmount
Nothing changed

[PATCH v2 3/5] generic/591: remove redundant output from golden image
Replace fflush(stdout) with setlinebuf(stdout). Thanks the review from Dave.

[PATCH v2 4/5] generic/591: use proper sector size
Remove bad binary files commit, and deal with them in [5/5].

[PATCH v2 5/5] gitignore: ignore missed binary files in src
Add two binary files to .gitignore file.

Removed original "[PATCH 5/5] generic/623: add overlay into the blacklist",
Amir would like to use another patch to deal with it.

=== Messages from orignal V1 ===
These 5 patches are random fixes, except patch 4/5 bases on 3/5.

 - [PATCH 1/5] generic/139: require 512 bytes to be the minimum dio size
I tried to help it support 4096 sector size, but it's not simple, especially
the golden image broken. So I'm thinking how about limit it in 512 bytes dio
testing.

 - [PATCH 2/5] generic/506: call _require_quota before _qmount
As subject

 - [PATCH 3/5] generic/591: remove redundant output from golden image
I think I found where's the issue from, but I'm not sure if it's the best
way to fix it. So welcome suggestions :)

 - [PATCH 4/5] generic/591: use proper sector size
Help splice-test to support a sector size option

 - [PATCH 5/5] generic/623: add overlay into the blacklist
I think it's simple to exclude overlay from this test directly, or we have to
check if $FSTYP=overlay, then think about how to deal with OVL_BASE_SCRATCH_DEV
things.

Thanks,
Zorro
