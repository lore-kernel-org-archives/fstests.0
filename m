Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBC3C432BE
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Aug 2021 08:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A4061075
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Aug 2021 08:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbhHJISN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 Aug 2021 04:18:13 -0400
Received: from verein.lst.de ([213.95.11.211]:35095 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238059AbhHJISJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 10 Aug 2021 04:18:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F318E67373; Tue, 10 Aug 2021 10:17:44 +0200 (CEST)
Date:   Tue, 10 Aug 2021 10:17:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 2/6] generic/640: add fscaps regression test
Message-ID: <20210810081744.GB20012@lst.de>
References: <20210731165834.479633-1-brauner@kernel.org> <20210731165834.479633-3-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731165834.479633-3-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
