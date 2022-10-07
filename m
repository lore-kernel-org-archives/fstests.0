Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C40C433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Oct 2022 05:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJGFC5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Oct 2022 01:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJGFC4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Oct 2022 01:02:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98256BB070
        for <fstests@vger.kernel.org>; Thu,  6 Oct 2022 22:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665118974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2OSdMSmKz2+8FohR2BeL0lBuEHTByXbSkcCGSK/zZns=;
        b=hddA0o83TqUcGYYuty3OvQYD2UGGm3NjWaNDbU2L7pqSSEV12RmR3BVVq75wH1X9vNsFnt
        bCpi/uWoBS9cTgrvhuTR2WeD22WJgQOa6xRe+fkkPdDzqhq/GyyY3HT0LhgCsOPKf4ZY2C
        L0ONZTAzk9gwSsWJqeWzwBs5DbzA778=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-pjg4tGSSNd2aVRJSiQqkcg-1; Fri, 07 Oct 2022 01:02:53 -0400
X-MC-Unique: pjg4tGSSNd2aVRJSiQqkcg-1
Received: by mail-qk1-f198.google.com with SMTP id de16-20020a05620a371000b006ceb92bc740so3036570qkb.15
        for <fstests@vger.kernel.org>; Thu, 06 Oct 2022 22:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2OSdMSmKz2+8FohR2BeL0lBuEHTByXbSkcCGSK/zZns=;
        b=GXqzkanzm9Dku6rVNby58KvdUhtPI53Lrd86fBUAEaDOK4EFSkLHAQqByOqJtIzY6A
         ac8TflMpj86GQhKo2kk0AIRSE8ZYNXh5uW/7/IOH85Yv8uTZj6aXvx6jD+pdpGsundPp
         7aCUC3exSzLnWaaEqbRYTkbXaiKtS7nVi89mr4H74CI4dTZ6SbGtTGC1+VSMdaip2UUf
         IA5w7kOIZ8EmMb8s5Es6ERY5EMbZT7jBHZaAEjOD/hkTiDFmWoKRsk0k5txZEEXSrAe/
         Ah2/FG8+0XwQhq3w20/6GWDNxytQBEfK9lAeKtvGktllxJy0Oj7s4FVEQJi/qlUQ20cU
         JuzQ==
X-Gm-Message-State: ACrzQf13bCYSpvaNR9w79ywLJVoqrJ2DKvHXf1ZtWqt8NbvH5Ts6zDiv
        /uKzzKIOGWigA55qfw8BPe5Xkmyj2IvMMqaKoPhFil6pwdNgYgNY+j8+JIVkS+eU0ltIIwqxbUi
        f3T4YxdhsYMOYZhLQQg==
X-Received: by 2002:a05:620a:3:b0:6ce:1a87:dc6f with SMTP id j3-20020a05620a000300b006ce1a87dc6fmr2611491qki.73.1665118972977;
        Thu, 06 Oct 2022 22:02:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7D8F7Eb08yusEtIIJQQoTnduUY+fn2NcCN2qC9KkNJa47taIe4SdiVCFeJWksFUqm2vEAMHg==
X-Received: by 2002:a05:620a:3:b0:6ce:1a87:dc6f with SMTP id j3-20020a05620a000300b006ce1a87dc6fmr2611483qki.73.1665118972766;
        Thu, 06 Oct 2022 22:02:52 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u28-20020a05620a085c00b006ceafb1aa92sm1048053qku.96.2022.10.06.22.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 22:02:52 -0700 (PDT)
Date:   Fri, 7 Oct 2022 13:02:48 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/2] btrfs: test active zone tracking
Message-ID: <20221007050248.kagbkgfbqrkmv54g@zlang-mailbox>
References: <cover.1664948475.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1664948475.git.naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 05, 2022 at 02:46:42PM +0900, Naohiro Aota wrote:
> This series adds a test for checking if an active zone tracking feature of
> btrfs's zoned mode. The first patch introduces _zone_capacity() helper to
> get the zone capacity of a specified zone. It rewrites btrfs/237 with the
> helper and use the helper in a newly added test btrfs/292.

I have no more review points on this version now, will push it in next fstests
release, if no objection from others. Thanks!

> 
> Changes:
> - v3:
>   - Fix import of common/zoned in btrfs/237. 
>   - Use _fixed_by_kernel_commit.
>   - Cleanup background dd processes.
>   - Rework error handling.
>   - Fix indent.
> - v2:
>   - Rename to common/zoned.
>   - Move _filter_blkzone_report() as well to common/zoned.
>   - Drop _require_fio as it was already unnecessary.
> 
> Naohiro Aota (2):
>   common: introduce zone_capacity() to return a zone capacity
>   btrfs: test active zone tracking
> 
>  common/filter       |  13 ----
>  common/zoned        |  39 ++++++++++++
>  tests/btrfs/237     |   8 +--
>  tests/btrfs/292     | 143 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/292.out |   2 +
>  5 files changed, 186 insertions(+), 19 deletions(-)
>  create mode 100644 common/zoned
>  create mode 100755 tests/btrfs/292
>  create mode 100644 tests/btrfs/292.out
> 
> -- 
> 2.38.0
> 

