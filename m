Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368BAC61DA4
	for <linux-fstests@archiver.kernel.org>; Sat, 18 Feb 2023 06:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjBRGRL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 18 Feb 2023 01:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBRGRK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 18 Feb 2023 01:17:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6DD56EC2
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2023 22:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676700986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=APW3oIrUEWEjGiKY4gDaezSSYCh4pa4uaTuapF7axes=;
        b=bjv3dJjMqGoddbyC7UDW/zZNFKEJ7v8alsWTpPpiznyVH9E7d3P1T7r4LH4wsXx+tArP4q
        P1uzbE+X1m/ahoSPPFgiVEeeGY2tLIc6pApqBMEF0R9lC2W8Z5uxJaVgx2VCZzxlBCod+u
        tX+Rqa1RVTEtSZ2iDCFYI+2Gekjo8Ug=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-120-1fK1ixX7OLidzHTjlQYAJQ-1; Sat, 18 Feb 2023 01:16:24 -0500
X-MC-Unique: 1fK1ixX7OLidzHTjlQYAJQ-1
Received: by mail-pf1-f197.google.com with SMTP id o6-20020a056a00214600b005a8da78efedso4752pfk.2
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2023 22:16:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APW3oIrUEWEjGiKY4gDaezSSYCh4pa4uaTuapF7axes=;
        b=J4E2YArXUTP+OAsheGqP3fwIgRBtukHg8ZtdGSwTvaJmv/CxyN/enxT3YHknranw3N
         jZzkwqvV1hQKo0+sow2DpZDGQwkfMBOGy/rmlxcpuH9kZgzzCPjDoTPGQl8VqjyX1E+A
         NWOKvVn3X6s9LytAAGc8y6siIbChHUngAuE7Vyevc+WIK0/MK1BX/MVkbEfVYSdUjhIh
         abcT09gJ4pKekJpaCvWwuJK1cur5S54o/np4CIpeq4t8EvijAnQAHUv/yqSdxwE9GS7Q
         uPr+VbOJ0UkWOg6+MhwF32TZYz9YUyF89TvtSZIyYzBCCVtJycm813vpspt+ZXHsK7fj
         h6Iw==
X-Gm-Message-State: AO0yUKXpp7S7bnr8+mglfMKHgXh2elA3cbdWnS6b/jRsST8OkkTNu1qj
        nkZ/HlmvEL7MJr3Py1Hrie6PF4kE0FZkEFcosrDkCXVtXT9t1iOTvggY3959+TrqEfOM4gInUuX
        9s5JsFFDK68IZokY2jBwpZobjWw==
X-Received: by 2002:a62:3207:0:b0:5a8:f259:21ff with SMTP id y7-20020a623207000000b005a8f25921ffmr2898174pfy.14.1676700983558;
        Fri, 17 Feb 2023 22:16:23 -0800 (PST)
X-Google-Smtp-Source: AK7set9wqmFS6PWOBqSHVUEHyt/bHCfsFspW5IAN98x62TFf3khHQXVJ+PsyTaecy0FHxXowJKNAmA==
X-Received: by 2002:a62:3207:0:b0:5a8:f259:21ff with SMTP id y7-20020a623207000000b005a8f25921ffmr2898161pfy.14.1676700983232;
        Fri, 17 Feb 2023 22:16:23 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t17-20020a62ea11000000b005ac8a51d591sm655123pfh.21.2023.02.17.22.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 22:16:22 -0800 (PST)
Date:   Sat, 18 Feb 2023 14:16:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCHSET v24.0 0/2] fstests: fix a few bugs in fs population
Message-ID: <20230218061619.djsl2ljza625qjx5@zlang-mailbox>
References: <Y69Unb7KRM5awJoV@magnolia>
 <167243877612.728350.1799909806305296744.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167243877612.728350.1799909806305296744.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Dec 30, 2022 at 02:19:36PM -0800, Darrick J. Wong wrote:
> Hi all,
> 
> Before we start on an intense patchset of improving the XFS fuzz testing
> framework, let's fix a couple of bugs in the code that creates sample
> filesystems with all types of metadata.
> 
> If you're going to start using this mess, you probably ought to just
> pull from my git trees, which are linked below.
> 
> This is an extraordinary way to destroy everything.  Enjoy!
> Comments and questions are, as always, welcome.
> 
> --D

Ack,

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> fstests git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=fix-populate-problems
> ---
>  common/populate |   70 ++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 46 insertions(+), 24 deletions(-)
> 

