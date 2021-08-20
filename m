Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF33C4320A
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Aug 2021 01:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1663061101
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Aug 2021 01:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhHTBEm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Aug 2021 21:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhHTBEl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Aug 2021 21:04:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAF2C061756;
        Thu, 19 Aug 2021 18:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=KvPeQTJ6zykLufy+7+vNzdRuiokVyvLx+qplfgrwmaI=; b=tjCXReMtEqQnUm2rrUvy+wRmuU
        4ZnWOm7GP95q+1KbhFrBO/8XIXvkdMzxeihp8xW51KYDCpmb3dMCAdXSOb8ZLwmLYs1/PFddcQa28
        JQnHrYPOIDn2VlNGfUNCXlu8gBszXw+Vd2mb6KbCHp/POfafXQ+8vIXp86XGz7dsNMGp1qDTw9Zcw
        GaSA3H0yPdft6k8rAmQMA+4uNHQYnrxqCO9w7i4iM0XZYtOPxnzEIQI1vtujuUXL2MBavh7ahhR8H
        ttNvhiTOyQFhzQ5eo13DXt4SrkAWZUmbkSTVgXn+VikoXRuM98RHKWGxD/orPWDFku5dTijcOK2o6
        EVSgeODQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGsx1-009pcF-Ga; Fri, 20 Aug 2021 01:04:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     hare@suse.de, dgilbert@interlog.com, jeyu@kernel.org,
        lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v5 0/2] fstests: add patient module remover
Date:   Thu, 19 Aug 2021 18:04:00 -0700
Message-Id: <20210820010402.2343320-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This v5 addresses the comments I failed to notice Eryu Guan
had made on the scsi_debug changes. It also extends the first
patch by augmenting the README to mention the "forever" option
to the patient module removal option.

Luis Chamberlain (2):
  common/module: add patient module rmmod support
  common/scsi_debug: use the patient module remover

 README            |   4 ++
 common/config     |  31 +++++++++++++
 common/module     | 108 ++++++++++++++++++++++++++++++++++++++++++++++
 common/scsi_debug |  37 ++++++++++------
 4 files changed, 168 insertions(+), 12 deletions(-)

-- 
2.30.2

