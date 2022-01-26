Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC4FC28CF5
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Jan 2022 04:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiAZEVk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 Jan 2022 23:21:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38646 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230293AbiAZEVj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Jan 2022 23:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643170898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WRnm8IHmtjOwzS1bcgFaIBN0wtPQTcqXOeyPOkjdiTw=;
        b=IhJCmpidzSP3GkwwGynZCRv07fPNHfnINLA7J4KcH8MRFToKzFzJOkbh0oOY2Ki3kDspjc
        ChPzh+GDE+eUT/ylNn/qukGIHFvz7wE+NmnTWBblLOcARf8pSy7QuW45oMsIEIFNXJDWln
        LR3DguZR/690giydI3erJQTmkSox1Pc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-uujBSb1nOEySYScK-kY3RA-1; Tue, 25 Jan 2022 23:21:37 -0500
X-MC-Unique: uujBSb1nOEySYScK-kY3RA-1
Received: by mail-pf1-f198.google.com with SMTP id n185-20020a6227c2000000b004cb97301208so433601pfn.19
        for <fstests@vger.kernel.org>; Tue, 25 Jan 2022 20:21:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=WRnm8IHmtjOwzS1bcgFaIBN0wtPQTcqXOeyPOkjdiTw=;
        b=nfwua9WnOGvhSvR5WlCAvrZ7MAUUOf+B8XnHp5bCUHXwNT7IhUpaqa3jlwLsrP1nxI
         VgKhiJ9ZtXaMxHQI5Bcqx6NNlef0Aot/iNMpXih1ic68J00OOb2/HGDYFdHcZn4pk+M3
         bPQJES3soxyxDD8zGzEZ09KSiwca8OEgEB62Zk0+aWYN9ij0pJxgI2J7C/4Q4PbfeSbV
         SWWT7mFpkVbL+TwpfsaogMC9teRVN664LtM9BGBej8JZiTu76aSoK2QMKcOYculwaMuH
         AQcg9bzi1N8zhTYDgKJMC4C6PvDmClm1Q/cEa1pAgKhqwQ19KjfRYntLykQEz3Wsh9xW
         UEEg==
X-Gm-Message-State: AOAM530BWRYRXQALdSpLGOs4hzL0Y/p0orcay/AocWKNlvJnR3Lum4Jh
        d/XcniCy0UUqYA/Q1Xlm5cgWDsK4dMALGLUtLgyGKVNuaghHsV2kFIeSWfDo91uHcBxxYDvZgrR
        FuepnBmyVdXWhGvEAzg==
X-Received: by 2002:a62:7686:0:b0:4c9:f270:1f39 with SMTP id r128-20020a627686000000b004c9f2701f39mr8839749pfc.50.1643170895826;
        Tue, 25 Jan 2022 20:21:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiBgGtbyeClQs7hjtKBkhpkIJ9VjzAO7EjK4OTmIEHRygZev2Zeh+/oJ7YEfxiGTm4HOq6RA==
X-Received: by 2002:a62:7686:0:b0:4c9:f270:1f39 with SMTP id r128-20020a627686000000b004c9f2701f39mr8839731pfc.50.1643170895520;
        Tue, 25 Jan 2022 20:21:35 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e6sm518505pfv.43.2022.01.25.20.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 20:21:34 -0800 (PST)
Date:   Wed, 26 Jan 2022 12:21:31 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Rishabh Dave <ridave@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: adding support for ceph-fuse
Message-ID: <20220126042131.yfpkxts4uo2ubps7@zlang-mailbox>
Mail-Followup-To: Rishabh Dave <ridave@redhat.com>, fstests@vger.kernel.org
References: <CA+jMu4Q5cx5+G7jtrNT3RL8gi6nUB6ZikP1ztFUjTQUh6ojLrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+jMu4Q5cx5+G7jtrNT3RL8gi6nUB6ZikP1ztFUjTQUh6ojLrA@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jan 21, 2022 at 05:26:50PM +0530, Rishabh Dave wrote:
> Hi,
> 
> Currently tests from xfstests-dev can be executed against CephFS
> mounted using the kernel but not mounted using FUSE. This is so
> because right now xfstests-dev doesn't know how to mount CephFS with
> FUSE.
> 
> I've written a patch (attached to this e-mail) that adds the ability
> to xfstests-dev to mount CephFS with FUSE as well. I've tested the
> patch against Ceph's master branch. The patch works fine IMO because
> after applying the patch I could run tests against kernel-mounted as
> well as FUSE-mounted CephFS.
> 
> I am not sure about the review process for xfstests-dev, please let me
> know if the patches need to be uploaded elsewhere. Thanks in advance.

fstests@ review patches similar with linux kernel. git commit your change
in your local xfstests-dev (with proper commit log), then send that patch
through `git send-mail` to fstests@vger.kernel.org (and cc ceph-fs mail
list if you need). Please don't use attachment (as a patch), just keep your
patch (plain text) in mail body directly.

Thanks,
Zorro


> 
> Regards,
> - Rishabh


