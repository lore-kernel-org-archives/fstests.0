Return-Path: <SRS0=+iS3=2F=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD37C43603
	for <linux-fstests@archiver.kernel.org>; Sun, 15 Dec 2019 16:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE1D206D3
	for <linux-fstests@archiver.kernel.org>; Sun, 15 Dec 2019 16:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7Z0NhW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfLOQIg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 15 Dec 2019 11:08:36 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46626 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfLOQIg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 15 Dec 2019 11:08:36 -0500
Received: by mail-pl1-f193.google.com with SMTP id k20so3386761pll.13
        for <fstests@vger.kernel.org>; Sun, 15 Dec 2019 08:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WL/1nr1QLf5Hzc6aoS+YNEW3bBVC2Qb/XN7zSzF0FRo=;
        b=H7Z0NhW5Me1Yr0R2vMwmP6fgEYNKPF2wdJg+PQ/X7PpQLVL8JFA5J+35nP3inG37+y
         LDTzXfEfLtfNQEONP6z2m7NReVdVXyZdDBsz/u1EvULZ8rAdrML29u8w2Jx6PXBlv6W0
         1HxjHyrIAQdY6U8U4j+MeIxZmj7QEhyN90mAp1+siVpAoPfiqpnpqO2sF/QlK9ea0RZ1
         qV4E32qgth7ZGBC0hO0p+olaoKFVNX6zUnAEp8yZkJoob/0nIr2KTX6hYyCszpF79VTu
         nMWeLF6cHEl5EZux9y9W8fXOAk9kjNVjVVdKcdpbLzTe0DU+MRN5sqe2PJxnP770WJ6C
         VnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WL/1nr1QLf5Hzc6aoS+YNEW3bBVC2Qb/XN7zSzF0FRo=;
        b=cc9iqa/Kts5JVKK17ca55bJWTf6xZdZxjY4TnNRK+7uepdcIe0RmmziTQ2FjOB8SJD
         S4VpqVrKoNKptAiBZ+v3uy6BXiPZF4cTz9FqEA+LJ4oQDYBrj5Jngd6z5MgdZ/rD6hfh
         ve+si0Mej1H5Xq4avGSbPkfWIQ9vZL5v3FzEq4/qT9RkszAcoREObGPbJ7rR0hDbiLMj
         HDAdGrjUGL3vA8rWqlbD7uh76OjKL7hOSGtCxKsHUz0xEl0DRkq9Om0BjZ9b+xfouboV
         Z8drAkouG/clXmU8Mxcs5aXHDaM/Q9NOW8gDmDXrA9o4yTucxtjTPTQbWu9QjFqE+Q+m
         E0MQ==
X-Gm-Message-State: APjAAAV4IibdizXxK4AbWsjdrIWqtOXBP/sB0QBp/UQAZZSKA928s0PV
        4Pf8vPyWpkGkEEbr5qyESTE=
X-Google-Smtp-Source: APXvYqwYpw45LL4JxvSQlOu6CzGAy5dIIdXm22qSSHbUz6hJrqIWDRj+ebOIQnlGC+6gZ8vCDCPkjA==
X-Received: by 2002:a17:90a:a44:: with SMTP id o62mr12696015pjo.80.1576426115625;
        Sun, 15 Dec 2019 08:08:35 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id e25sm17781283pge.64.2019.12.15.08.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 08:08:35 -0800 (PST)
Date:   Mon, 16 Dec 2019 00:08:30 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Kusanagi Kouichi <slash@ac.auone-net.jp>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] common/filter: prepend 0 to treat offset as octal
Message-ID: <20191215160828.GB1776323@desktop>
References: <20191212031152.1906287-1-naohiro.aota@wdc.com>
 <20191212060437.GA99869@magnolia>
 <20191212100009818.MNNO.12766.ppp.dion.ne.jp@dmta0006.auone-net.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212100009818.MNNO.12766.ppp.dion.ne.jp@dmta0006.auone-net.jp>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Dec 12, 2019 at 07:00:09PM +0900, Kusanagi Kouichi wrote:
> On 2019-12-11 22:04:37 -0800, Darrick J. Wong wrote:
> > On Thu, Dec 12, 2019 at 12:11:52PM +0900, Naohiro Aota wrote:
> > > The offsets printed by "od" are octal numbers. So, we need to add "0" at
> > > the head of the $offset to parse it as an octal number.
> > > 
> > > Fixes: 37520a314bd4 ("fstests: Don't use gawk's strtonum")
> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > 
> > <grumble> Did the original patch author run all the tests that use
> > _filter_od to make sure there weren't any regressions.  This fixes
> > xfs/139 for me, so...
> 
> I'm sorry. I didn't test well. Eryu, can you revert commit 37520a314bd4?

Sure, I'll just revert it for now.

Eryu
