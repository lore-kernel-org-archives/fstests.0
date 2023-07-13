Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACABC0015E
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Jul 2023 15:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjGMPgK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Jul 2023 11:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGMPgJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Jul 2023 11:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8642730F5
        for <fstests@vger.kernel.org>; Thu, 13 Jul 2023 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689262504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WWX/2RdmzMlzeOXQbV2SXlI4tVXd/cgTFBBGmD8VxPY=;
        b=fMYD0ExBEZOw3p/ybSRaH+g+AD3pSoLLu5h7LaSf/LQNShHosp+aJS2dSeLjZJHylPhByM
        KBpltazjmpNmSqNyhfVuf+Z866XW4GqPsI2/OL1rvQY3oeB+R2nJ3ahXrYZILIPYzzjasZ
        WCZQob/SHGaAbiYIEVhs1ldSAfTGhQc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-wkfTeExDMaa2IGv176lDvw-1; Thu, 13 Jul 2023 11:35:02 -0400
X-MC-Unique: wkfTeExDMaa2IGv176lDvw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-55bf2bf1cdeso701084a12.3
        for <fstests@vger.kernel.org>; Thu, 13 Jul 2023 08:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689262502; x=1691854502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWX/2RdmzMlzeOXQbV2SXlI4tVXd/cgTFBBGmD8VxPY=;
        b=ggdZ6S0exwuWnNo7Xj+/h9xo7Rgn9TJaiu8vSqFSzlnkQwUzCQ6RdEeYmx2MsUAhd3
         SgG7BKLDFKdrZ29RxOrr5zYwp+DgT8xbOEYPu+drprsI6ZRGxi4/dMe4yKVzTLiObjWj
         hEUU8vhh+Vlh0/fBfRwH7ipaaBapJWKnRXqKubhJwCKQ6S6bffZEHAb3H2fOtvX63PXz
         5BYP+H3rdV0Oxrtp2Kcuis3FdXelZeB6pxhgl1mvT6RgDwsYfqNPiq3UGqyXrLAaXpRn
         iNX6f4D6+AXIazuf+ZuEPQvCHuvHFCYYvHF1JFyxc+BFsTRfK8B8M8ZQ3WSgUaZw9Axo
         Wf/A==
X-Gm-Message-State: ABy/qLYgks/H3tff9t1O8Eeiyh4yKmOP/L5T8njMukV7cEcjkPjlmAht
        FXTKFgjWmx9qFeg6jjMUwHwi3OOShZ6LfYznYnb1JT/hWROtqYQVODLGuSvNNY5SZ5RU76I4Do2
        KDsRy7Ns1TLUxND2l9w==
X-Received: by 2002:a17:902:bd83:b0:1b8:ae12:5610 with SMTP id q3-20020a170902bd8300b001b8ae125610mr1939224pls.7.1689262501961;
        Thu, 13 Jul 2023 08:35:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFouuLPNOhM+tHoNY8x7Sb6yJTPZepnALm5nFskVxVhslrQlwybjZ2K7enE1PmSQ0J9alXZNg==
X-Received: by 2002:a17:902:bd83:b0:1b8:ae12:5610 with SMTP id q3-20020a170902bd8300b001b8ae125610mr1939211pls.7.1689262501684;
        Thu, 13 Jul 2023 08:35:01 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902748500b001a95f632340sm6107157pll.46.2023.07.13.08.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:35:01 -0700 (PDT)
Date:   Thu, 13 Jul 2023 23:34:57 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     alexl@redhat.com
Cc:     fstests@vger.kernel.org, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com
Subject: Re: [PATCH v2 0/4] overlayfs: Test data-only upperdirs and fs-verity
Message-ID: <20230713153457.5723wtjidhvlxfyz@zlang-mailbox>
References: <cover.1688979643.git.alexl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1688979643.git.alexl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 10, 2023 at 11:07:09AM +0200, alexl@redhat.com wrote:
> From: Alexander Larsson <alexl@redhat.com>
> 
> This adds support for testing the new data-only upperdir feature which is
> currently in master and will be in 6.5-rc1. It also adds tests for the
> fs-verity validation feature which is queued in overlayfs-next for 6.6.
> 
> All new tests check for the required features before running, so
> having it in early will be nice for testers of linux-next.
> 
> Changes since v1:
>  * Consistently use $fstyp and $scratch_mnt in _require_scratch_verity
>    (Pointed out by Eric Biggers)
>  * Added Signed-off-by to patches from Amir
> 
> Alexander Larsson (1):
>   overlay: Add test coverage for fs-verity support
> 
> Amir Goldstein (3):
>   overlay: add helper for mounting rdonly overlay
>   overlay/060: add test cases of follow to lowerdata
>   overlay: Add test for follow of lowerdata in data-only layers

This patchset looks good to me, and I didn't regression from it. So if there's
not more review points from overlayfs side, I'll merge this patchset in next
fstests release.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> 
>  common/overlay        |  35 ++++-
>  common/verity         |  16 ++-
>  tests/overlay/060     |  43 +++++-
>  tests/overlay/060.out |  18 +++
>  tests/overlay/079     | 325 +++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/079.out |  42 ++++++
>  tests/overlay/080     | 326 ++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/080.out |   7 +
>  8 files changed, 800 insertions(+), 12 deletions(-)
>  create mode 100755 tests/overlay/079
>  create mode 100644 tests/overlay/079.out
>  create mode 100755 tests/overlay/080
>  create mode 100644 tests/overlay/080.out
> 
> -- 
> 2.40.1
> 

