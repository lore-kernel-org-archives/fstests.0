Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FC0C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 25 May 2022 07:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242763AbiEYHei (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 25 May 2022 03:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239807AbiEYHec (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 May 2022 03:34:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A9E443F8
        for <fstests@vger.kernel.org>; Wed, 25 May 2022 00:34:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AC106177A
        for <fstests@vger.kernel.org>; Wed, 25 May 2022 07:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025C0C385B8
        for <fstests@vger.kernel.org>; Wed, 25 May 2022 07:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653464070;
        bh=MbFB67gnD726284n1JM6z2FnVxIN/gvZr54Zmx15Kog=;
        h=From:To:Subject:Date:From;
        b=SgxyKQASZOwfPmO6EqAJAJfq4QSE0lAMDbr7xlXv2pWTM7zAjeUVflVKGNFGECHhL
         PWUZHCktnKRzu3FcK708dR91u5VaWKFVmK4iJ/D6LsML5SsLIqIsooV77d40x9rNRs
         +gn9qCdqT4W1tIaqcS2j+RJkQ5gLcWI3NQYM4bv6NgG998A6YQ5NeubPWcD3aYbCgN
         oH0eb19JxH1Gcj9R9bwC44WwurOU1UyW0SOkDkUg4yuy+wRk6iU917Fs4vfSrUHoYo
         nBaHAb3Qd8TjMdhvfteE1Tzzvl8PyZkWGRvVAHDVQT1pEsrtdBvpaDkPSlB4FHr2+b
         OlR97MuQrpcAQ==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH 0/2] source fs specific common file properly
Date:   Wed, 25 May 2022 15:34:25 +0800
Message-Id: <20220525073427.3355242-1-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

It starts with generic/402 always fails on overlayfs as:

  QA output created by 402
  ./common/rc: line 2441: _xfs_timestamp_range: command not found
  ./common/rc: line 2403: [: syntax error: '-1' unexpected
  ./common/rc: line 2408: [: -le: unary operator expected
  ./common/rc: line 2441: _xfs_timestamp_range: command not found
  0;0 != 1;1
  0;0 != 1;1
  Silence is golden

Due to if FSTYP is overlay, we only source common/overlay file. But we
still need the helpers of the underlying filesystem. So I think we need
to source the common/$OVL_BASE_FSTYP in common/overlay.

Besides overlayfs, I'd like to extend other uplying fs support its
BASE_FSTYP, so other uplying fs (e.g. nfs, cifs, glusterfs ...) will
do like this.

Thanks,
Zorro
