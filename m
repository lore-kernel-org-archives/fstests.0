Return-Path: <SRS0=KIFJ=4H=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3DDC34031
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 00:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDF8208E4
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 00:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgBSAdT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:33:19 -0500
Received: from trent.utfs.org ([94.185.90.103]:55188 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgBSAdT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 18 Feb 2020 19:33:19 -0500
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 69D805F968;
        Wed, 19 Feb 2020 01:33:18 +0100 (CET)
Date:   Tue, 18 Feb 2020 16:33:18 -0800 (PST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Eryu Guan <guaneryu@gmail.com>
cc:     fstests@vger.kernel.org
Subject: Re: README: fsgqa needs a home directory too
In-Reply-To: <20200217125323.GL2697@desktop>
Message-ID: <alpine.DEB.2.22.395.2002181629370.2831@trent.utfs.org>
References: <alpine.DEB.2.22.395.2001311318390.2831@trent.utfs.org> <20200217125323.GL2697@desktop>
User-Agent: Alpine 2.22 (DEB 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, 17 Feb 2020, Eryu Guan wrote:
> > Signed-off-by: Christian Kujau <lists@nerdbynature.de>
> 
> Ok, your patch is missing the "---" below Signed-off-by line
> 
> ---
> 
> above dashes make the patch appliable.

Sorry for that, next time I'll try to use scripts/checkpatch.pl from the 
Kernel project before submitting patches.

Thanks for applying this.

Christian.
-- 
BOFH excuse #70:

nesting roaches shorted out the ether cable
