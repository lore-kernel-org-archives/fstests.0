Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96836C07E99
	for <linux-fstests@archiver.kernel.org>; Mon,  5 Jul 2021 07:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E8F613B2
	for <linux-fstests@archiver.kernel.org>; Mon,  5 Jul 2021 07:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhGEH75 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 5 Jul 2021 03:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhGEH75 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Jul 2021 03:59:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D47DC061574
        for <fstests@vger.kernel.org>; Mon,  5 Jul 2021 00:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4CFtrn9sQgZDqsrBXOIpC7K6DRYfw57OL009p3GnXUA=; b=KqfxTsDjZPGjJ6685IFcGHb/1Q
        S1wTeCyIMRise0rv5FYhXQW3SmwyhMpRjfTNOuSp3w99nXuRodfW5gHBCk212Fi56z8AtAPD6nm00
        KCxnU4V6tIt0excnDjFIhObif4PghvXr7xhd8+teNS53jGIpm84zG3KVAbhlSScpaTLg19C1o/cyg
        zKg2ktWRDbCcK6oaw0hy5vRxdN3SR9CqjAEtWO7+ClVYC9zz+kAK9Tkwz/7lQ6XIBixK0dLUSdhCY
        txvuatm4KKz7G8cqsnSEW65XGi/VWbmMo5QeQ79YolqgqVJxhniW2/8SfFiPbrSC+VqY2Yp9Dvjnq
        OtW8i/KA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0JTF-00A0yi-Q8; Mon, 05 Jul 2021 07:56:56 +0000
Date:   Mon, 5 Jul 2021 08:56:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        Leah Rumancik <leah.rumancik@gmail.com>
Subject: Re: [PATCH] ext4/048: skip test of filename wipe if journal
 checkpoint is not supported
Message-ID: <YOK7Qf+1Rv9+ntxT@infradead.org>
References: <20210621164851.1808923-1-tytso@mit.edu>
 <YOGRukqZFQTb36MS@desktop>
 <YOIwqn1jPBSyXIwd@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOIwqn1jPBSyXIwd@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jul 04, 2021 at 06:05:30PM -0400, Theodore Ts'o wrote:
> Given the discussion for the patches, I suspect that it will be only
> the distros that are meant for Cloud environments (e.g., Google's COS,
> maybe Amazon Linux, etc.) that will be interested at all in the first
> place --- and if they do, they'll want to take both of them.

FYI, I still think supporting discard at all is a active and dangerous
mis-service to your users.  Discard must not and often will not
clear data.  Write smae OTOH does, and with the REQ_UNMAP flag will
give you the same results as discards for devices that zero on
discard, while haveing a safe (but slow) fallback if not.
