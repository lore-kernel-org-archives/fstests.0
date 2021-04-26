Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263B4C433B4
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 00:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0699A6117A
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 00:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhDZAfU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 25 Apr 2021 20:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhDZAfT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Apr 2021 20:35:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996C1C061574;
        Sun, 25 Apr 2021 17:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VMiGqXM1hH3svRbIPs3VeukCp6tAxDpm9HcvnItH/pU=; b=YkR7OcuFsqoEpSfbF3ygp0PCt2
        hfmltKfPo17aohZQkfA+lQ+vACHGghFyu4aDneTL2vt0u8SOpwj8QfoR/H6Vyefd1rPzco4wiAl3a
        m83fKi3NSGfWxxZB6F7iigaobAytz7S67H9FF0acjWSdO9nt0Jpdn1TVg10EJVaHGF+HSfezOPImw
        DKibv13xNztGPZmtTkkWcMinFinoqV5du2/k5obWWYewnnaWsDkhsPFCLHduS9uI0OyF4hUgSwGcV
        EGot1a8oUU2TDSKS9Z8SOysypoZrVPXn29Pxzdsjr06PTldhCA/OiddMX1PjMX5t6ZiRNGEBIuipM
        YP1XRfdw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lapCo-004uCZ-Qv; Mon, 26 Apr 2021 00:34:31 +0000
Date:   Mon, 26 Apr 2021 01:34:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        krisman@collabora.com, preichl@redhat.com, kernel@collabora.com
Subject: Re: [PATCH] generic/453: Exclude filenames that are not supported by
 exfat
Message-ID: <20210426003430.GH235567@casper.infradead.org>
References: <20210425223105.1855098-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425223105.1855098-1-shreeya.patel@collabora.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 26, 2021 at 04:01:05AM +0530, Shreeya Patel wrote:
> exFAT filesystem does not support the following character codes
> 0x0000 - 0x001F ( Control Codes ), /, ?, :, ", \, *, <, |, >

ummm ...

> -# Fake slash?
> -setf "urk\xc0\xafmoo" "FAKESLASH"

That doesn't use any of the explained banned characters.  It uses 0xc0,
0xaf.

Now, in utf-8, that's an nonconforming sequence.  "The Unicode and UCS
standards require that producers of UTF-8 shall use the shortest form
possible, for example, producing a two-byte sequence with first byte 0xc0
is nonconforming.  Unicode 3.1 has added the requirement that conforming
programs must not accept non-shortest forms in their input."

So is it that exfat is rejecting nonconforming sequences?  Or is it
converting the nonconforming sequence from 0xc0 0xaf to the conforming
sequence 0x2f, and then rejecting it (because it's '/')?

