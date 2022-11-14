Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D48C43219
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Nov 2022 11:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiKNLcl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Nov 2022 06:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbiKNLcX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Nov 2022 06:32:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E4E111B
        for <fstests@vger.kernel.org>; Mon, 14 Nov 2022 03:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668425486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2rB3wzOCzs5u3el8ehNKoXXxgk2BS/YYI3SevxAA1is=;
        b=DRH4A6RV61r/77yq1n7ME9HETTbTPHUWGacjHpcC6ZXQuoEwUKn2qSVPXsTvpKe167WOWr
        GSY2Vf8LKt6aYhkj2TReyZr1Sh8up3vQosBvpeBLQZcRSU5SZJFxzoJXneDBULu6Nughi9
        WsVzjwnIQC3duFHjSXuvefHWhvWu9dY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-43-fXNlCCv1MTSrjPTEecUroA-1; Mon, 14 Nov 2022 06:31:25 -0500
X-MC-Unique: fXNlCCv1MTSrjPTEecUroA-1
Received: by mail-qv1-f72.google.com with SMTP id 71-20020a0c804d000000b004b2fb260447so8267422qva.10
        for <fstests@vger.kernel.org>; Mon, 14 Nov 2022 03:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rB3wzOCzs5u3el8ehNKoXXxgk2BS/YYI3SevxAA1is=;
        b=XGH1YEFFgl2NuHpJNORqhZaTGey9NYfRvQj2DkwEea7zI25O+N9//dYUfp5jSu86zs
         efcXPjnW1Oswei8gSOfPgzDfWbNDEg4ThNcw5hinBnFMYBYGJiZeEGMNPVSdp4JDnpmC
         nMfiFZa3CsbolXDLTEN6Fatl7Kw85w1jo9k2YKh4W7LmxeC5IOyLiTAWNHKDxrptFDD2
         FVkw2fHogFDQ7sDcFZJSjni1/EoyvSV4GVyAjIuyNyBsgD2gJ1V/BwHIpFOnVN+n+upO
         B/aYIrOgc2P44/TQ8X4SAAMSOoVYI3gZTAHMH2gs0fJuL7TirSYqh7i5Ebbl8c+/dgTt
         9kTg==
X-Gm-Message-State: ANoB5pnInQJvwECuM03j/n/r9LSpx7gjXq6TwypB7cV1rCxSAtcBiEbM
        VwakTFlFVwNKS7WqsIXyp3eh6gKk4SO5kX4dupe/EtCMEh7m8Pu3AcKbNDM2MfNLWXhAWmTlW47
        dXsD2lZCJWYfXetEL
X-Received: by 2002:a05:620a:439c:b0:6ba:f088:cfd8 with SMTP id a28-20020a05620a439c00b006baf088cfd8mr10738811qkp.736.1668425484859;
        Mon, 14 Nov 2022 03:31:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5M8qdrpic/fhkFnlbRtFhtHlz4b4OeT53tkj2RrFl/WJ0Rn+ohXNM70ECbMpU3dvieE7cLzw==
X-Received: by 2002:a05:620a:439c:b0:6ba:f088:cfd8 with SMTP id a28-20020a05620a439c00b006baf088cfd8mr10738787qkp.736.1668425484375;
        Mon, 14 Nov 2022 03:31:24 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a16ad00b006fb112f512csm6177577qkj.74.2022.11.14.03.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 03:31:24 -0800 (PST)
Date:   Mon, 14 Nov 2022 12:31:21 +0100
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: update group name according to xfs_io command
 requirement
Message-ID: <20221114113121.qgp4qs6ycc5ccdlj@aalbersh.remote.csb>
References: <20221108183242.3362013-1-zlang@kernel.org>
 <20221111015835.j4pf2gqsd3qipjmj@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111015835.j4pf2gqsd3qipjmj@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Nov 11, 2022 at 09:58:35AM +0800, Zorro Lang wrote:
> On Wed, Nov 09, 2022 at 02:32:42AM +0800, Zorro Lang wrote:
> > When a test case requires someone xfs_io command, that nearly means
> > that case belong that kind of test group. Likes fpunch for punch
> > group, fcollapse for collapse group, falloc for prealloc group, fzero
> > for zero group and so on.
> > 
> > Many fstests cases miss some test groups they should belong to, so
> > this patch trys to supplement this lack,  according to the "xxxx"
> > which required by _require_xfs_io_command "xxxx".
> > 
> > Reported-by: Theodore Ts'o <tytso@mit.edu>
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> > 
> > Hi,
> > 
> > Ted complains the insert and collapse groups missing [1], cause he
> > have to skip some cases by command of _require_xfs_io_command.
> > 
> > I think the group missing is the real problem and the first problem,
> > so I'm trying to add missed groups to fstests cases, simply according
> > to _require_xfs_io_command lines.
> > 
> > By a simple grep, I found there're too many cases contain _require_xfs_io_command,
> > so I wrote a ugly temporary script to help to do this job automatically as [2].
> > This script is not good enough, so I took a little time to do manual checking
> > after running the script. Hope this patch helps, feel free to review or test,
> > and please tell me if I miss something.
> 
> Any comments about this change? I'm not asking for reviewing that script,
> just the group names change :)
> 
> Thanks,
> Zorro
> 

The changes looks good to me (also did some manual checking).
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

But otherwise, I think, as it's in shape now it's more work for
reviewer - to check those groups, as it could be done automatically
maybe it make sense to add similar script to build system, maybe? :)

Btw, which commands are considered to have their own group? pwrite,
for example, doesn't have a group (so, those tests aren't changed).

-- 
- Andrey

