Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C3AC43334
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jun 2022 05:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbiFVFVm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Jun 2022 01:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiFVFVl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Jun 2022 01:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 149D236172
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 22:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655875298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PEUZ0EFO26ZVhvTZm+oXSLeoa3Y69coZy1AF1wVEKTg=;
        b=RgpfGKtcGbGm5JlvYkUOn2CXW6ocAGa2woeQPf+1BFa8AW/rA58NaizgA7An8olHLO8oTS
        X4fVH60WdbQjKZg9fMw9/SmxZdEIqGvPgCpe5h+HE3sUyUZSnbGhVg7+tIERif66V5FVQV
        1XL2BMWvnY9UwbMySBctMFnk9Q8Ywj0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-P5z2nEniNwaN-JOudiJvjQ-1; Wed, 22 Jun 2022 01:21:37 -0400
X-MC-Unique: P5z2nEniNwaN-JOudiJvjQ-1
Received: by mail-qk1-f199.google.com with SMTP id i16-20020a05620a249000b006aedb25493cso945191qkn.15
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 22:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PEUZ0EFO26ZVhvTZm+oXSLeoa3Y69coZy1AF1wVEKTg=;
        b=IGeKVfZNswMMCEL++oDDvXsFabcTnXP/jk8v1x30dU0DPiH1Be9Ra9AX3mL2NISg5w
         o7zFQbXS6KFCppLuavjOBZ6lKc/VbSW3GaDNctkRUIuipooA2v9bghJGtSGIV3eY2ZUF
         L+UDhwLOQMaSWpwjUS3GtkeE02eTTyiltrTztcvl2Al5fs/zU8GVp8hFL7Zrj5sFHXbn
         FFJaB7WNdaVHs0b2OmxMYRtgyEAEUSq8wVmoh2efUOAsnSHOIrLiJH+kU33HVSnPiJXs
         XzlTtTF0EuS7S4y2ls9j9z/JFwJQ9sceZTcCFYYZvvqUegT5P4e8+m+rTQc88JuCT9X3
         4TSg==
X-Gm-Message-State: AJIora/hiFbdiW06XX/NslnroeCERAjeIWSRzn9JpBjGlyn3eCSan/hB
        MtQfW8Fk0HzhabXOUWjfJuE7gqM8mXEw218nP3ihu7tIC97FsO0zeJoimXiAniQ9/FtA0KLW+Xo
        PEDstxue4LGn3jZbt4A==
X-Received: by 2002:a05:622a:120e:b0:315:4464:1dd1 with SMTP id y14-20020a05622a120e00b0031544641dd1mr1542776qtx.654.1655875296564;
        Tue, 21 Jun 2022 22:21:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1srDQyfjTi4H6UhD7UUcvwvjGSYzWSX2BLRhhkLs/5ltT8MY3KeNqxzqBa4PHSMZtzTT84b1A==
X-Received: by 2002:a05:622a:120e:b0:315:4464:1dd1 with SMTP id y14-20020a05622a120e00b0031544641dd1mr1542770qtx.654.1655875296285;
        Tue, 21 Jun 2022 22:21:36 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ay31-20020a05620a179f00b006a7137330e2sm14721408qkb.132.2022.06.21.22.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 22:21:35 -0700 (PDT)
Date:   Wed, 22 Jun 2022 13:21:30 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 0/6] check: minor cleanups and xunit report fix
Message-ID: <20220622052130.uajc3amjeeup6ojr@zlang-mailbox>
References: <20220620192934.21694-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620192934.21694-1-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 20, 2022 at 09:29:28PM +0200, David Disseldorp wrote:
> Hi,
> 
> This patchset contains a few cleanups which I came across while working
> on a larger set of changes for test-rerun-on-failure[1] support. One
> minor fix for the tests count in the xunit report is included.

Thanks for this pre-fix patchset, I'd like to ack this change at first, if
no more objections. And give your another patchset [1] a little more reviewing
time. Welcome review points on that [1].

Thanks,
Zorro

[1]
[RFC PATCH 0/2] add option to rerun failed tests

> 
> Diffstat:
>  check         | 148 +++++++++++++++++++++-----------------------------
>  common/report |  14 +++--
>  2 files changed, 71 insertions(+), 91 deletions(-)
> 
> 1. test-rerun-on-failure proposal by Ted Ts'o:
>    https://lwn.net/Articles/897061/
> 
> Cheers, David
> 
> 

