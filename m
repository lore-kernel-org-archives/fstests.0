Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46848C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 11 Oct 2022 09:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJKJX3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 11 Oct 2022 05:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJKJX1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Oct 2022 05:23:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DD07D1CB
        for <fstests@vger.kernel.org>; Tue, 11 Oct 2022 02:23:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AA29A1F86C
        for <fstests@vger.kernel.org>; Tue, 11 Oct 2022 09:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665480200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Koi62DQmJJ/tFmOchgKV0K+m/BkU/oHH0n7Ks4A42dc=;
        b=OcJxD6dl/dem520wg6EKaSIxjFpgkM7HTc9Nf4toMrbdN+kJDrS3DVfDsoK83/MP2wk9kp
        7bZCHxxI3MKrgSbtuJhOrmdxT48bB1VAYetwjJMyYJqsSayPDum5Pu4hgW74OjEjjRPxhY
        nDj9/c4B9KI1w1NJLL/Xt/31EKf44ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665480200;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Koi62DQmJJ/tFmOchgKV0K+m/BkU/oHH0n7Ks4A42dc=;
        b=bqOJwVTjbTtsmE5NbmODraifr46+072Njg+mHbHsrDJBbtj2WjI4fipa/kuISPD7J+OOG8
        2Pry+w1D1bGpIsAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87E4E13ACA
        for <fstests@vger.kernel.org>; Tue, 11 Oct 2022 09:23:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C3ArHwg2RWNodQAAMHmgww
        (envelope-from <ddiss@suse.de>)
        for <fstests@vger.kernel.org>; Tue, 11 Oct 2022 09:23:20 +0000
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Subject: [PATCH 0/2]: minor compiler warning and lsqa fixes
Date:   Tue, 11 Oct 2022 11:23:38 +0200
Message-Id: <20221011092340.24857-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

I couple of minor clean-ups I had laying around:

 lsqa.pl                | 2 +-
 src/seek_sanity_test.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)


