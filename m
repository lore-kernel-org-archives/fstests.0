Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDB0C43214
	for <linux-fstests@archiver.kernel.org>; Sat, 14 Aug 2021 08:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7270A6109E
	for <linux-fstests@archiver.kernel.org>; Sat, 14 Aug 2021 08:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbhHNIkW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 14 Aug 2021 04:40:22 -0400
Received: from verein.lst.de ([213.95.11.211]:49567 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237671AbhHNIkV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 14 Aug 2021 04:40:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 694AA67373; Sat, 14 Aug 2021 10:39:51 +0200 (CEST)
Date:   Sat, 14 Aug 2021 10:39:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v3 1/8] idmapped-mounts: use die() helper
Message-ID: <20210814083951.GA22637@lst.de>
References: <20210812160140.990229-1-brauner@kernel.org> <20210812160140.990229-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812160140.990229-2-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
