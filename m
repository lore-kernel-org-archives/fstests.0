Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B90C4338F
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Aug 2021 14:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF4E610C9
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Aug 2021 14:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbhHROHq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbhHROHp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Aug 2021 10:07:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B9FC061764;
        Wed, 18 Aug 2021 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=t7yJ2bcNJWGSBC482VMdmiWbdC42sC3SvF5Zv1MVXCs=; b=ge1JcuFqixlF6ZBbUsgYLAhvJH
        +xq/awS6k8DsxuCZKonmuQed2vow//8m0Kp/Qu2ZSXq/lYw4ZrDzrlaQV+U46crDuVyj++K5F3AGm
        4ptV1sU2ctHhIlelzdEq8IrtrwvPNs/njqbHr5egStvYVi+CbUjZouAFOZnXZhG+f76OAukEZiV5O
        QPdvSZRct7b5O0eqkoCJAlHKslpf/4BI4Ut9u6qIHIVH5u4obDFimZna3QR7174KLihL/B+b6U+Ru
        iKTVDG3ADOEjmBc6jd+yUmDMgW97GSfCDVw8kM0YE3DSBPRqWL0pOFrGOlXOq2LMZy4I3gIlceCJG
        6iz+3WsA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMDm-005oZI-Uv; Wed, 18 Aug 2021 14:07:10 +0000
Date:   Wed, 18 Aug 2021 07:07:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org
Subject: git fstests tree alias
Message-ID: <YR0UDlcXWl7rhRF9@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

It is nice that we have fstests on vger, I think this helps
with many FS developers who are new adopting and getting used
to the fact that we use fstests for *any* filesystem. However
the git tree is still misleading. While I don't think we can
phase out the old one, can we at least get an alias?

pub/scm/fs/fstests.git ?

  Luis
