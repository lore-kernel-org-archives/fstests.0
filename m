Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CC3C3DA7D
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Jan 2023 13:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjAANb2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 1 Jan 2023 08:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAANb2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 Jan 2023 08:31:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D83B3894
        for <fstests@vger.kernel.org>; Sun,  1 Jan 2023 05:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672579839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PfyKh+6ly8mcavFLlVRXy4fl8nsb5VprOU1Yhje8hko=;
        b=izhNnQHRE7KlYb7hftRtHtqk8eK0bzvsK24OAp+mSSaazQLEPB/Thc0cvx2P+isjV3XfUO
        uZERU8Y/1sswZG5NhSRFuFsiLKvsxdJeDrG12LEKxYpYM+6e03fpq/N19K7J5o3bU1paWM
        dJ2QJSnBICRXjx6jeg9M0dj9u6W03ck=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-547-hd7m_p1SOnG9NBlVW1y2ig-1; Sun, 01 Jan 2023 08:30:38 -0500
X-MC-Unique: hd7m_p1SOnG9NBlVW1y2ig-1
Received: by mail-pj1-f69.google.com with SMTP id z4-20020a17090ab10400b002195a146546so18017975pjq.9
        for <fstests@vger.kernel.org>; Sun, 01 Jan 2023 05:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfyKh+6ly8mcavFLlVRXy4fl8nsb5VprOU1Yhje8hko=;
        b=Hx8g/4yjiH3PlHlbCztHtvdEIg+YolMzZEHugL9BurehLAIl6CBBiVuEw8vDaXHLwF
         HG5wet3NNiSwnWJefZWY8qenMokp+hAyiB3vaniu3/j5KlvYv5qTgXJPROe/wne0PpfR
         opqSlWeyklYVYUV3zXIZpVJ2zqt9As15ZkTDQ187ykOqhrxKeaJXPxZEm3HMLg7FlajG
         7lFxnj1v7xYhXTAm8mVQ4ZqmBO4uQh3Q8wKK0W3D7+oQQ3Qv2HOjjLpjVlFWf8CL+K8x
         90MY5XWwnX3JYNpezqQKBMlDpHeTLEKzionvqcYGofe/LNB0dGuW6O5RaEveoEQ66zdU
         a71A==
X-Gm-Message-State: AFqh2kpbYMTgmBUY/2znrOCcDO42Bgue08nRigiUcAKFRIAvjwgUSB2a
        yK8V/D7RtRfx9nQsjoFOr5zJ5xZFfnXmCaabK7cMdKXcsXzqsK+WQ0ZviIoZ2C+G5ltguix2W1g
        s4exMiJ98bQgyIogWUg==
X-Received: by 2002:aa7:9147:0:b0:56c:318a:f83b with SMTP id 7-20020aa79147000000b0056c318af83bmr44952568pfi.13.1672579836906;
        Sun, 01 Jan 2023 05:30:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsZcU2Onik1n60YvsLbDVPYFSI38W8QIO1sdI79iDnlqKaQNWTbKI/2r0XZuH9+dgDdmHkEOA==
X-Received: by 2002:aa7:9147:0:b0:56c:318a:f83b with SMTP id 7-20020aa79147000000b0056c318af83bmr44952552pfi.13.1672579836596;
        Sun, 01 Jan 2023 05:30:36 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z15-20020a63190f000000b0046ffe3fea77sm15361159pgl.76.2023.01.01.05.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 05:30:36 -0800 (PST)
Date:   Sun, 1 Jan 2023 21:30:32 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH v3 00/10] xfstests: update verity tests for non-4K block
 and page size
Message-ID: <20230101133032.6jz4dvd6wx5m3ws5@zlang-mailbox>
References: <20221229233222.119630-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229233222.119630-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Dec 29, 2022 at 03:32:12PM -0800, Eric Biggers wrote:
> This series updates the verity xfstests to eliminate implicit
> assumptions that 'merkle_tree_block_size == fs_block_size == page_size
> == 4096', and to provide some test coverage for cases where
> merkle_tree_block_size differs from fs_block_size and/or page_size.  It
> doesn't add any new test scripts, but it does update some of the
> existing test scripts to test multiple block sizes.
> 
> This goes along with my kernel patch series
> "fsverity: support for non-4K pages"
> (https://lore.kernel.org/linux-fsdevel/20221223203638.41293-1-ebiggers@kernel.org/T/#u).
> However, it's not necessary to wait for that kernel patch series to be
> applied before applying this xfstests patch series.
> 
> Changed in v3:
>   - Fixed generic/574 failure with some bash versions.

Thanks for fixing this failure, this version looks good to me. I'd like to
merge this patchset with my RVB.

> 
> Changed in v2:
>   - Adjusted the output of generic/574, generic/575, and generic/624
>     slightly to avoid confusion.
> 
> Eric Biggers (10):
>   common/verity: add and use _fsv_can_enable()
>   common/verity: set FSV_BLOCK_SIZE to an appropriate value
>   common/verity: use FSV_BLOCK_SIZE by default
>   common/verity: add _filter_fsverity_digest()
>   generic/572: support non-4K Merkle tree block size
>   generic/573: support non-4K Merkle tree block size
>   generic/577: support non-4K Merkle tree block size
>   generic/574: test multiple Merkle tree block sizes
>   generic/624: test multiple Merkle tree block sizes
>   generic/575: test 1K Merkle tree block size
> 
>  common/verity         |  84 ++++++++++++----
>  tests/generic/572     |  21 ++--
>  tests/generic/572.out |  10 +-
>  tests/generic/573     |   8 +-
>  tests/generic/574     | 219 +++++++++++++++++++++++++-----------------
>  tests/generic/574.out |  83 +---------------
>  tests/generic/575     |  57 ++++++++---
>  tests/generic/575.out |   8 +-
>  tests/generic/577     |  24 ++---
>  tests/generic/577.out |  10 +-
>  tests/generic/624     | 119 ++++++++++++++++-------
>  tests/generic/624.out |  15 +--
>  12 files changed, 370 insertions(+), 288 deletions(-)
> 
> 
> base-commit: 3dc46f477b39d732e1841e6f5a180759cee3e8ce
> -- 
> 2.39.0
> 

