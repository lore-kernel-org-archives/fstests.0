Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEEAECAAD8
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Sep 2022 11:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiITLuq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Sep 2022 07:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiITLup (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2022 07:50:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F393473335
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 04:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F70A622FE
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 11:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D824C433D6;
        Tue, 20 Sep 2022 11:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663674644;
        bh=FqvJmwRYfhS/xC1vgkEopEKI1x7Bl8uEkUMX0m2L+zY=;
        h=From:To:Cc:Subject:Date:From;
        b=UsJedsSn/yIAvNqCvmUMGmMPzKjQobebPFuNSZH5wHNr4qYXbg89dElCUdPPTZwjM
         LF8PWC6eA5OPJNo1X2+I8aJhCnf9D3MpNm6e423B0HdEMNEU7WV4nxGWI+jIEFXGIO
         sbRNHNGo9E6Qw5/Uqspb8DmYSv/JCJgCcQ4OE4ML6+oTIeYoOKioZBWR46uhuAmloz
         23y4RSiIrjszGjEtzQ4Cn8yAC4LSYpUeQq9oalmCjgno4b/iUWSvWkYUh7U20Qi2BU
         0aBup4/ETNqTvsLPU1r8JN+s3uyPl7u/GsuEQpC1bq5AkKBEwoAa+NdKKkmBDHUtL7
         k7S6AmHx1AF1g==
From:   Zorro Lang <zlang@kernel.org>
To:     brauner@kernel.org, fstests@vger.kernel.org
Cc:     sforshee@digitalocean.com, amir73il@gmail.com, hch@lst.de,
        cyphar@cyphar.com
Subject: [PATCH v4 0/2] group ownership changing test
Date:   Tue, 20 Sep 2022 19:50:33 +0800
Message-Id: <20220920115035.2472076-1-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Christian,

It's been 3 month past, since your patch [1] was reviewed last time. I'm still
waititng for this test coverage for fs. According to the review points last
time, I split your v3 patch [1] to 2 separated cases, one basic testing for
covering that fix, one extend testing for overlay part.

I only did below changes (compare with v3):
1) Split one case to two cases.
2) Move "_supports_filetype" line under the _scratch_mount.

I still keep the patch Author as you, and signed-off-by you, due to I just
hope to bring this discussion back, and push the proceeding of this patch
be merged.

(CC the old cc list to get more review)

Thanks,
Zorro

[1]
https://lore.kernel.org/fstests/20220615092826.2333847-1-brauner@kernel.org/
