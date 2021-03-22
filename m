Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2093C433C1
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Mar 2021 13:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D741619A6
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Mar 2021 13:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCVNuW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 Mar 2021 09:50:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51676 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhCVNuH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Mar 2021 09:50:07 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lOKwV-0002x5-Hh; Mon, 22 Mar 2021 13:50:03 +0000
Date:   Mon, 22 Mar 2021 14:50:02 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v10 0/6] fstests: add idmapped mounts tests
Message-ID: <20210322135002.6tyexslvqfiaari7@wittgenstein>
References: <20210322134522.916512-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210322134522.916512-1-brauner@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 22, 2021 at 02:45:16PM +0100, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Hey everyone,
> 
> This series is available from:
> https://git.kernel.org/brauner/xfstests-dev/h/idmapped_mounts
> https://gitlab.com/brauner/xfstests/-/tree/idmapped_mounts
> https://github.com/brauner/xfstests/tree/idmapped_mounts

I sent this series from my kernel.org mail address and patch 2/6 hasn't
made it through this time too. So it seems that vger is rejecting it due
to its size is my guess. I'll go poing the #korg folks to ask what's
going on and whether that can be handled.

Thanks!
Christian
