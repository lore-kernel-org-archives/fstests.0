Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C991CC433B4
	for <linux-fstests@archiver.kernel.org>; Fri,  7 May 2021 15:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9710C6145A
	for <linux-fstests@archiver.kernel.org>; Fri,  7 May 2021 15:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhEGPJ6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 May 2021 11:09:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232284AbhEGPJ6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 7 May 2021 11:09:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EB2561006;
        Fri,  7 May 2021 15:08:56 +0000 (UTC)
Date:   Fri, 7 May 2021 17:08:53 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] generic/633: extend fscaps test
Message-ID: <20210507150853.exv5jmqrlaxqkvnx@wittgenstein>
References: <20210501122539.2844335-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210501122539.2844335-1-brauner@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, May 01, 2021 at 02:25:39PM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Add a test to verify that setting a v3 fscap from an idmapped mount
> works as expected. This and other related use-cases were regressed by
> commit [1] which was reverted in [2] and the proper fix merged right
> before v5.12 was released in [3].
> 
> [1]: commit 3b0c2d3eaa83 ("Revert 95ebabde382c ("capabilities: Don't allow writing ambiguous v3 file capabilities")")
> [2]: commit 95ebabde382c ("capabilities: Don't allow writing ambiguous v3 file capabilities")
> [3]: commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Cc: fstests@vger.kernel.org
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---

I've folded this patch into the series I just sent out:
https://lore.kernel.org/fstests/20210507150100.968659-1-brauner@kernel.org

So this patch should be ignored.

Thanks!
Christian
