Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EB7C4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Oct 2022 15:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiJQPHK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Oct 2022 11:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiJQPG4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Oct 2022 11:06:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E451E2F38C
        for <fstests@vger.kernel.org>; Mon, 17 Oct 2022 08:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0ECDAB81902
        for <fstests@vger.kernel.org>; Mon, 17 Oct 2022 15:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A9CC433D6;
        Mon, 17 Oct 2022 15:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666019052;
        bh=LniUQ6HzToLAv9exx7oJLcc2O5Bb1u2HmqCsUDRtxf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Az1IgMNXzi55aDiGv/xeKNmN/bb8c7UOng1eR6UOc/lyurWd4Kr/hq4pAu2Pq1GV+
         sVyMmebCXgr9jP/6oH81g4wzlKfEpgW1GGhmeCztFIEkbBGeSjJdfSejro6uFNhYNu
         EEBJnzMdccPvSryuNzXSXGtYI46f7uSW3ppjYIPDvLmpVW01KoZURoe1EyAgerEpu9
         f8CxBGox38TFxAk9aOtICGQEEBTdyolEbCVQdjWslvABVajiFp58BGCBrOTA6O+Cxg
         k/2xF1Gad6G67ovsZiIMiuzxpxb3wqMKumE/Luimyx36fu5rdvQ5BHSCmOdtYYVmpU
         P6tXTQ1Vn1Yjg==
Date:   Mon, 17 Oct 2022 17:04:08 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/193: add to perms group
Message-ID: <20221017150408.ddda2hpggg5x7ljh@wittgenstein>
References: <20221017095311.68280-1-brauner@kernel.org>
 <7eb737f8-5fb2-97ac-6ad7-eb1ce8a59f30@fujitsu.com>
 <20221017132914.zj3lou5cizuuxluv@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221017132914.zj3lou5cizuuxluv@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 17, 2022 at 09:29:14PM +0800, Zorro Lang wrote:
> On Mon, Oct 17, 2022 at 10:01:13AM +0000, xuyang2018.jy@fujitsu.com wrote:
> > 
> > 
> > on 2022/10/17 17:53, Christian Brauner wrote:
> > > This test changes permissions and specifically tests for setuid and
> > > setgid bits to be dropped or kept. It really needs to be run when -g
> > > perms is specified.
> > 
> > Yes, Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > 
> > ps: generic/67[3-4] and generic/68[3-7] test suid and sgid, they should 
> > also add perms group.
> 
> OK, if Christian agrees with this point and would like to help that, please
> help to check and add "perms" to more proper cases in one patch.

I think that's a good idea. Yang, would you be open to sending a patch
to add all these test to the "perms" group in one go?
