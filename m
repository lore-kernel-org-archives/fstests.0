Return-Path: <SRS0=KIFJ=4H=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D97C3404E
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 00:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB224208E4
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 00:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgBSA3b (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:29:31 -0500
Received: from trent.utfs.org ([94.185.90.103]:54634 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgBSA3b (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 18 Feb 2020 19:29:31 -0500
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id E418E5F974;
        Wed, 19 Feb 2020 01:29:26 +0100 (CET)
Date:   Tue, 18 Feb 2020 16:29:26 -0800 (PST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Eryu Guan <guaneryu@gmail.com>
cc:     fstests@vger.kernel.org
Subject: Re: shared/032: add options for reiser4
In-Reply-To: <20200217124738.GK2697@desktop>
Message-ID: <alpine.DEB.2.22.395.2002181627110.2831@trent.utfs.org>
References: <alpine.DEB.2.22.395.2001311244100.2831@trent.utfs.org> <20200217124738.GK2697@desktop>
User-Agent: Alpine 2.22 (DEB 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, 17 Feb 2020, Eryu Guan wrote:
> Thanks for the patch! But This patch cannot be applied, seems the format
> is wrong.

Weird, I thought I double checked and test-applied it again to my checkout 
of xfstests-dev, but apparently not :(

> But it's easy enough to apply manually, just please make sure the patch
> format is correct next time.

OK, thanks for taking the time review this, and sorry for the garbled 
patch.

Christian.

-- 
BOFH excuse #70:

nesting roaches shorted out the ether cable
