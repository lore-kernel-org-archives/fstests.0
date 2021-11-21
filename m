Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1A8C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Nov 2021 15:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbhKUPbe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Nov 2021 10:31:34 -0500
Received: from out20-26.mail.aliyun.com ([115.124.20.26]:47951 "EHLO
        out20-26.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbhKUPbe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Nov 2021 10:31:34 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2924398|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.402921-0.0123653-0.584714;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Lwg8U5W_1637508507;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Lwg8U5W_1637508507)
          by smtp.aliyun-inc.com(10.147.40.2);
          Sun, 21 Nov 2021 23:28:27 +0800
Date:   Sun, 21 Nov 2021 23:28:27 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Radoslav Kolev <radoslav.kolev@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: read only filesystem tests
Message-ID: <YZplm9Xo1lRKMJCN@desktop>
References: <e64129cb-dec9-f0bb-9a50-ede0a7b2aca6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e64129cb-dec9-f0bb-9a50-ede0a7b2aca6@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 15, 2021 at 01:18:25PM +0200, Radoslav Kolev wrote:
> Hello,
> 
> I am interested in read only filesystem tests, and more specifically
> squashfs. I saw that ~2 year ago there was a patch set submitted, but not
> accepted that added support for it with some feedback, that
> the tests are copied and double the maintenance burden, but sadly there is
> no easy way to avoid that.
> 
> What is the current mood about read only filesystem tests and fstests?

I'd like to see tests for readonly filesystems, squashfs is definitely
one target, and other readonly filesystems like erofs could benefit from
the tests as well.

> Is this the right project to fill this need and is it worth it trying to
> address some of the problems with the old squashfs patches?

I think so, at least I'm happy to see readonly tests in fstests
personally. But, to be honest, I still didn't come out with a good way
to share existing generic tests for RO filesystems.. And I think it's a
good opportunity to use wisdom from the community :)

Thanks,
Eryu
