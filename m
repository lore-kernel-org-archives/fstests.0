Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2453C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 17 May 2022 09:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243266AbiEQJTP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 May 2022 05:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244485AbiEQJTE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 May 2022 05:19:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06E42B19A
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 02:18:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B4F1B817D0
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 09:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE50C385B8;
        Tue, 17 May 2022 09:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652779126;
        bh=sQ9inMjzpES2WE3t1EPquQ1yTK6tLREWv+Js9z9QWvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xgkku8GwdHQuSHKWd1wV9NdXEbKAjSY85vuuRx4+7e5vIbNMnG53vBMOYUgvo5Pzt
         PHKWv8JWee6760KaFwqod1hJPMSj3K0RzndJ3tLfyda8oWNK/7EDjZawB8fTfzJsy1
         TF030tP7cT9VwHY0HAWBqhBWchzJMOhArQ/aVOss0dpM+W31KzB6cVZRdjCdjUDc2Q
         2VwB5US36c+ZzyyeTbAg6VpIhVvQePhetS5TENTgpLRbnSeATN4JODkR55ioHBzTWH
         LYWHGI6+3Jun21PmMe3hQ01cxdjdPjDati3r48kSj91Jv0KfuuSECVlKAF6APQWMZd
         mpOZ8U/53Epag==
Date:   Tue, 17 May 2022 11:18:42 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to 781bb995a149
Message-ID: <20220517091842.hqmozwfgiwont5pn@wittgenstein>
References: <20220515054317.C66CCC385B8@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220515054317.C66CCC385B8@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, May 15, 2022 at 01:43:15PM +0800, Zorro Lang wrote:
> Hi all,
> 
> The for-next branch of the xfstests repository at:
> 
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> has just been updated and tagged as v2022.05.15 release.
> 
> There're two improvements:
> 1) A big change from Christian is the whole src/idmapped-mounts refactoring, so
> if have old related patches, please rebase on the latest for-next. Thanks!

Thank you for your support!

Christian
