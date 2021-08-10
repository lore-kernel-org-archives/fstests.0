Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63798C4338F
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Aug 2021 21:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36EED61077
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Aug 2021 21:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbhHJVbt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 Aug 2021 17:31:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233625AbhHJVbt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 10 Aug 2021 17:31:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0542461019;
        Tue, 10 Aug 2021 21:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628631087;
        bh=UDMwx2q99TfgQbOEjtpB26rCgk+Rsd+p41hRotSTIao=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fXv4mVXSEqjH2bEBdG5SF20qh3Y4W8zp7EbFFDQEGloJtpxeSZSG27jdb/pDTSrvO
         X2aGW+PmDVR9rJY6OS7SbmO0iM7xvNmnjyln3rmOVEUxy1L0YHAk2oGlbQj6SwuS1s
         O6NkLAjAHUQ+9hsnWy6KTyxf7xeRVYk787TAanUWurI4Xdd/rDWtaM40RZ3BXd9B7O
         OG7tKUHvXOmfO2GzLqOovC/Lo8eCi98g4CvT4surhIP7gAYbRJ885UcjCvVhBnzGmY
         l0KCTAn922VGYMVmOWOivB0L0Fi0aRLSgn79jimjr8Tqjchw3KYow24ht6Vjne4eUh
         sg7hWsXRV6aRw==
Received: by mail-qv1-f41.google.com with SMTP id m12so62703qvt.1;
        Tue, 10 Aug 2021 14:31:26 -0700 (PDT)
X-Gm-Message-State: AOAM533ceMWJmzMRoDV6fYFVhDYnsPU/D9Db17Us07ayD09RCrlzYivG
        gAXtu2LChTbNQvDq+2bfbpSBX65HAWLYVpNEg/k=
X-Google-Smtp-Source: ABdhPJxOskfCDOWSoSq/GETYRKrlJxVpP30mI6v88L3ZWrcvSduFa4roezd2UW+1ImoP+XQavwTSJMpvRGQpBZEDI0M=
X-Received: by 2002:ad4:4ea8:: with SMTP id ed8mr19931056qvb.2.1628631086202;
 Tue, 10 Aug 2021 14:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210727201045.2540681-1-mcgrof@kernel.org> <20210727201045.2540681-4-mcgrof@kernel.org>
In-Reply-To: <20210727201045.2540681-4-mcgrof@kernel.org>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Tue, 10 Aug 2021 14:31:14 -0700
X-Gmail-Original-Message-ID: <CAB=NE6U0Evs5mAwvgLBnMNHB0pF+UjTB66R_3r+nu8EHxN5hWg@mail.gmail.com>
Message-ID: <CAB=NE6U0Evs5mAwvgLBnMNHB0pF+UjTB66R_3r+nu8EHxN5hWg@mail.gmail.com>
Subject: Re: [PATCH 3/4] common/module: add a patient module rmmod
To:     fstests <fstests@vger.kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Douglas Gilbert <dgilbert@interlog.com>,
        Jessica Yu <jeyu@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

I see the first two patches in this series were applied. Great!

I also see this patch and the next one is not applied yet. Please
don't apply as I'll resend a new set now with some more enhancements
after finding out this issue is very generic and requires a kmod
solution. I'll post these patches soon.

 Luis
