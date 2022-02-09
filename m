Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F55C4321E
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 02:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240972AbiBICjX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Feb 2022 21:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244169AbiBICCb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Feb 2022 21:02:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456DCC06157B
        for <fstests@vger.kernel.org>; Tue,  8 Feb 2022 18:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1glhJ01QY/z/1oIFzlkDJyz6tI4o2a6NhFja9S4WSsk=; b=szn3/XqwAPQC8Q8FzqI+9nlHNl
        BTMejBkab1+K+Qja9PQvMUb5Fi/a/c59T5RM/Hp/2Vljg7/31FGD+2iqxXCkBiT3BCb+8Gz6R9Qrl
        TAuLTEFVJ2X89EUZZx+9sflHAMsnnpIaS8dZqiyl6HLCCYZkl8x24EOHLcNyLd0H+VN4vSQVkiRzZ
        w95cTOmPoa5uTVRWVV/00Pypj5Bwu8g7vczU9HcsCLqBj6NdzzXXM7EasK8b6wo9vlYO7gu0L/Wov
        q3oeqR14s5rEBV6ofdRQWpA+8TXD1d3GLU4Dx3cD3uDl3Q4BXYN4RWaqQAhcV1ds5rWaye/5rgyvU
        M5jnExTA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHcJO-00FxxX-3S; Wed, 09 Feb 2022 02:02:26 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/4] configure.in: rename to configure.ac
Date:   Tue,  8 Feb 2022 18:02:20 -0800
Message-Id: <20220209020223.3805346-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209020223.3805346-1-mcgrof@kernel.org>
References: <20220209020223.3805346-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

autoheader complains and tell us to rename configure.in
to configure.ac. Let's do that.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 configure.in => configure.ac | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename configure.in => configure.ac (100%)

diff --git a/configure.in b/configure.ac
similarity index 100%
rename from configure.in
rename to configure.ac
-- 
2.34.1

