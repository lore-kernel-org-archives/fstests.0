Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B64DC0015E
	for <linux-fstests@archiver.kernel.org>; Tue, 25 Jul 2023 07:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjGYHcJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 Jul 2023 03:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjGYHbe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Jul 2023 03:31:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0386B120
        for <fstests@vger.kernel.org>; Tue, 25 Jul 2023 00:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690270098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N41wB1XUeGtXhkko+QpaUFn4g34BQYX+NQCNZ8tnT98=;
        b=ZAXt2CM7aGzUa6QW/lutcSRXichDij4Qv0EYbmy61TRWIYyBtwga+3jt9hazB8H1ZfG17M
        a6n+INyUc7OycIbokyrRbZhes/JTTv9LiEJ8MpXx6//U8edq898lLMBKIW5xBvpA8Y54CZ
        2CLNJ4BZw21cUiwaEKp322m8mtp0z6c=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-7rvGKWzjMX-mmhbv4I3BlQ-1; Tue, 25 Jul 2023 03:28:16 -0400
X-MC-Unique: 7rvGKWzjMX-mmhbv4I3BlQ-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-565f0c7c243so8827511eaf.2
        for <fstests@vger.kernel.org>; Tue, 25 Jul 2023 00:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690270095; x=1690874895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N41wB1XUeGtXhkko+QpaUFn4g34BQYX+NQCNZ8tnT98=;
        b=HW/NVuEThDyeTKr4+aHVsiA6V9Z+31Ia1hBM8RNVL/ObhrhEBGSo7xfZ9xaQD19n8I
         Cjdvlx01H6bfDFSQ5Vu8f0S2QFlwdiklw9WCqBNrwm3myI9HhawS6hVJhIlL2shpgWJM
         BNeUL74WTx9nac1bonYoiqmX+XWnuLXML8ouhihqW9/EApWNuWlY8Sf0WIyXZDWJ8N4f
         mU3UmYuFzF1diozUY4voBQZ604Vrt63oeRX2Bo2ILPKyBBzscpNx1KUpkXhj4iIklx65
         ajnZvfFJgeh7R76HAIEHIM7dRoqO9RWDxtMlgRIXNizTvGgJQhp61KAEnRsphR0E9PXx
         09TA==
X-Gm-Message-State: ABy/qLZ1N5Tc2PtozpWP+iRPXW9n247rCVQiLGqM+xQ5KyXcE5EXA3LM
        +ngPWt1aBm7/JfSmQOvs0zPGZUSgKXp8azgn/1esrZIwqZ69QUw2a0rrztHyvY3qjmNRGhefm77
        AidABiDYaikMBjlCYYcSTog871wgNwzA=
X-Received: by 2002:a05:6358:2619:b0:135:57d0:d171 with SMTP id l25-20020a056358261900b0013557d0d171mr7618180rwc.15.1690270095567;
        Tue, 25 Jul 2023 00:28:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEhrEM682egXT7yJH2RT+JcSEthOJdjbn/9MfJXL7uhyuYIPOeGrZqP6+gSaMUoV3/bExjZhw==
X-Received: by 2002:a05:6358:2619:b0:135:57d0:d171 with SMTP id l25-20020a056358261900b0013557d0d171mr7618164rwc.15.1690270095159;
        Tue, 25 Jul 2023 00:28:15 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m7-20020aa79007000000b006636c4f57a6sm8950284pfo.27.2023.07.25.00.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 00:28:14 -0700 (PDT)
Date:   Tue, 25 Jul 2023 15:28:11 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org
Subject: Re: add device removal test v3
Message-ID: <20230725072811.oh2xtshz6amowuz2@zlang-mailbox>
References: <20230724152927.33094-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724152927.33094-1-hch@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 24, 2023 at 08:29:25AM -0700, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds two tests for removing a device underneath the
> file system.  This covers the new shutdown handling series I'm
> posting.
> 
> Changes since v2:
>  - don't look for specific logical/physical block sizes on SCRATCH_DEV
>  - use run_check (Zorro Lang)
>  - use SCSI_DEBUG_MNT instead of SCRATCH_DEV (Zorro Lang)

Thanks Christoph! This version looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Changes since v1:
>  - renumbered the tests
>  - add a check that the tests are only run on block based file systems
> 

