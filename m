Return-Path: <SRS0=wZFd=7L=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC49C433E0
	for <linux-fstests@archiver.kernel.org>; Fri, 29 May 2020 04:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854BB20707
	for <linux-fstests@archiver.kernel.org>; Fri, 29 May 2020 04:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqSM5l1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgE2Eg4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 29 May 2020 00:36:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39222 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbgE2Eg4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 May 2020 00:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590727014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OsJQ7HE5pbYkB90/p5XHSyPuieFk9BMVpHlPQ8fS1Tk=;
        b=KqSM5l1A1wpeQ2IbNlcnVXO97hVqha3fZ3vr9IPmKoansrAWj+ORVuREABjEuxi6xeI1Sj
        T4fPycMmLEFS8nLOkbKaphIu5seFta1pdCWl79PngdUKTp0s1k/kHBgDU+nwyMSluQr1wz
        IeQO9aKiX9jRcU0w/U1IV3Qh6DHoFTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-IDZCbyRKOFS2Nk-zpykq6w-1; Fri, 29 May 2020 00:36:52 -0400
X-MC-Unique: IDZCbyRKOFS2Nk-zpykq6w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42DF31005510
        for <fstests@vger.kernel.org>; Fri, 29 May 2020 04:36:51 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5355579A5
        for <fstests@vger.kernel.org>; Fri, 29 May 2020 04:36:50 +0000 (UTC)
Date:   Fri, 29 May 2020 12:48:22 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/484: add _require_xfs_io_command "syncfs"
Message-ID: <20200529044821.GG1938@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <1590651179-5695-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590651179-5695-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 28, 2020 at 03:32:59PM +0800, Yang Xu wrote:
> When using old xfsprogs version, xfs_io doesn't support syncfs command.
> It was not fixed until xfsprogs commit eb24bcffc0("xfs_io: fix missing syncfs command").
> Add a require for this so that we can skip this case if xfs_io doesn't
> support syncfs command.
> 
> Reported-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  tests/generic/484 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/484 b/tests/generic/484
> index cf257c6b..dad411e9 100755
> --- a/tests/generic/484
> +++ b/tests/generic/484
> @@ -42,6 +42,7 @@ _require_scratch_nocheck
>  # realtime subvolume, thus the test will fail with rtinherit=1
>  _require_no_rtinherit
>  _require_dm_target error
> +_require_xfs_io_command "syncfs"

That's good to me, as ext4/034 and generic/474 already had this 'requirement'.
Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  
>  rm -f $seqres.full
>  
> -- 
> 2.23.0
> 
> 
> 

