Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BC8C7EE23
	for <linux-fstests@archiver.kernel.org>; Thu,  8 Jun 2023 10:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjFHKjT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 8 Jun 2023 06:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjFHKjS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Jun 2023 06:39:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6A8273E
        for <fstests@vger.kernel.org>; Thu,  8 Jun 2023 03:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686220690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0soHcIINz/aqkgOrMyGWCwcMQ5dQQuCg3zca+l6XCFI=;
        b=XhjLU0mIdLhfZAGvnoY+/8qUKJgLpcsSr0Nhyh8pzRoKKgFSvZYyRUJ6ppsax/4G6adBEq
        iakPAHumLnJ1cxVBPq/l/WHb/AeV2cKZvyrqlcSKZ62n7+YGY/ASxIblbPVBKBkYvIZ9Ek
        nmejUcak8jD0xzHx5SkTFpCWB/r6aFU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-sB4LNGXRPoavtv_0bvPSeQ-1; Thu, 08 Jun 2023 06:38:09 -0400
X-MC-Unique: sB4LNGXRPoavtv_0bvPSeQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f6089a9689so2765155e9.1
        for <fstests@vger.kernel.org>; Thu, 08 Jun 2023 03:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220688; x=1688812688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0soHcIINz/aqkgOrMyGWCwcMQ5dQQuCg3zca+l6XCFI=;
        b=cBEE+FHqG06tHKP/d3UUzR/UHnoJ9KBLxRFhFuokAtlCbrTfgTYYLdDS3OECaokH7M
         k9VrMvTnQf7KkIHgsQTR0tmtvgKkOhScX5EF5QfKu4FBD2xIv0kU8dpDgKP2izWOjoXh
         ubH3mnRPEdmpdtSqDmeS5jKD4qWxkX+76aVszGvBThzXXWgmH9eE7+AfpfR2iqRbn6v2
         +HL0ly5spZLRnPzeRa0Qzd2vi+3zFp7rJAjT6luViyTEajZm/elvK/sB5h6cV9kDGezf
         qYvbH7DYGMvm8Vc05B62IH3iYfuPj3J/MKh8mqEXVq+iDrE9FYqVslFsdoEPFn4aB8BG
         BItg==
X-Gm-Message-State: AC+VfDzFTv+0tp96PXYpHU123G4WuD/8c8am3jOu6N9MfopMs/XxF0G6
        BkFi0QqhnpLJt4CbnW4hGzkrJy2pcUeTIC48IVBGAMTxEx2rg3WFsaUAU+1UH6I4+kGdvNn5KXz
        gGVbsDMvohAnq0DrkRKSzCV6j
X-Received: by 2002:a05:600c:21c5:b0:3f5:fb98:729e with SMTP id x5-20020a05600c21c500b003f5fb98729emr1125966wmj.22.1686220688118;
        Thu, 08 Jun 2023 03:38:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7unE9bT25qBnFU9fLIaLLec8dxlYXRLlL7cGYKN+eLbUks1/RHsbSIFbGTkpF6RsUqu7RlxQ==
X-Received: by 2002:a05:600c:21c5:b0:3f5:fb98:729e with SMTP id x5-20020a05600c21c500b003f5fb98729emr1125950wmj.22.1686220687829;
        Thu, 08 Jun 2023 03:38:07 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c205300b003f7cb42fa20sm1540906wmg.42.2023.06.08.03.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:38:06 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:38:04 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     zlang@redhat.com, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCHSET 0/3] fstests: reduce scrub time in testing
Message-ID: <20230608103804.uchw2l257ug3fa5c@aalbersh.remote.csb>
References: <168609056295.2592490.1272515528324889317.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168609056295.2592490.1272515528324889317.stgit@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2023-06-06 15:29:22, Darrick J. Wong wrote:
> Hi all,
> 
> For fuzz testing of the filesystem repair tools, there's no point in
> having _check_xfs_filesystem rebuild the filesystem metadata with
> xfs_repair or xfs_scrub after it's already been testing both.  This can
> reduce the runtime of those tests considerably.
> 
> Do the same for xfs/503 since we're only concerned with testing that
> metadump and mdrestore work properly.
> 
> If you're going to start using this mess, you probably ought to just
> pull from my git trees, which are linked below.
> 
> This is an extraordinary way to destroy everything.  Enjoy!
> Comments and questions are, as always, welcome.
> 
> --D
> 
> fstests git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=scrub-test-speedups
> ---
>  common/fuzzy  |    7 ++++++-
>  common/rc     |    2 +-
>  common/xfs    |   31 ++++++++++++++++++++++---------
>  tests/xfs/503 |    2 ++
>  4 files changed, 31 insertions(+), 11 deletions(-)
> 

The whole patchset looks good to me.
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey

