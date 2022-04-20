Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F1AC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 20 Apr 2022 17:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381355AbiDTSCk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 Apr 2022 14:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381449AbiDTSCV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Apr 2022 14:02:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7BA47566
        for <fstests@vger.kernel.org>; Wed, 20 Apr 2022 10:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAEC9B81EB6
        for <fstests@vger.kernel.org>; Wed, 20 Apr 2022 17:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BBBC385A0;
        Wed, 20 Apr 2022 17:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650477555;
        bh=EZHeW5t2qhKMbPT6SiQTXvuIYDcYN1SZVP1NKZIPa0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IAx/T7fxspsDYAnuZF8XpyjlzxlyFS4m56lG0RdgUJTQsRz83iN88bWJ7jYej/OWO
         hyKwuF5qnE9cBZnD2IUp61CtKeHhSs1z9W/6Lpq0RE5FzeLKtjxRSzB0S3/j+divpR
         as5Ofqut8FqwoDBKYEdIj/qNaVvY0fuVOQMXN0OCvlG2ebWG/6Qe6HrLmydPI7IVq0
         wyOKkW0ER1TwoVyA33Yduyxy5Gv944+YTABM/quEHxh19IEUAfY2hME5QVhUI5LEDc
         BaVwY/BniJOCzEi7ozjLvW6oC+MCjERd9qgJi9MOL1anX04S4qF8GdUzwgF9xwn6dv
         NEcmcXj7lnNlg==
Date:   Wed, 20 Apr 2022 19:59:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>, Eryu Guan <guaneryu@gmail.com>,
        Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix generic/633 failure on systems without
 CONFIG_USER_NS
Message-ID: <20220420175911.ei7l4xb6mee3a2cn@wittgenstein>
References: <20220331111920.8377-1-jack@suse.cz>
 <20220331113912.uzaojcp3ih5uibmr@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220331113912.uzaojcp3ih5uibmr@wittgenstein>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Mar 31, 2022 at 01:39:12PM +0200, Christian Brauner wrote:
> On Thu, Mar 31, 2022 at 01:19:18PM +0200, Jan Kara wrote:
> > Hello!
> > 
> > these two patches fix a failure of test generic/633 on a system without
> > CONFIG_USER_NS.
> 
> Thank you!
> I've pulled and tested the patches.
> RVB+TB on the individual patches.

Hey Eryu,
hey Zorro,

Jan's patches have not shown up in xfstests upstream and I think they
got lost on the mailing list.

Hopefully they can be picked up this week.

Thanks!
Christian
