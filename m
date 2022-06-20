Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F282CCA479
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Jun 2022 19:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiFTTaD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Jun 2022 15:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbiFTTaC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Jun 2022 15:30:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB9C1C11B
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 12:30:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C27311F991
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 19:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655753399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UdTTT2YWhY1OF9OhL815SRrC4M5OaA7rSIQIkMAqhoE=;
        b=Kmebyw6l1MBC8LSZlwQ5FxpNsUx5JaCMwiFL+f0zotcPcqYtBCzIXMwOBROGmuyFKEuCh7
        6K6pzuYyLd1Nogig7GBjLzbknvNi8EGiidd28wTLJgB6qicAH2lLnJW5YM9truYX5Uhn0c
        pFSEt1lp27PGoYSWKdAgVyjzRk3O6I4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655753399;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UdTTT2YWhY1OF9OhL815SRrC4M5OaA7rSIQIkMAqhoE=;
        b=blvePYXA6kj+zuNk+JhSrF6vEbQjlGtHEUnHHsF5ZnI0asnuT4EV/PkhYZUmfdkv/lNQ1+
        zKcjkRZZCS7gtDCA==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A35A42C141
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 19:29:59 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Subject: [PATCH 0/6] check: minor cleanups and xunit report fix
Date:   Mon, 20 Jun 2022 21:29:28 +0200
Message-Id: <20220620192934.21694-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

This patchset contains a few cleanups which I came across while working
on a larger set of changes for test-rerun-on-failure[1] support. One
minor fix for the tests count in the xunit report is included.

Diffstat:
 check         | 148 +++++++++++++++++++++-----------------------------
 common/report |  14 +++--
 2 files changed, 71 insertions(+), 91 deletions(-)

1. test-rerun-on-failure proposal by Ted Ts'o:
   https://lwn.net/Articles/897061/

Cheers, David


