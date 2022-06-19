Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDFAC43334
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Jun 2022 12:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiFSM51 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Jun 2022 08:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbiFSM50 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Jun 2022 08:57:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9BFB87F
        for <fstests@vger.kernel.org>; Sun, 19 Jun 2022 05:57:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00726B80CAC
        for <fstests@vger.kernel.org>; Sun, 19 Jun 2022 12:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C337C34114
        for <fstests@vger.kernel.org>; Sun, 19 Jun 2022 12:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655643442;
        bh=cwbJFuoxOfNtMeQKMB+9ZXyHiGS0QRT6uH2QB+wvpPk=;
        h=Date:From:To:Subject:From;
        b=Ad7/97W9c4KrfvGSO2TU/HLCIgFJ7XNBn1UC0hUJEBFJfHiBuogUph2fI3MZTVraT
         tO3GRT879DTqcuOF9PJDZowgu1hzputg/6oaVjdoC2HXPeivh1QDKaR9nbBYfcPnkb
         NhbL4OYlggfO8AI+0NdPhBRQZv8NQC6W3tHEHTocXFqXtqhoV6AH6nuDmDNtG/M2Po
         f61UY5uat0l11yBghexQkv1o+guGWAFZm7GAxdaYblCJNtiafFNx5R4ngVfra2sUVe
         w+B9URwCuAKp7c+GWyEdSr7Ay1jbmYI3zhoH8BHZbtqpTIWCKYBF6azzdZCjUJn/xR
         s+rnR3u46A65g==
Date:   Sun, 19 Jun 2022 20:57:16 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [Notice] Defer fstests release to next weekend (2022-06-26)
Message-ID: <20220619125716.6bkwlfigx2gszucv@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

As subject. Due to most of patches are still under reviewing, or are still
controversial, only 2 patches get acked this week, and these 2 patches aren't
critical, so I'd like to cancel the fstests release this week. Thanks for
your understanding.

Thanks,
Zorro
